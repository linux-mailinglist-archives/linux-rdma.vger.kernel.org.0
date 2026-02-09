Return-Path: <linux-rdma+bounces-16686-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJNkLZQTimlrGAAAu9opvQ
	(envelope-from <linux-rdma+bounces-16686-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Feb 2026 18:04:20 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C79E112D79
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Feb 2026 18:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CB753021E43
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Feb 2026 16:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8274A3816EC;
	Mon,  9 Feb 2026 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hBJq982R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C95243387
	for <linux-rdma@vger.kernel.org>; Mon,  9 Feb 2026 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770656330; cv=none; b=LIQ8Il32wNN8Fm3Y63gmeJ7k8TtwQlOQURtGqGwTZum8E0TUiWIKL4bcoGYJEI89FrDjhKzkuTRzcNc8b3kJ/HXGeBxRlaKEVGp1PuJ1tA45NpV/BO87vzQYtKtfyvOX43ADWsNoAciF2Jc9xCEXuLFhiFdeMQxWuqzB//bXq7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770656330; c=relaxed/simple;
	bh=85oaoBxlwrdtTXUTkxjFmeBmx1MVGM73U+yJ3bLlM7o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pRiXYBypRquDjQTB7PEwUoAP+x87p7pwiBUkxdXBue85y9Gf/0mF6/RKWGhP1jz2v1u0FlOtlVd75fDwAt2dwnJVb+XTJrvWBcPeLOX91uteJEixUk2Fv2QSqRTFOah6AX3sXCowpKA7y6VxCUq8Vr7FjC3f0TF6TObY+8GhgI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hBJq982R; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770656330; x=1802192330;
  h=date:from:to:cc:subject:message-id;
  bh=85oaoBxlwrdtTXUTkxjFmeBmx1MVGM73U+yJ3bLlM7o=;
  b=hBJq982R9DVNiwk9Y31+19Y+MnQXqXLxhkzWLchNHdFD4jWCf6876zfk
   le3yPU/gsM58ItmEJAj+WXdhC3Jr28dQ0A/FXVzT39fcBOnQtC/L/VIir
   1lJ+ZIRsjU4SZVxapIAJxc7Eq55G1KX0bpoQIKq8K43bBbpvHX/gIzYep
   olhko2S4ayjP7sFsvI8lmga8DBbUdeEuz/FJd7LU8EIbwxL2lNr05/JFl
   YfbOn4laCpvyuNcjYo/z2HoGLfoGSl9wEvlLPLf36qAx4dzYP+Yuv8O9d
   sPn72HrE54OOA44/g/+Zo8YFbwxNaJ7ZbswrdhAoW+1UVuJYilgv04TAu
   g==;
X-CSE-ConnectionGUID: e5RXq3eXQlyCfMAuUcjgVw==
X-CSE-MsgGUID: kh4Z0yfTSamFJspMdpbnkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="59336521"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="59336521"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 08:58:49 -0800
X-CSE-ConnectionGUID: 4gYQy9nGT1OLtf87wPg85g==
X-CSE-MsgGUID: fOKGGmF0TeahbKOaLIor9g==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 Feb 2026 08:58:47 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vpUaz-00000000o8i-1CmI;
	Mon, 09 Feb 2026 16:58:45 +0000
Date: Tue, 10 Feb 2026 00:58:29 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 d6c58f4eb3d00a695f5a610ea780cad322ec714e
Message-ID: <202602100020.GnlreN6K-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16686-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 1C79E112D79
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: d6c58f4eb3d00a695f5a610ea780cad322ec714e  RDMA/mlx5: Implement DMABUF export ops

elapsed time: 726m

configs tested: 163
configs skipped: 4

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
arc                   randconfig-001-20260209    gcc-10.5.0
arc                   randconfig-002-20260209    gcc-10.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260209    gcc-15.2.0
arm                   randconfig-002-20260209    gcc-12.5.0
arm                   randconfig-003-20260209    gcc-8.5.0
arm                   randconfig-004-20260209    gcc-14.3.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260209    clang-22
arm64                 randconfig-002-20260209    gcc-15.2.0
arm64                 randconfig-003-20260209    clang-19
arm64                 randconfig-004-20260209    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260209    gcc-10.5.0
csky                  randconfig-002-20260209    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20260209    clang-16
hexagon               randconfig-002-20260209    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260209    gcc-14
i386        buildonly-randconfig-002-20260209    clang-20
i386        buildonly-randconfig-003-20260209    gcc-14
i386        buildonly-randconfig-004-20260209    clang-20
i386        buildonly-randconfig-005-20260209    clang-20
i386        buildonly-randconfig-006-20260209    gcc-13
i386                                defconfig    clang-20
i386                  randconfig-001-20260209    clang-20
i386                  randconfig-002-20260209    gcc-14
i386                  randconfig-003-20260209    clang-20
i386                  randconfig-004-20260209    clang-20
i386                  randconfig-005-20260209    clang-20
i386                  randconfig-006-20260209    clang-20
i386                  randconfig-007-20260209    clang-20
i386                  randconfig-011-20260209    clang-20
i386                  randconfig-012-20260209    gcc-14
i386                  randconfig-013-20260209    clang-20
i386                  randconfig-014-20260209    gcc-14
i386                  randconfig-015-20260209    gcc-14
i386                  randconfig-016-20260209    gcc-14
i386                  randconfig-017-20260209    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260209    clang-18
loongarch             randconfig-002-20260209    clang-22
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
mips                         cobalt_defconfig    gcc-15.2.0
mips                     cu1830-neo_defconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260209    gcc-8.5.0
nios2                 randconfig-002-20260209    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260209    gcc-12.5.0
parisc                randconfig-002-20260209    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                       ebony_defconfig    clang-22
powerpc                      ppc6xx_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260209    gcc-10.5.0
powerpc               randconfig-002-20260209    clang-22
powerpc                     tqm8560_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260209    clang-22
powerpc64             randconfig-002-20260209    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20260209    gcc-9.5.0
riscv                 randconfig-002-20260209    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                  randconfig-001-20260209    gcc-12.5.0
s390                  randconfig-002-20260209    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                         apsh4a3a_defconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260209    gcc-10.5.0
sh                    randconfig-002-20260209    gcc-9.5.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260209    gcc-8.5.0
sparc                 randconfig-002-20260209    gcc-11.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260209    clang-22
sparc64               randconfig-002-20260209    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260209    gcc-14
um                    randconfig-002-20260209    clang-18
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260209    gcc-14
x86_64      buildonly-randconfig-002-20260209    gcc-14
x86_64      buildonly-randconfig-003-20260209    clang-20
x86_64      buildonly-randconfig-004-20260209    clang-20
x86_64      buildonly-randconfig-005-20260209    gcc-14
x86_64      buildonly-randconfig-006-20260209    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260209    gcc-12
x86_64                randconfig-002-20260209    gcc-14
x86_64                randconfig-003-20260209    gcc-14
x86_64                randconfig-004-20260209    gcc-12
x86_64                randconfig-005-20260209    clang-20
x86_64                randconfig-006-20260209    gcc-14
x86_64                randconfig-011-20260209    clang-20
x86_64                randconfig-012-20260209    clang-20
x86_64                randconfig-013-20260209    gcc-13
x86_64                randconfig-014-20260209    clang-20
x86_64                randconfig-015-20260209    gcc-14
x86_64                randconfig-016-20260209    gcc-14
x86_64                randconfig-071-20260209    clang-20
x86_64                randconfig-072-20260209    gcc-14
x86_64                randconfig-073-20260209    clang-20
x86_64                randconfig-074-20260209    clang-20
x86_64                randconfig-075-20260209    clang-20
x86_64                randconfig-076-20260209    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260209    gcc-8.5.0
xtensa                randconfig-002-20260209    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

