Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF33A2164ED
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 05:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgGGDxB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 23:53:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:37409 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727094AbgGGDxB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Jul 2020 23:53:01 -0400
IronPort-SDR: yBqZfbUFqEwRdzujIg2WfiY4h1wCozSMjSL/sFg3UbKyG7gNSBpSHB+BSAfxkeurj5OepwZLrS
 erfxFRMhZTew==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="212506950"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="212506950"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 20:53:00 -0700
IronPort-SDR: FUKodFWMvT/GJJvNX5jLE0oYoB+nOX1Rqtjz+KZMVLmHOUmuRMCo0FYgHO3jH3WtfmnDEXnlcQ
 4O43xZXcVEKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="279475648"
Received: from lkp-server01.sh.intel.com (HELO f2047cb89c8e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Jul 2020 20:52:39 -0700
Received: from kbuild by f2047cb89c8e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jsees-00003n-Vb; Tue, 07 Jul 2020 03:52:38 +0000
Date:   Tue, 07 Jul 2020 11:52:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 d473f4dc2f95c8c856b1659ced3502802b7d2fbe
Message-ID: <5f03f172.SdS85OZnPzggyebR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  for-next
branch HEAD: d473f4dc2f95c8c856b1659ced3502802b7d2fbe  RDMA/mlx5: Introduce ODP prefetch counter

elapsed time: 758m

configs tested: 160
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                           corgi_defconfig
mips                     loongson1b_defconfig
s390                              allnoconfig
arm                           spitz_defconfig
arm                             ezx_defconfig
sh                                  defconfig
arm                      tct_hammer_defconfig
powerpc64                           defconfig
sh                        dreamcast_defconfig
arm                         orion5x_defconfig
mips                           ip22_defconfig
arc                      axs103_smp_defconfig
mips                          rm200_defconfig
alpha                               defconfig
riscv                    nommu_k210_defconfig
mips                           jazz_defconfig
sh                          r7785rp_defconfig
openrisc                         allyesconfig
sparc                            alldefconfig
mips                  mips_paravirt_defconfig
sh                     sh7710voipgw_defconfig
nios2                            alldefconfig
m68k                            q40_defconfig
mips                      malta_kvm_defconfig
sh                        edosk7760_defconfig
arm                            zeus_defconfig
sh                           se7206_defconfig
arm                         s3c6400_defconfig
arm                            dove_defconfig
s390                          debug_defconfig
c6x                        evmc6457_defconfig
arm                          gemini_defconfig
arm                         bcm2835_defconfig
mips                          ath79_defconfig
mips                 decstation_r4k_defconfig
mips                         rt305x_defconfig
nios2                         3c120_defconfig
arm                            hisi_defconfig
mips                            gpr_defconfig
arm                          pxa168_defconfig
sparc64                          allyesconfig
arm                          moxart_defconfig
parisc                              defconfig
arm                            mps2_defconfig
m68k                          multi_defconfig
sh                               j2_defconfig
mips                       lemote2f_defconfig
sh                           se7780_defconfig
arm                     davinci_all_defconfig
arm                     eseries_pxa_defconfig
arm                              zx_defconfig
parisc                generic-32bit_defconfig
xtensa                  audio_kc705_defconfig
mips                        bcm47xx_defconfig
sh                          rsk7269_defconfig
m68k                        m5307c3_defconfig
mips                         bigsur_defconfig
arm                       versatile_defconfig
m68k                        stmark2_defconfig
sh                           se7705_defconfig
xtensa                          iss_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a001-20200706
i386                 randconfig-a002-20200706
i386                 randconfig-a006-20200706
i386                 randconfig-a004-20200706
i386                 randconfig-a005-20200706
i386                 randconfig-a003-20200706
i386                 randconfig-a011-20200707
i386                 randconfig-a014-20200707
i386                 randconfig-a015-20200707
i386                 randconfig-a016-20200707
i386                 randconfig-a012-20200707
i386                 randconfig-a013-20200707
i386                 randconfig-a011-20200706
i386                 randconfig-a014-20200706
i386                 randconfig-a015-20200706
i386                 randconfig-a016-20200706
i386                 randconfig-a012-20200706
i386                 randconfig-a013-20200706
x86_64               randconfig-a001-20200706
x86_64               randconfig-a006-20200706
x86_64               randconfig-a002-20200706
x86_64               randconfig-a003-20200706
x86_64               randconfig-a004-20200706
x86_64               randconfig-a005-20200706
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
