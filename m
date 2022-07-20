Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0850957BF23
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jul 2022 22:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiGTUXH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jul 2022 16:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGTUXH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Jul 2022 16:23:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA04549B7B
        for <linux-rdma@vger.kernel.org>; Wed, 20 Jul 2022 13:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658348585; x=1689884585;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=S5QoVtCM2spdET9+RErfImehjJbwnivcGFxnxsdr0/c=;
  b=Sou/b8Xj48OGxxW1qFfBWELODRQLjJJ79IxbRMlm211r3h7XTJ3Xf6aO
   /NtlmhTZq/P/OPvS5ZXxP9kytM4KXIb89IYO2nwWLs6lTxq/Trfo4ojdG
   I050k3fCDaHf42dOTl3MCrRHQjIo78kePl+0OjzdA/VQCU6Qqz5y+e+iI
   E7YUhBKci2unZSPX3OneCddQ3xcMMkBDLKItHQ0uf7dFEOOv1DVTDxwtN
   d4jzN+qFqdKbSQnwQDFNLbDHAYc2z+eObq5huEHIppzYuDIWbLFb0Fww+
   wKEcj3EIoan6sTScQ/vDa7SGaclLYc4ezMQCuZ2XdqO8xFiNDwIl0JpmM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="269906447"
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="269906447"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 13:23:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="925369958"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 20 Jul 2022 13:23:03 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oEGDm-0000ua-TR;
        Wed, 20 Jul 2022 20:23:02 +0000
Date:   Thu, 21 Jul 2022 04:22:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 0c6ab0ca9a662d4ca9742d97156bac0d3067d72d
Message-ID: <62d863fd.n4Tg9y9eggQnBnpG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 0c6ab0ca9a662d4ca9742d97156bac0d3067d72d  RDMA/mlx5: Expose steering anchor to userspace

elapsed time: 1562m

configs tested: 159
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
i386                 randconfig-c001-20220718
arm                        realview_defconfig
arm                             rpc_defconfig
powerpc                     sequoia_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                          iop32x_defconfig
sh                      rts7751r2d1_defconfig
arm                         nhk8815_defconfig
powerpc                    sam440ep_defconfig
xtensa                    smp_lx200_defconfig
arm                          pxa3xx_defconfig
powerpc                       maple_defconfig
m68k                        m5307c3_defconfig
m68k                             alldefconfig
arc                     haps_hs_smp_defconfig
powerpc                     pq2fads_defconfig
sh                         microdev_defconfig
arc                     nsimosci_hs_defconfig
sh                        dreamcast_defconfig
arm                            xcep_defconfig
powerpc                     mpc83xx_defconfig
powerpc                      ep88xc_defconfig
arm                      footbridge_defconfig
powerpc                        cell_defconfig
nios2                               defconfig
openrisc                 simple_smp_defconfig
powerpc                     ep8248e_defconfig
arc                        nsimosci_defconfig
sh                             shx3_defconfig
x86_64                              defconfig
sh                        sh7757lcr_defconfig
sh                   secureedge5410_defconfig
m68k                        mvme147_defconfig
nios2                         10m50_defconfig
mips                           jazz_defconfig
xtensa                  cadence_csp_defconfig
sh                           se7343_defconfig
arm                         at91_dt_defconfig
xtensa                              defconfig
m68k                            mac_defconfig
arm                           viper_defconfig
arm                            lart_defconfig
arm                              allmodconfig
m68k                                defconfig
arm                           corgi_defconfig
m68k                            q40_defconfig
mips                  decstation_64_defconfig
loongarch                        alldefconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
loongarch                           defconfig
loongarch                         allnoconfig
arm                  randconfig-c002-20220718
x86_64               randconfig-c001-20220718
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
i386                          randconfig-a005
i386                          randconfig-a003
i386                          randconfig-a001
x86_64               randconfig-a013-20220718
x86_64               randconfig-a014-20220718
x86_64               randconfig-a011-20220718
x86_64               randconfig-a016-20220718
x86_64               randconfig-a012-20220718
x86_64               randconfig-a015-20220718
i386                 randconfig-a015-20220718
i386                 randconfig-a011-20220718
i386                 randconfig-a012-20220718
i386                 randconfig-a014-20220718
i386                 randconfig-a016-20220718
i386                 randconfig-a013-20220718
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
s390                 randconfig-r044-20220718
riscv                randconfig-r042-20220718
arc                  randconfig-r043-20220718
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                      tct_hammer_defconfig
mips                           ip28_defconfig
x86_64                           allyesconfig
powerpc               mpc834x_itxgp_defconfig
arm                     am200epdkit_defconfig
riscv                            alldefconfig
arm                        magician_defconfig
arm                          pxa168_defconfig
arm                          moxart_defconfig
powerpc                          allmodconfig
powerpc                 mpc832x_rdb_defconfig
arm                          pcm027_defconfig
mips                          malta_defconfig
hexagon                          alldefconfig
powerpc                    gamecube_defconfig
mips                      maltaaprp_defconfig
mips                        maltaup_defconfig
powerpc                     mpc5200_defconfig
mips                           rs90_defconfig
arm                           spitz_defconfig
mips                          ath25_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                 randconfig-a004-20220718
i386                 randconfig-a001-20220718
i386                 randconfig-a005-20220718
i386                 randconfig-a002-20220718
i386                 randconfig-a006-20220718
i386                 randconfig-a003-20220718
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a001-20220718
x86_64               randconfig-a005-20220718
x86_64               randconfig-a003-20220718
x86_64               randconfig-a002-20220718
x86_64               randconfig-a006-20220718
x86_64               randconfig-a004-20220718
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220718
hexagon              randconfig-r045-20220718

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
