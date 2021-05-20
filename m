Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2198338AD25
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 13:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240081AbhETL5g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 May 2021 07:57:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:11258 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239663AbhETLze (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 May 2021 07:55:34 -0400
IronPort-SDR: dkBgI9Da8VwApcymhIg9zZGGsyInGq/0WD9Wi9vWWAnjbhLvK5MsEGatxqPnn+CBgsnnH8BuRn
 KPowGhpKcvDg==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="188610315"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="188610315"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 04:51:08 -0700
IronPort-SDR: cHPPUPsdCE8l+r1KQ/m9OEKyZpsEbxtTwpB/IAy4c05PJz4PzOI1kIKYjOHlneuHd9Bs0+PlWf
 8ABZqTG5swDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="543501855"
Received: from lkp-server02.sh.intel.com (HELO 1b329be5b008) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 20 May 2021 04:51:06 -0700
Received: from kbuild by 1b329be5b008 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ljhCk-0000aV-1N; Thu, 20 May 2021 11:51:06 +0000
Date:   Thu, 20 May 2021 19:50:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 463a3f66473b58d71428a1c3ce69ea52c05440e5
Message-ID: <60a64d10.Lk/aXUWT0cXIVO7/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: 463a3f66473b58d71428a1c3ce69ea52c05440e5  RDMA/uverbs: Fix a NULL vs IS_ERR() bug

elapsed time: 724m

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
sh                           se7206_defconfig
sh                 kfr2r09-romimage_defconfig
h8300                    h8300h-sim_defconfig
xtensa                           alldefconfig
arc                          axs103_defconfig
powerpc                     mpc5200_defconfig
openrisc                         alldefconfig
powerpc                      walnut_defconfig
mips                      malta_kvm_defconfig
mips                           mtx1_defconfig
sh                         microdev_defconfig
powerpc                    amigaone_defconfig
arm                             mxs_defconfig
arm64                            alldefconfig
powerpc                      katmai_defconfig
powerpc                       eiger_defconfig
mips                         tb0226_defconfig
arm                      tct_hammer_defconfig
m68k                             allmodconfig
arm                            hisi_defconfig
xtensa                  audio_kc705_defconfig
x86_64                            allnoconfig
sh                   rts7751r2dplus_defconfig
m68k                       m5208evb_defconfig
arm                          pcm027_defconfig
sh                         ap325rxa_defconfig
arm                         socfpga_defconfig
powerpc                 mpc8272_ads_defconfig
arm                           sama5_defconfig
m68k                       bvme6000_defconfig
m68k                        m5307c3_defconfig
m68k                         apollo_defconfig
mips                        bcm47xx_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                           ip27_defconfig
powerpc                      ep88xc_defconfig
arm                             rpc_defconfig
arm                         assabet_defconfig
mips                           ci20_defconfig
xtensa                         virt_defconfig
m68k                       m5275evb_defconfig
powerpc                  mpc885_ads_defconfig
arc                                 defconfig
sh                            hp6xx_defconfig
sh                           se7721_defconfig
powerpc                 mpc832x_rdb_defconfig
s390                             allyesconfig
csky                                defconfig
arc                           tb10x_defconfig
sh                        edosk7705_defconfig
arc                        vdk_hs38_defconfig
powerpc                     rainier_defconfig
arm                         lubbock_defconfig
riscv                    nommu_virt_defconfig
powerpc                  storcenter_defconfig
sh                          rsk7203_defconfig
arm                           corgi_defconfig
powerpc                 mpc832x_mds_defconfig
arm                      jornada720_defconfig
h8300                            allyesconfig
arm                         vf610m4_defconfig
sh                           sh2007_defconfig
mips                      maltasmvp_defconfig
arm                        multi_v7_defconfig
powerpc                     powernv_defconfig
um                             i386_defconfig
x86_64                              defconfig
ia64                                defconfig
arm                         lpc18xx_defconfig
mips                     cu1000-neo_defconfig
powerpc                      cm5200_defconfig
mips                          rb532_defconfig
arm                          ixp4xx_defconfig
arm                         shannon_defconfig
powerpc                      obs600_defconfig
mips                           jazz_defconfig
arm                        keystone_defconfig
mips                   sb1250_swarm_defconfig
sh                           se7712_defconfig
powerpc                     taishan_defconfig
sh                        dreamcast_defconfig
arm                        oxnas_v6_defconfig
powerpc                     tqm5200_defconfig
arm                             ezx_defconfig
sh                          lboxre2_defconfig
sh                        edosk7760_defconfig
powerpc                      arches_defconfig
m68k                         amcore_defconfig
mips                         cobalt_defconfig
ia64                            zx1_defconfig
arm                      integrator_defconfig
powerpc                 mpc836x_mds_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20210520
x86_64               randconfig-a006-20210520
x86_64               randconfig-a005-20210520
x86_64               randconfig-a003-20210520
x86_64               randconfig-a004-20210520
x86_64               randconfig-a002-20210520
i386                 randconfig-a003-20210519
i386                 randconfig-a001-20210519
i386                 randconfig-a005-20210519
i386                 randconfig-a004-20210519
i386                 randconfig-a002-20210519
i386                 randconfig-a006-20210519
i386                 randconfig-a001-20210520
i386                 randconfig-a005-20210520
i386                 randconfig-a002-20210520
i386                 randconfig-a006-20210520
i386                 randconfig-a004-20210520
i386                 randconfig-a003-20210520
x86_64               randconfig-a012-20210519
x86_64               randconfig-a015-20210519
x86_64               randconfig-a013-20210519
x86_64               randconfig-a011-20210519
x86_64               randconfig-a016-20210519
x86_64               randconfig-a014-20210519
i386                 randconfig-a016-20210520
i386                 randconfig-a011-20210520
i386                 randconfig-a015-20210520
i386                 randconfig-a012-20210520
i386                 randconfig-a014-20210520
i386                 randconfig-a013-20210520
i386                 randconfig-a014-20210519
i386                 randconfig-a016-20210519
i386                 randconfig-a011-20210519
i386                 randconfig-a015-20210519
i386                 randconfig-a012-20210519
i386                 randconfig-a013-20210519
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210520
x86_64               randconfig-b001-20210519
x86_64               randconfig-a003-20210519
x86_64               randconfig-a004-20210519
x86_64               randconfig-a005-20210519
x86_64               randconfig-a001-20210519
x86_64               randconfig-a002-20210519
x86_64               randconfig-a006-20210519
x86_64               randconfig-a013-20210520
x86_64               randconfig-a014-20210520
x86_64               randconfig-a012-20210520
x86_64               randconfig-a016-20210520
x86_64               randconfig-a015-20210520
x86_64               randconfig-a011-20210520

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
