Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EF257644F
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Jul 2022 17:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbiGOPS4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Jul 2022 11:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbiGOPSr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Jul 2022 11:18:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2946E100
        for <linux-rdma@vger.kernel.org>; Fri, 15 Jul 2022 08:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657898315; x=1689434315;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FcffuCRlJ7Ogc7GhUJeLYwvS/JjsmY80BMnBuJKSZJc=;
  b=eWooD5hdyPSUOt5eW79R4hJyvTHq2CLjubj9PqeG6EzQON10n8dd/IOv
   RAOxrEArUDprNHlwYc44z64wi1+U4c/tSWZV6OxwcDoadhqfYY3OOCkPa
   pISPg7DY3CO5h0x4DeTvTGaCBGz8v0ksSwETtVWbUZQQ+yGy69DRO+iXL
   S2AKKzrImbHellF7fCkG0454FB0hbruBjxJRaMXyplaWYRM90zDnjhnbw
   ++95lFWVOsr4BQ4ey90en0cHPAVPpUkOcRhQTrczWB63ZtgBrhtX53OWE
   I0DLeXOcu8P+/Sg7sONKqwS0O2/ove6PcLYknEYe+6F1GxjuKtz3pGJ4Z
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="268840524"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="268840524"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 08:18:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="571551504"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Jul 2022 08:18:33 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCN5M-0000CP-Mz;
        Fri, 15 Jul 2022 15:18:32 +0000
Date:   Fri, 15 Jul 2022 19:31:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 cc0315564d6eec91c716d314b743321be24c70b3
Message-ID: <62d15007.F1Z7IiB+QrdXzE97%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: cc0315564d6eec91c716d314b743321be24c70b3  RDMA/irdma: Fix sleep from invalid context BUG

elapsed time: 5724m

configs tested: 70
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                        trizeps4_defconfig
sh                             sh03_defconfig
mips                           gcw0_defconfig
mips                             allyesconfig
arc                              alldefconfig
powerpc                  iss476-smp_defconfig
mips                         bigsur_defconfig
m68k                        mvme147_defconfig
arm                       multi_v4t_defconfig
arc                         haps_hs_defconfig
powerpc                         wii_defconfig
mips                      loongson3_defconfig
sparc                       sparc64_defconfig
csky                              allnoconfig
sparc64                          alldefconfig
arm64                               defconfig
ia64                             allyesconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig
x86_64                        randconfig-c001
i386                          randconfig-c001
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                          g5_defconfig
powerpc                   lite5200b_defconfig
arm                          ep93xx_defconfig
arm                     davinci_all_defconfig
arm                        mvebu_v5_defconfig
mips                     cu1830-neo_defconfig
arm                       imx_v4_v5_defconfig
powerpc                   bluestone_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
hexagon              randconfig-r045-20220714
hexagon              randconfig-r041-20220714

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
