Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD2E64A8E7
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Dec 2022 21:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbiLLUyC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Dec 2022 15:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbiLLUyB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Dec 2022 15:54:01 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4671030
        for <linux-rdma@vger.kernel.org>; Mon, 12 Dec 2022 12:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670878440; x=1702414440;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=P/3aEHwZkGrmWXtgTmakvzDMYyNc5m7GGSmrIQDJWqI=;
  b=H4sOkfhIFVNkOfBBS/xuUBZ7WrQlsZcHvWvUXONmKFt1lXON9EyFn0Wi
   WDa7L9TNSWfj2+00w0qviDa96FdA2kARegRvq+QxNqEvp/mPz+KLMBI8G
   Sp9ky61NEY0SyZPKdssOtyJBk9Clq79MEkg4fwDjqnXPwgR2biUtWmEuG
   fv1XcThVRzmK+y7DCj8Y1xtPMNoL/7E26y8bFh1M+fM0lbkj0bTlUGFVk
   6Sc9cXoUVNyk8j+3XWYgu8Pmp8UVh+YHD/d3hb0AfteyfpNfQpy1spmDr
   6WvUfB2TH2Wou0MyTka6KYh2LV4/CqrIqGBEi2Adn3NTYwnrNk8J3JuGj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="345018259"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="345018259"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 12:53:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="822626877"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="822626877"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 12 Dec 2022 12:53:36 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p4pnr-0003uF-2H;
        Mon, 12 Dec 2022 20:53:35 +0000
Date:   Tue, 13 Dec 2022 04:53:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 27998322992bcbb2b4ddc4715a5d9064579e3c7a
Message-ID: <639794cf.Jdi62uVdPRKCpVDo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 27998322992bcbb2b4ddc4715a5d9064579e3c7a  RDMA/mlx5: Fix validation of max_rd_atomic caps for DC

elapsed time: 727m

configs tested: 80
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
i386                                defconfig
x86_64               randconfig-a011-20221212
x86_64               randconfig-a012-20221212
x86_64               randconfig-a014-20221212
ia64                             allmodconfig
x86_64               randconfig-a013-20221212
x86_64               randconfig-a015-20221212
s390                                defconfig
x86_64               randconfig-a016-20221212
s390                             allmodconfig
um                             i386_defconfig
x86_64                          rhel-8.3-rust
sh                               allmodconfig
um                           x86_64_defconfig
i386                 randconfig-a013-20221212
i386                 randconfig-a016-20221212
mips                             allyesconfig
powerpc                          allmodconfig
s390                             allyesconfig
x86_64                           rhel-8.3-bpf
i386                 randconfig-a014-20221212
arm                                 defconfig
i386                 randconfig-a012-20221212
x86_64                           rhel-8.3-syz
i386                 randconfig-a011-20221212
m68k                             allyesconfig
arm                              allyesconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
arm64                            allyesconfig
riscv                randconfig-r042-20221212
i386                 randconfig-a015-20221212
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arc                  randconfig-r043-20221211
i386                             allyesconfig
x86_64                              defconfig
arc                  randconfig-r043-20221212
arm                  randconfig-r046-20221211
s390                 randconfig-r044-20221212
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                            allnoconfig
mips                        bcm47xx_defconfig
sh                          polaris_defconfig
arm                        spear6xx_defconfig
arm                          pxa910_defconfig
arm                           u8500_defconfig
powerpc                   motionpro_defconfig
m68k                          amiga_defconfig
powerpc                 mpc834x_mds_defconfig

clang tested configs:
i386                 randconfig-a002-20221212
i386                 randconfig-a003-20221212
x86_64               randconfig-a002-20221212
x86_64               randconfig-a001-20221212
x86_64               randconfig-a004-20221212
x86_64               randconfig-a003-20221212
i386                 randconfig-a001-20221212
x86_64               randconfig-a006-20221212
x86_64               randconfig-a005-20221212
i386                 randconfig-a004-20221212
i386                 randconfig-a006-20221212
i386                 randconfig-a005-20221212
arm                  randconfig-r046-20221212
riscv                randconfig-r042-20221211
hexagon              randconfig-r045-20221211
hexagon              randconfig-r041-20221211
hexagon              randconfig-r045-20221212
s390                 randconfig-r044-20221211
hexagon              randconfig-r041-20221212
arm                       imx_v4_v5_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                           mtx1_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
