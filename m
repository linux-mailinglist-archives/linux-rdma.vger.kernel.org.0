Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4B460C0B6
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Oct 2022 03:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiJYBOw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 21:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiJYBOU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 21:14:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A1910FF4
        for <linux-rdma@vger.kernel.org>; Mon, 24 Oct 2022 17:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666657795; x=1698193795;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=JGPbIF+BYEajR/innvSkLYpB0q93NsF2ULr3mCiaFsU=;
  b=daXfN7g/kPSGMNwL4RABFEA8WlY3up1oNNu8jYT4tVdUdeLMbm5khwUR
   inmHYVpf49LbfzgmMkTupMZU7yQkXKo8JAOqJJk1f3P4GwKLdwb1ovc/r
   djfOqmOxLsBjKZ9J9ENi1YbOSRSUgr3VePrpagLP9mKVkAg8KlTpG7hsb
   ddpXfz6u/yQYPFmkDiaLZiWSJmwDdZ3OCMZWaAml/4WBjzH7rcXXNMLFy
   XdABZgE5Uk3ro9LRm5g6UCJg0mIdV9qyfSL7XXHrZPAAT57xOQzWB+CRs
   DfzgstwjUaZxLVkpKLt5ysN7T8TuCWErMadV9iOZaBtYsDwVDrq74BMr3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="305165295"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="305165295"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 17:29:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="720666293"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="720666293"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Oct 2022 17:29:53 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1on7pJ-0005ke-0s;
        Tue, 25 Oct 2022 00:29:53 +0000
Date:   Tue, 25 Oct 2022 08:29:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 71d236399160ad9beaae7267b93d2d487e8f19a0
Message-ID: <63572dff.uV33AJMJixLTW94Q%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 71d236399160ad9beaae7267b93d2d487e8f19a0  RDMA/rxe: Remove the member 'type' of struct rxe_mr

elapsed time: 723m

configs tested: 103
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
arm                                 defconfig
s390                             allmodconfig
s390                                defconfig
arm64                            allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
arm                              allyesconfig
i386                                defconfig
x86_64                               rhel-8.3
ia64                             allmodconfig
s390                             allyesconfig
x86_64                           allyesconfig
i386                 randconfig-a011-20221024
i386                 randconfig-a013-20221024
m68k                             allmodconfig
i386                 randconfig-a012-20221024
arc                              allyesconfig
i386                 randconfig-a015-20221024
alpha                            allyesconfig
i386                 randconfig-a014-20221024
x86_64               randconfig-a014-20221024
x86_64                           rhel-8.3-syz
x86_64               randconfig-a013-20221024
i386                 randconfig-a016-20221024
x86_64               randconfig-a012-20221024
i386                             allyesconfig
x86_64               randconfig-a011-20221024
x86_64                         rhel-8.3-kunit
powerpc                           allnoconfig
m68k                             allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a015-20221024
mips                             allyesconfig
x86_64               randconfig-a016-20221024
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20221024
sh                               allmodconfig
riscv                randconfig-r042-20221024
s390                 randconfig-r044-20221024
x86_64               randconfig-k001-20221024
i386                          randconfig-c001
powerpc                   motionpro_defconfig
csky                             alldefconfig
powerpc                 mpc837x_rdb_defconfig
openrisc                            defconfig
arm                        mini2440_defconfig
sh                         ecovec24_defconfig
m68k                            mac_defconfig
arm                       omap2plus_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                        spear6xx_defconfig
powerpc                      tqm8xx_defconfig
powerpc                 mpc834x_mds_defconfig
mips                            gpr_defconfig
m68k                            q40_defconfig
m68k                        m5307c3_defconfig
powerpc                      cm5200_defconfig
sh                        sh7763rdp_defconfig
ia64                             allyesconfig
sh                             shx3_defconfig
arc                      axs103_smp_defconfig
mips                        vocore2_defconfig
sh                         ap325rxa_defconfig
ia64                      gensparse_defconfig
arm                          pxa910_defconfig
i386                 randconfig-c001-20221024
arc                  randconfig-r043-20221023
parisc                generic-64bit_defconfig
sh                           se7712_defconfig
arc                              alldefconfig
sh                        dreamcast_defconfig
sh                          polaris_defconfig
riscv                    nommu_k210_defconfig
xtensa                    xip_kc705_defconfig

clang tested configs:
x86_64               randconfig-a001-20221024
x86_64               randconfig-a005-20221024
hexagon              randconfig-r041-20221024
i386                 randconfig-a001-20221024
x86_64               randconfig-a003-20221024
i386                 randconfig-a002-20221024
x86_64               randconfig-a006-20221024
i386                 randconfig-a003-20221024
x86_64               randconfig-a004-20221024
i386                 randconfig-a004-20221024
x86_64               randconfig-a002-20221024
hexagon              randconfig-r045-20221024
i386                 randconfig-a005-20221024
i386                 randconfig-a006-20221024
s390                 randconfig-r044-20221023
hexagon              randconfig-r041-20221023
riscv                randconfig-r042-20221023
hexagon              randconfig-r045-20221023
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
mips                     loongson2k_defconfig
arm                          moxart_defconfig
arm                         s3c2410_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
