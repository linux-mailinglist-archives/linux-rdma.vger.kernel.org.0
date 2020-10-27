Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1840429AAFA
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Oct 2020 12:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411832AbgJ0Lfp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Oct 2020 07:35:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:64047 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411843AbgJ0Lfp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Oct 2020 07:35:45 -0400
IronPort-SDR: JNbvH2DwgTrV3au26POP9f9dNZyG02Oeq/nem9PwZCgtdzAfB0kqvbrd8icMk1fax3wJa7saH2
 yV7ZSjgFAxIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="185804787"
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="185804787"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 04:35:44 -0700
IronPort-SDR: pCgMH1uSLsTXhN8X8Getm1rvbGNE/8uzbY5n//0n9v3v20nvt0Ny18CSYJsUeO1wOv+VYb6XgV
 F+zQO6J+g8Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="350495759"
Received: from lkp-server01.sh.intel.com (HELO ef28dff175aa) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 Oct 2020 04:35:43 -0700
Received: from kbuild by ef28dff175aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kXNGQ-0000DC-Qu; Tue, 27 Oct 2020 11:35:42 +0000
Date:   Tue, 27 Oct 2020 19:35:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 676a80adba0131e1603ef3de5f73a19a0d3d0e65
Message-ID: <5f9805f9.7Rr5EUGTYLhaG8zF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 676a80adba0131e1603ef3de5f73a19a0d3d0e65  RDMA: Remove AH from uverbs_cmd_mask

elapsed time: 735m

configs tested: 139
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         tb0219_defconfig
sh                          landisk_defconfig
arm                             mxs_defconfig
powerpc                       holly_defconfig
ia64                             allyesconfig
arm                          pxa910_defconfig
xtensa                generic_kc705_defconfig
arm                            qcom_defconfig
arm                           h3600_defconfig
arm                           sama5_defconfig
arm                         s3c2410_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                          rsk7269_defconfig
powerpc                      obs600_defconfig
mips                      pic32mzda_defconfig
sh                      rts7751r2d1_defconfig
mips                      malta_kvm_defconfig
arm                         assabet_defconfig
arc                              alldefconfig
sh                           se7343_defconfig
xtensa                         virt_defconfig
powerpc                 linkstation_defconfig
mips                      bmips_stb_defconfig
parisc                generic-32bit_defconfig
arm                      integrator_defconfig
arm                          simpad_defconfig
arm                         shannon_defconfig
arm                         s3c6400_defconfig
sh                            shmin_defconfig
sh                             espt_defconfig
i386                                defconfig
arm                          iop32x_defconfig
xtensa                              defconfig
arm                        multi_v7_defconfig
xtensa                  nommu_kc705_defconfig
i386                             alldefconfig
powerpc                      mgcoge_defconfig
arm                            lart_defconfig
mips                     loongson1c_defconfig
arm                        mvebu_v5_defconfig
ia64                         bigsur_defconfig
arm                          moxart_defconfig
sh                        edosk7760_defconfig
arm                             rpc_defconfig
sh                              ul2_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                          allyesconfig
powerpc                 mpc8313_rdb_defconfig
ia64                        generic_defconfig
m68k                       m5275evb_defconfig
m68k                        m5272c3_defconfig
arm                      footbridge_defconfig
arm                  colibri_pxa270_defconfig
mips                      fuloong2e_defconfig
mips                           mtx1_defconfig
m68k                            mac_defconfig
sh                        dreamcast_defconfig
powerpc                     ppa8548_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     redwood_defconfig
arc                      axs103_smp_defconfig
ia64                                defconfig
m68k                        mvme16x_defconfig
powerpc                      acadia_defconfig
powerpc                     tqm8560_defconfig
arm                           stm32_defconfig
powerpc                    gamecube_defconfig
mips                      pistachio_defconfig
ia64                             allmodconfig
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
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20201026
i386                 randconfig-a003-20201026
i386                 randconfig-a005-20201026
i386                 randconfig-a001-20201026
i386                 randconfig-a006-20201026
i386                 randconfig-a004-20201026
x86_64               randconfig-a011-20201026
x86_64               randconfig-a013-20201026
x86_64               randconfig-a016-20201026
x86_64               randconfig-a015-20201026
x86_64               randconfig-a012-20201026
x86_64               randconfig-a014-20201026
i386                 randconfig-a016-20201026
i386                 randconfig-a015-20201026
i386                 randconfig-a014-20201026
i386                 randconfig-a012-20201026
i386                 randconfig-a013-20201026
i386                 randconfig-a011-20201026
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20201026
x86_64               randconfig-a003-20201026
x86_64               randconfig-a002-20201026
x86_64               randconfig-a006-20201026
x86_64               randconfig-a004-20201026
x86_64               randconfig-a005-20201026

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
