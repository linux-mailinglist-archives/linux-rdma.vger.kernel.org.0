Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBF65BF7CD
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Sep 2022 09:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiIUHgL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Sep 2022 03:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiIUHgL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Sep 2022 03:36:11 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856697F265
        for <linux-rdma@vger.kernel.org>; Wed, 21 Sep 2022 00:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663745770; x=1695281770;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=a25cyIk6FxBE+GvCMYOPNYFiCOtAxz7OZS4i6uKMbH8=;
  b=dzEmJKRR38pZPN1mmMIfcdT5PT/73Cu5pMouaRlphTg7gIvYWiGx0435
   8e+pkq7STl8pH1rUU/jSvtODd2AXxlfGK+SGWyoXWndKX7C7KLjDW1usY
   MJnPuzovHziEvXATTlRxmVjNEDUkiEA8s05PAF6ccMUf7vEado0oB94Wv
   +WDhCtn7U4NVt4MgYV0w4+2NsH1sbXQuhvFuWQ8VLa1iSI0R6+oYrPLRb
   lImf/zhhnnUcgv0jtqKXA9VRtLL5VHFLXFVzBfSk7GaAE5AwJ7jfjZzMN
   f4+Qztjy7JkGq7SMeqpLdK//8c9Htkql5U0TQkDdrlUico/Bt1vN9TL3T
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="279654516"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="279654516"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 00:36:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="948031622"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 21 Sep 2022 00:36:08 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oauHA-0003Mr-0g;
        Wed, 21 Sep 2022 07:36:08 +0000
Date:   Wed, 21 Sep 2022 15:36:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 a3c278807a459e6f50afee6971cabe74cccfb490
Message-ID: <632abee6.kSww16dbNhIMk/bU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: a3c278807a459e6f50afee6971cabe74cccfb490  RDMA/siw: Fix QP destroy to wait for all references dropped.

elapsed time: 758m

configs tested: 111
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
arc                  randconfig-r043-20220921
riscv                randconfig-r042-20220921
s390                 randconfig-r044-20220921
alpha                            allyesconfig
arc                              allyesconfig
i386                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
i386                             allyesconfig
ia64                             allmodconfig
ia64                        generic_defconfig
sh                   rts7751r2dplus_defconfig
sh                          rsk7203_defconfig
nios2                         3c120_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm                          simpad_defconfig
powerpc                    sam440ep_defconfig
sh                             espt_defconfig
arm                            xcep_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
ia64                          tiger_defconfig
powerpc                  iss476-smp_defconfig
m68k                            q40_defconfig
sparc                       sparc64_defconfig
openrisc                         alldefconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
m68k                         amcore_defconfig
powerpc                         ps3_defconfig
s390                          debug_defconfig
sh                          sdk7780_defconfig
m68k                           virt_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sh                        sh7763rdp_defconfig
sparc64                             defconfig
powerpc                      makalu_defconfig
m68k                        mvme147_defconfig
sh                           se7705_defconfig
m68k                            mac_defconfig
arm                        mini2440_defconfig
arc                        nsimosci_defconfig
powerpc                     tqm8541_defconfig
arm                             ezx_defconfig
mips                         cobalt_defconfig
sparc                             allnoconfig
microblaze                      mmu_defconfig
arc                      axs103_smp_defconfig
i386                 randconfig-c001-20220919
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
m68k                       m5275evb_defconfig
loongarch                 loongson3_defconfig

clang tested configs:
hexagon              randconfig-r041-20220921
hexagon              randconfig-r045-20220921
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-k001
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
arm                        multi_v5_defconfig
mips                        bcm63xx_defconfig
powerpc                          allyesconfig
powerpc                      acadia_defconfig
mips                      pic32mzda_defconfig
riscv                             allnoconfig
mips                           ip28_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
