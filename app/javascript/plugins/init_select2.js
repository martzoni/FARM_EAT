import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  $('.select2').select2({ width: '100%'}); // (~ document.querySelectorAll)
};

export { initSelect2 };

// padding: 10px 5px;
//   font: bold 15px;
//   border: 0;
//   background: rgb(255, 255, 255);
//   border-radius: 8px 0px 0px 8px;  