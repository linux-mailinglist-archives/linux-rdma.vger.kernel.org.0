Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB85625CDC
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 15:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiKKOWa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Nov 2022 09:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbiKKOWN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Nov 2022 09:22:13 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AB27019E
        for <linux-rdma@vger.kernel.org>; Fri, 11 Nov 2022 06:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668176111; x=1699712111;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=LL77zQXd2g+ah+EJWdxfdWsr1fyQHS1cwdQKXEl1LdM=;
  b=KXe7xGJ3Cmiz3EfQySAiEGOD/yyAZZ/ueEJMaswTQ1Bt3QfyVu1G/hzX
   +kyLLBfcwho0sC6ZIVBIDgk9T1YgJyHheDUj0VFIm+7JktixLpWAV/yOZ
   k8AWvhWh+UlWQ/ZEnCfAAtHi/7kwI+kRD1G01ZVAsZ6Xj/Cccxz/9xKPy
   iC4j5Xtr/l2m/La3NB5ReFnumlT2y2m/eGAkqF4QgM+3qtwBpxDZN1pWS
   uEX5rKJRCrNQoX6ey6tr6xlNT7lYgKf/9vsygALWAFEL2iFISCi1xEcZM
   NSriLAB99M0fgrq2U4SEZFqOEy28LQ0M/0IwT8XCGpmrQzvr+ys0sUtZc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="375864145"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="375864145"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 06:15:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="670754894"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="670754894"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 Nov 2022 06:15:09 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1otUoG-00040f-2r;
        Fri, 11 Nov 2022 14:15:08 +0000
Date:   Fri, 11 Nov 2022 22:14:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 5de087250f1d8f7b81abaf94110884994793f073
Message-ID: <636e58d1.EAB/wcyf/srJt/S1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 5de087250f1d8f7b81abaf94110884994793f073  RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_mmap.c

elapsed time: 724m

configs tested: 75
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                           rhel-8.3-kvm
s390                             allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
powerpc                           allnoconfig
m68k                             allyesconfig
x86_64                           rhel-8.3-syz
s390                                defconfig
x86_64                         rhel-8.3-kunit
powerpc                          allmodconfig
m68k                             allmodconfig
x86_64                        randconfig-a015
mips                             allyesconfig
s390                             allyesconfig
ia64                             allmodconfig
sh                               allmodconfig
x86_64                              defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                            allnoconfig
arm                                 defconfig
i386                                defconfig
arm                      integrator_defconfig
sh                           se7724_defconfig
arc                          axs101_defconfig
loongarch                 loongson3_defconfig
i386                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
s390                 randconfig-r044-20221111
riscv                randconfig-r042-20221111
arc                  randconfig-r043-20221111
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
mips                 randconfig-c004-20221111
i386                          randconfig-c001
powerpc                         ps3_defconfig
xtensa                  cadence_csp_defconfig
sh                         apsh4a3a_defconfig
loongarch                        alldefconfig
nios2                               defconfig
arm                            pleb_defconfig

clang tested configs:
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-k001
powerpc                    socrates_defconfig
powerpc                        icon_defconfig
arm                         hackkit_defconfig
arm                       netwinder_defconfig
arm                          ixp4xx_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                         s3c2410_defconfig
hexagon              randconfig-r041-20221111
hexagon              randconfig-r045-20221111
arm                           sama7_defconfig
arm                          pcm027_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
