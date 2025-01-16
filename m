Return-Path: <linux-rdma+bounces-7032-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3A5A13091
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2025 02:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0DD63A5329
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2025 01:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E334F17BD3;
	Thu, 16 Jan 2025 01:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P0MTGJ7I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB34929A1
	for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2025 01:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990154; cv=none; b=BbZsjqrCwXXMaInFT9dqulwWlKREnBMHFE8KSUiDrFLGZxRdX2BHop04X50tEd+Yr8D0clZep7AXQpLhQ+fPmFsUwDYRd+EJN53KNvU3c04xCvfIRRWIsi/rhqI0ysyd69s23dEu+WGAP6ij/ATaXtfIUBw/X2eGL9NDt8rSgLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990154; c=relaxed/simple;
	bh=VX1zxE1LmQ9t6UHhEQdobnKG+XzCaF+Hd3L4FpU4Omw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MxCdapjW+2nqz65YZAp9hBFRmQDy3zwfzwYkVD+f0aNUENRDM+XBReE68LZC76f7qkZkvFChd0xqn9YZpBXZgZFNfK23pThLi9jNJSlWQeDzvWAOHiv42Y5SVj4ZpY5bekOZjrH542KxcpWoLF3z8EzMcRE4Vjqo6mF1XEYBTdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P0MTGJ7I; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736990152; x=1768526152;
  h=date:from:to:cc:subject:message-id;
  bh=VX1zxE1LmQ9t6UHhEQdobnKG+XzCaF+Hd3L4FpU4Omw=;
  b=P0MTGJ7I4iDdQsil4tpmD4bCINM7CsChBLsLqzAo/KILGrmqGZD2YnQd
   nvkqlB1aibTc7Bsab44mvVcZPOrFMl6Fr9r/Qii+DFfhVOqzP0TJcvqu4
   t2UPKwZ6pycyBA3uOebVhaXNoKmX8eQpg4f4dm4EP6Zr5UXMghTFWADM9
   Cz/kaA/7xXhDjRTO0o58yCFyyAVsxmtGEUCBoH0lIEeG7nm5Eu+M5pgq3
   JY+D/TLtcMTw8ZIY2OTIYADQQ01WL/ddxjQPKrOL+w0OxwJNZyxtQKFDM
   tH0CjvFWuqPrIkyxmOa9Yh72kyXe/QNTCDWNUDGNksRV169GJEYB8qzzF
   w==;
X-CSE-ConnectionGUID: qhTiEnh9Q/a3JjkRLGMA5A==
X-CSE-MsgGUID: Mxv9OYEcQA+VSQqUk9O1mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="37510694"
X-IronPort-AV: E=Sophos;i="6.13,207,1732608000"; 
   d="scan'208";a="37510694"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 17:15:52 -0800
X-CSE-ConnectionGUID: jQsyv5GYS7OY34Xu57Ucjw==
X-CSE-MsgGUID: tw2MFB2BRY22CJCQPpDk7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,207,1732608000"; 
   d="scan'208";a="136155885"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 15 Jan 2025 17:15:51 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYEU8-000R5J-2b;
	Thu, 16 Jan 2025 01:15:48 +0000
Date: Thu, 16 Jan 2025 09:15:02 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/for-testing] BUILD SUCCESS
 a4fdb96b28ccb545148b38c6bae6b84258547b6e
Message-ID: <202501160956.na6vLoIT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/for-testing
branch HEAD: a4fdb96b28ccb545148b38c6bae6b84258547b6e  Merge remote-tracking branch 'linus/master' into k.o/wip/for-testing

elapsed time: 1455m

configs tested: 79
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
arc                               allnoconfig    gcc-13.2.0
arc                      axs103_smp_defconfig    gcc-13.2.0
arc                   randconfig-001-20250115    gcc-13.2.0
arc                   randconfig-002-20250115    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                          gemini_defconfig    clang-20
arm                   randconfig-001-20250115    clang-16
arm                   randconfig-002-20250115    clang-20
arm                   randconfig-003-20250115    clang-20
arm                   randconfig-004-20250115    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250115    clang-20
arm64                 randconfig-002-20250115    gcc-14.2.0
arm64                 randconfig-003-20250115    clang-18
arm64                 randconfig-004-20250115    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250115    gcc-14.2.0
csky                  randconfig-002-20250115    gcc-14.2.0
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20250115    clang-20
hexagon               randconfig-002-20250115    clang-19
i386        buildonly-randconfig-001-20250115    clang-19
i386        buildonly-randconfig-002-20250115    gcc-12
i386        buildonly-randconfig-003-20250115    gcc-12
i386        buildonly-randconfig-004-20250115    gcc-12
i386        buildonly-randconfig-005-20250115    gcc-12
i386        buildonly-randconfig-006-20250115    gcc-12
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250115    gcc-14.2.0
loongarch             randconfig-002-20250115    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250115    gcc-14.2.0
nios2                 randconfig-002-20250115    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250115    gcc-14.2.0
parisc                randconfig-002-20250115    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250115    gcc-14.2.0
powerpc               randconfig-002-20250115    gcc-14.2.0
powerpc               randconfig-003-20250115    gcc-14.2.0
powerpc64             randconfig-001-20250115    gcc-14.2.0
powerpc64             randconfig-002-20250115    gcc-14.2.0
powerpc64             randconfig-003-20250115    clang-18
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250115    gcc-14.2.0
riscv                 randconfig-002-20250115    clang-16
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250115    clang-20
s390                  randconfig-002-20250115    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250115    gcc-14.2.0
sh                    randconfig-002-20250115    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250115    gcc-14.2.0
sparc                 randconfig-002-20250115    gcc-14.2.0
sparc64               randconfig-001-20250115    gcc-14.2.0
sparc64               randconfig-002-20250115    gcc-14.2.0
um                                allnoconfig    clang-18
um                    randconfig-001-20250115    clang-18
um                    randconfig-002-20250115    gcc-12
x86_64      buildonly-randconfig-001-20250115    gcc-12
x86_64      buildonly-randconfig-002-20250115    gcc-12
x86_64      buildonly-randconfig-003-20250115    clang-19
x86_64      buildonly-randconfig-004-20250115    clang-19
x86_64      buildonly-randconfig-005-20250115    gcc-12
x86_64      buildonly-randconfig-006-20250115    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250115    gcc-14.2.0
xtensa                randconfig-002-20250115    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

