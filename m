Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF5355B2B0
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jun 2022 17:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiFZPk0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Jun 2022 11:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiFZPkZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 26 Jun 2022 11:40:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE1BDFAD
        for <linux-rdma@vger.kernel.org>; Sun, 26 Jun 2022 08:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656258024; x=1687794024;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=sndlD9rWs5ZAKAy50s5OOTlNeK8pb5mIDwQV67qzklA=;
  b=Dxxqy7hHGLWx/9JQVqHTHTaSRzhAFdKHbP5+8Mal2SJc8r4NgG2FOUaD
   Cxp+nz2heGEtKgPY9Wt7TlpUH6AARkaK7rDkKXuavvCG2zBJccZpwbMsj
   ZqC+v7um7tR0mfnFdZgcrRslJnEH0juUh2+UmzBDVFjKAjBXRpNs9GVRv
   GJn0JTvZfVYhicnAB6oiI55qJYcQd1mECcyavBVSJa5HaNuU+oZQ+ZHaM
   jDTNUPa9k5GaykHcPVru+I9bmICVVZX32Q1eGHVZT866z5GMX09tKNG+F
   BlZdE22W5+v9iadhSE4WTlMgWjWrNzYKClsLurthCpQQ+9H7d1D7tVPgJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="342974931"
X-IronPort-AV: E=Sophos;i="5.92,224,1650956400"; 
   d="scan'208";a="342974931"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 08:40:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,224,1650956400"; 
   d="scan'208";a="835842106"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jun 2022 08:40:22 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5UN3-0007UR-V6;
        Sun, 26 Jun 2022 15:40:21 +0000
Date:   Sun, 26 Jun 2022 23:39:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 2990f223ffa7bb25422956b9f79f9176a5b38346
Message-ID: <62b87dbc.+l1XINkDbtJlcqnW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: 2990f223ffa7bb25422956b9f79f9176a5b38346  RDMA/cm: Fix memory leak in ib_cm_insert_listen

elapsed time: 2416m

configs tested: 82
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
powerpc                      arches_defconfig
m68k                          multi_defconfig
powerpc                     mpc83xx_defconfig
sh                 kfr2r09-romimage_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-c001
i386                          randconfig-c001
arm                  randconfig-c002-20220625
ia64                             allmodconfig
m68k                             allyesconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allmodconfig
i386                                defconfig
i386                          randconfig-a001
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
arc                  randconfig-r043-20220624
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
x86_64                        randconfig-k001
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r041-20220624
hexagon              randconfig-r045-20220624
s390                 randconfig-r044-20220624
riscv                randconfig-r042-20220624

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
