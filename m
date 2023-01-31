Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238AB68205E
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Jan 2023 01:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjAaAI2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Jan 2023 19:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjAaAI2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Jan 2023 19:08:28 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76956166EC
        for <linux-rdma@vger.kernel.org>; Mon, 30 Jan 2023 16:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675123707; x=1706659707;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=9XO1+Gjpl0+7GhEcP8c77sbFCcyNB7wjGODn9j2oryg=;
  b=E8x7sa8Ig84VAmlf6/AdNNIZ0rx8A3IFRLirWRjCeoGTyPwSARsfAevZ
   LeS6empudXIjyerioFRaZaO1iNkItCN2X5t7P12AeydBZ0SKicjcPEPMZ
   2Tg5DTznqYM3lkuPlGQxhLN2IiML47sSBKG2/EdJYgFwenMLwpihTWZNz
   LL+K4eVQAm/KdIKSpHh4DCaqIic+PeOCkWRW/E3fXdm1OjEX12WKZDgnm
   OLCIOFTWmLk9FyvAPb+xVRj+Gs0qiQXKEj/JdGI8AL+imNBesLx4eZm/K
   MXpN0xu+xWp/N44hl7/Ed0f7xDqVqA7i4/o9GNSc01rAzxLNo8DLt3iSM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="327729476"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="327729476"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 16:08:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="753040505"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="753040505"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jan 2023 16:08:24 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMeCG-0003zU-0h;
        Tue, 31 Jan 2023 00:08:24 +0000
Date:   Tue, 31 Jan 2023 08:08:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 b7e08a5a63a11627601915473c3b569c1f6c6c06
Message-ID: <63d85bf0.jJhlODh8p9sF1Ifg%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: b7e08a5a63a11627601915473c3b569c1f6c6c06  RDMA/usnic: use iommu_map_atomic() under spin_lock()

elapsed time: 722m

configs tested: 102
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
um                             i386_defconfig
alpha                               defconfig
um                           x86_64_defconfig
s390                             allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                            allnoconfig
alpha                            allyesconfig
m68k                             allyesconfig
s390                                defconfig
x86_64               randconfig-a001-20230130
x86_64               randconfig-a003-20230130
x86_64               randconfig-a004-20230130
x86_64               randconfig-a002-20230130
s390                             allyesconfig
x86_64               randconfig-a006-20230130
x86_64               randconfig-a005-20230130
i386                 randconfig-a001-20230130
i386                 randconfig-a004-20230130
x86_64                              defconfig
i386                 randconfig-a003-20230130
i386                 randconfig-a002-20230130
i386                 randconfig-a006-20230130
x86_64                               rhel-8.3
i386                 randconfig-a005-20230130
arm                                 defconfig
x86_64                    rhel-8.3-kselftests
ia64                             allmodconfig
x86_64                          rhel-8.3-func
i386                                defconfig
x86_64                           allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
arm64                            allyesconfig
sh                               allmodconfig
arc                  randconfig-r043-20230129
arm                              allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
arm                  randconfig-r046-20230129
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
arm                  randconfig-r046-20230130
arc                  randconfig-r043-20230130
i386                             allyesconfig
mips                        bcm47xx_defconfig
powerpc                     pq2fads_defconfig
openrisc                       virt_defconfig
arm                            qcom_defconfig
i386                          randconfig-c001
arm                        multi_v7_defconfig
sh                           se7750_defconfig
openrisc                 simple_smp_defconfig
m68k                          hp300_defconfig
sh                          sdk7786_defconfig
sh                          rsk7269_defconfig
powerpc                       holly_defconfig
arm                         nhk8815_defconfig
arm                         s3c6400_defconfig
csky                                defconfig
sh                          r7785rp_defconfig
m68k                        stmark2_defconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a014-20230130
x86_64               randconfig-a012-20230130
x86_64               randconfig-a013-20230130
x86_64               randconfig-a011-20230130
x86_64               randconfig-a015-20230130
x86_64               randconfig-a016-20230130
i386                 randconfig-a013-20230130
i386                 randconfig-a012-20230130
i386                 randconfig-a014-20230130
i386                 randconfig-a011-20230130
i386                 randconfig-a016-20230130
hexagon              randconfig-r041-20230129
i386                 randconfig-a015-20230130
riscv                randconfig-r042-20230130
hexagon              randconfig-r045-20230130
hexagon              randconfig-r041-20230130
hexagon              randconfig-r045-20230129
s390                 randconfig-r044-20230129
s390                 randconfig-r044-20230130
riscv                randconfig-r042-20230129
x86_64                        randconfig-k001
powerpc                 mpc8560_ads_defconfig
arm                          ixp4xx_defconfig
arm                         s5pv210_defconfig
powerpc                     skiroot_defconfig
powerpc                    gamecube_defconfig
powerpc                        fsp2_defconfig
arm                       versatile_defconfig
powerpc                      pmac32_defconfig
powerpc                        icon_defconfig
mips                       lemote2f_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                    mvme5100_defconfig
arm                         s3c2410_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
