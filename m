Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DBA628AF2
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Nov 2022 22:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbiKNVAr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Nov 2022 16:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbiKNVAq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Nov 2022 16:00:46 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8C5C24
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 13:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668459645; x=1699995645;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=F4LIqiitcL1Z0Wtk4d3UCJ8SNOCFZARdeF8K0Mzkmls=;
  b=fw5mGQoJnVrdMH/TAFZiXUWeltmBourZZ5vwqKtRAOk5Kb2Zhkof3P4u
   0tfq2+HCUTHLljClceJkThtRBYCQR729ckHLff13IxFHK8l9BaS77IC/2
   AZ5Hq8OKRjKoklAdwyt1dj0Gvy8fdRXMSTPA4mxD0otebsHQmfkVCLbn8
   twRcds84k/EoFLyFySmLUyG38MahaWtO0dliCvb0eFRQaVet6YOboxTAs
   W4kjCQ/hqD9Lp2mC7eQSamDEDxOEbKnKuGfzRNI6AGR8kOV+BDBQKUoan
   8uSIVjIT6w5v2xoVtLWzHU/8HtdXKI1EeAVHHT5MwunKJamQaXXXuZCe0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="309709582"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="309709582"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 13:00:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="669818337"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="669818337"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 14 Nov 2022 13:00:43 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ougZO-0000k7-2e;
        Mon, 14 Nov 2022 21:00:42 +0000
Date:   Tue, 15 Nov 2022 04:59:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 3574cfdca28543e2e8db649297cd6659ea8e4bb8
Message-ID: <6372ac47.w06LBFfoFxmjNcTB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 3574cfdca28543e2e8db649297cd6659ea8e4bb8  RDMA/mana: Remove redefinition of basic u64 type

elapsed time: 721m

configs tested: 85
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
i386                                defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
arm                                 defconfig
s390                             allyesconfig
arc                  randconfig-r043-20221114
sh                               allmodconfig
i386                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a002-20221114
x86_64               randconfig-a001-20221114
x86_64               randconfig-a004-20221114
x86_64               randconfig-a005-20221114
x86_64               randconfig-a003-20221114
x86_64               randconfig-a006-20221114
i386                 randconfig-a006-20221114
x86_64                            allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                 randconfig-a002-20221114
i386                 randconfig-a004-20221114
i386                 randconfig-a003-20221114
i386                 randconfig-a005-20221114
i386                 randconfig-a001-20221114
mips                      loongson3_defconfig
sh                        edosk7760_defconfig
csky                                defconfig
powerpc                      ppc6xx_defconfig
sh                           se7343_defconfig
powerpc                    adder875_defconfig
ia64                          tiger_defconfig
powerpc                     sequoia_defconfig
sh                          rsk7201_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
arm64                            allyesconfig
arm                              allyesconfig
xtensa                         virt_defconfig
sh                            shmin_defconfig
xtensa                              defconfig
mips                        vocore2_defconfig
ia64                             allmodconfig
i386                 randconfig-c001-20221114
arm                           sunxi_defconfig
arm                               allnoconfig
loongarch                 loongson3_defconfig
arc                         haps_hs_defconfig
mips                  decstation_64_defconfig
powerpc                    sam440ep_defconfig
sparc64                          alldefconfig

clang tested configs:
hexagon              randconfig-r045-20221114
hexagon              randconfig-r041-20221114
riscv                randconfig-r042-20221114
i386                 randconfig-a011-20221114
i386                 randconfig-a013-20221114
i386                 randconfig-a012-20221114
i386                 randconfig-a015-20221114
i386                 randconfig-a014-20221114
i386                 randconfig-a016-20221114
x86_64               randconfig-a012-20221114
x86_64               randconfig-a013-20221114
x86_64               randconfig-a016-20221114
x86_64               randconfig-a014-20221114
x86_64               randconfig-a015-20221114
x86_64               randconfig-a011-20221114
mips                           mtx1_defconfig
powerpc                 mpc8560_ads_defconfig
x86_64               randconfig-k001-20221114
powerpc                     mpc512x_defconfig
arm                        magician_defconfig
s390                 randconfig-r044-20221114

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
