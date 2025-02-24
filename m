Return-Path: <linux-rdma+bounces-8028-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CAEA416AF
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2025 08:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51DB01893E1E
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2025 07:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374E11D8E01;
	Mon, 24 Feb 2025 07:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OC/RdXQH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F3218B464
	for <linux-rdma@vger.kernel.org>; Mon, 24 Feb 2025 07:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740383477; cv=none; b=W4BtuBu7MgInEpTmBJV67VUD2THTKpb6J6jubJy7fXvQyb1Rfy0I8B6mkHgGc/F9uuLlbyWFDu1IrNddisGfC2QXQRmpwh5V6U1peV7ZghYwb5xoyB/YicNVleVYdPseuXao08TZvgbJD+4YOsSHxnJTMRkAu+3L1ElVEkG3S24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740383477; c=relaxed/simple;
	bh=mIw+aNu4XNEcrrnnHjrKudGrTc8ITon7JNLYHgb3VL8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QmhlVUEqqsdJx0H150anUMtqupU/6Uq8xnQdbF7aCbEycDZhVln7IUoYg13NyPuuzM91d6hn8ND4W37ZfkjXZ2w5+g3rjvsgl/mIH/CjyPKY3ydTsO1U98wsiDIEITVPz4OgdZ8Ct/6zjr+EkHWKdu+kuBBMsWhlzi64iT7xH5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OC/RdXQH; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740383475; x=1771919475;
  h=date:from:to:cc:subject:message-id;
  bh=mIw+aNu4XNEcrrnnHjrKudGrTc8ITon7JNLYHgb3VL8=;
  b=OC/RdXQHLc3Dwy+GQQY+KN1s4+R9aao+skektIeJdyoovTKXnTdWo+P1
   QEiVwIZD8eJV01QkA/UUjD8uAAqZwa3npWuC6nfBYNg0uyc/fR8EfYLug
   HbOmlmjOmp1xQRMq57vW/IwAmjHY0vQDjzVqLLXJ2Zp/MxoHybbSsboIj
   3GMWEostLK4SMAxTuIA1rkp2zFz4lfjZC9SXl5oj0wHS5BO6CcLQ1hgqK
   a8Pkr2Jey8nUFRM7uezExRokCop0LqgEJJd/RbCB0Tlzt6ZPQ/mjVP5t/
   CkBqq/Reoh6QzQDHn5HxAGddmYNcmmOuk4T2vekIrTUNkMAUr4foVQbiR
   Q==;
X-CSE-ConnectionGUID: IaKqv7ubSGOojciKIdGWtQ==
X-CSE-MsgGUID: 54B71LNWRj6D6yI/WQld8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="58544376"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="58544376"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 23:51:14 -0800
X-CSE-ConnectionGUID: /lIk80lyRMCJ+ZQMB3Dy4Q==
X-CSE-MsgGUID: AyzFR9IwS6KqRUH+IXFqpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121252634"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 23 Feb 2025 23:51:11 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tmTF8-00080g-0v;
	Mon, 24 Feb 2025 07:51:10 +0000
Date: Mon, 24 Feb 2025 15:50:43 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 b66535356a4834a234f99e16a97eb51f2c6c5a7d
Message-ID: <202502241537.exHPhiMF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: b66535356a4834a234f99e16a97eb51f2c6c5a7d  RDMA/bnxt_re: Fix the page details for the srq created by kernel consumers

elapsed time: 1128m

configs tested: 169
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                          axs103_defconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20250223    gcc-13.2.0
arc                   randconfig-001-20250224    gcc-13.2.0
arc                   randconfig-002-20250223    gcc-13.2.0
arc                   randconfig-002-20250224    gcc-13.2.0
arm                              alldefconfig    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                      footbridge_defconfig    clang-17
arm                   randconfig-001-20250223    gcc-14.2.0
arm                   randconfig-001-20250224    gcc-14.2.0
arm                   randconfig-002-20250223    clang-21
arm                   randconfig-002-20250224    gcc-14.2.0
arm                   randconfig-003-20250223    clang-19
arm                   randconfig-003-20250224    gcc-14.2.0
arm                   randconfig-004-20250223    gcc-14.2.0
arm                   randconfig-004-20250224    gcc-14.2.0
arm                         socfpga_defconfig    gcc-14.2.0
arm                        vexpress_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250223    clang-21
arm64                 randconfig-001-20250224    gcc-14.2.0
arm64                 randconfig-002-20250223    gcc-14.2.0
arm64                 randconfig-002-20250224    clang-21
arm64                 randconfig-003-20250223    clang-21
arm64                 randconfig-003-20250224    gcc-14.2.0
arm64                 randconfig-004-20250223    clang-21
arm64                 randconfig-004-20250224    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250223    gcc-14.2.0
csky                  randconfig-001-20250224    gcc-14.2.0
csky                  randconfig-002-20250223    gcc-14.2.0
csky                  randconfig-002-20250224    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250223    clang-21
hexagon               randconfig-001-20250224    clang-21
hexagon               randconfig-002-20250223    clang-16
hexagon               randconfig-002-20250224    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250223    clang-19
i386        buildonly-randconfig-002-20250223    gcc-11
i386        buildonly-randconfig-003-20250223    gcc-12
i386        buildonly-randconfig-004-20250223    clang-19
i386        buildonly-randconfig-005-20250223    gcc-12
i386        buildonly-randconfig-006-20250223    gcc-11
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
loongarch             randconfig-001-20250223    gcc-14.2.0
loongarch             randconfig-001-20250224    gcc-14.2.0
loongarch             randconfig-002-20250223    gcc-14.2.0
loongarch             randconfig-002-20250224    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip22_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250223    gcc-14.2.0
nios2                 randconfig-001-20250224    gcc-14.2.0
nios2                 randconfig-002-20250223    gcc-14.2.0
nios2                 randconfig-002-20250224    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250223    gcc-14.2.0
parisc                randconfig-001-20250224    gcc-14.2.0
parisc                randconfig-002-20250223    gcc-14.2.0
parisc                randconfig-002-20250224    gcc-14.2.0
powerpc                     akebono_defconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                       holly_defconfig    clang-21
powerpc                  mpc866_ads_defconfig    clang-21
powerpc               randconfig-001-20250223    gcc-14.2.0
powerpc               randconfig-001-20250224    gcc-14.2.0
powerpc               randconfig-002-20250223    clang-17
powerpc               randconfig-002-20250224    gcc-14.2.0
powerpc               randconfig-003-20250223    gcc-14.2.0
powerpc               randconfig-003-20250224    gcc-14.2.0
powerpc                     tqm5200_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250223    gcc-14.2.0
powerpc64             randconfig-002-20250223    clang-21
powerpc64             randconfig-002-20250224    clang-18
powerpc64             randconfig-003-20250223    gcc-14.2.0
powerpc64             randconfig-003-20250224    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250223    clang-17
riscv                 randconfig-001-20250224    gcc-14.2.0
riscv                 randconfig-002-20250223    gcc-14.2.0
riscv                 randconfig-002-20250224    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                          debug_defconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250223    clang-18
s390                  randconfig-001-20250224    gcc-14.2.0
s390                  randconfig-002-20250223    clang-16
s390                  randconfig-002-20250224    clang-17
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                        edosk7760_defconfig    gcc-14.2.0
sh                          landisk_defconfig    gcc-14.2.0
sh                    randconfig-001-20250223    gcc-14.2.0
sh                    randconfig-001-20250224    gcc-14.2.0
sh                    randconfig-002-20250223    gcc-14.2.0
sh                    randconfig-002-20250224    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250223    gcc-14.2.0
sparc                 randconfig-001-20250224    gcc-14.2.0
sparc                 randconfig-002-20250223    gcc-14.2.0
sparc                 randconfig-002-20250224    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250223    gcc-14.2.0
sparc64               randconfig-001-20250224    gcc-14.2.0
sparc64               randconfig-002-20250223    gcc-14.2.0
sparc64               randconfig-002-20250224    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250223    clang-21
um                    randconfig-001-20250224    gcc-12
um                    randconfig-002-20250223    gcc-12
um                    randconfig-002-20250224    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250223    clang-19
x86_64      buildonly-randconfig-002-20250223    gcc-12
x86_64      buildonly-randconfig-003-20250223    gcc-12
x86_64      buildonly-randconfig-004-20250223    gcc-12
x86_64      buildonly-randconfig-005-20250223    gcc-12
x86_64      buildonly-randconfig-006-20250223    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250223    gcc-14.2.0
xtensa                randconfig-001-20250224    gcc-14.2.0
xtensa                randconfig-002-20250223    gcc-14.2.0
xtensa                randconfig-002-20250224    gcc-14.2.0
xtensa                    smp_lx200_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

