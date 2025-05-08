Return-Path: <linux-rdma+bounces-10146-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2A8AAF2D0
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 07:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B5D4E1E4D
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 05:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAF3215041;
	Thu,  8 May 2025 05:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k2dmffBv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51F22147F5
	for <linux-rdma@vger.kernel.org>; Thu,  8 May 2025 05:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746681724; cv=none; b=mnf6kkDlLnM0TVsy4G2ZYh1kwEye1j9bHhEscjVe6T5749T0WgGJXkrs1xzU1jYv9PDwW9nymTPrFPP5ZhUuuYniVYDfTH0Csufdgl+aD9+Nj3agnYOGrzwc2oXfclnLC2hN7Ir9iChNauLdl3QxQzOAWQ7upukHUaH05TUaozQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746681724; c=relaxed/simple;
	bh=kQ9DIxPUHcVptmbM74QAEt1AwZ6FYCeWzzErAtnTc2w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sULMBLA1Ycl1Qq4dedUMkOHvPzdiAlT+yx7sSZCH3BGCnkR+vEgCXsemDVI6Yye40LfuibqhYgiGjmWB2F6IeWorIRluIcmVj9FcC3bcep1ERYhbmUcinEL0Qp0nz1bLWLRX53vR0aUm8rkQY4v984eumJcNdKZHhW+be/sYvuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k2dmffBv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746681723; x=1778217723;
  h=date:from:to:cc:subject:message-id;
  bh=kQ9DIxPUHcVptmbM74QAEt1AwZ6FYCeWzzErAtnTc2w=;
  b=k2dmffBvvrm0ZbNZ5VciaqQcV8ps/BM5/Qtx4St9FB0/brjkJqyV4Eiw
   J/PRvAcK9BxvTS2GLFGUagSzHvVDHpCgPV5jbcVHkpSUweDmY3hj8hLrw
   ACaZsLVK31ef5u3I0pCxgf+aRTIh7J1/KX4DBTC+r+Cm8qZR/rUoYE1lT
   ih8dgq2gTqe1L6rjlhk11tSS/BFBHBYO7WpMsnph6aaRgqQnzj3bkC2sP
   LQbyc+Ghr1yFP5ikxaTqIYeO9XBeq/guWjmhPQJy51k1D0jRChcY9+bji
   iwNXFsjbr7sAduhT1BGciCdAjSq3nWUHU/E+um6LPEIt3/CiTw0g+8+7V
   A==;
X-CSE-ConnectionGUID: kFEkw5IgSwW17NRHq9GBmA==
X-CSE-MsgGUID: juQezmalSJqoTSpdWsNsXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="52258930"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="52258930"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 22:22:02 -0700
X-CSE-ConnectionGUID: mT17MaSTQ7eaY5yZ2F9d4A==
X-CSE-MsgGUID: 5n32/XjPT82K9KWvxvUh2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="136193938"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 07 May 2025 22:22:01 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCthn-000AKJ-0n;
	Thu, 08 May 2025 05:21:59 +0000
Date: Thu, 08 May 2025 13:21:05 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 e56b4eab9cde7db525bf8dc57b489d157d5a201e
Message-ID: <202505081359.8byugIIc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: e56b4eab9cde7db525bf8dc57b489d157d5a201e  RDMA/siw: Remove unused siw_mem_add

elapsed time: 2132m

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

