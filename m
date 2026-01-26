Return-Path: <linux-rdma+bounces-16001-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AVoCPnldmkrYgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16001-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 04:56:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0BC83C9E
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 04:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0801300DD64
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 03:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0F62FE04D;
	Mon, 26 Jan 2026 03:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kqLRL9hB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECF52F39C1
	for <linux-rdma@vger.kernel.org>; Mon, 26 Jan 2026 03:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769399717; cv=none; b=JBZNrbWjUZgVOXoxH5L3DzsJdXKOGtGEU3OOUfSCXAyDFw/+7BG9Ut7VmL3DSMzn5myXU3SX4koHhNxkomWkwBoivAH7EMJk4220lH1CCQgDfL66LWdIQU7ZZaHscgVZc1QqNL+/hW4s3dOEd4Qsi1mf8ov89pmJG/1G5mcNVmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769399717; c=relaxed/simple;
	bh=/44NhuMVJ94+l9TEthRS1sIdS2ZFM1sPj9Fy0WTs4Tg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gdXqQSn6ddb15CQrjRwDvMbORm6BZfPDmH1clLMhOcNL0wv7WIIP+GidVzIaOOTxGzH47LxXOGHZMWzUuniV09T9Arq2gZelNGkz6yvw58uXmfOH9gznYB2gFfwX9uz/fCsyqCLIB2P38UQRA/eYPpxO/kWtzg09HTLLJheSq8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kqLRL9hB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769399715; x=1800935715;
  h=date:from:to:cc:subject:message-id;
  bh=/44NhuMVJ94+l9TEthRS1sIdS2ZFM1sPj9Fy0WTs4Tg=;
  b=kqLRL9hBCZZmmDlJMhdtusNeq4qkt8keu6WHbU4M40vCfiR+WrS105LE
   pa9EchAfPbc2v8dc4UTgFi5VW4/2lU7k6e1Qes8xzfFcAa8e08/FJHG6J
   KQRJ03jysBe4fmv8BWp3FxMJ3MiQZVz09mzi7sqs9nu/G1c1SdBcllQca
   qZ/VTppoXLFuOHLGB4iVhrfH0th2qmjkEqvmPbio4qvk49bzItiBv8vsS
   +l1dZ2PRWxBvuRGaGWQZzsqBUeFv2g05gF7iWpHq9vumofkH1k1zojLIK
   6HyO/v2xEFqHr13AGHqm3jXvmZUSQspY1Jz/bjoTkW5AqiNPWj8q3aYoN
   A==;
X-CSE-ConnectionGUID: B0SZSzdgQbKT0ZCCERGQ6w==
X-CSE-MsgGUID: JE9SNLj4RhukV6+oKRSXVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="93240283"
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="93240283"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2026 19:55:15 -0800
X-CSE-ConnectionGUID: 2EAc0Pz3TH+EGF/8dlouzQ==
X-CSE-MsgGUID: 5qzGG/91Reac8ufAukTU3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="207386540"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 25 Jan 2026 19:55:13 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkDh0-00000000Wrs-30SW;
	Mon, 26 Jan 2026 03:55:10 +0000
Date: Mon, 26 Jan 2026 11:54:15 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 2529aead51673814ebf464723626ac608b8635a5
Message-ID: <202601261109.LyMSlINv-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16001-lists,linux-rdma=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,lists];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B0BC83C9E
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 2529aead51673814ebf464723626ac608b8635a5  RDMA/irdma: Use CQ ID for CEQE context

elapsed time: 818m

configs tested: 167
configs skipped: 3

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
arc                   randconfig-001-20260125    gcc-11.5.0
arc                   randconfig-002-20260125    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                          exynos_defconfig    clang-22
arm                             mxs_defconfig    clang-22
arm                   randconfig-001-20260125    gcc-12.5.0
arm                   randconfig-002-20260125    clang-22
arm                   randconfig-003-20260125    gcc-10.5.0
arm                   randconfig-004-20260125    clang-20
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260125    clang-17
arm64                 randconfig-002-20260125    clang-22
arm64                 randconfig-003-20260125    clang-22
arm64                 randconfig-004-20260125    clang-22
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260125    gcc-15.2.0
csky                  randconfig-002-20260125    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20260126    clang-22
hexagon               randconfig-002-20260126    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260126    gcc-14
i386        buildonly-randconfig-002-20260126    clang-20
i386        buildonly-randconfig-003-20260126    gcc-14
i386        buildonly-randconfig-004-20260126    clang-20
i386        buildonly-randconfig-005-20260126    gcc-14
i386        buildonly-randconfig-006-20260126    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260126    clang-20
i386                  randconfig-002-20260126    clang-20
i386                  randconfig-003-20260126    clang-20
i386                  randconfig-004-20260126    gcc-12
i386                  randconfig-005-20260126    gcc-14
i386                  randconfig-006-20260126    clang-20
i386                  randconfig-007-20260126    gcc-14
i386                  randconfig-011-20260125    gcc-14
i386                  randconfig-012-20260125    gcc-14
i386                  randconfig-013-20260125    gcc-14
i386                  randconfig-014-20260125    clang-20
i386                  randconfig-015-20260125    clang-20
i386                  randconfig-016-20260125    gcc-14
i386                  randconfig-017-20260125    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260126    gcc-15.2.0
loongarch             randconfig-002-20260126    clang-22
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
mips                        bcm63xx_defconfig    clang-22
mips                           ip30_defconfig    gcc-15.2.0
mips                malta_qemu_32r6_defconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260126    gcc-11.5.0
nios2                 randconfig-002-20260126    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260126    gcc-8.5.0
parisc                randconfig-002-20260126    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260126    gcc-14.3.0
powerpc               randconfig-002-20260126    clang-22
powerpc                     skiroot_defconfig    clang-22
powerpc64             randconfig-001-20260126    gcc-8.5.0
powerpc64             randconfig-002-20260126    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv             nommu_k210_sdcard_defconfig    gcc-15.2.0
riscv                 randconfig-001-20260125    clang-22
riscv                 randconfig-002-20260125    clang-16
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                  randconfig-001-20260125    gcc-11.5.0
s390                  randconfig-002-20260125    gcc-9.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                        dreamcast_defconfig    gcc-15.2.0
sh                    randconfig-001-20260125    gcc-15.2.0
sh                    randconfig-002-20260125    gcc-14.3.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260125    gcc-8.5.0
sparc                 randconfig-002-20260125    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260125    gcc-12.5.0
sparc64               randconfig-002-20260125    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260125    gcc-14
um                    randconfig-002-20260125    clang-16
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260125    clang-20
x86_64      buildonly-randconfig-002-20260125    gcc-14
x86_64      buildonly-randconfig-003-20260125    clang-20
x86_64      buildonly-randconfig-004-20260125    clang-20
x86_64      buildonly-randconfig-005-20260125    gcc-14
x86_64      buildonly-randconfig-006-20260125    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260125    gcc-14
x86_64                randconfig-002-20260125    gcc-14
x86_64                randconfig-003-20260125    gcc-14
x86_64                randconfig-004-20260125    gcc-14
x86_64                randconfig-005-20260125    gcc-14
x86_64                randconfig-006-20260125    gcc-14
x86_64                randconfig-011-20260126    gcc-12
x86_64                randconfig-012-20260126    gcc-12
x86_64                randconfig-013-20260126    clang-20
x86_64                randconfig-014-20260126    gcc-14
x86_64                randconfig-015-20260126    gcc-14
x86_64                randconfig-016-20260126    gcc-14
x86_64                randconfig-071-20260125    clang-20
x86_64                randconfig-072-20260125    gcc-14
x86_64                randconfig-073-20260125    clang-20
x86_64                randconfig-074-20260125    gcc-14
x86_64                randconfig-075-20260125    gcc-14
x86_64                randconfig-076-20260125    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260125    gcc-12.5.0
xtensa                randconfig-002-20260125    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

