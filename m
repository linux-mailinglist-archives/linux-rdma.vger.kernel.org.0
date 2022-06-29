Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A5E55F9CE
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jun 2022 09:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiF2HyC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jun 2022 03:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbiF2Hx4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jun 2022 03:53:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2278B5C
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jun 2022 00:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656489235; x=1688025235;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=wI29qTYUet+bqN2hkjMS+hTSat0OD7iVCLTWHq1aqVE=;
  b=cIOUi8Jk1yyxKxnfJOQuxb9PDXrZp8LU56KC4fcblzGQDUdgqRfxpwAg
   Uz/bI84jtBzMrgSPrNdp+km5rvMdKUeplngAj1iIr7iG1Ya4BsXi6SLOg
   A9pZlOIO9pr4HBhqJ3x/C+EqQDpG9BNI5HWp2eedk4c4nMwiBcro9AI5r
   eMibnGaRQ4HpQ6IN/nHPcYp2WmRTsEQZ+YWjCPayIIjtDyxSj8Xzoed5D
   dJYrbe2zdlhXi8f2S5CwP/u7XTKN/gCfGVLc08iF7AtdxvENZnpGkgxE1
   v4ejYZxE1fYbuQgndthDA0lUEbiPa2TmtQSImPhEoEqjFIRy060szwgQg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="264995786"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="264995786"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 00:53:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="540769262"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 29 Jun 2022 00:53:51 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6SWE-000B0A-Po;
        Wed, 29 Jun 2022 07:53:50 +0000
Date:   Wed, 29 Jun 2022 15:53:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 0fe3dbbefb74a8575f61d7801b08dbc50523d60d
Message-ID: <62bc04e5.jwOX4Gu/Wn4y7UWC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: 0fe3dbbefb74a8575f61d7801b08dbc50523d60d  linux/dim: Fix divide by 0 in RDMA DIM

elapsed time: 729m

configs tested: 68
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
xtensa                  audio_kc705_defconfig
sh                              ul2_defconfig
i386                             alldefconfig
powerpc                         ps3_defconfig
m68k                        stmark2_defconfig
arm                            mps2_defconfig
arm                          simpad_defconfig
sh                ecovec24-romimage_defconfig
arm                        realview_defconfig
arm                        cerfcube_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                 mpc837x_mds_defconfig
sh                           se7712_defconfig
arm                      jornada720_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64               randconfig-a012-20220627
x86_64               randconfig-a011-20220627
x86_64               randconfig-a013-20220627
x86_64               randconfig-a014-20220627
x86_64               randconfig-a015-20220627
x86_64               randconfig-a016-20220627
i386                 randconfig-a014-20220627
i386                 randconfig-a011-20220627
i386                 randconfig-a012-20220627
i386                 randconfig-a015-20220627
i386                 randconfig-a016-20220627
i386                 randconfig-a013-20220627
arc                  randconfig-r043-20220627
s390                 randconfig-r044-20220627
riscv                randconfig-r042-20220627
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                        neponset_defconfig
x86_64                        randconfig-k001
x86_64               randconfig-a002-20220627
x86_64               randconfig-a003-20220627
x86_64               randconfig-a001-20220627
x86_64               randconfig-a005-20220627
x86_64               randconfig-a006-20220627
x86_64               randconfig-a004-20220627
i386                 randconfig-a005-20220627
i386                 randconfig-a001-20220627
i386                 randconfig-a006-20220627
i386                 randconfig-a004-20220627
i386                 randconfig-a003-20220627
i386                 randconfig-a002-20220627
hexagon              randconfig-r041-20220627
hexagon              randconfig-r045-20220627

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
