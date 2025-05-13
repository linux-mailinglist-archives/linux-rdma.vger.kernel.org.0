Return-Path: <linux-rdma+bounces-10318-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DD6AB512C
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 12:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A47A7A339E
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 10:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAAE2459D9;
	Tue, 13 May 2025 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OkGG6bZv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F88C242923
	for <linux-rdma@vger.kernel.org>; Tue, 13 May 2025 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130687; cv=none; b=slDbrGEqarHkEq5lKd+K/ojuUxGrTxj52SiVukDgFHGrwEuOKSukBL8S+9O7U+a9zOj4Wk8oUPje5gPSIpm9NhsAGjU1wCcq31RwqabndB2tNgJcLgaAYgb40K8NzSPebTu0lZ/PIPeebfrdhtpdAFHt29tZRVkN9773FBVFzR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130687; c=relaxed/simple;
	bh=dMMmIrHYUE3J/CocBNKIgz83418lHGg80ZbPgZTPv2c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gd9AQscIRZ160+CX1feVoAcsLOBcdxxmATgMfZPASggcJ7REAbjhpVTXWnfl/QsBPIKcKBca88suhrqoz3fKdgN00+1tZINVj8DUU4SfW//DRErTQLp0euVhG3YAUNPuo6SFs7RfAZnhUqfGAjHC0qWUIPGV7USVrFTx6hT6cco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OkGG6bZv; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747130685; x=1778666685;
  h=date:from:to:cc:subject:message-id;
  bh=dMMmIrHYUE3J/CocBNKIgz83418lHGg80ZbPgZTPv2c=;
  b=OkGG6bZv9DX4XzJ7JUA6mj0BceKG0IPpvohaRFOsQgF83XvuoD/i7HO/
   h9bhw4PLpBrDUcUzP8GINsh081FGZDO+4YIEl7rJjxi1qjtvOCRsc4IXL
   xxZPKPGLk37jtFaYm4nux43KEXP2czDQxQDqO50RxA9Mu6HJ2LDVwQ1UV
   GGCCGpBXbucQdUg4GL2IlcaNiXBCCKMfYFLe+Zh72mVb02fp3XSWLqdQz
   /mnfHoS1KQTK7PSIkjEVcECzwGsd46FciC/RuXoWOYLUrP/BV5qp6KCZz
   8GEkuBAIAp8uoO7k7cIAgJ1e65VoJyeO+kDlHtYQhcoWByh+5ViNouhx2
   Q==;
X-CSE-ConnectionGUID: y1C2cbFpT+6cwYulTs4cXg==
X-CSE-MsgGUID: IRcpKyZdQhqk0zc+16Ucng==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="49084507"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="49084507"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 03:04:44 -0700
X-CSE-ConnectionGUID: 26wfYdKbT/yCmAs12ml0Aw==
X-CSE-MsgGUID: NP16WIasRJqADDvquoagaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="141710103"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 13 May 2025 03:04:42 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uEmV6-000Fxz-1b;
	Tue, 13 May 2025 10:04:40 +0000
Date: Tue, 13 May 2025 18:03:53 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 505cc26bcae00699bacaee66cd50ede7a9cc89cb
Message-ID: <202505131843.2bELahFW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 505cc26bcae00699bacaee66cd50ede7a9cc89cb  net: mana: Add support for auxiliary device servicing events

elapsed time: 1288m

configs tested: 180
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250512    gcc-14.2.0
arc                   randconfig-001-20250513    gcc-14.2.0
arc                   randconfig-002-20250512    gcc-11.5.0
arc                   randconfig-002-20250513    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                     am200epdkit_defconfig    gcc-14.2.0
arm                       aspeed_g4_defconfig    clang-21
arm                     davinci_all_defconfig    clang-19
arm                            qcom_defconfig    clang-21
arm                   randconfig-001-20250512    gcc-7.5.0
arm                   randconfig-001-20250513    gcc-7.5.0
arm                   randconfig-002-20250512    clang-17
arm                   randconfig-002-20250513    gcc-8.5.0
arm                   randconfig-003-20250512    gcc-6.5.0
arm                   randconfig-003-20250513    gcc-8.5.0
arm                   randconfig-004-20250512    clang-21
arm                   randconfig-004-20250513    clang-16
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250512    gcc-7.5.0
arm64                 randconfig-001-20250513    clang-21
arm64                 randconfig-002-20250512    clang-21
arm64                 randconfig-002-20250513    clang-21
arm64                 randconfig-003-20250512    clang-21
arm64                 randconfig-003-20250513    gcc-6.5.0
arm64                 randconfig-004-20250512    clang-21
arm64                 randconfig-004-20250513    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250512    gcc-9.3.0
csky                  randconfig-001-20250513    gcc-14.2.0
csky                  randconfig-002-20250512    gcc-14.2.0
csky                  randconfig-002-20250513    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250512    clang-20
hexagon               randconfig-001-20250513    clang-21
hexagon               randconfig-002-20250512    clang-21
hexagon               randconfig-002-20250513    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250512    gcc-11
i386        buildonly-randconfig-001-20250513    clang-20
i386        buildonly-randconfig-002-20250512    clang-20
i386        buildonly-randconfig-002-20250513    clang-20
i386        buildonly-randconfig-003-20250512    clang-20
i386        buildonly-randconfig-003-20250513    clang-20
i386        buildonly-randconfig-004-20250512    gcc-12
i386        buildonly-randconfig-004-20250513    clang-20
i386        buildonly-randconfig-005-20250512    clang-20
i386        buildonly-randconfig-005-20250513    gcc-12
i386        buildonly-randconfig-006-20250512    clang-20
i386        buildonly-randconfig-006-20250513    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250512    gcc-13.3.0
loongarch             randconfig-001-20250513    gcc-14.2.0
loongarch             randconfig-002-20250512    gcc-13.3.0
loongarch             randconfig-002-20250513    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                            q40_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                      maltaaprp_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250512    gcc-7.5.0
nios2                 randconfig-001-20250513    gcc-10.5.0
nios2                 randconfig-002-20250512    gcc-11.5.0
nios2                 randconfig-002-20250513    gcc-12.4.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                generic-64bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250512    gcc-12.4.0
parisc                randconfig-001-20250513    gcc-11.5.0
parisc                randconfig-002-20250512    gcc-10.5.0
parisc                randconfig-002-20250513    gcc-11.5.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                      pasemi_defconfig    clang-21
powerpc               randconfig-001-20250512    gcc-5.5.0
powerpc               randconfig-001-20250513    clang-21
powerpc               randconfig-002-20250512    clang-21
powerpc               randconfig-002-20250513    gcc-8.5.0
powerpc               randconfig-003-20250512    gcc-7.5.0
powerpc               randconfig-003-20250513    clang-21
powerpc64             randconfig-001-20250512    clang-21
powerpc64             randconfig-001-20250513    clang-21
powerpc64             randconfig-002-20250512    gcc-5.5.0
powerpc64             randconfig-003-20250512    clang-21
powerpc64             randconfig-003-20250513    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250512    gcc-7.5.0
riscv                 randconfig-001-20250513    gcc-14.2.0
riscv                 randconfig-002-20250512    clang-21
riscv                 randconfig-002-20250513    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250512    clang-18
s390                  randconfig-001-20250513    clang-21
s390                  randconfig-002-20250512    clang-21
s390                  randconfig-002-20250513    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        apsh4ad0a_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                    randconfig-001-20250512    gcc-11.5.0
sh                    randconfig-001-20250513    gcc-12.4.0
sh                    randconfig-002-20250512    gcc-9.3.0
sh                    randconfig-002-20250513    gcc-14.2.0
sh                      rts7751r2d1_defconfig    gcc-14.2.0
sh                            titan_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250512    gcc-10.3.0
sparc                 randconfig-001-20250513    gcc-11.5.0
sparc                 randconfig-002-20250512    gcc-8.5.0
sparc                 randconfig-002-20250513    gcc-13.3.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250512    gcc-6.5.0
sparc64               randconfig-001-20250513    gcc-11.5.0
sparc64               randconfig-002-20250512    gcc-10.5.0
sparc64               randconfig-002-20250513    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250512    gcc-12
um                    randconfig-001-20250513    clang-19
um                    randconfig-002-20250512    clang-21
um                    randconfig-002-20250513    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250512    gcc-12
x86_64      buildonly-randconfig-001-20250513    gcc-12
x86_64      buildonly-randconfig-002-20250512    gcc-12
x86_64      buildonly-randconfig-002-20250513    gcc-12
x86_64      buildonly-randconfig-003-20250512    clang-20
x86_64      buildonly-randconfig-003-20250513    clang-20
x86_64      buildonly-randconfig-004-20250512    clang-20
x86_64      buildonly-randconfig-004-20250513    gcc-12
x86_64      buildonly-randconfig-005-20250512    clang-20
x86_64      buildonly-randconfig-005-20250513    clang-20
x86_64      buildonly-randconfig-006-20250512    clang-20
x86_64      buildonly-randconfig-006-20250513    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250512    gcc-12.4.0
xtensa                randconfig-001-20250513    gcc-7.5.0
xtensa                randconfig-002-20250512    gcc-14.2.0
xtensa                randconfig-002-20250513    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

