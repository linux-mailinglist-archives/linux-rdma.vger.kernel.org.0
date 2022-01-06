Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F044866E1
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 16:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240570AbiAFPo0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jan 2022 10:44:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:5764 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229726AbiAFPoZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 Jan 2022 10:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641483865; x=1673019865;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=9fR4FIpDCSdWgxzJHLL+VMKsS2rKs0/AVyzEx44W4EQ=;
  b=alas8w4kjc20+0dLxfKUNY9TWZirk+FkI3XQye6gApitdxr36IRa4/Cp
   FNJ65C6OnIoYm1TYjIHx1cftLxgjufihYo+GobUCHx5zGI7Tp/CPtLLZH
   ZyW0LRXqeTNkp+O/aDN0KuapeMuUfwH8guIzTs8Mp3sAOaspakuMGg1IH
   +gS/A6EHDzH4QnIjvtldaO1GzLwSKXEsG+t9u7zvB3aXGABQzRAKAUFRQ
   mukO3Z290Jq1qGnqU6NIibgnAjqOWg9dEbXu+YJtTIKv2TCWTKTJuj0Ze
   z8mi1IBwMIkyAj9YvboglPtsuarxZiIDZajQMZi7P/goXos5TbCjhqSZx
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242632603"
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="242632603"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 07:44:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="513448642"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 06 Jan 2022 07:44:23 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5UwB-000Hkq-3U; Thu, 06 Jan 2022 15:44:23 +0000
Date:   Thu, 06 Jan 2022 23:43:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 954e136d5d1af8294f4805630b155e2a29f4119d
Message-ID: <61d70e37.E/cl5GqpLx2s8PBj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 954e136d5d1af8294f4805630b155e2a29f4119d  IB/iser: Align coding style across driver

elapsed time: 724m

configs tested: 117
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220106
s390                       zfcpdump_defconfig
um                           x86_64_defconfig
arm                            lart_defconfig
sparc                            alldefconfig
sh                        apsh4ad0a_defconfig
arc                          axs103_defconfig
ia64                        generic_defconfig
sh                              ul2_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     tqm8541_defconfig
nios2                            alldefconfig
arm                            qcom_defconfig
sh                             espt_defconfig
xtensa                          iss_defconfig
powerpc                      ppc40x_defconfig
sh                               alldefconfig
sparc                               defconfig
mips                       capcella_defconfig
m68k                       bvme6000_defconfig
openrisc                    or1ksim_defconfig
powerpc                     redwood_defconfig
arc                     haps_hs_smp_defconfig
sh                          r7785rp_defconfig
parisc                generic-64bit_defconfig
arc                    vdk_hs38_smp_defconfig
arm                          pxa3xx_defconfig
powerpc                     mpc83xx_defconfig
sh                     sh7710voipgw_defconfig
sh                   secureedge5410_defconfig
arm                        realview_defconfig
arm                  randconfig-c002-20220106
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a012-20220106
x86_64               randconfig-a015-20220106
x86_64               randconfig-a014-20220106
x86_64               randconfig-a013-20220106
x86_64               randconfig-a011-20220106
x86_64               randconfig-a016-20220106
i386                 randconfig-a012-20220106
i386                 randconfig-a016-20220106
i386                 randconfig-a014-20220106
i386                 randconfig-a015-20220106
i386                 randconfig-a011-20220106
i386                 randconfig-a013-20220106
s390                 randconfig-r044-20220106
arc                  randconfig-r043-20220106
riscv                randconfig-r042-20220106
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
mips                 randconfig-c004-20220106
arm                  randconfig-c002-20220106
i386                 randconfig-c001-20220106
riscv                randconfig-c006-20220106
powerpc              randconfig-c003-20220106
x86_64               randconfig-c007-20220106
arm                          collie_defconfig
powerpc                      ppc44x_defconfig
i386                 randconfig-a003-20220106
i386                 randconfig-a005-20220106
i386                 randconfig-a004-20220106
i386                 randconfig-a006-20220106
i386                 randconfig-a002-20220106
i386                 randconfig-a001-20220106
x86_64               randconfig-a005-20220106
x86_64               randconfig-a001-20220106
x86_64               randconfig-a004-20220106
x86_64               randconfig-a006-20220106
x86_64               randconfig-a002-20220106
x86_64               randconfig-a003-20220106

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
