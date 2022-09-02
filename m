Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC795AA699
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Sep 2022 05:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiIBDtR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Sep 2022 23:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbiIBDs5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Sep 2022 23:48:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F6A98590
        for <linux-rdma@vger.kernel.org>; Thu,  1 Sep 2022 20:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662090535; x=1693626535;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=IvI4cBueDKYuv9paH3dd3wnCeZgtOiCSBKnuW3yydVg=;
  b=JmeHGRWnMGuVlCtaGN8H2EoyBH+Nnd+ER8aCMLA4rzc7IR51bnB6mIcF
   jFGLBnAKfiKYNXaujsniYsXlP9BIrUPXsCw7NjLXiPixepuIuarahtKQJ
   QgRTgZiSZnYmEyDzDF+CLz5K8+mcLA6W2WE1y5wCA2M1y4P0Z+9KNYuB0
   OP/k4qefWRbFkUVpI2zPZTTpViyZ9oydij2qE7SoPIX1/rLezexxEq8i4
   miZDPGnJDOtv2v+VO9ITxrynfQR/7+/QJ3dJzjnwZ/DWOLuVo9kIYeVGC
   SaIyViHRPk53UAAdfx/hnjsER3wAKrG5TRvDd2dleByJRLNi/NdCYVK2I
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="275630745"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="275630745"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 20:48:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="612803746"
Received: from lkp-server02.sh.intel.com (HELO fccc941c3034) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 01 Sep 2022 20:48:53 -0700
Received: from kbuild by fccc941c3034 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTxfo-000063-2l;
        Fri, 02 Sep 2022 03:48:52 +0000
Date:   Fri, 02 Sep 2022 11:48:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 fc5e1acf6ade49da06c6a74b0c3fa903e0c9503a
Message-ID: <63117cfb.tMUWxr983RfDrHWj%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: fc5e1acf6ade49da06c6a74b0c3fa903e0c9503a  RDMA/siw: Add missing Kconfig selections

elapsed time: 1190m

configs tested: 118
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
i386                                defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                           allyesconfig
i386                          randconfig-a001
i386                             allyesconfig
i386                          randconfig-a003
m68k                             allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a005
x86_64                        randconfig-a015
powerpc                          allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
mips                             allyesconfig
powerpc                           allnoconfig
m68k                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
arc                  randconfig-r043-20220901
x86_64                           rhel-8.3-syz
sh                               allmodconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
arm                              allyesconfig
arm                                 defconfig
arm64                            allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm                           stm32_defconfig
powerpc                     pq2fads_defconfig
mips                       bmips_be_defconfig
arm                        oxnas_v6_defconfig
sh                            shmin_defconfig
sh                             espt_defconfig
sparc                            alldefconfig
mips                 randconfig-c004-20220901
i386                          randconfig-c001
m68k                         apollo_defconfig
sh                          rsk7264_defconfig
sh                           se7751_defconfig
arm                            hisi_defconfig
sh                         apsh4a3a_defconfig
powerpc                  storcenter_defconfig
powerpc                      cm5200_defconfig
mips                     decstation_defconfig
mips                            ar7_defconfig
powerpc                      tqm8xx_defconfig
alpha                            alldefconfig
arm                         lubbock_defconfig
sh                           se7750_defconfig
m68k                          amiga_defconfig
powerpc                     mpc83xx_defconfig
arm                          badge4_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-c001
microblaze                      mmu_defconfig
m68k                        m5272c3_defconfig
sparc                               defconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
sparc                       sparc64_defconfig
mips                           ip32_defconfig
mips                            gpr_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                          pxa3xx_defconfig
mips                           ci20_defconfig
sh                          lboxre2_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
ia64                             allmodconfig
powerpc                     ep8248e_defconfig
sh                   sh7724_generic_defconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
x86_64                        randconfig-a012
i386                          randconfig-a006
i386                          randconfig-a004
hexagon              randconfig-r041-20220901
x86_64                        randconfig-a014
x86_64                        randconfig-a016
riscv                randconfig-r042-20220901
hexagon              randconfig-r045-20220901
x86_64                        randconfig-a001
s390                 randconfig-r044-20220901
x86_64                        randconfig-a003
x86_64                        randconfig-a005
powerpc                      katmai_defconfig
powerpc                     mpc5200_defconfig
x86_64                        randconfig-k001
arm                        vexpress_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
