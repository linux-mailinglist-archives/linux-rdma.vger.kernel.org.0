Return-Path: <linux-rdma+bounces-6733-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0749FC32F
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Dec 2024 02:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C291883555
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Dec 2024 01:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6B0D2FB;
	Wed, 25 Dec 2024 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S8/7u9Nq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164928BE8
	for <linux-rdma@vger.kernel.org>; Wed, 25 Dec 2024 01:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735091442; cv=none; b=s9kvtRPLaKBl8MQ3C/xgTaUaoD/H5s2DyZO78qnL1zuTBixGCQXpKDh6rx99D5n+0rAWjqms7pZgTISJ2wvL529rTu2KU+IFnUsyJ8ABF9+TO3VEMwjCWdjipHt7gsTBAUSngxloSSK7VcWcnJ0IZ5KBX1mfCDBrAdE55biV+Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735091442; c=relaxed/simple;
	bh=8xrdd55oAvh61kC4tKkwZyM60GJ1QlSvLPE3PerNh6U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DmhbeiTx66B8Mq8MC/MkZ7S1ml3NNDMop4sM+8CdQMPmqWylplZvhfXwadqhqNuOdsRXmo7q+BV2p/Swepaf5ajmlUt0niBITjisaePd9U227XxER2yHRmgoCmFUDBEic0Ni/2MxnXvRlAypI99QuSUefdFqaiRbjUngBn/isBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S8/7u9Nq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735091440; x=1766627440;
  h=date:from:to:cc:subject:message-id;
  bh=8xrdd55oAvh61kC4tKkwZyM60GJ1QlSvLPE3PerNh6U=;
  b=S8/7u9NqFyc5mMeL7zEKacbm44B32hPd+4G1PUuG041AfPEpd6+bmQ8S
   GPuuSlXlr+bg78QVVHEKsJHuHik0m83xfi/rl7nWri/x0tOPwhsZZuIox
   X6/16l8ZDpwWSfg/s2VsNBS3GjTecfBWliHmSegNZU/QZi1bU6nDeWo1Q
   qo3Z2NHBagl8rvfD9gNrDSlR7lApDxnNkUhYs6jZoiccwEaBEGscZ6xNF
   5bIkCnQwlkDVVLwv+R7qNA8EBhy3HXXHAFOM1mwwqeqZF0X4la4bExYdI
   96dtzwmleQXDbqy+BBbXRKZSY2NbNF/ThjvxpGQ6NJyh6Z+nyOKpSLt65
   g==;
X-CSE-ConnectionGUID: W5nq7xo3TVaCVbHD76x9FQ==
X-CSE-MsgGUID: fqW2G58OS0iNobEoFe6v8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="52956408"
X-IronPort-AV: E=Sophos;i="6.12,261,1728975600"; 
   d="scan'208";a="52956408"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 17:50:39 -0800
X-CSE-ConnectionGUID: vG5AdGbNQ2KwpWzTiVTuUA==
X-CSE-MsgGUID: l3k41ysXSG2trzU7dB0hWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,261,1728975600"; 
   d="scan'208";a="99826360"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 24 Dec 2024 17:50:38 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tQGXk-0001ah-04;
	Wed, 25 Dec 2024 01:50:36 +0000
Date: Wed, 25 Dec 2024 09:49:44 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 2ac5415022d16d63d912a39a06f32f1f51140261
Message-ID: <202412250938.wU0lYKUg-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: 2ac5415022d16d63d912a39a06f32f1f51140261  RDMA/rxe: Remove the direct link to net_device

elapsed time: 919m

configs tested: 142
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20241224    gcc-13.2.0
arc                   randconfig-002-20241224    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20241224    gcc-14.2.0
arm                   randconfig-002-20241224    gcc-14.2.0
arm                   randconfig-003-20241224    clang-19
arm                   randconfig-004-20241224    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241224    gcc-14.2.0
arm64                 randconfig-002-20241224    clang-20
arm64                 randconfig-003-20241224    gcc-14.2.0
arm64                 randconfig-004-20241224    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241224    gcc-14.2.0
csky                  randconfig-001-20241225    gcc-14.2.0
csky                  randconfig-002-20241224    gcc-14.2.0
csky                  randconfig-002-20241225    gcc-14.2.0
hexagon                          alldefconfig    clang-15
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20241224    clang-20
hexagon               randconfig-001-20241225    clang-20
hexagon               randconfig-002-20241224    clang-20
hexagon               randconfig-002-20241225    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241224    clang-19
i386        buildonly-randconfig-002-20241224    gcc-12
i386        buildonly-randconfig-003-20241224    clang-19
i386        buildonly-randconfig-004-20241224    clang-19
i386        buildonly-randconfig-005-20241224    clang-19
i386        buildonly-randconfig-006-20241224    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241224    gcc-14.2.0
loongarch             randconfig-001-20241225    gcc-14.2.0
loongarch             randconfig-002-20241224    gcc-14.2.0
loongarch             randconfig-002-20241225    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                            mac_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip28_defconfig    gcc-14.2.0
mips                        omega2p_defconfig    clang-16
mips                       rbtx49xx_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241224    gcc-14.2.0
nios2                 randconfig-001-20241225    gcc-14.2.0
nios2                 randconfig-002-20241224    gcc-14.2.0
nios2                 randconfig-002-20241225    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241224    gcc-14.2.0
parisc                randconfig-001-20241225    gcc-14.2.0
parisc                randconfig-002-20241224    gcc-14.2.0
parisc                randconfig-002-20241225    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                      pasemi_defconfig    clang-20
powerpc                      ppc44x_defconfig    clang-20
powerpc                         ps3_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241224    clang-15
powerpc               randconfig-001-20241225    gcc-14.2.0
powerpc               randconfig-002-20241224    clang-20
powerpc               randconfig-002-20241225    clang-20
powerpc               randconfig-003-20241224    gcc-14.2.0
powerpc               randconfig-003-20241225    gcc-14.2.0
powerpc                         wii_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241224    clang-20
powerpc64             randconfig-001-20241225    gcc-14.2.0
powerpc64             randconfig-002-20241224    clang-20
powerpc64             randconfig-002-20241225    clang-16
powerpc64             randconfig-003-20241224    clang-20
powerpc64             randconfig-003-20241225    clang-18
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20241224    clang-17
riscv                 randconfig-002-20241224    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20241224    gcc-14.2.0
s390                  randconfig-002-20241224    gcc-14.2.0
sh                               alldefconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20241224    gcc-14.2.0
sh                    randconfig-002-20241224    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241224    gcc-14.2.0
sparc                 randconfig-002-20241224    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241224    gcc-14.2.0
sparc64               randconfig-002-20241224    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241224    gcc-12
um                    randconfig-002-20241224    clang-15
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241224    clang-19
x86_64      buildonly-randconfig-002-20241224    gcc-12
x86_64      buildonly-randconfig-003-20241224    gcc-12
x86_64      buildonly-randconfig-004-20241224    clang-19
x86_64      buildonly-randconfig-005-20241224    gcc-11
x86_64      buildonly-randconfig-006-20241224    gcc-11
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                generic_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20241224    gcc-14.2.0
xtensa                randconfig-002-20241224    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

