Return-Path: <linux-rdma+bounces-1720-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D88894860
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 02:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73BD91C22D9B
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 00:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B7C33C5;
	Tue,  2 Apr 2024 00:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PWAPykIV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E787D33F9
	for <linux-rdma@vger.kernel.org>; Tue,  2 Apr 2024 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712016948; cv=none; b=DFe4Ik5HjAkrHPq2ILfJBQajFjU8niXX1PErWCvveQVu3mAZF3vXA8Upf1hLuP/k7GdobFKDRJaBstQjppxKhE6wxWjRptBm/N1zKbIA+tE8TMRjT7czgHIrXHoY5tc+975yNhX6zXzcwk7nVoJdBoAs9TSI6IYg5U1NNGp1Udw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712016948; c=relaxed/simple;
	bh=5TnHYhVhr5OMCUmKi4NLVitfxatdD6ND5LcnopI/zIA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ptvMdtRaJ+SawjPKPei5Y5vPbmu8svZnh/w0kiTHbvjnDg7eIUc46VzGBz/nEIfp9Tu+xI5x4a0oFndAsysiGW/m6lRFHj2/VCkbDRlL8FJil6ND/ZV9EghyxZR61l57GKzVD6TCayleucDNnvxXISE5V4p/XCKw5MfbctRbjbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PWAPykIV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712016946; x=1743552946;
  h=date:from:to:cc:subject:message-id;
  bh=5TnHYhVhr5OMCUmKi4NLVitfxatdD6ND5LcnopI/zIA=;
  b=PWAPykIVpNoN29wuPpiADZICUIiUHVSmwnd9an0QCEd3FRiXu6+k03Tm
   JkLJ7k6H5QX23KJ20KZFY5+bQsgkbRB9NWM4buBgI2k2oWKnbG+VbJG21
   7Gnc1NV5W+jWqoTDMTMBS3AFXshGQlXMwRmuuQVhW56V76w3ALd1A8jQ3
   o3Ttw6AHcpHe46TpOSTJwbPKlKhJowawk0urj9jwnu3U09PF3waJ6/Fpk
   TdNe4M7y8V/BmwORBJtRsn1FdkWsYULSeDOvBbLRI/txaVuNFhYRv4A2S
   +0sNva/7IjniYwk60JwvUIBpBVLXj5JovUISwQ0JexdLv+XZB/NXZQByB
   w==;
X-CSE-ConnectionGUID: iaSAAKfMT5ajlHNIibtb2w==
X-CSE-MsgGUID: JKsLY8yBQWmMRCOotZyPlQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="24620759"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="24620759"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 17:15:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="17949750"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 01 Apr 2024 17:15:43 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rrRo8-0000g3-1P;
	Tue, 02 Apr 2024 00:15:30 +0000
Date: Tue, 02 Apr 2024 08:14:40 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 481047d7e8391d3842ae59025806531cdad710d9
Message-ID: <202404020838.KXiOGPpL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: 481047d7e8391d3842ae59025806531cdad710d9  RDMA/rxe: Fix the problem "mutex_destroy missing"

elapsed time: 721m

configs tested: 240
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20240401   gcc  
arc                   randconfig-001-20240402   gcc  
arc                   randconfig-002-20240401   gcc  
arc                   randconfig-002-20240402   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm                     davinci_all_defconfig   clang
arm                                 defconfig   clang
arm                          ixp4xx_defconfig   gcc  
arm                      jornada720_defconfig   clang
arm                        keystone_defconfig   gcc  
arm                        mvebu_v5_defconfig   gcc  
arm                   randconfig-001-20240401   clang
arm                   randconfig-001-20240402   gcc  
arm                   randconfig-002-20240401   clang
arm                   randconfig-003-20240401   gcc  
arm                   randconfig-004-20240401   gcc  
arm                          sp7021_defconfig   gcc  
arm                        spear6xx_defconfig   clang
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240401   gcc  
arm64                 randconfig-002-20240401   gcc  
arm64                 randconfig-003-20240401   gcc  
arm64                 randconfig-004-20240401   gcc  
arm64                 randconfig-004-20240402   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240401   gcc  
csky                  randconfig-001-20240402   gcc  
csky                  randconfig-002-20240401   gcc  
csky                  randconfig-002-20240402   gcc  
hexagon                          alldefconfig   clang
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240401   clang
hexagon               randconfig-002-20240401   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240401   gcc  
i386         buildonly-randconfig-002-20240401   clang
i386         buildonly-randconfig-003-20240401   clang
i386         buildonly-randconfig-004-20240401   gcc  
i386         buildonly-randconfig-005-20240401   gcc  
i386         buildonly-randconfig-006-20240401   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240401   gcc  
i386                  randconfig-002-20240401   gcc  
i386                  randconfig-003-20240401   clang
i386                  randconfig-004-20240401   clang
i386                  randconfig-005-20240401   gcc  
i386                  randconfig-006-20240401   gcc  
i386                  randconfig-011-20240401   clang
i386                  randconfig-012-20240401   clang
i386                  randconfig-013-20240401   gcc  
i386                  randconfig-014-20240401   gcc  
i386                  randconfig-015-20240401   gcc  
i386                  randconfig-016-20240401   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240401   gcc  
loongarch             randconfig-001-20240402   gcc  
loongarch             randconfig-002-20240401   gcc  
loongarch             randconfig-002-20240402   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                            mac_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   gcc  
mips                     cu1830-neo_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                     loongson2k_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                          malta_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240401   gcc  
nios2                 randconfig-001-20240402   gcc  
nios2                 randconfig-002-20240401   gcc  
nios2                 randconfig-002-20240402   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240401   gcc  
parisc                randconfig-001-20240402   gcc  
parisc                randconfig-002-20240401   gcc  
parisc                randconfig-002-20240402   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                      bamboo_defconfig   clang
powerpc                        cell_defconfig   gcc  
powerpc                      chrp32_defconfig   clang
powerpc                     ksi8560_defconfig   gcc  
powerpc                       maple_defconfig   clang
powerpc                     mpc5200_defconfig   clang
powerpc                     ppa8548_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20240401   gcc  
powerpc               randconfig-002-20240401   gcc  
powerpc               randconfig-002-20240402   gcc  
powerpc               randconfig-003-20240401   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                     sequoia_defconfig   clang
powerpc                     tqm8540_defconfig   gcc  
powerpc64             randconfig-001-20240401   gcc  
powerpc64             randconfig-001-20240402   gcc  
powerpc64             randconfig-002-20240401   clang
powerpc64             randconfig-002-20240402   gcc  
powerpc64             randconfig-003-20240401   gcc  
powerpc64             randconfig-003-20240402   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240401   clang
riscv                 randconfig-002-20240401   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240401   gcc  
s390                  randconfig-001-20240402   gcc  
s390                  randconfig-002-20240401   gcc  
s390                  randconfig-002-20240402   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                    randconfig-001-20240401   gcc  
sh                    randconfig-001-20240402   gcc  
sh                    randconfig-002-20240401   gcc  
sh                    randconfig-002-20240402   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240401   gcc  
sparc64               randconfig-001-20240402   gcc  
sparc64               randconfig-002-20240401   gcc  
sparc64               randconfig-002-20240402   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240401   gcc  
um                    randconfig-001-20240402   gcc  
um                    randconfig-002-20240401   clang
um                    randconfig-002-20240402   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240401   clang
x86_64       buildonly-randconfig-001-20240402   clang
x86_64       buildonly-randconfig-002-20240401   clang
x86_64       buildonly-randconfig-002-20240402   clang
x86_64       buildonly-randconfig-003-20240401   gcc  
x86_64       buildonly-randconfig-003-20240402   clang
x86_64       buildonly-randconfig-004-20240401   gcc  
x86_64       buildonly-randconfig-004-20240402   clang
x86_64       buildonly-randconfig-005-20240401   gcc  
x86_64       buildonly-randconfig-005-20240402   clang
x86_64       buildonly-randconfig-006-20240402   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240402   clang
x86_64                randconfig-002-20240402   clang
x86_64                randconfig-003-20240402   gcc  
x86_64                randconfig-004-20240402   clang
x86_64                randconfig-005-20240402   gcc  
x86_64                randconfig-006-20240402   gcc  
x86_64                randconfig-011-20240402   gcc  
x86_64                randconfig-012-20240402   gcc  
x86_64                randconfig-013-20240402   clang
x86_64                randconfig-014-20240402   gcc  
x86_64                randconfig-015-20240402   clang
x86_64                randconfig-016-20240402   gcc  
x86_64                randconfig-071-20240402   clang
x86_64                randconfig-072-20240402   clang
x86_64                randconfig-073-20240402   clang
x86_64                randconfig-074-20240402   gcc  
x86_64                randconfig-075-20240402   clang
x86_64                randconfig-076-20240402   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240401   gcc  
xtensa                randconfig-001-20240402   gcc  
xtensa                randconfig-002-20240401   gcc  
xtensa                randconfig-002-20240402   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

