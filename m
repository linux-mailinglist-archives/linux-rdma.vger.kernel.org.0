Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914DA624CBF
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Nov 2022 22:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiKJVRo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Nov 2022 16:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiKJVRo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Nov 2022 16:17:44 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA32C66
        for <linux-rdma@vger.kernel.org>; Thu, 10 Nov 2022 13:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668115062; x=1699651062;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=aP882s7Kv4RCBetG3UPAAWXGjRsMFG97jULx+yeKtOs=;
  b=gn1cfpkX3wBIstfKmbKf8QzSC471+TyJyj0wAdanTOm90HVW+ZWYI8kO
   j6CzdCRNuUkpfqpR7HHi0UTGT8ENO44GSz/j5IZY+FfTJdU/FiIk54chX
   UQdFpem5feSFv0ypXX3cMKQOgma6TatsEaBcOKNpIDwGORdG/6sL3kuDw
   7mSbu/tuYY1N+ERCxqAxvU4w3FWDYpMeotJuouSlZw0f1SMcCbFClaFP9
   bibD0wNyVYGA6mC1XsfmpjiwMxZUtQ66EF4tG9dnpe2dna/Xq1abxADTS
   0Q4MxWvOmiEvRjbSSFA6QFGfaipOOPLFZPqAyhD1L+f6Va2NmZJi1WIy/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="298949927"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="298949927"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 13:17:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="588331857"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="588331857"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 10 Nov 2022 13:17:40 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1otEvb-0003GD-1j;
        Thu, 10 Nov 2022 21:17:39 +0000
Date:   Fri, 11 Nov 2022 05:17:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 5c20311d76cbaeb7ed2ecf9c8b8322f8fc4a7ae3
Message-ID: <636d6a4f.8im20WYENpzsZr38%lkp@intel.com>
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
branch HEAD: 5c20311d76cbaeb7ed2ecf9c8b8322f8fc4a7ae3  IB/mad: Don't call to function that might sleep while in atomic context

elapsed time: 734m

configs tested: 83
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
s390                             allmodconfig
m68k                             allmodconfig
alpha                               defconfig
arc                              allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
alpha                            allyesconfig
x86_64                            allnoconfig
i386                             allyesconfig
i386                                defconfig
m68k                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
s390                                defconfig
ia64                             allmodconfig
s390                             allyesconfig
powerpc                           allnoconfig
arm                        cerfcube_defconfig
sh                               alldefconfig
sh                        sh7757lcr_defconfig
arm                                 defconfig
x86_64                              defconfig
s390                       zfcpdump_defconfig
powerpc                      arches_defconfig
powerpc                     sequoia_defconfig
mips                         cobalt_defconfig
arm                      footbridge_defconfig
xtensa                  cadence_csp_defconfig
mips                         db1xxx_defconfig
arm                        spear6xx_defconfig
powerpc                      pasemi_defconfig
sh                           se7722_defconfig
arm                         cm_x300_defconfig
powerpc              randconfig-c003-20221110
x86_64                           allyesconfig
x86_64                               rhel-8.3
arm                         lpc18xx_defconfig
nios2                         10m50_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7724_defconfig
microblaze                          defconfig
parisc                           alldefconfig
arm                          pxa910_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arm64                            allyesconfig
arm                              allyesconfig
powerpc                    amigaone_defconfig
arc                        nsimosci_defconfig
powerpc                       ppc64_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          randconfig-c001

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a004
s390                 randconfig-r044-20221110
riscv                randconfig-r042-20221110
hexagon              randconfig-r041-20221110
hexagon              randconfig-r045-20221110
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a001
powerpc                        fsp2_defconfig
powerpc                    gamecube_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
