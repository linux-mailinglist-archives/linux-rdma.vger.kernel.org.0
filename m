Return-Path: <linux-rdma+bounces-9284-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E8AA81AD6
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 04:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8CC884A34
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 02:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B937DA6C;
	Wed,  9 Apr 2025 02:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+i8wejk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA2581AC8
	for <linux-rdma@vger.kernel.org>; Wed,  9 Apr 2025 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744165356; cv=none; b=UBs0144b2R744xfqeOyitmiE0rvsZCjFnal/o+QQfGaFGKcaRAXsMf28Bpgw3rEGwmme6ISrTHCk9vAKkKL4g6rnzDSumjHxdzZh1IERzFa/lXJDiIEb32/TZMvANB/4cVWwXxaOnEVtN9LtKJDzF1DMTnw3u30p7cOadSREmJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744165356; c=relaxed/simple;
	bh=UMVoW2zOi+vsq2Kj5GVV3nva9LbppLapQXzkCAKIRyw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h8nibpcTiNFYGjLuuTpWoAOggbQHYYPa8wUootXytpESg4pKwnUvhUfX+yDANM5UWV7OEhINh/CoQ1pPwR34KFYDsxGVRDHP8V+omwtVc0o7N1L8/L9n/IxkvRzcP18IYSU+JDiD5cGPRtwLeiW47W0OasCdvKRZABXVu0Yw1OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+i8wejk; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744165355; x=1775701355;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UMVoW2zOi+vsq2Kj5GVV3nva9LbppLapQXzkCAKIRyw=;
  b=T+i8wejk7MpyXujdE2kQBcl4jG0s9fRui/n2Kz8r4xLYA/hPX4NALrmv
   6DzSm/wx0dB2pWP+ncUjeZicmnsKj1SgAU2oEWuXEK1oYkbOro9lj3Hlz
   ueYmZsoG1b3XRq9uP3SXBRMxF85/KiDKBPW3z7a/X16PvW62KFtFrfgyT
   9yCMFtxbqgYx+MeE8YSDNbt3a1QfitYrK25LgtTkl2Vq4ZoAJ5ePESk+r
   o7Kqd9hKe/r8avYPVEkk+qH/JKDHxh/pnKPdarP7g1GPN1bG82/QtYgiK
   NgNRhDaB/evR+p374hnbdoOPvJiSd8K5tf1eEdHjMMSn75DNkRt6EefkZ
   A==;
X-CSE-ConnectionGUID: sm233LsoQIKafQ00Li5OJw==
X-CSE-MsgGUID: tEdKqSL7TgODf8HomW5HZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45742645"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="45742645"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 19:22:34 -0700
X-CSE-ConnectionGUID: FZ6RUtBZTsKHTexVUMuSog==
X-CSE-MsgGUID: Ffnarxc+QB6p+gHwrQ1oUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="129273445"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 08 Apr 2025 19:22:32 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u2L5C-0008Bp-0i;
	Wed, 09 Apr 2025 02:22:30 +0000
Date: Wed, 9 Apr 2025 10:21:45 +0800
From: kernel test robot <lkp@intel.com>
To: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [rdma:wip/jgg-for-rc 1/6]
 drivers/infiniband/hw/bnxt_re/ib_verbs.c:1777:24: warning: variable 'nq' set
 but not used
Message-ID: <202504091055.CzgXnk4C-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
head:   9beb2c91fb86e0be70a5833c6730441fa3c9efa8
commit: 6b395d31146a3fae775823ea8570a37b922f6685 [1/6] RDMA/bnxt_re: Fix budget handling of notification queue
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20250409/202504091055.CzgXnk4C-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250409/202504091055.CzgXnk4C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504091055.CzgXnk4C-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/infiniband/hw/bnxt_re/ib_verbs.c:1777:24: warning: variable 'nq' set but not used [-Wunused-but-set-variable]
    1777 |         struct bnxt_qplib_nq *nq = NULL;
         |                               ^
   drivers/infiniband/hw/bnxt_re/ib_verbs.c:1828:24: warning: variable 'nq' set but not used [-Wunused-but-set-variable]
    1828 |         struct bnxt_qplib_nq *nq = NULL;
         |                               ^
   2 warnings generated.


vim +/nq +1777 drivers/infiniband/hw/bnxt_re/ib_verbs.c

1ac5a404797523c Selvin Xavier      2017-02-10  1769  
37cb11acf1f72a0 Devesh Sharma      2018-01-11  1770  /* Shared Receive Queues */
119181d1d4327d3 Leon Romanovsky    2020-09-07  1771  int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
37cb11acf1f72a0 Devesh Sharma      2018-01-11  1772  {
37cb11acf1f72a0 Devesh Sharma      2018-01-11  1773  	struct bnxt_re_srq *srq = container_of(ib_srq, struct bnxt_re_srq,
37cb11acf1f72a0 Devesh Sharma      2018-01-11  1774  					       ib_srq);
37cb11acf1f72a0 Devesh Sharma      2018-01-11  1775  	struct bnxt_re_dev *rdev = srq->rdev;
37cb11acf1f72a0 Devesh Sharma      2018-01-11  1776  	struct bnxt_qplib_srq *qplib_srq = &srq->qplib_srq;
37cb11acf1f72a0 Devesh Sharma      2018-01-11 @1777  	struct bnxt_qplib_nq *nq = NULL;
37cb11acf1f72a0 Devesh Sharma      2018-01-11  1778  
37cb11acf1f72a0 Devesh Sharma      2018-01-11  1779  	if (qplib_srq->cq)
37cb11acf1f72a0 Devesh Sharma      2018-01-11  1780  		nq = qplib_srq->cq->nq;
181028a0d84cdcc Chandramohan Akula 2024-08-29  1781  	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT) {
181028a0d84cdcc Chandramohan Akula 2024-08-29  1782  		free_page((unsigned long)srq->uctx_srq_page);
181028a0d84cdcc Chandramohan Akula 2024-08-29  1783  		hash_del(&srq->hash_entry);
181028a0d84cdcc Chandramohan Akula 2024-08-29  1784  	}
68e326dea1dba93 Leon Romanovsky    2019-04-03  1785  	bnxt_qplib_destroy_srq(&rdev->qplib_res, qplib_srq);
37cb11acf1f72a0 Devesh Sharma      2018-01-11  1786  	ib_umem_release(srq->umem);
063975feedb1438 Chandramohan Akula 2023-07-26  1787  	atomic_dec(&rdev->stats.res.srq_count);
119181d1d4327d3 Leon Romanovsky    2020-09-07  1788  	return 0;
37cb11acf1f72a0 Devesh Sharma      2018-01-11  1789  }
37cb11acf1f72a0 Devesh Sharma      2018-01-11  1790  

:::::: The code at line 1777 was first introduced by commit
:::::: 37cb11acf1f72a007a85894a6dd2ec93932bde46 RDMA/bnxt_re: Add SRQ support for Broadcom adapters

:::::: TO: Devesh Sharma <devesh.sharma@broadcom.com>
:::::: CC: Doug Ledford <dledford@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

