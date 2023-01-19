Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4D2674ABF
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jan 2023 05:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjATEdl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Jan 2023 23:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjATEdR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Jan 2023 23:33:17 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33657B4E12
        for <linux-rdma@vger.kernel.org>; Thu, 19 Jan 2023 20:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674189159; x=1705725159;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=A3jVD1YvrNsZWiWXDo2s/VyTl8gwaH5Skeq707Ug/AA=;
  b=n6XqIJ/1LA1C5sgc/QBt20mjpWKG6CKbsL0vcmyYjcpKpgMVFrTr39UW
   zLbGHqVRqpkcXN+ccbyd3h42ejbSqviqAsKUuquuSasLv6EkpT1IW/PX8
   ltYYxYe5pOzxYqOT0AeqCkBWzO9lrYylukbjKNFnqXDk977Z+kd30fbcb
   foFqieFrqPdKhtSRVvkHa+2h/VcHIT4oCGKV25DjWdtCKm7yAZ1hlOMGb
   6+G1XM10nA6ruelfqK8Et5NHhTxkBm2K9NWmgQSbG5HKl+e2GbGZj6TYZ
   e6y2A/+4eaxE6xZ7asU0gGdLFpuz8wkIT7Dp2wl8B8AO2uVWwjfX/69uP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="411436629"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="411436629"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 21:00:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="661997220"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="661997220"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jan 2023 21:00:33 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIN2O-00016u-2Y;
        Thu, 19 Jan 2023 05:00:32 +0000
Date:   Thu, 19 Jan 2023 12:59:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD SUCCESS
 0f097f08c9b3c1fdb6cc9f2dd423abc17d13f1a2
Message-ID: <63c8ce47.S9ePHk1CaPDFHsw6%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: 0f097f08c9b3c1fdb6cc9f2dd423abc17d13f1a2  lib/scatterlist: Fix to calculate the last_pg properly

elapsed time: 730m

configs tested: 78
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
arc                              allyesconfig
alpha                            allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                                 defconfig
alpha                               defconfig
arm                                 defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
s390                             allmodconfig
s390                                defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
arm64                            allyesconfig
arm                              allyesconfig
s390                             allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20230118
s390                 randconfig-r044-20230118
arc                  randconfig-r043-20230118
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
powerpc                      mgcoge_defconfig
sh                        dreamcast_defconfig
sh                           se7722_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                          randconfig-c001
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
sh                                  defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                              defconfig
parisc                           allyesconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
arm                       omap2plus_defconfig
microblaze                          defconfig
nios2                         10m50_defconfig
arm                               allnoconfig
sh                           se7705_defconfig
arc                      axs103_smp_defconfig

clang tested configs:
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
mips                       lemote2f_defconfig
arm                         socfpga_defconfig
arm                         orion5x_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
arm                        spear3xx_defconfig
arm                        neponset_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
