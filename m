Return-Path: <linux-rdma+bounces-6514-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A8F9F14F5
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2024 19:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26731652E2
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2024 18:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E8D186E52;
	Fri, 13 Dec 2024 18:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HdBSO2b9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CC81DA5F
	for <linux-rdma@vger.kernel.org>; Fri, 13 Dec 2024 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734114644; cv=none; b=pmSQ/mUN82tYBlBfkh6ab7GhmcvMpo9fsGvgrJhlM5H+oCrHZYEyOEPzs/DBLQjkev2KKKmCQYrF2cxbrLz/teemj2LNMfZaDzzcbVUYhqw+TF7Yv9F5W0tUV1NsZdouNpszG2NJmhM5E/m1OeI9Fjcm8/sXO+gks2p0u5iIJvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734114644; c=relaxed/simple;
	bh=GQzNGQxz+LAOcD/gAn2RZ2bJXJAV6c73ZR1sJsd+C1Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WH8QGTr/3rHHl49/MIXThoEa+jUtOG8w6vmzR7ERsz+rUUoa5IZy3/274fjd9T4OxzOsCA0Q+V0gOM1OurZewxfNrL7oEg/HCOlzqI4DEvulrhKvkqP9Y6pnS4XRsEwBxnTxwrhK7eEzS8/Z+M6BzmASqWVB34QmZ8g0MX5nPEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HdBSO2b9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734114643; x=1765650643;
  h=date:from:to:cc:subject:message-id;
  bh=GQzNGQxz+LAOcD/gAn2RZ2bJXJAV6c73ZR1sJsd+C1Q=;
  b=HdBSO2b9yW9bmYC7eExC2XsjmZowLWGW/xX/Wop8l31+wCurkepawwWe
   j1z23J9WOzqxyIt+Qq9nWKJJvrfGToLIwJcOMcJsCyci3lz2jyFs+hUYd
   Q9KuAoMAVHDmZpw4Q2wCLU8Te93EYaK9NvqajOS1NGJrUM7/WtgUVBSCq
   Tnp+dJmsqki+GdHXamchLAIGn0gY6ApxcNmdb1Ki/hJOAPt3ITawE2gbj
   S2XmQKZWPVYeDbJGjaxmw9t2NQkZ3BlShb5VfiTyMhdJmM9eloPOKeNME
   zdbZY2OaSgrvAwNDHwmXi1BhN5OQLvnFlagPGxAqPfgZruWSBl0ZncKGs
   w==;
X-CSE-ConnectionGUID: CLg1KhAsSD2v8M6tMJHB9A==
X-CSE-MsgGUID: Mx0bZNWOQbuKmSBY6Mx0dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="45267877"
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="45267877"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 10:30:41 -0800
X-CSE-ConnectionGUID: eFMCxNv/SMW/4kFFB25XtA==
X-CSE-MsgGUID: 1WxmB7/4SxuFzOFxH0morQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97040881"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 13 Dec 2024 10:30:40 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMAQv-000CJN-14;
	Fri, 13 Dec 2024 18:30:37 +0000
Date: Sat, 14 Dec 2024 02:30:36 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 8e2442abec075c4b01506b9de621ad97431756a5
Message-ID: <202412140230.CfturcOI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 8e2442abec075c4b01506b9de621ad97431756a5  IB/mad: Add flow control for solicited MADs

elapsed time: 1452m

configs tested: 65
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                             allmodconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20241213    gcc-13.2.0
arc                  randconfig-002-20241213    gcc-13.2.0
arm                  randconfig-001-20241213    clang-16
arm                  randconfig-002-20241213    clang-18
arm                  randconfig-003-20241213    gcc-14.2.0
arm                  randconfig-004-20241213    clang-18
arm64                randconfig-001-20241213    gcc-14.2.0
arm64                randconfig-002-20241213    gcc-14.2.0
arm64                randconfig-003-20241213    clang-18
arm64                randconfig-004-20241213    gcc-14.2.0
csky                 randconfig-001-20241213    gcc-14.2.0
csky                 randconfig-002-20241213    gcc-14.2.0
hexagon              randconfig-001-20241213    clang-20
hexagon              randconfig-002-20241213    clang-20
i386       buildonly-randconfig-001-20241213    clang-19
i386       buildonly-randconfig-002-20241213    gcc-12
i386       buildonly-randconfig-003-20241213    gcc-12
i386       buildonly-randconfig-004-20241213    clang-19
i386       buildonly-randconfig-005-20241213    gcc-12
i386       buildonly-randconfig-006-20241213    gcc-12
loongarch            randconfig-001-20241213    gcc-14.2.0
loongarch            randconfig-002-20241213    gcc-14.2.0
nios2                randconfig-001-20241213    gcc-14.2.0
nios2                randconfig-002-20241213    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20241213    gcc-14.2.0
parisc               randconfig-002-20241213    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20241213    gcc-14.2.0
powerpc              randconfig-002-20241213    clang-20
powerpc              randconfig-003-20241213    gcc-14.2.0
powerpc64            randconfig-001-20241213    gcc-14.2.0
powerpc64            randconfig-002-20241213    gcc-14.2.0
powerpc64            randconfig-003-20241213    gcc-14.2.0
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20241213    gcc-14.2.0
riscv                randconfig-002-20241213    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-20
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20241213    gcc-14.2.0
s390                 randconfig-002-20241213    clang-19
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20241213    gcc-14.2.0
sh                   randconfig-002-20241213    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20241213    gcc-14.2.0
sparc                randconfig-002-20241213    gcc-14.2.0
sparc64              randconfig-001-20241213    gcc-14.2.0
sparc64              randconfig-002-20241213    gcc-14.2.0
um                               allnoconfig    clang-18
um                   randconfig-001-20241213    gcc-12
um                   randconfig-002-20241213    clang-16
x86_64     buildonly-randconfig-001-20241213    gcc-12
x86_64     buildonly-randconfig-002-20241213    gcc-12
x86_64     buildonly-randconfig-003-20241213    gcc-12
x86_64     buildonly-randconfig-004-20241213    gcc-12
x86_64     buildonly-randconfig-005-20241213    gcc-12
x86_64     buildonly-randconfig-006-20241213    clang-19
xtensa               randconfig-001-20241213    gcc-14.2.0
xtensa               randconfig-002-20241213    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

