Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B782D5A095F
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Aug 2022 09:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbiHYG66 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Aug 2022 02:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236647AbiHYG6y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Aug 2022 02:58:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB68A1D10
        for <linux-rdma@vger.kernel.org>; Wed, 24 Aug 2022 23:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661410732; x=1692946732;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=czreFjrfqzRKjQff3xSfITQyUZrhUxNzuaENEldmQPM=;
  b=nM2ixvYbFzEVmYPETlsnv68gfWccAIo9lU1zskMSqA1KcRH530I4qS9Y
   Meuf5XRb/ziTKLg8kPQtbgXHCkj7Uy1Py/FsK+chfGx4hUNfIa56nbQ5/
   WLpDw4mfN9R4+IyCBzutA8OgpWjSSALoD0Ip/O6/c0MszZE/+JDsNuANn
   FaTHMgOS8cOazHhcve9+WgI2F+QZKsF4K4cqXIqkH5/iz89I47JEqahbi
   5JnujkOppmLnvEzdMafk1gbtFY4iSQRzfNmf9i/xymELka2ri3PbvLNcM
   EgWwviT+Z9qO9Itby9AnIeSXSWXZVWLku8oa5oa3Uxz2sMlsgZOGBWk0T
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="355888964"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="355888964"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 23:58:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="678343233"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 24 Aug 2022 23:58:29 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oR6ou-0001qh-1W;
        Thu, 25 Aug 2022 06:58:28 +0000
Date:   Thu, 25 Aug 2022 14:57:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 3d67e7e236adb4965ff9834bb7125686ecf9654a
Message-ID: <63071d66.AWI7nIRAqrF9UTye%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 3d67e7e236adb4965ff9834bb7125686ecf9654a  RDMA/hns: Support MR's restrack raw ops for hns driver

elapsed time: 1454m

configs tested: 182
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
m68k                             allmodconfig
arc                              allyesconfig
x86_64                        randconfig-a013
alpha                            allyesconfig
x86_64                        randconfig-a011
m68k                             allyesconfig
x86_64                        randconfig-a015
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                randconfig-r042-20220824
i386                                defconfig
arc                  randconfig-r043-20220824
i386                             allyesconfig
mips                             allyesconfig
sh                               allmodconfig
arc                  randconfig-r043-20220823
s390                 randconfig-r044-20220824
loongarch                           defconfig
loongarch                         allnoconfig
x86_64                              defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                           allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                          randconfig-a001
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          randconfig-c001
i386                          randconfig-a003
sh                        sh7763rdp_defconfig
m68k                          multi_defconfig
arc                      axs103_smp_defconfig
m68k                            mac_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
i386                          randconfig-a005
arm                       omap2plus_defconfig
arc                          axs101_defconfig
arc                         haps_hs_defconfig
m68k                        m5272c3_defconfig
m68k                          atari_defconfig
sh                          sdk7786_defconfig
powerpc                    klondike_defconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
i386                          randconfig-a012
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
i386                          randconfig-a014
i386                          randconfig-a016
sparc                             allnoconfig
microblaze                          defconfig
m68k                        mvme16x_defconfig
m68k                         apollo_defconfig
arm                        shmobile_defconfig
parisc64                         alldefconfig
sh                          kfr2r09_defconfig
xtensa                          iss_defconfig
arm                            hisi_defconfig
ia64                          tiger_defconfig
mips                      loongson3_defconfig
arm                             rpc_defconfig
arc                        nsim_700_defconfig
sh                   sh7770_generic_defconfig
arm                          gemini_defconfig
arm                            lart_defconfig
m68k                       m5249evb_defconfig
sh                             espt_defconfig
arm64                               defconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig
m68k                            q40_defconfig
ia64                        generic_defconfig
sh                             shx3_defconfig
arc                     nsimosci_hs_defconfig
ia64                             allmodconfig
um                                  defconfig
microblaze                      mmu_defconfig
arm                        realview_defconfig
sh                          r7780mp_defconfig
sh                        edosk7760_defconfig
sh                           se7751_defconfig
powerpc                      arches_defconfig
m68k                        stmark2_defconfig
sh                           se7721_defconfig
powerpc                      pcm030_defconfig
arc                    vdk_hs38_smp_defconfig
arm                            zeus_defconfig
s390                          debug_defconfig
ia64                            zx1_defconfig
sh                          rsk7269_defconfig
mips                        bcm47xx_defconfig
csky                             alldefconfig
ia64                      gensparse_defconfig
xtensa                         virt_defconfig
sh                   sh7724_generic_defconfig
powerpc                      makalu_defconfig
arm                            pleb_defconfig
arm                      integrator_defconfig
sh                         apsh4a3a_defconfig
sh                           se7722_defconfig
arm                           viper_defconfig
sh                   secureedge5410_defconfig
sh                         ap325rxa_defconfig
xtensa                    smp_lx200_defconfig
sh                      rts7751r2d1_defconfig
sh                            titan_defconfig
mips                         cobalt_defconfig
powerpc                      tqm8xx_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220824
mips                    maltaup_xpa_defconfig
sh                         ecovec24_defconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r045-20220824
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
riscv                randconfig-r042-20220823
hexagon              randconfig-r045-20220823
x86_64                        randconfig-a005
hexagon              randconfig-r041-20220823
hexagon              randconfig-r041-20220824
s390                 randconfig-r044-20220823
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
mips                     loongson1c_defconfig
powerpc                     ppa8548_defconfig
powerpc                  mpc866_ads_defconfig
x86_64                        randconfig-k001
mips                     cu1000-neo_defconfig
powerpc                    gamecube_defconfig
mips                     decstation_defconfig
mips                           ci20_defconfig
riscv                            alldefconfig
powerpc                      ppc64e_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                     tqm8540_defconfig
arm                      pxa255-idp_defconfig
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
