Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642FC62AF15
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Nov 2022 00:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiKOXF2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 18:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238575AbiKOXFZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 18:05:25 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B655D2BB1A
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 15:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668553523; x=1700089523;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Xe1W+VjK4jWqF9+yMDuefqYExJXNH7sWwIWoQ+ziYpg=;
  b=FROduqrM0ljYBqo1/nqP06eIETuTGfmpfiH7MqPal8cgr7qzFiAuXtJN
   /zbwI49L6wmMHjAmDfvVdXnRn/cdC8P56E9TXc5Eoe1Va26Xgmd5EVjp/
   KgLqhIiCOs8EMBrAt7//5c+ja5SwUuBkaAD3hTa4nCLB++HXmvbMbaufF
   fQMg22mDUVHnR4HdHgAEnLiS2FE9KcQZRjkHgm29jIeNk+EWFG4pHfKVN
   IFbIfWWGIjTL1Dngm/8w+luOCXs1wndg3xa25nk+5WgEAEW8Iyixn9+VZ
   GC1grgh8qcW1wpsYmdZi72R89/FQ8Eaw9k6MfM3xR4fZx3od6gDkZG+cl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="313540147"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="313540147"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 15:05:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="744791177"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="744791177"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 15 Nov 2022 15:05:21 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ov4zY-0001jT-22;
        Tue, 15 Nov 2022 23:05:20 +0000
Date:   Wed, 16 Nov 2022 07:05:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 ecacb3751f254572af0009b9501e2cdc83a30b6a
Message-ID: <63741b1d.qXBBwEwgJYWofUi6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: ecacb3751f254572af0009b9501e2cdc83a30b6a  RDMA/nldev: Return "-EAGAIN" if the cm_id isn't from expected port

elapsed time: 772m

configs tested: 110
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a001-20221114
s390                             allyesconfig
i386                 randconfig-a002-20221114
powerpc                          allmodconfig
i386                 randconfig-a005-20221114
i386                 randconfig-a006-20221114
i386                 randconfig-a003-20221114
x86_64                              defconfig
i386                 randconfig-a004-20221114
x86_64               randconfig-a002-20221114
mips                             allyesconfig
x86_64               randconfig-a001-20221114
i386                                defconfig
x86_64               randconfig-a004-20221114
powerpc                           allnoconfig
x86_64               randconfig-a005-20221114
sh                               allmodconfig
x86_64                               rhel-8.3
x86_64               randconfig-a003-20221114
arc                  randconfig-r043-20221115
x86_64               randconfig-a006-20221114
riscv                randconfig-r042-20221115
s390                 randconfig-r044-20221115
x86_64                           allyesconfig
ia64                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
m68k                             allmodconfig
i386                          randconfig-a016
m68k                             allyesconfig
x86_64                            allnoconfig
sh                          kfr2r09_defconfig
xtensa                  nommu_kc705_defconfig
sh                     magicpanelr2_defconfig
xtensa                          iss_defconfig
microblaze                      mmu_defconfig
arm                       multi_v4t_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
powerpc                      ppc40x_defconfig
powerpc                     taishan_defconfig
arc                          axs101_defconfig
arm                      integrator_defconfig
mips                           ci20_defconfig
powerpc                      ppc6xx_defconfig
sh                 kfr2r09-romimage_defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                             allyesconfig
i386                          randconfig-c001
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
mips                     decstation_defconfig
sh                         apsh4a3a_defconfig
openrisc                 simple_smp_defconfig
s390                          debug_defconfig
riscv                    nommu_k210_defconfig
mips                        vocore2_defconfig
arm                            hisi_defconfig
powerpc                   motionpro_defconfig
mips                      maltasmvp_defconfig
mips                      loongson3_defconfig
sh                           se7721_defconfig
arm                         axm55xx_defconfig
parisc                              defconfig
powerpc                       maple_defconfig
arm                      footbridge_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20221115
m68k                            q40_defconfig
sh                        dreamcast_defconfig
sh                          rsk7203_defconfig
mips                         cobalt_defconfig
arm                         vf610m4_defconfig
powerpc                      cm5200_defconfig

clang tested configs:
x86_64               randconfig-a012-20221114
x86_64               randconfig-a013-20221114
x86_64               randconfig-a011-20221114
x86_64               randconfig-a014-20221114
x86_64               randconfig-a016-20221114
x86_64               randconfig-a015-20221114
hexagon              randconfig-r045-20221115
hexagon              randconfig-r041-20221115
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
powerpc                   bluestone_defconfig
powerpc               mpc834x_itxgp_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-k001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
arm                           sama7_defconfig
powerpc                 mpc8315_rdb_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
