Return-Path: <linux-rdma+bounces-8509-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E01A584EC
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 15:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD0E47A58E3
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 14:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48C51CAA85;
	Sun,  9 Mar 2025 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RbHBkzWJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9FD1C2DC8
	for <linux-rdma@vger.kernel.org>; Sun,  9 Mar 2025 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741530728; cv=none; b=kzXMrXX6Ww7PtV61crgixj0v0qGbu8yTmQ/C2KjazFc+psrVb3T82OSfWTGeQdYSI4dh1L4oY5ITORjbmJYPFVyZaNFrQVAmfUrtEjstPxOXg94NOqg8dL2n0C7XcAH/NgP4aD8NBCd3++59bqhcbTT3qSBqGIP7JgCritmY1Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741530728; c=relaxed/simple;
	bh=rf7ClRPwbXBSePW2jK3Cp73RMSU8ntYf25KwZNIqRWY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XDq9D7X63x6rbW+PDvs2SXlnug9XZGmMBPq/K+1RIdDaXR7vXOHG4j0H83ZAFldUvmKj1L64lgQOq46DNORLfdjvI7J8ktCIbXRa+Eo8js3t5TTPzYpqqkDg49NY9ijDlb/jRtCFMM4TM5qPrV5kUOWut8eHJBHoAcN8ToHX31I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RbHBkzWJ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741530727; x=1773066727;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rf7ClRPwbXBSePW2jK3Cp73RMSU8ntYf25KwZNIqRWY=;
  b=RbHBkzWJ1Ef7lDXWj0LCfNyhZaEXS7fy+EIjuSdmxBLIV3wh2sggp93v
   kB++7mP3Qgf1v7pvWvhgEPyeiOR1g6kBBeiDnDzws0T06d53Op+FRBFTv
   wpueBESQGODIXtAe+suSR2yfTZQxdKMbhZT4369TmASPWi2CWqnr8khVz
   5BArWZFVd3xEjFMqX/7Bd6WfIJYgiLjoxwRpzAci9y3ShFYFDV8mSftXD
   B+zwdZE+OOFxveNldBQbzmgqs3UaqgGYOrZB0nIz0x4VWWXMGFG16+Rgz
   9+oQQaYlArYedqQsq0KzqfB8VA+bCtH6naGoIod3gFy7f9jrJ6gwh/Fgk
   Q==;
X-CSE-ConnectionGUID: GBtuOiEJROqT55MvLYcyog==
X-CSE-MsgGUID: xYkRZBJjSIGnYXCcjO5cuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="53157490"
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="53157490"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 07:32:06 -0700
X-CSE-ConnectionGUID: Mz38SZ9bTuOQheLpz9LDzA==
X-CSE-MsgGUID: ewQXqTkbScu1LfchR0THwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="120480757"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 09 Mar 2025 07:32:04 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trHhC-0003BQ-0S;
	Sun, 09 Mar 2025 14:32:02 +0000
Date: Sun, 9 Mar 2025 22:31:36 +0800
From: kernel test robot <lkp@intel.com>
To: Chiara Meiohas <cmeiohas@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [rdma:wip/leon-for-next 19/29] include/rdma/ib_ucaps.h:19:18:
 warning: extra tokens at end of #ifdef directive
Message-ID: <202503092207.3Ho0hd5Q-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
head:   b064e7b61e82e48d030582eb1d3701b31c2b16c8
commit: 548599879c3a640b3893070a1739624bcfdb968d [19/29] RDMA/uverbs: Introduce UCAP (User CAPabilities) API
config: csky-randconfig-002-20250309 (https://download.01.org/0day-ci/archive/20250309/202503092207.3Ho0hd5Q-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250309/202503092207.3Ho0hd5Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503092207.3Ho0hd5Q-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/infiniband/core/ucaps.c:11:
>> include/rdma/ib_ucaps.h:19:18: warning: extra tokens at end of #ifdef directive
      19 | #ifdef IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
         |                  ^


vim +19 include/rdma/ib_ucaps.h

    16	
    17	void ib_cleanup_ucaps(void);
    18	int ib_get_ucaps(int *fds, int fd_count, uint64_t *idx_mask);
  > 19	#ifdef IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
    20	int ib_create_ucap(enum rdma_user_cap type);
    21	void ib_remove_ucap(enum rdma_user_cap type);
    22	#else
    23	static inline int ib_create_ucap(enum rdma_user_cap type)
    24	{
    25		return -EOPNOTSUPP;
    26	}
    27	static inline void ib_remove_ucap(enum rdma_user_cap type) {}
    28	#endif /* CONFIG_INFINIBAND_USER_ACCESS */
    29	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

