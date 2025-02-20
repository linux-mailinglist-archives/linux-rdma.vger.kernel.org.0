Return-Path: <linux-rdma+bounces-7893-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305C9A3DA7B
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 13:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFB43ACAA7
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 12:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D940E1F4E37;
	Thu, 20 Feb 2025 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sfh20sJ/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D0C1F3FED
	for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056049; cv=none; b=Ts7WuiNRFP14J41VDyVE3mXHl8y/09AR9GX0fWAkgOvZsMX0lF3TnCPZ04qJWxUWac5b6j/1g3dqbHCGhrbE4RCpTMTKWZ8Gk1rSXEvP7yEyIqLTekrg0fv03P5E7clVaFhnRTvyUIBF3dSql1cKMTKbHwPENfirANKlymbmUY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056049; c=relaxed/simple;
	bh=P6AmntTZ8C1kFRkIorQTdVnfsKOq4qaynD8OPDNJeEw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gDCkPHJEfwyjK15LW5V7lEAYstLOPy4owBQqpYk/VUpRIUSt0HgQsIOU2rVB9Bwy8OvGb6A5hWHUhsoV0ibF08t1XFfiMp9mur8fapSFKWcd5/gsmRf8PBuXLqX6pPTCQm2Huvj2SB5b+/uT64XY2FJ1v8oq8JzTL47SC5xB2yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sfh20sJ/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740056048; x=1771592048;
  h=date:from:to:cc:subject:message-id;
  bh=P6AmntTZ8C1kFRkIorQTdVnfsKOq4qaynD8OPDNJeEw=;
  b=Sfh20sJ/8qH/KVQRi9cexC7LceseTF/qtwQIB/fB2lHoS+HDAi76nJsP
   u8qqKqiYOBRVVoZf4V9ipNww8I8grkOW3aQrzHuUzQP363QmXzVa1o4ld
   0bnttPdtN9lg4EpaFWboVbw+m2IHrWudJCBKFCOFpgfPfiT4W3Nc/LNqK
   DpbHlNquogbEPyQHMYJ9s5lhYNeKRIHbLaIZjTaHQr/IQDQZSn5NboOZf
   I9X160drL6sTGKvyvqTRvxNZxMI4u3Qb3gBJz0lmYfnb2ZUTK4pWXfS7/
   lVvGb6YH4VcnIQT8TRKd49azrgUMp3+rYEvGebkUzVDc62TPrLDz0xvTN
   A==;
X-CSE-ConnectionGUID: TJaW2pFdQKalE+5W8ss+ug==
X-CSE-MsgGUID: +qsncv/mQn6HvcMYKqJJDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40021802"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="40021802"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 04:54:07 -0800
X-CSE-ConnectionGUID: 8sUpEldKRqifdm2mKKzBVg==
X-CSE-MsgGUID: D0aCOfdvSi+IZajYVcpADA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="145887255"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 20 Feb 2025 04:54:06 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tl643-0004IF-1l;
	Thu, 20 Feb 2025 12:54:03 +0000
Date: Thu, 20 Feb 2025 20:54:01 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 486055f5e09df959ad4e3aa4ee75b5c91ddeec2e
Message-ID: <202502202055.TY5YaJxe-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 486055f5e09df959ad4e3aa4ee75b5c91ddeec2e  RDMA/core: Fix best page size finding when it can cross SG entries

elapsed time: 1448m

configs tested: 100
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250219    gcc-13.2.0
arc                   randconfig-002-20250219    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250219    gcc-14.2.0
arm                   randconfig-002-20250219    clang-17
arm                   randconfig-003-20250219    clang-15
arm                   randconfig-004-20250219    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250219    clang-21
arm64                 randconfig-002-20250219    gcc-14.2.0
arm64                 randconfig-003-20250219    gcc-14.2.0
arm64                 randconfig-004-20250219    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250219    gcc-14.2.0
csky                  randconfig-002-20250219    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250219    clang-14
hexagon               randconfig-002-20250219    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250219    clang-19
i386        buildonly-randconfig-002-20250219    clang-19
i386        buildonly-randconfig-003-20250219    gcc-12
i386        buildonly-randconfig-004-20250219    clang-19
i386        buildonly-randconfig-005-20250219    clang-19
i386        buildonly-randconfig-006-20250219    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250219    gcc-14.2.0
loongarch             randconfig-002-20250219    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250219    gcc-14.2.0
nios2                 randconfig-002-20250219    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250219    gcc-14.2.0
parisc                randconfig-002-20250219    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc               randconfig-001-20250219    clang-15
powerpc               randconfig-002-20250219    clang-17
powerpc               randconfig-003-20250219    gcc-14.2.0
powerpc64             randconfig-001-20250219    gcc-14.2.0
powerpc64             randconfig-002-20250219    gcc-14.2.0
powerpc64             randconfig-003-20250219    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                            allyesconfig    clang-21
riscv                 randconfig-001-20250219    clang-21
riscv                 randconfig-002-20250219    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250219    clang-18
s390                  randconfig-002-20250219    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250219    gcc-14.2.0
sh                    randconfig-002-20250219    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250219    gcc-14.2.0
sparc                 randconfig-002-20250219    gcc-14.2.0
sparc64               randconfig-001-20250219    gcc-14.2.0
sparc64               randconfig-002-20250219    gcc-14.2.0
um                               allmodconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250219    clang-21
um                    randconfig-002-20250219    clang-21
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250219    gcc-12
x86_64      buildonly-randconfig-002-20250219    clang-19
x86_64      buildonly-randconfig-003-20250219    gcc-12
x86_64      buildonly-randconfig-004-20250219    clang-19
x86_64      buildonly-randconfig-005-20250219    gcc-12
x86_64      buildonly-randconfig-006-20250219    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250219    gcc-14.2.0
xtensa                randconfig-002-20250219    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

