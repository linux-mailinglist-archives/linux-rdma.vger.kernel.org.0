Return-Path: <linux-rdma+bounces-8859-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0E1A6A1DC
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 09:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3859188EB22
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 08:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F5A214A71;
	Thu, 20 Mar 2025 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OWdo2tr+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158D5216E05
	for <linux-rdma@vger.kernel.org>; Thu, 20 Mar 2025 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460778; cv=none; b=IO+VjS5hQUAvIdCj9q3v1vRBhwzlZbDQMuQwLMpLD8nFgYpoOJdkIykzAOkKFV/yk07G3W86ovLBC8fsHkUaVvn8AIHe/APtM2qzO+DWkmJ5Y97liSdZLHQbhgRAD92Gz0Y9+KhInQG63NakSBZoXu94Ao9JXDgHjwAH0ugrxMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460778; c=relaxed/simple;
	bh=RIaw6SIDxVRv+x7wr647zjrBfs8ecORFYCFA25UlUZQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dh7R5vftHvqrdNTZdmsfhPEYcCvQ22vi2aa0fVATBtWh8aoPCR9MZbBrqJhr5KYa8/ChA6U62iZl/AgvlR1rpRs4u/EMjom4TmVB6u2JJ4971wxVoK38WMIqfqno2KO6iHBcXt1lc9mJ0xmOwsssGAEXlK5slqaJz2dD6rXixTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OWdo2tr+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742460776; x=1773996776;
  h=date:from:to:cc:subject:message-id;
  bh=RIaw6SIDxVRv+x7wr647zjrBfs8ecORFYCFA25UlUZQ=;
  b=OWdo2tr+jHW8FQaU/dxWmOLodspBvdszU5o4aNvpdQT4fkRIH2cie9Oq
   fsktiJ+E53uaaBwJKCMtf/OsX493JyxVRwKocAORshtUppQX8s9kOl9Hy
   DLXX8nH8B8u4+Pt5h7rY9SVamzhmAAMTollHG/wKy0j+FUZxeL/Al80rK
   yfNdaN6zVUybLoL7tFcKzyFHetsU+i4SZ2jGjv48PZ2ljyNrSmunnS4+c
   su3Tn85Rw/jVA3bdc/Eto2E+pmUJ3Y6Yn3txOKZpYje25gQ0iCEo4mafb
   MXcJ9u7pqsV0lCMiBxsE93pQ7lHLjxyNrefTxIUkV6xuGYdmArKw3VAdz
   w==;
X-CSE-ConnectionGUID: 6GBDfvbIR76enSai3077PA==
X-CSE-MsgGUID: uyaPxgU4RZWBydGuZf9AoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="53894841"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="53894841"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 01:52:55 -0700
X-CSE-ConnectionGUID: YXcdXFVGQiKG9citik9hWQ==
X-CSE-MsgGUID: jW8xnBqySxqtg+uKH3ucfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="123963376"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 20 Mar 2025 01:52:53 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvBdz-0000Jj-2N;
	Thu, 20 Mar 2025 08:52:51 +0000
Date: Thu, 20 Mar 2025 16:52:03 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 79195147644653ebffadece31a42181e4c48c07d
Message-ID: <202503201653.xyVAM0gp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 79195147644653ebffadece31a42181e4c48c07d  RDMA/mlx5: Fix calculation of total invalidated pages

elapsed time: 2772m

configs tested: 253
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                             allnoconfig    gcc-6.5.0
alpha                            allyesconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-9.3.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-13.3.0
arc                               allnoconfig    gcc-8.5.0
arc                              allyesconfig    gcc-10.5.0
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250318    gcc-8.5.0
arc                   randconfig-001-20250319    gcc-14.2.0
arc                   randconfig-001-20250320    gcc-10.5.0
arc                   randconfig-002-20250318    gcc-8.5.0
arc                   randconfig-002-20250319    gcc-14.2.0
arc                   randconfig-002-20250320    gcc-8.5.0
arm                              allmodconfig    gcc-13.3.0
arm                              allmodconfig    gcc-8.5.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                              allyesconfig    gcc-6.5.0
arm                                 defconfig    clang-14
arm                   randconfig-001-20250318    gcc-14.2.0
arm                   randconfig-001-20250319    clang-18
arm                   randconfig-001-20250320    clang-20
arm                   randconfig-002-20250318    clang-21
arm                   randconfig-002-20250319    clang-21
arm                   randconfig-002-20250320    clang-16
arm                   randconfig-003-20250318    gcc-14.2.0
arm                   randconfig-003-20250319    clang-20
arm                   randconfig-003-20250320    gcc-8.5.0
arm                   randconfig-004-20250318    clang-21
arm                   randconfig-004-20250319    clang-16
arm                   randconfig-004-20250320    gcc-7.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-8.5.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250318    clang-21
arm64                 randconfig-001-20250319    gcc-7.5.0
arm64                 randconfig-001-20250320    clang-21
arm64                 randconfig-002-20250318    clang-14
arm64                 randconfig-002-20250319    gcc-7.5.0
arm64                 randconfig-003-20250318    gcc-13.3.0
arm64                 randconfig-003-20250319    gcc-7.5.0
arm64                 randconfig-004-20250318    gcc-6.5.0
arm64                 randconfig-004-20250319    gcc-7.5.0
csky                              allnoconfig    gcc-14.2.0
csky                              allnoconfig    gcc-9.3.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250318    gcc-14.2.0
csky                  randconfig-001-20250319    gcc-9.3.0
csky                  randconfig-001-20250320    gcc-10.5.0
csky                  randconfig-002-20250318    gcc-14.2.0
csky                  randconfig-002-20250319    gcc-14.2.0
csky                  randconfig-002-20250320    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250318    clang-21
hexagon               randconfig-001-20250319    clang-21
hexagon               randconfig-001-20250320    clang-18
hexagon               randconfig-002-20250318    clang-17
hexagon               randconfig-002-20250319    clang-16
hexagon               randconfig-002-20250320    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250318    clang-20
i386        buildonly-randconfig-001-20250319    gcc-12
i386        buildonly-randconfig-001-20250320    gcc-12
i386        buildonly-randconfig-002-20250318    clang-20
i386        buildonly-randconfig-002-20250319    gcc-12
i386        buildonly-randconfig-002-20250320    clang-20
i386        buildonly-randconfig-003-20250318    clang-20
i386        buildonly-randconfig-003-20250319    gcc-12
i386        buildonly-randconfig-003-20250320    clang-20
i386        buildonly-randconfig-004-20250318    clang-20
i386        buildonly-randconfig-004-20250319    clang-20
i386        buildonly-randconfig-004-20250320    clang-20
i386        buildonly-randconfig-005-20250318    clang-20
i386        buildonly-randconfig-005-20250319    gcc-12
i386        buildonly-randconfig-005-20250320    gcc-12
i386        buildonly-randconfig-006-20250318    clang-20
i386        buildonly-randconfig-006-20250319    clang-20
i386        buildonly-randconfig-006-20250320    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-12.4.0
loongarch                         allnoconfig    gcc-13.3.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250318    gcc-14.2.0
loongarch             randconfig-001-20250319    gcc-14.2.0
loongarch             randconfig-001-20250320    gcc-14.2.0
loongarch             randconfig-002-20250318    gcc-14.2.0
loongarch             randconfig-002-20250319    gcc-14.2.0
loongarch             randconfig-002-20250320    gcc-12.4.0
m68k                             allmodconfig    gcc-8.5.0
m68k                              allnoconfig    gcc-5.5.0
m68k                             allyesconfig    gcc-6.5.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5249evb_defconfig    gcc-9.3.0
microblaze                       allmodconfig    gcc-9.3.0
microblaze                        allnoconfig    gcc-11.5.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-9.3.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-10.5.0
mips                          ath25_defconfig    clang-21
mips                    maltaup_xpa_defconfig    gcc-6.5.0
mips                        qi_lb60_defconfig    clang-21
nios2                         3c120_defconfig    gcc-7.5.0
nios2                             allnoconfig    gcc-8.5.0
nios2                 randconfig-001-20250318    gcc-9.3.0
nios2                 randconfig-001-20250319    gcc-11.5.0
nios2                 randconfig-001-20250320    gcc-6.5.0
nios2                 randconfig-002-20250318    gcc-5.5.0
nios2                 randconfig-002-20250319    gcc-5.5.0
nios2                 randconfig-002-20250320    gcc-12.4.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-10.5.0
parisc                           allmodconfig    gcc-5.5.0
parisc                            allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-5.5.0
parisc                           allyesconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-9.3.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250318    gcc-8.5.0
parisc                randconfig-001-20250319    gcc-10.5.0
parisc                randconfig-001-20250320    gcc-13.3.0
parisc                randconfig-002-20250318    gcc-14.2.0
parisc                randconfig-002-20250319    gcc-10.5.0
parisc                randconfig-002-20250320    gcc-11.5.0
powerpc                          allmodconfig    gcc-10.5.0
powerpc                          allmodconfig    gcc-5.5.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-8.5.0
powerpc                          allyesconfig    clang-21
powerpc               randconfig-001-20250318    clang-21
powerpc               randconfig-001-20250319    gcc-9.3.0
powerpc               randconfig-001-20250320    gcc-6.5.0
powerpc               randconfig-002-20250318    clang-21
powerpc               randconfig-002-20250319    clang-21
powerpc               randconfig-002-20250320    clang-21
powerpc               randconfig-003-20250318    gcc-14.2.0
powerpc               randconfig-003-20250319    clang-21
powerpc               randconfig-003-20250320    clang-21
powerpc64                        alldefconfig    clang-21
powerpc64             randconfig-001-20250318    clang-21
powerpc64             randconfig-001-20250319    clang-20
powerpc64             randconfig-001-20250320    clang-21
powerpc64             randconfig-002-20250318    gcc-14.2.0
powerpc64             randconfig-002-20250319    gcc-5.5.0
powerpc64             randconfig-002-20250320    gcc-8.5.0
powerpc64             randconfig-003-20250318    gcc-8.5.0
powerpc64             randconfig-003-20250319    clang-21
powerpc64             randconfig-003-20250320    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                             allnoconfig    gcc-7.5.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250318    clang-21
riscv                 randconfig-001-20250319    clang-20
riscv                 randconfig-001-20250320    clang-21
riscv                 randconfig-002-20250318    clang-21
riscv                 randconfig-002-20250319    clang-17
riscv                 randconfig-002-20250320    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-13.2.0
s390                             allyesconfig    gcc-14.2.0
s390                             allyesconfig    gcc-8.5.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250318    clang-15
s390                  randconfig-001-20250319    gcc-6.5.0
s390                  randconfig-001-20250320    gcc-5.5.0
s390                  randconfig-002-20250318    gcc-12.4.0
s390                  randconfig-002-20250319    gcc-8.5.0
s390                  randconfig-002-20250320    gcc-7.5.0
sh                               allmodconfig    gcc-14.2.0
sh                               allmodconfig    gcc-9.3.0
sh                                allnoconfig    gcc-10.5.0
sh                               allyesconfig    gcc-14.2.0
sh                               allyesconfig    gcc-7.5.0
sh                                  defconfig    gcc-11.5.0
sh                    randconfig-001-20250318    gcc-14.2.0
sh                    randconfig-001-20250319    gcc-11.5.0
sh                    randconfig-001-20250320    gcc-14.2.0
sh                    randconfig-002-20250318    gcc-7.5.0
sh                    randconfig-002-20250319    gcc-5.5.0
sh                    randconfig-002-20250320    gcc-10.5.0
sh                  sh7785lcr_32bit_defconfig    gcc-7.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-6.5.0
sparc                             allnoconfig    gcc-6.5.0
sparc                 randconfig-001-20250318    gcc-14.2.0
sparc                 randconfig-001-20250319    gcc-6.5.0
sparc                 randconfig-001-20250320    gcc-7.5.0
sparc                 randconfig-002-20250318    gcc-14.2.0
sparc                 randconfig-002-20250319    gcc-8.5.0
sparc                 randconfig-002-20250320    gcc-7.5.0
sparc64                             defconfig    gcc-10.5.0
sparc64               randconfig-001-20250318    gcc-11.5.0
sparc64               randconfig-001-20250319    gcc-8.5.0
sparc64               randconfig-001-20250320    gcc-5.5.0
sparc64               randconfig-002-20250318    gcc-11.5.0
sparc64               randconfig-002-20250319    gcc-6.5.0
sparc64               randconfig-002-20250320    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250318    clang-21
um                    randconfig-001-20250319    gcc-12
um                    randconfig-001-20250320    gcc-12
um                    randconfig-002-20250318    gcc-12
um                    randconfig-002-20250319    gcc-11
um                    randconfig-002-20250320    clang-16
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250318    clang-20
x86_64      buildonly-randconfig-001-20250319    clang-20
x86_64      buildonly-randconfig-001-20250320    clang-20
x86_64      buildonly-randconfig-002-20250318    clang-20
x86_64      buildonly-randconfig-002-20250319    clang-20
x86_64      buildonly-randconfig-002-20250320    gcc-12
x86_64      buildonly-randconfig-003-20250318    clang-20
x86_64      buildonly-randconfig-003-20250319    gcc-12
x86_64      buildonly-randconfig-003-20250320    clang-20
x86_64      buildonly-randconfig-004-20250318    clang-20
x86_64      buildonly-randconfig-004-20250319    gcc-11
x86_64      buildonly-randconfig-004-20250320    clang-20
x86_64      buildonly-randconfig-005-20250318    gcc-12
x86_64      buildonly-randconfig-005-20250319    clang-20
x86_64      buildonly-randconfig-005-20250320    clang-20
x86_64      buildonly-randconfig-006-20250318    gcc-12
x86_64      buildonly-randconfig-006-20250319    clang-20
x86_64      buildonly-randconfig-006-20250320    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                generic_kc705_defconfig    gcc-7.5.0
xtensa                randconfig-001-20250318    gcc-14.2.0
xtensa                randconfig-001-20250319    gcc-10.5.0
xtensa                randconfig-001-20250320    gcc-9.3.0
xtensa                randconfig-002-20250318    gcc-7.5.0
xtensa                randconfig-002-20250319    gcc-12.4.0
xtensa                randconfig-002-20250320    gcc-11.5.0
xtensa                    smp_lx200_defconfig    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

