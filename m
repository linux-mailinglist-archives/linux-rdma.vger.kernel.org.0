Return-Path: <linux-rdma+bounces-411-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E82811885
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Dec 2023 17:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BDD2820B2
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Dec 2023 16:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADF02EB15;
	Wed, 13 Dec 2023 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jFS8mcFL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A739BD
	for <linux-rdma@vger.kernel.org>; Wed, 13 Dec 2023 08:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702483238; x=1734019238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8ud5wlnwP7B8tk2ZPaICZRGUS4DVkiINd/pOcmi6oD4=;
  b=jFS8mcFLiZT9rLK04ZvCdjyfVLZUi8j9KSoIXJi6LKZGUgKYWExo5Mkx
   qjO9RX1hCJ0uzJdOJc8WvubhqbpSNU+ycUmLvtGhyv9f/idA4RMSq7XQV
   8w85OI9oaXru+K/cYndHrUwXqFT4GJDZrTyLM3hOxd4njM+WVtyx9dl8Y
   Z1srmiH3KurpPmYnr5NSdwgKq6wLE3GoYcuVvZtW+E2l0Wivt7mLZlAU1
   tlvOS6cgAvmDW9YS/V6oS4I3Rl2ita7v8dQ9aTfPO5Z2J1C2+DSrGWKcp
   5z25kGybadvpNvIZxGPtLI1hIZnjiUoj6/vXwbHGkpIVGEEtWEIVC0DEw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="461458765"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="461458765"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:00:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="773995131"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="773995131"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 13 Dec 2023 08:00:29 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDRet-000Klg-24;
	Wed, 13 Dec 2023 16:00:27 +0000
Date: Wed, 13 Dec 2023 23:59:30 +0800
From: kernel test robot <lkp@intel.com>
To: Selvin Xavier <selvin.xavier@broadcom.com>, leon@kernel.org,
	jgg@ziepe.ca
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next 1/2] RDMA/bnxt_re: Add UAPI to share a page with
 user space
Message-ID: <202312132318.8DO4UiPT-lkp@intel.com>
References: <1702438411-23530-2-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1702438411-23530-2-git-send-email-selvin.xavier@broadcom.com>

Hi Selvin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v6.7-rc5 next-20231213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Selvin-Xavier/RDMA-bnxt_re-Add-UAPI-to-share-a-page-with-user-space/20231213-115222
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/1702438411-23530-2-git-send-email-selvin.xavier%40broadcom.com
patch subject: [PATCH for-next 1/2] RDMA/bnxt_re: Add UAPI to share a page with user space
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231213/202312132318.8DO4UiPT-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231213/202312132318.8DO4UiPT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312132318.8DO4UiPT-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/infiniband/hw/bnxt_re/ib_verbs.c:4442:30: warning: variable 'cctx' set but not used [-Wunused-but-set-variable]
           struct bnxt_qplib_chip_ctx *cctx;
                                       ^
   drivers/infiniband/hw/bnxt_re/ib_verbs.c:4472:42: warning: variable 'addr' is uninitialized when used here [-Wuninitialized]
           entry = bnxt_re_mmap_entry_insert(uctx, addr, mmap_flag, &mem_offset);
                                                   ^~~~
   drivers/infiniband/hw/bnxt_re/ib_verbs.c:4448:10: note: initialize the variable 'addr' to silence this warning
           u64 addr;
                   ^
                    = 0
   drivers/infiniband/hw/bnxt_re/ib_verbs.c:4472:48: warning: variable 'mmap_flag' is uninitialized when used here [-Wuninitialized]
           entry = bnxt_re_mmap_entry_insert(uctx, addr, mmap_flag, &mem_offset);
                                                         ^~~~~~~~~
   drivers/infiniband/hw/bnxt_re/ib_verbs.c:4441:2: note: variable 'mmap_flag' is declared here
           enum bnxt_re_mmap_flag mmap_flag;
           ^
   3 warnings generated.


vim +/cctx +4442 drivers/infiniband/hw/bnxt_re/ib_verbs.c

  4431	
  4432	DECLARE_UVERBS_GLOBAL_METHODS(BNXT_RE_OBJECT_NOTIFY_DRV,
  4433				      &UVERBS_METHOD(BNXT_RE_METHOD_NOTIFY_DRV));
  4434	
  4435	/* Toggle MEM */
  4436	static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bundle *attrs)
  4437	{
  4438		struct ib_uobject *uobj = uverbs_attr_get_uobject(attrs, BNXT_RE_TOGGLE_MEM_HANDLE);
  4439		enum bnxt_re_get_toggle_mem_type res_type;
  4440		struct bnxt_re_user_mmap_entry *entry;
  4441		enum bnxt_re_mmap_flag mmap_flag;
> 4442		struct bnxt_qplib_chip_ctx *cctx;
  4443		struct bnxt_re_ucontext *uctx;
  4444		struct bnxt_re_dev *rdev;
  4445		u64 mem_offset;
  4446		u32 length;
  4447		u32 offset;
  4448		u64 addr;
  4449		int err;
  4450	
  4451		uctx = container_of(ib_uverbs_get_ucontext(attrs), struct bnxt_re_ucontext, ib_uctx);
  4452		if (IS_ERR(uctx))
  4453			return PTR_ERR(uctx);
  4454	
  4455		err = uverbs_get_const(&res_type, attrs, BNXT_RE_TOGGLE_MEM_TYPE);
  4456		if (err)
  4457			return err;
  4458	
  4459		rdev = uctx->rdev;
  4460		cctx = rdev->chip_ctx;
  4461	
  4462		switch (res_type) {
  4463		case BNXT_RE_CQ_TOGGLE_MEM:
  4464			break;
  4465		case BNXT_RE_SRQ_TOGGLE_MEM:
  4466			break;
  4467	
  4468		default:
  4469			return -EOPNOTSUPP;
  4470		}
  4471	
  4472		entry = bnxt_re_mmap_entry_insert(uctx, addr, mmap_flag, &mem_offset);
  4473		if (!entry)
  4474			return -ENOMEM;
  4475	
  4476		uobj->object = entry;
  4477		uverbs_finalize_uobj_create(attrs, BNXT_RE_TOGGLE_MEM_HANDLE);
  4478		err = uverbs_copy_to(attrs, BNXT_RE_TOGGLE_MEM_MMAP_PAGE,
  4479				     &mem_offset, sizeof(mem_offset));
  4480		if (err)
  4481			return err;
  4482	
  4483		err = uverbs_copy_to(attrs, BNXT_RE_TOGGLE_MEM_MMAP_LENGTH,
  4484				     &length, sizeof(length));
  4485		if (err)
  4486			return err;
  4487	
  4488		err = uverbs_copy_to(attrs, BNXT_RE_TOGGLE_MEM_MMAP_OFFSET,
  4489				     &offset, sizeof(length));
  4490		if (err)
  4491			return err;
  4492	
  4493		return 0;
  4494	}
  4495	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

