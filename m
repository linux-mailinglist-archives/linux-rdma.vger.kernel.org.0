Return-Path: <linux-rdma+bounces-3150-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C416909246
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2024 20:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD9A28775C
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2024 18:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D11819DF7C;
	Fri, 14 Jun 2024 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bmux3C2+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DCF179BC
	for <linux-rdma@vger.kernel.org>; Fri, 14 Jun 2024 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718389699; cv=none; b=p94MsH4F7OYL4gyhxkwxFbzY3oNFC2lQb8o9EEuIAyKGq+oVwBRLg4jGY8K0kql321tT0CEU9OjVI//oW8sStL1ah13XnVFM9jre52VTWDIkutFjyYWG7uhK7I1wATxUiEV6c72p56jERrxhhAAoa82bZscbgJ5NGzJsgtfWHVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718389699; c=relaxed/simple;
	bh=1uijl8ROgK5Br1k70COsZNo55ACHob1qS3SGc/8G27Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qUKlSr2HOlHSSsDvAj3g8NJZLB/kLgo+XFyLsQ6wZ010ehSOn3IobwvhZfsq6Y+f7hb5R2Sns+dzcZKGKQwDoxHoRwrsxnH/VSrjFpqKkaqkQDuBBZIz137gl7D1APx1kzFIVwWOV3XSYWvyrKYIc9PSD/D3UgTrU3iN6qRsPuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bmux3C2+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718389698; x=1749925698;
  h=date:from:to:cc:subject:message-id;
  bh=1uijl8ROgK5Br1k70COsZNo55ACHob1qS3SGc/8G27Q=;
  b=bmux3C2+1T9v6C3zUoS5LCEmAnfP0uMxg/+A8epehUWZuweqxNiZTUf1
   PRwSixfsx2IY9yp4NApZkXXHtmnExu9Z5NkyjRzInpzBnig33unr8Tk6b
   YLaes+npfF/id01m1ZXf8oSv9Fj6hrk/4aNduoY1bHT+1b0U0ZqJypW08
   Zh5Qf6ZXQpQwYYQscArPSpQj1MXOH4T2nTRJWXtGCRHoWBG05+oNzK25d
   z0m7vXRFMPmAW8DMVFSXF2xrcmkjO0z7O+kKlNyfwj/MmSo9X0u2/If21
   lfiQR0aIk1TTIDrs/60oDVwky6+R5oYTJYTs/jK3dLYoDY4FrrlVXHrE/
   A==;
X-CSE-ConnectionGUID: VYJwk/NESyKeSTj/FJ0kKQ==
X-CSE-MsgGUID: SOBacLbjRriwxzX/qUEIPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="40706277"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="40706277"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 11:28:16 -0700
X-CSE-ConnectionGUID: 0/24SbKwSv+Z9dOVZrQACw==
X-CSE-MsgGUID: u0MJCeFQQc65EX24WTpllg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="45497139"
Received: from lkp-server01.sh.intel.com (HELO 9e3ee4e9e062) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 14 Jun 2024 11:28:16 -0700
Received: from kbuild by 9e3ee4e9e062 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sIBem-0001dn-3D;
	Fri, 14 Jun 2024 18:28:12 +0000
Date: Sat, 15 Jun 2024 02:28:09 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:mana-shared] BUILD SUCCESS
 7fc45cb68696c7213c484ec81892bc8a986fde52
Message-ID: <202406150206.FHpbKdO3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git mana-shared
branch HEAD: 7fc45cb68696c7213c484ec81892bc8a986fde52  net: mana: Allow variable size indirection table

elapsed time: 2882m

configs tested: 83
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-13.2.0
arm                                 defconfig   clang-14
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                             allmodconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                             allyesconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon                             defconfig   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386                                defconfig   clang-18
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                             allyesconfig   gcc-13.2.0
nios2                            allmodconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                            allyesconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   clang-19
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                          allmodconfig   gcc-13.2.0
sparc64                          allyesconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

