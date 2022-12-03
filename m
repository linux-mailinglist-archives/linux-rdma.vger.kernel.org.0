Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515096411FA
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Dec 2022 01:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiLCA0i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Dec 2022 19:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbiLCA0h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Dec 2022 19:26:37 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD5F7F8AD
        for <linux-rdma@vger.kernel.org>; Fri,  2 Dec 2022 16:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670027196; x=1701563196;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=QtGZDYDCUFIWjVxxjI5f6GT6M/SAGb5UwFCUjXtSLMc=;
  b=hZGVvH9uo98ZSNtiZCJJd53KTK4g5VtgrVHkHGqXI7XlH6Ywd1d+TuDz
   RYXFwWYqnhU1a/rCg856vjunS4PuT6p/EpSXMBk/e7c2lXgXN2xFuNV/L
   q1lZmA88HOHaTShG7B+SbsBTDPkRBp1+h0BsVZ7RVcZ9lgydzHe4rsmEN
   MUeXQnyimkfJ8zlTIBhx9yTlBdEsrVLcRQxHHJ/CrjlCTs/YeLU0kouao
   8aoEOJCO3PdS7JlTHK9guQN91vp8tXMedCE5s4yjI3bc0bmy45jvQGhYY
   2MUyMQJ1ypFLwFYVizjb4sgZSPxd66Z3DUcrMfjr5wCge9QZoHloR7MUh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="378226435"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="378226435"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:26:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="645208628"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="645208628"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 Dec 2022 16:26:34 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p1GMT-000E99-0v;
        Sat, 03 Dec 2022 00:26:33 +0000
Date:   Sat, 03 Dec 2022 08:25:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 4cd9f1d320f905e7bc60f030566d15003745ba91
Message-ID: <638a9788.gfWet+nmtbOvW8Ny%lkp@intel.com>
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
branch HEAD: 4cd9f1d320f905e7bc60f030566d15003745ba91  RDMA/rxe: Enable atomic write capability for rxe device

elapsed time: 1449m

configs tested: 103
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
ia64                             allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arc                                 defconfig
x86_64                               rhel-8.3
alpha                               defconfig
x86_64                              defconfig
arc                  randconfig-r043-20221201
s390                 randconfig-r044-20221201
riscv                randconfig-r042-20221201
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                           allyesconfig
i386                          randconfig-a005
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                             allyesconfig
i386                                defconfig
x86_64                            allnoconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arm                           h5000_defconfig
powerpc                         ps3_defconfig
powerpc                      tqm8xx_defconfig
i386                          randconfig-c001
arm                  randconfig-c002-20221201
x86_64                        randconfig-c001
arm                        spear6xx_defconfig
sh                           se7619_defconfig
mips                       bmips_be_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sh                         apsh4a3a_defconfig
sh                           se7780_defconfig
arc                            hsdk_defconfig
mips                             allmodconfig
xtensa                generic_kc705_defconfig
arc                        vdk_hs38_defconfig
arm                           stm32_defconfig
powerpc                 mpc834x_itx_defconfig
arm                         lubbock_defconfig
sh                  sh7785lcr_32bit_defconfig
arc                    vdk_hs38_smp_defconfig
m68k                        m5407c3_defconfig
m68k                             alldefconfig
arm                         cm_x300_defconfig
mips                    maltaup_xpa_defconfig
powerpc                       holly_defconfig
arm                         s3c6400_defconfig
m68k                          multi_defconfig
sh                          rsk7269_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20221201
hexagon              randconfig-r045-20221201
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001
powerpc                          allyesconfig
powerpc                        icon_defconfig
mips                      maltaaprp_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
