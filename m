Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9176050958E
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Apr 2022 05:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384008AbiDUDvI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 23:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384006AbiDUDvI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 23:51:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E968AE7A
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 20:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650512900; x=1682048900;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=aWY0luQ+9oSefJcJmTnP/ULIsERbrAbw7oKSpCDOyoI=;
  b=UNW5nqXidstBmbCXioNf/6ooJyoecyt0baRt6wH+0BmT/MIWQIVVFeFx
   +BaClwwCuNmt1jdHN+O/Q9ZOMDzzxFxlzMmBf2fcQ88ANNI5QEzBNa23u
   X8K6dRDz7x2lCCx0WI9/bTeQ30eUWNSDcFpk6RXGm8QUctTY9yKZSAccf
   880hqBIlGjeVjv+Qh62+PS4+gcRpxR6p1RRJRf1NHv03MDy37TBRjddsV
   eOnKC3ngacf8VhH9M8KTyakhgADPqPHZZcAomxQqwqjuHsTyZ1rSDj6Xt
   OnEamkdgXqXudAwAuDtw7o7mtg0Pk5ndPMQJKWi4NJ9WDhWd15SdDEAcL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="244809417"
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="244809417"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 20:48:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="647951320"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Apr 2022 20:48:18 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhNnl-0007on-TN;
        Thu, 21 Apr 2022 03:48:17 +0000
Date:   Thu, 21 Apr 2022 11:44:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 570a4bf7440e9fb2a4164244a6bf60a46362b627
Message-ID: <6260d31d.kqcscJ4syaLLrtTu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: 570a4bf7440e9fb2a4164244a6bf60a46362b627  RDMA/rxe: Recheck the MR in when generating a READ reply

elapsed time: 743m

configs tested: 110
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
m68k                       m5208evb_defconfig
m68k                          hp300_defconfig
powerpc                      ppc6xx_defconfig
powerpc                      pcm030_defconfig
mips                     loongson1b_defconfig
arm                          lpd270_defconfig
xtensa                         virt_defconfig
powerpc                      chrp32_defconfig
ia64                      gensparse_defconfig
sh                        apsh4ad0a_defconfig
mips                         cobalt_defconfig
arm                            qcom_defconfig
sh                   secureedge5410_defconfig
powerpc                       ppc64_defconfig
arm64                            alldefconfig
sh                          polaris_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220420
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
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220420
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
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
riscv                randconfig-c006-20220420
mips                 randconfig-c004-20220420
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220420
powerpc              randconfig-c003-20220420
arm                           omap1_defconfig
powerpc                      ppc44x_defconfig
powerpc                     pseries_defconfig
powerpc                     skiroot_defconfig
arm                          ep93xx_defconfig
powerpc                    gamecube_defconfig
arm                        neponset_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220420
riscv                randconfig-r042-20220420
hexagon              randconfig-r045-20220420
s390                 randconfig-r044-20220420

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
