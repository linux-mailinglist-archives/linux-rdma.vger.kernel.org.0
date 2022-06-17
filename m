Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187DF54F0CF
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Jun 2022 07:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237443AbiFQF4g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Jun 2022 01:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiFQF4f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Jun 2022 01:56:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F29666CB2
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jun 2022 22:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655445391; x=1686981391;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=BHEhlvOoRGN1a9E+WLKcZj+MsVtevBI8EImWRnSgZ2c=;
  b=A8dTjYp75LT9Gp+om1e7GYlv5uXqqMb9/ftQ/ESnJX/zF/uoR8IUpdcX
   JSpf/Jugxtof4S2AkdMDjZ7Ilvk5FYKvkV5HdjLK7RAdtnizwnqIdB067
   +jST/tVYQkCUX3X9ujtDR4lSAHPfRI2ne5A02U/aoZtQRptP2J7hfNNFN
   LUJm8iqkZs5TyzN8/YuRwyGi3IvmpPx13tvEVHhCCTM7VNbvUwauPRMlr
   QP2/s7Zs0MsgOaf07Jc0gUQctOCzPSnCdecBv8KTCP4wC+cf9sHb0JcPx
   OTToTv07gIveAi6zc8HINs8hB8CC70ti0rU1B1PzpnzVaHuloZNntB1qf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280139917"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280139917"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 22:56:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="619156828"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 16 Jun 2022 22:56:29 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o24y4-000P81-N9;
        Fri, 17 Jun 2022 05:56:28 +0000
Date:   Fri, 17 Jun 2022 13:56:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 686141bc02f2d1b668a12d32b5e02c7987228aff
Message-ID: <62ac177a.jYrjSSo34QcMe0Y/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 686141bc02f2d1b668a12d32b5e02c7987228aff  Merge branch 'mlx5-next' into wip/leon-for-next

elapsed time: 740m

configs tested: 141
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc                 mpc85xx_cds_defconfig
s390                          debug_defconfig
m68k                          amiga_defconfig
mips                  maltasmvp_eva_defconfig
microblaze                          defconfig
powerpc                 mpc834x_itx_defconfig
sh                   rts7751r2dplus_defconfig
m68k                       m5475evb_defconfig
powerpc                     tqm8548_defconfig
sh                             sh03_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                          pxa910_defconfig
sh                      rts7751r2d1_defconfig
sh                         microdev_defconfig
parisc64                         alldefconfig
ia64                        generic_defconfig
mips                           xway_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                           sama5_defconfig
m68k                        stmark2_defconfig
powerpc                      ppc40x_defconfig
sh                            hp6xx_defconfig
xtensa                  nommu_kc705_defconfig
mips                             allmodconfig
xtensa                  cadence_csp_defconfig
mips                  decstation_64_defconfig
arc                    vdk_hs38_smp_defconfig
parisc                generic-64bit_defconfig
sh                   sh7770_generic_defconfig
mips                         cobalt_defconfig
sh                          urquell_defconfig
s390                                defconfig
m68k                          hp300_defconfig
arc                        vdk_hs38_defconfig
powerpc                      pcm030_defconfig
powerpc                    klondike_defconfig
m68k                        m5407c3_defconfig
arc                           tb10x_defconfig
arm                        realview_defconfig
sh                             espt_defconfig
sh                     sh7710voipgw_defconfig
arm                        mvebu_v7_defconfig
arc                            hsdk_defconfig
sh                   sh7724_generic_defconfig
sh                              ul2_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                      maltasmvp_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220617
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220617
arc                  randconfig-r043-20220617
s390                 randconfig-r044-20220617
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                           sama7_defconfig
mips                      malta_kvm_defconfig
arm                      pxa255-idp_defconfig
riscv                             allnoconfig
arm                          collie_defconfig
mips                         tb0287_defconfig
powerpc                     ppa8548_defconfig
mips                          ath79_defconfig
powerpc                      acadia_defconfig
arm                       cns3420vb_defconfig
arm                        multi_v5_defconfig
arm                          ep93xx_defconfig
arm                        mvebu_v5_defconfig
powerpc                     tqm5200_defconfig
arm                          moxart_defconfig
arm                         s5pv210_defconfig
hexagon                             defconfig
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
riscv                randconfig-r042-20220616
hexagon              randconfig-r041-20220616
hexagon              randconfig-r045-20220616
s390                 randconfig-r044-20220616

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
