Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BB76344B0
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Nov 2022 20:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiKVTfd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Nov 2022 14:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiKVTfc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Nov 2022 14:35:32 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6EC248E4
        for <linux-rdma@vger.kernel.org>; Tue, 22 Nov 2022 11:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669145732; x=1700681732;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=M4+cMCHtVoxYRGtpdDZNxhaYVl322LlCzg+wZVLaSTE=;
  b=GQEt7OwHZVgTvBGtnQFiQZoiIpXGh84qvcJj/DilBH/LKlcDzY7opTU1
   /cERxjoLixwFLC3t1WRvN3HoLb4EJTR8JysTHMPT7D1amrfuTkOIZoAlo
   ewVhKkDj73SV0oTWT1bokSX8fl+1ICEFTBBrhzKxIkhDESGZB3ZV8CkhP
   ltC6xfFKZ8a56HMHafiqzUiarpuAISYXDeiN2cy2GkEfmjjngrNbAkBRu
   FVr1cJ/EZtv09uW/u8/mFv/mLpFtxcCfK75XOUBSQilPbC5Hjfn0d0ewU
   5kqJb8+3tmooQZiJuldMrX7XkUbDJ0OPLuGfVY+lumrFh7KwuC+bL8jb8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="378156691"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="378156691"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 11:35:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="710312125"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="710312125"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Nov 2022 11:35:30 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oxZ3J-0001n1-1F;
        Tue, 22 Nov 2022 19:35:29 +0000
Date:   Wed, 23 Nov 2022 03:35:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 0c5e259b06a8efc69f929ad777ea49281bb58e37
Message-ID: <637d2475.DOEgthJcaqYJ2rJS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 0c5e259b06a8efc69f929ad777ea49281bb58e37  RDMA/hns: Fix incorrect sge nums calculation

elapsed time: 5456m

configs tested: 168
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                            allnoconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
s390                 randconfig-r044-20221121
riscv                randconfig-r042-20221121
arc                  randconfig-r043-20221121
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
sh                            migor_defconfig
sh                          urquell_defconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                 randconfig-a014-20221121
i386                 randconfig-a011-20221121
i386                 randconfig-a013-20221121
i386                 randconfig-a016-20221121
i386                 randconfig-a012-20221121
i386                 randconfig-a015-20221121
arc                              allyesconfig
i386                          randconfig-c001
x86_64               randconfig-a011-20221121
x86_64               randconfig-a014-20221121
x86_64               randconfig-a012-20221121
x86_64               randconfig-a013-20221121
x86_64               randconfig-a016-20221121
x86_64               randconfig-a015-20221121
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
mips                      loongson3_defconfig
csky                                defconfig
powerpc                      ppc6xx_defconfig
sh                             espt_defconfig
arm                              allmodconfig
arm                           corgi_defconfig
powerpc                      bamboo_defconfig
sh                          r7780mp_defconfig
arm                        cerfcube_defconfig
xtensa                           alldefconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                          simpad_defconfig
sh                          rsk7264_defconfig
mips                 decstation_r4k_defconfig
loongarch                           defconfig
arm                             pxa_defconfig
mips                        bcm47xx_defconfig
powerpc                    adder875_defconfig
mips                           ip32_defconfig
xtensa                       common_defconfig
loongarch                         allnoconfig
powerpc                     sequoia_defconfig
arm                        shmobile_defconfig
arc                  randconfig-r043-20221120
arm                      footbridge_defconfig
powerpc                       eiger_defconfig
sh                        sh7763rdp_defconfig
m68k                            q40_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                 mpc837x_mds_defconfig
ia64                             allmodconfig
m68k                          hp300_defconfig
arm                        realview_defconfig
powerpc                    sam440ep_defconfig
sh                         ap325rxa_defconfig
s390                             allyesconfig
arm                            hisi_defconfig
sh                          sdk7786_defconfig
sparc                       sparc64_defconfig
sh                           se7712_defconfig
nios2                               defconfig
parisc                              defconfig
arm64                               defconfig
ia64                             allyesconfig
m68k                                defconfig
ia64                                defconfig
m68k                        m5272c3_defconfig
arm                         nhk8815_defconfig
sparc                               defconfig
x86_64                                  kexec
mips                             allyesconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20221120
mips                           jazz_defconfig
powerpc                      ep88xc_defconfig
m68k                       m5249evb_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                           sama5_defconfig
parisc64                            defconfig
arc                           tb10x_defconfig
mips                          rb532_defconfig
sh                               alldefconfig
m68k                        m5307c3_defconfig
powerpc                     tqm8541_defconfig
powerpc                     asp8347_defconfig
xtensa                    xip_kc705_defconfig
powerpc                      pasemi_defconfig
sparc                       sparc32_defconfig
sparc                            alldefconfig
sh                           se7705_defconfig
m68k                        stmark2_defconfig
powerpc                 mpc8540_ads_defconfig
arm                      jornada720_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm                        trizeps4_defconfig
m68k                       m5275evb_defconfig
arc                          axs103_defconfig
m68k                             allmodconfig
alpha                            allyesconfig
sh                              ul2_defconfig
sh                           se7780_defconfig
sh                          sdk7780_defconfig
m68k                             allyesconfig

clang tested configs:
x86_64               randconfig-a002-20221121
x86_64               randconfig-a001-20221121
x86_64               randconfig-a004-20221121
x86_64               randconfig-a006-20221121
x86_64               randconfig-a005-20221121
x86_64               randconfig-a003-20221121
i386                 randconfig-a001-20221121
i386                 randconfig-a005-20221121
i386                 randconfig-a006-20221121
i386                 randconfig-a004-20221121
i386                 randconfig-a003-20221121
i386                 randconfig-a002-20221121
x86_64                        randconfig-k001
arm                                 defconfig
arm                          pxa168_defconfig
riscv                          rv32_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                    mvme5100_defconfig
arm                         bcm2835_defconfig
arm                         lpc32xx_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
powerpc                    gamecube_defconfig
powerpc                  mpc866_ads_defconfig
arm                        neponset_defconfig
powerpc                     ksi8560_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
powerpc                  mpc885_ads_defconfig
arm                     am200epdkit_defconfig
hexagon                             defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
