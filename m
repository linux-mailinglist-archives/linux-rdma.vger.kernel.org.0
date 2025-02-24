Return-Path: <linux-rdma+bounces-8026-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8ADA41544
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2025 07:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E0A07A246B
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2025 06:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF96D15ADB4;
	Mon, 24 Feb 2025 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QNyL+D32"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC26528DB3
	for <linux-rdma@vger.kernel.org>; Mon, 24 Feb 2025 06:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740377863; cv=none; b=m5ah05ixGG4r4+/RriMWi67BDNbrtMA7fGp1mS/RAh+lkjuTHABZcEiSyO5iWudLFmjfMbzFO0AxBzVINg7DDULaTINpbKIypZ4l7GqCRe/aMvm81V11EuXCp4ZxNPx/JaRzoGDC5+11xqBVj/1YkY16jo1FdoiiCfkxuLXM40g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740377863; c=relaxed/simple;
	bh=XDA4YBv25OHKsKZ4pTTWSzW5JQJGFm+fwhI0Ry2wJ9k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CpFJSp/xh4da3m5imzfT9cE3mQGyVLJhxVYJvqpR3sATQmsOmoW48ypFX+2VJwFxz02isGJh/kjq4keskihhhfqgaGx26JgCbnVM2Tsob9rcSE1FHqHuj2IcKe+d/W5cYOLEJ8ZLAEy01rNZh82e+zX51evhI0WsOgtmKW38dC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QNyL+D32; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740377862; x=1771913862;
  h=date:from:to:cc:subject:message-id;
  bh=XDA4YBv25OHKsKZ4pTTWSzW5JQJGFm+fwhI0Ry2wJ9k=;
  b=QNyL+D32B1M7llIBu8tjCqv9ZoLeR6zQxsCTMPMBd1WaW1aKxU0TRIen
   md7f7n3GHtcRbjiwcysKFAypB/i/H0Vy/gA4lOjYOv4hNWZ3hVguyzAdi
   LkxdfP7XeaJIQbFZ7HjqTLvDB7ao1tpbkzpBMREqW1Shb2kjZgDEBfDBE
   lnMkTm/OG9a66H5vi0Xl+bocEna1W/hDLtmiYxgb1ohT9U5OrStrc9k2X
   wZne7KV5rkcwjKpc15u1VlEQ3NBqPuNZBN5KRmVBi5LXaBsYCZajDA26L
   6aU2uN97/euYw9wp/apkA+8pBMZND4LBUJwhKkrQHgNkKDTG+/BBagrbI
   A==;
X-CSE-ConnectionGUID: vuamsqRPRoSVpFYUGQzGNQ==
X-CSE-MsgGUID: 0v5ltfIyRAOxL4H7UzHMmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="40827999"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="40827999"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 22:17:42 -0800
X-CSE-ConnectionGUID: yc/Tif7vRFC2N04ATTqgDQ==
X-CSE-MsgGUID: OtkW1PjyTZ6g2TlKVx6smg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="120941283"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 23 Feb 2025 22:17:40 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tmRmb-0007vb-0y;
	Mon, 24 Feb 2025 06:17:37 +0000
Date: Mon, 24 Feb 2025 14:16:47 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 be35a3127d60964b338da95c7bfaaf4a01b330d4
Message-ID: <202502241441.ZbEpu3Gc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: be35a3127d60964b338da95c7bfaaf4a01b330d4  RDMA/mana_ib: Ensure variable err is initialized

elapsed time: 1099m

configs tested: 167
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250223    gcc-13.2.0
arc                   randconfig-001-20250224    gcc-13.2.0
arc                   randconfig-002-20250223    gcc-13.2.0
arc                   randconfig-002-20250224    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g4_defconfig    clang-21
arm                      jornada720_defconfig    clang-21
arm                   randconfig-001-20250223    gcc-14.2.0
arm                   randconfig-001-20250224    gcc-14.2.0
arm                   randconfig-002-20250223    clang-21
arm                   randconfig-002-20250224    gcc-14.2.0
arm                   randconfig-003-20250223    clang-19
arm                   randconfig-003-20250224    gcc-14.2.0
arm                   randconfig-004-20250223    gcc-14.2.0
arm                   randconfig-004-20250224    gcc-14.2.0
arm                             rpc_defconfig    clang-17
arm                        shmobile_defconfig    gcc-14.2.0
arm                       spear13xx_defconfig    gcc-14.2.0
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
loongarch             randconfig-001-20250223    gcc-14.2.0
loongarch             randconfig-001-20250224    gcc-14.2.0
loongarch             randconfig-002-20250223    gcc-14.2.0
loongarch             randconfig-002-20250224    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                           sun3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
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
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                 mpc834x_itx_defconfig    clang-21
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250223    gcc-14.2.0
powerpc               randconfig-001-20250224    gcc-14.2.0
powerpc               randconfig-002-20250223    clang-17
powerpc               randconfig-002-20250224    gcc-14.2.0
powerpc               randconfig-003-20250223    gcc-14.2.0
powerpc               randconfig-003-20250224    gcc-14.2.0
powerpc64             randconfig-001-20250223    gcc-14.2.0
powerpc64             randconfig-002-20250223    clang-21
powerpc64             randconfig-002-20250224    clang-18
powerpc64             randconfig-003-20250223    gcc-14.2.0
powerpc64             randconfig-003-20250224    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                    nommu_virt_defconfig    clang-21
riscv                 randconfig-001-20250223    clang-17
riscv                 randconfig-001-20250224    gcc-14.2.0
riscv                 randconfig-002-20250223    gcc-14.2.0
riscv                 randconfig-002-20250224    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250223    clang-18
s390                  randconfig-001-20250224    gcc-14.2.0
s390                  randconfig-002-20250223    clang-16
s390                  randconfig-002-20250224    clang-17
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250223    gcc-14.2.0
sh                    randconfig-001-20250224    gcc-14.2.0
sh                    randconfig-002-20250223    gcc-14.2.0
sh                    randconfig-002-20250224    gcc-14.2.0
sh                           se7343_defconfig    gcc-14.2.0
sh                           sh2007_defconfig    gcc-14.2.0
sparc                            alldefconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250223    gcc-14.2.0
sparc                 randconfig-001-20250224    gcc-14.2.0
sparc                 randconfig-002-20250223    gcc-14.2.0
sparc                 randconfig-002-20250224    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
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
xtensa                  audio_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250223    gcc-14.2.0
xtensa                randconfig-001-20250224    gcc-14.2.0
xtensa                randconfig-002-20250223    gcc-14.2.0
xtensa                randconfig-002-20250224    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

