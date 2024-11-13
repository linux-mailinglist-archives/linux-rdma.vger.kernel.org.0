Return-Path: <linux-rdma+bounces-5949-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874489C67ED
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2024 04:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCC05B23179
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2024 03:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB899157A41;
	Wed, 13 Nov 2024 03:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WDA0ngrg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E273013635C
	for <linux-rdma@vger.kernel.org>; Wed, 13 Nov 2024 03:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731470242; cv=none; b=IN6mcwjJvxTqNQP/duo/k+w0FePfzisTxwjGIKHRmkYfzL7mQ8GAKSyj58HqBfcj23tM4jw9CQ6Rj+Yf95CZ11eZB+JSFp0ySD5yP0UPmgJluJWF0WFiWxY2rmmF1G38dSnYYJ17vfAOUslLao0ytbvhKqAPhS9PjtDgVBH9tj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731470242; c=relaxed/simple;
	bh=BqUA6qdZh9YFK2M0yfKft3v/+YZ5tGL713rRAriDen4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=I87xpgjG04YMsIVeZkVH8uK8nXBCFuFv7zoBvem24JrRU9qeId0fhppa4Cd7aiDa5wGGBOCERDCsOOnKyK+aI1pNQVOoMpy2UrFT72r426A1jEohfmuagK7iUIoM0gIEOHTDuLt9MQ8EgmnMC0gN5GcEhXi11fJKLuGzduhztwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WDA0ngrg; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731470241; x=1763006241;
  h=date:from:to:cc:subject:message-id;
  bh=BqUA6qdZh9YFK2M0yfKft3v/+YZ5tGL713rRAriDen4=;
  b=WDA0ngrgNzt0WbtWJIe1ACT2LKPperXFSb3Etf2+APx2t57hy2FMgCF2
   qpnMy5e7s5jMGlCE9QBrMalCxe/Fwb4I5p211MM8/3PJZqCxie/HIUqc+
   t9KRkXpjgJMo74gmWv/ZofvQDdqsGklEkAmjplmdK+Ba1tXW993MSCsZ7
   C6LJ094t0WmWYvTxDQY1KiVckPfLbu55w8cv8wHC6EHn82QLY0zwf3fjz
   zjUbgK9w3erD8x0MWVVmwBFlarmkpmjDTaFyBlgBu6fY1WAJCXzCsk8wo
   28wXkKM7zKzebarRfPHIPlbW9H3D85PxJH7VkCiANtwEfFLRcqRLOO8M1
   w==;
X-CSE-ConnectionGUID: UYLqWXClQ7ecwUNSPiRFvw==
X-CSE-MsgGUID: F6qQASi7Tf+9VtHCR4+v6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="56735398"
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="56735398"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 19:57:18 -0800
X-CSE-ConnectionGUID: yXiQfLvsQnWQzEiFb7G88Q==
X-CSE-MsgGUID: giUh+1H4SuOasOmrFnyo/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="92672205"
Received: from lkp-server01.sh.intel.com (HELO c782e932e0d3) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 12 Nov 2024 19:57:16 -0800
Received: from kbuild by c782e932e0d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tB4VF-00002n-0c;
	Wed, 13 Nov 2024 03:57:13 +0000
Date: Wed, 13 Nov 2024 11:56:25 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 6abe2a90808192a5a8b2825293e5f10e80fdea56
Message-ID: <202411131120.5GfW3Jef-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: 6abe2a90808192a5a8b2825293e5f10e80fdea56  Revert "RDMA/core: Fix ENODEV error for iWARP test over vlan"

elapsed time: 725m

configs tested: 98
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                       allnoconfig    gcc-14.2.0
alpha                      allyesconfig    clang-20
alpha                         defconfig    gcc-14.2.0
arc                        allmodconfig    clang-20
arc                        allmodconfig    gcc-13.2.0
arc                         allnoconfig    gcc-14.2.0
arc                        allyesconfig    clang-20
arc                        allyesconfig    gcc-13.2.0
arc                           defconfig    gcc-14.2.0
arm                        allmodconfig    clang-20
arm                        allmodconfig    gcc-14.2.0
arm                         allnoconfig    gcc-14.2.0
arm                        allyesconfig    clang-20
arm                        allyesconfig    gcc-14.2.0
arm                   at91_dt_defconfig    clang-20
arm                           defconfig    gcc-14.2.0
arm                integrator_defconfig    clang-20
arm                 netwinder_defconfig    clang-20
arm                      qcom_defconfig    clang-20
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
m68k                 m5475evb_defconfig    clang-20
microblaze                 allmodconfig    gcc-14.2.0
microblaze                  allnoconfig    gcc-14.2.0
microblaze                 allyesconfig    gcc-14.2.0
microblaze                    defconfig    gcc-14.2.0
mips                        allnoconfig    gcc-14.2.0
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
powerpc                    allyesconfig    gcc-14.2.0
powerpc                  cell_defconfig    clang-20
powerpc               mpc5200_defconfig    clang-20
powerpc           mpc836x_rdk_defconfig    clang-20
powerpc            mpc866_ads_defconfig    clang-20
powerpc                pcm030_defconfig    clang-20
riscv                      allmodconfig    gcc-14.2.0
riscv                       allnoconfig    clang-20
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
sh                            defconfig    gcc-12
sh          ecovec24-romimage_defconfig    clang-20
sh             secureedge5410_defconfig    clang-20
sh             sh7724_generic_defconfig    clang-20
sh                       shx3_defconfig    clang-20
sparc                      allmodconfig    gcc-14.2.0
sparc64                       defconfig    gcc-12
um                         allmodconfig    clang-20
um                          allnoconfig    clang-20
um                         allyesconfig    clang-20
um                            defconfig    gcc-12
um                       i386_defconfig    gcc-12
um                     x86_64_defconfig    gcc-12
x86_64                      allnoconfig    clang-19
x86_64                     allyesconfig    clang-19
x86_64                        defconfig    clang-19
x86_64                            kexec    clang-19
x86_64                            kexec    gcc-12
x86_64                         rhel-8.3    gcc-12
xtensa                      allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

