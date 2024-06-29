Return-Path: <linux-rdma+bounces-3568-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAAA91CB7C
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Jun 2024 09:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE191C2193C
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Jun 2024 07:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E641CAA6;
	Sat, 29 Jun 2024 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L6VpbltK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799D1AD49
	for <linux-rdma@vger.kernel.org>; Sat, 29 Jun 2024 07:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719645657; cv=none; b=EwhoCr/ct6XEI/lRmSJCzCwistU5a+b6mROuowmCZhcNVDBxE1WAIbMTZzj59OEO2hqfvW8pTKpBGKiwpEVg9u+fy1KEIHSRVRpQ0/nGTHBN7kRsDKEyIrHr1NHkoLCvGUK5pmdO7+jk/XZT1X9uK1udAX+yT1ZypgybEFjCZ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719645657; c=relaxed/simple;
	bh=nWjnCBr9bpaejxedFvs3WLo5y0C1Ne3t+RcEoT6V0GI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mpa/+aG/CjuWg2SlDeZdyuT7T/L/PtaqAo5r4x+55HVUC5q7vbI79n9+SJ9OOcMnlguPGg0Y+xYasdE+YUpbEAiv0xBoiO4+NPW9LoWa7f8AzziqQnCSTEe86mTOcmpKSfIWpStQT9wHOcd16JTHIYxWR6qTLtux6o9Yd7GTuiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L6VpbltK; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719645656; x=1751181656;
  h=date:from:to:cc:subject:message-id;
  bh=nWjnCBr9bpaejxedFvs3WLo5y0C1Ne3t+RcEoT6V0GI=;
  b=L6VpbltKayMHR7lwzcZ0kDv4NaFKRtuwOCWAAJBH5m6Pg/ff+0dBXGZc
   YU7hUoA6LNyuvLN4k6D3PzxTMBy7pj+p7tRTVi5GuzwPgKVJilaG0t0A7
   AAa7qCNJb7tq2Z0iXlG3xCgKtKMN5AIo6Mmjybtn3A9e+sA+MbWRulitz
   Oy+KFfCFct14+0JA7iHYHLIocigfLGiUgr/PFasIPnhTwY/j1Svbb3y13
   R7MPJvvDQVQPru8wm1/fnEUYkku4Z3kT6FJ+OSS4OdqDYkHGjTu2PdLYH
   Wje3sOqcUOXE1n0y2+xbRABDjyraWSDDO8KZAnO4/o9OKN5QOl0m1FCDP
   Q==;
X-CSE-ConnectionGUID: 6bq8aGYUTn2gofUyx5BEBw==
X-CSE-MsgGUID: bevTGNVERBqsC6+Aag/yTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16972908"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16972908"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2024 00:20:56 -0700
X-CSE-ConnectionGUID: 6MpunFphTNmQRsbU94wDfQ==
X-CSE-MsgGUID: BZC3AiI+RSSQwcj37dizvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="45372309"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 29 Jun 2024 00:20:54 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNSOB-000J46-0w;
	Sat, 29 Jun 2024 07:20:51 +0000
Date: Sat, 29 Jun 2024 15:20:22 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 589b844f1bf04850d9fabcaa2e943325dc6768b4
Message-ID: <202406291521.EGWvIDTb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 589b844f1bf04850d9fabcaa2e943325dc6768b4  RDMA/mlx5: Send UAR page index as ioctl attribute

elapsed time: 2049m

configs tested: 60
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386         buildonly-randconfig-001-20240628   gcc-10
i386         buildonly-randconfig-001-20240629   gcc-7
i386         buildonly-randconfig-002-20240628   gcc-10
i386         buildonly-randconfig-002-20240628   gcc-13
i386         buildonly-randconfig-002-20240629   gcc-7
i386         buildonly-randconfig-003-20240628   gcc-10
i386         buildonly-randconfig-003-20240628   gcc-13
i386         buildonly-randconfig-003-20240629   gcc-7
i386         buildonly-randconfig-004-20240628   gcc-10
i386         buildonly-randconfig-004-20240628   gcc-13
i386         buildonly-randconfig-004-20240629   gcc-7
i386         buildonly-randconfig-005-20240628   clang-18
i386         buildonly-randconfig-005-20240628   gcc-10
i386         buildonly-randconfig-005-20240629   gcc-7
i386         buildonly-randconfig-006-20240628   gcc-10
i386         buildonly-randconfig-006-20240628   gcc-13
i386         buildonly-randconfig-006-20240629   gcc-7
i386                  randconfig-001-20240628   gcc-10
i386                  randconfig-001-20240629   gcc-7
i386                  randconfig-002-20240628   gcc-10
i386                  randconfig-002-20240628   gcc-13
i386                  randconfig-002-20240629   gcc-7
i386                  randconfig-003-20240628   clang-18
i386                  randconfig-003-20240628   gcc-10
i386                  randconfig-003-20240629   gcc-7
i386                  randconfig-004-20240628   gcc-10
i386                  randconfig-004-20240628   gcc-13
i386                  randconfig-004-20240629   gcc-7
i386                  randconfig-005-20240628   clang-18
i386                  randconfig-005-20240628   gcc-10
i386                  randconfig-005-20240629   gcc-7
i386                  randconfig-006-20240628   gcc-10
i386                  randconfig-006-20240628   gcc-13
i386                  randconfig-006-20240629   gcc-7
i386                  randconfig-011-20240628   clang-18
i386                  randconfig-011-20240628   gcc-10
i386                  randconfig-011-20240629   gcc-7
i386                  randconfig-012-20240628   gcc-10
i386                  randconfig-012-20240628   gcc-9
i386                  randconfig-012-20240629   gcc-7
i386                  randconfig-013-20240628   gcc-10
i386                  randconfig-013-20240628   gcc-13
i386                  randconfig-013-20240629   gcc-7
i386                  randconfig-014-20240628   clang-18
i386                  randconfig-014-20240628   gcc-10
i386                  randconfig-014-20240629   gcc-7
i386                  randconfig-015-20240628   gcc-10
i386                  randconfig-015-20240628   gcc-13
i386                  randconfig-015-20240629   gcc-7
i386                  randconfig-016-20240628   gcc-10
i386                  randconfig-016-20240628   gcc-7
i386                  randconfig-016-20240629   gcc-7
openrisc                          allnoconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

