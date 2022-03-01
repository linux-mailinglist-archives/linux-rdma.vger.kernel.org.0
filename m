Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE584C8813
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Mar 2022 10:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiCAJfy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Mar 2022 04:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiCAJfx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Mar 2022 04:35:53 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4790BC1B
        for <linux-rdma@vger.kernel.org>; Tue,  1 Mar 2022 01:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646127312; x=1677663312;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=CY222U6cJcdryxzuzpNnTiKuURohUmX4MuYegXSm0LE=;
  b=F8YffJqlXN4sukZAh4JTMYfUyb6VnxaS4FSKkztpreuEVLbz997eb0t9
   Nsk8k6/rwfU64GTOVpm9K4CfDph4VFwEyJWGyJBSB5PWN9SqURKq+oHSB
   e3XjQzd8cCfKIAkDwNt1RVE1rJ2O7tu4NGRYDKg7f50i8NMeIhkdye+af
   MD+Fg0od6FSzwBSuLL5uErlSlDZsupdY8/oiOeBC4K2HJMvC3p6tbdKtD
   v2l5yJipxRVNWq2I00MYQfuCtZrV8V425miiczIEKWJH6hNIEUwQ9dYZu
   GBoVmtxG+NRxDkt15rH+bMXNUNtrY+Mv91V4Ni0ht8fwMflxAWXMnN2RU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="233068332"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="233068332"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 01:35:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="593536533"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2022 01:35:09 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOyuS-0000FA-Hf; Tue, 01 Mar 2022 09:35:08 +0000
Date:   Tue, 01 Mar 2022 17:34:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 a80501b89152adb29adc7ab943d75c7345f9a3fb
Message-ID: <621de896.krVZ7SknaButOFyA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: a80501b89152adb29adc7ab943d75c7345f9a3fb  RDMA/core: Remove unnecessary statements

elapsed time: 729m

configs tested: 216
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
i386                 randconfig-c001-20220228
arc                        vdk_hs38_defconfig
powerpc                      pasemi_defconfig
m68k                       m5249evb_defconfig
arm                            lart_defconfig
arm                         assabet_defconfig
arm                          simpad_defconfig
sh                           se7780_defconfig
arc                 nsimosci_hs_smp_defconfig
parisc                              defconfig
mips                             allyesconfig
powerpc                        cell_defconfig
s390                                defconfig
h8300                       h8s-sim_defconfig
nios2                         10m50_defconfig
mips                           jazz_defconfig
mips                         db1xxx_defconfig
sh                ecovec24-romimage_defconfig
m68k                            mac_defconfig
sh                     sh7710voipgw_defconfig
m68k                        m5407c3_defconfig
sh                              ul2_defconfig
sh                            migor_defconfig
powerpc                      tqm8xx_defconfig
xtensa                    xip_kc705_defconfig
nds32                               defconfig
mips                     loongson1b_defconfig
powerpc                     tqm8548_defconfig
sh                        sh7757lcr_defconfig
powerpc                      bamboo_defconfig
arm                        keystone_defconfig
arc                        nsim_700_defconfig
mips                            gpr_defconfig
arm                       omap2plus_defconfig
powerpc                     tqm8555_defconfig
mips                         mpc30x_defconfig
arm                        cerfcube_defconfig
mips                       bmips_be_defconfig
mips                         rt305x_defconfig
sh                          rsk7269_defconfig
sh                        sh7785lcr_defconfig
sh                         ecovec24_defconfig
arm                        multi_v7_defconfig
sh                          landisk_defconfig
sh                          r7785rp_defconfig
arc                            hsdk_defconfig
sh                          r7780mp_defconfig
sh                           se7724_defconfig
sh                          sdk7780_defconfig
arm                            pleb_defconfig
microblaze                      mmu_defconfig
arm                          pxa3xx_defconfig
m68k                        m5307c3_defconfig
m68k                          multi_defconfig
powerpc                     redwood_defconfig
parisc                generic-64bit_defconfig
mips                          rb532_defconfig
um                               alldefconfig
sh                        edosk7705_defconfig
sh                                  defconfig
powerpc                   motionpro_defconfig
sh                               alldefconfig
um                           x86_64_defconfig
s390                       zfcpdump_defconfig
powerpc                     taishan_defconfig
openrisc                    or1ksim_defconfig
arm                         axm55xx_defconfig
powerpc                     sequoia_defconfig
m68k                       m5275evb_defconfig
arm                        mini2440_defconfig
sparc64                          alldefconfig
sh                           se7619_defconfig
powerpc                      ppc6xx_defconfig
arc                          axs103_defconfig
openrisc                         alldefconfig
sh                           se7751_defconfig
powerpc                 linkstation_defconfig
arm                          badge4_defconfig
arm                            qcom_defconfig
arm                       aspeed_g5_defconfig
arc                        nsimosci_defconfig
m68k                         apollo_defconfig
arm                        spear6xx_defconfig
m68k                          amiga_defconfig
arm                           viper_defconfig
arm                  randconfig-c002-20220228
arm                  randconfig-c002-20220227
arm                  randconfig-c002-20220301
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
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
x86_64               randconfig-a011-20220228
x86_64               randconfig-a015-20220228
x86_64               randconfig-a014-20220228
x86_64               randconfig-a013-20220228
x86_64               randconfig-a016-20220228
x86_64               randconfig-a012-20220228
i386                 randconfig-a016-20220228
i386                 randconfig-a012-20220228
i386                 randconfig-a015-20220228
i386                 randconfig-a011-20220228
i386                 randconfig-a013-20220228
i386                 randconfig-a014-20220228
s390                 randconfig-r044-20220228
arc                  randconfig-r043-20220228
riscv                randconfig-r042-20220228
arc                  randconfig-r043-20220227
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc              randconfig-c003-20220227
x86_64                        randconfig-c007
arm                  randconfig-c002-20220227
mips                 randconfig-c004-20220227
s390                 randconfig-c005-20220227
i386                          randconfig-c001
riscv                randconfig-c006-20220227
powerpc              randconfig-c003-20220301
riscv                randconfig-c006-20220301
arm                  randconfig-c002-20220301
mips                 randconfig-c004-20220301
powerpc                     powernv_defconfig
mips                           rs90_defconfig
arm                         hackkit_defconfig
arm                      pxa255-idp_defconfig
powerpc                     tqm8540_defconfig
mips                           mtx1_defconfig
powerpc                     pseries_defconfig
powerpc                     tqm8560_defconfig
arm                       cns3420vb_defconfig
arm                        neponset_defconfig
arm                        vexpress_defconfig
powerpc                      pmac32_defconfig
arm                       imx_v4_v5_defconfig
mips                      bmips_stb_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     mpc5200_defconfig
arm                           sama7_defconfig
mips                           ip28_defconfig
arm                        mvebu_v5_defconfig
arm                          imote2_defconfig
powerpc                        fsp2_defconfig
arm                           spitz_defconfig
arm                     davinci_all_defconfig
mips                     cu1830-neo_defconfig
x86_64               randconfig-a003-20220228
x86_64               randconfig-a005-20220228
x86_64               randconfig-a002-20220228
x86_64               randconfig-a006-20220228
x86_64               randconfig-a001-20220228
x86_64               randconfig-a004-20220228
i386                 randconfig-a002-20220228
i386                 randconfig-a001-20220228
i386                 randconfig-a005-20220228
i386                 randconfig-a003-20220228
i386                 randconfig-a006-20220228
i386                 randconfig-a004-20220228
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220301
hexagon              randconfig-r045-20220227
hexagon              randconfig-r041-20220227
riscv                randconfig-r042-20220227

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
