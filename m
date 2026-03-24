Return-Path: <linux-rdma+bounces-18581-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKDEMiObwmm3fQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18581-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 15:09:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 248EB309F1B
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 15:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 311BD304669F
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 14:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5597F2288CB;
	Tue, 24 Mar 2026 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jxlg7Ypd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EE13D566E
	for <linux-rdma@vger.kernel.org>; Tue, 24 Mar 2026 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774361301; cv=none; b=GwkOTdQT/KR4ohzo/WpZ+Sv0C9oa1Bod8cTO+P3rV1aR8fNpYW2wz6hO4Gz1EzbSQkLWo3SfuHRnyEPiSKwtXpQdkGj/GeT5E9OB+BKEBgBctsif1ldyYsC36tP0Yyl+ydOzs5rYS6QETmDhWOjKEooiWrOaJzNHuemYzZQsVOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774361301; c=relaxed/simple;
	bh=XEn1VuJwVv6wETJzSwh5fpz6cCLUx5iemJPaRq+7GmM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EfVpiPkik4tyRHYmHOU9L+yOyi3z3if3DOCE1eg/4gaTvcCZnti+0DJLs/pjcbX2CRrH2LsZVNX46DRiGazDMWzHojdzef/du/uh0rzweJwmkNijw0WNTARqFHv8dXtqMQQwEVkL2uOa9jsYx5nDIIWOkpSyeC7Jq0FJNnQ0bKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jxlg7Ypd; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774361300; x=1805897300;
  h=date:from:to:cc:subject:message-id;
  bh=XEn1VuJwVv6wETJzSwh5fpz6cCLUx5iemJPaRq+7GmM=;
  b=jxlg7YpdX8gBIb3wEnsuGDRcPSKEbK6e8lFwqfA+X+eN1357PO23mcVJ
   k8y5tGnjE1E1sCdWbNO3Ykqlb/4ytijrdGWHqGAwmt806ZvT58BQqWwXd
   b/t9+mOZmp3rvCZhzOhiXgz62dY9qVjAkTMZnDQqz344WwW2LWAYhA5G0
   dcRLbAS4NJhh4bMS2XVg7L2nXgRva4kvP9Xrib3eupJ/XOz55bJUzRXk5
   Ff3BXd2e6rT9x1n2SvMVW07p9BNWTuIZlPj96KhoekSh9E0Z1VIkSzgsj
   lH5QXgaQCu6tpp4y7qhrsIALMl52tWLufRXzfXNo2LJdnRpwKHNi+Z0RU
   Q==;
X-CSE-ConnectionGUID: Vmp6EXKfSva2iIxfjymJ3w==
X-CSE-MsgGUID: CEVR26H6TqqWz2WIqCDemA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86849135"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86849135"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 07:08:19 -0700
X-CSE-ConnectionGUID: 909sap2jQvKM3glzhPIFrg==
X-CSE-MsgGUID: 8+Stw+L2TviYDqM36PJing==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="217792058"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 24 Mar 2026 07:08:16 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w52QY-000000004f9-1dLn;
	Tue, 24 Mar 2026 14:08:14 +0000
Date: Tue, 24 Mar 2026 22:07:17 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 6edef31ef9004ed51624246a04f7f81112f485b0
Message-ID: <202603242208.rZqjr3GZ-lkp@intel.com>
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18581-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 248EB309F1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 6edef31ef9004ed51624246a04f7f81112f485b0  RDMA/uverbs: Update outdated reference to remove_commit_idr_uobject()

elapsed time: 1202m

configs tested: 187
configs skipped: 3

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
arc                   randconfig-001-20260324    gcc-11.5.0
arc                   randconfig-001-20260324    gcc-8.5.0
arc                   randconfig-002-20260324    gcc-8.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260324    gcc-8.5.0
arm                   randconfig-002-20260324    gcc-14.3.0
arm                   randconfig-002-20260324    gcc-8.5.0
arm                   randconfig-003-20260324    gcc-8.5.0
arm                   randconfig-004-20260324    clang-23
arm                   randconfig-004-20260324    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260324    gcc-13.4.0
arm64                 randconfig-002-20260324    gcc-13.4.0
arm64                 randconfig-003-20260324    gcc-13.4.0
arm64                 randconfig-004-20260324    gcc-13.4.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260324    gcc-13.4.0
csky                  randconfig-002-20260324    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260324    gcc-11.5.0
hexagon               randconfig-002-20260324    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260324    gcc-12
i386        buildonly-randconfig-002-20260324    gcc-12
i386        buildonly-randconfig-003-20260324    gcc-12
i386        buildonly-randconfig-004-20260324    gcc-12
i386        buildonly-randconfig-005-20260324    gcc-12
i386        buildonly-randconfig-006-20260324    gcc-12
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260324    clang-20
i386                  randconfig-002-20260324    clang-20
i386                  randconfig-003-20260324    clang-20
i386                  randconfig-004-20260324    clang-20
i386                  randconfig-005-20260324    clang-20
i386                  randconfig-006-20260324    clang-20
i386                  randconfig-007-20260324    clang-20
i386                  randconfig-011-20260324    gcc-13
i386                  randconfig-012-20260324    gcc-13
i386                  randconfig-013-20260324    gcc-13
i386                  randconfig-014-20260324    gcc-13
i386                  randconfig-015-20260324    gcc-13
i386                  randconfig-016-20260324    gcc-13
i386                  randconfig-017-20260324    gcc-13
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260324    gcc-11.5.0
loongarch             randconfig-002-20260324    gcc-11.5.0
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
mips                           mtx1_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260324    gcc-11.5.0
nios2                 randconfig-002-20260324    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260324    gcc-8.5.0
parisc                randconfig-002-20260324    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc               randconfig-001-20260324    gcc-8.5.0
powerpc               randconfig-002-20260324    gcc-8.5.0
powerpc                  storcenter_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260324    gcc-8.5.0
powerpc64             randconfig-002-20260324    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260324    clang-23
riscv                 randconfig-002-20260324    clang-23
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260324    clang-23
s390                  randconfig-001-20260324    gcc-12.5.0
s390                  randconfig-002-20260324    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260324    clang-23
sh                    randconfig-001-20260324    gcc-15.2.0
sh                    randconfig-002-20260324    clang-23
sh                    randconfig-002-20260324    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260324    gcc-14
sparc                 randconfig-002-20260324    gcc-14
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260324    gcc-14
sparc64               randconfig-002-20260324    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260324    gcc-14
um                    randconfig-002-20260324    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
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
x86_64                randconfig-002-20260324    clang-20
x86_64                randconfig-003-20260324    clang-20
x86_64                randconfig-004-20260324    clang-20
x86_64                randconfig-005-20260324    clang-20
x86_64                randconfig-006-20260324    clang-20
x86_64                randconfig-011-20260324    gcc-14
x86_64                randconfig-012-20260324    gcc-14
x86_64                randconfig-013-20260324    gcc-14
x86_64                randconfig-014-20260324    gcc-14
x86_64                randconfig-015-20260324    gcc-14
x86_64                randconfig-016-20260324    gcc-14
x86_64                randconfig-071-20260324    gcc-12
x86_64                randconfig-072-20260324    gcc-12
x86_64                randconfig-073-20260324    gcc-12
x86_64                randconfig-074-20260324    gcc-12
x86_64                randconfig-075-20260324    gcc-12
x86_64                randconfig-076-20260324    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260324    gcc-14
xtensa                randconfig-002-20260324    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

