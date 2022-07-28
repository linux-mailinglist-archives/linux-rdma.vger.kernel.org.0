Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F0E58433D
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jul 2022 17:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiG1Pla (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jul 2022 11:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiG1Pl3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jul 2022 11:41:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ADD1CB03
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jul 2022 08:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659022889; x=1690558889;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6ymGtolwxHlz8EpS/F6HkWig1pdg9PWjAJI89jA0Ko0=;
  b=EceouVk6y4+giy/6MYd+nQwZAup+UdmMzqidEF2L/4kdmlgY92KTbffA
   HH7wqWptTzQgB4fOyurNSrpG0qfgCebEG2qZMVUIC4lniFJaQiPHSnhGu
   sPssdyvYIU5SRozRq6aymRA9P1j7x4jdgyvENiXZYzDZrlbaao1Z01TmR
   UY8wAh3TM3qFgDihctlK4pleDh+uh4/Maf/1u1bIDMjhf+5cGsUJEr46c
   cUSWNcybG+Nx/ojsW1zZvD+aGKGHy9UWfLu9QpN+GHG/ofXlsW7Zdl8ZB
   wQ53ucjBbBSg9ZUO8xYxpEWdF3NWONgzejaRt0TDA678Ie777+Yd1dt9n
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="374846092"
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="374846092"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 08:41:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="668885578"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jul 2022 08:41:27 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oH5de-000AJA-16;
        Thu, 28 Jul 2022 15:41:26 +0000
Date:   Thu, 28 Jul 2022 23:40:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 c1885d3f17a4147d27ed53963f57c62535aedc1f
Message-ID: <62e2adf4.n4TdzlBs+6AYAU+z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: c1885d3f17a4147d27ed53963f57c62535aedc1f  Revert "RDMA/rxe: Create duplicate mapping tables for FMRs"

elapsed time: 1785m

configs tested: 185
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                             allyesconfig
i386                                defconfig
nios2                         3c120_defconfig
arm                           viper_defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
sparc64                             defconfig
sh                            shmin_defconfig
arc                     haps_hs_smp_defconfig
powerpc                     asp8347_defconfig
powerpc                    amigaone_defconfig
arm                           tegra_defconfig
parisc                generic-64bit_defconfig
openrisc                         alldefconfig
i386                          randconfig-c001
sh                          rsk7269_defconfig
sh                           sh2007_defconfig
openrisc                            defconfig
loongarch                           defconfig
loongarch                         allnoconfig
sh                          landisk_defconfig
sh                           se7343_defconfig
m68k                            q40_defconfig
sh                            titan_defconfig
m68k                          sun3x_defconfig
mips                      fuloong2e_defconfig
sh                           se7712_defconfig
m68k                         amcore_defconfig
sparc                       sparc32_defconfig
powerpc                      mgcoge_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                     decstation_defconfig
xtensa                  cadence_csp_defconfig
arc                                 defconfig
powerpc                      pasemi_defconfig
m68k                                defconfig
sh                      rts7751r2d1_defconfig
arc                        vdk_hs38_defconfig
mips                            ar7_defconfig
m68k                        stmark2_defconfig
sh                          lboxre2_defconfig
loongarch                 loongson3_defconfig
sh                          urquell_defconfig
arm                            lart_defconfig
powerpc                     sequoia_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arc                              alldefconfig
powerpc                        cell_defconfig
mips                           gcw0_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
s390                                defconfig
s390                             allmodconfig
alpha                               defconfig
s390                             allyesconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220727
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
sh                        sh7763rdp_defconfig
powerpc                         wii_defconfig
sh                ecovec24-romimage_defconfig
powerpc                      makalu_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                         ps3_defconfig
arm                        mvebu_v7_defconfig
arm                         vf610m4_defconfig
xtensa                       common_defconfig
sparc                       sparc64_defconfig
arm                           sama5_defconfig
arm                            qcom_defconfig
arm                            hisi_defconfig
m68k                        m5272c3_defconfig
sh                          rsk7264_defconfig
mips                  decstation_64_defconfig
arm                         assabet_defconfig
sh                         ecovec24_defconfig
powerpc                 mpc8540_ads_defconfig
sh                   sh7770_generic_defconfig
m68k                          amiga_defconfig
arm                         cm_x300_defconfig
ia64                                defconfig
xtensa                    smp_lx200_defconfig
parisc64                            defconfig
csky                             alldefconfig
mips                 randconfig-c004-20220728
powerpc              randconfig-c003-20220728
s390                 randconfig-r044-20220728
riscv                randconfig-r042-20220728
arc                  randconfig-r043-20220728
arm                           u8500_defconfig
powerpc                 linkstation_defconfig
powerpc                     taishan_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc                           allyesconfig
ia64                        generic_defconfig
arc                            hsdk_defconfig

clang tested configs:
hexagon              randconfig-r041-20220727
hexagon              randconfig-r045-20220727
s390                 randconfig-r044-20220727
riscv                randconfig-r042-20220727
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
arm                         bcm2835_defconfig
powerpc                        icon_defconfig
powerpc               mpc834x_itxgp_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
powerpc                 mpc8315_rdb_defconfig
powerpc                 mpc832x_mds_defconfig
mips                           ip27_defconfig
arm                          ixp4xx_defconfig
x86_64                        randconfig-k001
riscv                    nommu_virt_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                        neponset_defconfig
powerpc                        fsp2_defconfig
powerpc                  mpc885_ads_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
mips                     decstation_defconfig
powerpc                      pasemi_defconfig
arm                             mxs_defconfig
powerpc                     tqm5200_defconfig
arm                         s5pv210_defconfig
hexagon              randconfig-r041-20220728
hexagon              randconfig-r045-20220728
powerpc                    mvme5100_defconfig
powerpc                      pmac32_defconfig
arm                        spear3xx_defconfig
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
mips                      pic32mzda_defconfig
hexagon                             defconfig
arm                     davinci_all_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                    gamecube_defconfig
arm                          collie_defconfig
mips                 randconfig-c004-20220728
x86_64                        randconfig-c007
s390                 randconfig-c005-20220728
powerpc              randconfig-c003-20220728
i386                          randconfig-c001
riscv                randconfig-c006-20220728
arm                  randconfig-c002-20220728

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
