Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3DE4DE731
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Mar 2022 10:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbiCSJTj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Mar 2022 05:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiCSJTi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Mar 2022 05:19:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A139112E178
        for <linux-rdma@vger.kernel.org>; Sat, 19 Mar 2022 02:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647681497; x=1679217497;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=gguxSjewdctigpUiWV00X1EwO1ebu4wfbj8QzAZC78I=;
  b=kjnCfdDNUO9xiP4HJnwycSCHLkpdwS6PrcTEQyc7oXFMVRPUjVqK2J5g
   kJdcYIgSOzPIxxOvNCDRLuH6X9p/O0K2g/SM+TIXmo0HT6tYalkM0vrrL
   sm8SFXLmwdHUlrF4iZuavr2wdyW8mswlK0uRkHPlS6T8JNjACJfZh7SHH
   lJownaXlzOb68MkEwZWGlVnW8+b73jHuPkmYycpTAIn/Cpq+6urcB4i5G
   lmWAkK7Ab59MFn6gUJNLWjZwTxwIehavoxwutVCq39oe0I/bl/QCMLb4H
   8qfnepiLjudNJlpw3mwhKZTi+Z90zhuQOLayXdR915ZITizpsNNyZYiYh
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="257011050"
X-IronPort-AV: E=Sophos;i="5.90,194,1643702400"; 
   d="scan'208";a="257011050"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 02:18:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,194,1643702400"; 
   d="scan'208";a="647846461"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 19 Mar 2022 02:18:15 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVVDy-000Fp4-Kf; Sat, 19 Mar 2022 09:18:14 +0000
Date:   Sat, 19 Mar 2022 17:18:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 87e0eacb176f9500c2063d140c0a1d7fa51ab8a5
Message-ID: <62359fd1.PqY0NiROHTVrldal%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 87e0eacb176f9500c2063d140c0a1d7fa51ab8a5  RDMA/nldev: Prevent underflow in nldev_stat_set_counter_dynamic_doit()

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
arc                         haps_hs_defconfig
m68k                       m5249evb_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                      ppc6xx_defconfig
arm64                            alldefconfig
arm                            xcep_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                         ap325rxa_defconfig
sh                             espt_defconfig
mips                       capcella_defconfig
arm                      footbridge_defconfig
m68k                          multi_defconfig
csky                             alldefconfig
arm                        mini2440_defconfig
arm                        mvebu_v7_defconfig
arm                        multi_v7_defconfig
mips                         rt305x_defconfig
ia64                        generic_defconfig
arm                        keystone_defconfig
xtensa                           alldefconfig
arm                            hisi_defconfig
arm                          lpd270_defconfig
parisc                           allyesconfig
mips                     decstation_defconfig
sh                              ul2_defconfig
m68k                             allyesconfig
arc                                 defconfig
m68k                        m5307c3_defconfig
mips                         mpc30x_defconfig
m68k                           sun3_defconfig
sh                        edosk7705_defconfig
powerpc                   motionpro_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                           sh2007_defconfig
powerpc                        cell_defconfig
ia64                             alldefconfig
arm                           corgi_defconfig
ia64                          tiger_defconfig
powerpc                  storcenter_defconfig
powerpc                       maple_defconfig
powerpc                     ep8248e_defconfig
sh                           se7343_defconfig
mips                         tb0226_defconfig
sh                           se7619_defconfig
m68k                       m5208evb_defconfig
arc                           tb10x_defconfig
powerpc64                        alldefconfig
alpha                            alldefconfig
arm                             rpc_defconfig
arm                        trizeps4_defconfig
alpha                               defconfig
mips                      maltasmvp_defconfig
powerpc                 mpc8540_ads_defconfig
sh                           se7705_defconfig
openrisc                         alldefconfig
sh                          sdk7780_defconfig
powerpc                      bamboo_defconfig
arm                         lubbock_defconfig
arc                          axs101_defconfig
arm                             pxa_defconfig
mips                  maltasmvp_eva_defconfig
arm                        realview_defconfig
m68k                            mac_defconfig
sh                            hp6xx_defconfig
arm                  randconfig-c002-20220318
arm                  randconfig-c002-20220317
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
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
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220318
arm                  randconfig-c002-20220317
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220318
riscv                randconfig-c006-20220318
riscv                randconfig-c006-20220317
powerpc              randconfig-c003-20220317
mips                 randconfig-c004-20220317
mips                 randconfig-c004-20220318
i386                          randconfig-c001
mips                        qi_lb60_defconfig
hexagon                          alldefconfig
powerpc                     tqm8540_defconfig
mips                           ip22_defconfig
powerpc                        icon_defconfig
i386                             allyesconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220318
hexagon              randconfig-r045-20220317
hexagon              randconfig-r041-20220318
riscv                randconfig-r042-20220318
hexagon              randconfig-r041-20220317
s390                 randconfig-r044-20220318

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
