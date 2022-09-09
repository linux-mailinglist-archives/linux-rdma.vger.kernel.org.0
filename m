Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717975B2D42
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Sep 2022 06:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiIIEPF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Sep 2022 00:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIIEPF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Sep 2022 00:15:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ADE6C753
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 21:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662696903; x=1694232903;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=t0BWbWx9CnYEpLXZ8BAJz3+LVi6/sloDJJFrYQo9JTw=;
  b=gwr4emMuD+ifEBYYXgVmJB2WwEwaawRaWzxroNDu1zulIiThAQ4xZDet
   w1MY5Kj73E03fzXhMtHeuTO/OYRhW6zPNtn0lNqzM3DoUpDPKfQMdwN0s
   Zrc/Urs5diLmiFEISKn1iLiH3wV1Shyn2+pXw/z4SUyykH4HM5DnvR1tt
   2jaJQ2qyZcwTRhe7tED3MQpN+F+ogZNT+P4BWAwUr08JX1QNK5g96P6F9
   z+dBRG7jrCPcUGS7B08QbTzruWErED+Ltn//P0SwrTl6rY0DbvHHG/aDe
   532RshGgq324DvAU0nM8b8ditwuQPUJXgc+7yBOqfvzZF48UzJpTXCQyR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="298730480"
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="298730480"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 21:14:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="566229302"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 08 Sep 2022 21:14:47 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWVPi-0000hx-15;
        Fri, 09 Sep 2022 04:14:46 +0000
Date:   Fri, 09 Sep 2022 12:14:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 e866025b3b1557f9bf6ab1770f297fe6d90e0417
Message-ID: <631abdb3.ARuIgDto0Pc+NArJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: e866025b3b1557f9bf6ab1770f297fe6d90e0417  RDMA/mlx5: Remove duplicate assignment in umr_rereg_pas()

elapsed time: 1154m

configs tested: 170
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a002
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                        randconfig-a015
i386                                defconfig
arc                              allyesconfig
x86_64                        randconfig-a006
arm                                 defconfig
x86_64                               rhel-8.3
alpha                            allyesconfig
x86_64                        randconfig-a004
arc                  randconfig-r043-20220908
i386                          randconfig-a014
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-a001
x86_64                           allyesconfig
i386                          randconfig-a003
i386                          randconfig-a012
arc                  randconfig-r043-20220907
i386                          randconfig-a016
i386                          randconfig-a005
s390                 randconfig-r044-20220908
riscv                randconfig-r042-20220908
x86_64                              defconfig
i386                             allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                         wii_defconfig
arm                        cerfcube_defconfig
xtensa                  cadence_csp_defconfig
m68k                       m5275evb_defconfig
sh                         ap325rxa_defconfig
sparc                             allnoconfig
powerpc                      arches_defconfig
openrisc                 simple_smp_defconfig
powerpc                     asp8347_defconfig
i386                             alldefconfig
powerpc                     ep8248e_defconfig
m68k                          hp300_defconfig
m68k                        m5272c3_defconfig
arm                          exynos_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
i386                          randconfig-c001
um                                  defconfig
sh                            titan_defconfig
arm                            mps2_defconfig
arm                          pxa3xx_defconfig
arm                         s3c6400_defconfig
powerpc                     stx_gp3_defconfig
arm64                            alldefconfig
sh                           se7722_defconfig
ia64                          tiger_defconfig
arc                              alldefconfig
arm                        realview_defconfig
xtensa                              defconfig
arm                          iop32x_defconfig
parisc64                            defconfig
openrisc                            defconfig
sh                        sh7757lcr_defconfig
sparc                               defconfig
sh                     sh7710voipgw_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sh                          r7785rp_defconfig
powerpc                     mpc83xx_defconfig
xtensa                generic_kc705_defconfig
arm                      integrator_defconfig
sparc64                             defconfig
arc                     haps_hs_smp_defconfig
arm                         assabet_defconfig
arm                            zeus_defconfig
mips                            ar7_defconfig
mips                         rt305x_defconfig
arc                      axs103_smp_defconfig
openrisc                    or1ksim_defconfig
sh                             shx3_defconfig
mips                    maltaup_xpa_defconfig
mips                  maltasmvp_eva_defconfig
sh                        edosk7705_defconfig
mips                     decstation_defconfig
sh                          sdk7780_defconfig
arm                        mini2440_defconfig
sh                            shmin_defconfig
powerpc                        cell_defconfig
nios2                               defconfig
mips                 decstation_r4k_defconfig
arm                      footbridge_defconfig
parisc                           allyesconfig
arm                             pxa_defconfig
arm                           u8500_defconfig
powerpc                      mgcoge_defconfig
m68k                                defconfig
m68k                          multi_defconfig
nios2                            allyesconfig
sh                             espt_defconfig
sh                     magicpanelr2_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                            hisi_defconfig
xtensa                    smp_lx200_defconfig
m68k                          atari_defconfig
m68k                       m5475evb_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                     tqm8548_defconfig
parisc                              defconfig
powerpc                      ppc40x_defconfig
mips                      loongson3_defconfig
sh                         apsh4a3a_defconfig
parisc                           alldefconfig
sh                            migor_defconfig
arc                    vdk_hs38_smp_defconfig
sh                         microdev_defconfig
mips                           xway_defconfig
sparc64                          alldefconfig
arm                         nhk8815_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220908
ia64                             allmodconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a001
x86_64                        randconfig-a016
x86_64                        randconfig-a003
i386                          randconfig-a013
x86_64                        randconfig-a014
i386                          randconfig-a015
hexagon              randconfig-r041-20220907
x86_64                        randconfig-a005
i386                          randconfig-a011
hexagon              randconfig-r041-20220908
riscv                randconfig-r042-20220907
hexagon              randconfig-r045-20220908
i386                          randconfig-a002
hexagon              randconfig-r045-20220907
i386                          randconfig-a004
s390                 randconfig-r044-20220907
i386                          randconfig-a006
powerpc                     tqm8540_defconfig
arm                           spitz_defconfig
x86_64                        randconfig-k001
arm                      pxa255-idp_defconfig
s390                             alldefconfig
powerpc                        fsp2_defconfig
powerpc                 mpc8272_ads_defconfig
mips                        qi_lb60_defconfig
arm                          pcm027_defconfig
mips                           mtx1_defconfig
mips                          ath79_defconfig
powerpc                     ppa8548_defconfig
mips                           ip22_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
