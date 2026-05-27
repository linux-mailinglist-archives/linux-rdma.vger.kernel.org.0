Return-Path: <linux-rdma+bounces-21400-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLxAHglIF2qS/QcAu9opvQ
	(envelope-from <linux-rdma+bounces-21400-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 21:37:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9325E992D
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 21:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71B9630C012A
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B647E38CFE7;
	Wed, 27 May 2026 19:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPuouXGT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A980038BF6C
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779910556; cv=none; b=D5i5QoR8im+ImQPazoSinB52+N4xLCE6e8rArk6piq6qnz38Q1t5/gB32tVLXSQXKEtVdZIk8jLzgoNJZSlW2tyOD8iImH4K8DQPGRdw3dnCimAcAihJbfSsVkXyvuYOMecjuVDANCbGWRiKLHi6hadhJ9cvgnRAZZVtBF6wrbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779910556; c=relaxed/simple;
	bh=Or5DIdfRyBgj0Ozerswl+RaS4W3B429sNgLfsOkt2uk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iJFwrGh1K2PFYO88YPBq/ORaOAtD7EnHdSH2ttpR27zCGLBdf89JSFAy4xD19ZNwN/qKpsCdLbEvHAQTiVks5uvYmwrhFFsn8PbTEuFq7rXrBJiDiDRMQ/pxIm+unfjfjYcqiiXM2pFFHmuggKJMDIulXCKV+k/pQxEO02bsmV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPuouXGT; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779910552; x=1811446552;
  h=date:from:to:cc:subject:message-id;
  bh=Or5DIdfRyBgj0Ozerswl+RaS4W3B429sNgLfsOkt2uk=;
  b=mPuouXGTcovzdN/E5JiHZnG0RiCrrv26gT9g/a3ajoiCHRocIPk4/SNx
   eopzA6Zf5A5b+olOJji28c0AzfJdFxgSY0jGLvL/ZFJotLFLmBuZ3gpu8
   KHhlUsIVo9fc4gaURB75XlTA4ZbfbABww1WV26abp3VVv0sFh2J3h57zY
   KVmHGEXl7w5lMY8RMK4j9NsR1l9nuif4VajXTxQTkDQcRgqUnQOXl5pCQ
   efLCcTHQzh/dx/ut+78xCDKI+5tSCmzGtT5nMmnkdGPvTvEKMRoaSTFoJ
   LHcKaEuniAAyzIdES6fW4UPoN0Y405Nl7Nk9KrY+8IkGbbIWDcscrG9Dv
   Q==;
X-CSE-ConnectionGUID: TledyPlEScO11vyWbGPtkg==
X-CSE-MsgGUID: iDVA00sATH6LRGurfPSnNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80740334"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80740334"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 12:35:44 -0700
X-CSE-ConnectionGUID: 6n5y0SiwSKOUDact2ynWfw==
X-CSE-MsgGUID: SQas3cP3TKSwChmBAqZ1vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="246361867"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 27 May 2026 12:35:43 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wSK2V-000000004Na-3QMD;
	Wed, 27 May 2026 19:35:39 +0000
Date: Thu, 28 May 2026 03:35:15 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 9733e9f580fdda2e8c1cd349caddd93f026ab6f5
Message-ID: <202605280304.sva4NNhX-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21400-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6C9325E992D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 9733e9f580fdda2e8c1cd349caddd93f026ab6f5  RDMA/core: Move flow related functions to ib_uverbs_support.ko

elapsed time: 1650m

configs tested: 83
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260527    gcc-8.5.0
arm64                 randconfig-004-20260527    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-002-20260527    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch             randconfig-001-20260527    clang-19
loongarch             randconfig-002-20260527    gcc-13.4.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260527    gcc-14.3.0
sparc                 randconfig-002-20260527    gcc-14.3.0
sparc                       sparc32_defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260527    clang-20
sparc64               randconfig-002-20260527    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260527    gcc-14
um                    randconfig-002-20260527    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260527    clang-20
x86_64      buildonly-randconfig-002-20260527    gcc-14
x86_64      buildonly-randconfig-003-20260527    gcc-14
x86_64      buildonly-randconfig-004-20260527    gcc-14
x86_64      buildonly-randconfig-005-20260527    gcc-14
x86_64      buildonly-randconfig-006-20260527    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260527    gcc-8.5.0
xtensa                randconfig-002-20260527    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

