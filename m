Return-Path: <linux-rdma+bounces-413-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25545811920
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Dec 2023 17:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33401F2101B
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Dec 2023 16:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DB833CD3;
	Wed, 13 Dec 2023 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c0a7cN99"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99A091
	for <linux-rdma@vger.kernel.org>; Wed, 13 Dec 2023 08:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702484554; x=1734020554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g8rXSc35TRcmfEsM9eL5J5LRcDNAunMI4Uwk7iEYV5o=;
  b=c0a7cN99orekJzwj0aElnGL1Lo2MDcM+Ve8Hm6+m2umy0elDQ0veBkYh
   wB7/KqDziGK/tZ6CRpP7oDyqJIFcHCuQavM4optuH2sue/EKtRktAx+zO
   bFfbb0eUYoboc7Eez0mSsQEdzHplpO4Iq0Ek9kVihuDDPQeQTbYp0eQhE
   LYMdvI8bkIwCjLsZaWhLSFq1FUQ4dl5zN4dHRpQ3mfqNHi+3+tfYdGj6c
   lBPpdyRm82ZtH5GHXYzkRieXypeSBF13/Lsji/uvawksY9mFL7RzY8/dq
   +JLoK9C9Jvenhf/C09pYW611rBgPbCTWo7MCIVAWCRHxjg9g+JIBeAOaZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="461462061"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="461462061"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:22:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="774003175"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="774003175"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 13 Dec 2023 08:22:32 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDS0E-000Kod-1b;
	Wed, 13 Dec 2023 16:22:30 +0000
Date: Thu, 14 Dec 2023 00:21:53 +0800
From: kernel test robot <lkp@intel.com>
To: Selvin Xavier <selvin.xavier@broadcom.com>, leon@kernel.org,
	jgg@ziepe.ca
Cc: oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next 2/2] RDMA/bnxt_re: Share a page to expose per CQ
 info with userspace
Message-ID: <202312140044.BB9N8UAJ-lkp@intel.com>
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
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20231214/202312140044.BB9N8UAJ-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231214/202312140044.BB9N8UAJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312140044.BB9N8UAJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/infiniband/hw/bnxt_re/ib_verbs.c:4236:20: warning: no previous prototype for 'bnxt_re_search_for_cq' [-Wmissing-prototypes]
    4236 | struct bnxt_re_cq *bnxt_re_search_for_cq(struct bnxt_re_dev *rdev, u32 cq_id)
         |                    ^~~~~~~~~~~~~~~~~~~~~
   drivers/infiniband/hw/bnxt_re/ib_verbs.c: In function 'bnxt_re_handler_BNXT_RE_METHOD_GET_TOGGLE_MEM':
   drivers/infiniband/hw/bnxt_re/ib_verbs.c:4473:37: warning: variable 'cctx' set but not used [-Wunused-but-set-variable]
    4473 |         struct bnxt_qplib_chip_ctx *cctx;
         |                                     ^~~~


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

