Return-Path: <linux-rdma+bounces-9358-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60BDA84F0C
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 23:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADA9E46237D
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 21:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59617283699;
	Thu, 10 Apr 2025 21:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lm8h3y3x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D70E6EB79
	for <linux-rdma@vger.kernel.org>; Thu, 10 Apr 2025 21:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744319367; cv=none; b=SPcOEyMvjKie05pRduvcc+N6XjoTW2MuyiaWYkSOPVfBiK4yJAkESZVFnMt3dT6zRR/seBm3WZwW6nzmtlJTXvAGHF9Jc5HB8NDyvz9Q3vn5Sj/4J4ZjfYy6D7Gzw7PF0NnAm10KQRDY9KMN1nGPCMx4V/Ihbl+/oJqkRw4feIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744319367; c=relaxed/simple;
	bh=mj7XMqnbi/ruFJqGGK6iN4YpFpAdz57qQZsM2/VAuv8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=q2WwXuFj9xi/m3YmmFFbblbbIzxLtn9ShCZBwVZR8ai0mtZGK9lT0ATxTK+d9SZDyDthYF8giLHzN8lGDnMIIhJyWfxQzBZcPVeeWKVivzrh4DxX4RsNvW13qp8PmnE3jkXrmrb7US3QzroUMp6KV3QsD9Qv+YHX92A44WTZ28Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lm8h3y3x; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744319366; x=1775855366;
  h=date:from:to:cc:subject:message-id;
  bh=mj7XMqnbi/ruFJqGGK6iN4YpFpAdz57qQZsM2/VAuv8=;
  b=lm8h3y3x9w6OJU8Y6N4zZiW9ZYVhPhduo4fXQjmOF7ur+mbXa42NpaqF
   eKm5uGxpF5YDcm+Enm4uLhG0N7bvbMW+p5sEcg3LRcL5Gmg7BYGRKLe51
   6yzfnHXoJzLt0HCpcOmAPpqQ9UVXtwECSIzPxwfBKC6RQHq/v9xgencIu
   g8taPcfMm3cZfHUUvB0v56xi+A1zQPBF34HASUZtBgR6IF1ULAmF45av+
   nd+oACeQ90R46MfcypBv4W7kzlZbDf3bQ8g9Hb1u3SfewcmXFiNgrD2j7
   yrVMuIF2AApdDBf3c0Wm21M8LFPwtmA6unHmv6UEAQHG7d4uMtZM5T3HJ
   A==;
X-CSE-ConnectionGUID: RpvSJjmFQna2vq8PR9PDtQ==
X-CSE-MsgGUID: 2jogaFlITomCRo5iS8C0Nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="63403969"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="63403969"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 14:09:25 -0700
X-CSE-ConnectionGUID: cBw/Im0SSEy8WaakVuIUEQ==
X-CSE-MsgGUID: K3tCveGVSq6ncEDV1sztZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="134180220"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 10 Apr 2025 14:09:23 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u2z9E-000AXS-2H;
	Thu, 10 Apr 2025 21:09:20 +0000
Date: Fri, 11 Apr 2025 05:08:54 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-rc] BUILD SUCCESS
 9a0e6f15029e1a8a21e40f06fd05aa52b7f063de
Message-ID: <202504110547.itLUWxVf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: 9a0e6f15029e1a8a21e40f06fd05aa52b7f063de  RDMA/core: Silence oversized kvmalloc() warning

elapsed time: 1538m

configs tested: 110
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                   randconfig-001-20250410    gcc-14.2.0
arc                   randconfig-001-20250411    gcc-14.2.0
arc                   randconfig-002-20250410    gcc-12.4.0
arc                   randconfig-002-20250411    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                            hisi_defconfig    gcc-14.2.0
arm                   randconfig-001-20250410    clang-21
arm                   randconfig-001-20250411    clang-21
arm                   randconfig-002-20250410    clang-18
arm                   randconfig-002-20250411    clang-21
arm                   randconfig-003-20250410    gcc-7.5.0
arm                   randconfig-003-20250411    gcc-6.5.0
arm                   randconfig-004-20250410    gcc-8.5.0
arm                   randconfig-004-20250411    gcc-6.5.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250410    clang-21
arm64                 randconfig-002-20250410    clang-21
arm64                 randconfig-003-20250410    gcc-6.5.0
arm64                 randconfig-004-20250410    gcc-8.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250410    gcc-14.2.0
csky                  randconfig-001-20250411    gcc-14.2.0
csky                  randconfig-002-20250410    gcc-14.2.0
csky                  randconfig-002-20250411    gcc-9.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250410    clang-21
hexagon               randconfig-001-20250411    clang-21
hexagon               randconfig-002-20250410    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250410    clang-20
i386        buildonly-randconfig-002-20250410    clang-20
i386        buildonly-randconfig-003-20250410    clang-20
i386        buildonly-randconfig-004-20250410    gcc-11
i386        buildonly-randconfig-005-20250410    clang-20
i386        buildonly-randconfig-006-20250410    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250410    gcc-12.4.0
loongarch             randconfig-002-20250410    gcc-12.4.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                      mmu_defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                       rbtx49xx_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250410    gcc-14.2.0
nios2                 randconfig-002-20250410    gcc-10.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250410    gcc-5.5.0
parisc                randconfig-002-20250410    gcc-11.5.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250410    gcc-6.5.0
powerpc               randconfig-002-20250410    gcc-6.5.0
powerpc               randconfig-003-20250410    clang-21
powerpc64             randconfig-001-20250410    clang-21
powerpc64             randconfig-002-20250410    clang-21
powerpc64             randconfig-003-20250410    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250410    clang-21
riscv                 randconfig-002-20250410    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250410    clang-17
s390                  randconfig-002-20250410    gcc-6.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250410    gcc-12.4.0
sh                    randconfig-002-20250410    gcc-10.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250410    gcc-10.3.0
sparc                 randconfig-002-20250410    gcc-7.5.0
sparc64               randconfig-001-20250410    gcc-7.5.0
sparc64               randconfig-002-20250410    gcc-5.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250410    clang-21
um                    randconfig-002-20250410    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250410    clang-20
x86_64      buildonly-randconfig-002-20250410    gcc-12
x86_64      buildonly-randconfig-003-20250410    clang-20
x86_64      buildonly-randconfig-004-20250410    clang-20
x86_64      buildonly-randconfig-005-20250410    clang-20
x86_64      buildonly-randconfig-006-20250410    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250410    gcc-14.2.0
xtensa                randconfig-002-20250410    gcc-7.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

