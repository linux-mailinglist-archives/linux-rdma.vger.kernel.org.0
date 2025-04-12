Return-Path: <linux-rdma+bounces-9388-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0433DA86EF3
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Apr 2025 20:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8171B7AD008
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Apr 2025 18:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743F721C9FF;
	Sat, 12 Apr 2025 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mIuwZ4DK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4F3219A86
	for <linux-rdma@vger.kernel.org>; Sat, 12 Apr 2025 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744483493; cv=none; b=d6EwoRYYHMqbeAvvbfE3lmA5MKQpQYRO8APTXH4Fz0hI8a6Xx0rP4VCtsZWnSS3j8wpctgXpVnHRbC1IUlOXYpdag90HSgEXhH3cZDY9nx7WZt8MpZrkjHV6QAOOWnMiYm3NLX62VaM1PMMJygdkTl3zBdN2CNV4J0WHypCpVsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744483493; c=relaxed/simple;
	bh=OfXsulzrcuMY+QXDNwgPX9X7ebWRuZGEwxnbDJsaMSk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EfR8NGVf1iBv/FBiAo4gnb43j5mliSh/dpsMKC8ZPN5wOYXj89f+PMxPLqtnzZzBB/gCIhh6reC13rLO0ZuWbTS6XoJ8jQ/R9PnX+uVU2FrUI7kOEPLfkoyiT2LJp5Plq9PJ31vOa0jR8pW/95YHWAXjqpsFgG2L3lS53ShJ3Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mIuwZ4DK; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744483491; x=1776019491;
  h=date:from:to:cc:subject:message-id;
  bh=OfXsulzrcuMY+QXDNwgPX9X7ebWRuZGEwxnbDJsaMSk=;
  b=mIuwZ4DKW6ibz/uoocxHunp1tkgdZCXxtYogzBLDJglu/3OCjQdHBItw
   CPKLhdzUXJ+mF11N9MrNq/dkIVyrSVE0XLnDXP/e7CW9/mmFXla1pqIBD
   qYM0+bvAIB2smdYX/OVBESOTDbYIWJWvL7YVavZWpY8BvfFiWGEAeifnE
   3VE7Grc5gwehg4aB34PHmwGCYjwdmDETYplMfHZhmscc6WyuOzrC/qBCi
   hA48dcssE8TunoPdPi9tiduhJqiAVk8mhwn0I5j3BuVnZO6G8P2kfdM5j
   13Rj3YdoJZbgcyqisYDfrSplNLtUIchklDUjajDNGdfHoRTNSggXU+iu/
   w==;
X-CSE-ConnectionGUID: RGvX+uy2Qfuv+uOlOgrQPw==
X-CSE-MsgGUID: aVCk2NaJQNyKvv95p3OgbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="56670049"
X-IronPort-AV: E=Sophos;i="6.15,208,1739865600"; 
   d="scan'208";a="56670049"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2025 11:44:48 -0700
X-CSE-ConnectionGUID: 8fr5ivvoSs6svpWkV+AM4g==
X-CSE-MsgGUID: MpxZfKorRAer38ic9fAnTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,208,1739865600"; 
   d="scan'208";a="134552687"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 12 Apr 2025 11:44:47 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u3fqP-000C29-18;
	Sat, 12 Apr 2025 18:44:45 +0000
Date: Sun, 13 Apr 2025 02:44:28 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 ffe1cee21f8b533ae27c3a31bfa56b8c1b27fa6e
Message-ID: <202504130222.TNTTIVkD-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: ffe1cee21f8b533ae27c3a31bfa56b8c1b27fa6e  RDMA/hns: initialize db in update_srq_db()

elapsed time: 1446m

configs tested: 81
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250412    gcc-14.2.0
arc                   randconfig-002-20250412    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                            dove_defconfig    gcc-14.2.0
arm                   randconfig-001-20250412    clang-21
arm                   randconfig-002-20250412    gcc-7.5.0
arm                   randconfig-003-20250412    clang-21
arm                   randconfig-004-20250412    clang-21
arm64                 randconfig-001-20250412    clang-21
arm64                 randconfig-002-20250412    clang-21
arm64                 randconfig-003-20250412    gcc-8.5.0
arm64                 randconfig-004-20250412    clang-21
csky                  randconfig-001-20250412    gcc-14.2.0
csky                  randconfig-002-20250412    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250412    clang-21
hexagon               randconfig-002-20250412    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250412    clang-20
i386        buildonly-randconfig-002-20250412    clang-20
i386        buildonly-randconfig-003-20250412    clang-20
i386        buildonly-randconfig-004-20250412    clang-20
i386        buildonly-randconfig-005-20250412    clang-20
i386        buildonly-randconfig-006-20250412    gcc-11
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch             randconfig-001-20250412    gcc-14.2.0
loongarch             randconfig-002-20250412    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
nios2                 randconfig-001-20250412    gcc-8.5.0
nios2                 randconfig-002-20250412    gcc-10.5.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                           alldefconfig    gcc-14.2.0
parisc                randconfig-001-20250412    gcc-7.5.0
parisc                randconfig-002-20250412    gcc-9.3.0
powerpc               randconfig-001-20250412    clang-18
powerpc               randconfig-002-20250412    clang-21
powerpc               randconfig-003-20250412    clang-18
powerpc64             randconfig-001-20250412    clang-21
powerpc64             randconfig-002-20250412    clang-21
powerpc64             randconfig-003-20250412    clang-21
riscv                 randconfig-001-20250412    clang-20
riscv                 randconfig-002-20250412    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250412    clang-18
s390                  randconfig-002-20250412    gcc-9.3.0
s390                  randconfig-002-20250413    gcc-8.5.0
sh                               allmodconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250412    gcc-14.2.0
sh                    randconfig-002-20250412    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                 randconfig-001-20250412    gcc-10.3.0
sparc                 randconfig-002-20250412    gcc-13.3.0
sparc64               randconfig-001-20250412    gcc-13.3.0
sparc64               randconfig-002-20250412    gcc-5.5.0
um                               allmodconfig    clang-19
um                               allyesconfig    gcc-12
um                    randconfig-001-20250412    gcc-12
um                    randconfig-002-20250412    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250412    gcc-12
x86_64      buildonly-randconfig-002-20250412    clang-20
x86_64      buildonly-randconfig-003-20250412    gcc-11
x86_64      buildonly-randconfig-004-20250412    clang-20
x86_64      buildonly-randconfig-005-20250412    clang-20
x86_64      buildonly-randconfig-006-20250412    clang-20
x86_64                              defconfig    gcc-11
xtensa                randconfig-001-20250412    gcc-14.2.0
xtensa                randconfig-002-20250412    gcc-13.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

