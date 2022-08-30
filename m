Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B765A7076
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Aug 2022 00:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiH3WQ4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Aug 2022 18:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiH3WQy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Aug 2022 18:16:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA36E6D9E7
        for <linux-rdma@vger.kernel.org>; Tue, 30 Aug 2022 15:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661897813; x=1693433813;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mzySOWRhhkOOvw3zaGWLFMFZqbE3iEmqZ5i9/21iMjY=;
  b=P8TVcm7EJwAtaDBKHoehzltaIedKTu69OWEDfK1ak+WSBVToVrpKqgRc
   0WrXYdq9rE8GiL7JeUBMTiQMt2n7fg/XCdHeQ8JE1OyMbeCgZ4v8/bAzA
   LBpkrcO8EEGVdoiLvmp9pBhJKCTpP0E1jZEgbTxQWLEy+rgDgGXEjJAIc
   R9So2GPg5VPhuvoPRgoymL03WdYG+VVnGQxK1UWg5txORjifEtEwmt6lU
   cG4zVJ5P/ws22oWt/cCO11SwZX3YBhPxSivHBlRXYxT7d+Z9icbCqjNXy
   UfqWjbXIRXo40x71mrPVyXzUMPjDDlTxZQeTjenbH7wi2uljZbduTpe6S
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="321449460"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="321449460"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 15:11:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="588800169"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 30 Aug 2022 15:11:34 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oT9SH-0000fx-35;
        Tue, 30 Aug 2022 22:11:33 +0000
Date:   Wed, 31 Aug 2022 06:10:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 bfb3bde95479e7072839564ec90dbf5d00bfb9b1
Message-ID: <630e8ade.Y+b0fvs4OBEbwvy2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: bfb3bde95479e7072839564ec90dbf5d00bfb9b1  RDMA/hns: Remove redundant member doorbell_qpn of struct hns_roce_qp

elapsed time: 724m

configs tested: 103
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220830
m68k                             allmodconfig
sh                               allmodconfig
arc                              allyesconfig
x86_64                        randconfig-a004
x86_64                              defconfig
arm                                 defconfig
x86_64                        randconfig-a002
alpha                            allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a006
m68k                             allyesconfig
i386                                defconfig
i386                          randconfig-a005
arm64                            allyesconfig
i386                             allyesconfig
x86_64                        randconfig-a013
i386                          randconfig-a014
arm                              allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a011
i386                          randconfig-a012
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
i386                          randconfig-a016
x86_64                        randconfig-a015
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                           rhel-8.3-syz
x86_64                               rhel-8.3
arc                                 defconfig
sh                            hp6xx_defconfig
arm                            pleb_defconfig
openrisc                       virt_defconfig
x86_64                           allyesconfig
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm                         lubbock_defconfig
arc                           tb10x_defconfig
arc                          axs101_defconfig
xtensa                          iss_defconfig
i386                          randconfig-c001
arm                       imx_v6_v7_defconfig
mips                           jazz_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     asp8347_defconfig
sh                           se7619_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
sparc                               defconfig
mips                      loongson3_defconfig
m68k                       m5475evb_defconfig
xtensa                  nommu_kc705_defconfig
mips                       bmips_be_defconfig
mips                        bcm47xx_defconfig
powerpc                       eiger_defconfig
arc                 nsimosci_hs_smp_defconfig
sparc                             allnoconfig
sh                           se7721_defconfig
sh                        edosk7760_defconfig
m68k                            mac_defconfig
arm                      integrator_defconfig
sh                          kfr2r09_defconfig
arm                         cm_x300_defconfig
nios2                            alldefconfig
openrisc                  or1klitex_defconfig
arc                        nsimosci_defconfig
arm                        oxnas_v6_defconfig
mips                         bigsur_defconfig
m68k                          multi_defconfig
xtensa                              defconfig
powerpc                 mpc834x_itx_defconfig
arm                     eseries_pxa_defconfig
powerpc                 mpc8540_ads_defconfig
xtensa                    smp_lx200_defconfig
arm                          lpd270_defconfig
openrisc                         alldefconfig

clang tested configs:
hexagon              randconfig-r045-20220830
hexagon              randconfig-r041-20220830
s390                 randconfig-r044-20220830
riscv                randconfig-r042-20220830
x86_64                        randconfig-a005
x86_64                        randconfig-a001
i386                          randconfig-a002
x86_64                        randconfig-a003
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a015
x86_64                        randconfig-a016
arm                          pcm027_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
