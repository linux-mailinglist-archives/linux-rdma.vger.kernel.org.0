Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519AA649784
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Dec 2022 01:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiLLA4m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Dec 2022 19:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLLA4l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Dec 2022 19:56:41 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530196358
        for <linux-rdma@vger.kernel.org>; Sun, 11 Dec 2022 16:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670806600; x=1702342600;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=LZhgY+8EZ2v8aGMqu2oHIfDC6Il4AVdVG4aV/vqr29U=;
  b=fB5qTj3uTO3NYe8Hffn3S+grQWhocuwTattE5EcZ/zuV3+SrU14m5wN3
   ozPlBdk3GWfSXKotb2qY+8K4+MmCgFhW+mfKBpW4GCUJqHFKcb15E2cIA
   /8IxDFCk9NpFm9hbEWlqEAF4H7hhi9NweaBzCecVxIxLTpzLR30EP1GXu
   ie/OlnYupYMngMgTszShVlCHTQUD22uZTPkfOK5D39CUFEoPdzwH9QgrP
   XwkaoQ/okJ/OK3oXakkiiTaL6LAtn59kVVP6cchBk6e5Heg4XBEkvvHWy
   6FGOKMKTtNLsAKhvPkvQ+W2mJW3ZFy/b8kSYpsiCOGqnljesRO5bFIL5g
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="316436518"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="316436518"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 16:56:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="822313727"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="822313727"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 11 Dec 2022 16:56:38 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p4X7V-0003L9-1m;
        Mon, 12 Dec 2022 00:56:37 +0000
Date:   Mon, 12 Dec 2022 08:55:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 dbc94a0fb81771a38733c0e8f2ea8c4fa6934dc1
Message-ID: <63967c11.xfsw10gmswY0Q8Y+%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: dbc94a0fb81771a38733c0e8f2ea8c4fa6934dc1  IB/IPoIB: Fix queue count inconsistency for PKEY child interfaces

elapsed time: 739m

configs tested: 108
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                  randconfig-r043-20221211
arm                  randconfig-r046-20221211
i386                                defconfig
i386                          randconfig-a014
um                           x86_64_defconfig
i386                          randconfig-a012
x86_64                        randconfig-a006
i386                             allyesconfig
x86_64                        randconfig-a013
um                             i386_defconfig
i386                          randconfig-a016
x86_64                              defconfig
x86_64                        randconfig-a011
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a015
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a004
x86_64                          rhel-8.3-func
x86_64                            allnoconfig
x86_64                        randconfig-a002
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
i386                          randconfig-a005
x86_64                           allyesconfig
m68k                             allmodconfig
x86_64                           rhel-8.3-bpf
arc                              allyesconfig
ia64                             allmodconfig
alpha                            allyesconfig
arc                                 defconfig
s390                             allmodconfig
x86_64                           rhel-8.3-syz
m68k                             allyesconfig
x86_64                         rhel-8.3-kunit
alpha                               defconfig
x86_64                           rhel-8.3-kvm
s390                                defconfig
s390                             allyesconfig
arm                                 defconfig
mips                           jazz_defconfig
powerpc                           allnoconfig
arm                            zeus_defconfig
powerpc                          allmodconfig
mips                             allyesconfig
loongarch                        alldefconfig
sh                           se7722_defconfig
sh                               allmodconfig
arc                        nsim_700_defconfig
arm                              allyesconfig
ia64                            zx1_defconfig
arm64                            allyesconfig
arm                        realview_defconfig
powerpc                     tqm8555_defconfig
alpha                            alldefconfig
powerpc                      chrp32_defconfig
powerpc                  storcenter_defconfig
sparc                            alldefconfig
arm                         nhk8815_defconfig
i386                          randconfig-c001
powerpc                       ppc64_defconfig
powerpc                 mpc8540_ads_defconfig
sh                             espt_defconfig
xtensa                    xip_kc705_defconfig
sparc                               defconfig
powerpc                         wii_defconfig
nios2                         10m50_defconfig
nios2                               defconfig
mips                          rb532_defconfig
arm                        multi_v7_defconfig
sh                        edosk7760_defconfig
arc                            hsdk_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
hexagon              randconfig-r041-20221211
i386                          randconfig-a013
hexagon              randconfig-r045-20221211
riscv                randconfig-r042-20221211
i386                          randconfig-a011
s390                 randconfig-r044-20221211
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a001
i386                          randconfig-a002
x86_64                        randconfig-a003
i386                          randconfig-a006
mips                     loongson2k_defconfig
mips                  cavium_octeon_defconfig
powerpc                     kmeter1_defconfig
arm                            mmp2_defconfig
arm                          ixp4xx_defconfig
arm                        multi_v5_defconfig
powerpc                     tqm5200_defconfig
arm                     davinci_all_defconfig
mips                           rs90_defconfig
x86_64                        randconfig-k001
mips                        omega2p_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
