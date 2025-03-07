Return-Path: <linux-rdma+bounces-8487-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A97BA57267
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 20:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C4E188B659
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 19:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8122C2397B0;
	Fri,  7 Mar 2025 19:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HUypNY5I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F657254B0D
	for <linux-rdma@vger.kernel.org>; Fri,  7 Mar 2025 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376716; cv=none; b=OztCPCXqfBjZAOBrBhhzcnuhZZ2l9lxX6745xMfCrYkzQm7WOAGHIIKDPqoR+1YzPbwrwtjmDbdoMpeblTWiRnmpNprE7YwxVa6Pj5iLexasFn38HfLF9ueQR7QWma9LIlYoSo1iMDTGv8Vl/B/PSWPSIZyPlJs2Kec2hB7KStk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376716; c=relaxed/simple;
	bh=5AS/RTnr0/iROOXd2OuyHlRapbrKhM7Aotvqr/+QGvU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mrf6TDYw9sR5BMZ2dxpEy/tI3j9c3u+xEgv3QGww5oBpss0AL4SH8SLiz101g3hS23H4bKXrwYiqiS9F8e+hzNprhAo0SZaXHsxwGAN20HfpMy/eP3EZWDW9w80m5XJX5Qu8BQKkN41sNZQxmtdAG/TmT8HbyTnO0GwViV7o2uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HUypNY5I; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741376714; x=1772912714;
  h=date:from:to:cc:subject:message-id;
  bh=5AS/RTnr0/iROOXd2OuyHlRapbrKhM7Aotvqr/+QGvU=;
  b=HUypNY5IeX63SrZSuHj9lI7fXhQXbAic10MU1np1rmthHxeXqxLHAp4X
   jF0A4fepGH2LqbreK00jvY/BMBcYO7x6ehDZ1xa8P723H0CEW84S5UDTU
   x2CWeOYERuqVJMRDfmq5eUpLVHyYg1bmKhLERWaZMmItJIoGGQCM1LIJ6
   JB309H7KF0je6AKEyzAUHHFlpEnoZfoXYpaO8dmRgeKxEWkoXXHwkr4pR
   CGCr05+SeurjiqIc60RCRQY9Mwhtq0Kx5fQ1B/89/cziaxBCb7kuK3nbw
   vJC18aPTguqUBuU5yL0qogfpnY/dQ0OcOOFa57vZdMNXH9VNExJfLro/v
   g==;
X-CSE-ConnectionGUID: ra+g0ByqSIGLAKfmLN6wRQ==
X-CSE-MsgGUID: fbt4Nm74QEC/adwFidWscw==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="46361796"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="46361796"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 11:45:13 -0800
X-CSE-ConnectionGUID: USwPTpigTVCx/7YENf/HPQ==
X-CSE-MsgGUID: FASBZZboSbynv8J28MIMFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120324911"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 07 Mar 2025 11:45:12 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqdd7-0000zL-2u;
	Fri, 07 Mar 2025 19:45:09 +0000
Date: Sat, 08 Mar 2025 03:45:02 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:hmm] BUILD SUCCESS
 da0dd17604d4c70080497091c762a790b0871eff
Message-ID: <202503080356.NcNc1Xfh-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git hmm
branch HEAD: da0dd17604d4c70080497091c762a790b0871eff  fwctl/cxl: Add documentation to FWCTL CXL

elapsed time: 1441m

configs tested: 57
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                  randconfig-001-20250307    gcc-13.2.0
arc                  randconfig-002-20250307    gcc-13.2.0
arm                  randconfig-001-20250307    clang-21
arm                  randconfig-002-20250307    gcc-14.2.0
arm                  randconfig-003-20250307    clang-19
arm                  randconfig-004-20250307    clang-21
arm64                randconfig-001-20250307    gcc-14.2.0
arm64                randconfig-002-20250307    clang-15
arm64                randconfig-003-20250307    gcc-14.2.0
arm64                randconfig-004-20250307    clang-15
csky                 randconfig-001-20250307    gcc-14.2.0
csky                 randconfig-002-20250307    gcc-14.2.0
hexagon              randconfig-001-20250307    clang-21
hexagon              randconfig-002-20250307    clang-21
i386       buildonly-randconfig-001-20250307    clang-19
i386       buildonly-randconfig-002-20250307    clang-19
i386       buildonly-randconfig-003-20250307    gcc-11
i386       buildonly-randconfig-004-20250307    clang-19
i386       buildonly-randconfig-005-20250307    gcc-12
i386       buildonly-randconfig-006-20250307    clang-19
loongarch            randconfig-001-20250307    gcc-14.2.0
loongarch            randconfig-002-20250307    gcc-14.2.0
nios2                randconfig-001-20250307    gcc-14.2.0
nios2                randconfig-002-20250307    gcc-14.2.0
parisc               randconfig-001-20250307    gcc-14.2.0
parisc               randconfig-002-20250307    gcc-14.2.0
powerpc              randconfig-001-20250307    gcc-14.2.0
powerpc              randconfig-002-20250307    clang-21
powerpc              randconfig-003-20250307    clang-19
powerpc64            randconfig-001-20250307    clang-21
powerpc64            randconfig-002-20250307    gcc-14.2.0
powerpc64            randconfig-003-20250307    gcc-14.2.0
riscv                randconfig-001-20250307    gcc-14.2.0
riscv                randconfig-002-20250307    clang-19
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250307    gcc-14.2.0
s390                 randconfig-002-20250307    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250307    gcc-14.2.0
sh                   randconfig-002-20250307    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250307    gcc-14.2.0
sparc                randconfig-002-20250307    gcc-14.2.0
sparc64              randconfig-001-20250307    gcc-14.2.0
sparc64              randconfig-002-20250307    gcc-14.2.0
um                   randconfig-001-20250307    clang-17
um                   randconfig-002-20250307    clang-21
x86_64     buildonly-randconfig-001-20250307    clang-19
x86_64     buildonly-randconfig-002-20250307    gcc-12
x86_64     buildonly-randconfig-003-20250307    clang-19
x86_64     buildonly-randconfig-004-20250307    clang-19
x86_64     buildonly-randconfig-005-20250307    clang-19
x86_64     buildonly-randconfig-006-20250307    gcc-12
xtensa               randconfig-001-20250307    gcc-14.2.0
xtensa               randconfig-002-20250307    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

