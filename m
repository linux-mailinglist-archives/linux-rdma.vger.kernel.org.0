Return-Path: <linux-rdma+bounces-8702-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38557A6110A
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 13:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6046881C1E
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 12:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418DD1C84DB;
	Fri, 14 Mar 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hs1CFxZz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B3F1FE47A
	for <linux-rdma@vger.kernel.org>; Fri, 14 Mar 2025 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955091; cv=none; b=IVZoxjwYP+Xi0mPI16HX4JUkt3dLdh8QaOMF/N7E2aP2Xrrpvccsa6J2mNtvuJ0JHmJl2i4SVzX0Ktil+VWKiqo3YtTr7qddN8PbOL+10wvBGVAWE3otcRZ9te12fLk4M+g6z2gFEvhR4qDGBKCIxbyS3Ny/bsch/0X8pjOHVPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955091; c=relaxed/simple;
	bh=mr9sO8blqFfSdRqrVLOmnyVk0ZGVwdZs24243vQSyYU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OAjIHE9hukoOBjk/8CqQurF4zi1VN2zp+c5J0t16fLiYYONcS4MxqLgdK6JehGGwj/X4iTPdLHOo8ZfutkPLtQZvbhoCj5RRzT8kOgc5aQjvSGvRqZ9oOhz/w7mQdUgnCvMn7FSqE2238rZ/01nSwZLsIyc0T6vfNplYX1zW6B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hs1CFxZz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741955089; x=1773491089;
  h=date:from:to:cc:subject:message-id;
  bh=mr9sO8blqFfSdRqrVLOmnyVk0ZGVwdZs24243vQSyYU=;
  b=hs1CFxZzSye9eeimhB6cpk2b/5qEUMYlQTsmUvqmpT3bHR5MZUyCWxYa
   EHyH3V6EYvvC8qf667xB2+vJP3S6v3e5DlmvaAIODm4xr8hnSINITk0q2
   BTiXCcgcA/3ocls8aGP2uK5ICARBWVE+PEfJkvLqZEGkIt4dXN1C4cwq0
   /kIHpAsm7KwNx6Krzm0cscyJ7ADFIBY5qeuAcVWwHZxy6DYUe773g3WrZ
   D5zi7IMV5Ny5QmwvhujryJpeRAXoX0eGYpb7vo+3vYCUCCkucotzHkRvN
   Q3acuCAdUmJ9pVMjNytvoSoP+tMKVHjHWNZBZ+vJULCjB5CTzbi7h0TYp
   A==;
X-CSE-ConnectionGUID: iCF/rGTqS8GZwuj30Cxhzg==
X-CSE-MsgGUID: TXYXWgTzQJSX9yye/wVoUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42274447"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="42274447"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 05:24:48 -0700
X-CSE-ConnectionGUID: K6aj/rq6QAuHGo5CYasnfA==
X-CSE-MsgGUID: GeEOmd+/QaGdxo6vAgGR1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121057760"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 14 Mar 2025 05:24:46 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tt45k-000ARP-2R;
	Fri, 14 Mar 2025 12:24:44 +0000
Date: Fri, 14 Mar 2025 20:24:15 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 0a924decd4a3a27c557a6d3c29add61d45ab592a
Message-ID: <202503142009.yukpMdtQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 0a924decd4a3a27c557a6d3c29add61d45ab592a  RDMA/rxe: Improve readability of ODP pagefault interface

elapsed time: 2459m

configs tested: 315
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                          axs103_defconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20250313    clang-18
arc                   randconfig-001-20250313    gcc-13.2.0
arc                   randconfig-001-20250314    gcc-13.2.0
arc                   randconfig-002-20250313    clang-18
arc                   randconfig-002-20250313    gcc-13.2.0
arc                   randconfig-002-20250314    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g5_defconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                           h3600_defconfig    gcc-14.2.0
arm                       imx_v6_v7_defconfig    gcc-14.2.0
arm                          pxa910_defconfig    gcc-14.2.0
arm                   randconfig-001-20250313    clang-16
arm                   randconfig-001-20250313    clang-18
arm                   randconfig-001-20250314    clang-21
arm                   randconfig-002-20250313    clang-18
arm                   randconfig-002-20250314    gcc-14.2.0
arm                   randconfig-003-20250313    clang-18
arm                   randconfig-003-20250313    gcc-14.2.0
arm                   randconfig-003-20250314    gcc-14.2.0
arm                   randconfig-004-20250313    clang-18
arm                   randconfig-004-20250313    clang-21
arm                   randconfig-004-20250314    gcc-14.2.0
arm                           sama5_defconfig    gcc-14.2.0
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                            allyesconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250313    clang-18
arm64                 randconfig-001-20250314    gcc-14.2.0
arm64                 randconfig-002-20250313    clang-16
arm64                 randconfig-002-20250313    clang-18
arm64                 randconfig-002-20250314    clang-21
arm64                 randconfig-003-20250313    clang-18
arm64                 randconfig-003-20250313    gcc-14.2.0
arm64                 randconfig-003-20250314    clang-15
arm64                 randconfig-004-20250313    clang-18
arm64                 randconfig-004-20250313    clang-21
arm64                 randconfig-004-20250314    clang-21
csky                             allmodconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                             allyesconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250313    gcc-14.2.0
csky                  randconfig-001-20250314    gcc-14.2.0
csky                  randconfig-002-20250313    gcc-14.2.0
csky                  randconfig-002-20250314    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250313    clang-17
hexagon               randconfig-001-20250313    gcc-14.2.0
hexagon               randconfig-001-20250314    clang-21
hexagon               randconfig-002-20250313    clang-21
hexagon               randconfig-002-20250313    gcc-14.2.0
hexagon               randconfig-002-20250314    clang-21
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20250313    clang-19
i386        buildonly-randconfig-001-20250313    gcc-12
i386        buildonly-randconfig-001-20250314    clang-19
i386        buildonly-randconfig-002-20250313    clang-19
i386        buildonly-randconfig-002-20250313    gcc-12
i386        buildonly-randconfig-002-20250314    clang-19
i386        buildonly-randconfig-003-20250313    clang-19
i386        buildonly-randconfig-003-20250314    gcc-12
i386        buildonly-randconfig-004-20250313    clang-19
i386        buildonly-randconfig-004-20250313    gcc-12
i386        buildonly-randconfig-004-20250314    gcc-12
i386        buildonly-randconfig-005-20250313    clang-19
i386        buildonly-randconfig-005-20250314    gcc-12
i386        buildonly-randconfig-006-20250313    clang-19
i386        buildonly-randconfig-006-20250313    gcc-12
i386        buildonly-randconfig-006-20250314    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250313    clang-19
i386                  randconfig-001-20250314    clang-19
i386                  randconfig-002-20250313    clang-19
i386                  randconfig-002-20250314    clang-19
i386                  randconfig-003-20250313    clang-19
i386                  randconfig-003-20250314    clang-19
i386                  randconfig-004-20250313    clang-19
i386                  randconfig-004-20250314    clang-19
i386                  randconfig-005-20250313    clang-19
i386                  randconfig-005-20250314    clang-19
i386                  randconfig-006-20250313    clang-19
i386                  randconfig-006-20250314    clang-19
i386                  randconfig-007-20250313    clang-19
i386                  randconfig-007-20250314    clang-19
i386                  randconfig-011-20250313    clang-19
i386                  randconfig-011-20250314    gcc-11
i386                  randconfig-012-20250313    clang-19
i386                  randconfig-012-20250314    gcc-11
i386                  randconfig-013-20250313    clang-19
i386                  randconfig-013-20250314    gcc-11
i386                  randconfig-014-20250313    clang-19
i386                  randconfig-014-20250314    gcc-11
i386                  randconfig-015-20250313    clang-19
i386                  randconfig-015-20250314    gcc-11
i386                  randconfig-016-20250313    clang-19
i386                  randconfig-016-20250314    gcc-11
i386                  randconfig-017-20250313    clang-19
i386                  randconfig-017-20250314    gcc-11
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                        allyesconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250313    gcc-14.2.0
loongarch             randconfig-001-20250314    gcc-14.2.0
loongarch             randconfig-002-20250313    gcc-14.2.0
loongarch             randconfig-002-20250314    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                             allmodconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                             allyesconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
mips                            gpr_defconfig    gcc-13.2.0
mips                           ip30_defconfig    gcc-13.2.0
nios2                         10m50_defconfig    gcc-14.2.0
nios2                         3c120_defconfig    gcc-14.2.0
nios2                            alldefconfig    gcc-14.2.0
nios2                            allmodconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                            allyesconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250313    gcc-14.2.0
nios2                 randconfig-001-20250314    gcc-14.2.0
nios2                 randconfig-002-20250313    gcc-14.2.0
nios2                 randconfig-002-20250314    gcc-14.2.0
openrisc                         alldefconfig    gcc-13.2.0
openrisc                         allmodconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250313    gcc-14.2.0
parisc                randconfig-001-20250314    gcc-14.2.0
parisc                randconfig-002-20250313    gcc-14.2.0
parisc                randconfig-002-20250314    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                          allyesconfig    clang-16
powerpc                   currituck_defconfig    gcc-14.2.0
powerpc                      katmai_defconfig    gcc-14.2.0
powerpc                     kmeter1_defconfig    gcc-14.2.0
powerpc                 mpc8313_rdb_defconfig    gcc-14.2.0
powerpc                  mpc866_ads_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250313    clang-16
powerpc               randconfig-001-20250313    gcc-14.2.0
powerpc               randconfig-001-20250314    clang-21
powerpc               randconfig-002-20250313    clang-18
powerpc               randconfig-002-20250313    gcc-14.2.0
powerpc               randconfig-002-20250314    gcc-14.2.0
powerpc               randconfig-003-20250313    gcc-14.2.0
powerpc               randconfig-003-20250314    gcc-14.2.0
powerpc64             randconfig-001-20250313    gcc-14.2.0
powerpc64             randconfig-001-20250314    gcc-14.2.0
powerpc64             randconfig-002-20250313    gcc-14.2.0
powerpc64             randconfig-002-20250314    clang-17
powerpc64             randconfig-003-20250313    gcc-14.2.0
powerpc64             randconfig-003-20250314    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-15
riscv                            allyesconfig    clang-21
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250313    clang-21
riscv                 randconfig-001-20250313    gcc-14.2.0
riscv                 randconfig-001-20250314    clang-19
riscv                 randconfig-002-20250313    clang-21
riscv                 randconfig-002-20250313    gcc-14.2.0
riscv                 randconfig-002-20250314    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250313    clang-15
s390                  randconfig-001-20250313    gcc-14.2.0
s390                  randconfig-001-20250314    gcc-14.2.0
s390                  randconfig-002-20250313    clang-15
s390                  randconfig-002-20250313    gcc-14.2.0
s390                  randconfig-002-20250314    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                          polaris_defconfig    gcc-13.2.0
sh                    randconfig-001-20250313    gcc-14.2.0
sh                    randconfig-001-20250314    gcc-14.2.0
sh                    randconfig-002-20250313    gcc-14.2.0
sh                    randconfig-002-20250314    gcc-14.2.0
sh                          rsk7203_defconfig    gcc-13.2.0
sh                          rsk7264_defconfig    gcc-14.2.0
sh                          rsk7269_defconfig    gcc-14.2.0
sh                           se7722_defconfig    gcc-14.2.0
sh                           sh2007_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                            allyesconfig    gcc-14.2.0
sparc                 randconfig-001-20250313    gcc-14.2.0
sparc                 randconfig-001-20250314    gcc-14.2.0
sparc                 randconfig-002-20250313    gcc-14.2.0
sparc                 randconfig-002-20250314    gcc-14.2.0
sparc                       sparc64_defconfig    gcc-14.2.0
sparc64                          allmodconfig    gcc-14.2.0
sparc64                          allyesconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250313    gcc-14.2.0
sparc64               randconfig-001-20250314    gcc-14.2.0
sparc64               randconfig-002-20250313    gcc-14.2.0
sparc64               randconfig-002-20250314    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-15
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250313    clang-21
um                    randconfig-001-20250313    gcc-14.2.0
um                    randconfig-001-20250314    gcc-12
um                    randconfig-002-20250313    clang-21
um                    randconfig-002-20250313    gcc-14.2.0
um                    randconfig-002-20250314    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250313    clang-19
x86_64      buildonly-randconfig-001-20250314    clang-19
x86_64      buildonly-randconfig-002-20250313    clang-19
x86_64      buildonly-randconfig-002-20250314    clang-19
x86_64      buildonly-randconfig-003-20250313    clang-19
x86_64      buildonly-randconfig-003-20250314    gcc-12
x86_64      buildonly-randconfig-004-20250313    clang-19
x86_64      buildonly-randconfig-004-20250313    gcc-12
x86_64      buildonly-randconfig-004-20250314    clang-19
x86_64      buildonly-randconfig-005-20250313    clang-19
x86_64      buildonly-randconfig-005-20250314    gcc-12
x86_64      buildonly-randconfig-006-20250313    clang-19
x86_64      buildonly-randconfig-006-20250313    gcc-12
x86_64      buildonly-randconfig-006-20250314    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250313    gcc-12
x86_64                randconfig-001-20250314    clang-19
x86_64                randconfig-002-20250313    gcc-12
x86_64                randconfig-002-20250314    clang-19
x86_64                randconfig-003-20250313    gcc-12
x86_64                randconfig-003-20250314    clang-19
x86_64                randconfig-004-20250313    gcc-12
x86_64                randconfig-004-20250314    clang-19
x86_64                randconfig-005-20250313    gcc-12
x86_64                randconfig-005-20250314    clang-19
x86_64                randconfig-006-20250313    gcc-12
x86_64                randconfig-006-20250314    clang-19
x86_64                randconfig-007-20250313    gcc-12
x86_64                randconfig-007-20250314    clang-19
x86_64                randconfig-008-20250313    gcc-12
x86_64                randconfig-008-20250314    clang-19
x86_64                randconfig-071-20250313    gcc-12
x86_64                randconfig-071-20250314    clang-19
x86_64                randconfig-072-20250313    gcc-12
x86_64                randconfig-072-20250314    clang-19
x86_64                randconfig-073-20250313    gcc-12
x86_64                randconfig-073-20250314    clang-19
x86_64                randconfig-074-20250313    gcc-12
x86_64                randconfig-074-20250314    clang-19
x86_64                randconfig-075-20250313    gcc-12
x86_64                randconfig-075-20250314    clang-19
x86_64                randconfig-076-20250313    gcc-12
x86_64                randconfig-076-20250314    clang-19
x86_64                randconfig-077-20250313    gcc-12
x86_64                randconfig-077-20250314    clang-19
x86_64                randconfig-078-20250313    gcc-12
x86_64                randconfig-078-20250314    clang-19
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-18
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                           allyesconfig    gcc-14.2.0
xtensa                randconfig-001-20250313    gcc-14.2.0
xtensa                randconfig-001-20250314    gcc-14.2.0
xtensa                randconfig-002-20250313    gcc-14.2.0
xtensa                randconfig-002-20250314    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

