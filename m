Return-Path: <linux-rdma+bounces-7614-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7F3A2E178
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 00:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07763A39E2
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Feb 2025 23:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B9E1E25E7;
	Sun,  9 Feb 2025 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZuSgjvLE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA9C1E04B5
	for <linux-rdma@vger.kernel.org>; Sun,  9 Feb 2025 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739143916; cv=none; b=rXjnR5XT949JwNRqAzZZOEliFn91kS15TKVyrv5MyD8pnoZWNnhX7/Ma/dQAK+jYMBmapP6I3D2aw4P7xxz11lde1N4AFpgcYSsyLQ6JpQIMVX5diAVvOeF4b/2xidJPPqZFSram9bLztC5JLrUEfIVOijKjwoHqUiC/UTKpp+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739143916; c=relaxed/simple;
	bh=1DX61SZta/bDFpQLGUnSMJPGiCvC2bOP/8VrrRohGb8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Bt28gAALIEKiHX3zQ6dXrmcBnXrN9K4Z17bUpB4ymm5z0gs4ClOpeov+XZFTqU9AQvk5rM0qprIPD/SE5IJ5D9XwvFfU85fngGaAZma2XELixRlYCxS5Dv9Yq2OmbEUcCF1jSX/SluZ+P8noyQvbAEYA4Ko1bJoITQhRrDm2GQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZuSgjvLE; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739143914; x=1770679914;
  h=date:from:to:cc:subject:message-id;
  bh=1DX61SZta/bDFpQLGUnSMJPGiCvC2bOP/8VrrRohGb8=;
  b=ZuSgjvLE5zY8jfTIOfioardDOa9ac83IjBTF6JxyizlzLckXjFDH2tGa
   ui/7TowxnuJNhOlGVVxQRh/z/ApH26indRYv764J5HbKM6XDiCZ4sIf86
   LhCOPC08tn5ftYOqxLlsphlEqCgeO5QscHfF2oGVG0zIFBEL2oYT+kLd5
   eiUo3NMyHHUOxZcHeoRu8HpwrYZv7TyZnTosxRpY6dF0NZI5GIxaQmpIQ
   8YLgLNwUvhpjXAJWXC4P2cWj+llEF+deigAznhywjJGahIyZOfRtvLglf
   AjkK0xjIfC+9zao4KJ+DiPoBMQ/Gc7T3zW288+ma4jdA6kBTUvYHBsi+H
   Q==;
X-CSE-ConnectionGUID: Cly4sfLOTU6KBakH4StepQ==
X-CSE-MsgGUID: RB/ovmYTQQ69YgakXsnhuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="50354918"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="50354918"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 15:31:53 -0800
X-CSE-ConnectionGUID: ZH48zl+XTxa+VzovIuqsBQ==
X-CSE-MsgGUID: PfAFuAA/TQKzBVAFVS1V8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116636535"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 09 Feb 2025 15:31:52 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1thGmD-00121V-2Y;
	Sun, 09 Feb 2025 23:31:49 +0000
Date: Mon, 10 Feb 2025 07:31:22 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 9747c0c7791d4a5a62018a0c9c563dd2e6f6c1c0
Message-ID: <202502100715.KfavypM9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: 9747c0c7791d4a5a62018a0c9c563dd2e6f6c1c0  RDMA/hns: Fix mbox timing out by adding retry mechanism

elapsed time: 781m

configs tested: 138
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                      axs103_smp_defconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20250209    gcc-13.2.0
arc                   randconfig-002-20250209    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-21
arm                           imxrt_defconfig    clang-19
arm                   randconfig-001-20250209    gcc-14.2.0
arm                   randconfig-002-20250209    clang-21
arm                   randconfig-003-20250209    clang-21
arm                   randconfig-004-20250209    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250209    clang-18
arm64                 randconfig-002-20250209    gcc-14.2.0
arm64                 randconfig-003-20250209    gcc-14.2.0
arm64                 randconfig-004-20250209    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250209    gcc-14.2.0
csky                  randconfig-002-20250209    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250209    clang-21
hexagon               randconfig-002-20250209    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250209    gcc-12
i386        buildonly-randconfig-002-20250209    clang-19
i386        buildonly-randconfig-003-20250209    clang-19
i386        buildonly-randconfig-004-20250209    gcc-12
i386        buildonly-randconfig-005-20250209    clang-19
i386        buildonly-randconfig-006-20250209    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250209    gcc-14.2.0
loongarch             randconfig-002-20250209    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         amcore_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                            q40_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          eyeq5_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250209    gcc-14.2.0
nios2                 randconfig-002-20250209    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250209    gcc-14.2.0
parisc                randconfig-002-20250209    gcc-14.2.0
parisc64                         alldefconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                   currituck_defconfig    clang-17
powerpc                      katmai_defconfig    clang-18
powerpc                 mpc836x_rdk_defconfig    clang-18
powerpc               randconfig-001-20250209    gcc-14.2.0
powerpc               randconfig-002-20250209    clang-21
powerpc               randconfig-003-20250209    gcc-14.2.0
powerpc                     skiroot_defconfig    clang-21
powerpc                     tqm5200_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250209    gcc-14.2.0
powerpc64             randconfig-002-20250209    gcc-14.2.0
powerpc64             randconfig-003-20250209    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250209    clang-18
riscv                 randconfig-002-20250209    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250209    clang-21
s390                  randconfig-002-20250209    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250209    gcc-14.2.0
sh                    randconfig-002-20250209    gcc-14.2.0
sh                           se7343_defconfig    gcc-14.2.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250209    gcc-14.2.0
sparc                 randconfig-002-20250209    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250209    gcc-14.2.0
sparc64               randconfig-002-20250209    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250209    gcc-11
um                    randconfig-002-20250209    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250209    gcc-12
x86_64      buildonly-randconfig-002-20250209    gcc-12
x86_64      buildonly-randconfig-003-20250209    gcc-12
x86_64      buildonly-randconfig-004-20250209    gcc-12
x86_64      buildonly-randconfig-005-20250209    gcc-11
x86_64      buildonly-randconfig-006-20250209    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250209    gcc-14.2.0
xtensa                randconfig-002-20250209    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

