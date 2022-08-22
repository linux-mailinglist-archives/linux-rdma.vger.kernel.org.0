Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFC959B6EE
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Aug 2022 02:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiHVARX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Aug 2022 20:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiHVARW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Aug 2022 20:17:22 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E59311443
        for <linux-rdma@vger.kernel.org>; Sun, 21 Aug 2022 17:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661127441; x=1692663441;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=uyveHBt4dbwiFJKwcjnRaUVH4VtKrLP0Zguns4aCjhU=;
  b=CzN4m3iqYYF79FfXyxpeTpQoW5H+AkIdRZEnvuxJGEF6fubI9P2mY9+g
   uKPVebQYPS1g7y5guqsw2flISkvv/JubZkHVO9M/T5BY8vUA1B+BI2wbk
   6AwHuupToalJPrX6fJQIphgDvbWlZkbOMXPtnkuSXu7fvdN/1pDB438ML
   jL+jnbaPldl5U+5tKf+H+h0TeAU26pXy2ySLmT9RMH5Lr1VPMOBKSqjKF
   LLQJUeYGU8sVgp++u/Jz8Jhum20ZUTXyDO6+pi0F1mTuw5xQO7iy4KuW9
   mKZVpgaxtdaX1RNtq+jr0fc+FDcmowNCSWIvCy5egd1s6tuTaczCvgcpn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="379583465"
X-IronPort-AV: E=Sophos;i="5.93,253,1654585200"; 
   d="scan'208";a="379583465"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 17:17:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,253,1654585200"; 
   d="scan'208";a="677019246"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 21 Aug 2022 17:17:19 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPv82-0004gz-2o;
        Mon, 22 Aug 2022 00:17:18 +0000
Date:   Mon, 22 Aug 2022 08:16:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 56c310de0b4b3aca1c4fdd9c1093fc48372a7335
Message-ID: <6302caf2.sKxFKJkGip9SDBLI%lkp@intel.com>
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
branch HEAD: 56c310de0b4b3aca1c4fdd9c1093fc48372a7335  RDMA/rtrs-srv: Pass the correct number of entries for dma mapped SGL

elapsed time: 726m

configs tested: 117
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arc                  randconfig-r043-20220821
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
arm64                            allyesconfig
i386                                defconfig
x86_64                        randconfig-a013
i386                          randconfig-a001
arm                              allyesconfig
m68k                             allmodconfig
x86_64                               rhel-8.3
i386                          randconfig-a012
powerpc                           allnoconfig
x86_64                        randconfig-a011
x86_64                           allyesconfig
i386                          randconfig-a003
x86_64                        randconfig-a004
arc                              allyesconfig
alpha                            allyesconfig
x86_64                        randconfig-a015
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                          rhel-8.3-func
ia64                             allmodconfig
x86_64                         rhel-8.3-kunit
i386                          randconfig-a005
x86_64                    rhel-8.3-kselftests
m68k                             allyesconfig
arc                               allnoconfig
x86_64                           rhel-8.3-syz
i386                          randconfig-a016
alpha                             allnoconfig
sh                               allmodconfig
i386                          randconfig-a014
mips                             allyesconfig
i386                             allyesconfig
riscv                             allnoconfig
csky                              allnoconfig
powerpc                          allmodconfig
mips                     decstation_defconfig
arm                           imxrt_defconfig
mips                 decstation_r4k_defconfig
arm                       imx_v6_v7_defconfig
ia64                             alldefconfig
sh                           se7619_defconfig
arm                      integrator_defconfig
csky                                defconfig
microblaze                          defconfig
sh                        edosk7705_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
arm64                               defconfig
arm                        spear6xx_defconfig
parisc64                         alldefconfig
i386                          randconfig-c001
mips                           jazz_defconfig
arm                           h3600_defconfig
sh                     magicpanelr2_defconfig
alpha                               defconfig
openrisc                            defconfig
powerpc                 canyonlands_defconfig
arm                          lpd270_defconfig
arm                         lubbock_defconfig
sh                                  defconfig
parisc                generic-32bit_defconfig
arm                         axm55xx_defconfig
sh                             shx3_defconfig
sh                           se7780_defconfig
sh                          rsk7269_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
m68k                         apollo_defconfig
sh                           se7724_defconfig
arm                            lart_defconfig
m68k                       m5275evb_defconfig
arm                           sama5_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220821
powerpc                    adder875_defconfig
arm                         s3c6400_defconfig
arm                        cerfcube_defconfig
powerpc                      arches_defconfig
powerpc                      ppc6xx_defconfig
sh                           se7343_defconfig
parisc                              defconfig
sh                        apsh4ad0a_defconfig
m68k                          sun3x_defconfig
sh                     sh7710voipgw_defconfig
mips                        vocore2_defconfig

clang tested configs:
hexagon              randconfig-r045-20220821
hexagon              randconfig-r041-20220821
riscv                randconfig-r042-20220821
s390                 randconfig-r044-20220821
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a001
i386                          randconfig-a002
x86_64                        randconfig-a003
i386                          randconfig-a013
i386                          randconfig-a006
i386                          randconfig-a015
x86_64                        randconfig-a014
i386                          randconfig-a004
i386                          randconfig-a011
riscv                    nommu_virt_defconfig
mips                malta_qemu_32r6_defconfig
arm                       cns3420vb_defconfig
x86_64                        randconfig-k001
arm                           spitz_defconfig
arm                         s5pv210_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                          moxart_defconfig
arm                         bcm2835_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
