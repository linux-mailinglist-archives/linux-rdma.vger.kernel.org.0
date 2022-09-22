Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5155E5C09
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Sep 2022 09:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiIVHMz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Sep 2022 03:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiIVHMV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Sep 2022 03:12:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE65CB7768
        for <linux-rdma@vger.kernel.org>; Thu, 22 Sep 2022 00:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663830732; x=1695366732;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jlk+ftlX1cE3zl+EUq17AwWm5ZPeuvCYYJe8Ehf/+ks=;
  b=NSk0xz4irBN7hZL/XVDLqFzrYmFf8QtLZx/iSEvfF18hvO6IL3xZsQmd
   fErZ49EMJCTqJjb5oQ6eyyDsGB+/I1C7nbbpmerQvyI7SsIh0zLhTTdn/
   63h6Gy3ow1e3Anl3XCo0PZapI2uuVpZ8jKNql7QxqXVq08y/j9QaiNkar
   gi5mV1ChMa3k5omwZRSbT9YIzFn6S3eZfzNom9tijcN4G6royC0m/u61D
   AFyzfnu/cJPydLhKzOP1suQTT4lvPSrFW5a4IczjybwKGMgmTvZfUx2bQ
   4/IOhZMrHDfyDDeio9K0oY4naT2+ETSQotENpPeSsrvNHJ7rgf5Y03lug
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="298936592"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="298936592"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 00:12:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="864746171"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 22 Sep 2022 00:12:05 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obGNQ-0004Q0-2v;
        Thu, 22 Sep 2022 07:12:04 +0000
Date:   Thu, 22 Sep 2022 15:11:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:hmm] BUILD SUCCESS 6dce3468a04c68bc154b57ffc9a3f464fe24e18b
Message-ID: <632c0a9d.ZWXcBQ3A9F7Ia4yF%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git hmm
branch HEAD: 6dce3468a04c68bc154b57ffc9a3f464fe24e18b  RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter

elapsed time: 722m

configs tested: 109
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
ia64                             allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
s390                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
arm64                            allyesconfig
arm                                 defconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
powerpc                      bamboo_defconfig
arm                           h5000_defconfig
m68k                        mvme147_defconfig
powerpc                        cell_defconfig
sparc64                          alldefconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220922
i386                          randconfig-c001
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
arm                              allyesconfig
powerpc              randconfig-c003-20220921
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
powerpc                     stx_gp3_defconfig
arm                          exynos_defconfig
m68k                                defconfig
sh                 kfr2r09-romimage_defconfig
m68k                       m5208evb_defconfig
arm                        multi_v7_defconfig
powerpc                      makalu_defconfig
i386                             alldefconfig
powerpc                      ppc6xx_defconfig
powerpc                    adder875_defconfig
sh                               j2_defconfig
sh                             espt_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
mips                      loongson3_defconfig
sh                              ul2_defconfig
arm                         assabet_defconfig
arm                      jornada720_defconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
arm64                               defconfig
ia64                             allyesconfig
arm                              allmodconfig
ia64                                defconfig
mips                             allmodconfig
arc                          axs101_defconfig
powerpc                  storcenter_defconfig
loongarch                           defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
hexagon              randconfig-r041-20220921
hexagon              randconfig-r045-20220921
x86_64                        randconfig-k001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
powerpc                    gamecube_defconfig
arm                         orion5x_defconfig
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-c007
arm                  randconfig-c002-20220921
i386                          randconfig-c001
s390                 randconfig-c005-20220921
riscv                randconfig-c006-20220921
mips                 randconfig-c004-20220921
powerpc              randconfig-c003-20220921

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
