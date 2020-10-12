Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D7A28B436
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 13:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388332AbgJLL4e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 07:56:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:4582 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388255AbgJLL4e (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Oct 2020 07:56:34 -0400
IronPort-SDR: CfLrJreojv1k7UCIn2Y4liLTgZEwN07yh6fpDHKJdfRlklC5dsrZj0auRLutm4bQT+F88+isd9
 hZASx1jm6jlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="165784037"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="165784037"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 04:56:33 -0700
IronPort-SDR: dBAmn626Of+FsirTD9GVyFWIdVtUWcnRLu8hFha16gHWRJaMIMUaaefHBOccSSnUfwT/lTJ9QM
 ZqwrZFpkFWxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="520670701"
Received: from lkp-server02.sh.intel.com (HELO c41e9df04563) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 12 Oct 2020 04:56:32 -0700
Received: from kbuild by c41e9df04563 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kRwRL-00006n-Gw; Mon, 12 Oct 2020 11:56:31 +0000
Date:   Mon, 12 Oct 2020 19:56:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 1c39c16d64bc203655e780693929ab38d6139fc2
Message-ID: <5f84445e.58pH8cbrX/OicnIo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  for-next
branch HEAD: 1c39c16d64bc203655e780693929ab38d6139fc2  Merge branch 'dynamic_sg' into rdma.git for-next

elapsed time: 732m

configs tested: 141
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         cm_x300_defconfig
powerpc                      pasemi_defconfig
powerpc                 mpc832x_rdb_defconfig
m68k                        m5272c3_defconfig
ia64                      gensparse_defconfig
mips                         cobalt_defconfig
powerpc                     tqm8541_defconfig
mips                        jmr3927_defconfig
m68k                       bvme6000_defconfig
arc                             nps_defconfig
arm                          tango4_defconfig
mips                      maltasmvp_defconfig
i386                             allyesconfig
sh                           se7206_defconfig
powerpc                     tqm5200_defconfig
mips                         bigsur_defconfig
mips                       bmips_be_defconfig
um                            kunit_defconfig
arm                             pxa_defconfig
i386                             alldefconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     tqm8555_defconfig
mips                       rbtx49xx_defconfig
mips                            ar7_defconfig
arm                           u8500_defconfig
arm                       versatile_defconfig
powerpc64                        alldefconfig
arm                           stm32_defconfig
xtensa                    smp_lx200_defconfig
x86_64                           alldefconfig
arm                            xcep_defconfig
xtensa                              defconfig
riscv                    nommu_virt_defconfig
powerpc                      katmai_defconfig
sh                            hp6xx_defconfig
powerpc                     kmeter1_defconfig
xtensa                  cadence_csp_defconfig
sparc                            allyesconfig
riscv                    nommu_k210_defconfig
sh                          rsk7269_defconfig
riscv                            allmodconfig
s390                                defconfig
arc                           tb10x_defconfig
sh                        sh7785lcr_defconfig
arm                         orion5x_defconfig
arm                        multi_v7_defconfig
arm                      jornada720_defconfig
arc                      axs103_smp_defconfig
powerpc                 linkstation_defconfig
mips                    maltaup_xpa_defconfig
i386                                defconfig
arc                     nsimosci_hs_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                           sh2007_defconfig
arm                          imote2_defconfig
sh                         ap325rxa_defconfig
powerpc                      mgcoge_defconfig
mips                      pic32mzda_defconfig
arm                         s5pv210_defconfig
mips                  decstation_64_defconfig
powerpc                     ppa8548_defconfig
arm                         ebsa110_defconfig
arm                        vexpress_defconfig
arm                          badge4_defconfig
mips                          ath79_defconfig
arc                     haps_hs_smp_defconfig
mips                malta_qemu_32r6_defconfig
mips                   sb1250_swarm_defconfig
mips                        omega2p_defconfig
c6x                         dsk6455_defconfig
arm                         lubbock_defconfig
arm                       multi_v4t_defconfig
powerpc                 mpc837x_mds_defconfig
sh                         ecovec24_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
parisc                           allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20201012
i386                 randconfig-a006-20201012
i386                 randconfig-a001-20201012
i386                 randconfig-a003-20201012
i386                 randconfig-a004-20201012
i386                 randconfig-a002-20201012
x86_64               randconfig-a012-20201012
x86_64               randconfig-a013-20201012
x86_64               randconfig-a011-20201012
x86_64               randconfig-a016-20201012
x86_64               randconfig-a015-20201012
x86_64               randconfig-a014-20201012
i386                 randconfig-a016-20201012
i386                 randconfig-a015-20201012
i386                 randconfig-a013-20201012
i386                 randconfig-a012-20201012
i386                 randconfig-a011-20201012
i386                 randconfig-a014-20201012
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201012
x86_64               randconfig-a006-20201012
x86_64               randconfig-a005-20201012
x86_64               randconfig-a002-20201012
x86_64               randconfig-a001-20201012
x86_64               randconfig-a003-20201012

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
