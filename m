Return-Path: <linux-rdma+bounces-415-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F39811F51
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Dec 2023 20:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F1C2822DF
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Dec 2023 19:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E5C7316C;
	Wed, 13 Dec 2023 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U+XgiCcU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564A49C
	for <linux-rdma@vger.kernel.org>; Wed, 13 Dec 2023 11:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702496954; x=1734032954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AsC/bkFxnvGz28yB18zGRCfVJtAAcMt1vR1R3uw0LSs=;
  b=U+XgiCcUAx8Gs0IKG0N77Q6gvJzkYFzVeZiwFCa8ZCAcI54P/AB/PbRW
   uuQEF4UAFZo+WLbmX6N06TUNQPex6iU303p1sS5Y/GTkOl2B8Exh38NMH
   gz1WnTP2HJ9WN6lYkru4WPQXs5LRRhOlPR2Mjhvjm3e8lvTgfIWM3YBQB
   Ujl6KmP51fBN6wOMOR1jUWhm3A31TO+vj+NYIZ8+phu8K9VC3UraTZJou
   j/ORwlFBCLgnHpjqrIWvpbzydyj/a+VluGpTEpZ8Dl8d1syWS4Qr3+hUg
   KLLTG7GcywH8GxrRq6LKtDjvIqxyP4TJTq9j65BqXyyxJRaVMucFCEX8V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="397801793"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="397801793"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 11:49:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="774064431"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="774064431"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 13 Dec 2023 11:49:12 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDVED-000L4t-22;
	Wed, 13 Dec 2023 19:49:09 +0000
Date: Thu, 14 Dec 2023 03:48:20 +0800
From: kernel test robot <lkp@intel.com>
To: Selvin Xavier <selvin.xavier@broadcom.com>, leon@kernel.org,
	jgg@ziepe.ca
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next 2/2] RDMA/bnxt_re: Share a page to expose per CQ
 info with userspace
Message-ID: <202312140331.djKEJ9zR-lkp@intel.com>
References: <1702438411-23530-3-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1702438411-23530-3-git-send-email-selvin.xavier@broadcom.com>

Hi Selvin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on next-20231213]
[cannot apply to linus/master v6.7-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Selvin-Xavier/RDMA-bnxt_re-Add-UAPI-to-share-a-page-with-user-space/20231213-115222
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/1702438411-23530-3-git-send-email-selvin.xavier%40broadcom.com
patch subject: [PATCH for-next 2/2] RDMA/bnxt_re: Share a page to expose per CQ info with userspace
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231214/202312140331.djKEJ9zR-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231214/202312140331.djKEJ9zR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312140331.djKEJ9zR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/infiniband/hw/bnxt_re/ib_verbs.c:4236:20: warning: no previous prototype for function 'bnxt_re_search_for_cq' [-Wmissing-prototypes]
   struct bnxt_re_cq *bnxt_re_search_for_cq(struct bnxt_re_dev *rdev, u32 cq_id)
                      ^
   drivers/infiniband/hw/bnxt_re/ib_verbs.c:4236:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct bnxt_re_cq *bnxt_re_search_for_cq(struct bnxt_re_dev *rdev, u32 cq_id)
   ^
   static 
   drivers/infiniband/hw/bnxt_re/ib_verbs.c:4473:30: warning: variable 'cctx' set but not used [-Wunused-but-set-variable]
           struct bnxt_qplib_chip_ctx *cctx;
                                       ^
>> drivers/infiniband/hw/bnxt_re/ib_verbs.c:4510:7: warning: variable 'addr' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
           case BNXT_RE_SRQ_TOGGLE_MEM:
                ^~~~~~~~~~~~~~~~~~~~~~
   drivers/infiniband/hw/bnxt_re/ib_verbs.c:4517:42: note: uninitialized use occurs here
           entry = bnxt_re_mmap_entry_insert(uctx, addr, mmap_flag, &mem_offset);
                                                   ^~~~
   drivers/infiniband/hw/bnxt_re/ib_verbs.c:4481:10: note: initialize the variable 'addr' to silence this warning
           u64 addr;
                   ^
                    = 0
>> drivers/infiniband/hw/bnxt_re/ib_verbs.c:4510:7: warning: variable 'mmap_flag' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
           case BNXT_RE_SRQ_TOGGLE_MEM:
                ^~~~~~~~~~~~~~~~~~~~~~
   drivers/infiniband/hw/bnxt_re/ib_verbs.c:4517:48: note: uninitialized use occurs here
           entry = bnxt_re_mmap_entry_insert(uctx, addr, mmap_flag, &mem_offset);
                                                         ^~~~~~~~~
   drivers/infiniband/hw/bnxt_re/ib_verbs.c:4472:2: note: variable 'mmap_flag' is declared here
           enum bnxt_re_mmap_flag mmap_flag;
           ^
   4 warnings generated.


vim +/bnxt_re_search_for_cq +4236 drivers/infiniband/hw/bnxt_re/ib_verbs.c

  4235	
> 4236	struct bnxt_re_cq *bnxt_re_search_for_cq(struct bnxt_re_dev *rdev, u32 cq_id)
  4237	{
  4238		struct bnxt_re_cq *cq = NULL, *tmp_cq;
  4239	
  4240		hash_for_each_possible(rdev->cq_hash, tmp_cq, hash_entry, cq_id) {
  4241			if (tmp_cq->qplib_cq.id == cq_id) {
  4242				cq = tmp_cq;
  4243				break;
  4244			}
  4245		}
  4246		return cq;
  4247	}
  4248	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

