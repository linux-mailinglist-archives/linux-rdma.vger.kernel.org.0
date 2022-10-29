Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2F0612002
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Oct 2022 06:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiJ2EZH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 29 Oct 2022 00:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJ2EZG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 29 Oct 2022 00:25:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664BD30563
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 21:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667017504; x=1698553504;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6YdKtsGf/MWssOx8A02FWnwOM2FlZGSdOJEeG0kbCjM=;
  b=aQU4N9DP77oNSQcaEHp/w4RUeEWLcyZChspYujakDQNsUCM52II5/XZR
   XOUWxBxh49A+zLx3rGTtqrsgngkTVIjOH7GYWxfquRi5ekyMySEg6zDb5
   cSAaNFFtM35d7pX5xDtQwt0Qauysp4LcwUHBlQatESzQnkf6xB/EEfQbc
   alQV3Qh3tGdDwPGTqc8ei03/goQ1gflRgV3WOlrFC15hAyl/ZZdJKjLMr
   TRFhT7xAk/KoS0IDjr3Q3ZBXMuoaPbYLAykcBdb9diX8eY0uOMAN0Ukpv
   5XExcIq994PxYBWoUacSqQE6MQ51soy4NDhFDrY626Zslywsr6ZMXrmt/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="289029636"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="289029636"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 21:25:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="962249398"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="962249398"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 28 Oct 2022 21:25:02 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oodP4-000AZz-0P;
        Sat, 29 Oct 2022 04:25:02 +0000
Date:   Sat, 29 Oct 2022 12:25:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD SUCCESS
 7a47e077e503feb73d56e491ce89aa73b67a3972
Message-ID: <635cab1c.oE59Vle1ccrLelr6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: 7a47e077e503feb73d56e491ce89aa73b67a3972  RDMA/qedr: clean up work queue on failure in qedr_alloc_resources()

elapsed time: 722m

configs tested: 77
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
sh                               allmodconfig
x86_64                              defconfig
s390                                defconfig
ia64                             allmodconfig
s390                             allmodconfig
arc                  randconfig-r043-20221028
x86_64                           rhel-8.3-kvm
s390                             allyesconfig
m68k                             allmodconfig
x86_64                           rhel-8.3-syz
riscv                randconfig-r042-20221028
arc                              allyesconfig
s390                 randconfig-r044-20221028
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                         rhel-8.3-kunit
i386                                defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
mips                             allyesconfig
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
arc                  randconfig-r043-20221029
arm64                            allyesconfig
x86_64                        randconfig-a004
arm                              allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                           allyesconfig
x86_64                        randconfig-a015
i386                          randconfig-a016
i386                          randconfig-a014
i386                          randconfig-a001
i386                          randconfig-a003
i386                             allyesconfig
i386                          randconfig-a005
i386                          randconfig-a012
i386                          randconfig-c001
arm                            hisi_defconfig
xtensa                  cadence_csp_defconfig
m68k                           virt_defconfig
powerpc                       holly_defconfig
arm                          pxa3xx_defconfig
sh                        dreamcast_defconfig
powerpc                      ep88xc_defconfig
powerpc                       ppc64_defconfig
powerpc                      makalu_defconfig
arm                           u8500_defconfig
arm                         lpc18xx_defconfig
arm                      jornada720_defconfig

clang tested configs:
hexagon              randconfig-r041-20221028
hexagon              randconfig-r045-20221028
hexagon              randconfig-r041-20221029
riscv                randconfig-r042-20221029
x86_64                        randconfig-a016
hexagon              randconfig-r045-20221029
s390                 randconfig-r044-20221029
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a003
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a015
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
