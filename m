Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23651520F53
	for <lists+linux-rdma@lfdr.de>; Tue, 10 May 2022 10:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237711AbiEJIFc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 May 2022 04:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237706AbiEJIFR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 May 2022 04:05:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E8741319
        for <linux-rdma@vger.kernel.org>; Tue, 10 May 2022 01:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652169679; x=1683705679;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xU5SnKyJF/CstIhNm/lZ+PRT1U9IzwBcBw8/wBzuQLM=;
  b=QRWzvnHaemLrpvHB9RrnSZBj171RQsXo8Iel2fc2wywwYik3ChdbPR5d
   wBXVimfrBDhUMwk+DTUFLdf967urrTCY8tcu+qP6C7JMBbd17dbfifNe2
   jDnoTzvpLqt3Rp9QIEHKjB585VpqLN+ySeJ4BZ7p4eCZbastWC/+1pIdL
   ZzhX8hnBWvUduWv2r49GocddQgWUVwuKG3pbL0FJsUS+bKKOrVFGxRGu4
   7Wh3haT/SdbRabuTPXYAYvq2KkZbzNj9BtTDUs3+kiP1F3fvXxYcCjWFw
   +MoEHSkOYeGNkU/nmJHfjl+WU2rxtiBgJR40mWy0WcsFcaS4VzpYTfoHC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="332334082"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="332334082"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 01:01:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="602350921"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 10 May 2022 01:01:17 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noKo1-000HXi-8v;
        Tue, 10 May 2022 08:01:17 +0000
Date:   Tue, 10 May 2022 16:01:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 4703b4f0d94a5f887297713a2f6c2916a1ef08fd
Message-ID: <627a1bc1.GL9ifuSUZsPp0nMr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 4703b4f0d94a5f887297713a2f6c2916a1ef08fd  RDMA/rxe: Enforce IBA C11-17

elapsed time: 777m

configs tested: 170
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-c001-20220509
i386                          randconfig-c001
powerpc                        warp_defconfig
sh                           se7721_defconfig
arm                           corgi_defconfig
mips                 decstation_r4k_defconfig
arm                         lubbock_defconfig
parisc                           alldefconfig
sh                          urquell_defconfig
arm                             rpc_defconfig
mips                         cobalt_defconfig
sh                          sdk7780_defconfig
sh                           se7712_defconfig
arm                        clps711x_defconfig
arc                              alldefconfig
sh                          landisk_defconfig
arm                         axm55xx_defconfig
arm                       omap2plus_defconfig
powerpc64                           defconfig
arc                        vdk_hs38_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                             allmodconfig
powerpc                    klondike_defconfig
arm                        realview_defconfig
arc                          axs103_defconfig
sh                             sh03_defconfig
arc                                 defconfig
arm                      footbridge_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                           se7343_defconfig
sh                          kfr2r09_defconfig
arm                             ezx_defconfig
sh                           sh2007_defconfig
xtensa                           allyesconfig
arm                          badge4_defconfig
arm                      integrator_defconfig
powerpc                 mpc8540_ads_defconfig
arm                            xcep_defconfig
powerpc                     taishan_defconfig
arm                      jornada720_defconfig
sh                           se7724_defconfig
m68k                        m5272c3_defconfig
sh                           se7780_defconfig
sh                        edosk7705_defconfig
powerpc                      ppc40x_defconfig
arm                            qcom_defconfig
mips                        vocore2_defconfig
arc                     nsimosci_hs_defconfig
sh                         apsh4a3a_defconfig
s390                                defconfig
mips                         mpc30x_defconfig
powerpc                 linkstation_defconfig
powerpc                 mpc834x_itx_defconfig
s390                       zfcpdump_defconfig
arm                            hisi_defconfig
powerpc                      makalu_defconfig
sh                             espt_defconfig
um                                  defconfig
arm                       aspeed_g5_defconfig
sh                         ecovec24_defconfig
x86_64               randconfig-c001-20220509
arm                  randconfig-c002-20220509
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
parisc                              defconfig
parisc64                            defconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a015-20220509
x86_64               randconfig-a012-20220509
x86_64               randconfig-a016-20220509
x86_64               randconfig-a013-20220509
x86_64               randconfig-a011-20220509
x86_64               randconfig-a014-20220509
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                 randconfig-a011-20220509
i386                 randconfig-a013-20220509
i386                 randconfig-a016-20220509
i386                 randconfig-a015-20220509
i386                 randconfig-a014-20220509
i386                 randconfig-a012-20220509
arc                  randconfig-r043-20220509
s390                 randconfig-r044-20220509
riscv                randconfig-r042-20220509
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c007-20220509
i386                 randconfig-c001-20220509
powerpc              randconfig-c003-20220509
riscv                randconfig-c006-20220509
arm                  randconfig-c002-20220509
mips                 randconfig-c004-20220509
powerpc                     tqm5200_defconfig
arm                                 defconfig
mips                          ath79_defconfig
powerpc                      ppc64e_defconfig
mips                        workpad_defconfig
arm                          pcm027_defconfig
arm                      pxa255-idp_defconfig
hexagon                             defconfig
powerpc                      walnut_defconfig
arm                     am200epdkit_defconfig
mips                            e55_defconfig
arm                       aspeed_g4_defconfig
arm                       versatile_defconfig
arm                         s3c2410_defconfig
arm                          collie_defconfig
powerpc                     tqm8560_defconfig
arm                        vexpress_defconfig
mips                     loongson1c_defconfig
mips                     cu1830-neo_defconfig
x86_64               randconfig-a006-20220509
x86_64               randconfig-a002-20220509
x86_64               randconfig-a001-20220509
x86_64               randconfig-a004-20220509
x86_64               randconfig-a005-20220509
x86_64               randconfig-a003-20220509
i386                 randconfig-a004-20220509
i386                 randconfig-a006-20220509
i386                 randconfig-a002-20220509
i386                 randconfig-a003-20220509
i386                 randconfig-a001-20220509
i386                 randconfig-a005-20220509
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220509
hexagon              randconfig-r041-20220509

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
