Return-Path: <linux-rdma+bounces-5042-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E57E97E582
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2024 06:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3801C20FF9
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2024 04:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB867489;
	Mon, 23 Sep 2024 04:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0vv2Dbu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C681C3D
	for <linux-rdma@vger.kernel.org>; Mon, 23 Sep 2024 04:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727067098; cv=none; b=EYcrGjscZEWXQyAJ8rL7Ho7iXguMBqHtxCE4A1Lpb32jBw7TW1+dayVIVnhd3xDuWp0sR+2zQYwmvREVYScx9i2ithEBZLN5M94u4ZlvbDbpY1pYLi54/+v1cn6iLiqgu5guyE6fj1D+i4dAp5vjLK8M0TAZ+9B9Z7R0TkItpQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727067098; c=relaxed/simple;
	bh=MSQmGyetcDbJSUXcukUR8V4CMwXIPd+KnPcegSzh60I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sBrzo+ZvYFrGPJ0qzefYzmOkJVf+MvuUktc0Pyw4X76v7DNdrYM9Cxvf9NaqwtTRMrJau7RDfacqL91l6MdV5Txg3ipaiobHw51BIjI36LT8eZnE+GclmbEKkPnKVr6FRrXLJpoEbh+MB/37VOCiVuSpAI5ZL2mFJyAP/u+lVq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0vv2Dbu; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727067097; x=1758603097;
  h=date:from:to:cc:subject:message-id;
  bh=MSQmGyetcDbJSUXcukUR8V4CMwXIPd+KnPcegSzh60I=;
  b=d0vv2DbutXExlVp7Bo4KYV56woCDoc6I5Ps2j/ZzYTVjmdaflPVXpvfA
   E91KhqqHuZ5b7GCfy2PxX6w/1kt+k3ICmgzwo/gfd6RJVKIBBnvfyB4+5
   4OILyng5up6ukAJiw+P8U3TOk7/89q75OCLY44hpfhZDs5kP28JZLoCe1
   xainQRUxYyTyqJT+clP2Y6Aod4pnw4Vq9GCaW0b1BkPGuysh7r1Wo8CCw
   a2L9Or6TKeplktAgdNRyUqDeNRZ5du/ez88LDCFYWJPEhCB1dA4X+WLhj
   niY/vHnfI2Q23QEAvAEM2TLHoPphytA9Q62tpvV8V2JPoGCMCw2tCdfPl
   w==;
X-CSE-ConnectionGUID: 0enzNWozQHGVdUKPi8w85A==
X-CSE-MsgGUID: HeicdS5zQ6C/jjvKnm8WjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="26188572"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="26188572"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 21:51:36 -0700
X-CSE-ConnectionGUID: tm+/fm6bSvOx53RTAgNtSQ==
X-CSE-MsgGUID: dyoXkRzdQs2WmHrC4D3OeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="75499930"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 22 Sep 2024 21:51:34 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssb2q-000GuU-1Q;
	Mon, 23 Sep 2024 04:51:32 +0000
Date: Mon, 23 Sep 2024 12:50:50 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 70920941923316b760bc7a804eb3d49a126d8712
Message-ID: <202409231237.QkVV3dGT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 70920941923316b760bc7a804eb3d49a126d8712  RDMA/bnxt_re: Remove the unused variable en_dev

elapsed time: 888m

configs tested: 142
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                         at91_dt_defconfig    gcc-14.1.0
arm                                 defconfig    gcc-14.1.0
arm                            dove_defconfig    gcc-14.1.0
arm                        mvebu_v7_defconfig    gcc-14.1.0
arm                        spear3xx_defconfig    gcc-14.1.0
arm                         vf610m4_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240923    clang-18
i386        buildonly-randconfig-001-20240923    gcc-11
i386        buildonly-randconfig-002-20240923    clang-18
i386        buildonly-randconfig-002-20240923    gcc-11
i386        buildonly-randconfig-003-20240923    gcc-11
i386        buildonly-randconfig-003-20240923    gcc-12
i386        buildonly-randconfig-004-20240923    clang-18
i386        buildonly-randconfig-004-20240923    gcc-11
i386        buildonly-randconfig-005-20240923    gcc-11
i386        buildonly-randconfig-005-20240923    gcc-12
i386        buildonly-randconfig-006-20240923    clang-18
i386        buildonly-randconfig-006-20240923    gcc-11
i386                                defconfig    clang-18
i386                  randconfig-001-20240923    clang-18
i386                  randconfig-001-20240923    gcc-11
i386                  randconfig-002-20240923    clang-18
i386                  randconfig-002-20240923    gcc-11
i386                  randconfig-003-20240923    clang-18
i386                  randconfig-003-20240923    gcc-11
i386                  randconfig-004-20240923    gcc-11
i386                  randconfig-004-20240923    gcc-12
i386                  randconfig-005-20240923    gcc-11
i386                  randconfig-006-20240923    clang-18
i386                  randconfig-006-20240923    gcc-11
i386                  randconfig-011-20240923    clang-18
i386                  randconfig-011-20240923    gcc-11
i386                  randconfig-012-20240923    gcc-11
i386                  randconfig-012-20240923    gcc-12
i386                  randconfig-013-20240923    gcc-11
i386                  randconfig-013-20240923    gcc-12
i386                  randconfig-014-20240923    gcc-11
i386                  randconfig-014-20240923    gcc-12
i386                  randconfig-015-20240923    gcc-11
i386                  randconfig-015-20240923    gcc-12
i386                  randconfig-016-20240923    gcc-11
i386                  randconfig-016-20240923    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                           ip30_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                   currituck_defconfig    gcc-14.1.0
powerpc                   microwatt_defconfig    gcc-14.1.0
powerpc                 mpc836x_rdk_defconfig    gcc-14.1.0
powerpc                     skiroot_defconfig    gcc-14.1.0
powerpc64                        alldefconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                        edosk7705_defconfig    gcc-14.1.0
sh                        sh7763rdp_defconfig    gcc-14.1.0
sh                            shmin_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc                       sparc64_defconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                             i386_defconfig    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-18
x86_64                         rhel-8.3-kunit    clang-18
x86_64                           rhel-8.3-ltp    clang-18
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

