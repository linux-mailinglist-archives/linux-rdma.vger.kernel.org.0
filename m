Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C417588F9
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jul 2023 01:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjGRXQo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jul 2023 19:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjGRXQn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jul 2023 19:16:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4BAA1
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jul 2023 16:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689722199; x=1721258199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NhE1dnhfvt0KEceV7noRwcDHrkQzvl+cihIpKve9wDY=;
  b=kej2FQNrqfy8uGehEh7mA1VZLo1x2JHAW495YctO1cbHoyQ8IoqXPRqv
   MkLzbL5PPdOB15VCU2U2Lit1LsLyBTXXVE9YrnflJlNb9/QesukhOr4GI
   WLQl/nz3IxwPSsIXRPyqOZor6M2vOD/G4G+Z8YbvnM8BcyzPxYQjfBgVk
   tUzeXP6dc4dteZuVFQn7ev9BxbYJ0TLx9eSuSMei5sBHHcchaMzRk7Lol
   8iMVjKk5QJJo+g9eGVQWdWV/2BqCT/bUvhyI/8BcX7VhBZ30sucwrlo11
   PfzIXPwzL+dPrSgJ5tno3j7HWLnncTnFpR9Naq0uSSUCCk4tYQqL2uF0f
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="356280199"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="356280199"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 16:16:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="897714437"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="897714437"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 18 Jul 2023 16:16:36 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qLtvn-0003wZ-21;
        Tue, 18 Jul 2023 23:16:35 +0000
Date:   Wed, 19 Jul 2023 07:16:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>, jgg@ziepe.ca,
        leon@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com, michael.chan@broadcom.com,
        Chandramohan Akula <chandramohan.akula@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next v2 5/7] RDMA/bnxt_re: Update alloc_page uapi for
 pacing
Message-ID: <202307190721.q4H3DjZs-lkp@intel.com>
References: <1689573194-27687-6-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689573194-27687-6-git-send-email-selvin.xavier@broadcom.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Selvin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v6.5-rc2 next-20230718]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Selvin-Xavier/bnxt_en-Share-the-bar0-address-with-the-RoCE-driver/20230718-174723
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/1689573194-27687-6-git-send-email-selvin.xavier%40broadcom.com
patch subject: [PATCH for-next v2 5/7] RDMA/bnxt_re: Update alloc_page uapi for pacing
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230719/202307190721.q4H3DjZs-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230719/202307190721.q4H3DjZs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307190721.q4H3DjZs-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/arm64/include/asm/memory.h:337,
                    from arch/arm64/include/asm/thread_info.h:17,
                    from include/linux/thread_info.h:60,
                    from arch/arm64/include/asm/preempt.h:6,
                    from include/linux/preempt.h:79,
                    from include/linux/percpu.h:6,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from include/linux/interrupt.h:11,
                    from drivers/infiniband/hw/bnxt_re/ib_verbs.c:39:
   drivers/infiniband/hw/bnxt_re/ib_verbs.c: In function 'bnxt_re_mmap':
>> drivers/infiniband/hw/bnxt_re/ib_verbs.c:4164:81: warning: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
    4164 |                 ret = vm_insert_page(vma, vma->vm_start, virt_to_page(bnxt_entry->mem_offset));
         |                                                                       ~~~~~~~~~~^~~~~~~~~~~~
         |                                                                                 |
         |                                                                                 u64 {aka long long unsigned int}
   include/asm-generic/memory_model.h:37:45: note: in definition of macro '__pfn_to_page'
      37 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
         |                                             ^~~
   drivers/infiniband/hw/bnxt_re/ib_verbs.c:4164:58: note: in expansion of macro 'virt_to_page'
    4164 |                 ret = vm_insert_page(vma, vma->vm_start, virt_to_page(bnxt_entry->mem_offset));
         |                                                          ^~~~~~~~~~~~
   arch/arm64/include/asm/memory.h:339:53: note: expected 'const void *' but argument is of type 'u64' {aka 'long long unsigned int'}
     339 | static inline unsigned long virt_to_pfn(const void *kaddr)
         |                                         ~~~~~~~~~~~~^~~~~


vim +/virt_to_pfn +4164 drivers/infiniband/hw/bnxt_re/ib_verbs.c

  4119	
  4120	/* Helper function to mmap the virtual memory from user app */
  4121	int bnxt_re_mmap(struct ib_ucontext *ib_uctx, struct vm_area_struct *vma)
  4122	{
  4123		struct bnxt_re_ucontext *uctx = container_of(ib_uctx,
  4124							   struct bnxt_re_ucontext,
  4125							   ib_uctx);
  4126		struct bnxt_re_user_mmap_entry *bnxt_entry;
  4127		struct rdma_user_mmap_entry *rdma_entry;
  4128		int ret = 0;
  4129		u64 pfn;
  4130	
  4131		rdma_entry = rdma_user_mmap_entry_get(&uctx->ib_uctx, vma);
  4132		if (!rdma_entry)
  4133			return -EINVAL;
  4134	
  4135		bnxt_entry = container_of(rdma_entry, struct bnxt_re_user_mmap_entry,
  4136					  rdma_entry);
  4137	
  4138		switch (bnxt_entry->mmap_flag) {
  4139		case BNXT_RE_MMAP_WC_DB:
  4140			pfn = bnxt_entry->mem_offset >> PAGE_SHIFT;
  4141			ret = rdma_user_mmap_io(ib_uctx, vma, pfn, PAGE_SIZE,
  4142						pgprot_writecombine(vma->vm_page_prot),
  4143						rdma_entry);
  4144			break;
  4145		case BNXT_RE_MMAP_UC_DB:
  4146			pfn = bnxt_entry->mem_offset >> PAGE_SHIFT;
  4147			ret = rdma_user_mmap_io(ib_uctx, vma, pfn, PAGE_SIZE,
  4148						pgprot_noncached(vma->vm_page_prot),
  4149					rdma_entry);
  4150			break;
  4151		case BNXT_RE_MMAP_SH_PAGE:
  4152			ret = vm_insert_page(vma, vma->vm_start, virt_to_page(uctx->shpg));
  4153			break;
  4154		case BNXT_RE_MMAP_DBR_BAR:
  4155			pfn = bnxt_entry->mem_offset >> PAGE_SHIFT;
  4156			ret = rdma_user_mmap_io(ib_uctx, vma, pfn, PAGE_SIZE,
  4157						pgprot_noncached(vma->vm_page_prot),
  4158						rdma_entry);
  4159			break;
  4160		case BNXT_RE_MMAP_DBR_PAGE:
  4161			/* Driver doesn't expect write access for user space */
  4162			if (vma->vm_flags & VM_WRITE)
  4163				return -EFAULT;
> 4164			ret = vm_insert_page(vma, vma->vm_start, virt_to_page(bnxt_entry->mem_offset));
  4165			break;
  4166		default:
  4167			ret = -EINVAL;
  4168			break;
  4169		}
  4170	
  4171		rdma_user_mmap_entry_put(rdma_entry);
  4172		return ret;
  4173	}
  4174	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
