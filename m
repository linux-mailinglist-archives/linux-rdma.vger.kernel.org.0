Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59645584B7A
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Jul 2022 08:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiG2GOa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Jul 2022 02:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbiG2GO3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Jul 2022 02:14:29 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251F67E835
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jul 2022 23:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659075268; x=1690611268;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=PlGtf+SjEfZh028CpbUYuzQiq/AlCAYvsYOTsCnK5wc=;
  b=cWNQAohUmnYQeWxbfqA8troqtSJXq6mRzvRfkdmVa7rkrpkcSnonU6Cv
   7j8PYPYBwx48vAgb+EUao2n3HFcJtvW73XitLO2os+B431Dh7tEExg7+x
   XVDKyzFofDE7QHXpQPR03nPOX4UGx1hnj94WDl/H/72BAzXIGjRvkFTkF
   nx1Pc9wUzsISjl7XE98JDOxN6H5XxjJF1mIMIDDW+REhyMs1LekJIoYh+
   QqAwEI58SWz0VMiWQpGLb5NjGkE+zQOHdi2VHgN2u3SLNR9LJM7LxbCbx
   l1S3yV0MhHA3Qa8Q61cJj9C1EAx1MS5X3qhs0Tnjyjz/dVy9j7TTCqmlH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="289470710"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="289470710"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 23:14:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="601184084"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Jul 2022 23:14:26 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHJGT-000BBE-22;
        Fri, 29 Jul 2022 06:14:25 +0000
Date:   Fri, 29 Jul 2022 14:14:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 3e93c0b8a981b55c8ee45aae2abf6028730ab194
Message-ID: <62e37abd.SQYhVEumUSC0OT7T%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 3e93c0b8a981b55c8ee45aae2abf6028730ab194  Merge branch 'erdma' into rdma.git for-next

elapsed time: 1714m

configs tested: 163
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
riscv                randconfig-r042-20220728
s390                 randconfig-r044-20220728
x86_64                           rhel-8.3-syz
arm                                 defconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
um                           x86_64_defconfig
um                             i386_defconfig
i386                             allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm64                            allyesconfig
arm                              allyesconfig
csky                             alldefconfig
arm                           viper_defconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
loongarch                           defconfig
loongarch                         allnoconfig
i386                          randconfig-c001
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arc                  randconfig-r043-20220728
m68k                         amcore_defconfig
powerpc                 mpc837x_rdb_defconfig
xtensa                           allyesconfig
arm                           u8500_defconfig
powerpc                 linkstation_defconfig
powerpc                     taishan_defconfig
sh                          rsk7264_defconfig
mips                  decstation_64_defconfig
arm                         assabet_defconfig
sh                         ecovec24_defconfig
powerpc                         ps3_defconfig
arm                        mvebu_v7_defconfig
arm                         vf610m4_defconfig
xtensa                       common_defconfig
powerpc                    amigaone_defconfig
sh                          landisk_defconfig
ia64                        generic_defconfig
arc                            hsdk_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                            hisi_defconfig
m68k                        m5272c3_defconfig
i386                          randconfig-a005
arc                           tb10x_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                       m5475evb_defconfig
powerpc                      pasemi_defconfig
sparc                       sparc64_defconfig
arm                           sama5_defconfig
arm                            qcom_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
s390                       zfcpdump_defconfig
openrisc                         alldefconfig
sh                           se7343_defconfig
arm                            mps2_defconfig
openrisc                    or1ksim_defconfig
xtensa                  cadence_csp_defconfig
mips                           ip32_defconfig
sh                 kfr2r09-romimage_defconfig
sh                     sh7710voipgw_defconfig
m68k                        m5407c3_defconfig
sh                         ap325rxa_defconfig
powerpc                      tqm8xx_defconfig
arm                          lpd270_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220728
sparc                               defconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
mips                 randconfig-c004-20220728
powerpc              randconfig-c003-20220728
nios2                               defconfig
m68k                            mac_defconfig
nios2                            allyesconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
ia64                          tiger_defconfig
microblaze                          defconfig
arm                         axm55xx_defconfig
nios2                         10m50_defconfig
alpha                               defconfig
ia64                             allmodconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
s390                             allyesconfig

clang tested configs:
x86_64                        randconfig-a016
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220728
hexagon              randconfig-r045-20220728
x86_64                        randconfig-k001
i386                          randconfig-a002
i386                          randconfig-a004
powerpc                    mvme5100_defconfig
powerpc                      pmac32_defconfig
arm                        spear3xx_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
powerpc                 mpc8315_rdb_defconfig
mips                      pic32mzda_defconfig
hexagon                             defconfig
arm                          ixp4xx_defconfig
arm                     davinci_all_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                    gamecube_defconfig
arm                          collie_defconfig
arm                       imx_v4_v5_defconfig
arm                       versatile_defconfig
powerpc                      obs600_defconfig
powerpc                 mpc836x_mds_defconfig
riscv                             allnoconfig
powerpc                     tqm5200_defconfig
powerpc                        fsp2_defconfig
powerpc                      katmai_defconfig
powerpc                   microwatt_defconfig
powerpc                      ppc64e_defconfig
mips                          rm200_defconfig
arm                  colibri_pxa270_defconfig
arm                      pxa255-idp_defconfig
powerpc                  mpc885_ads_defconfig
mips                 randconfig-c004-20220728
x86_64                        randconfig-c007
s390                 randconfig-c005-20220728
powerpc              randconfig-c003-20220728
i386                          randconfig-c001
riscv                randconfig-c006-20220728
arm                  randconfig-c002-20220728
arm                         hackkit_defconfig
powerpc                      ppc44x_defconfig
arm                  colibri_pxa300_defconfig
arm                        magician_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
