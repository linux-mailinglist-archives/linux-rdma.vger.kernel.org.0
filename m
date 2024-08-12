Return-Path: <linux-rdma+bounces-4315-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D3194E5C5
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 06:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9021F221D5
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 04:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EC013D8B2;
	Mon, 12 Aug 2024 04:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BAbl8OS2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBECA37B
	for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2024 04:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723437109; cv=none; b=lotXTtSXx+56cXvikJew1SYgSjdJsg67C5EVCTfrKDtUf08tZEU7Wt+Yqjvhw3iNk8WqH+rUmz4TIgXkt/uR2zAOA/PRk1kgeOPie6zjUiV9X7PaopfKmlE7q2fGx9KN79d9ko6mBWf3R4uF60I7N9tKFYmxcOxuJaAXLlFtCAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723437109; c=relaxed/simple;
	bh=NzFme5HtAlwaB81qVECUH4CIyymb373IolZYKsojXQQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=McoJupJg7qITffyW0SCvLvQVdNVyJYUvbPvSsv24qzGoECEsJ6Lb+kso84qoxwD2PhXai55ydzGlHRLc7AsHauyZrnMcwKmgynaaWgndcTVrx9y3HygsTCZsjwFvLGdlLANlna9xNnZFYdRPAb5bTDGwt0qnxmMIVnoplg2jILo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BAbl8OS2; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723437108; x=1754973108;
  h=date:from:to:cc:subject:message-id;
  bh=NzFme5HtAlwaB81qVECUH4CIyymb373IolZYKsojXQQ=;
  b=BAbl8OS2sT5Z+2jg4yWcpjZILX/+7HI0t/V8aM4y0zAL/mAhFtBiDFOI
   KPekbCzD5qSG+Chc6UMX4qIq0aLB8+Dq0+Ytzq160z9FTP0FRLTpRVmQ0
   HmegoEy8ntXc/ziQjZqE/o7x82GLeshgSiPwkcGopSQrHXVNraC++TyAm
   7dr3QjZ1/zIZMhsH8OilwwlwoyoP3BNEzY9PxQ2DfjJvrHW8LEPRfLCQW
   qpxPdFdWwrcjH0239KSNR5CUGQ4A5ZzYU5CnoyFweKQcrMFWRXDxOYajW
   JaCBlk0yMxzVbOXQf2dJZFL21unGyYQB5TTGixrqa7++xnx2XcT7bcdun
   Q==;
X-CSE-ConnectionGUID: qVqchRbDQf601RaITkpJ0g==
X-CSE-MsgGUID: J9pGC48wR7+ZblHLiWFFkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="21089991"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="21089991"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 21:31:47 -0700
X-CSE-ConnectionGUID: p0bjAj1eTBKkBJlUjmslHA==
X-CSE-MsgGUID: tqG8U8slSxy8EsUi6LTM3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="58078797"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 11 Aug 2024 21:31:46 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sdMid-000BOD-2E;
	Mon, 12 Aug 2024 04:31:43 +0000
Date: Mon, 12 Aug 2024 12:31:42 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 ec7ad6530909983c8736c80af46e3529ce7bab55
Message-ID: <202408121239.R1uOywk1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: ec7ad6530909983c8736c80af46e3529ce7bab55  RDMA/mlx5: Introduce GET_DATA_DIRECT_SYSFS_PATH ioctl

elapsed time: 1069m

configs tested: 327
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                     haps_hs_smp_defconfig   gcc-13.2.0
arc                   randconfig-001-20240811   gcc-13.2.0
arc                   randconfig-001-20240812   gcc-13.2.0
arc                   randconfig-002-20240811   gcc-13.2.0
arc                   randconfig-002-20240812   gcc-13.2.0
arc                    vdk_hs38_smp_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                     am200epdkit_defconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                        keystone_defconfig   gcc-14.1.0
arm                        multi_v5_defconfig   gcc-14.1.0
arm                        mvebu_v7_defconfig   gcc-13.2.0
arm                   randconfig-001-20240811   gcc-13.2.0
arm                   randconfig-001-20240812   gcc-13.2.0
arm                   randconfig-002-20240811   gcc-13.2.0
arm                   randconfig-002-20240812   gcc-13.2.0
arm                   randconfig-003-20240811   gcc-13.2.0
arm                   randconfig-003-20240812   gcc-13.2.0
arm                   randconfig-004-20240811   gcc-13.2.0
arm                   randconfig-004-20240812   gcc-13.2.0
arm                             rpc_defconfig   gcc-13.2.0
arm                           u8500_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240811   gcc-13.2.0
arm64                 randconfig-001-20240812   gcc-13.2.0
arm64                 randconfig-002-20240811   gcc-13.2.0
arm64                 randconfig-002-20240812   gcc-13.2.0
arm64                 randconfig-003-20240811   gcc-13.2.0
arm64                 randconfig-003-20240812   gcc-13.2.0
arm64                 randconfig-004-20240811   gcc-13.2.0
arm64                 randconfig-004-20240812   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240811   gcc-13.2.0
csky                  randconfig-001-20240812   gcc-13.2.0
csky                  randconfig-002-20240811   gcc-13.2.0
csky                  randconfig-002-20240812   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             alldefconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240811   gcc-12
i386         buildonly-randconfig-001-20240812   clang-18
i386         buildonly-randconfig-002-20240811   gcc-12
i386         buildonly-randconfig-002-20240812   clang-18
i386         buildonly-randconfig-003-20240811   gcc-12
i386         buildonly-randconfig-003-20240812   clang-18
i386         buildonly-randconfig-004-20240811   gcc-12
i386         buildonly-randconfig-004-20240812   clang-18
i386         buildonly-randconfig-005-20240811   gcc-12
i386         buildonly-randconfig-005-20240812   clang-18
i386         buildonly-randconfig-006-20240811   gcc-12
i386         buildonly-randconfig-006-20240812   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240811   gcc-12
i386                  randconfig-001-20240812   clang-18
i386                  randconfig-002-20240811   gcc-12
i386                  randconfig-002-20240812   clang-18
i386                  randconfig-003-20240811   gcc-12
i386                  randconfig-003-20240812   clang-18
i386                  randconfig-004-20240811   gcc-12
i386                  randconfig-004-20240812   clang-18
i386                  randconfig-005-20240811   gcc-12
i386                  randconfig-005-20240812   clang-18
i386                  randconfig-006-20240811   gcc-12
i386                  randconfig-006-20240812   clang-18
i386                  randconfig-011-20240811   gcc-12
i386                  randconfig-011-20240812   clang-18
i386                  randconfig-012-20240811   gcc-12
i386                  randconfig-012-20240812   clang-18
i386                  randconfig-013-20240811   gcc-12
i386                  randconfig-013-20240812   clang-18
i386                  randconfig-014-20240811   gcc-12
i386                  randconfig-014-20240812   clang-18
i386                  randconfig-015-20240811   gcc-12
i386                  randconfig-015-20240812   clang-18
i386                  randconfig-016-20240811   gcc-12
i386                  randconfig-016-20240812   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240811   gcc-13.2.0
loongarch             randconfig-001-20240812   gcc-13.2.0
loongarch             randconfig-002-20240811   gcc-13.2.0
loongarch             randconfig-002-20240812   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          amiga_defconfig   gcc-13.2.0
m68k                         apollo_defconfig   gcc-13.2.0
m68k                          atari_defconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5208evb_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                          ath79_defconfig   gcc-13.2.0
mips                        bcm63xx_defconfig   gcc-14.1.0
mips                  cavium_octeon_defconfig   gcc-13.2.0
mips                         db1xxx_defconfig   gcc-13.2.0
mips                     decstation_defconfig   gcc-13.2.0
mips                      fuloong2e_defconfig   gcc-13.2.0
mips                           jazz_defconfig   gcc-14.1.0
mips                     loongson1c_defconfig   gcc-13.2.0
mips                          malta_defconfig   gcc-13.2.0
mips                        omega2p_defconfig   gcc-14.1.0
mips                      pic32mzda_defconfig   gcc-13.2.0
mips                        vocore2_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240811   gcc-13.2.0
nios2                 randconfig-001-20240812   gcc-13.2.0
nios2                 randconfig-002-20240811   gcc-13.2.0
nios2                 randconfig-002-20240812   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
openrisc                       virt_defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240811   gcc-13.2.0
parisc                randconfig-001-20240812   gcc-13.2.0
parisc                randconfig-002-20240811   gcc-13.2.0
parisc                randconfig-002-20240812   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                    adder875_defconfig   gcc-13.2.0
powerpc                     akebono_defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                 canyonlands_defconfig   gcc-13.2.0
powerpc                      chrp32_defconfig   gcc-13.2.0
powerpc                      cm5200_defconfig   gcc-13.2.0
powerpc                       eiger_defconfig   gcc-13.2.0
powerpc                      ep88xc_defconfig   gcc-13.2.0
powerpc                 linkstation_defconfig   gcc-13.2.0
powerpc                       maple_defconfig   gcc-13.2.0
powerpc                     mpc512x_defconfig   gcc-13.2.0
powerpc                 mpc8315_rdb_defconfig   gcc-13.2.0
powerpc                 mpc834x_itx_defconfig   gcc-13.2.0
powerpc                 mpc836x_rdk_defconfig   gcc-13.2.0
powerpc                    mvme5100_defconfig   gcc-14.1.0
powerpc                      pcm030_defconfig   gcc-13.2.0
powerpc                      pcm030_defconfig   gcc-14.1.0
powerpc               randconfig-001-20240811   gcc-13.2.0
powerpc               randconfig-001-20240812   gcc-13.2.0
powerpc               randconfig-002-20240812   gcc-13.2.0
powerpc               randconfig-003-20240811   gcc-13.2.0
powerpc               randconfig-003-20240812   gcc-13.2.0
powerpc                    socrates_defconfig   gcc-13.2.0
powerpc                  storcenter_defconfig   gcc-13.2.0
powerpc                  storcenter_defconfig   gcc-14.1.0
powerpc                         wii_defconfig   gcc-14.1.0
powerpc                 xes_mpc85xx_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240811   gcc-13.2.0
powerpc64             randconfig-001-20240812   gcc-13.2.0
powerpc64             randconfig-002-20240811   gcc-13.2.0
powerpc64             randconfig-002-20240812   gcc-13.2.0
powerpc64             randconfig-003-20240811   gcc-13.2.0
powerpc64             randconfig-003-20240812   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240811   gcc-13.2.0
riscv                 randconfig-001-20240812   gcc-13.2.0
riscv                 randconfig-002-20240811   gcc-13.2.0
riscv                 randconfig-002-20240812   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240811   gcc-13.2.0
s390                  randconfig-001-20240812   gcc-13.2.0
s390                  randconfig-002-20240811   gcc-13.2.0
s390                  randconfig-002-20240812   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                         ap325rxa_defconfig   gcc-13.2.0
sh                         apsh4a3a_defconfig   gcc-13.2.0
sh                                  defconfig   gcc-14.1.0
sh                        edosk7705_defconfig   gcc-14.1.0
sh                          landisk_defconfig   gcc-13.2.0
sh                          polaris_defconfig   gcc-13.2.0
sh                    randconfig-001-20240811   gcc-13.2.0
sh                    randconfig-001-20240812   gcc-13.2.0
sh                    randconfig-002-20240811   gcc-13.2.0
sh                    randconfig-002-20240812   gcc-13.2.0
sh                           se7206_defconfig   gcc-13.2.0
sh                           se7722_defconfig   gcc-13.2.0
sh                   sh7724_generic_defconfig   gcc-13.2.0
sh                            titan_defconfig   gcc-13.2.0
sh                              ul2_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240811   gcc-13.2.0
sparc64               randconfig-001-20240812   gcc-13.2.0
sparc64               randconfig-002-20240811   gcc-13.2.0
sparc64               randconfig-002-20240812   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240811   gcc-13.2.0
um                    randconfig-001-20240812   gcc-13.2.0
um                    randconfig-002-20240811   gcc-13.2.0
um                    randconfig-002-20240812   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240811   gcc-12
x86_64       buildonly-randconfig-001-20240812   clang-18
x86_64       buildonly-randconfig-002-20240811   clang-18
x86_64       buildonly-randconfig-002-20240811   gcc-12
x86_64       buildonly-randconfig-002-20240812   clang-18
x86_64       buildonly-randconfig-003-20240811   gcc-12
x86_64       buildonly-randconfig-003-20240812   clang-18
x86_64       buildonly-randconfig-004-20240811   gcc-12
x86_64       buildonly-randconfig-004-20240812   clang-18
x86_64       buildonly-randconfig-005-20240811   gcc-12
x86_64       buildonly-randconfig-005-20240812   clang-18
x86_64       buildonly-randconfig-006-20240811   gcc-12
x86_64       buildonly-randconfig-006-20240812   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240811   clang-18
x86_64                randconfig-001-20240811   gcc-12
x86_64                randconfig-001-20240812   clang-18
x86_64                randconfig-002-20240811   clang-18
x86_64                randconfig-002-20240811   gcc-12
x86_64                randconfig-002-20240812   clang-18
x86_64                randconfig-003-20240811   clang-18
x86_64                randconfig-003-20240811   gcc-12
x86_64                randconfig-003-20240812   clang-18
x86_64                randconfig-004-20240811   clang-18
x86_64                randconfig-004-20240811   gcc-12
x86_64                randconfig-004-20240812   clang-18
x86_64                randconfig-005-20240811   gcc-12
x86_64                randconfig-005-20240812   clang-18
x86_64                randconfig-006-20240811   clang-18
x86_64                randconfig-006-20240811   gcc-12
x86_64                randconfig-006-20240812   clang-18
x86_64                randconfig-011-20240811   gcc-12
x86_64                randconfig-011-20240812   clang-18
x86_64                randconfig-012-20240811   clang-18
x86_64                randconfig-012-20240811   gcc-12
x86_64                randconfig-012-20240812   clang-18
x86_64                randconfig-013-20240811   gcc-12
x86_64                randconfig-013-20240812   clang-18
x86_64                randconfig-014-20240811   gcc-12
x86_64                randconfig-014-20240812   clang-18
x86_64                randconfig-015-20240811   clang-18
x86_64                randconfig-015-20240811   gcc-12
x86_64                randconfig-015-20240812   clang-18
x86_64                randconfig-016-20240811   clang-18
x86_64                randconfig-016-20240811   gcc-12
x86_64                randconfig-016-20240812   clang-18
x86_64                randconfig-071-20240811   clang-18
x86_64                randconfig-071-20240811   gcc-12
x86_64                randconfig-071-20240812   clang-18
x86_64                randconfig-072-20240811   clang-18
x86_64                randconfig-072-20240811   gcc-12
x86_64                randconfig-072-20240812   clang-18
x86_64                randconfig-073-20240811   clang-18
x86_64                randconfig-073-20240811   gcc-12
x86_64                randconfig-073-20240812   clang-18
x86_64                randconfig-074-20240811   gcc-12
x86_64                randconfig-074-20240812   clang-18
x86_64                randconfig-075-20240811   clang-18
x86_64                randconfig-075-20240811   gcc-12
x86_64                randconfig-075-20240812   clang-18
x86_64                randconfig-076-20240811   gcc-12
x86_64                randconfig-076-20240812   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                generic_kc705_defconfig   gcc-14.1.0
xtensa                          iss_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240811   gcc-13.2.0
xtensa                randconfig-001-20240812   gcc-13.2.0
xtensa                randconfig-002-20240811   gcc-13.2.0
xtensa                randconfig-002-20240812   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

