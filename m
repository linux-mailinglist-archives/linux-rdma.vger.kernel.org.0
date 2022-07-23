Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C58357EBB8
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Jul 2022 05:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiGWDkG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jul 2022 23:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiGWDkF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jul 2022 23:40:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE766EEBE
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jul 2022 20:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658547602; x=1690083602;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hThjfIapM9VnaPV0aIuq1ZvP0HVSLH5I5ukT/xjAdSY=;
  b=JYSrivE5VEJ9wouJYdy5/lAyGihH7hIu2WHZIczM2ydEej8pbbNgoeWy
   hpyRzKjrbxeJJgMKiV5bmDymcHuICEhFLAdCtWMDplRNVqMAIRcHVMZsx
   al/TpcmxlcnNcdSMjubBx9aYbp5iPPS+3lDGb4O+su55oYm6NYli/yIPz
   Y8FHG2BHx33ur0vBbMJtd+O/TgsKsMThSqaYIaTc52gWd8WhvU23328W5
   cDHKRbF1XxAv4AiHxpyrPGHr6Y0Iyt6ozvkjEb9mXEPb+scK4UiiolOgR
   L1QIzEy+zYt4ZdlTEB7LKrGGqO3biHM9ezWobD4ZNVPQZ56iaCYgbwQHH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="351436974"
X-IronPort-AV: E=Sophos;i="5.93,187,1654585200"; 
   d="scan'208";a="351436974"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 20:40:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,187,1654585200"; 
   d="scan'208";a="549380890"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Jul 2022 20:40:00 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oF5zj-0002Ck-39;
        Sat, 23 Jul 2022 03:39:59 +0000
Date:   Sat, 23 Jul 2022 11:39:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 1603f89935ec86d40a7667e1250392626976ccc2
Message-ID: <62db6d5e.C15KENMAhRDGAFUh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 1603f89935ec86d40a7667e1250392626976ccc2  RDMA/rxe: Fix mw bind to allow any consumer key portion

elapsed time: 2195m

configs tested: 180
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220722
arc                        nsim_700_defconfig
sparc                       sparc64_defconfig
s390                             allmodconfig
m68k                       bvme6000_defconfig
sh                               j2_defconfig
arc                          axs101_defconfig
alpha                               defconfig
mips                         cobalt_defconfig
arm                      jornada720_defconfig
m68k                          atari_defconfig
sh                          r7785rp_defconfig
m68k                                defconfig
powerpc                 mpc834x_itx_defconfig
sh                              ul2_defconfig
powerpc                        cell_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                           xway_defconfig
mips                          rb532_defconfig
powerpc                 mpc834x_mds_defconfig
arm                           u8500_defconfig
sh                             shx3_defconfig
xtensa                           allyesconfig
arc                        vdk_hs38_defconfig
powerpc                       maple_defconfig
arm                          simpad_defconfig
sparc                       sparc32_defconfig
sh                  sh7785lcr_32bit_defconfig
parisc                generic-64bit_defconfig
powerpc                      makalu_defconfig
parisc                              defconfig
arc                      axs103_smp_defconfig
m68k                        m5407c3_defconfig
mips                           jazz_defconfig
powerpc                 mpc8540_ads_defconfig
openrisc                 simple_smp_defconfig
nios2                         3c120_defconfig
sh                        apsh4ad0a_defconfig
powerpc                     pq2fads_defconfig
alpha                            alldefconfig
openrisc                            defconfig
m68k                        mvme147_defconfig
mips                     loongson1b_defconfig
arm                         at91_dt_defconfig
s390                          debug_defconfig
sh                             sh03_defconfig
xtensa                           alldefconfig
arm                           corgi_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                       ppc64_defconfig
csky                                defconfig
arm                          gemini_defconfig
nios2                         10m50_defconfig
sh                               alldefconfig
powerpc                     tqm8555_defconfig
arm                        mini2440_defconfig
arm                            hisi_defconfig
sh                             espt_defconfig
arm                             pxa_defconfig
powerpc                      tqm8xx_defconfig
mips                           gcw0_defconfig
arm                        oxnas_v6_defconfig
powerpc                    amigaone_defconfig
arm                     eseries_pxa_defconfig
sh                        edosk7760_defconfig
sh                          rsk7203_defconfig
powerpc                      mgcoge_defconfig
sh                           se7751_defconfig
parisc64                         alldefconfig
powerpc                   currituck_defconfig
mips                      maltasmvp_defconfig
sh                           se7724_defconfig
sparc64                             defconfig
mips                           ci20_defconfig
sparc                               defconfig
sparc                            allyesconfig
x86_64                                  kexec
s390                                defconfig
arc                                 defconfig
s390                             allyesconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc64                            defconfig
parisc                           allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                              debian-10.3
loongarch                           defconfig
loongarch                         allnoconfig
arm                  randconfig-c002-20220721
x86_64                        randconfig-c001
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220721
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm

clang tested configs:
mips                malta_qemu_32r6_defconfig
mips                  cavium_octeon_defconfig
powerpc                     tqm8540_defconfig
arm                         s3c2410_defconfig
arm                      pxa255-idp_defconfig
mips                      maltaaprp_defconfig
arm                          ixp4xx_defconfig
powerpc                  mpc866_ads_defconfig
mips                          ath79_defconfig
powerpc                          allyesconfig
powerpc                     akebono_defconfig
powerpc                    mvme5100_defconfig
mips                      malta_kvm_defconfig
arm                                 defconfig
arm                           spitz_defconfig
arm                          pxa168_defconfig
i386                             allyesconfig
arm                       mainstone_defconfig
mips                        bcm63xx_defconfig
powerpc                     ksi8560_defconfig
mips                      pic32mzda_defconfig
mips                           mtx1_defconfig
powerpc                 mpc836x_mds_defconfig
arm                      tct_hammer_defconfig
mips                        qi_lb60_defconfig
arm                       versatile_defconfig
powerpc                      ppc44x_defconfig
arm                       spear13xx_defconfig
mips                     loongson1c_defconfig
x86_64                           allyesconfig
arm                         hackkit_defconfig
arm                  colibri_pxa300_defconfig
mips                         tb0287_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220721
s390                 randconfig-r044-20220721
hexagon              randconfig-r045-20220721
riscv                randconfig-r042-20220721
hexagon              randconfig-r041-20220722
hexagon              randconfig-r045-20220722

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
