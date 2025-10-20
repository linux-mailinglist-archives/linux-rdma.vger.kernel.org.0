Return-Path: <linux-rdma+bounces-13941-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C745BEF328
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Oct 2025 05:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D126D348D81
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Oct 2025 03:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E722BD035;
	Mon, 20 Oct 2025 03:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JVUXATgF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E0326B2CE
	for <linux-rdma@vger.kernel.org>; Mon, 20 Oct 2025 03:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760931281; cv=none; b=QUBFeL/VOD4osJvQynpXVDypbMflQ0v8c8NQ8XzO4U1q/LEUr9jp1gyc0NFbHijDl6I+MKCZsXbQydZHgo1U6SrdEEgqSbPIU1+g4fmYuxYn29eZIohR+OnjobsIJgnu/apluHpy6Tz1dRN4UZzt4pFc2bjObSWlcEj3SR9Oc20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760931281; c=relaxed/simple;
	bh=ogjFiyzeVoyoqOyaQ0aay6ZteTyHf2EWJikefaCxKtg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KsWiZR+hJfl6LAuOD/5z2JXe4A3mMILGGqGQQ8CWDpaIGtry5AlxL3EyC1YG+CihsfJ6RvymOVyGVnXIy4xCW3xG0OHFnnmYW/p3bsNqEbGuSlaFdP4tQ14EJK8ETNazfi1XisOrrIxAVri9JAHeb5l8A4Pptzx0oM3xru7oyGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JVUXATgF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760931280; x=1792467280;
  h=date:from:to:cc:subject:message-id;
  bh=ogjFiyzeVoyoqOyaQ0aay6ZteTyHf2EWJikefaCxKtg=;
  b=JVUXATgFF2LndcMUSKPacp2q0I8Rq5zF3MlythN8fxP6mmMMKJp4J05R
   j+fnOuPN4jB6q6PQHzcK2P6x4QLMtG1RaiUx0qGsfJ3nN6iTzMfs2jo4n
   Ywj+SGPQju0dHaJjOUF/657LdYrn9YM9urwBFLUVpQsIftW22oeYnCOHz
   kHqUEDhne1aFFcSuZizZIRmx29Jidi7YyQE8YAKD+hXpQ9YgppSblPK2x
   YRQprFl33sYIEnLjp+H5ryW5xhy/K+LnHHFCzlQT9mdmh6UAM4vQtzv6G
   Gq6yhXVJZndxLEeo7qxamqeGnR/YFgq1knmfGsyNik1FBnzYwUW1QwFRk
   g==;
X-CSE-ConnectionGUID: ljVs7jVpSMOiA9PZf1y3jw==
X-CSE-MsgGUID: h4pNJiqLRAaIYiOHrQJWLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="88515901"
X-IronPort-AV: E=Sophos;i="6.19,241,1754982000"; 
   d="scan'208";a="88515901"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 20:34:39 -0700
X-CSE-ConnectionGUID: Lmw/8KRoS8iCjH1CkzgYXw==
X-CSE-MsgGUID: x5vdNCtlS1yXg6lo4bwg7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,241,1754982000"; 
   d="scan'208";a="182783251"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 19 Oct 2025 20:34:37 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vAgf5-0009Sv-21;
	Mon, 20 Oct 2025 03:34:20 +0000
Date: Mon, 20 Oct 2025 11:33:21 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 d8713158faad0fd4418cb2f4e432c3876ad53a1f
Message-ID: <202510201114.d207yeF7-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: d8713158faad0fd4418cb2f4e432c3876ad53a1f  RDMA/uverbs: Fix umem release in UVERBS_METHOD_CQ_CREATE

elapsed time: 907m

configs tested: 169
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20251019    gcc-8.5.0
arc                   randconfig-002-20251019    gcc-13.4.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                          pxa3xx_defconfig    clang-22
arm                   randconfig-001-20251019    clang-22
arm                   randconfig-002-20251019    gcc-11.5.0
arm                   randconfig-003-20251019    clang-22
arm                   randconfig-004-20251019    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251019    gcc-13.4.0
arm64                 randconfig-002-20251019    clang-18
arm64                 randconfig-003-20251019    gcc-13.4.0
arm64                 randconfig-004-20251019    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251019    gcc-13.4.0
csky                  randconfig-002-20251019    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251019    clang-20
hexagon               randconfig-002-20251019    clang-17
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251019    clang-20
i386        buildonly-randconfig-002-20251019    gcc-14
i386        buildonly-randconfig-003-20251019    gcc-14
i386        buildonly-randconfig-004-20251019    clang-20
i386        buildonly-randconfig-005-20251019    gcc-13
i386        buildonly-randconfig-006-20251019    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251020    gcc-14
i386                  randconfig-002-20251020    gcc-14
i386                  randconfig-003-20251020    gcc-14
i386                  randconfig-004-20251020    gcc-14
i386                  randconfig-005-20251020    gcc-14
i386                  randconfig-006-20251020    gcc-14
i386                  randconfig-007-20251020    gcc-14
i386                  randconfig-011-20251020    clang-20
i386                  randconfig-012-20251020    clang-20
i386                  randconfig-013-20251020    clang-20
i386                  randconfig-014-20251020    clang-20
i386                  randconfig-015-20251020    clang-20
i386                  randconfig-016-20251020    clang-20
i386                  randconfig-017-20251020    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251019    clang-18
loongarch             randconfig-002-20251019    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                        m5407c3_defconfig    gcc-15.1.0
m68k                          sun3x_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                         3c120_defconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251019    gcc-8.5.0
nios2                 randconfig-002-20251019    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251019    gcc-15.1.0
parisc                randconfig-002-20251019    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                     kmeter1_defconfig    gcc-15.1.0
powerpc                 mpc832x_rdb_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251019    clang-17
powerpc               randconfig-002-20251019    gcc-10.5.0
powerpc               randconfig-003-20251019    gcc-11.5.0
powerpc64             randconfig-001-20251019    gcc-8.5.0
powerpc64             randconfig-002-20251019    clang-16
powerpc64             randconfig-003-20251019    gcc-15.1.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251019    clang-19
riscv                 randconfig-002-20251019    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251019    gcc-8.5.0
s390                  randconfig-002-20251019    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                          kfr2r09_defconfig    gcc-15.1.0
sh                          r7785rp_defconfig    gcc-15.1.0
sh                    randconfig-001-20251019    gcc-15.1.0
sh                    randconfig-002-20251019    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251019    gcc-11.5.0
sparc                 randconfig-002-20251019    gcc-13.4.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251019    gcc-8.5.0
sparc64               randconfig-002-20251019    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251019    gcc-13
um                    randconfig-002-20251019    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251019    clang-20
x86_64      buildonly-randconfig-002-20251019    gcc-13
x86_64      buildonly-randconfig-003-20251019    clang-20
x86_64      buildonly-randconfig-004-20251019    gcc-14
x86_64      buildonly-randconfig-005-20251019    clang-20
x86_64      buildonly-randconfig-006-20251019    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251020    clang-20
x86_64                randconfig-002-20251020    clang-20
x86_64                randconfig-003-20251020    clang-20
x86_64                randconfig-004-20251020    clang-20
x86_64                randconfig-005-20251020    clang-20
x86_64                randconfig-006-20251020    clang-20
x86_64                randconfig-007-20251020    clang-20
x86_64                randconfig-008-20251020    clang-20
x86_64                randconfig-071-20251020    clang-20
x86_64                randconfig-072-20251020    clang-20
x86_64                randconfig-073-20251020    clang-20
x86_64                randconfig-074-20251020    clang-20
x86_64                randconfig-075-20251020    clang-20
x86_64                randconfig-076-20251020    clang-20
x86_64                randconfig-077-20251020    clang-20
x86_64                randconfig-078-20251020    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251019    gcc-14.3.0
xtensa                randconfig-002-20251019    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

