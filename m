Return-Path: <linux-rdma+bounces-17752-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLWoJ/2KrmmzFwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17752-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 09:55:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEAB235B7A
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 09:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81DDC303D320
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 08:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A18536C58F;
	Mon,  9 Mar 2026 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QU30FkOK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14DD366DDA
	for <linux-rdma@vger.kernel.org>; Mon,  9 Mar 2026 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773046466; cv=none; b=ItOMk6l+uVoTU2CK11zNr2S9eAofmurLVtl/7n6D2ZQ258cV2LYezCF4KLEKeOLahDOXiNakbehuqB2zUQ4wZ4l6wjhXdb8mM8HJF3CNGUdzhLRAuJAUsoa5NpvIuPIvlds3Gn7hsNmUemZC9/XWRE1oE2B8PvzfJ//Yt89lnLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773046466; c=relaxed/simple;
	bh=lhydoUtdGxvGP2E7+aohuB5eCitdGKP2vNgvaXMisW0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=b6DF8PD3NGcM6FupQEtzq6RQgZU9Mu3PvBSQAlx1EtulLZawYvvPcXn+f+Q+BupNpT2h7t3fNTckG0EUv7oxbMYdoFOn1FDwi/EGu0nyKxlxsCs9Or/pU8xrGmASnj5EKZs87DnxucEUcfZ2zHhAqaLieK4cLnuBfW9jODqgs1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QU30FkOK; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773046461; x=1804582461;
  h=date:from:to:cc:subject:message-id;
  bh=lhydoUtdGxvGP2E7+aohuB5eCitdGKP2vNgvaXMisW0=;
  b=QU30FkOKi6jYwP7fj/UbZO3htuUnZf5+vFRw3GNFtrsjBXRGF1+NFi8r
   aEWyZCd2p8VJEX7UHZoaPl1GmEYmBh8nwfUWCtcPvBGNhXFg3fzIkl47Q
   G3khoVmRTj8e1XD+BT+07P087AamREP6l7tlqoPELZ8VzM/KcMm6P07S7
   ABHNXfqHb8VQqcFkjNjJ1d0uPr2SeTeJNsxAJghgvqvwYeeBys1ApEGkB
   szJcBQZ1ftyVc4z4LX+n9Xyq7SozYvd0PLXuK65jHZNjCPv384lhhxeUj
   RB2gsWYJtwoi1Rl1dXiatdaTfeZIWkG5MWXOONsO5MbAFWpYe/0+Q3zwO
   Q==;
X-CSE-ConnectionGUID: GnHm50HSQOm5uAb0cHYjqg==
X-CSE-MsgGUID: Thmpohp9SrOGFB9MVtSsYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="84698543"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="84698543"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 01:54:20 -0700
X-CSE-ConnectionGUID: jOIDo58yQxi0FzwplMDCsg==
X-CSE-MsgGUID: beghCgz1S5O3tnrUXr4IOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="216225556"
Received: from lkp-server01.sh.intel.com (HELO 17db2bb44c9a) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 09 Mar 2026 01:54:18 -0700
Received: from kbuild by 17db2bb44c9a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vzWNT-000000000O7-3x6D;
	Mon, 09 Mar 2026 08:54:15 +0000
Date: Mon, 09 Mar 2026 16:53:44 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 ef3b06742c8a201d0e83edc9a33a89a4fe3009f8
Message-ID: <202603091636.gT8hNY2h-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 1EEAB235B7A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17752-lists,linux-rdma=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,lists];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:mid]
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: ef3b06742c8a201d0e83edc9a33a89a4fe3009f8  RDMA/efa: Fix use of completion ctx after free

elapsed time: 836m

configs tested: 179
configs skipped: 16

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260309    gcc-11.5.0
arc                   randconfig-002-20260309    gcc-14.3.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260309    clang-16
arm                   randconfig-002-20260309    clang-17
arm                   randconfig-004-20260309    gcc-10.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260309    clang-20
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260309    gcc-14.3.0
csky                  randconfig-002-20260309    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260309    clang-19
hexagon               randconfig-002-20260309    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260309    clang-20
i386        buildonly-randconfig-002-20260309    clang-20
i386        buildonly-randconfig-003-20260309    clang-20
i386        buildonly-randconfig-005-20260309    gcc-14
i386        buildonly-randconfig-006-20260309    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260309    gcc-14
i386                  randconfig-002-20260309    clang-20
i386                  randconfig-003-20260309    gcc-14
i386                  randconfig-004-20260309    gcc-14
i386                  randconfig-005-20260309    gcc-14
i386                  randconfig-006-20260309    gcc-14
i386                  randconfig-007-20260309    gcc-12
i386                  randconfig-011-20260309    gcc-14
i386                  randconfig-012-20260309    clang-20
i386                  randconfig-013-20260309    gcc-14
i386                  randconfig-014-20260309    gcc-14
i386                  randconfig-015-20260309    gcc-14
i386                  randconfig-016-20260309    clang-20
i386                  randconfig-017-20260309    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260309    gcc-13.4.0
loongarch             randconfig-002-20260309    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260309    gcc-10.5.0
nios2                 randconfig-002-20260309    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260309    gcc-8.5.0
parisc                randconfig-002-20260309    gcc-14.3.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260309    gcc-14.3.0
powerpc               randconfig-002-20260309    clang-23
powerpc64             randconfig-001-20260309    gcc-11.5.0
powerpc64             randconfig-002-20260309    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260309    gcc-12.5.0
riscv                 randconfig-001-20260309    gcc-8.5.0
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260309    gcc-8.5.0
s390                  randconfig-002-20260309    gcc-8.5.0
s390                  randconfig-002-20260309    gcc-9.5.0
sh                               alldefconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260309    gcc-13.4.0
sh                    randconfig-001-20260309    gcc-8.5.0
sh                    randconfig-002-20260309    gcc-8.5.0
sh                    randconfig-002-20260309    gcc-9.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260309    gcc-12.5.0
sparc                 randconfig-002-20260309    gcc-13.4.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260309    clang-23
sparc64               randconfig-002-20260309    clang-20
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260309    clang-23
um                    randconfig-002-20260309    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260309    gcc-14
x86_64      buildonly-randconfig-002-20260309    gcc-14
x86_64      buildonly-randconfig-003-20260309    clang-20
x86_64      buildonly-randconfig-004-20260309    gcc-14
x86_64      buildonly-randconfig-005-20260309    gcc-14
x86_64      buildonly-randconfig-006-20260309    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-002-20260309    gcc-13
x86_64                randconfig-003-20260309    gcc-14
x86_64                randconfig-005-20260309    gcc-14
x86_64                randconfig-006-20260309    gcc-14
x86_64                randconfig-011-20260309    clang-20
x86_64                randconfig-011-20260309    gcc-14
x86_64                randconfig-012-20260309    clang-20
x86_64                randconfig-012-20260309    gcc-14
x86_64                randconfig-013-20260309    gcc-14
x86_64                randconfig-014-20260309    gcc-14
x86_64                randconfig-015-20260309    gcc-14
x86_64                randconfig-016-20260309    gcc-12
x86_64                randconfig-016-20260309    gcc-14
x86_64                randconfig-071-20260309    gcc-14
x86_64                randconfig-072-20260309    gcc-14
x86_64                randconfig-073-20260309    gcc-14
x86_64                randconfig-074-20260309    clang-20
x86_64                randconfig-075-20260309    gcc-14
x86_64                randconfig-076-20260309    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260309    gcc-13.4.0
xtensa                randconfig-002-20260309    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

