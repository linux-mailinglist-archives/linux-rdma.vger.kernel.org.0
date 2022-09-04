Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985E55AC6AF
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Sep 2022 23:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbiIDVj0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Sep 2022 17:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiIDVjZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 4 Sep 2022 17:39:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ABCF30
        for <linux-rdma@vger.kernel.org>; Sun,  4 Sep 2022 14:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662327564; x=1693863564;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/P9OHLc1ILf+cN7PrLHx7H2EaHHe73Doyv7dkRu79V4=;
  b=bREdiZGsuyOcYVc/SzV4NP0kecLL9JbzLDX4lnKJB951XSwTFgJ3FAIO
   zAKsWJfySPxr0NWEV2YAQjHYHmNK9JA/bUaFscI8s37UxkNkaAuVWsKjN
   Z2P5iSvkIzHmYpz4kj+loVK1JrncRnztPrmC5+Yxv5lGIbKetxAKM4kjk
   R2X6FX5ILXyjEXA5UKDlzO+1Q8LVy1/GXdGmuzVBL+SNYmeyIcUn+u6YR
   VzgbmbzpHsOPP8cqXnNyv3RB/ZFQvOA1XStM0RJjqMT2DtCOX0DCFzrmL
   SXid7BAtxAyR6mf4wvYRpCWer+5/GUR5safa2peTqOXE0Icb5o0JEsi3i
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="283263878"
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="283263878"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2022 14:39:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="590691205"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 04 Sep 2022 14:39:22 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUxKr-0003On-17;
        Sun, 04 Sep 2022 21:39:21 +0000
Date:   Mon, 05 Sep 2022 05:38:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 0d1b756acf60da5004c1e20ca4462f0c257bf6e1
Message-ID: <63151aee.p4bRj90ph0rzxXIH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: 0d1b756acf60da5004c1e20ca4462f0c257bf6e1  RDMA/siw: Pass a pointer to virt_to_page()

elapsed time: 769m

configs tested: 167
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                  randconfig-r043-20220904
riscv                randconfig-r042-20220904
x86_64                              defconfig
s390                 randconfig-r044-20220904
i386                          randconfig-a016
i386                          randconfig-a012
i386                          randconfig-a014
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a013
arm                                 defconfig
i386                                defconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a015
x86_64                               rhel-8.3
i386                          randconfig-a005
x86_64                        randconfig-a006
x86_64                        randconfig-a011
i386                          randconfig-a001
x86_64                           allyesconfig
arc                               allnoconfig
x86_64                          rhel-8.3-func
i386                          randconfig-a003
x86_64                         rhel-8.3-kunit
alpha                             allnoconfig
riscv                             allnoconfig
x86_64                        randconfig-a004
csky                              allnoconfig
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
x86_64                    rhel-8.3-kselftests
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
sh                           se7722_defconfig
arm                           u8500_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
i386                             allyesconfig
mips                      fuloong2e_defconfig
sparc64                          alldefconfig
arc                              allyesconfig
alpha                            allyesconfig
ia64                             allmodconfig
sh                   rts7751r2dplus_defconfig
m68k                             allyesconfig
mips                  maltasmvp_eva_defconfig
sh                           se7721_defconfig
m68k                           sun3_defconfig
arc                            hsdk_defconfig
powerpc                 mpc837x_rdb_defconfig
i386                          randconfig-c001
arm                         vf610m4_defconfig
loongarch                 loongson3_defconfig
sparc                               defconfig
microblaze                      mmu_defconfig
arm                         lpc18xx_defconfig
sh                           se7712_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
arm                         axm55xx_defconfig
m68k                          multi_defconfig
sh                          rsk7269_defconfig
mips                          rb532_defconfig
i386                             alldefconfig
ia64                          tiger_defconfig
sh                         apsh4a3a_defconfig
m68k                             alldefconfig
sh                          sdk7780_defconfig
i386                 randconfig-a003-20220905
i386                 randconfig-a005-20220905
i386                 randconfig-a006-20220905
i386                 randconfig-a001-20220905
i386                 randconfig-a002-20220905
i386                 randconfig-a004-20220905
sh                   secureedge5410_defconfig
powerpc                  iss476-smp_defconfig
mips                         db1xxx_defconfig
xtensa                    xip_kc705_defconfig
arc                     nsimosci_hs_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                           jazz_defconfig
arm                        realview_defconfig
powerpc                mpc7448_hpc2_defconfig
arc                          axs101_defconfig
arm                           viper_defconfig
arm                            hisi_defconfig
arm                     eseries_pxa_defconfig
sh                           se7750_defconfig
sh                          landisk_defconfig
powerpc                      pasemi_defconfig
powerpc                         ps3_defconfig
arm                         nhk8815_defconfig
sh                           se7780_defconfig
powerpc                      makalu_defconfig
sh                          sdk7786_defconfig
sh                         microdev_defconfig
openrisc                       virt_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220904
sh                          r7780mp_defconfig
m68k                          sun3x_defconfig
powerpc                      mgcoge_defconfig
sh                           se7751_defconfig
nios2                            allyesconfig
arm                           corgi_defconfig
arm                       aspeed_g5_defconfig
arm                          iop32x_defconfig
powerpc                     asp8347_defconfig
riscv                            allyesconfig
powerpc                      ppc40x_defconfig
arm                          pxa3xx_defconfig
arm                             ezx_defconfig
powerpc              randconfig-c003-20220904

clang tested configs:
hexagon              randconfig-r045-20220904
hexagon              randconfig-r041-20220904
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
arm                   milbeaut_m10v_defconfig
arm                            mmp2_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                      bmips_stb_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                     loongson2k_defconfig
mips                          rm200_defconfig
arm                           sama7_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                          moxart_defconfig
arm                        multi_v5_defconfig
x86_64                        randconfig-k001
powerpc                          g5_defconfig
arm                      pxa255-idp_defconfig
powerpc                     tqm8560_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                 mpc8272_ads_defconfig
mips                           ip27_defconfig
riscv                randconfig-r042-20220905
hexagon              randconfig-r041-20220905
hexagon              randconfig-r045-20220905
s390                 randconfig-r044-20220905
i386                 randconfig-a016-20220905
i386                 randconfig-a012-20220905
i386                 randconfig-a015-20220905
i386                 randconfig-a011-20220905
i386                 randconfig-a013-20220905
i386                 randconfig-a014-20220905
mips                      malta_kvm_defconfig
powerpc                     akebono_defconfig
mips                malta_qemu_32r6_defconfig
arm                         socfpga_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
