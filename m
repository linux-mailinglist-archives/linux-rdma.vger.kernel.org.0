Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F07A2553D6
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Aug 2020 06:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgH1Emn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Aug 2020 00:42:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:52847 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgH1Emn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Aug 2020 00:42:43 -0400
IronPort-SDR: +tH0YtKuhDA2JzL1MdW8Q5CEStRe2sXBBPhH9R7XDeCYWB9TISRM5DZy2/2mT2FB+S1TuEyav+
 v2conroY9vXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="136151805"
X-IronPort-AV: E=Sophos;i="5.76,362,1592895600"; 
   d="scan'208";a="136151805"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 21:42:42 -0700
IronPort-SDR: hpjicqCcM2bdVQYMtILQmaaEkvQGVz7lI7cn201joBL7aWZIox5TDjY4p8Y9MC3kC6zGdyOBtR
 74jKxT057+9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,362,1592895600"; 
   d="scan'208";a="280843695"
Received: from lkp-server01.sh.intel.com (HELO 4f455964fc6c) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 Aug 2020 21:42:41 -0700
Received: from kbuild by 4f455964fc6c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kBWDo-0002Um-H7; Fri, 28 Aug 2020 04:42:40 +0000
Date:   Fri, 28 Aug 2020 12:41:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD REGRESSION
 097a9d23b7250355b182c5fd47dd4c55b22b1c33
Message-ID: <5f488b13.mp4O8S2dJvcuz5kD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  for-rc
branch HEAD: 097a9d23b7250355b182c5fd47dd4c55b22b1c33  RDMA/bnxt_re: Remove the qp from list only if the qp destroy succeeds

Error/Warning in current branch:

ld.lld: error: n_tty.c:(.text.fixup+0xC): relocation R_ARM_THM_JUMP24 out of range: 19154716 is not in [-16777216, 16777215]

Error/Warning ids grouped by kconfigs:

clang_recent_errors
`-- arm-randconfig-r003-20200827
    `-- ld.lld:error:n_tty.c:(.text.fixupC):relocation-R_ARM_THM_JUMP24-out-of-range:is-not-in

elapsed time: 921m

configs tested: 127
configs skipped: 12

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                    nommu_k210_defconfig
mips                     decstation_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                              ul2_defconfig
sh                ecovec24-romimage_defconfig
arm                      pxa255-idp_defconfig
mips                           ip32_defconfig
sh                           se7721_defconfig
sh                           se7343_defconfig
mips                      loongson3_defconfig
mips                        vocore2_defconfig
arm                           u8500_defconfig
alpha                               defconfig
arm                          badge4_defconfig
m68k                           sun3_defconfig
arm                          ixp4xx_defconfig
m68k                          multi_defconfig
sh                            shmin_defconfig
arm                         s3c2410_defconfig
m68k                        m5272c3_defconfig
sh                            migor_defconfig
arm                        multi_v7_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                      ep88xc_defconfig
powerpc                      pmac32_defconfig
sparc64                          alldefconfig
arm                          pxa168_defconfig
ia64                             allmodconfig
sh                        sh7763rdp_defconfig
arm                         orion5x_defconfig
mips                         mpc30x_defconfig
powerpc                      ppc40x_defconfig
parisc                           allyesconfig
arc                            hsdk_defconfig
powerpc                     pseries_defconfig
arm                    vt8500_v6_v7_defconfig
sh                             sh03_defconfig
arm                         mv78xx0_defconfig
arc                              allyesconfig
powerpc                     powernv_defconfig
mips                          rb532_defconfig
ia64                         bigsur_defconfig
arm                        multi_v5_defconfig
sh                         ecovec24_defconfig
c6x                        evmc6678_defconfig
sparc                               defconfig
arc                    vdk_hs38_smp_defconfig
sh                        apsh4ad0a_defconfig
arm                         at91_dt_defconfig
sh                          kfr2r09_defconfig
arm                          pcm027_defconfig
powerpc                      ppc6xx_defconfig
nds32                            alldefconfig
c6x                         dsk6455_defconfig
arm                         lpc32xx_defconfig
riscv                               defconfig
arm                         bcm2835_defconfig
mips                     loongson1b_defconfig
mips                            ar7_defconfig
arm                          exynos_defconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
x86_64               randconfig-a003-20200827
x86_64               randconfig-a002-20200827
x86_64               randconfig-a001-20200827
x86_64               randconfig-a005-20200827
x86_64               randconfig-a006-20200827
x86_64               randconfig-a004-20200827
i386                 randconfig-a002-20200828
i386                 randconfig-a005-20200828
i386                 randconfig-a003-20200828
i386                 randconfig-a004-20200828
i386                 randconfig-a001-20200828
i386                 randconfig-a006-20200828
i386                 randconfig-a002-20200827
i386                 randconfig-a004-20200827
i386                 randconfig-a003-20200827
i386                 randconfig-a005-20200827
i386                 randconfig-a006-20200827
i386                 randconfig-a001-20200827
i386                 randconfig-a013-20200827
i386                 randconfig-a012-20200827
i386                 randconfig-a011-20200827
i386                 randconfig-a016-20200827
i386                 randconfig-a015-20200827
i386                 randconfig-a014-20200827
riscv                            allyesconfig
riscv                             allnoconfig
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
