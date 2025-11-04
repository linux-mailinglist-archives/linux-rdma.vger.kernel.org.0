Return-Path: <linux-rdma+bounces-14222-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65D8C2F30E
	for <lists+linux-rdma@lfdr.de>; Tue, 04 Nov 2025 04:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397451895F25
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Nov 2025 03:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5E02BD580;
	Tue,  4 Nov 2025 03:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aME0xI5/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86B82727E7
	for <linux-rdma@vger.kernel.org>; Tue,  4 Nov 2025 03:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762228009; cv=none; b=sKIwZ1IISSGqZnKxkk6gFu5knSCE1go72S0BBnfKxrb2RPLqvvD2KGiIkIsjhh/PWHQl3hfzp4+sbTG2yvVJOIhWI2bIxH8dBox3iwwArHMV49Ny7Ym69da0BNPVmlXyN7TfyyC+u4/Ya6vWdpOwvtPsEbZ7JomPZXuane236lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762228009; c=relaxed/simple;
	bh=xi/hW3NfngeZ5NWuTMWiUQ8P+RCzK4LcoZLxVlOP4oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwhDvR7bA2sof7RZ63H23EQuFei5NYAjFIP9YlNUZM7aWyFoR4fNBlkKIw1YBLklhkJqoUJD72m7pGjkpJJZrni2UK9tdBwfhMIlUshB/QKR4JG+8z2t7wiRyXPqfVg37m/J/6TIEUmGgB4FiuuBBQsH+drS5mgO9GYxE9jLcew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aME0xI5/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762228008; x=1793764008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xi/hW3NfngeZ5NWuTMWiUQ8P+RCzK4LcoZLxVlOP4oM=;
  b=aME0xI5/steHvArgox/sVKHF076JhFU+FT3acC8Mvoa8ay9Ev/w3v7ZT
   SvjOCSZ+ihFjonsWX0tnsTuFqjwVAuoRWgy1n7/ryttHpoWfiUDi+FqpG
   LcA5TXN7j4ACdWUVyBxeJB98LDrGFVSbg7WXAmzIZAchmNY9iFj3i1PaC
   XEyC8nP8nVFcoqGXSoTZl+OxqAgKTwA7ScrgvTDPT/GscH4g8GII9l+Ri
   yaNCt4BPur+/zfCKss7lZaryAEOhvAz6B2/qE+uWOpSzVW4ZPTSsRyxB0
   ot9hnWK0KBqEFoqbfpK/igpJNT4sTntzkGK6+miICyrCs8FYOpFzKT6/k
   g==;
X-CSE-ConnectionGUID: xuVDYL5ASPq875AVgBp6ig==
X-CSE-MsgGUID: OQTmqy3GQfWf3YbMaU3XvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64012739"
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="64012739"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 19:46:47 -0800
X-CSE-ConnectionGUID: pELMU9h3T7CrEYFApCaCcg==
X-CSE-MsgGUID: uWuyGm8FSLWm6cVAlOTpYA==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 03 Nov 2025 19:46:45 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vG809-000QpW-2p;
	Tue, 04 Nov 2025 03:46:36 +0000
Date: Tue, 4 Nov 2025 11:45:56 +0800
From: kernel test robot <lkp@intel.com>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	leon@kernel.org, jgg@ziepe.ca
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: Re: [PATCH rdma-next 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ and
 QP verbs
Message-ID: <202511041131.c3AuE5DZ-lkp@intel.com>
References: <20251103105033.205586-5-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103105033.205586-5-sriharsha.basavapatna@broadcom.com>

Hi Sriharsha,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v6.18-rc4 next-20251103]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sriharsha-Basavapatna/RDMA-bnxt_re-Move-the-UAPI-methods-to-a-dedicated-file/20251103-190151
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20251103105033.205586-5-sriharsha.basavapatna%40broadcom.com
patch subject: [PATCH rdma-next 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ and QP verbs
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20251104/202511041131.c3AuE5DZ-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251104/202511041131.c3AuE5DZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511041131.c3AuE5DZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/infiniband/hw/bnxt_re/dv.c:635:22: warning: variable 'rdev' set but not used [-Wunused-but-set-variable]
     635 |         struct bnxt_re_dev *rdev;
         |                             ^
>> drivers/infiniband/hw/bnxt_re/dv.c:891:30: warning: variable 'ib_cq' is uninitialized when used here [-Wuninitialized]
     891 |         bnxt_re_dv_init_ib_cq(rdev, ib_cq, re_cq);
         |                                     ^~~~~
   drivers/infiniband/hw/bnxt_re/dv.c:835:21: note: initialize the variable 'ib_cq' to silence this warning
     835 |         struct ib_cq *ib_cq;
         |                            ^
         |                             = NULL
   drivers/infiniband/hw/bnxt_re/dv.c:1105:27: warning: variable 'cntx' set but not used [-Wunused-but-set-variable]
    1105 |         struct bnxt_re_ucontext *cntx;
         |                                  ^
>> drivers/infiniband/hw/bnxt_re/dv.c:1131:18: warning: variable 'umem' is uninitialized when used here [-Wuninitialized]
    1131 |                 __func__, (u64)umem, sginfo->npages, sginfo->pgsize, sginfo->pgshft);
         |                                ^~~~
   include/linux/dev_printk.h:165:39: note: expanded from macro 'dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                              ^~~~~~~~~~~
   include/linux/dynamic_debug.h:274:19: note: expanded from macro 'dynamic_dev_dbg'
     274 |                            dev, fmt, ##__VA_ARGS__)
         |                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:59: note: expanded from macro '_dynamic_func_call'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |                                                                  ^~~~~~~~~~~
   include/linux/dynamic_debug.h:248:65: note: expanded from macro '_dynamic_func_call_cls'
     248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |                                                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:224:15: note: expanded from macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   drivers/infiniband/hw/bnxt_re/dv.c:1106:22: note: initialize the variable 'umem' to silence this warning
    1106 |         struct ib_umem *umem;
         |                             ^
         |                              = NULL
   4 warnings generated.


vim +/ib_cq +891 drivers/infiniband/hw/bnxt_re/dv.c

   823	
   824	static int UVERBS_HANDLER(BNXT_RE_METHOD_DV_CREATE_CQ)(struct uverbs_attr_bundle *attrs)
   825	{
   826		struct ib_uobject *uobj =
   827			uverbs_attr_get_uobject(attrs, BNXT_RE_DV_CREATE_CQ_HANDLE);
   828		struct bnxt_re_dv_umem *umem_handle = NULL;
   829		struct bnxt_re_dv_cq_resp resp = {};
   830		struct bnxt_re_dv_cq_req req = {};
   831		struct bnxt_re_ucontext *re_uctx;
   832		struct ib_ucontext *ib_uctx;
   833		struct bnxt_re_dev *rdev;
   834		struct bnxt_re_cq *re_cq;
   835		struct ib_cq *ib_cq;
   836		u64 offset;
   837		int ret;
   838	
   839		ib_uctx = ib_uverbs_get_ucontext(attrs);
   840		if (IS_ERR(ib_uctx))
   841			return PTR_ERR(ib_uctx);
   842	
   843		re_uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
   844		rdev = re_uctx->rdev;
   845	
   846		ret = uverbs_copy_from_or_zero(&req, attrs, BNXT_RE_DV_CREATE_CQ_REQ);
   847		if (ret) {
   848			dev_err(rdev_to_dev(rdev), "%s: Failed to copy request: %d\n",
   849				__func__, ret);
   850			return ret;
   851		}
   852	
   853		umem_handle = uverbs_attr_get_obj(attrs, BNXT_RE_DV_CREATE_CQ_UMEM_HANDLE);
   854		if (IS_ERR(umem_handle)) {
   855			dev_err(rdev_to_dev(rdev),
   856				"%s: BNXT_RE_DV_CREATE_CQ_UMEM_HANDLE is not valid\n",
   857				__func__);
   858			return PTR_ERR(umem_handle);
   859		}
   860	
   861		ret = uverbs_copy_from(&offset, attrs, BNXT_RE_DV_CREATE_CQ_UMEM_OFFSET);
   862		if (ret) {
   863			dev_err(rdev_to_dev(rdev), "%s: Failed to copy umem offset: %d\n",
   864				__func__, ret);
   865			return ret;
   866		}
   867	
   868		re_cq = bnxt_re_dv_create_qplib_cq(rdev, re_uctx, &req, umem_handle, offset);
   869		if (!re_cq) {
   870			dev_err(rdev_to_dev(rdev), "%s: Failed to create qplib cq\n",
   871				__func__);
   872			return -EIO;
   873		}
   874	
   875		ret = bnxt_re_dv_create_cq_resp(rdev, re_cq, &resp);
   876		if (ret) {
   877			dev_err(rdev_to_dev(rdev),
   878				"%s: Failed to create cq response\n", __func__);
   879			goto fail_resp;
   880		}
   881	
   882		ret = bnxt_re_dv_uverbs_copy_to(rdev, attrs, BNXT_RE_DV_CREATE_CQ_RESP,
   883						&resp, sizeof(resp));
   884		if (ret) {
   885			dev_err(rdev_to_dev(rdev),
   886				"%s: Failed to copy cq response: %d\n", __func__, ret);
   887			goto fail_resp;
   888		}
   889	
   890		bnxt_re_dv_finalize_uobj(uobj, re_cq, attrs, BNXT_RE_DV_CREATE_CQ_HANDLE);
 > 891		bnxt_re_dv_init_ib_cq(rdev, ib_cq, re_cq);
   892		re_cq->is_dv_cq = true;
   893		atomic_inc(&rdev->dv_cq_count);
   894	
   895		dev_dbg(rdev_to_dev(rdev), "%s: Created CQ: 0x%llx, handle: 0x%x\n",
   896			__func__, (u64)re_cq, uobj->id);
   897	
   898		return 0;
   899	
   900	fail_resp:
   901		bnxt_qplib_destroy_cq(&rdev->qplib_res, &re_cq->qplib_cq);
   902		bnxt_re_put_nq(rdev, re_cq->qplib_cq.nq);
   903		if (re_cq->umem_handle) {
   904			ib_umem_release(re_cq->umem);
   905			kfree(re_cq->umem_handle);
   906		}
   907		kfree(re_cq);
   908		return ret;
   909	};
   910	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

