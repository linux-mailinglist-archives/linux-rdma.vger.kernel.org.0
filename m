Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0844C2EB6
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 15:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbiBXOy7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Feb 2022 09:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbiBXOy6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Feb 2022 09:54:58 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BC41B0BC9
        for <linux-rdma@vger.kernel.org>; Thu, 24 Feb 2022 06:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645714467; x=1677250467;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=80V4A//XPjHsc3UVo3b3N1NkQYg/vQIzTCyn47/XDHo=;
  b=fZYfagqT2ujuKFIIHsPYrB5DKAg+iq318hEVCGuIQu+YRY6QXal0ZqEV
   aDNqCWYbmLT3GTAekDVq6ZSUminnSBxrKvIxg7wun9dvcxmRX3FVf7UCi
   Jx8PVADINGd7Dp7t4xgpEmsPHowSulj9hPG5X/YqrRGH8W+0wFcKt2vh6
   JrkB4r0FIWFtsiatYg8/zccHW+z5gOqnWJk9KqIplKJynfcEWHpkoxeKa
   bqBYTHtqu94sONlIt2JoW63Lh+175RIajsXoNbfP8GVC+02EcGjvtkitu
   1BF8iwIXgAfbBitlw2cYDtNQQzGUSQpHfCTs2fvhS8FypCUaBwzEBjxps
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="251983723"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="251983723"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 06:54:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="533159418"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 24 Feb 2022 06:54:25 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNFVg-0003Cc-Jq; Thu, 24 Feb 2022 14:54:24 +0000
Date:   Thu, 24 Feb 2022 22:53:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 6090a0c4c7c6156f267ee217f6577eecd610a652
Message-ID: <62179bf4.XP64lq7hKUlAeAnR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 6090a0c4c7c6156f267ee217f6577eecd610a652  RDMA/rxe: Cleanup rxe_mcast.c

elapsed time: 720m

configs tested: 133
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220223
sh                             sh03_defconfig
sh                          sdk7780_defconfig
arm                            pleb_defconfig
powerpc                      bamboo_defconfig
sh                             espt_defconfig
arc                              alldefconfig
sh                          rsk7201_defconfig
sh                          r7780mp_defconfig
sh                           se7724_defconfig
mips                           xway_defconfig
arm                            hisi_defconfig
sh                        sh7757lcr_defconfig
sh                          rsk7269_defconfig
mips                           jazz_defconfig
mips                           gcw0_defconfig
arm                         s3c6400_defconfig
h8300                    h8300h-sim_defconfig
sh                           sh2007_defconfig
sh                        sh7763rdp_defconfig
sh                            migor_defconfig
powerpc                      makalu_defconfig
arm                       aspeed_g5_defconfig
powerpc                     tqm8555_defconfig
ia64                             allmodconfig
arm                         assabet_defconfig
arc                        nsimosci_defconfig
nios2                         10m50_defconfig
sh                            titan_defconfig
powerpc                      ep88xc_defconfig
ia64                             alldefconfig
arm                           viper_defconfig
sh                        sh7785lcr_defconfig
arm                           tegra_defconfig
nios2                               defconfig
csky                                defconfig
arm                  randconfig-c002-20220224
arm                  randconfig-c002-20220223
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a016
i386                          randconfig-a014
i386                          randconfig-a012
s390                 randconfig-r044-20220224
arc                  randconfig-r043-20220224
riscv                randconfig-r042-20220224
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
powerpc              randconfig-c003-20220224
powerpc              randconfig-c003-20220223
x86_64                        randconfig-c007
arm                  randconfig-c002-20220224
arm                  randconfig-c002-20220223
mips                 randconfig-c004-20220224
mips                 randconfig-c004-20220223
i386                          randconfig-c001
riscv                randconfig-c006-20220223
riscv                randconfig-c006-20220224
s390                 randconfig-c005-20220224
s390                 randconfig-c005-20220223
powerpc                        icon_defconfig
powerpc                      obs600_defconfig
powerpc                     ppa8548_defconfig
arm                          imote2_defconfig
arm                         bcm2835_defconfig
arm                           spitz_defconfig
powerpc                      ppc44x_defconfig
powerpc                      katmai_defconfig
powerpc                     mpc5200_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                        neponset_defconfig
arm                          moxart_defconfig
mips                        maltaup_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220223
hexagon              randconfig-r041-20220223
riscv                randconfig-r042-20220223

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
