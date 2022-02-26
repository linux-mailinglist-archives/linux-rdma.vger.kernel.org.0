Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327114C55F3
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Feb 2022 13:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiBZMz2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 26 Feb 2022 07:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbiBZMz1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 26 Feb 2022 07:55:27 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3F1249136
        for <linux-rdma@vger.kernel.org>; Sat, 26 Feb 2022 04:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645880093; x=1677416093;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=V9qlu5oyBkYDKlz1LOYc0qoxXQJJ+3ejw7rghl+Et8o=;
  b=LL+ipTOA3t2ytdQJg3m7R6pBre6Xwt9kRHHhXrZW69uKcJPJRCHzicq3
   U4djJLCDpy12TQPaFl0qmrpndF9U8/PGmvgPX3CLf7GuWi+k8BXeXZdT7
   rXS9lykNKWsxA8AVqmBQU3d3sGvgAFO3tanXeqtvhpmITaBxrXe0dKn4D
   yZw5PcB6+xkW8+gRmB5kGVkPIGbAMk0E1Ju8klWIlfuvzUV33DZFBpNld
   sGsCVJLG0Lc+vbPABKFXODK4R55Wr7FOF0FhatIKRoAvcy/RqPgFXOKH6
   /Z1OZCcshN0ocMmGdC8YwfcFKqkK4zhGpejL4Amc+9TdOPhmEJ8j1pRAv
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="236162134"
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="236162134"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 04:54:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="592762739"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 26 Feb 2022 04:54:51 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNwb4-0005Tz-Vc; Sat, 26 Feb 2022 12:54:50 +0000
Date:   Sat, 26 Feb 2022 20:54:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 884194ef264e140a6d22f7a5de2b76765d17734a
Message-ID: <621a2309.NSr3ss6QFOTdFWwa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 884194ef264e140a6d22f7a5de2b76765d17734a  RDMA/irdma: Move union irdma_sockaddr to header file

elapsed time: 720m

configs tested: 152
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220225
powerpc              randconfig-c003-20220225
s390                          debug_defconfig
arm                        shmobile_defconfig
sh                         microdev_defconfig
sh                   sh7770_generic_defconfig
arm                            hisi_defconfig
sh                           se7619_defconfig
arm                        oxnas_v6_defconfig
xtensa                  nommu_kc705_defconfig
arc                                 defconfig
sh                          sdk7780_defconfig
powerpc                     asp8347_defconfig
arm                          exynos_defconfig
s390                       zfcpdump_defconfig
m68k                         apollo_defconfig
powerpc                 linkstation_defconfig
arm                          lpd270_defconfig
parisc                           allyesconfig
arc                      axs103_smp_defconfig
mips                         tb0226_defconfig
arm                       imx_v6_v7_defconfig
sh                               allmodconfig
arm                         assabet_defconfig
mips                  decstation_64_defconfig
sh                        dreamcast_defconfig
sh                   sh7724_generic_defconfig
powerpc                     pq2fads_defconfig
sh                          kfr2r09_defconfig
powerpc                        warp_defconfig
m68k                        mvme147_defconfig
microblaze                      mmu_defconfig
nios2                         10m50_defconfig
h8300                               defconfig
powerpc                 mpc837x_rdb_defconfig
mips                         db1xxx_defconfig
powerpc                    klondike_defconfig
mips                             allyesconfig
m68k                        m5272c3_defconfig
powerpc                      tqm8xx_defconfig
mips                        vocore2_defconfig
arm                        trizeps4_defconfig
i386                             alldefconfig
powerpc                         wii_defconfig
arm                          pxa910_defconfig
arm                           sunxi_defconfig
h8300                     edosk2674_defconfig
arc                         haps_hs_defconfig
powerpc                     mpc83xx_defconfig
powerpc                     redwood_defconfig
mips                     loongson1b_defconfig
arm                        mvebu_v7_defconfig
xtensa                           allyesconfig
powerpc                       maple_defconfig
powerpc                     ep8248e_defconfig
arm                           tegra_defconfig
sh                          lboxre2_defconfig
m68k                          hp300_defconfig
parisc                generic-32bit_defconfig
powerpc                      ppc40x_defconfig
arm                          simpad_defconfig
mips                         rt305x_defconfig
powerpc                   motionpro_defconfig
arm                           viper_defconfig
sh                        sh7757lcr_defconfig
m68k                          multi_defconfig
h8300                       h8s-sim_defconfig
sh                           se7750_defconfig
mips                          rb532_defconfig
mips                     decstation_defconfig
um                               alldefconfig
arm                      integrator_defconfig
arm                  randconfig-c002-20220225
arm                  randconfig-c002-20220226
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
s390                             allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc64                            defconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
s390                 randconfig-r044-20220226
arc                  randconfig-r043-20220226
riscv                randconfig-r042-20220226
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
powerpc              randconfig-c003-20220225
x86_64                        randconfig-c007
arm                  randconfig-c002-20220225
mips                 randconfig-c004-20220225
i386                          randconfig-c001
riscv                randconfig-c006-20220225
powerpc                     ppa8548_defconfig
arm                     am200epdkit_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220225
hexagon              randconfig-r041-20220225
hexagon              randconfig-r045-20220226
hexagon              randconfig-r041-20220226
riscv                randconfig-r042-20220225

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
