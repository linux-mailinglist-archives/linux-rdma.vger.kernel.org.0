Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39AC588856
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Aug 2022 09:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbiHCH46 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Aug 2022 03:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbiHCH46 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Aug 2022 03:56:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2A960CD
        for <linux-rdma@vger.kernel.org>; Wed,  3 Aug 2022 00:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659513417; x=1691049417;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=MXN0FKf+8EiaaRkw2KknnrChNXJskfsn7oj0OJNSFfc=;
  b=Qvn7OiOqPyRvQFh2tJ6y9IrsjVrBqpRMS+kRMaFR/4fpGFEC72bnFJCu
   hA19AzxnK+9s83IVF0F/9mbukL2g2Kt1F1E9y5szzRcLdEX2ayJBZrvCu
   YmKeIyYvr8kxpTEdoWBOHIO4sJlnRhxNyV6flhwlNcw8pVCSV0C9R7RZB
   wHessWaSn6Ptj/VTK03WkN3Ks4Lt6KwmOHEM8fYLxlLZL1FWDxKPawDRM
   mMw1yfDnc9yHgbzf6/g1Q53N3z3vSYPS0o0sspxKOlskuJJvyPn1Sx/hc
   L4uJKTtbgambk9iJ++YVX+D/ssSDRnbpA5Xmi32KtK4BJh2abl9zPQGO6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="289624486"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="289624486"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 00:56:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="670775384"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 Aug 2022 00:56:55 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ9FP-000H11-0n;
        Wed, 03 Aug 2022 07:56:55 +0000
Date:   Wed, 03 Aug 2022 15:56:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 6b822d408b58c3c4f26dae93245c6b7d8b39e0f9
Message-ID: <62ea2a11.VGjj0JWtyvt8LJ8T%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 6b822d408b58c3c4f26dae93245c6b7d8b39e0f9  RDMA/ib_srpt: Unify checking rdma_cm_id condition in srpt_cm_req_recv()

elapsed time: 717m

configs tested: 96
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
i386                             allyesconfig
x86_64                           allyesconfig
x86_64               randconfig-a014-20220801
x86_64               randconfig-a011-20220801
x86_64               randconfig-a012-20220801
x86_64               randconfig-a015-20220801
arc                  randconfig-r043-20220801
arc                  randconfig-r043-20220802
x86_64                          rhel-8.3-func
arc                              allyesconfig
x86_64                         rhel-8.3-kunit
s390                 randconfig-r044-20220801
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
riscv                randconfig-r042-20220801
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allmodconfig
i386                 randconfig-a012-20220801
i386                 randconfig-a013-20220801
i386                 randconfig-a014-20220801
i386                 randconfig-a011-20220801
i386                 randconfig-a015-20220801
i386                 randconfig-a016-20220801
ia64                             allmodconfig
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a004
m68k                             allyesconfig
alpha                            allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a015
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
mips                             allyesconfig
m68k                       m5208evb_defconfig
um                                  defconfig
sh                             espt_defconfig
powerpc                     tqm8555_defconfig
x86_64                        randconfig-a013
powerpc                     ep8248e_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                            migor_defconfig
sh                        sh7785lcr_defconfig
arc                     nsimosci_hs_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm                        cerfcube_defconfig
arm                           tegra_defconfig
loongarch                         allnoconfig
m68k                            mac_defconfig
x86_64                        randconfig-a011
powerpc                   motionpro_defconfig
arm                         at91_dt_defconfig

clang tested configs:
i386                 randconfig-a006-20220801
hexagon              randconfig-r045-20220801
hexagon              randconfig-r041-20220801
i386                 randconfig-a001-20220801
x86_64               randconfig-a006-20220801
i386                 randconfig-a002-20220801
hexagon              randconfig-r041-20220802
s390                 randconfig-r044-20220802
riscv                randconfig-r042-20220802
i386                 randconfig-a003-20220801
hexagon              randconfig-r045-20220802
i386                 randconfig-a005-20220801
i386                 randconfig-a004-20220801
x86_64               randconfig-a002-20220801
x86_64               randconfig-a001-20220801
x86_64               randconfig-a003-20220801
x86_64               randconfig-a005-20220801
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
x86_64                        randconfig-a005
i386                          randconfig-a011
x86_64                        randconfig-a014
i386                          randconfig-a015
x86_64                        randconfig-a012
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220803
hexagon              randconfig-r041-20220803
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
