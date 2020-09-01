Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE962587D4
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Sep 2020 08:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgIAGF3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Sep 2020 02:05:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:23621 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgIAGF2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 1 Sep 2020 02:05:28 -0400
IronPort-SDR: zTZerY2yQElZyJuPEbog6YOoh9uAD1CFMoHh2/Yb5t8sXzr+EmyLs9Jn45RKgaUUOcEmHD/iW+
 PJIUaI1xcmAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="144855507"
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="144855507"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 23:05:28 -0700
IronPort-SDR: BH2qLQA51HBOlB3KUMQ4U8bTCL8GwCcn0//wj0Xg6T74ocQEibiv7Q5OV2x171jcHZijzV+hR9
 uUET8XwkSxBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="501616315"
Received: from lkp-server02.sh.intel.com (HELO 713faec3b0e5) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 31 Aug 2020 23:05:26 -0700
Received: from kbuild by 713faec3b0e5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kCzQ5-0000aG-Rf; Tue, 01 Sep 2020 06:05:25 +0000
Date:   Tue, 01 Sep 2020 14:04:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 524d8ffd07f0ca10b24011487339f836ed859b32
Message-ID: <5f4de480.2ajABlFbEDH3cOng%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 524d8ffd07f0ca10b24011487339f836ed859b32  RDMA/qib: Tidy up process_cc()

elapsed time: 775m

configs tested: 120
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         s3c6400_defconfig
m68k                          sun3x_defconfig
ia64                            zx1_defconfig
xtensa                         virt_defconfig
sh                          polaris_defconfig
powerpc                 mpc8272_ads_defconfig
arc                      axs103_smp_defconfig
powerpc                     ep8248e_defconfig
arm                            u300_defconfig
sh                           se7751_defconfig
arm                           u8500_defconfig
parisc                generic-32bit_defconfig
m68k                        mvme147_defconfig
powerpc                          allmodconfig
arm                         shannon_defconfig
mips                     decstation_defconfig
alpha                            allyesconfig
sh                           se7343_defconfig
sh                     magicpanelr2_defconfig
powerpc                      pmac32_defconfig
arc                                 defconfig
parisc                           allyesconfig
arm                            zeus_defconfig
sparc                               defconfig
m68k                          atari_defconfig
arm                        cerfcube_defconfig
sh                     sh7710voipgw_defconfig
sh                      rts7751r2d1_defconfig
m68k                            q40_defconfig
arm                           omap1_defconfig
arm                   milbeaut_m10v_defconfig
sh                        edosk7705_defconfig
mips                      malta_kvm_defconfig
sh                         microdev_defconfig
mips                      bmips_stb_defconfig
arm                            mps2_defconfig
powerpc                    mvme5100_defconfig
mips                       lemote2f_defconfig
nios2                               defconfig
arm                       imx_v6_v7_defconfig
mips                           rs90_defconfig
i386                             alldefconfig
powerpc                      ppc64e_defconfig
arm                            hisi_defconfig
mips                           gcw0_defconfig
arm                         bcm2835_defconfig
arc                            hsdk_defconfig
arm                         s5pv210_defconfig
powerpc                         wii_defconfig
sh                        sh7757lcr_defconfig
powerpc                      tqm8xx_defconfig
nios2                            alldefconfig
sh                               alldefconfig
arm                           stm32_defconfig
mips                        jmr3927_defconfig
arc                     haps_hs_smp_defconfig
mips                malta_qemu_32r6_defconfig
sh                        dreamcast_defconfig
ia64                             alldefconfig
arm                      jornada720_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a001-20200831
i386                 randconfig-a002-20200831
i386                 randconfig-a004-20200831
i386                 randconfig-a006-20200831
i386                 randconfig-a005-20200831
i386                 randconfig-a003-20200831
x86_64               randconfig-a012-20200831
x86_64               randconfig-a015-20200831
x86_64               randconfig-a014-20200831
x86_64               randconfig-a011-20200831
x86_64               randconfig-a016-20200831
x86_64               randconfig-a013-20200831
i386                 randconfig-a013-20200831
i386                 randconfig-a011-20200831
i386                 randconfig-a012-20200831
i386                 randconfig-a015-20200831
i386                 randconfig-a016-20200831
i386                 randconfig-a014-20200831
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
