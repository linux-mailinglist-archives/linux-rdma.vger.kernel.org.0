Return-Path: <linux-rdma+bounces-22744-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y/KNNW+FR2ojaAAAu9opvQ
	(envelope-from <linux-rdma+bounces-22744-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Jul 2026 11:48:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E640F700CCD
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Jul 2026 11:48:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ZgdhTuHD;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22744-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22744-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 098543012C9C
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jul 2026 09:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF6B30CD92;
	Fri,  3 Jul 2026 09:48:19 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BBE38F240
	for <linux-rdma@vger.kernel.org>; Fri,  3 Jul 2026 09:48:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783072099; cv=none; b=b15xYQw5dfR+dj+QYcf8VRw1W88TwIxzQP0hbJ9ClErisKSnmkUmD2+NL1nGCM6tXW28E95D3ltaOcST55qUKEXLxylYHT0ZLlX6KzEJN8V6j8jvpQ+pQbPPr87VRRSS7p+J+dE6DK51klgPXymNQP2h/uW8atnVVYX3ahBpKAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783072099; c=relaxed/simple;
	bh=A4TsaFMDBaX8yFybpUkqJ9XWNW6dMY/asjOgV6xMecU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WBd5fir71kJMYozX9Dp+/sNjHAERzjucZ3Up79rCVUIrApylrMNwnehFcCLqPjbcVzjTv6nhHTap4XJesIZ5aPCineKBIx0TMcloCC73v6MPmvz/GEdRMrU+jOVK3f+X7LPwqZbYOM99GAYQ1SKp3ZjmdUxCtrNPKgZRi6Bwe44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZgdhTuHD; arc=none smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783072097; x=1814608097;
  h=date:from:to:cc:subject:message-id;
  bh=A4TsaFMDBaX8yFybpUkqJ9XWNW6dMY/asjOgV6xMecU=;
  b=ZgdhTuHDNQLxSx+kv5xVLj6cQmE+1zsg2fEzsn+e52UzZnbtvU1+OuVj
   mAbWp3jrmHERyJ8lRyRnvMZ28xlK59vr/ljcgNXJ13k4v0XZ3WEXGaPXM
   SXgQlbSm44P0nlsbPZTUoGIxwbCgerxmTX78pQjQS4W/U2GjDKXdHRmnq
   IDGopejKXQ5+WkJio4xnmAfMfWXOWHVnO/DN98/N6sHZmsaoFfg7qY67n
   UE1D+JJ/aR7oJHyfdDvqI7p/8qndEcQ9mq/aIA0KSQQvOOA8rWoAKY9FH
   I2P+Hke69Bwn2we2KCEQ2GVbqD0k9ocQT4FZtGNbPKoWHpdpYZw/TanB+
   g==;
X-CSE-ConnectionGUID: pkJ8b6QcSPiGVD1dbKIJEg==
X-CSE-MsgGUID: 88ize3kqTjCI249yeW6VrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="87651126"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="87651126"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 02:48:17 -0700
X-CSE-ConnectionGUID: O1jxP42vRkeU20ESNKYaKQ==
X-CSE-MsgGUID: KkFifWUoTta7ix6V3x2f+w==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 03 Jul 2026 02:48:15 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wfaVI-00000000Bwl-2n5V;
	Fri, 03 Jul 2026 09:48:12 +0000
Date: Fri, 03 Jul 2026 17:47:59 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 c3fd3966f7dd871e47f9bcd8fe90d6e23e4cdb1a
Message-ID: <202607031747.vc9EY0YK-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22744-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:dledford@redhat.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E640F700CCD

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: c3fd3966f7dd871e47f9bcd8fe90d6e23e4cdb1a  RDMA/mlx5: Remove kernel-doc warning in umr.c

elapsed time: 733m

configs tested: 197
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260703    gcc-8.5.0
arc                   randconfig-002-20260703    gcc-8.5.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                         mv78xx0_defconfig    clang-23
arm                        mvebu_v7_defconfig    clang-23
arm                   randconfig-001-20260703    gcc-8.5.0
arm                   randconfig-002-20260703    gcc-8.5.0
arm                   randconfig-003-20260703    gcc-8.5.0
arm                   randconfig-004-20260703    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    gcc-10.5.0
arm64                 randconfig-001-20260703    gcc-10.5.0
arm64                          randconfig-002    gcc-10.5.0
arm64                 randconfig-002-20260703    gcc-10.5.0
arm64                          randconfig-003    gcc-10.5.0
arm64                 randconfig-003-20260703    gcc-10.5.0
arm64                          randconfig-004    gcc-10.5.0
arm64                 randconfig-004-20260703    gcc-10.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    gcc-10.5.0
csky                  randconfig-001-20260703    gcc-10.5.0
csky                           randconfig-002    gcc-10.5.0
csky                  randconfig-002-20260703    gcc-10.5.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260703    gcc-16.1.0
hexagon               randconfig-002-20260703    gcc-16.1.0
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                 buildonly-randconfig-001    clang-22
i386        buildonly-randconfig-001-20260703    clang-22
i386                 buildonly-randconfig-002    clang-22
i386        buildonly-randconfig-002-20260703    clang-22
i386                 buildonly-randconfig-003    clang-22
i386        buildonly-randconfig-003-20260703    clang-22
i386                 buildonly-randconfig-004    clang-22
i386        buildonly-randconfig-004-20260703    clang-22
i386                 buildonly-randconfig-005    clang-22
i386        buildonly-randconfig-005-20260703    clang-22
i386                 buildonly-randconfig-006    clang-22
i386        buildonly-randconfig-006-20260703    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260703    clang-22
i386                  randconfig-002-20260703    clang-22
i386                  randconfig-003-20260703    clang-22
i386                  randconfig-004-20260703    clang-22
i386                  randconfig-005-20260703    clang-22
i386                  randconfig-006-20260703    clang-22
i386                  randconfig-007-20260703    clang-22
i386                  randconfig-011-20260703    clang-22
i386                  randconfig-012-20260703    clang-22
i386                  randconfig-013-20260703    clang-22
i386                  randconfig-014-20260703    clang-22
i386                  randconfig-015-20260703    clang-22
i386                  randconfig-016-20260703    clang-22
i386                  randconfig-017-20260703    clang-22
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260703    gcc-16.1.0
loongarch             randconfig-002-20260703    gcc-16.1.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                     eyeq6lplus_defconfig    gcc-16.1.0
mips                           ip28_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260703    gcc-16.1.0
nios2                 randconfig-002-20260703    gcc-16.1.0
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260703    clang-23
parisc                randconfig-002-20260703    clang-23
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                     asp8347_defconfig    clang-23
powerpc               randconfig-001-20260703    clang-23
powerpc               randconfig-002-20260703    clang-23
powerpc64             randconfig-001-20260703    clang-23
powerpc64             randconfig-002-20260703    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260703    gcc-9.5.0
riscv                 randconfig-002-20260703    gcc-9.5.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260703    gcc-9.5.0
s390                  randconfig-002-20260703    gcc-9.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260703    gcc-9.5.0
sh                    randconfig-002-20260703    gcc-9.5.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260703    gcc-11.5.0
sparc                 randconfig-002-20260703    gcc-11.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260703    gcc-11.5.0
sparc64               randconfig-002-20260703    gcc-11.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260703    gcc-11.5.0
um                    randconfig-002-20260703    gcc-11.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    gcc-14
x86_64      buildonly-randconfig-001-20260703    gcc-14
x86_64               buildonly-randconfig-002    gcc-14
x86_64      buildonly-randconfig-002-20260703    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260703    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260703    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260703    gcc-14
x86_64               buildonly-randconfig-006    gcc-14
x86_64      buildonly-randconfig-006-20260703    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                         randconfig-001    clang-22
x86_64                randconfig-001-20260703    clang-22
x86_64                         randconfig-002    clang-22
x86_64                randconfig-002-20260703    clang-22
x86_64                         randconfig-003    clang-22
x86_64                randconfig-003-20260703    clang-22
x86_64                         randconfig-004    clang-22
x86_64                randconfig-004-20260703    clang-22
x86_64                         randconfig-005    clang-22
x86_64                randconfig-005-20260703    clang-22
x86_64                         randconfig-006    clang-22
x86_64                randconfig-006-20260703    clang-22
x86_64                randconfig-011-20260703    gcc-14
x86_64                randconfig-012-20260703    gcc-14
x86_64                randconfig-013-20260703    gcc-14
x86_64                randconfig-014-20260703    gcc-14
x86_64                randconfig-015-20260703    gcc-14
x86_64                randconfig-016-20260703    gcc-14
x86_64                randconfig-071-20260703    clang-22
x86_64                randconfig-072-20260703    clang-22
x86_64                randconfig-073-20260703    clang-22
x86_64                randconfig-074-20260703    clang-22
x86_64                randconfig-075-20260703    clang-22
x86_64                randconfig-076-20260703    clang-22
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20
xtensa                       common_defconfig    gcc-16.1.0
xtensa                randconfig-001-20260703    gcc-11.5.0
xtensa                randconfig-002-20260703    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

