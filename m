Return-Path: <linux-rdma+bounces-20948-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJnVAw/IC2pSNQUAu9opvQ
	(envelope-from <linux-rdma+bounces-20948-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 04:16:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7786E57659C
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 04:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3A4130300FA
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 02:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BB02F1FC9;
	Tue, 19 May 2026 02:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IKMzYt9b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7797B1A9FA4
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 02:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779157003; cv=none; b=dukn7J4ClTFYcf78S8Yvetdd+fGdwpLn9nk8PCP2Q9OkYs+RAGqxdpyyTIwdgi63totUf8sdK3z8JdenSl6KjZchH+NYrhGQJ1umiAlDlxjGA9QAz34479VLgmRZ7xXGET7D4D+nKvJTivt0zwZO2+hQ/eMFpHRLem8w2CNaiJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779157003; c=relaxed/simple;
	bh=iFoRGsth2w1kY9LHTS3OUHXcW7KgAWRVZc/OY3MKyS4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KAMETk4yAN4B7BTIYn1CHhhscE/L9b73QSFBE4A8PH/ea6hzsmjxRxGu7TixODK2Xh2iJUkj+ZNIYiJFwxR3bwM9NG3RCstS/vKaFgd2udbuw3lun3TcvG6U52is8SAtJTUwIz/q/RTgW3IgBGICkEF7v44fQ9Kq7taO2dRm0y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IKMzYt9b; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779157002; x=1810693002;
  h=date:from:to:cc:subject:message-id;
  bh=iFoRGsth2w1kY9LHTS3OUHXcW7KgAWRVZc/OY3MKyS4=;
  b=IKMzYt9bGut4nuWKWuFPSBJ6Cw4kPR7ZDxTpV1q/3W7dEtWpzgs+FpZn
   o4+rYGcu17epdZ2yz1n2ffuaS/JCY4SqpRovrrVxsyHWCw1ccAEGpNKah
   dqdpwNr+pJen40jZj+ePbi0oZx3RhJoFbVBMtjCbCUdWzTLDd3g1gminm
   1JG29uslPxEwYFaFmQiVFgz6Wbsvwdx7ZnQ8yXLH1fqwm3V2VmG4Ur7ou
   Cop9chd9ZoVsijRkHySD6D2uqjQ/xV/V6lyXqvmo+fy4tOZG632PS1Ozv
   2oUtNMzROU75+SVX24a8sT513XZfyhu9fqDwNVVZWjl8SHVF9BtajfSUn
   w==;
X-CSE-ConnectionGUID: LVny45BASwO4dpjurCQcIw==
X-CSE-MsgGUID: 85czIv9ZTY6ijSO0SpI1Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="67553968"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="67553968"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 19:16:42 -0700
X-CSE-ConnectionGUID: H9/CwhxdSK+T9nvTGqcoLg==
X-CSE-MsgGUID: pAMfkrTgSEOJgnOt6HvRtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="239685392"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 18 May 2026 19:16:39 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wP9zr-000000000DJ-1JJR;
	Tue, 19 May 2026 02:16:03 +0000
Date: Tue, 19 May 2026 10:15:15 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 67464f388d52ec172be62c99fc43697437ffa384
Message-ID: <202605191005.pdZUWWNS-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20948-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,lists];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 7786E57659C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 67464f388d52ec172be62c99fc43697437ffa384  RDMA/cma: Constify struct configfs_item_operations and configfs_group_operations

elapsed time: 885m

configs tested: 171
configs skipped: 2

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
arc                   randconfig-001-20260519    gcc-9.5.0
arc                   randconfig-002-20260519    gcc-10.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260519    clang-23
arm                   randconfig-002-20260519    clang-23
arm                   randconfig-003-20260519    clang-23
arm                   randconfig-004-20260519    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260519    clang-18
arm64                 randconfig-002-20260519    gcc-11.5.0
arm64                 randconfig-003-20260519    gcc-8.5.0
arm64                 randconfig-004-20260519    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260519    gcc-12.5.0
csky                  randconfig-002-20260519    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon                        randconfig-001    clang-17
hexagon               randconfig-001-20260519    clang-23
hexagon               randconfig-002-20260519    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260519    gcc-12
i386        buildonly-randconfig-002-20260519    gcc-14
i386        buildonly-randconfig-003-20260519    clang-20
i386        buildonly-randconfig-004-20260519    gcc-14
i386        buildonly-randconfig-005-20260519    gcc-14
i386        buildonly-randconfig-006-20260519    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260518    clang-20
i386                  randconfig-002-20260518    gcc-14
i386                  randconfig-003-20260518    gcc-14
i386                  randconfig-004-20260518    clang-20
i386                  randconfig-005-20260518    clang-20
i386                  randconfig-006-20260518    gcc-13
i386                  randconfig-007-20260518    clang-20
i386                  randconfig-011-20260519    clang-20
i386                  randconfig-012-20260519    clang-20
i386                  randconfig-013-20260519    gcc-14
i386                  randconfig-014-20260519    clang-20
i386                  randconfig-015-20260519    clang-20
i386                  randconfig-016-20260519    clang-20
i386                  randconfig-017-20260519    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260519    clang-18
loongarch                      randconfig-002    gcc-13.4.0
loongarch             randconfig-002-20260519    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260519    gcc-11.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260519    gcc-10.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260519    gcc-12.5.0
parisc                randconfig-002-20260519    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260519    clang-23
powerpc               randconfig-002-20260519    gcc-8.5.0
powerpc64             randconfig-001-20260519    clang-23
powerpc64             randconfig-002-20260519    gcc-14.3.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260518    clang-23
riscv                 randconfig-001-20260519    gcc-8.5.0
riscv                 randconfig-002-20260518    clang-23
riscv                 randconfig-002-20260519    clang-17
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260518    gcc-12.5.0
s390                  randconfig-001-20260519    clang-23
s390                  randconfig-002-20260518    gcc-12.5.0
s390                  randconfig-002-20260519    clang-18
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                        apsh4ad0a_defconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260518    gcc-14.3.0
sh                    randconfig-001-20260519    gcc-15.2.0
sh                    randconfig-002-20260518    gcc-11.5.0
sh                    randconfig-002-20260519    gcc-13.4.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260519    gcc-14.3.0
sparc                 randconfig-002-20260519    gcc-11.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260519    gcc-8.5.0
sparc64               randconfig-002-20260519    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260519    clang-23
um                    randconfig-002-20260519    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260518    clang-20
x86_64      buildonly-randconfig-002-20260518    clang-20
x86_64      buildonly-randconfig-003-20260518    clang-20
x86_64      buildonly-randconfig-004-20260518    gcc-14
x86_64      buildonly-randconfig-005-20260518    gcc-14
x86_64      buildonly-randconfig-006-20260518    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260519    gcc-14
x86_64                randconfig-002-20260519    gcc-13
x86_64                randconfig-003-20260519    clang-20
x86_64                randconfig-004-20260519    clang-20
x86_64                randconfig-005-20260519    clang-20
x86_64                randconfig-006-20260519    clang-20
x86_64                randconfig-011-20260519    gcc-14
x86_64                randconfig-012-20260519    clang-20
x86_64                randconfig-013-20260519    clang-20
x86_64                randconfig-014-20260519    gcc-14
x86_64                randconfig-015-20260519    clang-20
x86_64                randconfig-016-20260519    clang-20
x86_64                randconfig-071-20260519    gcc-14
x86_64                randconfig-072-20260519    gcc-12
x86_64                randconfig-073-20260519    gcc-14
x86_64                randconfig-074-20260519    gcc-14
x86_64                randconfig-075-20260519    gcc-14
x86_64                randconfig-076-20260519    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260519    gcc-10.5.0
xtensa                randconfig-002-20260519    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

