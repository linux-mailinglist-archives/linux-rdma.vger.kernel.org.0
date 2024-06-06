Return-Path: <linux-rdma+bounces-2956-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E078FF552
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 21:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6A47B2155C
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 19:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5385C54654;
	Thu,  6 Jun 2024 19:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jqRfKy6A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303468821
	for <linux-rdma@vger.kernel.org>; Thu,  6 Jun 2024 19:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717702506; cv=none; b=LEKxyuTi9cZyLu/zu57UFsZY5jzuW3kfHz4rrQJF6z9irvpgJVzFFnAk09ijBz11CqLFpDUeLqQ7RN/Tt+vztFrxtGOR0+jEiAHH/RHTB+hrivOT48HfEW8pIxmxxXEm83TEEwluiCvhhYqnsmLF42Xdp2Y7LZprcmy7Wxdu26E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717702506; c=relaxed/simple;
	bh=TrFfZbnSSnE5sD3UANR4mCeLZUIh7oy5E2tEcuSPqEo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=s4yYDTnj87NYxa4I2o/OtuKGoAKT4EnfwUirUO4NjFFwwG142+vf3DzllgzMFnAP6n65uYolFC0iHFog7cdnANyAbdXeju0gg2zc47qxywHRYoppqJWl397jq8SoVgUNTPF2XmxZzLivp54ubI4dTy21xW8pv2qWFxVVRLCQZGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jqRfKy6A; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717702504; x=1749238504;
  h=date:from:to:cc:subject:message-id;
  bh=TrFfZbnSSnE5sD3UANR4mCeLZUIh7oy5E2tEcuSPqEo=;
  b=jqRfKy6AutC5GHgwrkNmFbX5CGg2eJKcESYwYt6knDt44EF2IYAlq9LU
   FUIG8WuMyz2LNsLTmZ2P18H+ZjfyIH00eNIXIQ7mbZgMxWnBYCrtf9zzg
   PNbWtoiLiy8J9r39CY5OcnYmpvFSzKt7DQ4bFEaQpzy8lYHHRGCOY97t7
   31VIrTCG/5QVpWxLyC1dAn+p7PY/K9NIhywl92AUwJyIAsB2joh0A/DfO
   U31hx68Uru7VyE1sxsjNDg0NC704igegPZBP72gjRNZkSZI41LK9mbjHw
   ncedB8D5RjyW+g2HEA9cyKF93kcsGdKyRkJWXnK1Z1gIRNwM5eRPUet5o
   w==;
X-CSE-ConnectionGUID: CsKn9eWnQSO8Ws09xBH3tA==
X-CSE-MsgGUID: InH/W7XKRPK7b+dLq7C7HQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14239132"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14239132"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 12:35:04 -0700
X-CSE-ConnectionGUID: v1RHifptQL2Fpb4r/klNlQ==
X-CSE-MsgGUID: eZeCHfV4S3OX/eKZ0K8/Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="42505793"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 06 Jun 2024 12:35:02 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFIt2-0003cY-10;
	Thu, 06 Jun 2024 19:35:00 +0000
Date: Fri, 07 Jun 2024 03:34:35 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-rc] BUILD SUCCESS
 fa0aa4d75f6b909ec910fd1f1eab7cc7bb42227b
Message-ID: <202406070332.bfvIzUTv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: fa0aa4d75f6b909ec910fd1f1eab7cc7bb42227b  RDMA/mlx5: Add check for srq max_sge attribute

elapsed time: 1543m

configs tested: 107
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240607   gcc  
arc                   randconfig-002-20240607   gcc  
arm                               allnoconfig   clang
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240607   gcc  
arm                   randconfig-002-20240607   clang
arm                   randconfig-003-20240607   clang
arm                   randconfig-004-20240607   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240607   gcc  
arm64                 randconfig-002-20240607   clang
arm64                 randconfig-003-20240607   clang
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240607   gcc  
csky                  randconfig-002-20240607   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240606   clang
i386         buildonly-randconfig-002-20240606   clang
i386         buildonly-randconfig-003-20240606   clang
i386         buildonly-randconfig-004-20240606   gcc  
i386         buildonly-randconfig-005-20240606   clang
i386         buildonly-randconfig-006-20240606   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240606   clang
i386                  randconfig-002-20240606   clang
i386                  randconfig-003-20240606   clang
i386                  randconfig-004-20240606   clang
i386                  randconfig-005-20240606   clang
i386                  randconfig-006-20240606   clang
i386                  randconfig-011-20240606   clang
i386                  randconfig-012-20240606   gcc  
i386                  randconfig-013-20240606   gcc  
i386                  randconfig-014-20240606   gcc  
i386                  randconfig-015-20240606   gcc  
i386                  randconfig-016-20240606   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       rbtx49xx_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    amigaone_defconfig   gcc  
powerpc                     kmeter1_defconfig   gcc  
powerpc                     tqm8560_defconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

