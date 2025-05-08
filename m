Return-Path: <linux-rdma+bounces-10130-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB2FAAF1FE
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 06:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44AD71BC7648
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 04:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE4420409A;
	Thu,  8 May 2025 04:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nk+dkeBb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B34C1DF99C
	for <linux-rdma@vger.kernel.org>; Thu,  8 May 2025 04:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746677440; cv=none; b=YJYDSTuIWro1aDeEj0cuNGQrFo8Dte1zIPOtBQFpV29zyp/XNwnZPHemUqXt6VZ+M3aTp2dTEXcu078LphzK2g6f7BU1v2S06L5Rvxa+GmAjD/wfxA1BHzyLLZjBLsCBX3G9meBbde+FF3w+2n/P3lz4gxtLXg6a5b96i/++t/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746677440; c=relaxed/simple;
	bh=YidFV3KmF5dkJz8hlvA+efy1ZOfeR3fwHPggntmeqag=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XLboDt85WRz0sJEgOSFlWfzllDoLKEwh7CBzpvEYns2j6SjrbjGtXiOsGZHW0dOC7zg5F6xXY2FNs500ZossiDD0JDfSMYgZXYy0NOxI5u4XQX+6x4GuacFdMIvYwVHbHKQ00SyzcYXuNkF3UIiEvy5xJhxMLAhRKiWH/wv4xu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nk+dkeBb; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746677438; x=1778213438;
  h=date:from:to:cc:subject:message-id;
  bh=YidFV3KmF5dkJz8hlvA+efy1ZOfeR3fwHPggntmeqag=;
  b=nk+dkeBbod7Y00/nvL1vxih21yRX5/VygqmDjFf4stOJoKo4IyDQ0PPu
   tU682p6Dnepgumn7HxtnHDiCfcSItF/bFSQd1/guw/VDNGlPWEkKbjj0Q
   wDV5G9dncG2P7zf9oTiAiDEuHaELcRYgiVoUUv7ITF+sZYsheHR8HWPGj
   uM0Qp7EAbN/vjVOwGfra33P8FcwyZDfPKfRZ2GS7+pLnmTMADse/qHxvW
   cQJbip9/flXHmJpLHYduMnEUKrB/DMDl3OW91kv4kC1S1QPxF31Oh2m0U
   d5edosK9uamOjXlvg4/IvxTRoPNzbrlahEh5RlMTLqNpGeVnN8TSqMcbq
   Q==;
X-CSE-ConnectionGUID: W1amHBVDTCmlSRdIAINBIA==
X-CSE-MsgGUID: E4RBfRyKR5GuIcxu1YbxvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="59430931"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="59430931"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 21:10:38 -0700
X-CSE-ConnectionGUID: WYbSOqTWSLKQ1IymG4LRKA==
X-CSE-MsgGUID: MRGQydJyRjulqmuzQxGRmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="136662921"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 07 May 2025 21:10:37 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCsag-0009y0-1g;
	Thu, 08 May 2025 04:10:34 +0000
Date: Thu, 08 May 2025 12:09:54 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 d0706bfd3ee40923c001c6827b786a309e2a8713
Message-ID: <202505081249.vUuto5Xv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: d0706bfd3ee40923c001c6827b786a309e2a8713  RDMA/core: Fix "KASAN: slab-use-after-free Read in ib_register_device" problem

elapsed time: 2061m

configs tested: 79
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha               allnoconfig    gcc-14.2.0
alpha              allyesconfig    clang-19
alpha                 defconfig    gcc-14.2.0
arc                allmodconfig    clang-19
arc                 allnoconfig    gcc-14.2.0
arc                allyesconfig    clang-19
arc                   defconfig    gcc-14.2.0
arm                allmodconfig    clang-19
arm                 allnoconfig    clang-21
arm                 allnoconfig    gcc-14.2.0
arm                allyesconfig    clang-19
arm                   defconfig    gcc-14.2.0
arm64              allmodconfig    clang-19
arm64               allnoconfig    gcc-14.2.0
arm64                 defconfig    gcc-14.2.0
csky                allnoconfig    gcc-14.2.0
csky                  defconfig    gcc-14.2.0
hexagon            allmodconfig    clang-19
hexagon             allnoconfig    clang-21
hexagon             allnoconfig    gcc-14.2.0
hexagon            allyesconfig    clang-19
hexagon               defconfig    gcc-14.2.0
i386               allmodconfig    clang-20
i386                allnoconfig    clang-20
i386               allyesconfig    clang-20
i386                  defconfig    clang-20
loongarch          allmodconfig    gcc-14.2.0
loongarch           allnoconfig    gcc-14.2.0
loongarch             defconfig    gcc-14.2.0
m68k               allmodconfig    gcc-14.2.0
m68k                allnoconfig    gcc-14.2.0
m68k               allyesconfig    gcc-14.2.0
m68k                  defconfig    gcc-14.2.0
microblaze         allmodconfig    gcc-14.2.0
microblaze          allnoconfig    gcc-14.2.0
microblaze         allyesconfig    gcc-14.2.0
microblaze            defconfig    gcc-14.2.0
mips                allnoconfig    gcc-14.2.0
nios2               allnoconfig    gcc-14.2.0
nios2                 defconfig    gcc-14.2.0
openrisc            allnoconfig    clang-21
openrisc            allnoconfig    gcc-14.2.0
openrisc           allyesconfig    gcc-14.2.0
parisc             allmodconfig    gcc-14.2.0
parisc              allnoconfig    clang-21
parisc              allnoconfig    gcc-14.2.0
parisc             allyesconfig    gcc-14.2.0
parisc64              defconfig    gcc-14.2.0
powerpc            allmodconfig    gcc-14.2.0
powerpc             allnoconfig    clang-21
powerpc             allnoconfig    gcc-14.2.0
powerpc            allyesconfig    gcc-14.2.0
riscv              allmodconfig    gcc-14.2.0
riscv               allnoconfig    clang-21
riscv               allnoconfig    gcc-14.2.0
riscv              allyesconfig    gcc-14.2.0
s390               allmodconfig    clang-18
s390               allmodconfig    gcc-14.2.0
s390                allnoconfig    clang-21
s390               allyesconfig    gcc-14.2.0
sh                 allmodconfig    gcc-14.2.0
sh                  allnoconfig    gcc-14.2.0
sh                 allyesconfig    gcc-14.2.0
sparc              allmodconfig    gcc-14.2.0
sparc               allnoconfig    gcc-14.2.0
um                 allmodconfig    clang-19
um                  allnoconfig    clang-21
um                 allyesconfig    clang-19
x86_64              allnoconfig    clang-20
x86_64             allyesconfig    clang-20
x86_64                defconfig    clang-20
x86_64                    kexec    clang-20
x86_64                 rhel-9.4    clang-20
x86_64             rhel-9.4-bpf    clang-18
x86_64      rhel-9.4-kselftests    clang-20
x86_64           rhel-9.4-kunit    clang-18
x86_64             rhel-9.4-ltp    clang-18
x86_64            rhel-9.4-rust    clang-18
xtensa              allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

