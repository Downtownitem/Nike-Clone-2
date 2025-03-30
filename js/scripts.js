const emailInput = document.getElementById('email');
const emailError = document.getElementById('email-error');


const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

emailInput.addEventListener('input', () => {
  const value = emailInput.value.trim();

  if (value === '') {
    emailError.textContent = 'Required';
    emailError.style.display = 'block';
    emailInput.classList.add('error-border');
    return;
  }

  if (!emailRegex.test(value)) {
    emailError.textContent = 'Invalid email address';
    emailError.style.display = 'block';
    emailInput.classList.add('error-border');
    return;
  }

  emailError.style.display = 'none';
  emailInput.classList.remove('error-border');
});
