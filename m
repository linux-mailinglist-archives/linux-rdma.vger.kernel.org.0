Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B16D624A72
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Nov 2022 20:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiKJTSa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Nov 2022 14:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKJTS2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Nov 2022 14:18:28 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF017218A
        for <linux-rdma@vger.kernel.org>; Thu, 10 Nov 2022 11:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668107906; x=1699643906;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=vTjXGjmIE8WtndrVi0YN5eLVmzSvHC3SI9WJ6ZgwI+Y=;
  b=kcAptMYy7VGZR+Qzdp4UPUqLhGMlR67wdX08kWJJqtwLzDYp3Rgeh1YC
   bXJEB3AR0T5aY8tJGEpiLbpqr0FMmoi9IJNaXdovJfI2QzrLZzT1i1TcR
   sM9YWjKM0gvP2ih6ig0OuHQRBCwz/9OYQsNX5CKhrApbg+W6R8YAhzg5x
   SwKbJNKwQNfMOOPo1gtBSg7JwC/yFI8P9nTgCEwPKPLOLEChqzG20Sp4A
   VU12zdoyHcvojAuo0GOVBDZWs//8F8mtaBkar+uNDzs3mzmaMuwjEi7Ku
   LiXOAjC/fa0vfmTJwWbCZYGKDb32pufd8ZMmalA/9j/V0/XlPDyN2qJ4r
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="375669158"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="375669158"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 11:13:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="631774558"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="631774558"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 10 Nov 2022 11:13:35 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1otCzX-00037U-0G;
        Thu, 10 Nov 2022 19:13:35 +0000
Date:   Fri, 11 Nov 2022 03:13:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:mana-shared-6.2] BUILD SUCCESS
 28c66cfa45388af1126985d1114e0ed762eb2abd
Message-ID: <636d4d50.jbUoG+fSwW4tZJE1%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git mana-shared-6.2
branch HEAD: 28c66cfa45388af1126985d1114e0ed762eb2abd  net: mana: Define data structures for protection domain and memory registration

elapsed time: 752m

configs tested: 93
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
i386                                defconfig
arm                            lart_defconfig
i386                             alldefconfig
powerpc                       holly_defconfig
m68k                        mvme16x_defconfig
sh                        edosk7760_defconfig
x86_64                              defconfig
arc                                 defconfig
alpha                               defconfig
i386                          randconfig-a001
x86_64                          rhel-8.3-func
i386                          randconfig-a003
x86_64                    rhel-8.3-kselftests
s390                             allmodconfig
i386                          randconfig-a005
x86_64                               rhel-8.3
i386                             allyesconfig
s390                                defconfig
x86_64                           allyesconfig
arm                                 defconfig
powerpc                           allnoconfig
arc                              allyesconfig
powerpc                          allmodconfig
alpha                            allyesconfig
s390                             allyesconfig
mips                             allyesconfig
x86_64                            allnoconfig
sh                               allmodconfig
m68k                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
arm                        cerfcube_defconfig
sh                               alldefconfig
sh                        sh7757lcr_defconfig
s390                       zfcpdump_defconfig
powerpc                      arches_defconfig
powerpc                     sequoia_defconfig
mips                         cobalt_defconfig
arm                      footbridge_defconfig
xtensa                  cadence_csp_defconfig
mips                         db1xxx_defconfig
arm                        spear6xx_defconfig
powerpc                      pasemi_defconfig
m68k                             allmodconfig
sh                           se7722_defconfig
arm                         cm_x300_defconfig
powerpc              randconfig-c003-20221110
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
sh                   secureedge5410_defconfig
powerpc                 mpc837x_rdb_defconfig
xtensa                    xip_kc705_defconfig
xtensa                          iss_defconfig
powerpc                 mpc834x_mds_defconfig
arm                         lpc18xx_defconfig
nios2                         10m50_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7724_defconfig
microblaze                          defconfig
parisc                           alldefconfig
arm                          pxa910_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm64                               defconfig
powerpc                 linkstation_defconfig
parisc                generic-64bit_defconfig
loongarch                           defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
s390                 randconfig-r044-20221110
riscv                randconfig-r042-20221110
hexagon              randconfig-r041-20221110
hexagon              randconfig-r045-20221110
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a001
powerpc                        fsp2_defconfig
powerpc                    gamecube_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
