Return-Path: <linux-rdma+bounces-8684-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AC4A60149
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 20:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA75D3A21E2
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 19:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6201B1F3D3E;
	Thu, 13 Mar 2025 19:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MuvnelRs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2331F3FC3
	for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 19:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741894270; cv=none; b=OEX8o2the5q03iwZesTpe1wrChyozocU91d7D4xWu8o/RvE0wpJIFcknunrbhgfxnkMrM7ZQPvXze8LFeoLl2FX2zhdL00Ww+ZGYs4/k5/co9W8MUiW/ACY1wPCkl9ms3j6oWQCLxUuIHonoY+bmnIKCFdES3TWON7A+1KhBA8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741894270; c=relaxed/simple;
	bh=fRfzz4b43AJUPxAd/bLup3xut4ioxfBqMdXl0wgZNJM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ARdWs2f7W46Y/zPKSn6UMwttCQPMcmKHIGEml+aJRWfFw9fkWG+g70mQzVXltNybxEawRMuIv6AkVaqG4986r2IUAifcoxvlywt5sPWXZ/evrVVuLGrCgEbb935qPLQoBDJIcmzAiD/Kh25kCg9SPStMsARugBR0jAXMMC0cXJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MuvnelRs; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741894269; x=1773430269;
  h=date:from:to:cc:subject:message-id;
  bh=fRfzz4b43AJUPxAd/bLup3xut4ioxfBqMdXl0wgZNJM=;
  b=MuvnelRsWypx8o0sMv/WQf/28cd/Gy8rZvugUdHnFkwIqXMWzdxCzLKt
   BhYnwvgbf4a8/0aG7KniZhEIdTDmpoGi1oPtgcQ4mrfPyczeA2LjqJTAp
   t0wN7v1+VPxci6W8QG/UplHOhqQVLPIKzoxpPlIR/KvDhpjWz128s5zO6
   9GNn55dEE+j75Jww2Sw72hxtKxKXb/BnOu34x8R9PcK412w2tQXUT+MmC
   GkiOaDCClarQeaXarf+4B2l7BNC5fxZ2XSvYZhB48q+H2Idz1CthH0CvB
   LMLIc4gofEIXwaCI8W4hjtNa0lV7cujcQlfM6Xyu0UKSq4riMeSTYesx/
   Q==;
X-CSE-ConnectionGUID: vaOmsE0YRrmR7QrduLRk7A==
X-CSE-MsgGUID: k6CYzESrSSGzptvLEmQwcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="60434277"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="60434277"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 12:31:08 -0700
X-CSE-ConnectionGUID: SJHLBS+tQHa0sEoaXZDqRQ==
X-CSE-MsgGUID: wnCZePthTKKO5zkhutVZSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="144251805"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 13 Mar 2025 12:31:06 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsoGm-0009n8-14;
	Thu, 13 Mar 2025 19:31:04 +0000
Date: Fri, 14 Mar 2025 03:30:53 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 6b5e41a8b51fce520bb09bd651a29ef495e990de
Message-ID: <202503140347.HqytZtku-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: 6b5e41a8b51fce520bb09bd651a29ef495e990de  RDMA/hns: Fix wrong value of max_sge_rd

elapsed time: 1445m

configs tested: 97
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250313    gcc-13.2.0
arc                   randconfig-002-20250313    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250313    clang-16
arm                   randconfig-002-20250313    clang-18
arm                   randconfig-003-20250313    gcc-14.2.0
arm                   randconfig-004-20250313    clang-21
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250313    clang-18
arm64                 randconfig-002-20250313    clang-16
arm64                 randconfig-003-20250313    gcc-14.2.0
arm64                 randconfig-004-20250313    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250313    gcc-14.2.0
csky                  randconfig-002-20250313    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250313    clang-17
hexagon               randconfig-002-20250313    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250313    gcc-12
i386        buildonly-randconfig-002-20250313    gcc-12
i386        buildonly-randconfig-003-20250313    clang-19
i386        buildonly-randconfig-004-20250313    gcc-12
i386        buildonly-randconfig-005-20250313    clang-19
i386        buildonly-randconfig-006-20250313    gcc-12
i386                                defconfig    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250313    gcc-14.2.0
loongarch             randconfig-002-20250313    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250313    gcc-14.2.0
nios2                 randconfig-002-20250313    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250313    gcc-14.2.0
parisc                randconfig-002-20250313    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250313    clang-16
powerpc               randconfig-002-20250313    clang-18
powerpc               randconfig-003-20250313    gcc-14.2.0
powerpc64             randconfig-001-20250313    gcc-14.2.0
powerpc64             randconfig-002-20250313    gcc-14.2.0
powerpc64             randconfig-003-20250313    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250313    clang-21
riscv                 randconfig-002-20250313    clang-21
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250313    clang-15
s390                  randconfig-002-20250313    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250313    gcc-14.2.0
sh                    randconfig-002-20250313    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250313    gcc-14.2.0
sparc                 randconfig-002-20250313    gcc-14.2.0
sparc64               randconfig-001-20250313    gcc-14.2.0
sparc64               randconfig-002-20250313    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250313    clang-21
um                    randconfig-002-20250313    clang-21
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250313    clang-19
x86_64      buildonly-randconfig-002-20250313    clang-19
x86_64      buildonly-randconfig-003-20250313    clang-19
x86_64      buildonly-randconfig-004-20250313    gcc-12
x86_64      buildonly-randconfig-005-20250313    clang-19
x86_64      buildonly-randconfig-006-20250313    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250313    gcc-14.2.0
xtensa                randconfig-002-20250313    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

