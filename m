Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C115A4022
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 01:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiH1XSo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Aug 2022 19:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiH1XSl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Aug 2022 19:18:41 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504822E6B1
        for <linux-rdma@vger.kernel.org>; Sun, 28 Aug 2022 16:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661728720; x=1693264720;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tCyzlYRYopI2QynlCPCZ4FPRWdtZNSCh77Pp1JY+WAI=;
  b=d+vQaqSorVOw+0A+XZpGjrehYKVrg5UkKFdGkcWrBIPV54sglnZptsoQ
   SMf3lTKoKqsjX2IrZk+PeXWQZNwBDvAKJYx9DPnOV/VX7v3ZmPqp//El6
   Dpf9ofX2ONb15z7EE+/UkEAEcW0LsCDcapz84dTlaCbWBuGbgSiB5MYfS
   0Y3CJX5Yhq0Q2LRjspCnhudfst/DVm/gcRzMOsCOWFRlz4j7GeMMelQ01
   2+AGmKED6W83qmepBaJz/5OztoqtMjRSouXGRzuvc+qWvgpStnL5mNUC8
   367mEaW2AmqfnGD9kLDWG1F3rx/xxkMy6DHvr9GnUXwXgsVIg6lNv/JGK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="275178475"
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="275178475"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 16:18:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="587952863"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Aug 2022 16:18:38 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSRY5-0001iN-0y;
        Sun, 28 Aug 2022 23:18:37 +0000
Date:   Mon, 29 Aug 2022 07:18:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 ead54ced6321099978d30d62dc49c282a6e70574
Message-ID: <630bf7ba.HlcQTzOd6DpLtLo3%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: ead54ced6321099978d30d62dc49c282a6e70574  RDMA/irdma: Fix drain SQ hang with no completion

elapsed time: 731m

configs tested: 141
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220828
m68k                             allyesconfig
i386                                defconfig
s390                 randconfig-r044-20220828
riscv                randconfig-r042-20220828
loongarch                         allnoconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
arc                               allnoconfig
csky                                defconfig
s390                                defconfig
i386                   debian-10.3-kselftests
i386                          randconfig-a001
x86_64                              defconfig
powerpc                           allnoconfig
x86_64                        randconfig-a002
x86_64                           alldefconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a006
riscv                               defconfig
x86_64                           allyesconfig
i386                          randconfig-a014
i386                         debian-10.3-func
arm                                 defconfig
loongarch                           defconfig
x86_64                          rhel-8.3-func
alpha                             allnoconfig
x86_64                               rhel-8.3
i386                          debian-10.3-kvm
i386                              debian-10.3
riscv                    nommu_k210_defconfig
csky                              allnoconfig
riscv                    nommu_virt_defconfig
powerpc                          allmodconfig
ia64                             allmodconfig
sparc                               defconfig
x86_64                        randconfig-a015
i386                        debian-10.3-kunit
x86_64                         rhel-8.3-kunit
mips                     loongson1b_defconfig
parisc                              defconfig
i386                          randconfig-a003
x86_64                        randconfig-a004
x86_64                                  kexec
x86_64                        randconfig-a013
nios2                               defconfig
arc                              allyesconfig
mips                         cobalt_defconfig
nios2                            allyesconfig
parisc64                            defconfig
arm                           h5000_defconfig
arc                                 defconfig
mips                             allyesconfig
i386                          randconfig-a012
sh                      rts7751r2d1_defconfig
sparc                            allyesconfig
alpha                            allyesconfig
x86_64                           rhel-8.3-kvm
arc                    vdk_hs38_smp_defconfig
sh                               allmodconfig
parisc                           allyesconfig
alpha                               defconfig
mips                           ip32_defconfig
arm                         lpc18xx_defconfig
x86_64                    rhel-8.3-kselftests
xtensa                           allyesconfig
powerpc                        warp_defconfig
sh                          sdk7786_defconfig
powerpc                          allyesconfig
m68k                             allmodconfig
i386                             allyesconfig
sh                             sh03_defconfig
arm                              allyesconfig
x86_64                           rhel-8.3-syz
sh                            titan_defconfig
i386                          randconfig-a016
arm64                            allyesconfig
mips                         bigsur_defconfig
arm                             pxa_defconfig
riscv                            allyesconfig
powerpc                   motionpro_defconfig
arc                            hsdk_defconfig
arm                         nhk8815_defconfig
arm                          gemini_defconfig
xtensa                           alldefconfig
sh                        sh7763rdp_defconfig
arm                              allmodconfig
mips                             allmodconfig
mips                    maltaup_xpa_defconfig
i386                          randconfig-a005
arc                 nsimosci_hs_smp_defconfig
arm                        shmobile_defconfig
sh                        edosk7705_defconfig
ia64                          tiger_defconfig
arm64                               defconfig
m68k                                defconfig
i386                          randconfig-c001
arm                            xcep_defconfig
powerpc                         ps3_defconfig
ia64                                defconfig
powerpc              randconfig-c003-20220828
sh                           se7750_defconfig
openrisc                    or1ksim_defconfig
s390                             allmodconfig
m68k                          amiga_defconfig
s390                             allyesconfig
ia64                             allyesconfig
powerpc                      mgcoge_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220828

clang tested configs:
hexagon              randconfig-r041-20220828
hexagon              randconfig-r045-20220828
i386                          randconfig-a013
x86_64                        randconfig-a001
x86_64                        randconfig-a005
i386                          randconfig-a011
x86_64                        randconfig-a012
arm                       spear13xx_defconfig
x86_64                        randconfig-a003
mips                   sb1250_swarm_defconfig
x86_64                        randconfig-a014
powerpc               mpc834x_itxgp_defconfig
x86_64                        randconfig-a016
i386                          randconfig-a002
powerpc                    ge_imp3a_defconfig
arm                              alldefconfig
arm                         bcm2835_defconfig
arm                       netwinder_defconfig
mips                        qi_lb60_defconfig
mips                malta_qemu_32r6_defconfig
arm                          sp7021_defconfig
arm                  colibri_pxa270_defconfig
riscv                          rv32_defconfig
hexagon                          alldefconfig
arm                     am200epdkit_defconfig
i386                          randconfig-a015
i386                          randconfig-a004
i386                          randconfig-a006
powerpc                      ppc64e_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
