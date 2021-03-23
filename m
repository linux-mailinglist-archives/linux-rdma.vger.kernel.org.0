Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEF6345512
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Mar 2021 02:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhCWBqD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 21:46:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:62348 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231285AbhCWBpw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Mar 2021 21:45:52 -0400
IronPort-SDR: qqdzwfKt2K6/jTT0pdXE/xettb8FE1MCSTHsd9ASPmGdrznxLSw3YpbcJVXt3cN3VcS2ShXrcV
 O1RyJtT8ZN0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="254381047"
X-IronPort-AV: E=Sophos;i="5.81,270,1610438400"; 
   d="scan'208";a="254381047"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 18:45:51 -0700
IronPort-SDR: oje/K/1Chz2U3QRkRVma/m0Kr8qlMzsW/WNlbcUDASurgv3CllZTub2ianx9JCjBSX2gEaAjB7
 TcF4sr0MMrhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,270,1610438400"; 
   d="scan'208";a="513514913"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Mar 2021 18:45:50 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lOW7B-0000J0-MP; Tue, 23 Mar 2021 01:45:49 +0000
Date:   Tue, 23 Mar 2021 09:45:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 af06b628a6bde8506bbad32dbf7cc641c0176ad7
Message-ID: <60594834.+scxEbQTpnTXC/Ax%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: af06b628a6bde8506bbad32dbf7cc641c0176ad7  RDMA/hns: Fix bug during CMDQ initialization

elapsed time: 723m

configs tested: 148
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
m68k                       m5208evb_defconfig
arc                         haps_hs_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                      katmai_defconfig
sh                                  defconfig
sh                          urquell_defconfig
xtensa                    xip_kc705_defconfig
m68k                        m5407c3_defconfig
sh                        sh7757lcr_defconfig
mips                           ip27_defconfig
riscv                    nommu_virt_defconfig
arc                              alldefconfig
arc                          axs103_defconfig
powerpc                     powernv_defconfig
sh                           se7712_defconfig
arm                         lubbock_defconfig
sparc64                          alldefconfig
powerpc                      ppc44x_defconfig
mips                      maltaaprp_defconfig
powerpc                   motionpro_defconfig
powerpc                      chrp32_defconfig
arm                          moxart_defconfig
arm                  colibri_pxa270_defconfig
arm                         s3c2410_defconfig
arm                          ixp4xx_defconfig
mips                           ip28_defconfig
arm                             mxs_defconfig
riscv                            alldefconfig
sh                        edosk7705_defconfig
arm                     eseries_pxa_defconfig
sh                               alldefconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     ep8248e_defconfig
mips                       lemote2f_defconfig
sh                     magicpanelr2_defconfig
mips                  decstation_64_defconfig
openrisc                 simple_smp_defconfig
powerpc                    sam440ep_defconfig
m68k                          hp300_defconfig
powerpc                   bluestone_defconfig
m68k                       m5275evb_defconfig
powerpc                     akebono_defconfig
powerpc                     redwood_defconfig
arm                            lart_defconfig
arm                         palmz72_defconfig
arm                        mvebu_v7_defconfig
sh                           se7780_defconfig
powerpc                 mpc837x_mds_defconfig
arm                          simpad_defconfig
powerpc                 mpc836x_rdk_defconfig
openrisc                         alldefconfig
m68k                       m5249evb_defconfig
mips                        maltaup_defconfig
arm                           omap1_defconfig
i386                                defconfig
arm                       imx_v4_v5_defconfig
arm                         at91_dt_defconfig
mips                        jmr3927_defconfig
powerpc                         wii_defconfig
riscv                               defconfig
arm                  colibri_pxa300_defconfig
mips                           jazz_defconfig
powerpc                     mpc83xx_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                 mpc8272_ads_defconfig
mips                            gpr_defconfig
sh                           se7619_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                           se7724_defconfig
arm                             ezx_defconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210322
i386                 randconfig-a003-20210322
i386                 randconfig-a001-20210322
i386                 randconfig-a002-20210322
i386                 randconfig-a006-20210322
i386                 randconfig-a005-20210322
i386                 randconfig-a003-20210323
i386                 randconfig-a004-20210323
i386                 randconfig-a001-20210323
i386                 randconfig-a002-20210323
i386                 randconfig-a006-20210323
i386                 randconfig-a005-20210323
x86_64               randconfig-a012-20210322
x86_64               randconfig-a015-20210322
x86_64               randconfig-a013-20210322
x86_64               randconfig-a014-20210322
x86_64               randconfig-a016-20210322
x86_64               randconfig-a011-20210322
i386                 randconfig-a014-20210322
i386                 randconfig-a011-20210322
i386                 randconfig-a015-20210322
i386                 randconfig-a016-20210322
i386                 randconfig-a012-20210322
i386                 randconfig-a013-20210322
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210322
x86_64               randconfig-a003-20210322
x86_64               randconfig-a001-20210322
x86_64               randconfig-a006-20210322
x86_64               randconfig-a004-20210322
x86_64               randconfig-a005-20210322

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
