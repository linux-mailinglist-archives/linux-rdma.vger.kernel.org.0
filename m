Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72679606F4D
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 07:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiJUFQf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 01:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJUFQe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 01:16:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A491863FC
        for <linux-rdma@vger.kernel.org>; Thu, 20 Oct 2022 22:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666329392; x=1697865392;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=VL16Ul6sNpl81c6uI+fn5AJKAW/BEr5Og673ozZf1/g=;
  b=LU2ymLaXlzIDasUd0ibUUxEouVSUuny3wZ4uoTo4tx1oEtYpELj1xMa9
   K68mpNB5/8sFfj5W7CJg7XWOWoXr/moTySYAw2zZy6PN9zj65WFxFox5z
   ItHEZQvNaFW1Qj9xg3F0QD+SXltlagq3uGb2iXITeEO3eewbhYBS+45Ma
   ukRixGP9ElduxRm9cW/xZAv5uFRFF0KLVZG+Tqk8ELVfd6dgRsDmwmYEg
   1aWw9XfKNYk3JMp+GbiXxz6cKYDp4BKjOmdHxFGN0K247XMRxjuv2Dmrs
   hvFvZrmHSR5hHx3Pk6DO3pVhm1USioyMr5L4cSH4B88OenX/rD6Zo9N7a
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="371128049"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="371128049"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 22:16:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="608155156"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="608155156"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2022 22:16:30 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1olkOT-0002FK-3B;
        Fri, 21 Oct 2022 05:16:29 +0000
Date:   Fri, 21 Oct 2022 13:16:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 c1842f34fceef47d6285e558004f8e2d6ed91b91
Message-ID: <63522b1d.8PiQZWfJaL3GfnT6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: c1842f34fceef47d6285e558004f8e2d6ed91b91  IB/iser: open code iser_disconnected_handler

elapsed time: 2735m

configs tested: 242
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
sh                             shx3_defconfig
sh                          polaris_defconfig
mips                         cobalt_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                             allyesconfig
i386                                defconfig
arc                  randconfig-r043-20221018
s390                 randconfig-r044-20221018
riscv                randconfig-r042-20221018
sh                        sh7763rdp_defconfig
sh                          sdk7780_defconfig
powerpc                    klondike_defconfig
sparc                             allnoconfig
arc                           tb10x_defconfig
m68k                        mvme16x_defconfig
arc                         haps_hs_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
sh                            shmin_defconfig
sh                         apsh4a3a_defconfig
arm                        cerfcube_defconfig
mips                           jazz_defconfig
powerpc                        warp_defconfig
sh                               j2_defconfig
m68k                        m5272c3_defconfig
arm                         cm_x300_defconfig
sh                          kfr2r09_defconfig
sh                             sh03_defconfig
sh                          r7785rp_defconfig
sh                             espt_defconfig
arm                          iop32x_defconfig
sh                            hp6xx_defconfig
loongarch                         allnoconfig
arm                             pxa_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                           se7712_defconfig
i386                          randconfig-c001
arm                          pxa3xx_defconfig
sh                   sh7770_generic_defconfig
m68k                                defconfig
sh                          urquell_defconfig
arc                  randconfig-r043-20221019
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                      integrator_defconfig
powerpc                      ppc6xx_defconfig
powerpc                 mpc834x_mds_defconfig
arm64                            alldefconfig
sh                        sh7757lcr_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
xtensa                  audio_kc705_defconfig
arm                          simpad_defconfig
sh                           se7206_defconfig
powerpc                 mpc834x_itx_defconfig
ia64                          tiger_defconfig
m68k                       m5475evb_defconfig
xtensa                              defconfig
powerpc                       maple_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20221019
m68k                          sun3x_defconfig
openrisc                       virt_defconfig
m68k                           virt_defconfig
xtensa                          iss_defconfig
arc                        vdk_hs38_defconfig
arm                         assabet_defconfig
openrisc                            defconfig
nios2                            alldefconfig
sh                   rts7751r2dplus_defconfig
powerpc                   currituck_defconfig
arm                           stm32_defconfig
openrisc                  or1klitex_defconfig
mips                           gcw0_defconfig
arm                        keystone_defconfig
ia64                                defconfig
arm                        clps711x_defconfig
xtensa                           alldefconfig
csky                              allnoconfig
arm                          exynos_defconfig
nios2                               defconfig
arc                          axs101_defconfig
powerpc                   motionpro_defconfig
powerpc                     mpc83xx_defconfig
sh                          rsk7269_defconfig
s390                          debug_defconfig
sh                     sh7710voipgw_defconfig
loongarch                           defconfig
loongarch                        allmodconfig
arm                         s3c6400_defconfig
powerpc                     tqm8555_defconfig
csky                                defconfig
xtensa                         virt_defconfig
powerpc                     sequoia_defconfig
arm                           h3600_defconfig
sparc64                          alldefconfig
m68k                       bvme6000_defconfig
sh                        dreamcast_defconfig
mips                           ip32_defconfig
sh                            titan_defconfig
arm                       aspeed_g5_defconfig
m68k                          amiga_defconfig
arc                               allnoconfig
nios2                            allyesconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arm                  randconfig-c002-20221020
sparc                               defconfig
xtensa                           allyesconfig
sparc                            allyesconfig
x86_64                                  kexec
arc                  randconfig-r043-20221020
s390                 randconfig-r044-20221020
riscv                randconfig-r042-20221020
sparc                       sparc32_defconfig
arc                        nsimosci_defconfig
sh                           se7619_defconfig
mips                 randconfig-c004-20221020
ia64                         bigsur_defconfig
m68k                        stmark2_defconfig
powerpc                      cm5200_defconfig
sh                ecovec24-romimage_defconfig
arm                      footbridge_defconfig
sh                     magicpanelr2_defconfig
arm                          gemini_defconfig
mips                  maltasmvp_eva_defconfig
um                               alldefconfig
powerpc                  iss476-smp_defconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
openrisc                         alldefconfig
powerpc                       holly_defconfig
m68k                         apollo_defconfig
arm                        oxnas_v6_defconfig
m68k                            q40_defconfig
powerpc                     tqm8541_defconfig
powerpc                      chrp32_defconfig
sparc                            alldefconfig
arm                          badge4_defconfig
sh                           se7750_defconfig
sh                           se7343_defconfig
nios2                         10m50_defconfig
mips                           ci20_defconfig
m68k                        mvme147_defconfig
mips                       bmips_be_defconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017
mips                           mtx1_defconfig
s390                 randconfig-r044-20221019
hexagon              randconfig-r045-20221019
riscv                randconfig-r042-20221019
hexagon              randconfig-r041-20221019
powerpc                 mpc8272_ads_defconfig
powerpc                 mpc8560_ads_defconfig
x86_64                        randconfig-c007
mips                 randconfig-c004-20221019
i386                          randconfig-c001
s390                 randconfig-c005-20221019
arm                  randconfig-c002-20221019
riscv                randconfig-c006-20221019
powerpc              randconfig-c003-20221019
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20221018
hexagon              randconfig-r041-20221018
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-k001
hexagon                             defconfig
powerpc                     tqm8540_defconfig
powerpc                      pmac32_defconfig
powerpc                     ksi8560_defconfig
powerpc               mpc834x_itxgp_defconfig
hexagon              randconfig-r041-20221020
hexagon              randconfig-r045-20221020
arm                       mainstone_defconfig
powerpc                      obs600_defconfig
powerpc                    gamecube_defconfig
mips                          ath79_defconfig
arm                         shannon_defconfig
mips                     cu1830-neo_defconfig
arm                          ep93xx_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                       lemote2f_defconfig
powerpc                    socrates_defconfig
arm                         orion5x_defconfig
powerpc                     tqm8560_defconfig
powerpc                     kmeter1_defconfig
arm                           omap1_defconfig
mips                      malta_kvm_defconfig
arm                                 defconfig
arm                        magician_defconfig
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
arm                  colibri_pxa300_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
