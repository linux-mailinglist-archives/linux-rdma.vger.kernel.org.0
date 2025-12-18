Return-Path: <linux-rdma+bounces-15092-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2FDCCD349
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 19:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DF8830252BE
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 18:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A984306B02;
	Thu, 18 Dec 2025 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FATJbjE2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC43E1A5BB4
	for <linux-rdma@vger.kernel.org>; Thu, 18 Dec 2025 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766083165; cv=none; b=AJ28leeYInR94YdvLkkfFvJfQuxMdmLo3GuqyJ4FzWqe5K6LddN54N/nYCdjD9c8WfYrqAOr95BtoQX2ntfncA8p+YY7DdDN/q9rC7j89Eq9oBTlQlrHIxqnPJniw/lfTiqtwNl/nI3lmEwncpymu/ubNpDIjGFcut1mNQvw8TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766083165; c=relaxed/simple;
	bh=UDS7mdupj0/ANS6Tw/1feZhDzu4aoKpxhiuvRlmgof8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Eeu98UesDSk8RsrSmparE2kOdGvGGuDM0NWViuc3gmDg88e37Kju/mk15KL3OEZKewdh1+iFOynF+mExhRdcwmLFD0MHQsvgIWMwOgLm7P0oGTLFUPD5npimNgg9KLMCSHVPmiu4YmEb9p0dw+ojCLbK3HL6kTO965sW7EMV6tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FATJbjE2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766083164; x=1797619164;
  h=date:from:to:cc:subject:message-id;
  bh=UDS7mdupj0/ANS6Tw/1feZhDzu4aoKpxhiuvRlmgof8=;
  b=FATJbjE25PAsyqN5Fl6fb2oMNKJNPFk1fVIN8JpZpGu/1VehjcP7qwdy
   Cm+9WU2MPrvoDSZ+pI4DHycq0FAELiKsfvh/DJo87JH1JdJqrBkv5ud+Y
   ZBVsODuF0CW/0Q9mZi7b9MTo7x3twh9UqTlUK6sLG36trNN7H4AJUi0dw
   LJ4t5lia+nuhXsACnTYUX6cvvoMm7dGcZfnvuFPfhbimsoptXVMZknrNo
   rJ6M2pqyvrIBGBUB2XaAxPk5xNYGQpO23bnfj/TV+rTZywveQaMhNrXcp
   XfQgO3sxMaHioEmhhZbvNEjwB7VnJPPHCX7d/yhhUkQYIPb3/asuqE6Ha
   w==;
X-CSE-ConnectionGUID: Y4lDVZu3ReqskWOMVXXXYw==
X-CSE-MsgGUID: ecmHoq5+TPmqjIoNrZhnTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="78361288"
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="78361288"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 10:39:24 -0800
X-CSE-ConnectionGUID: AMjPQbI+R/Sx6MDFctUAQA==
X-CSE-MsgGUID: 1h64KWT8TN2UUHit0UEMgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="203067869"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 18 Dec 2025 10:39:22 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWIuF-000000002S9-2nHd;
	Thu, 18 Dec 2025 18:39:19 +0000
Date: Fri, 19 Dec 2025 02:38:39 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:for-rc] BUILD SUCCESS
 85463eb6a46caf2f1e0e1a6d0731f2f3bab17780
Message-ID: <202512190225.wp1aWmfZ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: 85463eb6a46caf2f1e0e1a6d0731f2f3bab17780  RDMA/efa: Remove possible negative shift

elapsed time: 1464m

configs tested: 150
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251218    clang-22
arc                   randconfig-002-20251218    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                         nhk8815_defconfig    clang-22
arm                   randconfig-001-20251218    clang-22
arm                   randconfig-002-20251218    clang-22
arm                   randconfig-003-20251218    clang-22
arm                   randconfig-004-20251218    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251218    gcc-14.3.0
arm64                 randconfig-002-20251218    gcc-14.3.0
arm64                 randconfig-003-20251218    gcc-14.3.0
arm64                 randconfig-004-20251218    gcc-14.3.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251218    gcc-14.3.0
csky                  randconfig-002-20251218    gcc-14.3.0
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon               randconfig-001-20251218    gcc-11.5.0
hexagon               randconfig-002-20251218    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251218    gcc-14
i386        buildonly-randconfig-002-20251218    gcc-14
i386        buildonly-randconfig-003-20251218    gcc-14
i386        buildonly-randconfig-004-20251218    gcc-14
i386        buildonly-randconfig-005-20251218    gcc-14
i386        buildonly-randconfig-006-20251218    gcc-14
i386                  randconfig-001-20251218    gcc-12
i386                  randconfig-002-20251218    gcc-12
i386                  randconfig-003-20251218    gcc-12
i386                  randconfig-004-20251218    gcc-12
i386                  randconfig-005-20251218    gcc-12
i386                  randconfig-006-20251218    gcc-12
i386                  randconfig-007-20251218    gcc-12
i386                  randconfig-011-20251218    clang-20
i386                  randconfig-012-20251218    clang-20
i386                  randconfig-013-20251218    clang-20
i386                  randconfig-014-20251218    clang-20
i386                  randconfig-015-20251218    clang-20
i386                  randconfig-016-20251218    clang-20
i386                  randconfig-017-20251218    clang-20
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251218    gcc-11.5.0
loongarch             randconfig-002-20251218    gcc-11.5.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                        stmark2_defconfig    clang-22
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                         db1xxx_defconfig    clang-22
mips                           xway_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251218    gcc-11.5.0
nios2                 randconfig-002-20251218    gcc-11.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251218    gcc-8.5.0
parisc                randconfig-002-20251218    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc               randconfig-001-20251218    gcc-8.5.0
powerpc               randconfig-002-20251218    gcc-8.5.0
powerpc64             randconfig-001-20251218    gcc-8.5.0
powerpc64             randconfig-002-20251218    gcc-8.5.0
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251218    gcc-8.5.0
riscv                 randconfig-002-20251218    gcc-8.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251218    gcc-8.5.0
s390                  randconfig-002-20251218    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                        edosk7760_defconfig    clang-22
sh                    randconfig-001-20251218    gcc-8.5.0
sh                    randconfig-002-20251218    gcc-8.5.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251218    gcc-15.1.0
sparc                 randconfig-002-20251218    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251218    gcc-15.1.0
sparc64               randconfig-002-20251218    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251218    gcc-15.1.0
um                    randconfig-002-20251218    gcc-15.1.0
um                           x86_64_defconfig    gcc-14
x86_64                           alldefconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251218    gcc-14
x86_64      buildonly-randconfig-002-20251218    gcc-14
x86_64      buildonly-randconfig-003-20251218    gcc-14
x86_64      buildonly-randconfig-004-20251218    gcc-14
x86_64      buildonly-randconfig-005-20251218    gcc-14
x86_64      buildonly-randconfig-006-20251218    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251218    gcc-14
x86_64                randconfig-012-20251218    gcc-14
x86_64                randconfig-013-20251218    gcc-14
x86_64                randconfig-014-20251218    gcc-14
x86_64                randconfig-015-20251218    gcc-14
x86_64                randconfig-016-20251218    gcc-14
x86_64                randconfig-071-20251218    gcc-12
x86_64                randconfig-072-20251218    gcc-12
x86_64                randconfig-073-20251218    gcc-12
x86_64                randconfig-074-20251218    gcc-12
x86_64                randconfig-075-20251218    gcc-12
x86_64                randconfig-076-20251218    gcc-12
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251218    gcc-15.1.0
xtensa                randconfig-002-20251218    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

