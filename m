Return-Path: <linux-rdma+bounces-18589-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IUrH0v5wmlDngQAu9opvQ
	(envelope-from <linux-rdma+bounces-18589-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 21:51:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C7F31C889
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 21:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97A253045BF7
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 20:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD60359A81;
	Tue, 24 Mar 2026 20:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FjyWCgD7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C9278F26
	for <linux-rdma@vger.kernel.org>; Tue, 24 Mar 2026 20:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774385481; cv=none; b=B0ss47AdqdJ+gF59TQefkcUa4OgDfLAn5iH7WdsYl5x6h1BEejyrFW0EtpWmHnadrRImimFyCs2OmDq9I8e1P7VmwFR4oNVPop+HSHoIrUb0YR5JZ5y17qb3ZATANeKdwbFSKpwnzEHs5ZNQpHTwbijl+Grb9QRijhlAm6Wl8Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774385481; c=relaxed/simple;
	bh=0Jlqr9I0qcRqwWWH16+uMa9eJg0yOEXj5gqILdBbhS8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DAKd6lX4lI4kHjEWqpKc+GiSVpPWWIuy5+48oyOnnt+BYtv68FJnAxizNVB2+cgETsjp/pYj50BBzV/5/bLvsW/PUKK+nQSCYr/2b6z01JtuiOz2QkAE2yGO+N4QHF9FC1oSsjfWDKZ/BxyndB77H9p8pcUSpa6spuUqomLQ5pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FjyWCgD7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774385478; x=1805921478;
  h=date:from:to:cc:subject:message-id;
  bh=0Jlqr9I0qcRqwWWH16+uMa9eJg0yOEXj5gqILdBbhS8=;
  b=FjyWCgD7qsRzTZQmT5N6EgRm/aAlYXYLoI967OuMh1zEXZMxtdmqNTkp
   Xz3NXkNCJ/1HMn3Rva7XLmXOoAhV0S/7uOAwPELnfDHw4jGBMKY+hH5YX
   K3AxazxsWbtoeQEt5mu9BOYQGvcHfRQJAhbsI6uoF4QNfHm3lC6P4F6yw
   bVm/D5ti1uvU/xy/DSvtq8iUt66B09zyMLpyGPpao3Mejd9uWLL3IpGXH
   zcAUxQfBi7cs0BFd79KyfFo0mj52ky68u4fmEi5xgx5VoXJxJK5NkHmgD
   Y21O3QNwLp5twp+d7QkKUQYViDTQooouzsftKEDUnB6R1BZ4v6R9ZZ20/
   Q==;
X-CSE-ConnectionGUID: 1IC0dHSeTbm2KI/NC9nKSg==
X-CSE-MsgGUID: y3eOu0SZSO+odjZa/jRuAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="74440586"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="74440586"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 13:51:18 -0700
X-CSE-ConnectionGUID: LPXJsWyURla1rFOkGrZ5jw==
X-CSE-MsgGUID: DUJJw6z7T+qf+XDyMHbv5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="248037186"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 24 Mar 2026 13:51:16 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w58iX-000000005QX-3sID;
	Tue, 24 Mar 2026 20:51:13 +0000
Date: Wed, 25 Mar 2026 04:50:37 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 05eec2a60c7909acfbe5b6c5fbb64790d5a3ff1c
Message-ID: <202603250429.Sbxh3DYl-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18589-lists,linux-rdma=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,lists];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 30C7F31C889
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 05eec2a60c7909acfbe5b6c5fbb64790d5a3ff1c  RDMA: Remove outdated comments referencing hfi1_destroy_qp()

elapsed time: 923m

configs tested: 297
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                      axs103_smp_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260324    gcc-8.5.0
arc                   randconfig-001-20260325    gcc-8.5.0
arc                   randconfig-002-20260324    gcc-8.5.0
arc                   randconfig-002-20260325    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260324    gcc-8.5.0
arm                   randconfig-001-20260325    gcc-8.5.0
arm                   randconfig-002-20260324    gcc-8.5.0
arm                   randconfig-002-20260325    gcc-8.5.0
arm                   randconfig-003-20260324    gcc-8.5.0
arm                   randconfig-003-20260325    gcc-8.5.0
arm                   randconfig-004-20260324    gcc-8.5.0
arm                   randconfig-004-20260325    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260324    gcc-13.4.0
arm64                 randconfig-001-20260325    clang-23
arm64                 randconfig-002-20260324    gcc-13.4.0
arm64                 randconfig-002-20260324    gcc-8.5.0
arm64                 randconfig-002-20260325    clang-23
arm64                 randconfig-003-20260324    clang-23
arm64                 randconfig-003-20260324    gcc-13.4.0
arm64                 randconfig-003-20260325    clang-23
arm64                 randconfig-004-20260324    clang-23
arm64                 randconfig-004-20260324    gcc-13.4.0
arm64                 randconfig-004-20260325    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260324    gcc-13.4.0
csky                  randconfig-001-20260324    gcc-15.2.0
csky                  randconfig-001-20260325    clang-23
csky                  randconfig-002-20260324    gcc-13.4.0
csky                  randconfig-002-20260324    gcc-15.2.0
csky                  randconfig-002-20260325    clang-23
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260324    clang-23
hexagon               randconfig-001-20260325    gcc-11.5.0
hexagon               randconfig-002-20260324    clang-23
hexagon               randconfig-002-20260325    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260324    gcc-12
i386        buildonly-randconfig-001-20260325    gcc-14
i386        buildonly-randconfig-002-20260324    clang-20
i386        buildonly-randconfig-002-20260324    gcc-12
i386        buildonly-randconfig-002-20260325    gcc-14
i386        buildonly-randconfig-003-20260324    clang-20
i386        buildonly-randconfig-003-20260324    gcc-12
i386        buildonly-randconfig-003-20260325    gcc-14
i386        buildonly-randconfig-004-20260324    gcc-12
i386        buildonly-randconfig-004-20260324    gcc-14
i386        buildonly-randconfig-004-20260325    gcc-14
i386        buildonly-randconfig-005-20260324    clang-20
i386        buildonly-randconfig-005-20260324    gcc-12
i386        buildonly-randconfig-005-20260325    gcc-14
i386        buildonly-randconfig-006-20260324    gcc-12
i386        buildonly-randconfig-006-20260324    gcc-14
i386        buildonly-randconfig-006-20260325    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260324    clang-20
i386                  randconfig-001-20260324    gcc-14
i386                  randconfig-002-20260324    clang-20
i386                  randconfig-003-20260324    clang-20
i386                  randconfig-004-20260324    clang-20
i386                  randconfig-005-20260324    clang-20
i386                  randconfig-006-20260324    clang-20
i386                  randconfig-006-20260324    gcc-14
i386                  randconfig-007-20260324    clang-20
i386                  randconfig-007-20260324    gcc-14
i386                  randconfig-011-20260324    clang-20
i386                  randconfig-011-20260324    gcc-13
i386                  randconfig-011-20260325    clang-20
i386                  randconfig-012-20260324    clang-20
i386                  randconfig-012-20260324    gcc-13
i386                  randconfig-012-20260325    clang-20
i386                  randconfig-013-20260324    gcc-13
i386                  randconfig-013-20260324    gcc-14
i386                  randconfig-013-20260325    clang-20
i386                  randconfig-014-20260324    gcc-13
i386                  randconfig-014-20260325    clang-20
i386                  randconfig-015-20260324    gcc-13
i386                  randconfig-015-20260324    gcc-14
i386                  randconfig-015-20260325    clang-20
i386                  randconfig-016-20260324    gcc-13
i386                  randconfig-016-20260325    clang-20
i386                  randconfig-017-20260324    clang-20
i386                  randconfig-017-20260324    gcc-13
i386                  randconfig-017-20260325    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260324    gcc-14.3.0
loongarch             randconfig-001-20260325    gcc-11.5.0
loongarch             randconfig-002-20260324    clang-18
loongarch             randconfig-002-20260325    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                        m5407c3_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260324    gcc-11.5.0
nios2                 randconfig-001-20260325    gcc-11.5.0
nios2                 randconfig-002-20260324    gcc-11.5.0
nios2                 randconfig-002-20260325    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260324    gcc-12.5.0
parisc                randconfig-001-20260324    gcc-8.5.0
parisc                randconfig-001-20260325    clang-23
parisc                randconfig-002-20260324    gcc-10.5.0
parisc                randconfig-002-20260324    gcc-8.5.0
parisc                randconfig-002-20260325    clang-23
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260324    gcc-8.5.0
powerpc               randconfig-001-20260325    clang-23
powerpc               randconfig-002-20260324    gcc-8.5.0
powerpc               randconfig-002-20260325    clang-23
powerpc                  storcenter_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260324    gcc-14.3.0
powerpc64             randconfig-001-20260324    gcc-8.5.0
powerpc64             randconfig-001-20260325    clang-23
powerpc64             randconfig-002-20260324    gcc-8.5.0
powerpc64             randconfig-002-20260325    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260324    clang-23
riscv                 randconfig-001-20260325    gcc-8.5.0
riscv                 randconfig-002-20260324    clang-23
riscv                 randconfig-002-20260325    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260324    clang-23
s390                  randconfig-001-20260324    gcc-12.5.0
s390                  randconfig-001-20260325    gcc-8.5.0
s390                  randconfig-002-20260324    clang-23
s390                  randconfig-002-20260325    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260324    clang-23
sh                    randconfig-001-20260324    gcc-15.2.0
sh                    randconfig-001-20260325    gcc-8.5.0
sh                    randconfig-002-20260324    clang-23
sh                    randconfig-002-20260324    gcc-15.2.0
sh                    randconfig-002-20260325    gcc-8.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260324    gcc-15.2.0
sparc                 randconfig-001-20260325    gcc-13
sparc                 randconfig-002-20260324    gcc-15.2.0
sparc                 randconfig-002-20260325    gcc-13
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260324    clang-23
sparc64               randconfig-001-20260325    gcc-13
sparc64               randconfig-002-20260324    clang-20
sparc64               randconfig-002-20260325    gcc-13
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260324    gcc-14
um                    randconfig-001-20260325    gcc-13
um                    randconfig-002-20260324    clang-17
um                    randconfig-002-20260325    gcc-13
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260324    gcc-14
x86_64      buildonly-randconfig-002-20260324    clang-20
x86_64      buildonly-randconfig-002-20260324    gcc-14
x86_64      buildonly-randconfig-003-20260324    clang-20
x86_64      buildonly-randconfig-003-20260324    gcc-14
x86_64      buildonly-randconfig-004-20260324    gcc-14
x86_64      buildonly-randconfig-005-20260324    gcc-12
x86_64      buildonly-randconfig-005-20260324    gcc-14
x86_64      buildonly-randconfig-006-20260324    clang-20
x86_64      buildonly-randconfig-006-20260324    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260324    clang-20
x86_64                randconfig-001-20260324    gcc-14
x86_64                randconfig-002-20260324    clang-20
x86_64                randconfig-003-20260324    clang-20
x86_64                randconfig-003-20260324    gcc-14
x86_64                randconfig-004-20260324    clang-20
x86_64                randconfig-004-20260324    gcc-14
x86_64                randconfig-005-20260324    clang-20
x86_64                randconfig-005-20260324    gcc-14
x86_64                randconfig-006-20260324    clang-20
x86_64                randconfig-011-20260324    clang-20
x86_64                randconfig-011-20260324    gcc-14
x86_64                randconfig-012-20260324    gcc-14
x86_64                randconfig-013-20260324    gcc-14
x86_64                randconfig-014-20260324    clang-20
x86_64                randconfig-014-20260324    gcc-14
x86_64                randconfig-015-20260324    gcc-14
x86_64                randconfig-016-20260324    clang-20
x86_64                randconfig-016-20260324    gcc-14
x86_64                randconfig-071-20260324    gcc-12
x86_64                randconfig-071-20260324    gcc-14
x86_64                randconfig-072-20260324    gcc-12
x86_64                randconfig-072-20260324    gcc-14
x86_64                randconfig-073-20260324    gcc-12
x86_64                randconfig-073-20260324    gcc-14
x86_64                randconfig-074-20260324    gcc-12
x86_64                randconfig-075-20260324    gcc-12
x86_64                randconfig-075-20260324    gcc-14
x86_64                randconfig-076-20260324    gcc-12
x86_64                randconfig-076-20260324    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260324    gcc-8.5.0
xtensa                randconfig-001-20260325    gcc-13
xtensa                randconfig-002-20260324    gcc-14.3.0
xtensa                randconfig-002-20260325    gcc-13

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

