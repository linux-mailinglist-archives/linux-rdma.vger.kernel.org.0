Return-Path: <linux-rdma+bounces-5948-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4B29C67C9
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2024 04:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C115282B11
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2024 03:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3B957CBE;
	Wed, 13 Nov 2024 03:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2wX9vaE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A072166310
	for <linux-rdma@vger.kernel.org>; Wed, 13 Nov 2024 03:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731468269; cv=none; b=OH+bfVXZDjxG/CDqRkUFefeiR2uO92L7tmyZWeqxggtV1zCOwHtVdgZcJsSeWOXlYpfmGNddJULIXdcvvZuFhZTVJ0riYxKtMoNYNPXghiOcH9H+9HA7MOsHtnYgeOJ8YGnnytggIALrJQS2S9lxQkCe2T/7pCc0omu2vsidvwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731468269; c=relaxed/simple;
	bh=ZxCA3yGLdrmAwWkvfkBhfFW8kUv/A83RKNkJUhL3QeY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=lF1c29WZImV6L1ur5YFL6zSvquwkt7i4hV9NzGf2w57n/djhpUbhL5GHIdKxtFkyTjtNeQylWnXKG08uCs35eFGng+vhYlSwapR9NsqQZ2T261TXo9DXw9zoGDLW225ef+/QQDQNGsnIRzpiWlPERR5HmBCVsldsvfgBzVf2xeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2wX9vaE; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731468269; x=1763004269;
  h=date:from:to:cc:subject:message-id;
  bh=ZxCA3yGLdrmAwWkvfkBhfFW8kUv/A83RKNkJUhL3QeY=;
  b=d2wX9vaEtd4k2CqAxRFcT2xqM/kzIt/JppbhugnIOahHwPbKqSzt6dcD
   pePgUPvuMUj6zeltkU0JUicK/DmAKvvn1MnCalL0SYgJVIEK7EHUhIUyH
   3QdIxuRMZkDHVLwUKFbtvZyhRl07wQ8bxhbH8IfH4n3JVqPM9YzCihpLd
   1xU+170kmJBdKZaG49ngsiXdd54LnQO7dzqQ2XJWOPhbjbmpJSTBcLPnH
   mBRXo9n0TB6+quiDrPXPbGyq3iF2Ht+vCILFP9DzELuAHlZ7dwLT8Rzbs
   UWgKUsFl6pqh8lXqlY8uuKXkKrmEn9di4o309MPNSIePuoO0v871eyJZi
   Q==;
X-CSE-ConnectionGUID: tzQOcyyeRiq2G6xZwPa3VA==
X-CSE-MsgGUID: Dcj5NmOtSM+Og/LMZdrXOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="42458180"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="42458180"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 19:24:27 -0800
X-CSE-ConnectionGUID: FEGc34urTASajkC5e1HrUg==
X-CSE-MsgGUID: 15JeIO7PTduRXoRuVwb6Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="88123256"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 12 Nov 2024 19:24:26 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tB3zT-0001yv-0E;
	Wed, 13 Nov 2024 03:24:23 +0000
Date: Wed, 13 Nov 2024 11:23:35 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 cdb21c12adcb9eaf97ac085fd0d1382f9830224b
Message-ID: <202411131130.pePPRIHg-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: cdb21c12adcb9eaf97ac085fd0d1382f9830224b  RDMA/bnxt_re: Add set_func_resources support for P5/P7 adapters

elapsed time: 836m

configs tested: 122
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                       allnoconfig    gcc-14.2.0
alpha                      allyesconfig    clang-20
alpha                      allyesconfig    gcc-14.2.0
alpha                         defconfig    gcc-14.2.0
arc                        allmodconfig    clang-20
arc                        allmodconfig    gcc-13.2.0
arc                         allnoconfig    gcc-14.2.0
arc                        allyesconfig    clang-20
arc                        allyesconfig    gcc-13.2.0
arc                           defconfig    gcc-14.2.0
arc                      hsdk_defconfig    gcc-14.2.0
arm                        allmodconfig    clang-20
arm                        allmodconfig    gcc-14.2.0
arm                         allnoconfig    gcc-14.2.0
arm                        allyesconfig    clang-20
arm                        allyesconfig    gcc-14.2.0
arm                   at91_dt_defconfig    clang-20
arm               davinci_all_defconfig    gcc-14.2.0
arm                           defconfig    gcc-14.2.0
arm                integrator_defconfig    clang-20
arm                  keystone_defconfig    gcc-14.2.0
arm                  mvebu_v5_defconfig    gcc-14.2.0
arm                 netwinder_defconfig    clang-20
arm                      qcom_defconfig    clang-20
arm                  shmobile_defconfig    gcc-14.2.0
arm64                      alldefconfig    gcc-14.2.0
arm64                      allmodconfig    clang-20
arm64                       allnoconfig    gcc-14.2.0
arm64                         defconfig    clang-20
arm64                         defconfig    gcc-14.2.0
csky                        allnoconfig    gcc-14.2.0
csky                          defconfig    gcc-14.2.0
hexagon                    allmodconfig    clang-20
hexagon                     allnoconfig    gcc-14.2.0
hexagon                    allyesconfig    clang-20
hexagon                       defconfig    gcc-14.2.0
i386                       allmodconfig    clang-19
i386                        allnoconfig    clang-19
i386                       allyesconfig    clang-19
i386                          defconfig    clang-19
loongarch                  allmodconfig    gcc-14.2.0
loongarch                   allnoconfig    gcc-14.2.0
loongarch                     defconfig    gcc-14.2.0
m68k                       allmodconfig    gcc-14.2.0
m68k                        allnoconfig    gcc-14.2.0
m68k                       allyesconfig    gcc-14.2.0
m68k                          defconfig    gcc-14.2.0
m68k                 m5249evb_defconfig    gcc-14.2.0
m68k                 m5475evb_defconfig    clang-20
microblaze                 allmodconfig    gcc-14.2.0
microblaze                  allnoconfig    gcc-14.2.0
microblaze                 allyesconfig    gcc-14.2.0
microblaze                    defconfig    gcc-14.2.0
mips                        allnoconfig    gcc-14.2.0
mips                  qi_lb60_defconfig    gcc-14.2.0
mips                     xway_defconfig    clang-20
nios2                       allnoconfig    gcc-14.2.0
nios2                         defconfig    gcc-14.2.0
openrisc                    allnoconfig    clang-20
openrisc                   allyesconfig    gcc-14.2.0
openrisc                      defconfig    gcc-12
parisc                     allmodconfig    gcc-14.2.0
parisc                      allnoconfig    clang-20
parisc                     allyesconfig    gcc-14.2.0
parisc                        defconfig    gcc-12
parisc64                      defconfig    gcc-14.2.0
powerpc              adder875_defconfig    clang-20
powerpc                    allmodconfig    gcc-14.2.0
powerpc                     allnoconfig    clang-20
powerpc                    allyesconfig    clang-20
powerpc                    allyesconfig    gcc-14.2.0
powerpc                  cell_defconfig    clang-20
powerpc           linkstation_defconfig    gcc-14.2.0
powerpc               mpc512x_defconfig    gcc-14.2.0
powerpc               mpc5200_defconfig    clang-20
powerpc           mpc836x_rdk_defconfig    clang-20
powerpc            mpc866_ads_defconfig    clang-20
powerpc                pcm030_defconfig    clang-20
powerpc               ppa8548_defconfig    gcc-14.2.0
powerpc               sequoia_defconfig    gcc-14.2.0
powerpc               tqm8555_defconfig    gcc-14.2.0
riscv                      allmodconfig    clang-20
riscv                      allmodconfig    gcc-14.2.0
riscv                       allnoconfig    clang-20
riscv                      allyesconfig    clang-20
riscv                      allyesconfig    gcc-14.2.0
riscv                         defconfig    gcc-12
s390                       allmodconfig    clang-20
s390                       allmodconfig    gcc-14.2.0
s390                        allnoconfig    clang-20
s390                       allyesconfig    gcc-14.2.0
s390                          defconfig    gcc-12
sh                         allmodconfig    gcc-14.2.0
sh                          allnoconfig    gcc-14.2.0
sh                         allyesconfig    gcc-14.2.0
sh                   apsh4a3a_defconfig    gcc-14.2.0
sh                            defconfig    gcc-12
sh          ecovec24-romimage_defconfig    clang-20
sh             secureedge5410_defconfig    clang-20
sh               sh7710voipgw_defconfig    gcc-14.2.0
sh             sh7724_generic_defconfig    clang-20
sh                       shx3_defconfig    clang-20
sparc                      allmodconfig    gcc-14.2.0
sparc64                       defconfig    gcc-12
um                         allmodconfig    clang-20
um                          allnoconfig    clang-20
um                         allyesconfig    clang-20
um                         allyesconfig    gcc-12
um                            defconfig    gcc-12
um                       i386_defconfig    gcc-12
um                     x86_64_defconfig    gcc-12
x86_64                      allnoconfig    clang-19
x86_64                     allyesconfig    clang-19
x86_64                        defconfig    clang-19
x86_64                            kexec    clang-19
x86_64                            kexec    gcc-12
x86_64                         rhel-8.3    gcc-12
x86_64                     rhel-8.3-bpf    clang-19
x86_64                   rhel-8.3-kunit    clang-19
x86_64                     rhel-8.3-ltp    clang-19
x86_64                    rhel-8.3-rust    clang-19
xtensa                      allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

