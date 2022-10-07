Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06535F77C8
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Oct 2022 13:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiJGL7e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Oct 2022 07:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJGL7d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Oct 2022 07:59:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BA5CF865
        for <linux-rdma@vger.kernel.org>; Fri,  7 Oct 2022 04:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665143972; x=1696679972;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=eMyPaBgFFGKd74vPQYKpmYYNhykcLcm8rOvpSsGmTmY=;
  b=g9duRusMOcap1cDsGTh+r1IhtzdUF9bJolDuu4FPzzqspjDqfTLh+iPh
   2wqEOy1hb9Kq1GjVkcJV1+mkArG0pSV9bDhLsdgS6XWCpM+sm0/x/xJfJ
   tH3i4CBcl93WQcZxbdN7Byu+ThfHdxxnhkOZqxtqYxCOYXrsLhpA/y8UP
   bX8VCxBuehlpBdGDNnpTjf0752w9FcFELjiyYIDOGau0XQUzRobVHTX5q
   D34v5aZz+0cDAxkn5uoWxV0ChluYGh+qkXD5EHamSfG8PZH+fyYj2euT7
   iDVRZOuRIA2wzaBjkhmcitKxFQiiY326dimUIYCy+TXZKlPjsA3j4vzPT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="286943808"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="286943808"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 04:59:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="767559310"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="767559310"
Received: from lkp-server01.sh.intel.com (HELO 3c15167049b7) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Oct 2022 04:59:30 -0700
Received: from kbuild by 3c15167049b7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ogm0o-00018V-0T;
        Fri, 07 Oct 2022 11:59:30 +0000
Date:   Fri, 07 Oct 2022 19:59:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 33331a728c83f380e53a3dbf2be0c1893da1d739
Message-ID: <6340148a.eHXAni6IFlhwD+Pf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 33331a728c83f380e53a3dbf2be0c1893da1d739  Merge tag 'v6.0' into rdma.git for-next

elapsed time: 721m

configs tested: 136
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
x86_64                              defconfig
alpha                               defconfig
arm                                 defconfig
s390                             allmodconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
um                             i386_defconfig
i386                                defconfig
um                           x86_64_defconfig
s390                                defconfig
x86_64                           allyesconfig
arm64                            allyesconfig
x86_64                           rhel-8.3-syz
s390                             allyesconfig
i386                 randconfig-a011-20221003
m68k                             allmodconfig
i386                 randconfig-a012-20221003
x86_64                          rhel-8.3-func
i386                 randconfig-a013-20221003
arm                              allyesconfig
arc                              allyesconfig
i386                 randconfig-a015-20221003
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a016-20221003
alpha                            allyesconfig
x86_64                           rhel-8.3-kvm
i386                 randconfig-a014-20221003
m68k                             allyesconfig
sh                               allmodconfig
i386                             allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
ia64                             allmodconfig
x86_64               randconfig-a011-20221003
x86_64               randconfig-a016-20221003
x86_64               randconfig-a014-20221003
x86_64               randconfig-a013-20221003
x86_64               randconfig-a012-20221003
x86_64               randconfig-a015-20221003
powerpc                  iss476-smp_defconfig
sparc                            alldefconfig
m68k                        stmark2_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                       eiger_defconfig
powerpc                     tqm8555_defconfig
sh                           se7619_defconfig
m68k                          hp300_defconfig
arm                        keystone_defconfig
sh                           se7751_defconfig
sh                         ap325rxa_defconfig
powerpc                      tqm8xx_defconfig
i386                          randconfig-c001
mips                        bcm47xx_defconfig
sparc64                             defconfig
mips                      loongson3_defconfig
microblaze                          defconfig
arm64                            alldefconfig
openrisc                    or1ksim_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                  storcenter_defconfig
powerpc                     mpc83xx_defconfig
mips                  maltasmvp_eva_defconfig
xtensa                         virt_defconfig
powerpc                    adder875_defconfig
powerpc                      pcm030_defconfig
riscv                            allmodconfig
mips                       bmips_be_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sh                              ul2_defconfig
arc                          axs101_defconfig
xtensa                              defconfig
openrisc                 simple_smp_defconfig
powerpc                        warp_defconfig
powerpc                      makalu_defconfig
csky                             alldefconfig
arc                      axs103_smp_defconfig
mips                            gpr_defconfig
arm                      integrator_defconfig
parisc64                            defconfig
arm                        clps711x_defconfig
powerpc                     sequoia_defconfig
arm                  randconfig-c002-20221002
x86_64                        randconfig-c001
powerpc                 mpc85xx_cds_defconfig
sh                            migor_defconfig
nios2                            alldefconfig
riscv                randconfig-r042-20221007
riscv                randconfig-r042-20221003
arc                  randconfig-r043-20221003
arc                  randconfig-r043-20221002
arc                  randconfig-r043-20221007
s390                 randconfig-r044-20221003
s390                 randconfig-r044-20221007
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc                           allyesconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
arm                         s3c6400_defconfig
mips                     loongson1b_defconfig
powerpc                     asp8347_defconfig

clang tested configs:
hexagon              randconfig-r041-20221003
hexagon              randconfig-r045-20221003
x86_64               randconfig-a003-20221003
x86_64               randconfig-a005-20221003
x86_64               randconfig-a001-20221003
x86_64               randconfig-a004-20221003
x86_64               randconfig-a002-20221003
x86_64               randconfig-a006-20221003
i386                 randconfig-a001-20221003
i386                 randconfig-a006-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a003-20221003
i386                 randconfig-a005-20221003
i386                 randconfig-a004-20221003
x86_64                        randconfig-k001
powerpc                   microwatt_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                      obs600_defconfig
arm                       cns3420vb_defconfig
arm                          collie_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
