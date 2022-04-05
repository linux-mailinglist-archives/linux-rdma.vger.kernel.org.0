Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233204F2158
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Apr 2022 06:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiDEDDw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 23:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiDEDDf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 23:03:35 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0372C9921
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 19:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649126572; x=1680662572;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=C4m9m4MJ7y7JMvRsoi3TmVMReCbrzL4dlIj6sSNh5Ic=;
  b=NQDvHsxhstLZjv9yU/byx3PBaRM6+DWqQ24Uwn5W4X9qlPm1cAR3ZcIY
   3z3pZvhmKfbCD1yXlnRTnalkSbOJB9QUlQd7MJlq6lF4xwwKCxHZW4FXq
   W4vSMRIduVAIM37aMBxNOz/vwxOYCXS51QjoukaqlLJj8JE+iLsRKxEp+
   DhnHvbGXUUnSV3+nNHISMTDE4usvr/RozS3Y54dmC1gz2ML2uL2qidwoG
   4JmVYxeSM7B2yizUkGZWvI8x186dq2jH6o4NFMxl1DhCQRjdtHHaTvFEQ
   Gyajo3XLJI/27dL9T9Xcf0V2Cu3QmmT3QfZ4aaJgGQ5inHqi3wlXK91xT
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="321346142"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="321346142"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 19:42:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="696774356"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2022 19:42:41 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbZ9V-0002Yl-BE;
        Tue, 05 Apr 2022 02:42:41 +0000
Date:   Tue, 05 Apr 2022 10:42:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 107dd7beba403a363adfeb3ffe3734fe38a05cce
Message-ID: <624bac92.lEnadGJmCexbWy6+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: 107dd7beba403a363adfeb3ffe3734fe38a05cce  IB/cm: Cancel mad on the DREQ event when the state is MRA_REP_RCVD

elapsed time: 738m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20220404
arm                         axm55xx_defconfig
arm                         lubbock_defconfig
powerpc                 canyonlands_defconfig
nios2                         3c120_defconfig
openrisc                 simple_smp_defconfig
sh                             sh03_defconfig
sh                           se7343_defconfig
arm                         at91_dt_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                      ppc6xx_defconfig
arm                        mini2440_defconfig
arm                      integrator_defconfig
arm                        realview_defconfig
sh                           se7780_defconfig
powerpc                 mpc834x_mds_defconfig
sh                               allmodconfig
arm                      footbridge_defconfig
x86_64               randconfig-c001-20220404
arm                  randconfig-c002-20220404
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
alpha                               defconfig
alpha                            allyesconfig
csky                                defconfig
nios2                            allyesconfig
arc                                 defconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                               defconfig
sparc                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a011-20220404
x86_64               randconfig-a013-20220404
x86_64               randconfig-a012-20220404
x86_64               randconfig-a015-20220404
x86_64               randconfig-a016-20220404
x86_64               randconfig-a014-20220404
i386                 randconfig-a013-20220404
i386                 randconfig-a011-20220404
i386                 randconfig-a012-20220404
i386                 randconfig-a014-20220404
i386                 randconfig-a016-20220404
i386                 randconfig-a015-20220404
arc                  randconfig-r043-20220404
s390                 randconfig-r044-20220404
riscv                randconfig-r042-20220404
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
powerpc                     ppa8548_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     mpc512x_defconfig
arm                       cns3420vb_defconfig
powerpc                     kmeter1_defconfig
arm                        neponset_defconfig
powerpc                   microwatt_defconfig
i386                 randconfig-a001-20220404
i386                 randconfig-a003-20220404
i386                 randconfig-a002-20220404
i386                 randconfig-a004-20220404
i386                 randconfig-a005-20220404
i386                 randconfig-a006-20220404
x86_64               randconfig-a004-20220404
x86_64               randconfig-a002-20220404
x86_64               randconfig-a005-20220404
x86_64               randconfig-a001-20220404
x86_64               randconfig-a003-20220404
x86_64               randconfig-a006-20220404
hexagon              randconfig-r041-20220404
hexagon              randconfig-r045-20220404

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
