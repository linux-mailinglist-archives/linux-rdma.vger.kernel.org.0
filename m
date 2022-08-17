Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313995967F1
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Aug 2022 06:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiHQEMO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Aug 2022 00:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiHQEMN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Aug 2022 00:12:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D05394118
        for <linux-rdma@vger.kernel.org>; Tue, 16 Aug 2022 21:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660709532; x=1692245532;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FmjR/5L3ky8vGrHnd+Xm4lyjkF4p84ZhZR3kkZXv9/M=;
  b=E/9hFj19tBio42S1cUItE+6/HSKNk3H8VFh63UHW0vn0Rv9lqPy9RTl+
   +ivFdo3t9fqUmtT8sH5hOqX9UcYj0ci0uO/Fg9+kOWfh9fvMGVziNjES/
   I2/+Ew2Yv+E/XiKZm62iVLVNx2yPnBB/gUdQ5xpl4DdElxtsGAa4BP7T+
   K5gkOBl7jrRoqpcP1hbJ3sQI5OS089wlnc8+uqrvXmM/ExdASSMdTrH18
   FhJCwfk7oIh1aeUjKo6srvIEQqK8Im+LxzKrcPxAwyErvL7frfgCFAPD2
   MBkUpCa7Z0N6q0rdEaJOoW1ckA9CtPuEsYYLhDys4L+WhZpwpQcnDb830
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="293670844"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="293670844"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 21:12:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="557964245"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Aug 2022 21:12:10 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOAPa-0000Yu-00;
        Wed, 17 Aug 2022 04:12:10 +0000
Date:   Wed, 17 Aug 2022 12:11:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 b16de8b9e7d1aae169d059c3a0dd9a881a3c0d1d
Message-ID: <62fc6a6d.gg/6jG68SFYyFDtY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: b16de8b9e7d1aae169d059c3a0dd9a881a3c0d1d  RDMA: Handle the return code from dma_resv_wait_timeout() properly

elapsed time: 723m

configs tested: 105
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220815
i386                                defconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                             allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
m68k                             allyesconfig
sh                               allmodconfig
m68k                             allmodconfig
i386                 randconfig-a003-20220815
i386                 randconfig-a004-20220815
x86_64               randconfig-a001-20220815
i386                 randconfig-a002-20220815
x86_64               randconfig-a003-20220815
x86_64               randconfig-a005-20220815
i386                 randconfig-a001-20220815
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a004-20220815
x86_64                          rhel-8.3-func
x86_64               randconfig-a002-20220815
arc                        nsimosci_defconfig
m68k                          atari_defconfig
sh                        dreamcast_defconfig
sh                            migor_defconfig
i386                 randconfig-a005-20220815
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a006-20220815
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
i386                 randconfig-a006-20220815
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
powerpc              randconfig-c003-20220815
i386                 randconfig-c001-20220815
sh                           se7343_defconfig
m68k                                defconfig
powerpc                 mpc837x_rdb_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
arm                         lubbock_defconfig
csky                                defconfig
arm                         vf610m4_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
powerpc                      cm5200_defconfig
ia64                            zx1_defconfig
xtensa                  audio_kc705_defconfig
um                                  defconfig
xtensa                generic_kc705_defconfig
mips                  maltasmvp_eva_defconfig
sh                        sh7757lcr_defconfig
mips                            gpr_defconfig
m68k                        m5407c3_defconfig
sparc                       sparc32_defconfig
m68k                       m5275evb_defconfig
sh                   sh7770_generic_defconfig
parisc                           allyesconfig
powerpc                         wii_defconfig
sh                          landisk_defconfig
parisc64                         alldefconfig
ia64                             allmodconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
hexagon              randconfig-r045-20220815
hexagon              randconfig-r041-20220815
riscv                randconfig-r042-20220815
s390                 randconfig-r044-20220815
x86_64               randconfig-a013-20220815
x86_64               randconfig-a012-20220815
x86_64               randconfig-a011-20220815
x86_64               randconfig-a014-20220815
x86_64               randconfig-a015-20220815
x86_64               randconfig-a016-20220815
i386                 randconfig-a012-20220815
i386                 randconfig-a011-20220815
i386                 randconfig-a013-20220815
i386                 randconfig-a014-20220815
powerpc                      ppc64e_defconfig
powerpc                 mpc832x_mds_defconfig
i386                 randconfig-a015-20220815
i386                 randconfig-a016-20220815
arm                       imx_v4_v5_defconfig
mips                           mtx1_defconfig
powerpc                     kilauea_defconfig
s390                             alldefconfig
mips                          ath79_defconfig
arm                    vt8500_v6_v7_defconfig
arm64                            allyesconfig
powerpc                      pmac32_defconfig
x86_64               randconfig-k001-20220815

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
