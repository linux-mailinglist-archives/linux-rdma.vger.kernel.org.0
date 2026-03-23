Return-Path: <linux-rdma+bounces-18511-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHIqE9rrwGmROgQAu9opvQ
	(envelope-from <linux-rdma+bounces-18511-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 08:29:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C19032ED9EF
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 08:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5369F302FA85
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 07:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66D535E951;
	Mon, 23 Mar 2026 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zm/PxS8P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20C42882D6
	for <linux-rdma@vger.kernel.org>; Mon, 23 Mar 2026 07:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774250872; cv=none; b=K+xCq62QOKwhgcVjIvG0QE8T617yJL+chCCfVM0m/NAqYbmyeCANMyg45H8YfDXm/wCM4JmzQyOv10CiAv2eJyJBDfIjD3+FEFlYiOCnPFVmVT7ohaDeglljQFJZoNfxpTnA0cgSvUcRYsa88Vd9UBBSuodxSJ6gUCTESi5d0zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774250872; c=relaxed/simple;
	bh=wWb8WvAdVvI8zYjgzVDmQvaNr0zcjI+rmAh8oCaLX4A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ePHJfMRSi8E3LdXAS8rq35SFQVmId5aqH6jRzxMgOZRjgFXIB+Fx6eb0bCdekqjdgpJx3BPD39RLjPWM97yAXkCpc49KI6L1EpSvBkrtXs2E4W6vTMIP1tzf9BlszNEpA/m4h0lk09RBisuhDUmXaMwz3E1zZgtxWdStRhOMEEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zm/PxS8P; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774250871; x=1805786871;
  h=date:from:to:cc:subject:message-id;
  bh=wWb8WvAdVvI8zYjgzVDmQvaNr0zcjI+rmAh8oCaLX4A=;
  b=Zm/PxS8PI7MlDJNK2mU87NotNiLD8fhRl7Kwdbb7HF+ZNFkJZYZcQ0iF
   FEMbFyPzBYf20ciexiFL1JA9Xuw2Vf+VkXdEQ4eWEgMWYVFK38Y3aWKK6
   uP8cBw6SCbPyZPYhI0og2FiCgGwPVhaJHIxdld2JAQzOAcaTMYgbck3Dz
   9VjHnIkprBxbySEY8/X5HwJ6L6kkC+A9/p3oEnVPkW69fX6vaM+8INXMq
   jlCGej0dfHdx8IBHHMRr2FUrB6Hdw4MHBegDGHKyICK98Y0PRMdjEuTaW
   gbptQImr+SGKZ433fnSxPsg7oXXbV4COYGGRlnjxI6S5E7QW9nZvtJvAc
   w==;
X-CSE-ConnectionGUID: nwmS44rvSJa/q/jZohYaTA==
X-CSE-MsgGUID: p4wse1PRSpao7POf9msQ3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75364076"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="75364076"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 00:27:49 -0700
X-CSE-ConnectionGUID: PyY3uiloTZmxY1w7rEOrJA==
X-CSE-MsgGUID: OwXks5v3RVmnzc0iLMOO7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="228864317"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 23 Mar 2026 00:27:48 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w4ZhR-000000000Af-0m3x;
	Mon, 23 Mar 2026 07:27:45 +0000
Date: Mon, 23 Mar 2026 15:26:53 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 3909d195fe68eb43a0152ba6a532ba471545b372
Message-ID: <202603231544.bX9oAxqE-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-18511-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,lists];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C19032ED9EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 3909d195fe68eb43a0152ba6a532ba471545b372  RDMA/uverbs: update outdated reference to remove_commit_idr_uobject()

elapsed time: 711m

configs tested: 150
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
arc                   randconfig-001-20260323    gcc-8.5.0
arc                   randconfig-002-20260323    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260323    clang-23
arm                   randconfig-002-20260323    clang-23
arm                   randconfig-003-20260323    gcc-14.3.0
arm                   randconfig-004-20260323    gcc-10.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260323    gcc-10.5.0
arm64                 randconfig-002-20260323    gcc-11.5.0
arm64                 randconfig-003-20260323    clang-23
arm64                 randconfig-004-20260323    gcc-12.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260323    gcc-11.5.0
csky                  randconfig-002-20260323    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon               randconfig-001-20260323    clang-23
hexagon               randconfig-002-20260323    clang-17
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260323    clang-20
i386        buildonly-randconfig-002-20260323    gcc-14
i386        buildonly-randconfig-003-20260323    clang-20
i386        buildonly-randconfig-004-20260323    clang-20
i386        buildonly-randconfig-005-20260323    clang-20
i386        buildonly-randconfig-006-20260323    gcc-13
i386                                defconfig    clang-20
i386                  randconfig-001-20260323    gcc-13
i386                  randconfig-002-20260323    clang-20
i386                  randconfig-003-20260323    clang-20
i386                  randconfig-004-20260323    gcc-14
i386                  randconfig-011-20260323    clang-20
i386                  randconfig-012-20260323    clang-20
i386                  randconfig-013-20260323    clang-20
i386                  randconfig-014-20260323    gcc-14
i386                  randconfig-015-20260323    clang-20
i386                  randconfig-016-20260323    clang-20
i386                  randconfig-017-20260323    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260323    clang-18
loongarch             randconfig-002-20260323    clang-23
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
nios2                 randconfig-001-20260323    gcc-8.5.0
nios2                 randconfig-002-20260323    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260323    gcc-8.5.0
parisc                randconfig-002-20260323    gcc-13.4.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                     mpc83xx_defconfig    clang-23
powerpc               randconfig-001-20260323    clang-19
powerpc               randconfig-002-20260323    gcc-13.4.0
powerpc64             randconfig-001-20260323    clang-23
powerpc64             randconfig-002-20260323    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260323    gcc-14.3.0
riscv                 randconfig-002-20260323    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260323    gcc-8.5.0
s390                  randconfig-002-20260323    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260323    gcc-15.2.0
sh                    randconfig-002-20260323    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260323    gcc-8.5.0
sparc                 randconfig-002-20260323    gcc-13.4.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260323    gcc-8.5.0
sparc64               randconfig-002-20260323    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260323    clang-23
um                    randconfig-002-20260323    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260323    clang-20
x86_64      buildonly-randconfig-002-20260323    clang-20
x86_64      buildonly-randconfig-003-20260323    gcc-14
x86_64      buildonly-randconfig-004-20260323    clang-20
x86_64      buildonly-randconfig-005-20260323    clang-20
x86_64      buildonly-randconfig-006-20260323    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260323    clang-20
x86_64                randconfig-002-20260323    gcc-14
x86_64                randconfig-003-20260323    gcc-14
x86_64                randconfig-004-20260323    clang-20
x86_64                randconfig-005-20260323    gcc-14
x86_64                randconfig-006-20260323    clang-20
x86_64                randconfig-011-20260323    gcc-13
x86_64                randconfig-012-20260323    gcc-14
x86_64                randconfig-071-20260323    clang-20
x86_64                randconfig-072-20260323    clang-20
x86_64                randconfig-073-20260323    clang-20
x86_64                randconfig-074-20260323    gcc-13
x86_64                randconfig-075-20260323    clang-20
x86_64                randconfig-076-20260323    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260323    gcc-13.4.0
xtensa                randconfig-002-20260323    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

