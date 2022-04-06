Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974AA4F5B3F
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Apr 2022 12:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351512AbiDFKQB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Apr 2022 06:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358416AbiDFKPG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Apr 2022 06:15:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F8DC8BE0
        for <linux-rdma@vger.kernel.org>; Tue,  5 Apr 2022 23:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649227432; x=1680763432;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rFt7pXgoXHvYAcTkOXJqO5jh1qrZh6ffZwiFAYtVOm4=;
  b=G/i5djSEIXcVdGJFWzPTXFhwbGEQrazbHFF1rSRIjHnvN2bbbyKF2jB4
   vUQit0HQ6brqiP4uB1Ooecb4kSGrBJz8n/xaVDoGhPTf+Bp6EdcuIdpJQ
   vPqAb/0mRXdNH4/mnvukv86j4GUY4IAlaZ5lD5jiq86GOVcNtRVKmnBbS
   0sDpn7S6TKjBHMqQXpVcmVp9S0sUWP+QBUxvLcejhjLh6cqG3u6BPgiId
   lELiXc3n59beregh5yI2eh+CePDZUkNQMZ0hxKu1AYaTV+3yraEmuR1Ns
   OUw74KKkanMxDigMoChUSG69ylqMlrlZ1luSXv7Pij8SUcCSEXngCPRJf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="347408583"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="347408583"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 23:43:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="608772817"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 05 Apr 2022 23:43:51 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbzOQ-000496-Gk;
        Wed, 06 Apr 2022 06:43:50 +0000
Date:   Wed, 06 Apr 2022 14:43:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD SUCCESS
 4d809f69695d4e7d1378b3a072fa9aef23123018
Message-ID: <624d3688.J5faVNmmiMFGiaoU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: 4d809f69695d4e7d1378b3a072fa9aef23123018  IB/rdmavt: add lock to call to rvt_error_qp to prevent a race condition

elapsed time: 729m

configs tested: 120
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
m68k                        m5407c3_defconfig
powerpc                     pq2fads_defconfig
sparc64                          alldefconfig
m68k                            q40_defconfig
arm                           tegra_defconfig
arc                            hsdk_defconfig
arm                        shmobile_defconfig
m68k                        mvme16x_defconfig
riscv                            allmodconfig
mips                  maltasmvp_eva_defconfig
sparc                       sparc32_defconfig
sh                           se7722_defconfig
powerpc                      tqm8xx_defconfig
powerpc                     tqm8548_defconfig
i386                             alldefconfig
arm                        spear6xx_defconfig
m68k                       bvme6000_defconfig
m68k                       m5249evb_defconfig
ia64                        generic_defconfig
arm                           viper_defconfig
sh                            shmin_defconfig
sh                            migor_defconfig
sh                      rts7751r2d1_defconfig
openrisc                  or1klitex_defconfig
sparc                       sparc64_defconfig
arm                          iop32x_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                        mvebu_v7_defconfig
sh                 kfr2r09-romimage_defconfig
mips                           xway_defconfig
xtensa                    xip_kc705_defconfig
mips                          rb532_defconfig
m68k                        m5307c3_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220405
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220405
riscv                randconfig-c006-20220405
mips                 randconfig-c004-20220405
arm                  randconfig-c002-20220405
powerpc                        fsp2_defconfig
arm                           sama7_defconfig
powerpc                   microwatt_defconfig
riscv                            alldefconfig
arm                      tct_hammer_defconfig
powerpc                  mpc885_ads_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220405
riscv                randconfig-r042-20220405
hexagon              randconfig-r041-20220405

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
