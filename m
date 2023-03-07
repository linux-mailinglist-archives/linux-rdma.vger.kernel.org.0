Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EB16AE3FB
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Mar 2023 16:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCGPKn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Mar 2023 10:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjCGPKP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Mar 2023 10:10:15 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC19A84F46;
        Tue,  7 Mar 2023 07:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678201470; x=1709737470;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dD7/vAAn4YW8k4L1ZL28fs42vlmmEZEdoamXsQ8zEOM=;
  b=k/pRx9CfI1wgM9bHjlLPEvRIbqIX+6C33XVo8wOlZ2vr5XM7CFrLmJlc
   /6IcSeLUzIfIbNSl9Cjg4a7rCe+OCz/O7xUCA0KfT9x4J+OZJCRlGaPHy
   nnGds8Yz3QEsljOkcWSUd9Ojd9Vmmc47/bj3kNjULFu4eUEnsk6MlfysO
   mYrvyFu7WGUM7Xf4BsR0Fu8jE4ryMTtk4BHmwrGukrCdz0kDZW1dNIjzQ
   XY9sA5RnNTopua9WembRhgPplmcLwZ2BH276bBFGtPH8GY9JmURJW1Fz8
   53SYJ9VtadG1IreBkMhdgoqA7GFzsVJZZkKnfaLtVvP55/c1w0Wg/rNUL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="319698799"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="319698799"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 07:03:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="676590732"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="676590732"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 07 Mar 2023 07:03:09 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZYqL-0001PX-0K;
        Tue, 07 Mar 2023 15:03:09 +0000
Date:   Tue, 07 Mar 2023 23:02:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-watchdog@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD SUCCESS WITH WARNING
 709c6adf19dc558e44ab5c01659b09a16a2d3c82
Message-ID: <64075221.UqJaC4j/w2D0ATu0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 709c6adf19dc558e44ab5c01659b09a16a2d3c82  Add linux-next specific files for 20230307

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202302111601.jtY4lKrA-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303071444.sIbZTDCy-lkp@intel.com

Warning: (recently discovered and may have been fixed)

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.c:294:6: warning: no previous prototype for 'optc3_wait_drr_doublebuffer_pending_clear' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:1600:5: warning: no previous prototype for function 'vangogh_set_apu_thermal_limit' [-Wmissing-prototypes]
drivers/infiniband/ulp/srp/ib_srp.c:66: warning: "DEFINE_DYNAMIC_DEBUG_METADATA" redefined
drivers/infiniband/ulp/srp/ib_srp.c:67: warning: "DYNAMIC_DEBUG_BRANCH" redefined

Unverified Warning (likely false positive, please contact us if interested):

drivers/tty/serial/8250/8250_dfl.c:63 dfl_uart_get_params() error: uninitialized symbol 'clk_freq'.
drivers/tty/serial/8250/8250_dfl.c:69 dfl_uart_get_params() error: uninitialized symbol 'fifo_len'.
drivers/tty/serial/8250/8250_dfl.c:90 dfl_uart_get_params() error: uninitialized symbol 'reg_layout'.
drivers/usb/gadget/composite.c:2082:33: sparse: sparse: restricted __le16 degrades to integer
drivers/watchdog/imx2_wdt.c:442:22: sparse: sparse: symbol 'imx_wdt' was not declared. Should it be static?
drivers/watchdog/imx2_wdt.c:446:22: sparse: sparse: symbol 'imx_wdt_legacy' was not declared. Should it be static?

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-randconfig-r011-20230305
|   |-- drivers-infiniband-ulp-srp-ib_srp.c:warning:DEFINE_DYNAMIC_DEBUG_METADATA-redefined
|   `-- drivers-infiniband-ulp-srp-ib_srp.c:warning:DYNAMIC_DEBUG_BRANCH-redefined
|-- arm64-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dcn30-dcn30_optc.c:warning:no-previous-prototype-for-optc3_wait_drr_doublebuffer_pending_clear
|-- csky-randconfig-m031-20230305
|   |-- drivers-tty-serial-8250_dfl.c-dfl_uart_get_params()-error:uninitialized-symbol-clk_freq-.
|   |-- drivers-tty-serial-8250_dfl.c-dfl_uart_get_params()-error:uninitialized-symbol-fifo_len-.
|   `-- drivers-tty-serial-8250_dfl.c-dfl_uart_get_params()-error:uninitialized-symbol-reg_layout-.
|-- csky-randconfig-s031-20230305
|   |-- drivers-usb-gadget-composite.c:sparse:sparse:restricted-__le16-degrades-to-integer
|   |-- drivers-watchdog-imx2_wdt.c:sparse:sparse:symbol-imx_wdt-was-not-declared.-Should-it-be-static
|   `-- drivers-watchdog-imx2_wdt.c:sparse:sparse:symbol-imx_wdt_legacy-was-not-declared.-Should-it-be-static
|-- i386-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dcn30-dcn30_optc.c:warning:no-previous-prototype-for-optc3_wait_drr_doublebuffer_pending_clear
|-- i386-randconfig-s001
|   `-- drivers-usb-gadget-composite.c:sparse:sparse:restricted-__le16-degrades-to-integer
|-- i386-randconfig-s003
|   `-- drivers-usb-gadget-composite.c:sparse:sparse:restricted-__le16-degrades-to-integer
|-- ia64-randconfig-s043-20230305
|   `-- drivers-usb-gadget-composite.c:sparse:sparse:restricted-__le16-degrades-to-integer
|-- sparc-randconfig-s032-20230305
|   |-- drivers-watchdog-imx2_wdt.c:sparse:sparse:symbol-imx_wdt-was-not-declared.-Should-it-be-static
|   `-- drivers-watchdog-imx2_wdt.c:sparse:sparse:symbol-imx_wdt_legacy-was-not-declared.-Should-it-be-static
|-- sparc-randconfig-s042-20230305
|   `-- drivers-usb-gadget-composite.c:sparse:sparse:restricted-__le16-degrades-to-integer
|-- sparc64-randconfig-s041-20230305
|   |-- drivers-usb-gadget-composite.c:sparse:sparse:restricted-__le16-degrades-to-integer
|   |-- drivers-watchdog-imx2_wdt.c:sparse:sparse:symbol-imx_wdt-was-not-declared.-Should-it-be-static
|   `-- drivers-watchdog-imx2_wdt.c:sparse:sparse:symbol-imx_wdt_legacy-was-not-declared.-Should-it-be-static
|-- x86_64-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dcn30-dcn30_optc.c:warning:no-previous-prototype-for-optc3_wait_drr_doublebuffer_pending_clear
`-- x86_64-randconfig-s021
    `-- drivers-usb-gadget-composite.c:sparse:sparse:restricted-__le16-degrades-to-integer
clang_recent_errors
`-- arm-randconfig-r025-20230305
    `-- drivers-gpu-drm-amd-amdgpu-..-pm-swsmu-smu11-vangogh_ppt.c:warning:no-previous-prototype-for-function-vangogh_set_apu_thermal_limit

elapsed time: 729m

configs tested: 154
configs skipped: 13

tested configs:
alpha                            alldefconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r034-20230306   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r005-20230306   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230306   gcc  
arc                  randconfig-r011-20230305   gcc  
arc                  randconfig-r014-20230305   gcc  
arc                  randconfig-r035-20230305   gcc  
arc                  randconfig-r043-20230305   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         bcm2835_defconfig   clang
arm                          collie_defconfig   clang
arm                                 defconfig   gcc  
arm                      footbridge_defconfig   gcc  
arm                  randconfig-r006-20230305   gcc  
arm                  randconfig-r025-20230305   clang
arm                  randconfig-r046-20230305   clang
arm                         socfpga_defconfig   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230305   clang
arm64        buildonly-randconfig-r006-20230305   clang
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230306   gcc  
arm64                randconfig-r004-20230305   clang
arm64                randconfig-r012-20230306   clang
arm64                randconfig-r015-20230305   gcc  
csky                                defconfig   gcc  
hexagon      buildonly-randconfig-r003-20230305   clang
hexagon              randconfig-r041-20230305   clang
hexagon              randconfig-r045-20230305   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230306   gcc  
i386                 randconfig-a002-20230306   gcc  
i386                 randconfig-a003-20230306   gcc  
i386                 randconfig-a004-20230306   gcc  
i386                 randconfig-a005-20230306   gcc  
i386                 randconfig-a006-20230306   gcc  
i386                 randconfig-a011-20230306   clang
i386                 randconfig-a012-20230306   clang
i386                 randconfig-a013-20230306   clang
i386                 randconfig-a014-20230306   clang
i386                 randconfig-a015-20230306   clang
i386                 randconfig-a016-20230306   clang
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r005-20230305   gcc  
ia64                 randconfig-r005-20230306   gcc  
ia64                 randconfig-r013-20230305   gcc  
ia64                 randconfig-r033-20230306   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230305   gcc  
loongarch                           defconfig   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze   buildonly-randconfig-r004-20230305   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                           ip22_defconfig   clang
mips                          malta_defconfig   clang
mips                        qi_lb60_defconfig   clang
mips                 randconfig-r026-20230305   clang
nios2                               defconfig   gcc  
nios2                randconfig-r022-20230305   gcc  
nios2                randconfig-r031-20230305   gcc  
openrisc     buildonly-randconfig-r002-20230306   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r016-20230306   gcc  
parisc               randconfig-r032-20230305   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc                        icon_defconfig   clang
powerpc                 mpc836x_rdk_defconfig   clang
powerpc                     mpc83xx_defconfig   gcc  
powerpc                 mpc8540_ads_defconfig   gcc  
powerpc              randconfig-r014-20230306   clang
powerpc              randconfig-r016-20230305   gcc  
powerpc              randconfig-r024-20230305   gcc  
powerpc              randconfig-r026-20230306   clang
powerpc              randconfig-r035-20230306   gcc  
powerpc                  storcenter_defconfig   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc                     tqm8555_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230305   clang
riscv                randconfig-r042-20230305   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r005-20230305   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230306   gcc  
s390                 randconfig-r031-20230306   gcc  
s390                 randconfig-r032-20230306   gcc  
s390                 randconfig-r044-20230305   gcc  
sh                               allmodconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                   randconfig-r006-20230306   gcc  
sh                   randconfig-r023-20230305   gcc  
sh                           se7750_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230306   gcc  
sparc                randconfig-r023-20230306   gcc  
sparc                randconfig-r034-20230305   gcc  
sparc                randconfig-r036-20230305   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r003-20230306   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230306   gcc  
x86_64               randconfig-a002-20230306   gcc  
x86_64               randconfig-a003-20230306   gcc  
x86_64               randconfig-a004-20230306   gcc  
x86_64               randconfig-a005-20230306   gcc  
x86_64               randconfig-a006-20230306   gcc  
x86_64               randconfig-a011-20230306   clang
x86_64               randconfig-a012-20230306   clang
x86_64               randconfig-a013-20230306   clang
x86_64               randconfig-a014-20230306   clang
x86_64               randconfig-a015-20230306   clang
x86_64               randconfig-a016-20230306   clang
x86_64               randconfig-r022-20230306   clang
x86_64               randconfig-r025-20230306   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230306   gcc  
xtensa               randconfig-r002-20230305   gcc  
xtensa               randconfig-r011-20230306   gcc  
xtensa               randconfig-r021-20230305   gcc  
xtensa               randconfig-r024-20230306   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
