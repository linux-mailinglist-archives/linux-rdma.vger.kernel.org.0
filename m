Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0614F57D461
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jul 2022 21:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiGUTrw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jul 2022 15:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGUTrv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jul 2022 15:47:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BE889A5B
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jul 2022 12:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658432870; x=1689968870;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+EEDoDMK2r19S86m+FUmChz/K7Villbuzqd+0umt5K8=;
  b=jOxAU/RHtsMQP9Vr/t8wwAHBsFuI32QgMOPdwOY7+SqaNV2+os60oKgB
   wf3rhUbeZYFJ4KDYYL43CRp5VORwK1djyxUPmlMhIa370/vXcOwm8Y17t
   lNwS5ZVxs78eAsgbDD2IUPzacvnNxum/4oBGJn4xc2E5Nv+aehdnblDMQ
   TssLDuQ94lKmG4tPgkjVj6NwRK0MKtcNX6t1SLKR6Xf2DKeZhYFY70D7F
   s5hzxSTE0pHijjwVWich9gzIj5gG5ewFEQ79rKmD7DTj46n3SMrJ9k8ll
   uXpiU/69R/MU37/hzMb+N+b4By3FTrHcNJc8TsLMFmjWheYocx/HEiS6g
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="284714091"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="284714091"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 12:47:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="740807684"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jul 2022 12:47:49 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEc9E-0000U2-28;
        Thu, 21 Jul 2022 19:47:48 +0000
Date:   Fri, 22 Jul 2022 03:47:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 5abb71b47cf338f650fcccda4b13e07faa157742
Message-ID: <62d9ad4f.oRXbABgWvY6K2Qrn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 5abb71b47cf338f650fcccda4b13e07faa157742  RDMA/rxe: Fix spelling mistake in error print

elapsed time: 748m

configs tested: 107
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                        spear6xx_defconfig
arm                          pxa910_defconfig
mips                        vocore2_defconfig
powerpc                         ps3_defconfig
m68k                        mvme147_defconfig
xtensa                           alldefconfig
ia64                        generic_defconfig
xtensa                    smp_lx200_defconfig
arm                         assabet_defconfig
parisc                generic-64bit_defconfig
arm                         at91_dt_defconfig
powerpc                       maple_defconfig
sh                               alldefconfig
arm                           sama5_defconfig
sh                   sh7770_generic_defconfig
xtensa                       common_defconfig
m68k                       bvme6000_defconfig
arm                             rpc_defconfig
arm                        shmobile_defconfig
arc                          axs103_defconfig
xtensa                              defconfig
m68k                            mac_defconfig
arm                           viper_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
loongarch                           defconfig
loongarch                         allnoconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a005
x86_64               randconfig-a012-20220718
x86_64               randconfig-a011-20220718
x86_64               randconfig-a013-20220718
x86_64               randconfig-a015-20220718
x86_64               randconfig-a016-20220718
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                 randconfig-a013-20220718
i386                          randconfig-a014
i386                          randconfig-a016
i386                          randconfig-a012
arc                  randconfig-r043-20220718
s390                 randconfig-r044-20220718
riscv                randconfig-r042-20220718
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
mips                      malta_kvm_defconfig
arm                                 defconfig
arm                           spitz_defconfig
powerpc                        fsp2_defconfig
powerpc                          allyesconfig
arm                             mxs_defconfig
mips                           mtx1_defconfig
powerpc                     kmeter1_defconfig
powerpc                  mpc866_ads_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                 randconfig-a001-20220718
i386                 randconfig-a006-20220718
i386                 randconfig-a002-20220718
i386                          randconfig-a004
i386                          randconfig-a002
i386                          randconfig-a006
i386                 randconfig-a004-20220718
i386                 randconfig-a003-20220718
i386                 randconfig-a005-20220718
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220721
s390                 randconfig-r044-20220721
hexagon              randconfig-r045-20220721
riscv                randconfig-r042-20220721
hexagon              randconfig-r041-20220718
hexagon              randconfig-r045-20220718

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
