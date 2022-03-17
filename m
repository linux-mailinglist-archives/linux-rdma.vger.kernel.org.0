Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9156B4DBD6A
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Mar 2022 04:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241209AbiCQDRG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Mar 2022 23:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238141AbiCQDRG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Mar 2022 23:17:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776AD20F72
        for <linux-rdma@vger.kernel.org>; Wed, 16 Mar 2022 20:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647486950; x=1679022950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yw3uImH28dhH2YBE7o31dyG9yryxukmuDpP9KhjfRWk=;
  b=SFZrJD6/o+PFaIunlKvXRTAfMfJOhfohDyajIMyEmR9JCGT33RZiKy2s
   rLczG4nhoe/8ybH4gBZ1CPnRlZ6KrmBedftDE3CE+f/CjJE/iqd8bz1Xu
   XrnjNYFUER9IpGs4GR0bMxY8lw99sfQxBeB7DscFsxjPX1QP/dVe4lma4
   FWV78+RTszV2F85eTTvfD4j8tv7molxL2W+9aI52ldNteL+QcT3UQNAsf
   oX1U+FyqPTU/RpQX7+yb3jrR6f4sJic908DLVvYs/YkhjIW4F3JIqYVFH
   rV8aYXW/2qCdqydoOZ24G91rkjObk1Ej8rWQF8nYnvENvHvCyKoL1lH/o
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="255600429"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="255600429"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 20:15:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="541199083"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Mar 2022 20:15:47 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUgc6-000DEk-QL; Thu, 17 Mar 2022 03:15:46 +0000
Date:   Thu, 17 Mar 2022 11:14:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>, jgg@ziepe.ca,
        dledford@redhat.com
Cc:     kbuild-all@lists.01.org, leon@kernel.org,
        linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com,
        chengyou@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
Subject: Re: [PATCH for-next v4 12/12] RDMA/erdma: Add driver to kernel build
 environment
Message-ID: <202203171051.nVmoVnU3-lkp@intel.com>
References: <20220314064739.81647-13-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314064739.81647-13-chengyou@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Cheng,

I love your patch! Yet something to improve:

[auto build test ERROR on rdma/for-next]
[also build test ERROR on linus/master v5.17-rc8 next-20220316]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Cheng-Xu/Elastic-RDMA-Adapter-ERDMA-driver/20220314-144952
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20220317/202203171051.nVmoVnU3-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/ad7293bc27eaf3a5e28fffcc325fb9814e6a170c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Cheng-Xu/Elastic-RDMA-Adapter-ERDMA-driver/20220314-144952
        git checkout ad7293bc27eaf3a5e28fffcc325fb9814e6a170c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/infiniband/hw/erdma/erdma_main.c: In function 'erdma_probe_dev':
>> drivers/infiniband/hw/erdma/erdma_main.c:266:34: error: 'struct device' has no member named 'numa_node'
     266 |  dev->attrs.numa_node = pdev->dev.numa_node;
         |                                  ^


vim +266 drivers/infiniband/hw/erdma/erdma_main.c

766cdafe9cd7d4 Cheng Xu 2022-03-14  241  
766cdafe9cd7d4 Cheng Xu 2022-03-14  242  static int erdma_probe_dev(struct pci_dev *pdev)
766cdafe9cd7d4 Cheng Xu 2022-03-14  243  {
766cdafe9cd7d4 Cheng Xu 2022-03-14  244  	int err;
766cdafe9cd7d4 Cheng Xu 2022-03-14  245  	struct erdma_dev *dev;
766cdafe9cd7d4 Cheng Xu 2022-03-14  246  	u32 version;
766cdafe9cd7d4 Cheng Xu 2022-03-14  247  	int bars;
766cdafe9cd7d4 Cheng Xu 2022-03-14  248  
766cdafe9cd7d4 Cheng Xu 2022-03-14  249  	err = pci_enable_device(pdev);
766cdafe9cd7d4 Cheng Xu 2022-03-14  250  	if (err) {
766cdafe9cd7d4 Cheng Xu 2022-03-14  251  		dev_err(&pdev->dev, "pci_enable_device failed(%d)\n", err);
766cdafe9cd7d4 Cheng Xu 2022-03-14  252  		return err;
766cdafe9cd7d4 Cheng Xu 2022-03-14  253  	}
766cdafe9cd7d4 Cheng Xu 2022-03-14  254  
766cdafe9cd7d4 Cheng Xu 2022-03-14  255  	pci_set_master(pdev);
766cdafe9cd7d4 Cheng Xu 2022-03-14  256  
766cdafe9cd7d4 Cheng Xu 2022-03-14  257  	dev = ib_alloc_device(erdma_dev, ibdev);
766cdafe9cd7d4 Cheng Xu 2022-03-14  258  	if (!dev) {
766cdafe9cd7d4 Cheng Xu 2022-03-14  259  		dev_err(&pdev->dev, "ib_alloc_device failed\n");
766cdafe9cd7d4 Cheng Xu 2022-03-14  260  		err = -ENOMEM;
766cdafe9cd7d4 Cheng Xu 2022-03-14  261  		goto err_disable_device;
766cdafe9cd7d4 Cheng Xu 2022-03-14  262  	}
766cdafe9cd7d4 Cheng Xu 2022-03-14  263  
766cdafe9cd7d4 Cheng Xu 2022-03-14  264  	pci_set_drvdata(pdev, dev);
766cdafe9cd7d4 Cheng Xu 2022-03-14  265  	dev->pdev = pdev;
766cdafe9cd7d4 Cheng Xu 2022-03-14 @266  	dev->attrs.numa_node = pdev->dev.numa_node;
766cdafe9cd7d4 Cheng Xu 2022-03-14  267  
766cdafe9cd7d4 Cheng Xu 2022-03-14  268  	bars = pci_select_bars(pdev, IORESOURCE_MEM);
766cdafe9cd7d4 Cheng Xu 2022-03-14  269  	err = pci_request_selected_regions(pdev, bars, DRV_MODULE_NAME);
766cdafe9cd7d4 Cheng Xu 2022-03-14  270  	if (bars != ERDMA_BAR_MASK || err) {
766cdafe9cd7d4 Cheng Xu 2022-03-14  271  		err = err == 0 ? -EINVAL : err;
766cdafe9cd7d4 Cheng Xu 2022-03-14  272  		goto err_ib_device_release;
766cdafe9cd7d4 Cheng Xu 2022-03-14  273  	}
766cdafe9cd7d4 Cheng Xu 2022-03-14  274  
766cdafe9cd7d4 Cheng Xu 2022-03-14  275  	dev->func_bar_addr = pci_resource_start(pdev, ERDMA_FUNC_BAR);
766cdafe9cd7d4 Cheng Xu 2022-03-14  276  	dev->func_bar_len = pci_resource_len(pdev, ERDMA_FUNC_BAR);
766cdafe9cd7d4 Cheng Xu 2022-03-14  277  
766cdafe9cd7d4 Cheng Xu 2022-03-14  278  	dev->func_bar = devm_ioremap(&pdev->dev,
766cdafe9cd7d4 Cheng Xu 2022-03-14  279  				     dev->func_bar_addr,
766cdafe9cd7d4 Cheng Xu 2022-03-14  280  				     dev->func_bar_len);
766cdafe9cd7d4 Cheng Xu 2022-03-14  281  	if (!dev->func_bar) {
766cdafe9cd7d4 Cheng Xu 2022-03-14  282  		dev_err(&pdev->dev, "devm_ioremap failed.\n");
766cdafe9cd7d4 Cheng Xu 2022-03-14  283  		err = -EFAULT;
766cdafe9cd7d4 Cheng Xu 2022-03-14  284  		goto err_release_bars;
766cdafe9cd7d4 Cheng Xu 2022-03-14  285  	}
766cdafe9cd7d4 Cheng Xu 2022-03-14  286  
766cdafe9cd7d4 Cheng Xu 2022-03-14  287  	version = erdma_reg_read32(dev, ERDMA_REGS_VERSION_REG);
766cdafe9cd7d4 Cheng Xu 2022-03-14  288  	if (version == 0) {
766cdafe9cd7d4 Cheng Xu 2022-03-14  289  		/* we knows that it is a non-functional function. */
766cdafe9cd7d4 Cheng Xu 2022-03-14  290  		err = -ENODEV;
766cdafe9cd7d4 Cheng Xu 2022-03-14  291  		goto err_iounmap_func_bar;
766cdafe9cd7d4 Cheng Xu 2022-03-14  292  	}
766cdafe9cd7d4 Cheng Xu 2022-03-14  293  
766cdafe9cd7d4 Cheng Xu 2022-03-14  294  	err = erdma_device_init(dev, pdev);
766cdafe9cd7d4 Cheng Xu 2022-03-14  295  	if (err)
766cdafe9cd7d4 Cheng Xu 2022-03-14  296  		goto err_iounmap_func_bar;
766cdafe9cd7d4 Cheng Xu 2022-03-14  297  
766cdafe9cd7d4 Cheng Xu 2022-03-14  298  	err = erdma_request_vectors(dev);
766cdafe9cd7d4 Cheng Xu 2022-03-14  299  	if (err)
766cdafe9cd7d4 Cheng Xu 2022-03-14  300  		goto err_iounmap_func_bar;
766cdafe9cd7d4 Cheng Xu 2022-03-14  301  
766cdafe9cd7d4 Cheng Xu 2022-03-14  302  	err = erdma_comm_irq_init(dev);
766cdafe9cd7d4 Cheng Xu 2022-03-14  303  	if (err)
766cdafe9cd7d4 Cheng Xu 2022-03-14  304  		goto err_free_vectors;
766cdafe9cd7d4 Cheng Xu 2022-03-14  305  
766cdafe9cd7d4 Cheng Xu 2022-03-14  306  	err = erdma_aeq_init(dev);
766cdafe9cd7d4 Cheng Xu 2022-03-14  307  	if (err)
766cdafe9cd7d4 Cheng Xu 2022-03-14  308  		goto err_uninit_comm_irq;
766cdafe9cd7d4 Cheng Xu 2022-03-14  309  
766cdafe9cd7d4 Cheng Xu 2022-03-14  310  	err = erdma_cmdq_init(dev);
766cdafe9cd7d4 Cheng Xu 2022-03-14  311  	if (err)
766cdafe9cd7d4 Cheng Xu 2022-03-14  312  		goto err_uninit_aeq;
766cdafe9cd7d4 Cheng Xu 2022-03-14  313  
766cdafe9cd7d4 Cheng Xu 2022-03-14  314  	err = erdma_ceqs_init(dev);
766cdafe9cd7d4 Cheng Xu 2022-03-14  315  	if (err)
766cdafe9cd7d4 Cheng Xu 2022-03-14  316  		goto err_uninit_cmdq;
766cdafe9cd7d4 Cheng Xu 2022-03-14  317  
766cdafe9cd7d4 Cheng Xu 2022-03-14  318  	erdma_finish_cmdq_init(dev);
766cdafe9cd7d4 Cheng Xu 2022-03-14  319  
766cdafe9cd7d4 Cheng Xu 2022-03-14  320  	return 0;
766cdafe9cd7d4 Cheng Xu 2022-03-14  321  
766cdafe9cd7d4 Cheng Xu 2022-03-14  322  err_uninit_cmdq:
766cdafe9cd7d4 Cheng Xu 2022-03-14  323  	erdma_device_uninit(dev);
766cdafe9cd7d4 Cheng Xu 2022-03-14  324  	erdma_cmdq_destroy(dev);
766cdafe9cd7d4 Cheng Xu 2022-03-14  325  
766cdafe9cd7d4 Cheng Xu 2022-03-14  326  err_uninit_aeq:
766cdafe9cd7d4 Cheng Xu 2022-03-14  327  	erdma_aeq_destroy(dev);
766cdafe9cd7d4 Cheng Xu 2022-03-14  328  
766cdafe9cd7d4 Cheng Xu 2022-03-14  329  err_uninit_comm_irq:
766cdafe9cd7d4 Cheng Xu 2022-03-14  330  	erdma_comm_irq_uninit(dev);
766cdafe9cd7d4 Cheng Xu 2022-03-14  331  
766cdafe9cd7d4 Cheng Xu 2022-03-14  332  err_free_vectors:
766cdafe9cd7d4 Cheng Xu 2022-03-14  333  	pci_free_irq_vectors(dev->pdev);
766cdafe9cd7d4 Cheng Xu 2022-03-14  334  
766cdafe9cd7d4 Cheng Xu 2022-03-14  335  err_iounmap_func_bar:
766cdafe9cd7d4 Cheng Xu 2022-03-14  336  	devm_iounmap(&pdev->dev, dev->func_bar);
766cdafe9cd7d4 Cheng Xu 2022-03-14  337  
766cdafe9cd7d4 Cheng Xu 2022-03-14  338  err_release_bars:
766cdafe9cd7d4 Cheng Xu 2022-03-14  339  	pci_release_selected_regions(pdev, bars);
766cdafe9cd7d4 Cheng Xu 2022-03-14  340  
766cdafe9cd7d4 Cheng Xu 2022-03-14  341  err_ib_device_release:
766cdafe9cd7d4 Cheng Xu 2022-03-14  342  	ib_dealloc_device(&dev->ibdev);
766cdafe9cd7d4 Cheng Xu 2022-03-14  343  
766cdafe9cd7d4 Cheng Xu 2022-03-14  344  err_disable_device:
766cdafe9cd7d4 Cheng Xu 2022-03-14  345  	pci_disable_device(pdev);
766cdafe9cd7d4 Cheng Xu 2022-03-14  346  
766cdafe9cd7d4 Cheng Xu 2022-03-14  347  	return err;
766cdafe9cd7d4 Cheng Xu 2022-03-14  348  }
766cdafe9cd7d4 Cheng Xu 2022-03-14  349  

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
