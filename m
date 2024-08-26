Return-Path: <linux-rdma+bounces-4568-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D8395F346
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2024 15:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86081C218C9
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2024 13:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1F818455D;
	Mon, 26 Aug 2024 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ki71YPiv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD22153828
	for <linux-rdma@vger.kernel.org>; Mon, 26 Aug 2024 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680331; cv=none; b=h0BbSwtpQhnKGR+aP6w6SbR8769CUlj63h+5otxNOG4WpxElVCtwshEk5H2pOSUqDZEeJEbo8kgYBmgp4kdbHcHtemIBddhGvl76+YQ3RLlxba4b6tpesT8v+YxfDC/lL4PZRE3oG5iXvorCCoH3hI4Bk6Q3rOIBpUu7WJ4kbAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680331; c=relaxed/simple;
	bh=7duO9MVILcIS/upadXk2mLV0dtLcoo6R2fr7cbYSKAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiQXjtdUU8ULzQ090hrhlS2JIrj79JGNI/onOFrQuYAHUSu2/5dgri+ZGEjbrRqh/neiNyXxhBgkMWlYj3H8eJtx2ox1byg4sMt5rpZQXCK6QOdvezUerz0NSDwy76XTUgyTfbETE7t2mnuQxGanLN4fyvA9y0iNMRHQQAu8lCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ki71YPiv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724680329; x=1756216329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7duO9MVILcIS/upadXk2mLV0dtLcoo6R2fr7cbYSKAc=;
  b=ki71YPivY0Az6EjWBnkIpLS49R9OxFFP4lKuZaPzi5GRTtoqCVBvAV3E
   vVbxR1E6KbbcJHCo1B7E8+XQ+zSa6+OcDkKgP5u492nlOe0+rMBMZslfJ
   m5nX8xDNMggxzdSbKVQddj3UTY3bnG+bBUUg6V6YiFig9JILKE3ppYS5u
   gtfiP13o7hZA3GssqGGPqBxF+xLzjZh/bmCaWhTHLbMfmENDjvnBeQ4Jg
   BLcHo+FuLpRIKt5eKxdiUHNKlVPOTnmhglbTYvE5qMR4xlgOsWpoQ7/UO
   0tqzr5rceUfPrUXbEe+dM5LYgpxLmUH6+F+YVDqVZ3k+kvaRBtej/r2Qm
   w==;
X-CSE-ConnectionGUID: ZA8lbUHVQ9Gor9qA9vaaUQ==
X-CSE-MsgGUID: kBELRmlkTf+jIT48Cq2UUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="33673345"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="33673345"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 06:52:09 -0700
X-CSE-ConnectionGUID: XkJ47ffsSnCAyLemj5XdnA==
X-CSE-MsgGUID: AfB4mCxaRyauzF/J7rZkSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="93246362"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 26 Aug 2024 06:52:08 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sia8b-000H9x-10;
	Mon, 26 Aug 2024 13:52:05 +0000
Date: Mon, 26 Aug 2024 21:51:24 +0800
From: kernel test robot <lkp@intel.com>
To: Cheng Xu <chengyou@linux.alibaba.com>, jgg@ziepe.ca, leon@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org,
	KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next 2/4] RDMA/erdma: Refactor the initialization and
 destruction of EQ
Message-ID: <202408262144.SpsbTKs7-lkp@intel.com>
References: <20240823075058.89488-3-chengyou@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823075058.89488-3-chengyou@linux.alibaba.com>

Hi Cheng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v6.11-rc5 next-20240826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cheng-Xu/RDMA-erdma-Make-the-device-probe-process-more-robust/20240826-123256
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20240823075058.89488-3-chengyou%40linux.alibaba.com
patch subject: [PATCH for-next 2/4] RDMA/erdma: Refactor the initialization and destruction of EQ
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240826/202408262144.SpsbTKs7-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240826/202408262144.SpsbTKs7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408262144.SpsbTKs7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/infiniband/hw/erdma/erdma_eq.c:141:6: warning: no previous prototype for 'erdma_aeq_destroy' [-Wmissing-prototypes]
     141 | void erdma_aeq_destroy(struct erdma_dev *dev)
         |      ^~~~~~~~~~~~~~~~~


vim +/erdma_aeq_destroy +141 drivers/infiniband/hw/erdma/erdma_eq.c

f2a0a630b95345 Cheng Xu 2022-07-27  140  
f2a0a630b95345 Cheng Xu 2022-07-27 @141  void erdma_aeq_destroy(struct erdma_dev *dev)
f2a0a630b95345 Cheng Xu 2022-07-27  142  {
f2a0a630b95345 Cheng Xu 2022-07-27  143  	struct erdma_eq *eq = &dev->aeq;
f2a0a630b95345 Cheng Xu 2022-07-27  144  
f0697bf078368d Boshi Yu 2024-03-11  145  	dma_free_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT, eq->qbuf,
f2a0a630b95345 Cheng Xu 2022-07-27  146  			  eq->qbuf_dma_addr);
f0697bf078368d Boshi Yu 2024-03-11  147  
fdb09ed15f272a Boshi Yu 2024-03-11  148  	dma_pool_free(dev->db_pool, eq->dbrec, eq->dbrec_dma);
f2a0a630b95345 Cheng Xu 2022-07-27  149  }
f2a0a630b95345 Cheng Xu 2022-07-27  150  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

