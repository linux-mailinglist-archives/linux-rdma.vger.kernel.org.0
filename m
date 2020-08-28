Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5930F2553D7
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Aug 2020 06:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgH1Emp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Aug 2020 00:42:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:27192 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgH1Emo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Aug 2020 00:42:44 -0400
IronPort-SDR: L3DN4tLfDyBrJ18Nbu+6Zhska46jlpuK09OhmDg6P/mRm4HrwxZmaAbyB3ix3gTzAqtdN3HshY
 A4Gzmg503Mfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="220855625"
X-IronPort-AV: E=Sophos;i="5.76,362,1592895600"; 
   d="scan'208";a="220855625"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 21:42:42 -0700
IronPort-SDR: Rxv+0XCIUSOjQeJWRofdom6H+npveXAMGOpqUjr3wAO0lROQr5IRFPYfwP6oahDXOdThSqrPT5
 9cZWcxOI5pXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,362,1592895600"; 
   d="scan'208";a="300097481"
Received: from lkp-server01.sh.intel.com (HELO 4f455964fc6c) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Aug 2020 21:42:41 -0700
Received: from kbuild by 4f455964fc6c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kBWDo-0002Uk-GU; Fri, 28 Aug 2020 04:42:40 +0000
Date:   Fri, 28 Aug 2020 12:42:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 5f9e2822d12fe5050da5db0e65924d5ddc86bf29
Message-ID: <5f488b1b.vdNZq4bjKJiLqWIv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 5f9e2822d12fe5050da5db0e65924d5ddc86bf29  RDMA/rxe: Fix style warnings

elapsed time: 721m

configs tested: 131
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                ecovec24-romimage_defconfig
arm                      pxa255-idp_defconfig
mips                           ip32_defconfig
sh                           se7721_defconfig
sparc                               defconfig
sh                           se7343_defconfig
mips                      loongson3_defconfig
mips                        vocore2_defconfig
sh                            shmin_defconfig
arm                         s3c2410_defconfig
m68k                        m5272c3_defconfig
sh                            migor_defconfig
arm                        multi_v7_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                      ep88xc_defconfig
powerpc                      pmac32_defconfig
arm                            zeus_defconfig
arm                       aspeed_g4_defconfig
mips                           xway_defconfig
mips                     loongson1c_defconfig
mips                            gpr_defconfig
sparc64                          alldefconfig
powerpc                mpc7448_hpc2_defconfig
arm                          pxa168_defconfig
ia64                             allmodconfig
sh                        sh7763rdp_defconfig
arm                         orion5x_defconfig
arc                            hsdk_defconfig
powerpc                     pseries_defconfig
arm                    vt8500_v6_v7_defconfig
sh                             sh03_defconfig
arm                         mv78xx0_defconfig
arc                              allyesconfig
arm                       mainstone_defconfig
m68k                             allmodconfig
c6x                         dsk6455_defconfig
powerpc                     powernv_defconfig
mips                          rb532_defconfig
ia64                         bigsur_defconfig
arm                        multi_v5_defconfig
sh                         ecovec24_defconfig
c6x                        evmc6678_defconfig
arc                    vdk_hs38_smp_defconfig
sh                        apsh4ad0a_defconfig
powerpc                      pasemi_defconfig
sh                           se7712_defconfig
arm                           omap1_defconfig
arm                         at91_dt_defconfig
sh                          kfr2r09_defconfig
arm                          pcm027_defconfig
powerpc                      ppc6xx_defconfig
nds32                            alldefconfig
arm                         lpc32xx_defconfig
riscv                               defconfig
arm                         bcm2835_defconfig
mips                     loongson1b_defconfig
mips                            ar7_defconfig
alpha                               defconfig
arm                          exynos_defconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20200827
x86_64               randconfig-a002-20200827
x86_64               randconfig-a001-20200827
x86_64               randconfig-a005-20200827
x86_64               randconfig-a006-20200827
x86_64               randconfig-a004-20200827
i386                 randconfig-a002-20200827
i386                 randconfig-a004-20200827
i386                 randconfig-a003-20200827
i386                 randconfig-a005-20200827
i386                 randconfig-a006-20200827
i386                 randconfig-a001-20200827
i386                 randconfig-a002-20200828
i386                 randconfig-a005-20200828
i386                 randconfig-a003-20200828
i386                 randconfig-a004-20200828
i386                 randconfig-a001-20200828
i386                 randconfig-a006-20200828
i386                 randconfig-a013-20200827
i386                 randconfig-a012-20200827
i386                 randconfig-a011-20200827
i386                 randconfig-a016-20200827
i386                 randconfig-a015-20200827
i386                 randconfig-a014-20200827
i386                 randconfig-a013-20200828
i386                 randconfig-a012-20200828
i386                 randconfig-a011-20200828
i386                 randconfig-a016-20200828
i386                 randconfig-a014-20200828
i386                 randconfig-a015-20200828
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
