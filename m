Return-Path: <linux-rdma+bounces-13543-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C4CB8EC87
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 04:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8638177ED9
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 02:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBE114A60F;
	Mon, 22 Sep 2025 02:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A4jMlzvb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909E12BD03
	for <linux-rdma@vger.kernel.org>; Mon, 22 Sep 2025 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758508544; cv=none; b=BMK8v+samzdaD8kk9yJ4rSVp4D+A66n+L078lEDtOMwnkhmUqOHUh0JNTdt920KfcH6mE2C5y4oIMeeGqzf1zdV4BPAwbEea0yp7jq9pe4Cj133vJ5qm9uSigNTGsrPEgpLRH8ZHCtbnRFhprJXgm7vBZvTIiG0AarXX5BVE2E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758508544; c=relaxed/simple;
	bh=svR57wPdUJit098xtM1hW43Jn2RHSfyCFU53BKgHk7w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qevVEWDRQEDIA3OYEb5KsMDFN9NElTyUszLjP1/iDCaNp+C+9U2hQgdJO5d+NlrxXn055tZx57z68/7Cf20ZNll7UHOO3i/406SOb4Y8NlicVu/UNATBD6msVv5gnZNy3/RcVCqOFWD3L1678BiAQIMjTy4/hvlzbVrhg0B8xNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A4jMlzvb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758508543; x=1790044543;
  h=date:from:to:cc:subject:message-id;
  bh=svR57wPdUJit098xtM1hW43Jn2RHSfyCFU53BKgHk7w=;
  b=A4jMlzvbGv4/wMaHTCJsDEdpPivGcnUIPGqmnVajE/Mho+RV4NNhX6F9
   NwV49ffuXpURIr815AhfXt0cbO4GoXqUoZJhF42afZCXWBgHN3dF96uVr
   w4rQ3POMdMrGnRg4rxGnDc+v2GLX9yU4yxLbTmihH8vNVi/wGOi2avx5I
   iqrmIuAeO5I7WrbRUThZa3twMaR3TTFHsuNJ6CWrAb+wndfM1MNraiRMx
   +SOcSPx9QtX3oyMT6shcJSOVJ7SRmAf1TKzbaPRgALgq5LcaGNBBR6jDu
   8i+C+eanN30/jrMusV4dpC+yIxu/oFz6sSHy+ggrvIqfRuRYGIiDRX76K
   w==;
X-CSE-ConnectionGUID: 0XVI3Nm1SfGS+2YH/akhDA==
X-CSE-MsgGUID: iBuGzaXZTGeoNdhmdCyvWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11560"; a="60461456"
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; 
   d="scan'208";a="60461456"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 19:35:42 -0700
X-CSE-ConnectionGUID: jTAYiMAxSHa9KV0j9N9Jaw==
X-CSE-MsgGUID: U+cuOUK3Q8yDadiS6jIjIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; 
   d="scan'208";a="177154876"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 21 Sep 2025 19:35:40 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0WOi-0001Gj-2b;
	Mon, 22 Sep 2025 02:35:28 +0000
Date: Mon, 22 Sep 2025 10:34:39 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 9b9e32f75aa3d257e3ee3ab0a0f9ad5fbfb298af
Message-ID: <202509221026.eRtdILar-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 9b9e32f75aa3d257e3ee3ab0a0f9ad5fbfb298af  RDMA/bnxt_re: Fix incorrect errno used in function comments

elapsed time: 791m

configs tested: 142
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                     haps_hs_smp_defconfig    gcc-15.1.0
arc                            hsdk_defconfig    gcc-15.1.0
arc                   randconfig-001-20250921    gcc-14.3.0
arc                   randconfig-002-20250921    gcc-12.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                          gemini_defconfig    clang-20
arm                   randconfig-001-20250921    gcc-11.5.0
arm                   randconfig-002-20250921    clang-16
arm                   randconfig-003-20250921    gcc-8.5.0
arm                   randconfig-004-20250921    clang-22
arm                         s3c6400_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250921    clang-22
arm64                 randconfig-002-20250921    gcc-8.5.0
arm64                 randconfig-003-20250921    clang-22
arm64                 randconfig-004-20250921    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250921    gcc-9.5.0
csky                  randconfig-001-20250922    gcc-15.1.0
csky                  randconfig-002-20250921    gcc-15.1.0
csky                  randconfig-002-20250922    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250921    clang-20
hexagon               randconfig-001-20250922    clang-20
hexagon               randconfig-002-20250921    clang-22
hexagon               randconfig-002-20250922    clang-19
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250921    gcc-14
i386        buildonly-randconfig-002-20250921    clang-20
i386        buildonly-randconfig-003-20250921    gcc-12
i386        buildonly-randconfig-004-20250921    gcc-14
i386        buildonly-randconfig-005-20250921    gcc-14
i386        buildonly-randconfig-006-20250921    gcc-14
i386                                defconfig    clang-20
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250921    clang-18
loongarch             randconfig-001-20250922    clang-22
loongarch             randconfig-002-20250921    clang-18
loongarch             randconfig-002-20250922    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250921    gcc-8.5.0
nios2                 randconfig-001-20250922    gcc-11.5.0
nios2                 randconfig-002-20250921    gcc-8.5.0
nios2                 randconfig-002-20250922    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250921    gcc-8.5.0
parisc                randconfig-001-20250922    gcc-8.5.0
parisc                randconfig-002-20250921    gcc-8.5.0
parisc                randconfig-002-20250922    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                      cm5200_defconfig    clang-22
powerpc                    ge_imp3a_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250921    gcc-12.5.0
powerpc               randconfig-001-20250922    clang-22
powerpc               randconfig-002-20250921    gcc-8.5.0
powerpc               randconfig-002-20250922    gcc-12.5.0
powerpc               randconfig-003-20250921    clang-22
powerpc               randconfig-003-20250922    clang-17
powerpc64             randconfig-002-20250921    gcc-15.1.0
powerpc64             randconfig-002-20250922    clang-20
powerpc64             randconfig-003-20250921    clang-22
powerpc64             randconfig-003-20250922    clang-17
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250921    clang-22
riscv                 randconfig-002-20250921    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250921    clang-20
s390                  randconfig-002-20250921    clang-22
sh                               alldefconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250921    gcc-15.1.0
sh                    randconfig-002-20250921    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250921    gcc-13.4.0
sparc                 randconfig-002-20250921    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250921    clang-22
sparc64               randconfig-002-20250921    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250921    gcc-14
um                    randconfig-002-20250921    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250921    clang-20
x86_64      buildonly-randconfig-002-20250921    clang-20
x86_64      buildonly-randconfig-003-20250921    clang-20
x86_64      buildonly-randconfig-004-20250921    gcc-14
x86_64      buildonly-randconfig-005-20250921    clang-20
x86_64      buildonly-randconfig-006-20250921    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250921    gcc-12.5.0
xtensa                randconfig-002-20250921    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

