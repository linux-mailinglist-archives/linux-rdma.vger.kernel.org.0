Return-Path: <linux-rdma+bounces-4652-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7A796546E
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 03:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46996285558
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 01:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C78125D5;
	Fri, 30 Aug 2024 01:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RzxgttTp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90CB1D12EE
	for <linux-rdma@vger.kernel.org>; Fri, 30 Aug 2024 01:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724980127; cv=none; b=Dsk59wLaLVuSLdmNmL27UIZOK1mPRkyIU2k6w3t0B+Bnr4Yq2O7LOX8inLgWkvl7/oWEp8tR6ArYGcMMVm7yBFWgAIPtaEHXqa6IAOHMMayw2+fwcAmSziH4E9vKs0ktQMH49B8T/33DIEf7SLky62Z5sXDZGfvRsWjWSZZBHnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724980127; c=relaxed/simple;
	bh=onr1bGpCZeNIL5GbaDlhT8K7iaFYQ21BhpmlOWlyByk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HD5uQVyktAYPPwvVgzysBBKQZlzntZL5bcH7ZGnMRaiSytUlvF3XWN92flmTjttejqsgOGd/wgY7E2izMMtSIMQms2PkiS8qo0uQx5hsLH/m3KYXHP6bCyQ27m5ox8BPLKKYxRhUZ0yJa42kqzF2Nhnl7R/btXgM3Hll6VbbkWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RzxgttTp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724980125; x=1756516125;
  h=date:from:to:cc:subject:message-id;
  bh=onr1bGpCZeNIL5GbaDlhT8K7iaFYQ21BhpmlOWlyByk=;
  b=RzxgttTpN+Zn9yjOj+6nBCnNWLlPpTQLwJ3AYaeNVrMz+/xoe3pL3/UL
   EEtGpp+A+PoQf1MHP0vc5hCocwP1dkWpjlpBD+j3kSifPtHQvpuJOqLeC
   Jak7hMLATN3WdFqKhtest1t5/AWgX58SqdrNFYukzNBOhAPjzEe2Lm/KB
   Xze7cKoTwsjBVRrBY/m/MP/9TwNEBjbkSaB+HZoan5SfuXN1z4z1atQkJ
   cSSKJLwt0Nzwe0/ztmDXbRFF3iF/JK1WzkpTJBezVGseNg/Z9VNhmZo48
   8uSP7oQdNhpnyGwbELnLsZYoXbETcRJPJSV/Ua19dVGwzBuNa5fWDi2jb
   w==;
X-CSE-ConnectionGUID: CgxU8sKpSM6lijKGJuWS7w==
X-CSE-MsgGUID: WSxshaujSuysUGYsfbTp/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23775453"
X-IronPort-AV: E=Sophos;i="6.10,187,1719903600"; 
   d="scan'208";a="23775453"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 18:08:45 -0700
X-CSE-ConnectionGUID: gyW/CuaXT+Wq/+HpLuR4Xg==
X-CSE-MsgGUID: R/k064BZSImMGjnbXfBcAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,187,1719903600"; 
   d="scan'208";a="63598887"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 29 Aug 2024 18:08:44 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjq81-0000qb-03;
	Fri, 30 Aug 2024 01:08:41 +0000
Date: Fri, 30 Aug 2024 09:08:34 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 2d10b05bcef685572ce8962ecb0936952915d954
Message-ID: <202408300931.g7e8dVHF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 2d10b05bcef685572ce8962ecb0936952915d954  RDMA/cxgb4: Remove unused declarations

elapsed time: 2180m

configs tested: 176
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arc                   randconfig-001-20240829   gcc-14.1.0
arc                   randconfig-002-20240829   gcc-14.1.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                        multi_v5_defconfig   gcc-14.1.0
arm                   randconfig-001-20240829   gcc-14.1.0
arm                   randconfig-002-20240829   gcc-14.1.0
arm                   randconfig-003-20240829   gcc-14.1.0
arm                   randconfig-004-20240829   gcc-14.1.0
arm                         wpcm450_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                            allyesconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240829   gcc-14.1.0
arm64                 randconfig-002-20240829   gcc-14.1.0
arm64                 randconfig-003-20240829   gcc-14.1.0
arm64                 randconfig-004-20240829   gcc-14.1.0
csky                             allmodconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                             allyesconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240829   gcc-14.1.0
csky                  randconfig-002-20240829   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
hexagon               randconfig-001-20240829   gcc-14.1.0
hexagon               randconfig-002-20240829   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240829   clang-18
i386         buildonly-randconfig-002-20240829   clang-18
i386         buildonly-randconfig-003-20240829   clang-18
i386         buildonly-randconfig-004-20240829   clang-18
i386         buildonly-randconfig-005-20240829   clang-18
i386         buildonly-randconfig-006-20240829   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240829   clang-18
i386                  randconfig-002-20240829   clang-18
i386                  randconfig-003-20240829   clang-18
i386                  randconfig-004-20240829   clang-18
i386                  randconfig-005-20240829   clang-18
i386                  randconfig-006-20240829   clang-18
i386                  randconfig-011-20240829   clang-18
i386                  randconfig-012-20240829   clang-18
i386                  randconfig-013-20240829   clang-18
i386                  randconfig-014-20240829   clang-18
i386                  randconfig-015-20240829   clang-18
i386                  randconfig-016-20240829   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                        allyesconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240829   gcc-14.1.0
loongarch             randconfig-002-20240829   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          amiga_defconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                       m5475evb_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                             allmodconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                             allyesconfig   gcc-14.1.0
mips                         cobalt_defconfig   gcc-14.1.0
mips                           ip28_defconfig   gcc-14.1.0
mips                       rbtx49xx_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240829   gcc-14.1.0
nios2                 randconfig-002-20240829   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc                randconfig-001-20240829   gcc-14.1.0
parisc                randconfig-002-20240829   gcc-14.1.0
parisc64                            defconfig   gcc-14.1.0
powerpc                     akebono_defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                 canyonlands_defconfig   gcc-14.1.0
powerpc                       ebony_defconfig   gcc-14.1.0
powerpc                        icon_defconfig   gcc-14.1.0
powerpc                     rainier_defconfig   gcc-14.1.0
powerpc               randconfig-001-20240829   gcc-14.1.0
powerpc               randconfig-002-20240829   gcc-14.1.0
powerpc               randconfig-003-20240829   gcc-14.1.0
powerpc64             randconfig-001-20240829   gcc-14.1.0
powerpc64             randconfig-002-20240829   gcc-14.1.0
powerpc64             randconfig-003-20240829   gcc-14.1.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
riscv                 randconfig-001-20240829   gcc-14.1.0
riscv                 randconfig-002-20240829   gcc-14.1.0
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                  randconfig-001-20240829   gcc-14.1.0
s390                  randconfig-002-20240829   gcc-14.1.0
sh                               alldefconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                    randconfig-001-20240829   gcc-14.1.0
sh                    randconfig-002-20240829   gcc-14.1.0
sh                          rsk7203_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
sparc64               randconfig-001-20240829   gcc-14.1.0
sparc64               randconfig-002-20240829   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240829   gcc-14.1.0
um                    randconfig-002-20240829   gcc-14.1.0
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240829   clang-18
x86_64       buildonly-randconfig-002-20240829   clang-18
x86_64       buildonly-randconfig-003-20240829   clang-18
x86_64       buildonly-randconfig-004-20240829   clang-18
x86_64       buildonly-randconfig-005-20240829   clang-18
x86_64       buildonly-randconfig-006-20240829   clang-18
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                randconfig-001-20240829   clang-18
x86_64                randconfig-002-20240829   clang-18
x86_64                randconfig-003-20240829   clang-18
x86_64                randconfig-004-20240829   clang-18
x86_64                randconfig-005-20240829   clang-18
x86_64                randconfig-006-20240829   clang-18
x86_64                randconfig-011-20240829   clang-18
x86_64                randconfig-012-20240829   clang-18
x86_64                randconfig-013-20240829   clang-18
x86_64                randconfig-014-20240829   clang-18
x86_64                randconfig-015-20240829   clang-18
x86_64                randconfig-016-20240829   clang-18
x86_64                randconfig-071-20240829   clang-18
x86_64                randconfig-072-20240829   clang-18
x86_64                randconfig-073-20240829   clang-18
x86_64                randconfig-074-20240829   clang-18
x86_64                randconfig-075-20240829   clang-18
x86_64                randconfig-076-20240829   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240829   gcc-14.1.0
xtensa                randconfig-002-20240829   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

