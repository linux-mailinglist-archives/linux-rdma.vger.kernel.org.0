Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CDD7527A0
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jul 2023 17:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjGMPpN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jul 2023 11:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjGMPpM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jul 2023 11:45:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4BA2680;
        Thu, 13 Jul 2023 08:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689263111; x=1720799111;
  h=date:from:to:cc:subject:message-id;
  bh=9/FLSPVdU4RNS+r4dReJ2NONh6zf50wlqAxsuoP5f0g=;
  b=TNuv+nBuJxdw35a8vSQXWLYpBE+3CkDcEz7m3K6MoP5tzji/JrFjJWKo
   0Zm1CUoX60H604RhdHWkgqpFd/ubCYMqMa3l+I2cPCChis1VCN8PRmwbe
   OsI8NNRacMDM0ArLZHxy1Cy3AoxYN4sF0jaOt/ki14HX+5UvHGiXvLu5R
   KvndMyZCOJED/IVmDpn7OiaK5vscZbL4yBIaWzkHnnS3TgXU+Tze0u9lo
   bAlgxXfHornWOr3MZYypfAhqJyRz/Onv0c3EcrALVycW3f6fTv5Dwgxbx
   dC3lna5UIVpR0IViUm3rRlRxDVuMukRSipU9PwTPOubzjDowZpz3GOD1R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="355158640"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="355158640"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 08:45:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="846124438"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="846124438"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 Jul 2023 08:45:00 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJyV1-0006in-1g;
        Thu, 13 Jul 2023 15:44:59 +0000
Date:   Thu, 13 Jul 2023 23:44:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        linux-input@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 e3262265625831348cfb3128d35907ead75d8bf7
Message-ID: <202307132315.M00QjCo4-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: e3262265625831348cfb3128d35907ead75d8bf7  Add linux-next specific files for 20230713

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202306260401.qZlYQpV2-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202307131717.LtwApG0z-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/input/touchscreen/iqs7211.c:2464:12: warning: cast to smaller integer type 'enum iqs7211_dev_id' from 'const void *' [-Wvoid-pointer-to-enum-cast]
drivers/mfd/max77541.c:176:18: warning: cast to smaller integer type 'enum max7754x_ids' from 'const void *' [-Wvoid-pointer-to-enum-cast]

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/char/tpm/tpm_tis_spi_main.c:137 tpm_tis_spi_transfer_half() error: uninitialized symbol 'ret'.
drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c:98 mlx5_devcom_register_device() error: uninitialized symbol 'tmp_dev'.
kernel/trace/trace_functions_graph.c:1012 print_graph_return() warn: bitwise AND condition is false here
kernel/trace/trace_functions_graph.c:726 print_graph_entry_leaf() warn: bitwise AND condition is false here
net/wireless/scan.c:373 cfg80211_gen_new_ie() warn: potential spectre issue 'sub->data' [r]
net/wireless/scan.c:397 cfg80211_gen_new_ie() warn: possible spectre second half.  'ext_id'
{standard input}: Error: local label `"2" (instance number 9 of a fb label)' is not defined

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- csky-randconfig-m031-20230710
|   |-- drivers-char-tpm-tpm_tis_spi_main.c-tpm_tis_spi_transfer_half()-error:uninitialized-symbol-ret-.
|   |-- kernel-trace-trace_functions_graph.c-print_graph_entry_leaf()-warn:bitwise-AND-condition-is-false-here
|   `-- kernel-trace-trace_functions_graph.c-print_graph_return()-warn:bitwise-AND-condition-is-false-here
|-- microblaze-randconfig-m041-20230710
|   |-- drivers-net-ethernet-mellanox-mlx5-core-lib-devcom.c-mlx5_devcom_register_device()-error:uninitialized-symbol-tmp_dev-.
|   |-- net-wireless-scan.c-cfg80211_gen_new_ie()-warn:possible-spectre-second-half.-ext_id
|   `-- net-wireless-scan.c-cfg80211_gen_new_ie()-warn:potential-spectre-issue-sub-data-r
`-- sh-allmodconfig
    `-- standard-input:Error:local-label-(instance-number-of-a-fb-label)-is-not-defined
clang_recent_errors
|-- arm64-allmodconfig
|   `-- drivers-input-touchscreen-iqs7211.c:warning:cast-to-smaller-integer-type-enum-iqs7211_dev_id-from-const-void
|-- arm64-randconfig-r036-20230713
|   `-- drivers-mfd-max77541.c:warning:cast-to-smaller-integer-type-enum-max7754x_ids-from-const-void
`-- powerpc-randconfig-r003-20230713
    `-- clang:error:unsupported-option-fsanitize-thread-for-target-powerpc-unknown-linux-gnu

elapsed time: 726m

configs tested: 139
configs skipped: 2

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r024-20230712   gcc  
arc                  randconfig-r043-20230713   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm                         at91_dt_defconfig   gcc  
arm                                 defconfig   gcc  
arm                            dove_defconfig   clang
arm                           h3600_defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                  randconfig-r004-20230713   gcc  
arm                  randconfig-r022-20230712   gcc  
arm                  randconfig-r046-20230713   clang
arm                             rpc_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r034-20230713   clang
arm64                randconfig-r036-20230713   clang
csky                                defconfig   gcc  
csky                 randconfig-r013-20230713   gcc  
csky                 randconfig-r026-20230712   gcc  
hexagon              randconfig-r041-20230713   clang
hexagon              randconfig-r045-20230713   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230712   gcc  
i386         buildonly-randconfig-r005-20230712   gcc  
i386         buildonly-randconfig-r006-20230712   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230713   clang
i386                 randconfig-i002-20230713   clang
i386                 randconfig-i003-20230713   clang
i386                 randconfig-i004-20230713   clang
i386                 randconfig-i005-20230713   clang
i386                 randconfig-i006-20230713   clang
i386                 randconfig-i011-20230713   gcc  
i386                 randconfig-i012-20230713   gcc  
i386                 randconfig-i013-20230713   gcc  
i386                 randconfig-i014-20230713   gcc  
i386                 randconfig-i015-20230713   gcc  
i386                 randconfig-i016-20230713   gcc  
i386                 randconfig-r002-20230713   clang
i386                 randconfig-r021-20230712   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                 randconfig-r023-20230712   gcc  
microblaze           randconfig-r012-20230713   gcc  
microblaze           randconfig-r015-20230713   gcc  
microblaze           randconfig-r031-20230713   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                           ip28_defconfig   clang
mips                           rs90_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230713   gcc  
nios2                randconfig-r035-20230713   gcc  
openrisc             randconfig-r006-20230713   gcc  
openrisc             randconfig-r032-20230713   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230713   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    amigaone_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                       ebony_defconfig   clang
powerpc                       holly_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc                   microwatt_defconfig   clang
powerpc                      pmac32_defconfig   clang
powerpc                     ppa8548_defconfig   clang
powerpc                      ppc6xx_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc              randconfig-r003-20230713   clang
powerpc                    sam440ep_defconfig   gcc  
powerpc                     skiroot_defconfig   clang
powerpc                     tqm5200_defconfig   clang
powerpc                      tqm8xx_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230713   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r025-20230712   clang
s390                 randconfig-r033-20230713   clang
s390                 randconfig-r044-20230713   gcc  
sh                               allmodconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                   randconfig-r014-20230713   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r005-20230713   gcc  
um                               alldefconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230712   gcc  
x86_64       buildonly-randconfig-r002-20230712   gcc  
x86_64       buildonly-randconfig-r003-20230712   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230712   clang
x86_64               randconfig-x002-20230712   clang
x86_64               randconfig-x003-20230712   clang
x86_64               randconfig-x004-20230712   clang
x86_64               randconfig-x005-20230712   clang
x86_64               randconfig-x006-20230712   clang
x86_64               randconfig-x011-20230712   gcc  
x86_64               randconfig-x012-20230712   gcc  
x86_64               randconfig-x013-20230712   gcc  
x86_64               randconfig-x014-20230712   gcc  
x86_64               randconfig-x015-20230712   gcc  
x86_64               randconfig-x016-20230712   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r016-20230713   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
