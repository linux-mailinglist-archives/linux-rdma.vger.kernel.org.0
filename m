Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE183635827
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Nov 2022 10:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbiKWJwM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Nov 2022 04:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbiKWJvI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Nov 2022 04:51:08 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1879A8FF8C
        for <linux-rdma@vger.kernel.org>; Wed, 23 Nov 2022 01:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669196891; x=1700732891;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=IHTTSTU+8wdRumG1pHkk7AaVXSw8dpatlNM/8RBfDWk=;
  b=HoXhSJZFH0LfoOjbdyFh553aklFRIuGDKzhHIKwpE8fxp3keeL14CgLs
   24rylEUAzb6I9p96MDfMIV2HkLSxsvZaFFTJKucIdf3fcyXmSQ9tGaOZA
   pFzmE6jKVy1JUYVa/efYyVJ5+JpR/qqqf4lxGX5Ii1MCfCRRoqj/w4Sug
   lNBxUdeXDlyfNQ2r4CnxOBeAjEiMsX9aJhUZp+FCAlRB7IhBPxkpeI8uG
   pO2xpDcg9E6InDkZa7SxdaZaBdUQIQOW4MbISx+AsV31nIhpH2GtJkBSW
   18mrXnO6pF5jInVD2rDJwFPPzst8k14vwwFU1L+r1TeKsWFAUps+W/7tn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="376173240"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="376173240"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 01:48:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="730728096"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="730728096"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Nov 2022 01:48:08 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oxmMR-0002bF-2u;
        Wed, 23 Nov 2022 09:48:07 +0000
Date:   Wed, 23 Nov 2022 17:47:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 a115aa00b18f7b8982b8f458149632caf64a862a
Message-ID: <637dec1e.ebvRPJ3a3Uf0/SUy%lkp@intel.com>
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
branch HEAD: a115aa00b18f7b8982b8f458149632caf64a862a  RDMA/hns: fix memory leak in hns_roce_alloc_mr()

elapsed time: 1093m

configs tested: 99
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
arc                                 defconfig
mips                             allyesconfig
s390                             allmodconfig
powerpc                          allmodconfig
sh                               allmodconfig
alpha                               defconfig
s390                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
i386                 randconfig-a011-20221121
i386                 randconfig-a013-20221121
i386                 randconfig-a012-20221121
i386                 randconfig-a014-20221121
i386                 randconfig-a015-20221121
i386                 randconfig-a016-20221121
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                                defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
i386                             allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
sh                              ul2_defconfig
sh                           se7780_defconfig
m68k                                defconfig
sh                          sdk7780_defconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64               randconfig-a011-20221121
x86_64               randconfig-a014-20221121
x86_64               randconfig-a012-20221121
x86_64               randconfig-a013-20221121
x86_64               randconfig-a016-20221121
x86_64               randconfig-a015-20221121
sh                   rts7751r2dplus_defconfig
m68k                        m5307c3_defconfig
openrisc                    or1ksim_defconfig
s390                 randconfig-r044-20221121
riscv                randconfig-r042-20221121
arc                  randconfig-r043-20221120
arc                  randconfig-r043-20221121
i386                          randconfig-c001
arm                                 defconfig
arm                              allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                           sunxi_defconfig
sh                         ap325rxa_defconfig
arm                          simpad_defconfig
powerpc                  iss476-smp_defconfig
sh                             espt_defconfig
arc                    vdk_hs38_smp_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
arm64                            allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig

clang tested configs:
x86_64                        randconfig-k001
powerpc                    gamecube_defconfig
x86_64               randconfig-a002-20221121
x86_64               randconfig-a001-20221121
x86_64               randconfig-a004-20221121
x86_64               randconfig-a006-20221121
x86_64               randconfig-a005-20221121
x86_64               randconfig-a003-20221121
i386                 randconfig-a001-20221121
i386                 randconfig-a005-20221121
i386                 randconfig-a006-20221121
i386                 randconfig-a004-20221121
i386                 randconfig-a003-20221121
i386                 randconfig-a002-20221121
powerpc                 mpc832x_rdb_defconfig
mips                     cu1000-neo_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
