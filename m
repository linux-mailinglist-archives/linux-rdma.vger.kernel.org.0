Return-Path: <linux-rdma+bounces-1750-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 629B9895F5F
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 00:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13EEB28743E
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 22:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B0F15E808;
	Tue,  2 Apr 2024 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GxGmzoJL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB1079DD4
	for <linux-rdma@vger.kernel.org>; Tue,  2 Apr 2024 22:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095821; cv=none; b=f1UfWrD3kScmxR+M3fVJY3sG0g5ezaVau8qgo/2xYgqIZyCxYKufZYM/PX7OFWj1QqR8qOHmALtxK22G2d8spWMZG+60VRSjQ3MiXEq9vjVwPzGc/ZG2Busvc3rtzaexjBV7KQeX6TkNlcvfL1P0HHucsvmotB4Erf8pBbKZuoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095821; c=relaxed/simple;
	bh=tKK5YiiRz4Oo99lQtwVeDvfpLGGs9pmi2ROInIVc2QQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JwcQgTtpZzlFT3b/BUwayAA9mckIy9g1tklbLskENvhbT7HJUiE0uUAXynLgLqfJUy0Kqpwl4WLDl/c8Q6c1HGgxaTfyZvPWMojlGCqWX78IhzAptjz5uHt+uG3GNSRULMuqaz/3Bo1q/zAuQfJt5ER60Gf+LEvWi/L/DS5JYgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GxGmzoJL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712095819; x=1743631819;
  h=date:from:to:cc:subject:message-id;
  bh=tKK5YiiRz4Oo99lQtwVeDvfpLGGs9pmi2ROInIVc2QQ=;
  b=GxGmzoJLaLMD3+qre2bz4c6lfet/EKZPKSGspRX8KJlFJ1yZiDeghpaq
   dJVBRNm9+oO5Rf+j2mrC7/ksOz0sGGksDN9Pnmgpt5LIHSkyCl82y/m9Y
   mirzWuB9xna1eC+T3hcvDiewmVZwnGFWeup5Jpx4pjtE6Lftw5bl+Zb18
   L6uQUf3/SkSB2nd/fTXjkhdMaSP/nub5raLP4MNJiugCscAeQj1g2HK1s
   UABrYZd3b74jECuZ03zUtqr7zhKxwTaDRJuwSbWxY7MLk0IfX1wqxpv3l
   dyMQhDpCTPbersCQQ3dNyaKkLoxjSsrrxcMd2wC1dotcS4ftIohRTs6eO
   Q==;
X-CSE-ConnectionGUID: bqyzZE1gQk+I5Fb9NdV3uw==
X-CSE-MsgGUID: 1wWnn2S3QQiQYfPXW+knwA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="32694647"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="32694647"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 15:10:18 -0700
X-CSE-ConnectionGUID: VcfM+vI6QuK4TPMhHmijXQ==
X-CSE-MsgGUID: p2YsQuKFSYKgBRa1UtSMvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="41360111"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 02 Apr 2024 15:10:17 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rrmKd-0001Zz-0u;
	Tue, 02 Apr 2024 22:10:15 +0000
Date: Wed, 03 Apr 2024 06:09:38 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-rc] BUILD SUCCESS
 b68e1acb5834ed1a2ad42d9d002815a8bae7c0b6
Message-ID: <202404030637.1SnB2N6M-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: b68e1acb5834ed1a2ad42d9d002815a8bae7c0b6  RDMA/cm: Print the old state when cm_destroy_id gets timeout

elapsed time: 771m

configs tested: 147
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
arc                   randconfig-001-20240403   gcc  
arc                   randconfig-002-20240403   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240403   gcc  
arm                   randconfig-002-20240403   gcc  
arm                   randconfig-004-20240403   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-003-20240403   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240403   gcc  
csky                  randconfig-002-20240403   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240402   gcc  
i386         buildonly-randconfig-002-20240402   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240402   gcc  
i386                  randconfig-011-20240402   gcc  
i386                  randconfig-015-20240402   gcc  
i386                  randconfig-016-20240402   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240403   gcc  
loongarch             randconfig-002-20240403   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      loongson3_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240403   gcc  
nios2                 randconfig-002-20240403   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240403   gcc  
parisc                randconfig-002-20240403   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                    mvme5100_defconfig   gcc  
powerpc                      ppc64e_defconfig   gcc  
powerpc               randconfig-001-20240403   gcc  
powerpc               randconfig-002-20240403   gcc  
powerpc64             randconfig-001-20240403   gcc  
powerpc64             randconfig-003-20240403   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             alldefconfig   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240403   gcc  
sh                    randconfig-002-20240403   gcc  
sh                           se7721_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240403   gcc  
sparc64               randconfig-002-20240403   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240403   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240402   clang
x86_64       buildonly-randconfig-002-20240402   clang
x86_64       buildonly-randconfig-003-20240402   clang
x86_64       buildonly-randconfig-004-20240402   clang
x86_64       buildonly-randconfig-005-20240402   clang
x86_64       buildonly-randconfig-006-20240402   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240402   clang
x86_64                randconfig-002-20240402   clang
x86_64                randconfig-004-20240402   clang
x86_64                randconfig-013-20240402   clang
x86_64                randconfig-015-20240402   clang
x86_64                randconfig-071-20240402   clang
x86_64                randconfig-072-20240402   clang
x86_64                randconfig-073-20240402   clang
x86_64                randconfig-075-20240402   clang
x86_64                randconfig-076-20240402   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240403   gcc  
xtensa                randconfig-002-20240403   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

