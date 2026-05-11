Return-Path: <linux-rdma+bounces-20355-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLA7L054AWpGaQEAu9opvQ
	(envelope-from <linux-rdma+bounces-20355-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 08:33:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A221F508916
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 08:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B43D3001A5B
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 06:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA94299927;
	Mon, 11 May 2026 06:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A06Lkxw6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB60E224AFA
	for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 06:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778481220; cv=none; b=ODrvI85/op7B2nrfI20iHfaYGkquZ0GDZLZVmatdPs8RmkH4PI6UUObJiLETkX/eeAgIc/ow4QeKhcfL78vpNHlYWJWWa1gJva5G04mUg6GfktW1UHcTAZqC8s79sLmp4MxPxsa8kgYgSFOOP/ZF4SLo2JL3kmnDKoiFzFcr8L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778481220; c=relaxed/simple;
	bh=u4XoikkcyXzq1bi66MWbdZ1iIe2G5qmqkzTjRyrVmBY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tzJaqkcAxxELAUVS/EXsxIW3/mASzQsFF1VXL64GZWJOCZhIXp59WYoGCdWa5shfgFxaH3drGfKYl3dED5cBMP53lfP5fWth7Lgle5vSeuPxiDY/x9ywueHPCIUbXZCxxL3wkj/GT88orHbkd9pGJFDCTqCYBxV1l3e7ooazzPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A06Lkxw6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778481218; x=1810017218;
  h=date:from:to:cc:subject:message-id;
  bh=u4XoikkcyXzq1bi66MWbdZ1iIe2G5qmqkzTjRyrVmBY=;
  b=A06Lkxw6S88XHK5rRsKrpFIK24gIWzymvmk0vKe6RruBlm2TJIhAa1M8
   khKGmRgMje3Bk0pQ2YnAC2UrLdcmNBDvwj9RHlW+/lNxD8mL/O1GwwJtd
   D7/qPAdBSIpWuK9pBcjFLtBI1RzYPiBMFghd9qS7kZgdnSUqGv9mJfieP
   8ZugUenf2BcIa0o2SrfIMddrdhO/eBuPdFYYFCngpfyTgOEfXu0vXNJwg
   hgkKPAJP4zuk8Hz6ylq7FsJzPD8hQIwOqmYdB2OK2La3e7Pe86/36H1AZ
   712Jv4aCc17grxC4prgp5L8SURz2E1UBd5VwV7H9+l9cqopTZ1F7DzOnw
   Q==;
X-CSE-ConnectionGUID: acYAbqY9Saiw204qMBFaPg==
X-CSE-MsgGUID: 49Rbbx7rRfyJ2coRfhBoWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="79462833"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="79462833"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 23:33:37 -0700
X-CSE-ConnectionGUID: H4xjK5vyQ/ShLWqkBJzsJQ==
X-CSE-MsgGUID: E0foKZHZQPyHnkvnMSV4ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="233037668"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 10 May 2026 23:33:35 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMKCq-000000000Ev-2bgo;
	Mon, 11 May 2026 06:33:32 +0000
Date: Mon, 11 May 2026 14:32:54 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 784e12a8c45571b255e0b69a63dbc87600f2b2aa
Message-ID: <202605111442.u9VxJqjc-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: A221F508916
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20355-lists,linux-rdma=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,lists];
	NEURAL_HAM(-0.00)[-0.944];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 784e12a8c45571b255e0b69a63dbc87600f2b2aa  RDMA/hns: Fix arithmetic overflow in calc_hem_config()

elapsed time: 863m

configs tested: 264
configs skipped: 43

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260511    gcc-10.5.0
arc                   randconfig-002-20260511    gcc-10.5.0
arc                        vdk_hs38_defconfig    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                        clps711x_defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                            hisi_defconfig    gcc-15.2.0
arm                   randconfig-001-20260511    gcc-10.5.0
arm                   randconfig-002-20260511    gcc-10.5.0
arm                   randconfig-003-20260511    gcc-10.5.0
arm                   randconfig-004-20260511    gcc-10.5.0
arm                         wpcm450_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260511    clang-17
arm64                 randconfig-001-20260511    gcc-15.2.0
arm64                 randconfig-002-20260511    clang-17
arm64                 randconfig-002-20260511    gcc-15.2.0
arm64                 randconfig-003-20260511    clang-17
arm64                 randconfig-004-20260511    clang-17
arm64                 randconfig-004-20260511    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260511    clang-17
csky                  randconfig-001-20260511    gcc-15.2.0
csky                  randconfig-002-20260511    clang-17
csky                  randconfig-002-20260511    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260511    gcc-11.5.0
hexagon               randconfig-001-20260511    gcc-8.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260511    gcc-11.5.0
hexagon               randconfig-002-20260511    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260511    gcc-14
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260511    gcc-14
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260511    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260511    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260511    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260511    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260511    gcc-12
i386                  randconfig-002-20260511    gcc-12
i386                  randconfig-003-20260511    gcc-12
i386                  randconfig-004-20260511    gcc-12
i386                  randconfig-005-20260511    gcc-12
i386                  randconfig-006-20260511    gcc-12
i386                  randconfig-007-20260511    gcc-12
i386                           randconfig-011    clang-20
i386                  randconfig-011-20260511    clang-20
i386                  randconfig-011-20260511    gcc-14
i386                           randconfig-012    clang-20
i386                  randconfig-012-20260511    clang-20
i386                  randconfig-012-20260511    gcc-14
i386                           randconfig-013    clang-20
i386                  randconfig-013-20260511    clang-20
i386                           randconfig-014    clang-20
i386                  randconfig-014-20260511    clang-20
i386                           randconfig-015    clang-20
i386                  randconfig-015-20260511    clang-20
i386                  randconfig-015-20260511    gcc-14
i386                           randconfig-016    clang-20
i386                  randconfig-016-20260511    clang-20
i386                           randconfig-017    clang-20
i386                  randconfig-017-20260511    clang-20
i386                  randconfig-017-20260511    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260511    gcc-11.5.0
loongarch             randconfig-001-20260511    gcc-8.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260511    gcc-11.5.0
loongarch             randconfig-002-20260511    gcc-8.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                malta_qemu_32r6_defconfig    gcc-15.2.0
mips                    maltaup_xpa_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-15.2.0
nios2                               defconfig    clang-19
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260511    gcc-11.5.0
nios2                 randconfig-001-20260511    gcc-8.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260511    gcc-11.5.0
nios2                 randconfig-002-20260511    gcc-8.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-11.5.0
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
parisc                randconfig-001-20260511    clang-20
parisc                randconfig-001-20260511    gcc-8.5.0
parisc                randconfig-002-20260511    clang-20
parisc                randconfig-002-20260511    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      arches_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260511    clang-20
powerpc               randconfig-001-20260511    gcc-8.5.0
powerpc               randconfig-002-20260511    clang-20
powerpc64             randconfig-001-20260511    clang-20
powerpc64             randconfig-001-20260511    gcc-8.5.0
powerpc64             randconfig-002-20260511    clang-20
powerpc64             randconfig-002-20260511    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                          randconfig-001    gcc-12.5.0
riscv                 randconfig-001-20260511    gcc-12.5.0
riscv                          randconfig-002    gcc-12.5.0
riscv                 randconfig-002-20260511    gcc-12.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                           randconfig-001    gcc-12.5.0
s390                  randconfig-001-20260511    gcc-12.5.0
s390                           randconfig-002    gcc-12.5.0
s390                  randconfig-002-20260511    gcc-12.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-12.5.0
sh                    randconfig-001-20260511    gcc-12.5.0
sh                             randconfig-002    gcc-12.5.0
sh                    randconfig-002-20260511    gcc-12.5.0
sh                           se7722_defconfig    gcc-15.2.0
sh                           se7751_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260511    gcc-8.5.0
sparc                 randconfig-002-20260511    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260511    gcc-8.5.0
sparc64               randconfig-002-20260511    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260511    gcc-8.5.0
um                    randconfig-002-20260511    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260511    gcc-14
x86_64      buildonly-randconfig-002-20260511    gcc-14
x86_64      buildonly-randconfig-003-20260511    gcc-14
x86_64      buildonly-randconfig-004-20260511    gcc-14
x86_64      buildonly-randconfig-005-20260511    gcc-14
x86_64      buildonly-randconfig-006-20260511    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260511    clang-20
x86_64                randconfig-001-20260511    gcc-14
x86_64                randconfig-002-20260511    clang-20
x86_64                randconfig-002-20260511    gcc-14
x86_64                randconfig-003-20260511    clang-20
x86_64                randconfig-004-20260511    clang-20
x86_64                randconfig-005-20260511    clang-20
x86_64                randconfig-006-20260511    clang-20
x86_64                         randconfig-011    clang-20
x86_64                randconfig-011-20260511    clang-20
x86_64                randconfig-011-20260511    gcc-14
x86_64                         randconfig-012    clang-20
x86_64                randconfig-012-20260511    clang-20
x86_64                randconfig-012-20260511    gcc-14
x86_64                         randconfig-013    clang-20
x86_64                randconfig-013-20260511    clang-20
x86_64                         randconfig-014    clang-20
x86_64                randconfig-014-20260511    clang-20
x86_64                randconfig-014-20260511    gcc-14
x86_64                         randconfig-015    clang-20
x86_64                randconfig-015-20260511    clang-20
x86_64                randconfig-015-20260511    gcc-14
x86_64                         randconfig-016    clang-20
x86_64                randconfig-016-20260511    clang-20
x86_64                randconfig-016-20260511    gcc-14
x86_64                         randconfig-071    clang-20
x86_64                randconfig-071-20260511    clang-20
x86_64                         randconfig-072    clang-20
x86_64                randconfig-072-20260511    clang-20
x86_64                randconfig-072-20260511    gcc-14
x86_64                         randconfig-073    clang-20
x86_64                randconfig-073-20260511    clang-20
x86_64                randconfig-073-20260511    gcc-14
x86_64                         randconfig-074    clang-20
x86_64                randconfig-074-20260511    clang-20
x86_64                randconfig-074-20260511    gcc-14
x86_64                         randconfig-075    clang-20
x86_64                randconfig-075-20260511    clang-20
x86_64                         randconfig-076    clang-20
x86_64                randconfig-076-20260511    clang-20
x86_64                randconfig-076-20260511    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-11.5.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260511    gcc-8.5.0
xtensa                randconfig-002-20260511    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

