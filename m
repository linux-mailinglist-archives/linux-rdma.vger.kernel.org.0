Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C75A2815F8
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 17:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388202AbgJBPCe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Oct 2020 11:02:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:51701 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388016AbgJBPCe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 2 Oct 2020 11:02:34 -0400
IronPort-SDR: BfLbdnXuJDvtKZYh8BG0kpFWfzdyBk7ljTtACIwkjF3ui8GaFeZQo8HdFsIWyhuX0Bmm8ZMFye
 otPXFKnvGqLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="160333894"
X-IronPort-AV: E=Sophos;i="5.77,328,1596524400"; 
   d="scan'208";a="160333894"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 08:02:30 -0700
IronPort-SDR: UDWClAzasAiT1bNCKsaGlmFtJQuYQJ1jLy1EcugpUi88Ie/sd/bb5KFbKFmAeziEuJNt5WWEsI
 chyxht1FeVNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,328,1596524400"; 
   d="scan'208";a="309052245"
Received: from lkp-server02.sh.intel.com (HELO 404f47266ee4) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 02 Oct 2020 08:02:28 -0700
Received: from kbuild by 404f47266ee4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kOMZo-00000w-5n; Fri, 02 Oct 2020 15:02:28 +0000
Date:   Fri, 02 Oct 2020 23:02:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 9f85cbe50aa044a46f0a22fda323fa27b80c82da
Message-ID: <5f7740f0.B7jsGHFkuICfkASZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 9f85cbe50aa044a46f0a22fda323fa27b80c82da  RDMA/uverbs: Expose the new GID query API to user space

elapsed time: 847m

configs tested: 188
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         tb0287_defconfig
arm                        shmobile_defconfig
xtensa                    smp_lx200_defconfig
arm                         lubbock_defconfig
arm                       spear13xx_defconfig
powerpc                          allyesconfig
um                           x86_64_defconfig
mips                           mtx1_defconfig
powerpc                       holly_defconfig
arm                          gemini_defconfig
mips                malta_qemu_32r6_defconfig
mips                          malta_defconfig
riscv                             allnoconfig
arm                              alldefconfig
powerpc                        warp_defconfig
powerpc                         wii_defconfig
mips                        nlm_xlr_defconfig
mips                       lemote2f_defconfig
riscv                    nommu_k210_defconfig
sh                          rsk7203_defconfig
powerpc                     rainier_defconfig
mips                malta_kvm_guest_defconfig
sh                           se7724_defconfig
arm                     am200epdkit_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                    ge_imp3a_defconfig
sh                          polaris_defconfig
m68k                          atari_defconfig
mips                          ath79_defconfig
xtensa                  cadence_csp_defconfig
s390                       zfcpdump_defconfig
m68k                        m5307c3_defconfig
um                             i386_defconfig
arm                       multi_v4t_defconfig
sh                        dreamcast_defconfig
arm                         bcm2835_defconfig
powerpc                          g5_defconfig
arm                         vf610m4_defconfig
sh                           se7343_defconfig
powerpc                           allnoconfig
mips                         tb0219_defconfig
nds32                             allnoconfig
powerpc                    klondike_defconfig
microblaze                          defconfig
mips                 decstation_r4k_defconfig
arm                          lpd270_defconfig
xtensa                generic_kc705_defconfig
alpha                            alldefconfig
powerpc                    mvme5100_defconfig
sh                            titan_defconfig
powerpc                     mpc512x_defconfig
riscv                               defconfig
arm                           h3600_defconfig
sparc64                          alldefconfig
arm                        cerfcube_defconfig
powerpc                       ppc64_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     taishan_defconfig
arm                           spitz_defconfig
h8300                               defconfig
sh                   sh7770_generic_defconfig
sparc                       sparc32_defconfig
mips                          ath25_defconfig
powerpc                         ps3_defconfig
powerpc                       ebony_defconfig
arm                         palmz72_defconfig
powerpc                      acadia_defconfig
h8300                            alldefconfig
arc                          axs101_defconfig
sh                ecovec24-romimage_defconfig
alpha                               defconfig
powerpc                      ppc40x_defconfig
mips                     decstation_defconfig
m68k                             allmodconfig
arm                             rpc_defconfig
arc                     nsimosci_hs_defconfig
arm                           efm32_defconfig
arm                   milbeaut_m10v_defconfig
arm                           viper_defconfig
powerpc                     akebono_defconfig
arm                            zeus_defconfig
arm                         socfpga_defconfig
nios2                         10m50_defconfig
mips                            ar7_defconfig
arm                  colibri_pxa300_defconfig
arm                           sama5_defconfig
arm                           h5000_defconfig
sh                           se7780_defconfig
arm                       imx_v4_v5_defconfig
powerpc                 mpc8313_rdb_defconfig
m68k                       m5249evb_defconfig
m68k                       bvme6000_defconfig
arm                          imote2_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     mpc5200_defconfig
powerpc                      pcm030_defconfig
powerpc                       eiger_defconfig
c6x                        evmc6678_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
x86_64               randconfig-a004-20201002
x86_64               randconfig-a001-20201002
x86_64               randconfig-a002-20201002
x86_64               randconfig-a005-20201002
x86_64               randconfig-a003-20201002
x86_64               randconfig-a006-20201002
i386                 randconfig-a003-20200930
i386                 randconfig-a002-20200930
i386                 randconfig-a006-20200930
i386                 randconfig-a005-20200930
i386                 randconfig-a004-20200930
i386                 randconfig-a001-20200930
i386                 randconfig-a006-20201002
i386                 randconfig-a005-20201002
i386                 randconfig-a001-20201002
i386                 randconfig-a004-20201002
i386                 randconfig-a003-20201002
i386                 randconfig-a002-20201002
x86_64               randconfig-a015-20200930
x86_64               randconfig-a013-20200930
x86_64               randconfig-a012-20200930
x86_64               randconfig-a016-20200930
x86_64               randconfig-a014-20200930
x86_64               randconfig-a011-20200930
i386                 randconfig-a014-20201002
i386                 randconfig-a013-20201002
i386                 randconfig-a015-20201002
i386                 randconfig-a016-20201002
i386                 randconfig-a011-20201002
i386                 randconfig-a012-20201002
i386                 randconfig-a011-20200930
i386                 randconfig-a015-20200930
i386                 randconfig-a012-20200930
i386                 randconfig-a014-20200930
i386                 randconfig-a016-20200930
i386                 randconfig-a013-20200930
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20200930
x86_64               randconfig-a005-20200930
x86_64               randconfig-a003-20200930
x86_64               randconfig-a004-20200930
x86_64               randconfig-a002-20200930
x86_64               randconfig-a006-20200930
x86_64               randconfig-a012-20201002
x86_64               randconfig-a015-20201002
x86_64               randconfig-a014-20201002
x86_64               randconfig-a013-20201002
x86_64               randconfig-a011-20201002
x86_64               randconfig-a016-20201002

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
