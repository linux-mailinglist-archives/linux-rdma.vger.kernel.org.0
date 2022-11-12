Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F49F6265DF
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Nov 2022 01:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbiKLAMa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Nov 2022 19:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbiKLAM2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Nov 2022 19:12:28 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C05CE1
        for <linux-rdma@vger.kernel.org>; Fri, 11 Nov 2022 16:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668211948; x=1699747948;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ntf6UNU5gA3koc43JOGOufFink2DzxYQpyqF8mGvogE=;
  b=led15tENNqhjTlMJdZfavles/2UAVx0kBgIPxPCYSe3XBo/MmNVTQsBH
   k8mPr/yPQ778NTNQkZyDSqew4iyd/qyEw0o1SmTOQlJpBWbskzLvjuK3K
   mqHSeFiZhysCU7JJ0DTfabSus/+1pI1lzObHHdGhph6uCfkacgDTYUgCc
   YnPv5KvmKm7ZS869XbTEXQ1lWgVNkCuhwdWGYj9nfMI8jD4Gy46ahF1rL
   f61aqPi1U9YHVIZZMobZ8NSfLnDukuseXxTSNIN1gs5/j6kaX0MCnrU5x
   FbeQ8cam6BgidFMonkflBXQ4Dd2kIsNmNBfluiG1Z81TjDqJ4flSJvBlc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="375950574"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="375950574"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 16:12:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="743431624"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="743431624"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 11 Nov 2022 16:12:25 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ote8H-0004OJ-12;
        Sat, 12 Nov 2022 00:12:25 +0000
Date:   Sat, 12 Nov 2022 08:11:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 0266a177631d4c6b963b5b12dd986a8c5abdbf06
Message-ID: <636ee4af.xj6TG1WCAsL6U19r%lkp@intel.com>
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
branch HEAD: 0266a177631d4c6b963b5b12dd986a8c5abdbf06  RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter

elapsed time: 752m

configs tested: 97
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                        randconfig-a002
x86_64                          rhel-8.3-func
um                           x86_64_defconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                                defconfig
m68k                             allmodconfig
arm                                 defconfig
i386                          randconfig-a001
arc                              allyesconfig
arc                                 defconfig
x86_64                           rhel-8.3-syz
s390                             allmodconfig
powerpc                           allnoconfig
alpha                            allyesconfig
x86_64                         rhel-8.3-kunit
mips                             allyesconfig
alpha                               defconfig
powerpc                          allmodconfig
s390                                defconfig
x86_64                           rhel-8.3-kvm
m68k                             allyesconfig
arm                              allyesconfig
i386                          randconfig-a003
arc                  randconfig-r043-20221111
riscv                randconfig-r042-20221111
sh                               allmodconfig
arm64                            allyesconfig
i386                          randconfig-a005
s390                 randconfig-r044-20221111
x86_64                               rhel-8.3
i386                             allyesconfig
s390                             allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
arc                          axs103_defconfig
powerpc                 mpc834x_mds_defconfig
openrisc                         alldefconfig
i386                          randconfig-a014
i386                          randconfig-a012
ia64                             allmodconfig
i386                          randconfig-a016
x86_64                            allnoconfig
arm                      integrator_defconfig
sh                           se7724_defconfig
arc                          axs101_defconfig
loongarch                 loongson3_defconfig
sh                         apsh4a3a_defconfig
loongarch                        alldefconfig
nios2                               defconfig
arm                            pleb_defconfig
i386                          randconfig-c001
arm                       imx_v6_v7_defconfig
mips                 decstation_r4k_defconfig
arm                        oxnas_v6_defconfig
mips                 randconfig-c004-20221111
m68k                          hp300_defconfig
arm                         at91_dt_defconfig
sh                          r7780mp_defconfig
arm                           u8500_defconfig
mips                           gcw0_defconfig
mips                     loongson1b_defconfig
arm                           sunxi_defconfig
mips                            gpr_defconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r045-20221111
hexagon              randconfig-r041-20221111
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001
arm                           sama7_defconfig
arm                          pcm027_defconfig
arm                           omap1_defconfig
arm                       netwinder_defconfig
mips                        qi_lb60_defconfig
mips                  cavium_octeon_defconfig
powerpc                     skiroot_defconfig
powerpc                  mpc866_ads_defconfig
riscv                            alldefconfig
powerpc                      ppc44x_defconfig
mips                           rs90_defconfig
arm                          sp7021_defconfig
powerpc                 mpc8560_ads_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
