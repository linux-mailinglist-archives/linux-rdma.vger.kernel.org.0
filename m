Return-Path: <linux-rdma+bounces-5393-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3227699BF07
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2024 06:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1D61F250B9
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2024 04:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D1B136E3B;
	Mon, 14 Oct 2024 04:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RA4p7dzH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C137231CB2
	for <linux-rdma@vger.kernel.org>; Mon, 14 Oct 2024 04:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878435; cv=none; b=YkXZqhFdj2yDJRzoZ//ihG/ej1D9csiWlafanUXWSUcER6rWgyQ7v9ePhJc0uc72ACryjQhTFnNvb1TVS4jpb2sR/jYpAJq3tCnuWpaTvdtN8d2BEX9jCRPSNFBYqfM/Dm/L3zXa5ocX18K6NrHydCiBau6zInxjgApwxDQpJCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878435; c=relaxed/simple;
	bh=0iKo+EC/e2thr3spqOvswgEhD22a3K4kD1Fyn363QNo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cCpGSzXoQM8JwENFMMBHwJH0Aqxap/vSeYEnccdVguAOqKnzucR36UVouRkOx/4bBHOfGpGtUEqPqTC0HCRaYQHWC/Rte0cx+ezDKTdQ+9A/dp4p+xiHCI2RVVi0UHJt0D5cwzuWXHvGu51T4Xq6jBvtRwtosU67t0vB7P4286o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RA4p7dzH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728878434; x=1760414434;
  h=date:from:to:cc:subject:message-id;
  bh=0iKo+EC/e2thr3spqOvswgEhD22a3K4kD1Fyn363QNo=;
  b=RA4p7dzHYGRWKvpkSR9W8o9xdySjlZZpWWoqbJEoNmT4o+nCroTOOH2V
   edRW5Lh3Ifmgw8F8lmPnLqm4VkJjNN3AbqrBzDK+vRmnP362Ljjajrpz3
   qr4qDWQl0He7SpTn0HDu3OIlZksPO1N9rUmsQRetw46i81wglyc3tYgSY
   TRmuvlzy9/aYGiAkr8D9zOtwVOmBpetCp7CgXQ80WzB1hHZwEqQtVJd/g
   DjgyzBDkbvLSS8XojMX4Q4ZDOCQ2Nv3dER7R+SuwECSHCrbK2NIHvRXm9
   saU4mZOpvZRMtclcsl1q3dCz9+gME8LZzrRVKLoJAtdTYbLXag4XJO+e1
   A==;
X-CSE-ConnectionGUID: qgrB9dU3T2y0MjaXBs8cYw==
X-CSE-MsgGUID: 3e+dI5msRrKC9WM5SnrImA==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="53632762"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="53632762"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 21:00:33 -0700
X-CSE-ConnectionGUID: vz00FLGOTL2dfgWIUkwfbw==
X-CSE-MsgGUID: 4sIGAsU1QwqC8JZ3jMmUoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="77079995"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 13 Oct 2024 21:00:32 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0CFx-000EtV-1Y;
	Mon, 14 Oct 2024 04:00:29 +0000
Date: Mon, 14 Oct 2024 11:59:52 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 dc5006cfcf62bea88076a587344ba5e00e66d1c6
Message-ID: <202410141146.ByagLj2v-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: dc5006cfcf62bea88076a587344ba5e00e66d1c6  RDMA/bnxt_re: Fix the GID table length

elapsed time: 3075m

configs tested: 60
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
arc                               allnoconfig    gcc-13.2.0
arc                   randconfig-001-20241014    gcc-13.2.0
arc                   randconfig-002-20241014    gcc-13.2.0
arm                               allnoconfig    clang-20
arm                   randconfig-001-20241014    clang-20
arm                   randconfig-002-20241014    gcc-14.1.0
arm64                             allnoconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
hexagon                           allnoconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241013    clang-18
i386        buildonly-randconfig-002-20241013    gcc-12
i386        buildonly-randconfig-003-20241013    clang-18
i386        buildonly-randconfig-004-20241013    gcc-12
i386        buildonly-randconfig-005-20241013    clang-18
i386        buildonly-randconfig-006-20241013    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241013    clang-18
i386                  randconfig-002-20241013    gcc-12
i386                  randconfig-003-20241013    gcc-12
i386                  randconfig-004-20241013    gcc-11
i386                  randconfig-012-20241013    gcc-12
i386                  randconfig-014-20241013    gcc-12
i386                  randconfig-016-20241013    clang-18
loongarch                         allnoconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                              defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-14.1.0
um                                allnoconfig    clang-17
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

