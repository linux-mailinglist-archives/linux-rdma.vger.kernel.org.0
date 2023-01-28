Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F88367F8A5
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Jan 2023 15:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjA1OYh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Jan 2023 09:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbjA1OYh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 28 Jan 2023 09:24:37 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2109A5D1
        for <linux-rdma@vger.kernel.org>; Sat, 28 Jan 2023 06:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674915876; x=1706451876;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GzL4EX/18zYgBY6p6khgX4eiaKrH7WtNPIpIvp69xKg=;
  b=DybctBeIcmCi9znttEPQrxtoeSxVkjwu32rQaww8EkX80JaQcdzxTKwg
   a9LBipK4fN2txAlKzC5gwnRjgOAsSXLGzoRDTnofqQDmrcGAVr7H0tTgN
   RtRARRdSfOuWP3yWLiUDY3qjgbOv0jPVkYrp6EtiQ1EEun3w+Xg/kOo0c
   ktgfXficxikhmd7X+JC/CLOoLkaQLlIrolb+mqotp0/t+nN8u5CUllc5Y
   7WDrSFB363V+5XW68sLL02i0zVYB/rQRvmsrpoxagzdR+ajPk1mEZmG/O
   AzGw3SB1k7pXVuM7kvF0VKz88hxqmFKRdt8HOa7VgG+yGP4FV/IcjgPf2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="324987216"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="324987216"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 06:24:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="656941424"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="656941424"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Jan 2023 06:24:34 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLm89-0000mC-1K;
        Sat, 28 Jan 2023 14:24:33 +0000
Date:   Sat, 28 Jan 2023 22:24:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 e632291a2dbce45a24cddeb5fe28fe71d724ba43
Message-ID: <63d53016.Nkp33BDq1z9+SiDX%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: e632291a2dbce45a24cddeb5fe28fe71d724ba43  IB/IPoIB: Fix legacy IPoIB due to wrong number of queues

elapsed time: 738m

configs tested: 97
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
i386                                defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64               randconfig-a002-20230123
x86_64               randconfig-a005-20230123
x86_64               randconfig-a001-20230123
x86_64               randconfig-a006-20230123
x86_64               randconfig-a003-20230123
x86_64               randconfig-a004-20230123
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                 randconfig-a004-20230123
i386                 randconfig-a006-20230123
i386                 randconfig-a005-20230123
i386                 randconfig-a002-20230123
i386                 randconfig-a003-20230123
i386                 randconfig-a001-20230123
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
ia64                             allmodconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                 randconfig-c001-20230123
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          randconfig-c001
m68k                         amcore_defconfig
powerpc                      makalu_defconfig
m68k                        mvme147_defconfig
m68k                          amiga_defconfig
mips                          rb532_defconfig
arc                        nsim_700_defconfig
sh                           se7724_defconfig
sh                            shmin_defconfig
sh                        sh7763rdp_defconfig
sh                          rsk7264_defconfig
arm                          exynos_defconfig
xtensa                  nommu_kc705_defconfig
arc                      axs103_smp_defconfig
xtensa                    smp_lx200_defconfig
s390                          debug_defconfig

clang tested configs:
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
x86_64               randconfig-a016-20230123
x86_64               randconfig-a012-20230123
x86_64               randconfig-a015-20230123
x86_64               randconfig-a014-20230123
riscv                randconfig-r042-20230123
hexagon              randconfig-r041-20230123
hexagon              randconfig-r045-20230123
s390                 randconfig-r044-20230123
i386                 randconfig-a013-20230123
i386                 randconfig-a016-20230123
i386                 randconfig-a012-20230123
i386                 randconfig-a015-20230123
i386                 randconfig-a011-20230123
i386                 randconfig-a014-20230123
powerpc                      walnut_defconfig
arm                        mvebu_v5_defconfig
arm                           sama7_defconfig
x86_64                          rhel-8.3-rust
powerpc                 mpc832x_mds_defconfig
hexagon              randconfig-r041-20230124
hexagon              randconfig-r045-20230124
arm                  randconfig-r046-20230124
mips                        maltaup_defconfig
arm                         palmz72_defconfig
powerpc                    gamecube_defconfig
x86_64               randconfig-k001-20230123

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
