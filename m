Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4941D5966E0
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Aug 2022 03:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbiHQBkK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Aug 2022 21:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238255AbiHQBkJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Aug 2022 21:40:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03ADA95E61
        for <linux-rdma@vger.kernel.org>; Tue, 16 Aug 2022 18:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660700408; x=1692236408;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=MObRalZSdGeiKyXNMG2fI6yK7Qf3EUC4eXF2m+evpQE=;
  b=Wv8+UhfCcPqXLnr23K36UMUnQj5ZpB/wQwOeTfkSSczIN2FYCIE3uPTR
   t1x3wCnu9892EjWdkOeQrQpt+b6MFtZ+xTEsI3/JRJGFk7I67oYH5afyR
   kW1g6hOvbLF+LWcGzpWjEBoJhZXLcqneyX18Yah9XLSufaxknwPYOKxdt
   4scbnacZela3/RPoQU9BSYLC/rvJZj72tciOEyiddxiG1hDaCY877IKiS
   zVSDBFFBAfdZLKPRY3AjKZ52FG9zhVh9Nf2WSPGhrx29RDYxmevCbXX7U
   w/uBsRuAsgTfdz+fq756wPprKK9dNXBD7YiaevTdbZK+LrqAAiePTUoFN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="272143607"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="272143607"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 18:40:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="935151737"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 16 Aug 2022 18:40:07 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oO82Q-0000RQ-2L;
        Wed, 17 Aug 2022 01:40:06 +0000
Date:   Wed, 17 Aug 2022 09:39:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 13ad1125b941a5f257d9d3ae70485773abd34792
Message-ID: <62fc46ee.RJB21hzz4bIEqP8E%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 13ad1125b941a5f257d9d3ae70485773abd34792  RDMA/mlx5: Don't compare mkey tags in DEVX indirect mkey

elapsed time: 720m

configs tested: 96
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220815
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arm                                 defconfig
i386                 randconfig-a003-20220815
i386                 randconfig-a002-20220815
i386                 randconfig-a001-20220815
i386                 randconfig-a005-20220815
i386                 randconfig-a004-20220815
i386                 randconfig-a006-20220815
powerpc                          allmodconfig
mips                             allyesconfig
i386                                defconfig
powerpc                           allnoconfig
sh                               allmodconfig
arm                              allyesconfig
x86_64               randconfig-a001-20220815
x86_64               randconfig-a003-20220815
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a005-20220815
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a004-20220815
x86_64                           rhel-8.3-syz
x86_64               randconfig-a002-20220815
x86_64                          rhel-8.3-func
x86_64               randconfig-a006-20220815
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
arm64                            allyesconfig
i386                             allyesconfig
arc                        nsimosci_defconfig
m68k                          atari_defconfig
sh                        dreamcast_defconfig
sh                            migor_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc              randconfig-c003-20220815
i386                 randconfig-c001-20220815
sh                           se7343_defconfig
m68k                                defconfig
powerpc                 mpc837x_rdb_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
arm                         lubbock_defconfig
csky                                defconfig
arm                         vf610m4_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
powerpc                      cm5200_defconfig
ia64                            zx1_defconfig
xtensa                  audio_kc705_defconfig
um                                  defconfig
xtensa                generic_kc705_defconfig
mips                  maltasmvp_eva_defconfig
sh                        sh7757lcr_defconfig
mips                            gpr_defconfig
m68k                        m5407c3_defconfig
sparc                       sparc32_defconfig
m68k                       m5275evb_defconfig
sh                   sh7770_generic_defconfig
parisc                           allyesconfig

clang tested configs:
hexagon              randconfig-r041-20220815
hexagon              randconfig-r045-20220815
s390                 randconfig-r044-20220815
riscv                randconfig-r042-20220815
x86_64               randconfig-a013-20220815
x86_64               randconfig-a012-20220815
x86_64               randconfig-a011-20220815
x86_64               randconfig-a015-20220815
x86_64               randconfig-a014-20220815
x86_64               randconfig-a016-20220815
i386                 randconfig-a012-20220815
i386                 randconfig-a011-20220815
i386                 randconfig-a013-20220815
i386                 randconfig-a015-20220815
i386                 randconfig-a014-20220815
i386                 randconfig-a016-20220815
powerpc                      ppc64e_defconfig
powerpc                 mpc832x_mds_defconfig
arm                       imx_v4_v5_defconfig
mips                           mtx1_defconfig
powerpc                     kilauea_defconfig
s390                             alldefconfig
mips                          ath79_defconfig
arm                    vt8500_v6_v7_defconfig
arm64                            allyesconfig
powerpc                      pmac32_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
