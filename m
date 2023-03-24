Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0CC6C7E09
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Mar 2023 13:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCXM2z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Mar 2023 08:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjCXM2a (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Mar 2023 08:28:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AD81A661
        for <linux-rdma@vger.kernel.org>; Fri, 24 Mar 2023 05:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679660897; x=1711196897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bj2wGLDUkyzJKrD5t65t2ML1HC1u4hulruUloRKcFZo=;
  b=AETAU5eYg+eF2mKHbdPE3tNAtrm9rcDmN1QNWHdkSHOKbbfG9VwFTGIv
   /wAli0Huj5Jgw/6o35/sSxS5HYhQkxR+MB/E/UYHq6IfrG/ghjGkvB24I
   DZLmOarDkFu6r0ACI19tqVEdlz9IVvstCxLpmrLNVmQn/VLiDg2P25mls
   CdN7AvMVDcAX4lxf1My5/svkfhqm8aKdZC7/JUc6YtMEfIXHi+cvi7TFr
   JKGo+fGNbKyC64UVfYqH5WBGJmgIbedF82WyhYbSoScnWiThn0OVxvDw5
   r45k4xNPbkNwXxqQb3avJnrr8sMDR/2fLflyWlYYNZCeF3jOgemuDiG18
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="338486320"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="338486320"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 05:28:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="682685074"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="682685074"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 Mar 2023 05:28:15 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfgWk-000FIq-24;
        Fri, 24 Mar 2023 12:28:14 +0000
Date:   Fri, 24 Mar 2023 20:27:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Bernard Metzler <BMT@zurich.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] RDMA/rxe: Pass a pointer to virt_to_page()
Message-ID: <202303242000.HmTaa6yB-lkp@intel.com>
References: <20230324103252.712107-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324103252.712107-1-linus.walleij@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Linus,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v6.3-rc3 next-20230324]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Linus-Walleij/RDMA-rxe-Pass-a-pointer-to-virt_to_page/20230324-183329
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20230324103252.712107-1-linus.walleij%40linaro.org
patch subject: [PATCH] RDMA/rxe: Pass a pointer to virt_to_page()
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20230324/202303242000.HmTaa6yB-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f162d87e28eb5241d1a0e2085b80bfc70f626536
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Linus-Walleij/RDMA-rxe-Pass-a-pointer-to-virt_to_page/20230324-183329
        git checkout f162d87e28eb5241d1a0e2085b80bfc70f626536
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/infiniband/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303242000.HmTaa6yB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/parisc/include/asm/page.h:181,
                    from include/linux/mm_types_task.h:16,
                    from include/linux/mm_types.h:5,
                    from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:7,
                    from include/linux/xarray.h:15,
                    from include/linux/list_lru.h:14,
                    from include/linux/fs.h:13,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/bio.h:10,
                    from include/linux/libnvdimm.h:14,
                    from drivers/infiniband/sw/rxe/rxe_mr.c:7:
   drivers/infiniband/sw/rxe/rxe_mr.c: In function 'rxe_set_page':
>> drivers/infiniband/sw/rxe/rxe_mr.c:216:42: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     216 |         struct page *page = virt_to_page((void *)(iova & mr->page_mask));
         |                                          ^
   include/asm-generic/memory_model.h:18:46: note: in definition of macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   arch/parisc/include/asm/page.h:179:45: note: in expansion of macro '__pa'
     179 | #define virt_to_page(kaddr)     pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
         |                                             ^~~~
   drivers/infiniband/sw/rxe/rxe_mr.c:216:29: note: in expansion of macro 'virt_to_page'
     216 |         struct page *page = virt_to_page((void *)(iova & mr->page_mask));
         |                             ^~~~~~~~~~~~
   drivers/infiniband/sw/rxe/rxe_mr.c: In function 'rxe_mr_copy_dma':
   drivers/infiniband/sw/rxe/rxe_mr.c:291:37: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     291 |                 page = virt_to_page((void *)(iova & mr->page_mask));
         |                                     ^
   include/asm-generic/memory_model.h:18:46: note: in definition of macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   arch/parisc/include/asm/page.h:179:45: note: in expansion of macro '__pa'
     179 | #define virt_to_page(kaddr)     pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
         |                                             ^~~~
   drivers/infiniband/sw/rxe/rxe_mr.c:291:24: note: in expansion of macro 'virt_to_page'
     291 |                 page = virt_to_page((void *)(iova & mr->page_mask));
         |                        ^~~~~~~~~~~~
   drivers/infiniband/sw/rxe/rxe_mr.c: In function 'rxe_mr_do_atomic_op':
   drivers/infiniband/sw/rxe/rxe_mr.c:491:37: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     491 |                 page = virt_to_page((void *)(iova & PAGE_MASK));
         |                                     ^
   include/asm-generic/memory_model.h:18:46: note: in definition of macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   arch/parisc/include/asm/page.h:179:45: note: in expansion of macro '__pa'
     179 | #define virt_to_page(kaddr)     pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
         |                                             ^~~~
   drivers/infiniband/sw/rxe/rxe_mr.c:491:24: note: in expansion of macro 'virt_to_page'
     491 |                 page = virt_to_page((void *)(iova & PAGE_MASK));
         |                        ^~~~~~~~~~~~


vim +216 drivers/infiniband/sw/rxe/rxe_mr.c

   212	
   213	static int rxe_set_page(struct ib_mr *ibmr, u64 iova)
   214	{
   215		struct rxe_mr *mr = to_rmr(ibmr);
 > 216		struct page *page = virt_to_page((void *)(iova & mr->page_mask));
   217		bool persistent = !!(mr->access & IB_ACCESS_FLUSH_PERSISTENT);
   218		int err;
   219	
   220		if (persistent && !is_pmem_page(page)) {
   221			rxe_dbg_mr(mr, "Page cannot be persistent\n");
   222			return -EINVAL;
   223		}
   224	
   225		if (unlikely(mr->nbuf == mr->num_buf))
   226			return -ENOMEM;
   227	
   228		err = xa_err(xa_store(&mr->page_list, mr->nbuf, page, GFP_KERNEL));
   229		if (err)
   230			return err;
   231	
   232		mr->nbuf++;
   233		return 0;
   234	}
   235	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
