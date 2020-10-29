Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5A129E71F
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 10:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgJ2JVC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Oct 2020 05:21:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:29616 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgJ2JVC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Oct 2020 05:21:02 -0400
IronPort-SDR: /R7A7AdpmKdTH8NVnFIQd20PFLASSlw4Xm7HpB4hrRbr0xrNlzRi9M9N89XI57pzQbM06zl9LG
 6JjOkRZMwdaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="168502100"
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="168502100"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 02:21:00 -0700
IronPort-SDR: ubchoKQl6t3HRtG44DIUl/RGzWvzBHD7YaOpmaYFV4wK1FE0l+7PJFpQaG0IcayFulmDL8nvZa
 aYHU286V53GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="356205241"
Received: from lkp-server01.sh.intel.com (HELO c01187be935a) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 29 Oct 2020 02:20:58 -0700
Received: from kbuild by c01187be935a with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kY478-00001J-9c; Thu, 29 Oct 2020 09:20:58 +0000
Date:   Thu, 29 Oct 2020 17:20:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 3957740ac0c12a6871bacbcf4340a06de327bf37
Message-ID: <5f9a894c.hNsJuJHTyxOdb9MS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 3957740ac0c12a6871bacbcf4340a06de327bf37  RDMA: Convert various random sprintf sysfs _show uses to sysfs_emit

elapsed time: 888m

configs tested: 197
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                        m5307c3_defconfig
c6x                                 defconfig
s390                             allyesconfig
arm                          prima2_defconfig
ia64                          tiger_defconfig
openrisc                         alldefconfig
powerpc                 mpc8272_ads_defconfig
mips                        maltaup_defconfig
sh                           se7721_defconfig
arc                          axs103_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                       aspeed_g5_defconfig
sh                            shmin_defconfig
c6x                              alldefconfig
arm                      integrator_defconfig
arm                          pxa3xx_defconfig
ia64                                defconfig
ia64                        generic_defconfig
mips                          malta_defconfig
sh                          lboxre2_defconfig
mips                           gcw0_defconfig
powerpc                       ebony_defconfig
sh                   sh7770_generic_defconfig
arm                          simpad_defconfig
c6x                              allyesconfig
alpha                            alldefconfig
sh                          r7780mp_defconfig
arm                            lart_defconfig
mips                      bmips_stb_defconfig
arm                        magician_defconfig
m68k                        mvme147_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                              zx_defconfig
c6x                         dsk6455_defconfig
parisc                generic-32bit_defconfig
powerpc                    gamecube_defconfig
powerpc                     mpc5200_defconfig
powerpc                      chrp32_defconfig
arc                     haps_hs_smp_defconfig
m68k                       m5249evb_defconfig
arm                           tegra_defconfig
powerpc                 mpc834x_mds_defconfig
arm                     davinci_all_defconfig
mips                     loongson1b_defconfig
powerpc64                           defconfig
mips                             allyesconfig
sh                           se7343_defconfig
arc                                 defconfig
powerpc                      katmai_defconfig
mips                          rb532_defconfig
sh                             sh03_defconfig
mips                           xway_defconfig
powerpc                  storcenter_defconfig
sh                        dreamcast_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                        edosk7760_defconfig
sh                ecovec24-romimage_defconfig
riscv                            alldefconfig
powerpc                     asp8347_defconfig
powerpc                     mpc512x_defconfig
mips                       capcella_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                     akebono_defconfig
powerpc                      pcm030_defconfig
arm                             ezx_defconfig
powerpc64                        alldefconfig
powerpc                  iss476-smp_defconfig
arm                          imote2_defconfig
powerpc                      walnut_defconfig
mips                     decstation_defconfig
m68k                        m5407c3_defconfig
mips                            gpr_defconfig
mips                      malta_kvm_defconfig
powerpc                 mpc8560_ads_defconfig
arm                        multi_v5_defconfig
arm                         s5pv210_defconfig
arm                          tango4_defconfig
arm                          badge4_defconfig
powerpc                     tqm8540_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                malta_qemu_32r6_defconfig
sh                             espt_defconfig
arm                          ixp4xx_defconfig
um                            kunit_defconfig
m68k                          multi_defconfig
nds32                            alldefconfig
um                           x86_64_defconfig
arm                      tct_hammer_defconfig
mips                       bmips_be_defconfig
arm                           viper_defconfig
powerpc                      pasemi_defconfig
m68k                            q40_defconfig
mips                         db1xxx_defconfig
alpha                            allyesconfig
arm                            zeus_defconfig
sh                          rsk7264_defconfig
powerpc                    klondike_defconfig
riscv                    nommu_virt_defconfig
ia64                      gensparse_defconfig
arm                          pxa168_defconfig
ia64                             allmodconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20201029
x86_64               randconfig-a002-20201029
x86_64               randconfig-a003-20201029
x86_64               randconfig-a006-20201029
x86_64               randconfig-a005-20201029
x86_64               randconfig-a004-20201029
i386                 randconfig-a002-20201026
i386                 randconfig-a003-20201026
i386                 randconfig-a005-20201026
i386                 randconfig-a001-20201026
i386                 randconfig-a006-20201026
i386                 randconfig-a004-20201026
i386                 randconfig-a002-20201029
i386                 randconfig-a005-20201029
i386                 randconfig-a003-20201029
i386                 randconfig-a001-20201029
i386                 randconfig-a004-20201029
i386                 randconfig-a006-20201029
i386                 randconfig-a002-20201028
i386                 randconfig-a005-20201028
i386                 randconfig-a003-20201028
i386                 randconfig-a001-20201028
i386                 randconfig-a004-20201028
i386                 randconfig-a006-20201028
x86_64               randconfig-a011-20201028
x86_64               randconfig-a013-20201028
x86_64               randconfig-a016-20201028
x86_64               randconfig-a015-20201028
x86_64               randconfig-a012-20201028
x86_64               randconfig-a014-20201028
i386                 randconfig-a016-20201028
i386                 randconfig-a014-20201028
i386                 randconfig-a015-20201028
i386                 randconfig-a013-20201028
i386                 randconfig-a012-20201028
i386                 randconfig-a011-20201028
i386                 randconfig-a016-20201029
i386                 randconfig-a014-20201029
i386                 randconfig-a015-20201029
i386                 randconfig-a013-20201029
i386                 randconfig-a012-20201029
i386                 randconfig-a011-20201029
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-a001-20201028
x86_64               randconfig-a002-20201028
x86_64               randconfig-a003-20201028
x86_64               randconfig-a006-20201028
x86_64               randconfig-a005-20201028
x86_64               randconfig-a004-20201028

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
