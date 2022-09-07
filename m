Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446A45AFABB
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 05:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiIGDnD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Sep 2022 23:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGDnD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Sep 2022 23:43:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C70915D7
        for <linux-rdma@vger.kernel.org>; Tue,  6 Sep 2022 20:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662522182; x=1694058182;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=bcRYr6E7wGZI+81ZzeCULkJ09U/wKVRYNkJwtnf6P5M=;
  b=OyttcUGdx4ErzcIt97EvPIstEnybEC0O2n+Bo1wx6vHHNOSIxSRbamtt
   pIaEtPh9MviYkbRQ1+/92RCVDpg6+nD8luBdpCYjJmdLW9AYtqK0so41r
   nvaovMECTj/KfHtC2WSSq/kbrUJ8drhBppVYVv6ipjSPYw32LtfSaV1K9
   hBzn1Ka0F8pQyFXKIIB9pUjrH8sQt8kkoo1VmPbYEBC6rS7zdSAHsEXw2
   KXAlB8YwUinTNhsTmaNNoiKhE+y4La4I85hMvu7y/mpdVQwIkTP7a490s
   H5TcAwZw5eYNn4WVqCRyMVtWbrKQ9IYmTkLVNU0ZCUitoinz7J189WOO8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="294355179"
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="294355179"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 20:43:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="682652148"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 06 Sep 2022 20:43:00 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVlxr-00063i-2v;
        Wed, 07 Sep 2022 03:42:59 +0000
Date:   Wed, 07 Sep 2022 11:42:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 db77d84cfe3608eac938302f8f7178e44415bcba
Message-ID: <63181318.M8WDiGw3lGXPnmmF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: db77d84cfe3608eac938302f8f7178e44415bcba  RDMA/rtrs-clt: Kill xchg_paths

elapsed time: 941m

configs tested: 155
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
i386                             allyesconfig
i386                                defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220906
arc                  randconfig-r043-20220906
s390                 randconfig-r044-20220906
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
sh                               j2_defconfig
arm                       aspeed_g5_defconfig
m68k                          multi_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
sh                           se7780_defconfig
mips                           xway_defconfig
powerpc                       holly_defconfig
sparc64                             defconfig
parisc                generic-32bit_defconfig
arc                         haps_hs_defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-c001
arm                           tegra_defconfig
arm                          gemini_defconfig
sh                         ecovec24_defconfig
xtensa                generic_kc705_defconfig
sh                          polaris_defconfig
sh                   sh7770_generic_defconfig
ia64                                defconfig
powerpc                    klondike_defconfig
ia64                            zx1_defconfig
sh                          r7780mp_defconfig
sparc                       sparc64_defconfig
parisc64                            defconfig
powerpc                 canyonlands_defconfig
arm                           viper_defconfig
powerpc                    adder875_defconfig
sh                        dreamcast_defconfig
sh                          lboxre2_defconfig
powerpc                      bamboo_defconfig
powerpc                      makalu_defconfig
csky                             alldefconfig
m68k                                defconfig
powerpc                     pq2fads_defconfig
xtensa                          iss_defconfig
powerpc                    amigaone_defconfig
arm                        cerfcube_defconfig
sparc                            allyesconfig
sh                           se7705_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc                           allyesconfig
sh                           se7750_defconfig
sparc64                          alldefconfig
arm                             ezx_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220906
arm                          iop32x_defconfig
mips                           ip32_defconfig
nios2                         10m50_defconfig
arc                          axs103_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
x86_64                                  kexec
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                mpc7448_hpc2_defconfig
alpha                               defconfig
arm                           sama5_defconfig
powerpc                     tqm8548_defconfig
sh                            titan_defconfig
sh                     sh7710voipgw_defconfig
ia64                          tiger_defconfig
sh                         ap325rxa_defconfig
m68k                        mvme16x_defconfig
powerpc                 mpc837x_mds_defconfig
sh                          rsk7264_defconfig
sh                 kfr2r09-romimage_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
s390                             allmodconfig
riscv             nommu_k210_sdcard_defconfig
xtensa                              defconfig
arm                         lubbock_defconfig
m68k                       m5475evb_defconfig
sh                        edosk7705_defconfig
xtensa                  nommu_kc705_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
s390                                defconfig
arc                                 defconfig
s390                             allyesconfig
ia64                             allmodconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
powerpc                    mvme5100_defconfig
arm                             mxs_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                            mmp2_defconfig
powerpc                      acadia_defconfig
powerpc                     pseries_defconfig
arm                        neponset_defconfig
hexagon              randconfig-r041-20220906
hexagon              randconfig-r045-20220906
powerpc                     kilauea_defconfig
powerpc                     akebono_defconfig
powerpc                   lite5200b_defconfig
powerpc                     tqm5200_defconfig
powerpc                     mpc512x_defconfig
arm                           spitz_defconfig
arm                       spear13xx_defconfig
mips                      malta_kvm_defconfig
arm                    vt8500_v6_v7_defconfig
arm                     davinci_all_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
