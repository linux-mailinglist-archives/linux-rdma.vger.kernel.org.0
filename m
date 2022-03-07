Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1323F4D0840
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Mar 2022 21:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbiCGUV7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Mar 2022 15:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240085AbiCGUV7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Mar 2022 15:21:59 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04E0532DD
        for <linux-rdma@vger.kernel.org>; Mon,  7 Mar 2022 12:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646684464; x=1678220464;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=IkUqUkmWOeVs3FzXiJrXa72Dz8afkmN82b3LpOLoOzM=;
  b=Jxw2DYDRHPofzEPNc4S2nhxD7yLHzoigHoOgnwngP79njuh09Q/kNlYU
   FdboQOxjBi4fzMPETLGV8IopQZphs4qn+IJ5LArneXUwvkM3wk7JEEaxo
   ElC4HuzEdcvduBFLIqsVhTUFaQLxIGc9TBJs6DfQ0BMtqi/sIE+Uq+Ibb
   YJS5Sroz1MVE6SNZFHTpqZBbqMEgmSpX0QcJu83gqtavGB29lo7f8f9yQ
   U39aZedcR7VhssBG4YY8deg+Gs3G4dDEtR2trRKCUUSF1T/JadfePwep/
   rzK5UMszxINJKJD8PYTu6FdTnpE1FtM6kkDJQONmF2Tk8EJpuXEo6K0ZG
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254225127"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="254225127"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 12:21:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="711243317"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 07 Mar 2022 12:21:02 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRJqn-0000gK-Ub; Mon, 07 Mar 2022 20:21:01 +0000
Date:   Tue, 08 Mar 2022 04:20:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 73f7e05609ece4030f2745c4c0c01e0be6889590
Message-ID: <622668f9.+cADPNUWDERR0iNV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 73f7e05609ece4030f2745c4c0c01e0be6889590  RDMA/hns: Refactor the alloc_cqc()

elapsed time: 788m

configs tested: 103
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
i386                 randconfig-c001-20220307
powerpc                     pq2fads_defconfig
um                             i386_defconfig
ia64                          tiger_defconfig
m68k                        m5272c3_defconfig
arm                        multi_v7_defconfig
sh                          rsk7269_defconfig
arc                      axs103_smp_defconfig
arm                         lubbock_defconfig
arm                            hisi_defconfig
powerpc                 mpc837x_mds_defconfig
arm                        mvebu_v7_defconfig
mips                       capcella_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                        sh7757lcr_defconfig
arm                           tegra_defconfig
sh                         apsh4a3a_defconfig
m68k                       m5475evb_defconfig
powerpc                    klondike_defconfig
arm                         vf610m4_defconfig
arm                          exynos_defconfig
arm                  randconfig-c002-20220307
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20220307
x86_64               randconfig-a004-20220307
x86_64               randconfig-a005-20220307
x86_64               randconfig-a001-20220307
x86_64               randconfig-a003-20220307
x86_64               randconfig-a002-20220307
i386                 randconfig-a005-20220307
i386                 randconfig-a004-20220307
i386                 randconfig-a003-20220307
i386                 randconfig-a006-20220307
i386                 randconfig-a002-20220307
i386                 randconfig-a001-20220307
arc                  randconfig-r043-20220307
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c007-20220307
i386                 randconfig-c001-20220307
powerpc              randconfig-c003-20220307
riscv                randconfig-c006-20220307
mips                 randconfig-c004-20220307
arm                  randconfig-c002-20220307
s390                 randconfig-c005-20220307
mips                     cu1000-neo_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                   microwatt_defconfig
powerpc                          allmodconfig
powerpc                      ppc64e_defconfig
x86_64                           allyesconfig
hexagon              randconfig-r041-20220307
riscv                randconfig-r042-20220307
hexagon              randconfig-r045-20220307
s390                 randconfig-r044-20220307

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
