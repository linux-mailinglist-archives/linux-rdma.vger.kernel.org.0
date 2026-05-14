Return-Path: <linux-rdma+bounces-20670-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCeQFsGFBWqiXwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20670-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 10:20:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F8053F321
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 10:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18572300F53B
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 08:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584023D6CBE;
	Thu, 14 May 2026 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cI+9zJui"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213E1271443
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778746803; cv=none; b=dJS1kunzZrwmwgB8K97Q3v8U2/VPwQBOxzyk844bZG+uVgICZJvjkgbs/G6ArZL5fL9HY+Gpc+KImDsMveXODqfEuL5v93fSsoayNxyDEGBQZA4Eou5Qvg/k0Y5ibK9LMIVzcYtyzv/ere5fgzOyuHtC4z80/ZMLONYUvUrtVtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778746803; c=relaxed/simple;
	bh=3ZJlL7KQ0q5TOIbmDxNfPERsHwie3LB1J3qRyTk2Eo4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Hl7PiCNdW3RJGmgUEUlYhZMvtI7IJnPeXiJ7fCjPNvNBJ/4Z0SIXKRZewYTdNZvPt2V/Bf3c2Nq/Al7qtrc2O2HHclcQTmw+GIIlmdJGusEj8lDdTHyJF/aqs73pRPIY2NGC+rb0Hgh+ACdrV2tn5HI3MBOTJUfccyOMc1dWwFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cI+9zJui; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778746800; x=1810282800;
  h=date:from:to:cc:subject:message-id;
  bh=3ZJlL7KQ0q5TOIbmDxNfPERsHwie3LB1J3qRyTk2Eo4=;
  b=cI+9zJuiV8a9BxBjOffBL9HFOxnbsSj33wpID0GNWocXGfuTvvRfcUe3
   IUJr/WiZZ6vmBJ55zKrvN5Nf99+cC2nsJGLqwL84gip4/1xMJv7XLaqF5
   mvbNV7rT2PzE2BqnMACsg3f5t43ebXImYjo5JwsvzAiU6CRJzsSdiHoIG
   kpw6PazunUm+WJunerdJJeVb4RkLH5Ix5u0NNO+rIR0MGJt2b3UOBEOF/
   vo+WpN0m934V8zKLYW/zYwxTv21Fgaa5BosCFItbPSR4lF/nA9j7BcO7Z
   vhRwIvrd8ioGRMInmQCHr9xLK/BlXkb/V85uk+CDCkXmQnmlWij5JhEct
   g==;
X-CSE-ConnectionGUID: gTQBfWKXTjKGrHfcmFHPDg==
X-CSE-MsgGUID: M8/AqsJdTLmfSzkrZx56zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="83298865"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="83298865"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 01:20:00 -0700
X-CSE-ConnectionGUID: rLGRmvj+S8iD5dJ9t5KUwQ==
X-CSE-MsgGUID: h0kYWKYNToib6AfjbBYu/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="234044437"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 14 May 2026 01:19:58 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNRIS-000000006Bz-03jp;
	Thu, 14 May 2026 08:19:56 +0000
Date: Thu, 14 May 2026 16:19:33 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 9dd3e17173bfb8a430e24d40c1efd14d81142231
Message-ID: <202605141623.yJGBnovg-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: A5F8053F321
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20670-lists,linux-rdma=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,lists];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 9dd3e17173bfb8a430e24d40c1efd14d81142231  RDMA/hns: Use named initializer for pci_device_id array

elapsed time: 802m

configs tested: 226
configs skipped: 4

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
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260514    clang-23
arc                   randconfig-001-20260514    gcc-8.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260514    clang-23
arc                   randconfig-002-20260514    gcc-8.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260514    clang-23
arm                   randconfig-001-20260514    gcc-8.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260514    clang-23
arm                   randconfig-002-20260514    gcc-8.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260514    clang-23
arm                   randconfig-003-20260514    gcc-8.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260514    clang-23
arm                   randconfig-004-20260514    gcc-8.5.0
arm                         vf610m4_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260514    clang-23
arm64                 randconfig-002-20260514    clang-23
arm64                 randconfig-003-20260514    clang-23
arm64                 randconfig-004-20260514    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260514    clang-23
csky                  randconfig-002-20260514    clang-23
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260514    gcc-10.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260514    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260514    gcc-14
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260514    gcc-14
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260514    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260514    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260514    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260514    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260514    clang-20
i386                  randconfig-002-20260514    clang-20
i386                  randconfig-003-20260514    clang-20
i386                  randconfig-004-20260514    clang-20
i386                  randconfig-005-20260514    clang-20
i386                  randconfig-006-20260514    clang-20
i386                  randconfig-007-20260514    clang-20
i386                  randconfig-011-20260514    clang-20
i386                  randconfig-012-20260514    clang-20
i386                  randconfig-013-20260514    clang-20
i386                  randconfig-014-20260514    clang-20
i386                  randconfig-015-20260514    clang-20
i386                  randconfig-016-20260514    clang-20
i386                  randconfig-017-20260514    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260514    gcc-10.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260514    gcc-10.5.0
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
mips                        bcm63xx_defconfig    clang-23
mips                      maltasmvp_defconfig    gcc-15.2.0
mips                        qi_lb60_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260514    gcc-10.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260514    gcc-10.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                         randconfig-001    gcc-13.4.0
parisc                randconfig-001-20260514    gcc-13.4.0
parisc                         randconfig-002    gcc-13.4.0
parisc                randconfig-002-20260514    gcc-13.4.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                        randconfig-001    gcc-13.4.0
powerpc               randconfig-001-20260514    gcc-13.4.0
powerpc                        randconfig-002    gcc-13.4.0
powerpc               randconfig-002-20260514    gcc-13.4.0
powerpc                     tqm8541_defconfig    clang-23
powerpc64                      randconfig-001    gcc-13.4.0
powerpc64             randconfig-001-20260514    gcc-13.4.0
powerpc64                      randconfig-002    gcc-13.4.0
powerpc64             randconfig-002-20260514    gcc-13.4.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260514    gcc-14.3.0
riscv                 randconfig-002-20260514    gcc-14.3.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260514    gcc-14.3.0
s390                  randconfig-002-20260514    gcc-14.3.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260514    gcc-14.3.0
sh                    randconfig-002-20260514    gcc-14.3.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    gcc-15.2.0
sparc                 randconfig-001-20260514    gcc-15.2.0
sparc                          randconfig-002    gcc-15.2.0
sparc                 randconfig-002-20260514    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-15.2.0
sparc64               randconfig-001-20260514    gcc-15.2.0
sparc64                        randconfig-002    gcc-15.2.0
sparc64               randconfig-002-20260514    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-15.2.0
um                    randconfig-001-20260514    gcc-15.2.0
um                             randconfig-002    gcc-15.2.0
um                    randconfig-002-20260514    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64               buildonly-randconfig-001    clang-20
x86_64      buildonly-randconfig-001-20260514    clang-20
x86_64               buildonly-randconfig-002    clang-20
x86_64      buildonly-randconfig-002-20260514    clang-20
x86_64               buildonly-randconfig-003    clang-20
x86_64      buildonly-randconfig-003-20260514    clang-20
x86_64               buildonly-randconfig-004    clang-20
x86_64      buildonly-randconfig-004-20260514    clang-20
x86_64               buildonly-randconfig-005    clang-20
x86_64      buildonly-randconfig-005-20260514    clang-20
x86_64               buildonly-randconfig-006    clang-20
x86_64      buildonly-randconfig-006-20260514    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                         randconfig-001    gcc-14
x86_64                randconfig-001-20260514    gcc-14
x86_64                         randconfig-002    gcc-14
x86_64                randconfig-002-20260514    gcc-14
x86_64                         randconfig-003    gcc-14
x86_64                randconfig-003-20260514    gcc-14
x86_64                         randconfig-004    gcc-14
x86_64                randconfig-004-20260514    gcc-14
x86_64                         randconfig-005    gcc-14
x86_64                randconfig-005-20260514    gcc-14
x86_64                         randconfig-006    gcc-14
x86_64                randconfig-006-20260514    gcc-14
x86_64                randconfig-011-20260514    clang-20
x86_64                randconfig-012-20260514    clang-20
x86_64                randconfig-013-20260514    clang-20
x86_64                randconfig-014-20260514    clang-20
x86_64                randconfig-015-20260514    clang-20
x86_64                randconfig-016-20260514    clang-20
x86_64                randconfig-071-20260514    clang-20
x86_64                randconfig-072-20260514    clang-20
x86_64                randconfig-073-20260514    clang-20
x86_64                randconfig-074-20260514    clang-20
x86_64                randconfig-075-20260514    clang-20
x86_64                randconfig-076-20260514    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                         randconfig-001    gcc-15.2.0
xtensa                randconfig-001-20260514    gcc-15.2.0
xtensa                         randconfig-002    gcc-15.2.0
xtensa                randconfig-002-20260514    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

