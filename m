Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F1857A649
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jul 2022 20:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbiGSSP1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jul 2022 14:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiGSSP0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jul 2022 14:15:26 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CBF2DD4
        for <linux-rdma@vger.kernel.org>; Tue, 19 Jul 2022 11:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658254526; x=1689790526;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FrJ7t141NOjYKkCzsFs1OWG1/bC4ygttda1u3QLTKng=;
  b=SqupsEcsTfCfIobQjbKndNkm++2Xgn5uPnM484L8pCrvIHhBOFy/xugL
   O4yYnI34YCrlODntjEDMe0LSb0gkwPrBV7Kkl6gm3AdK9vgpkGYkWhTxA
   megrkGLE34ZzHKffWZspm96YPQz/UEsXc+efgrwbMKIlBsotzPgUk7n34
   Hytf1+dxWkXBZt2uBlWndxb9Cr3i7bQ4ECacaq5CeclSIWKk/pynV2Xoj
   UbB4nqis2ZCbXUxOyl3yKCXhIbdSMBGpmGEC0/h8b+JmfRG/8tCNDxtys
   TLNIerf9enkniMWGnFUcT0SVuKSzndUGbCuQJEgjlc6br0IBizmWleP3n
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="284124390"
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="284124390"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 11:15:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="548010529"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 19 Jul 2022 11:15:24 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDrkh-0005sg-CP;
        Tue, 19 Jul 2022 18:15:23 +0000
Date:   Wed, 20 Jul 2022 02:15:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 03905ac2852c577c9d863ed92fa6cc8ffabb2c7b
Message-ID: <62d6f4a8.XKv467uhdtlnNRwv%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 03905ac2852c577c9d863ed92fa6cc8ffabb2c7b  RDMA/rxe: Remove unused mask parameter

elapsed time: 1778m

configs tested: 174
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
i386                 randconfig-c001-20220718
powerpc                     tqm8541_defconfig
sh                          landisk_defconfig
sh                          r7785rp_defconfig
sh                            migor_defconfig
powerpc                      tqm8xx_defconfig
powerpc                  iss476-smp_defconfig
m68k                       m5249evb_defconfig
nios2                            allyesconfig
arm                           corgi_defconfig
powerpc                 mpc834x_mds_defconfig
m68k                         amcore_defconfig
sh                           se7343_defconfig
sh                         microdev_defconfig
arm                          pxa910_defconfig
arm                        oxnas_v6_defconfig
sh                           se7206_defconfig
sparc                       sparc32_defconfig
sh                          sdk7786_defconfig
arm                         axm55xx_defconfig
arc                               allnoconfig
arm                       omap2plus_defconfig
arc                              alldefconfig
m68k                          multi_defconfig
mips                    maltaup_xpa_defconfig
ia64                      gensparse_defconfig
arm                            pleb_defconfig
arm                        mini2440_defconfig
sh                               alldefconfig
arm                          lpd270_defconfig
mips                       bmips_be_defconfig
sh                            titan_defconfig
sh                          rsk7264_defconfig
xtensa                       common_defconfig
sh                        sh7757lcr_defconfig
sparc                             allnoconfig
um                               alldefconfig
arm                        mvebu_v7_defconfig
loongarch                 loongson3_defconfig
sh                        sh7785lcr_defconfig
sh                             sh03_defconfig
arm64                            alldefconfig
m68k                                defconfig
powerpc                     rainier_defconfig
arc                        nsim_700_defconfig
s390                                defconfig
arm                             rpc_defconfig
xtensa                  nommu_kc705_defconfig
arc                           tb10x_defconfig
arm                        keystone_defconfig
powerpc                     stx_gp3_defconfig
powerpc                      ppc6xx_defconfig
arm                        spear6xx_defconfig
arm                            qcom_defconfig
m68k                       m5208evb_defconfig
arm                       imx_v6_v7_defconfig
m68k                        mvme16x_defconfig
mips                         db1xxx_defconfig
arm                             pxa_defconfig
sh                   secureedge5410_defconfig
xtensa                  audio_kc705_defconfig
ia64                          tiger_defconfig
arc                    vdk_hs38_smp_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
powerpc                          allyesconfig
riscv                               defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
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
loongarch                           defconfig
loongarch                         allnoconfig
arm                  randconfig-c002-20220718
x86_64               randconfig-c001-20220718
csky                              allnoconfig
alpha                             allnoconfig
x86_64               randconfig-k001-20220718
arc                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
mips                             allyesconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a014-20220718
x86_64               randconfig-a016-20220718
x86_64               randconfig-a012-20220718
x86_64               randconfig-a013-20220718
x86_64               randconfig-a015-20220718
x86_64               randconfig-a011-20220718
i386                 randconfig-a015-20220718
i386                 randconfig-a011-20220718
i386                 randconfig-a012-20220718
i386                 randconfig-a014-20220718
i386                 randconfig-a016-20220718
i386                 randconfig-a013-20220718
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220718
s390                 randconfig-r044-20220718
riscv                randconfig-r042-20220718
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                      tct_hammer_defconfig
mips                          rm200_defconfig
arm                        mvebu_v5_defconfig
hexagon                          alldefconfig
mips                      bmips_stb_defconfig
powerpc                        fsp2_defconfig
powerpc                     akebono_defconfig
powerpc                    socrates_defconfig
powerpc                   bluestone_defconfig
arm                        vexpress_defconfig
powerpc                      obs600_defconfig
powerpc                     ppa8548_defconfig
arm                          ixp4xx_defconfig
arm                         hackkit_defconfig
arm                        multi_v5_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                 randconfig-a004-20220718
i386                 randconfig-a001-20220718
i386                 randconfig-a005-20220718
i386                 randconfig-a002-20220718
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
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
hexagon              randconfig-r041-20220718
hexagon              randconfig-r045-20220718

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
