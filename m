Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE613A3980
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jun 2021 04:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhFKCHe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 22:07:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:41397 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230168AbhFKCHd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Jun 2021 22:07:33 -0400
IronPort-SDR: HEzbKC+dIHAb24aeoNXAklP7rQXS67wxNzHdd9cfyuOoSY/UssTQj8z9MxxAaDzUzDEkMJ8ffR
 vyzj39AXR23w==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="291075571"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="291075571"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 19:05:36 -0700
IronPort-SDR: iKjNC75rLKp05ZSAf5f8K5/9OFT4F7Was03q3ylWvAeBlEgyrYs8b+RMWHdiMRm453LS1USxCH
 hziR7u4ce5Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="450602134"
Received: from lkp-server02.sh.intel.com (HELO 3cb98b298c7e) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jun 2021 19:05:35 -0700
Received: from kbuild by 3cb98b298c7e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lrWYB-0000Nc-GY; Fri, 11 Jun 2021 02:05:35 +0000
Date:   Fri, 11 Jun 2021 10:04:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 2db7b2eac7ad55105fe037b3f8f57d8ecac8c3fb
Message-ID: <60c2c4ca.YVia9FuQeDMRo6Cx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 2db7b2eac7ad55105fe037b3f8f57d8ecac8c3fb  RDMA/irdma: Store PBL info address a pointer type

elapsed time: 722m

configs tested: 157
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         shannon_defconfig
sh                          rsk7269_defconfig
arm                       imx_v6_v7_defconfig
arm                        mini2440_defconfig
arm                        keystone_defconfig
sh                          sdk7780_defconfig
arc                    vdk_hs38_smp_defconfig
arm                         vf610m4_defconfig
m68k                           sun3_defconfig
mips                        nlm_xlp_defconfig
arm                  colibri_pxa300_defconfig
arm                         bcm2835_defconfig
arm                      tct_hammer_defconfig
csky                             alldefconfig
sparc                       sparc32_defconfig
sh                              ul2_defconfig
sh                          rsk7264_defconfig
arm                           viper_defconfig
powerpc                 mpc836x_mds_defconfig
arm                        clps711x_defconfig
sparc                            alldefconfig
sh                   sh7770_generic_defconfig
arm                          pxa910_defconfig
sh                          lboxre2_defconfig
arm                       mainstone_defconfig
arm                           sama5_defconfig
powerpc                 mpc832x_mds_defconfig
mips                          rb532_defconfig
arm                        shmobile_defconfig
arc                         haps_hs_defconfig
ia64                        generic_defconfig
powerpc                         wii_defconfig
mips                        vocore2_defconfig
xtensa                    xip_kc705_defconfig
sparc                       sparc64_defconfig
mips                         mpc30x_defconfig
h8300                            alldefconfig
sh                           se7721_defconfig
sh                      rts7751r2d1_defconfig
arm                         axm55xx_defconfig
powerpc                      pasemi_defconfig
powerpc                      makalu_defconfig
h8300                     edosk2674_defconfig
arm                         at91_dt_defconfig
sh                               alldefconfig
powerpc                 mpc8272_ads_defconfig
h8300                               defconfig
sh                           se7619_defconfig
sh                         ap325rxa_defconfig
powerpc                     asp8347_defconfig
xtensa                          iss_defconfig
arm                        oxnas_v6_defconfig
powerpc                    ge_imp3a_defconfig
sh                          urquell_defconfig
arm                          gemini_defconfig
parisc                           alldefconfig
mips                            gpr_defconfig
powerpc                         ps3_defconfig
arm                            mmp2_defconfig
powerpc                     sequoia_defconfig
arm                        mvebu_v7_defconfig
alpha                               defconfig
mips                         db1xxx_defconfig
sh                               j2_defconfig
powerpc                          allmodconfig
powerpc                      pmac32_defconfig
mips                         rt305x_defconfig
powerpc                      tqm8xx_defconfig
nios2                         3c120_defconfig
microblaze                      mmu_defconfig
powerpc                 linkstation_defconfig
powerpc                    mvme5100_defconfig
powerpc                   lite5200b_defconfig
arm                      pxa255-idp_defconfig
powerpc                      ppc44x_defconfig
x86_64                            allnoconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20210610
i386                 randconfig-a006-20210610
i386                 randconfig-a004-20210610
i386                 randconfig-a001-20210610
i386                 randconfig-a005-20210610
i386                 randconfig-a003-20210610
x86_64               randconfig-a015-20210610
x86_64               randconfig-a011-20210610
x86_64               randconfig-a012-20210610
x86_64               randconfig-a014-20210610
x86_64               randconfig-a016-20210610
x86_64               randconfig-a013-20210610
i386                 randconfig-a015-20210610
i386                 randconfig-a013-20210610
i386                 randconfig-a016-20210610
i386                 randconfig-a014-20210610
i386                 randconfig-a012-20210610
i386                 randconfig-a011-20210610
i386                 randconfig-a015-20210608
i386                 randconfig-a013-20210608
i386                 randconfig-a016-20210608
i386                 randconfig-a011-20210608
i386                 randconfig-a012-20210608
i386                 randconfig-a014-20210608
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210610
x86_64               randconfig-a001-20210610
x86_64               randconfig-a004-20210610
x86_64               randconfig-a003-20210610
x86_64               randconfig-a006-20210610
x86_64               randconfig-a005-20210610

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
