Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EA04AE9FF
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Feb 2022 07:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiBIGF1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Feb 2022 01:05:27 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiBIGAo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Feb 2022 01:00:44 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2DCC03325A
        for <linux-rdma@vger.kernel.org>; Tue,  8 Feb 2022 22:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644386448; x=1675922448;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=df8k4k3Kk8AzAhi19SgSXbOpsAo6368HZa5ROhRTJ2Y=;
  b=iSb7taGmKfCOqAELOugsayvqYztXBMScmDU6vjg05abU/zmSU1whMHC2
   ZHqfRquqCKbp90z7GDfHVEJ2yP6QOPN53eGHHS5P6pdebPrgSAxCa0W8e
   WDIcXhBQWuwAUK/xfGanQNj7rM/AYXlqqA1TSUB1WLuWPdbVpxuora1bS
   NOVoaVslEbfbIPxyeqh3wqYsTMngU2vXcqd1P32OIxm0+83XH1rgsLDs/
   HXtfsAgDQjGNawjgNFKzISxB3/tD4T9HHBdhT/qanKcNv/uWlpoiYS8MG
   8StFvUzWp4g9IP3R6KvjlwsnElzmiPBZmbDVuCPAkxqsZ2Ilvn6d4FCZ1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="229099259"
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="229099259"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 22:00:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="482217003"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2022 22:00:28 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHg1j-0001Iu-VT; Wed, 09 Feb 2022 06:00:27 +0000
Date:   Wed, 09 Feb 2022 13:59:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 2f1b2820b546c1eef07d15ed73db4177c0cf6d46
Message-ID: <6203584d.nWPxvMXr/OYXdvkF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 2f1b2820b546c1eef07d15ed73db4177c0cf6d46  Merge branch 'irdma_dscp' into rdma.git for-next

elapsed time: 761m

configs tested: 103
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
powerpc                    sam440ep_defconfig
arm                         cm_x300_defconfig
h8300                            alldefconfig
mips                         rt305x_defconfig
powerpc                     pq2fads_defconfig
mips                     loongson1b_defconfig
arm                            xcep_defconfig
sparc                       sparc64_defconfig
arm                        oxnas_v6_defconfig
sh                          urquell_defconfig
mips                     decstation_defconfig
sh                         microdev_defconfig
xtensa                  nommu_kc705_defconfig
arm                         at91_dt_defconfig
sh                             espt_defconfig
powerpc                       ppc64_defconfig
powerpc                 mpc834x_itx_defconfig
sh                          sdk7780_defconfig
powerpc                     sequoia_defconfig
sh                   rts7751r2dplus_defconfig
mips                         db1xxx_defconfig
sh                             sh03_defconfig
openrisc                            defconfig
sh                        sh7763rdp_defconfig
arm                        mvebu_v7_defconfig
mips                            gpr_defconfig
arm                  randconfig-c002-20220209
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
nios2                            allyesconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig

clang tested configs:
powerpc                     tqm8540_defconfig
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r045-20220208
hexagon              randconfig-r041-20220208
riscv                randconfig-r042-20220208

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
