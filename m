Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA0660D4E3
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Oct 2022 21:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbiJYTo3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Oct 2022 15:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiJYTo0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Oct 2022 15:44:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C245926F
        for <linux-rdma@vger.kernel.org>; Tue, 25 Oct 2022 12:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666727064; x=1698263064;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=gDca9A7ivXkMeOSj3CyLv1XIeBnG8BUf1VRRqKgWkwk=;
  b=n//q548LoH0FFOZpSPfsBb32WgzvQiWx9Uw99Anxu5JFIJr7zP66CvJn
   wEqDnr0FphkIuwzSTz0s1PGbj3CFW3ApzCk2VgG9x/XhLlIXCBSZ3zT4D
   0oW9fUKTjKqorZQnBT1IXzsdNPWpKBEycuf70rmFatBT4sDOlQxTrTyer
   BXzT5i37lPPvUmJRtfUYW6uuhdRUxf3O4uIq4UEDYmXo3sC/ZJYRxRKhV
   pL5E2SUGiyXNBDaRCmmpNBaM0AzJ58nikCM7MShUDFUi3Ktpr7x5Opr6F
   /NsQIB0cxpGNDvvEkGzPUXWuP8biFi8LNr+qnV7c7PKXWyi00rpfT91o1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="394088052"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="394088052"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 12:44:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="665031245"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="665031245"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 25 Oct 2022 12:44:22 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1onPqX-0006aG-2Q;
        Tue, 25 Oct 2022 19:44:21 +0000
Date:   Wed, 26 Oct 2022 03:43:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 ad9394a3da33995dff828dbfd4540421e535bec9
Message-ID: <63583c70.URSxKEXFPCGDLKbk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: ad9394a3da33995dff828dbfd4540421e535bec9  RDMA/core: Fix null-ptr-deref in ib_core_cleanup()

elapsed time: 728m

configs tested: 78
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
arc                                 defconfig
um                           x86_64_defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                              allyesconfig
x86_64                          rhel-8.3-func
s390                             allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
s390                                defconfig
m68k                             allmodconfig
ia64                             allmodconfig
x86_64                           allyesconfig
m68k                             allyesconfig
x86_64                               rhel-8.3
i386                                defconfig
s390                             allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
arm                                 defconfig
powerpc                           allnoconfig
i386                 randconfig-a015-20221024
i386                 randconfig-a014-20221024
i386                 randconfig-a012-20221024
i386                 randconfig-a011-20221024
sh                               allmodconfig
i386                 randconfig-a013-20221024
i386                 randconfig-a016-20221024
x86_64                         rhel-8.3-kunit
arc                  randconfig-r043-20221025
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
i386                             allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                        randconfig-a011
powerpc                       eiger_defconfig
powerpc                      chrp32_defconfig
csky                             alldefconfig
sh                            migor_defconfig
sh                      rts7751r2d1_defconfig
x86_64               randconfig-k001-20221024
powerpc                     sequoia_defconfig
arm                       multi_v4t_defconfig
powerpc                 mpc837x_rdb_defconfig
loongarch                         allnoconfig
parisc64                         alldefconfig
sh                             sh03_defconfig
arm                          pxa3xx_defconfig
powerpc                       ppc64_defconfig
powerpc                 mpc834x_itx_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                          randconfig-c001
arm                         nhk8815_defconfig

clang tested configs:
hexagon              randconfig-r041-20221025
hexagon              randconfig-r045-20221025
riscv                randconfig-r042-20221025
s390                 randconfig-r044-20221025
x86_64               randconfig-a001-20221024
x86_64               randconfig-a003-20221024
x86_64               randconfig-a004-20221024
x86_64               randconfig-a002-20221024
x86_64               randconfig-a006-20221024
x86_64               randconfig-a005-20221024
i386                 randconfig-a001-20221024
i386                 randconfig-a002-20221024
i386                 randconfig-a003-20221024
i386                 randconfig-a004-20221024
i386                 randconfig-a005-20221024
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                 randconfig-a006-20221024

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
