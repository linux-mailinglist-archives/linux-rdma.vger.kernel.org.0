Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117384B9C1E
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Feb 2022 10:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiBQJhC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Feb 2022 04:37:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238736AbiBQJhB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Feb 2022 04:37:01 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5CFC4B46
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 01:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645090606; x=1676626606;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=QiY8oDqTpHSPbg9oHN0iW7Y579Wz4pOutDYknyQtQVg=;
  b=b277Lwf+pkBebTTgXEKPS3LtUBKsSz8Yy1mDcqzseja7RwJg0papa5RS
   mvT7WrrRK13zkEN49I5BZt5yySDFNRRAxxJHWimgDEpFkw0Ta8Yux0bjW
   p3s9H4/xSObmxr+DsxSwoJfjOnIShwHp5j55VIuH6FMt/MHEVAGxWTag1
   V7ziCVx8//04YBnc7/O6SytxtvKWakfMz6SD4VmIk3wYEvUIuQ6YkYZL7
   U/lN2WafERrmvf8P302odCKcCy9tbY/VQBK3xo+44xUqY5cHV6AO3wojP
   OyjPzGHEG3f2ypMC8G1UFY3QfnnIKWAd6O+yZVtPZ5994lQeN+QU2cm7i
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="231459815"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="231459815"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 01:36:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="545486613"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 17 Feb 2022 01:36:43 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKdDP-00001E-7j; Thu, 17 Feb 2022 09:36:43 +0000
Date:   Thu, 17 Feb 2022 17:36:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 3810c1a1cbe8f3157f644b4e42f6c0157dfd22cb
Message-ID: <620e170c.nWkPq1TXVuEx237N%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 3810c1a1cbe8f3157f644b4e42f6c0157dfd22cb  RDMA/rxe: Remove mcg from rxe pools

elapsed time: 868m

configs tested: 145
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
arm                        cerfcube_defconfig
arm                          exynos_defconfig
sh                            migor_defconfig
arc                          axs103_defconfig
arm                           u8500_defconfig
powerpc                     tqm8541_defconfig
xtensa                generic_kc705_defconfig
arc                      axs103_smp_defconfig
m68k                        m5307c3_defconfig
h8300                    h8300h-sim_defconfig
m68k                        stmark2_defconfig
powerpc                    amigaone_defconfig
sh                               alldefconfig
sh                          r7780mp_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                  iss476-smp_defconfig
m68k                          hp300_defconfig
openrisc                    or1ksim_defconfig
powerpc                   motionpro_defconfig
sparc                            allyesconfig
sh                             espt_defconfig
mips                         tb0226_defconfig
arm                            lart_defconfig
arm                        keystone_defconfig
powerpc                       ppc64_defconfig
nios2                            alldefconfig
nds32                             allnoconfig
xtensa                  audio_kc705_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                 canyonlands_defconfig
xtensa                  cadence_csp_defconfig
arc                          axs101_defconfig
sh                            shmin_defconfig
powerpc                    adder875_defconfig
s390                             allyesconfig
arm                       multi_v4t_defconfig
powerpc                 mpc837x_rdb_defconfig
ia64                         bigsur_defconfig
powerpc64                        alldefconfig
sh                          kfr2r09_defconfig
xtensa                           alldefconfig
openrisc                 simple_smp_defconfig
arm                  randconfig-c002-20220217
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220216
s390                 randconfig-r044-20220216
riscv                randconfig-r042-20220216
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
powerpc                   lite5200b_defconfig
arm                  colibri_pxa270_defconfig
arm                              alldefconfig
powerpc                  mpc866_ads_defconfig
mips                           ip27_defconfig
mips                     loongson1c_defconfig
arm                          ixp4xx_defconfig
arm                        neponset_defconfig
arm                     davinci_all_defconfig
mips                        workpad_defconfig
mips                     loongson2k_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                     mpc5200_defconfig
mips                           ip22_defconfig
powerpc                      obs600_defconfig
powerpc                     ppa8548_defconfig
arm                          imote2_defconfig
mips                          rm200_defconfig
riscv                            alldefconfig
arm                         shannon_defconfig
arm                        spear3xx_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
hexagon              randconfig-r045-20220216
hexagon              randconfig-r041-20220216
hexagon              randconfig-r045-20220217
hexagon              randconfig-r041-20220217
riscv                randconfig-r042-20220217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
