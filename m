Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FB35A405D
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 02:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiH2Adr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Aug 2022 20:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2Adq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Aug 2022 20:33:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4102FFF4
        for <linux-rdma@vger.kernel.org>; Sun, 28 Aug 2022 17:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661733225; x=1693269225;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Cpk/nrV5Byynf8CcQ5xFSH/5pCaj5Khm3hfy6qemcQc=;
  b=ivvVQJq44MllqIqkDzB4CK/v6J1NAUYKMHjWDUaxhgs0/rfM1ZglrHaZ
   1t2CwpMxDj5RbzQpDz+owzMuB4ANfL/BdFFFPBzom3qEGstKG69O+SLce
   QyYvIC0JUfd6QMs/Bp8wcoYSRvWsSvRar/aQpEsogd1uKxhyNcSs+ADPS
   UJA08JF0sKLiHQDFCxxowff5rEg+WfLTmxDWBtC8lwr1rOpNFcVIgm16d
   4Y8zthpt7ObP9YzG7IILvHSjhe1jurGkpSaH57UB8QgCulO2YoGYBhdGX
   M8oJXDS0KFipcQLCTvSHyy76AleGRtiYGlLg6n8Z9pJZYnCh72HvMt8WA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="292361938"
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="292361938"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 17:33:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="587964350"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Aug 2022 17:33:43 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSSik-0001o3-2K;
        Mon, 29 Aug 2022 00:33:42 +0000
Date:   Mon, 29 Aug 2022 08:33:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 05195dcb43504e381bf383e837fc935aac4258cc
Message-ID: <630c0965.WsmApCstDvhlyTAw%lkp@intel.com>
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
branch HEAD: 05195dcb43504e381bf383e837fc935aac4258cc  RDMA/core: Remove 'device' argument from rdma_build_skb()

elapsed time: 725m

configs tested: 132
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                        randconfig-a013
x86_64                        randconfig-a011
loongarch                         allnoconfig
arc                  randconfig-r043-20220828
loongarch                           defconfig
um                             i386_defconfig
x86_64                        randconfig-a015
um                           x86_64_defconfig
s390                 randconfig-r044-20220828
riscv                randconfig-r042-20220828
arc                               allnoconfig
alpha                             allnoconfig
csky                              allnoconfig
riscv                             allnoconfig
arm                            pleb_defconfig
nios2                               defconfig
nios2                            allyesconfig
sh                           sh2007_defconfig
parisc64                            defconfig
parisc                              defconfig
i386                         debian-10.3-func
arm                                 defconfig
parisc                           allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                          randconfig-a016
powerpc                           allnoconfig
riscv                            allmodconfig
x86_64                        randconfig-a002
riscv                          rv32_defconfig
arm64                            allyesconfig
mips                         bigsur_defconfig
arm                              allyesconfig
alpha                            allyesconfig
sh                               allmodconfig
alpha                               defconfig
x86_64                    rhel-8.3-kselftests
s390                             allyesconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
sh                            titan_defconfig
csky                                defconfig
arc                                 defconfig
powerpc                          allyesconfig
x86_64                           rhel-8.3-syz
arc                              allyesconfig
riscv                            allyesconfig
s390                                defconfig
x86_64                        randconfig-a004
riscv                    nommu_virt_defconfig
mips                           ip32_defconfig
i386                          randconfig-a012
riscv                               defconfig
x86_64                              defconfig
sh                           se7750_defconfig
i386                          randconfig-a003
sparc                               defconfig
i386                          randconfig-a005
i386                              debian-10.3
x86_64                           allyesconfig
i386                                defconfig
x86_64                          rhel-8.3-func
m68k                                defconfig
x86_64                                  kexec
x86_64                        randconfig-a006
s390                             allmodconfig
x86_64                         rhel-8.3-kunit
sparc                            allyesconfig
arm64                               defconfig
sh                        sh7763rdp_defconfig
x86_64                               rhel-8.3
powerpc                      ep88xc_defconfig
powerpc                          allmodconfig
ia64                                defconfig
i386                          randconfig-a014
x86_64                           rhel-8.3-kvm
m68k                             allyesconfig
arm                        shmobile_defconfig
mips                             allyesconfig
xtensa                           allyesconfig
powerpc                    adder875_defconfig
i386                          randconfig-a001
ia64                          tiger_defconfig
m68k                             allmodconfig
xtensa                              defconfig
arm                          pxa3xx_defconfig
arm                           h5000_defconfig
sh                      rts7751r2d1_defconfig
sh                          sdk7786_defconfig
mips                      maltasmvp_defconfig
i386                             allyesconfig
openrisc                            defconfig
sparc                       sparc32_defconfig
ia64                             allmodconfig
i386                          randconfig-c001
ia64                             allyesconfig
arm                              allmodconfig
mips                             allmodconfig
powerpc                      mgcoge_defconfig
mips                         cobalt_defconfig
s390                       zfcpdump_defconfig
arm                           stm32_defconfig
riscv             nommu_k210_sdcard_defconfig
arc                          axs103_defconfig
openrisc                 simple_smp_defconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a012
hexagon              randconfig-r041-20220828
hexagon              randconfig-r045-20220828
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
arm                         bcm2835_defconfig
x86_64                        randconfig-a001
arm                       netwinder_defconfig
mips                        qi_lb60_defconfig
powerpc                    ge_imp3a_defconfig
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a006
powerpc                     skiroot_defconfig
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
hexagon                          alldefconfig
arm                          ep93xx_defconfig
arm                     am200epdkit_defconfig
mips                   sb1250_swarm_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                          collie_defconfig
mips                           rs90_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
