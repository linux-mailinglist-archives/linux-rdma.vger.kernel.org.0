Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C339147CA9A
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Dec 2021 01:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbhLVA7Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Dec 2021 19:59:25 -0500
Received: from mga02.intel.com ([134.134.136.20]:37680 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230433AbhLVA7Z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Dec 2021 19:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640134765; x=1671670765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RbZxEyJvTv1Tc9Pd2Rax2gMuryNfSS90Z5uv4bUn5sM=;
  b=efphi2rf5VaxvTOYfQPMv+BnjKXY0HgQAX8qCBw3POoixyDsnPmsb5E1
   frwgroLOUh0Mm/AXINrpMkOdFlLic9kkCTFHpHQexd6/admqOaAAFs/+2
   mlbhKYc7SbUgntqngQrJtYqggi3S3wC2RuHokllY9LCe/SKcmDpPIBqYG
   gWseXAJLSrwO2ngqWBvHECONBwqtht/7zFBLlQZ1LuiIIFCRN2tw+jOjG
   r175vIx6KMCf2LJ+5YkV4FfKeJTy/v8SiPwRpq6G9atAoSQEMsFjEb4Tn
   HENv+jhICEHrFKXi3FU182XhltFAtI0hUmDOLUuR1i5mWCivfmdP6HFMy
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="227814809"
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="227814809"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 16:59:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="466494372"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 Dec 2021 16:59:22 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzpyT-0009jZ-Qs; Wed, 22 Dec 2021 00:59:21 +0000
Date:   Wed, 22 Dec 2021 08:58:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>, jgg@ziepe.ca,
        dledford@redhat.com
Cc:     kbuild-all@lists.01.org, leon@kernel.org,
        linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com,
        chengyou@linux.alibaba.com, tonylu@linux.alibaba.com
Subject: Re: [PATCH rdma-next 11/11] RDMA/erdma: Add driver to kernel build
 environment
Message-ID: <202112220838.tXmQUWZb-lkp@intel.com>
References: <20211221024858.25938-12-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221024858.25938-12-chengyou@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Cheng,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v5.16-rc6 next-20211221]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Cheng-Xu/Elastic-RDMA-Adapter-ERDMA-driver/20211221-105044
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20211222/202112220838.tXmQUWZb-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/3b0243fb79f0f12a5b5c020c6f26c82de2c3c57e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Cheng-Xu/Elastic-RDMA-Adapter-ERDMA-driver/20211221-105044
        git checkout 3b0243fb79f0f12a5b5c020c6f26c82de2c3c57e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/infiniband/hw/erdma/erdma_cm.c: In function 'erdma_cep_set_inuse':
>> drivers/infiniband/hw/erdma/erdma_cm.c:173:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     173 |         int ret;
         |             ^~~
   drivers/infiniband/hw/erdma/erdma_cm.c: In function 'erdma_cm_llp_state_change':
>> drivers/infiniband/hw/erdma/erdma_cm.c:1077:24: warning: variable 's' set but not used [-Wunused-but-set-variable]
    1077 |         struct socket *s;
         |                        ^
   drivers/infiniband/hw/erdma/erdma_cm.c: In function 'erdma_create_listen':
>> drivers/infiniband/hw/erdma/erdma_cm.c:1456:28: warning: variable 'r_ip' set but not used [-Wunused-but-set-variable]
    1456 |                 u8 *l_ip, *r_ip;
         |                            ^~~~
>> drivers/infiniband/hw/erdma/erdma_cm.c:1456:21: warning: variable 'l_ip' set but not used [-Wunused-but-set-variable]
    1456 |                 u8 *l_ip, *r_ip;
         |                     ^~~~
--
   drivers/infiniband/hw/erdma/erdma_main.c: In function 'erdma_probe_dev':
>> drivers/infiniband/hw/erdma/erdma_main.c:294:27: warning: variable 'ibdev' set but not used [-Wunused-but-set-variable]
     294 |         struct ib_device *ibdev;
         |                           ^~~~~
   drivers/infiniband/hw/erdma/erdma_main.c: At top level:
>> drivers/infiniband/hw/erdma/erdma_main.c:464:5: warning: no previous prototype for 'erdma_res_cb_init' [-Wmissing-prototypes]
     464 | int erdma_res_cb_init(struct erdma_dev *dev)
         |     ^~~~~~~~~~~~~~~~~
>> drivers/infiniband/hw/erdma/erdma_main.c:481:6: warning: no previous prototype for 'erdma_res_cb_free' [-Wmissing-prototypes]
     481 | void erdma_res_cb_free(struct erdma_dev *dev)
         |      ^~~~~~~~~~~~~~~~~
--
>> drivers/infiniband/hw/erdma/erdma_eq.c:169:6: warning: no previous prototype for 'erdma_intr_ceq_task' [-Wmissing-prototypes]
     169 | void erdma_intr_ceq_task(unsigned long data)
         |      ^~~~~~~~~~~~~~~~~~~


vim +/ret +173 drivers/infiniband/hw/erdma/erdma_cm.c

1d17ac4bdb13af Cheng Xu 2021-12-21  169  
1d17ac4bdb13af Cheng Xu 2021-12-21  170  static void erdma_cep_set_inuse(struct erdma_cep *cep)
1d17ac4bdb13af Cheng Xu 2021-12-21  171  {
1d17ac4bdb13af Cheng Xu 2021-12-21  172  	unsigned long flags;
1d17ac4bdb13af Cheng Xu 2021-12-21 @173  	int ret;
1d17ac4bdb13af Cheng Xu 2021-12-21  174  retry:
1d17ac4bdb13af Cheng Xu 2021-12-21  175  	spin_lock_irqsave(&cep->lock, flags);
1d17ac4bdb13af Cheng Xu 2021-12-21  176  
1d17ac4bdb13af Cheng Xu 2021-12-21  177  	if (cep->in_use) {
1d17ac4bdb13af Cheng Xu 2021-12-21  178  		spin_unlock_irqrestore(&cep->lock, flags);
1d17ac4bdb13af Cheng Xu 2021-12-21  179  		ret = wait_event_interruptible(cep->waitq, !cep->in_use);
1d17ac4bdb13af Cheng Xu 2021-12-21  180  		if (signal_pending(current))
1d17ac4bdb13af Cheng Xu 2021-12-21  181  			flush_signals(current);
1d17ac4bdb13af Cheng Xu 2021-12-21  182  		goto retry;
1d17ac4bdb13af Cheng Xu 2021-12-21  183  	} else {
1d17ac4bdb13af Cheng Xu 2021-12-21  184  		cep->in_use = 1;
1d17ac4bdb13af Cheng Xu 2021-12-21  185  		spin_unlock_irqrestore(&cep->lock, flags);
1d17ac4bdb13af Cheng Xu 2021-12-21  186  	}
1d17ac4bdb13af Cheng Xu 2021-12-21  187  }
1d17ac4bdb13af Cheng Xu 2021-12-21  188  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
