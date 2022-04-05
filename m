Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21904F3EC0
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Apr 2022 22:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbiDENyG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Apr 2022 09:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346044AbiDELwM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Apr 2022 07:52:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96564119840
        for <linux-rdma@vger.kernel.org>; Tue,  5 Apr 2022 04:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649157011; x=1680693011;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tEJiMv+/JcBPLAtGtRsx3EF7WeLvW6/xhKLgAa75hn0=;
  b=CjjD1mFifXVsWwfixWg3fOpzzhq+PuGkSZ1fuly+ZeW15I5pTY0YUT4l
   qmpJQF4YgJN2Xm7VvCekuhPNWCMsWvpHi+8E31cUv9DR9tUif31XAg/aw
   tIEUD1B9wmOVwV8e7SiMnrq35N1OOwdawsR5kAYAmy0KFI9Cj8zx+OYgp
   pZSIVGLl7ofdeDm6QdztdJIaUqqtYgFIMTDYbZNgo6nlLJxXEXOCXox/K
   FjLAeBlZxI+qk26OTW0ST0ay4Qgpdilx2PGAohgL5K5LAImXLbn5ig5GG
   Xlq770OSU/gxNeszQjdnIdp7/sPRZdJLmfZXD/3pJchG4WUQnn/Y31/Sg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="260712194"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="260712194"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 04:10:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="608402839"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 05 Apr 2022 04:10:05 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbh4W-00036t-VV;
        Tue, 05 Apr 2022 11:10:04 +0000
Date:   Tue, 05 Apr 2022 19:09:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 f543a3e82bb275349961f8507ee195f34132ffb4
Message-ID: <624c2363.Cr8k7uOsmq/Fw1PO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: f543a3e82bb275349961f8507ee195f34132ffb4  IB/uverbs: Move part of enum ib_device_cap_flags to uapi

elapsed time: 945m

configs tested: 117
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                         s3c6400_defconfig
mips                         db1xxx_defconfig
openrisc                 simple_smp_defconfig
arm                         at91_dt_defconfig
sh                           se7751_defconfig
mips                        vocore2_defconfig
arm                         lpc18xx_defconfig
sh                           se7343_defconfig
sh                         ap325rxa_defconfig
arm                       imx_v6_v7_defconfig
arc                        vdk_hs38_defconfig
m68k                       m5475evb_defconfig
sh                          sdk7786_defconfig
powerpc                        cell_defconfig
powerpc                      chrp32_defconfig
csky                             alldefconfig
mips                    maltaup_xpa_defconfig
arm                           stm32_defconfig
powerpc                     pq2fads_defconfig
powerpc                 mpc837x_mds_defconfig
m68k                          multi_defconfig
arm                             ezx_defconfig
xtensa                       common_defconfig
sh                        edosk7760_defconfig
powerpc                     stx_gp3_defconfig
powerpc                  iss476-smp_defconfig
sh                           se7750_defconfig
powerpc                      pcm030_defconfig
sh                  sh7785lcr_32bit_defconfig
xtensa                generic_kc705_defconfig
sh                             sh03_defconfig
ia64                          tiger_defconfig
arm                       multi_v4t_defconfig
mips                         cobalt_defconfig
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
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
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
powerpc                   bluestone_defconfig
arm                  colibri_pxa300_defconfig
mips                     loongson1c_defconfig
arm                        neponset_defconfig
mips                         tb0219_defconfig
arm                       spear13xx_defconfig
arm                         socfpga_defconfig
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
