Return-Path: <linux-rdma+bounces-16043-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKtgGgg/eGkzpAEAu9opvQ
	(envelope-from <linux-rdma+bounces-16043-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 05:28:56 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B4E8FDAB
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 05:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCE1A301AD09
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 04:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4B6322A2E;
	Tue, 27 Jan 2026 04:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kGWSOPz9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5062253A1
	for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 04:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769488132; cv=none; b=bwYWajyECIRiogUsiI0x/4cBKb/l0gG9q1pI09SAGWHSvyv3MGuSzLcawzAy2tOJ4l+hvLsb1kVJC5sGtqJmNJkNFxlhS6Tp/EcQGyQ5V3H67sKTXjNvUvYYib2mGH+b6hZL2XnDR4V56H1gkACOb1H20RNT/jXfgmN07OdUSSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769488132; c=relaxed/simple;
	bh=gjopuahNfWHq7DDdnul65UinbsMJo9vdQ0z4mZ0E73M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YWJdWQ0O6mfk/pVb0RI4C6bXx9bmFomaXntWIq0q35rzal586EWRvqttjjbB1/JCFobxxdlQNjYzYXphApZWPhd2tVKDIPpcD9dB0neKf6VlOsT16joUDrIZZ7f0V91bxSOTeq//UjxCRpTwFbDRGHHeQpXqXrEucH3sDPhmFzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kGWSOPz9; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769488129; x=1801024129;
  h=date:from:to:cc:subject:message-id;
  bh=gjopuahNfWHq7DDdnul65UinbsMJo9vdQ0z4mZ0E73M=;
  b=kGWSOPz93BrrX5kDCzfV5Ne6NGZWVJfNig408Ukf1qZcesHdT8T7Q0nW
   eXsdIzCCnIifJM2OoV9sM594KwF62cIqX8gmp2NLTgUJloOtjCWvx+/Jw
   8Ip3+7Wxq+MGE4KtXq5kShVAjwvZkkIXe9FnJoNt6uEf/7o5phIArd+vA
   jcipiqXbymmv2bwfP8u86GQbRYLJDqkh78R+ESWffRcE5sqQ6ZbRLnlrG
   Q6ICLB588CwJkEyV1tQFzeDcshEguLKj5vgnkEO4Jk6vN9JroIehKv49b
   5pVG9ttiorO4JAgTJjEUr6Bve5EOSBYa4rL/h+Bfb/+1KyseNL9eOvbTi
   A==;
X-CSE-ConnectionGUID: zFpEMRaHSP+EPXRCg4THhw==
X-CSE-MsgGUID: IOrLQ6UuSsiTpyW49Fkw/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="82103585"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="82103585"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 20:28:49 -0800
X-CSE-ConnectionGUID: DQfh3DcxT+2oOi482zzQBQ==
X-CSE-MsgGUID: ExqHsd5/RterDjTYKuQCUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="208228573"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 26 Jan 2026 20:28:47 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkah2-00000000XzK-2rZd;
	Tue, 27 Jan 2026 04:28:44 +0000
Date: Tue, 27 Jan 2026 12:27:55 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 1956f0a74ccf5dc9c3ef717f2985c3ed3400aab0
Message-ID: <202601271250.mNiSoKXm-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-16043-lists,linux-rdma=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,lists];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 29B4E8FDAB
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 1956f0a74ccf5dc9c3ef717f2985c3ed3400aab0  RDMA/uverbs: Validate wqe_size before using it in ib_uverbs_post_send

elapsed time: 903m

configs tested: 167
configs skipped: 7

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
arc                   randconfig-001-20260127    gcc-8.5.0
arc                   randconfig-002-20260127    gcc-11.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                          pxa910_defconfig    gcc-15.2.0
arm                   randconfig-001-20260127    clang-22
arm                   randconfig-002-20260127    clang-18
arm                   randconfig-003-20260127    gcc-14.3.0
arm                   randconfig-004-20260127    clang-18
arm                        spear6xx_defconfig    clang-22
arm64                            alldefconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260127    gcc-10.5.0
arm64                 randconfig-002-20260127    clang-22
arm64                 randconfig-003-20260127    gcc-11.5.0
arm64                 randconfig-004-20260127    gcc-12.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260127    gcc-15.2.0
csky                  randconfig-002-20260127    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20260127    clang-22
hexagon               randconfig-002-20260127    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260127    clang-20
i386        buildonly-randconfig-002-20260127    clang-20
i386        buildonly-randconfig-003-20260127    gcc-14
i386        buildonly-randconfig-004-20260127    clang-20
i386        buildonly-randconfig-005-20260127    gcc-14
i386        buildonly-randconfig-006-20260127    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20260127    gcc-14
i386                  randconfig-002-20260127    gcc-14
i386                  randconfig-003-20260127    clang-20
i386                  randconfig-004-20260127    gcc-14
i386                  randconfig-011-20260127    gcc-14
i386                  randconfig-012-20260127    gcc-12
i386                  randconfig-013-20260127    gcc-14
i386                  randconfig-014-20260127    clang-20
i386                  randconfig-015-20260127    clang-20
i386                  randconfig-016-20260127    gcc-14
i386                  randconfig-017-20260127    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260127    gcc-15.2.0
loongarch             randconfig-002-20260127    clang-18
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
m68k                          sun3x_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                  cavium_octeon_defconfig    gcc-15.2.0
mips                           ip22_defconfig    gcc-15.2.0
mips                      maltaaprp_defconfig    clang-22
mips                           xway_defconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260127    gcc-11.5.0
nios2                 randconfig-002-20260127    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260127    gcc-11.5.0
parisc                randconfig-002-20260127    gcc-13.4.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                     ep8248e_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260127    gcc-14.3.0
powerpc               randconfig-002-20260127    clang-22
powerpc64             randconfig-001-20260127    gcc-11.5.0
powerpc64             randconfig-002-20260127    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20260127    clang-22
riscv                 randconfig-002-20260127    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                  randconfig-001-20260127    gcc-13.4.0
s390                  randconfig-002-20260127    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                          r7785rp_defconfig    gcc-15.2.0
sh                    randconfig-001-20260127    gcc-13.4.0
sh                    randconfig-002-20260127    gcc-10.5.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260127    gcc-15.2.0
sparc                 randconfig-002-20260127    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260127    clang-20
sparc64               randconfig-002-20260127    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260127    clang-20
um                    randconfig-002-20260127    clang-22
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260127    clang-20
x86_64      buildonly-randconfig-002-20260127    gcc-14
x86_64      buildonly-randconfig-003-20260127    gcc-14
x86_64      buildonly-randconfig-004-20260127    gcc-14
x86_64      buildonly-randconfig-005-20260127    gcc-14
x86_64      buildonly-randconfig-006-20260127    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260127    gcc-14
x86_64                randconfig-002-20260127    gcc-14
x86_64                randconfig-003-20260127    clang-20
x86_64                randconfig-004-20260127    gcc-14
x86_64                randconfig-005-20260127    clang-20
x86_64                randconfig-006-20260127    gcc-14
x86_64                randconfig-011-20260127    clang-20
x86_64                randconfig-012-20260127    gcc-13
x86_64                randconfig-013-20260127    clang-20
x86_64                randconfig-014-20260127    clang-20
x86_64                randconfig-015-20260127    gcc-13
x86_64                randconfig-016-20260127    clang-20
x86_64                randconfig-071-20260127    gcc-14
x86_64                randconfig-072-20260127    gcc-14
x86_64                randconfig-073-20260127    gcc-14
x86_64                randconfig-074-20260127    clang-20
x86_64                randconfig-075-20260127    clang-20
x86_64                randconfig-076-20260127    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260127    gcc-10.5.0
xtensa                randconfig-002-20260127    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

