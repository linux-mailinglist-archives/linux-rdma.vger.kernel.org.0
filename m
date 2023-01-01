Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B1265ABAF
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Jan 2023 22:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjAAVWD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 1 Jan 2023 16:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAAVWC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 1 Jan 2023 16:22:02 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A291141
        for <linux-rdma@vger.kernel.org>; Sun,  1 Jan 2023 13:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672608121; x=1704144121;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ED1hDHrOXsDeS81YmE+CtPqDpvbCr9z9GFOI07uNLSA=;
  b=lErfQch6dkpvG0i6WEiqmZ6yPeTQcQ7pJIOdg5a/IIPXfpwsf7E4nj3e
   mdATwgY/t2+ESmB7BXZasEB3jfOXXAJZ+zmcedfetqFPXUMe4at/IjUdO
   dBgbyXqOfB1izq8zlRC2T4jm/aIbSLUfA0xvt8P2zcnUte1/dBZOIf+2I
   hiH3LrLGHhw73P5TKnoOMDN5jDAWxc6woTXS0KHTC37AnBp+x8aRWf7TW
   lQIxnf+R+mYVfafW7zuUBf04n3KyVTA/7qz12fSRGcofUlGtpusjS0d+c
   TkyooOfRlnm1zeIxk8ZV15udZN70ABSPeV9uhU34k3UrQV+V7787UDRNZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="319110537"
X-IronPort-AV: E=Sophos;i="5.96,292,1665471600"; 
   d="scan'208";a="319110537"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2023 13:22:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="899729850"
X-IronPort-AV: E=Sophos;i="5.96,292,1665471600"; 
   d="scan'208";a="899729850"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 Jan 2023 13:21:59 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pC5mI-000Q3r-2n;
        Sun, 01 Jan 2023 21:21:58 +0000
Date:   Mon, 02 Jan 2023 05:21:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 63ce7bc02df1040bce8273fbb92448a382bc7d93
Message-ID: <63b1f944.kfERpg9aAjB5BdDR%lkp@intel.com>
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
branch HEAD: 63ce7bc02df1040bce8273fbb92448a382bc7d93  RDMA/mlx5: Fix validation of max_rd_atomic caps for DC

elapsed time: 724m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
powerpc                           allnoconfig
s390                             allmodconfig
alpha                               defconfig
sh                               allmodconfig
x86_64                        randconfig-a006
s390                                defconfig
arm                                 defconfig
i386                          randconfig-a016
mips                             allyesconfig
i386                                defconfig
s390                             allyesconfig
arc                  randconfig-r043-20230101
x86_64                              defconfig
s390                 randconfig-r044-20230101
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                               rhel-8.3
x86_64                        randconfig-a013
alpha                            allyesconfig
riscv                randconfig-r042-20230101
arm64                            allyesconfig
i386                          randconfig-a014
m68k                             allyesconfig
x86_64                           allyesconfig
x86_64                        randconfig-a011
i386                          randconfig-a001
x86_64                        randconfig-a002
i386                          randconfig-a012
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a003
x86_64                        randconfig-a015
x86_64                          rhel-8.3-func
m68k                             allmodconfig
x86_64                           rhel-8.3-kvm
arc                              allyesconfig
x86_64                        randconfig-a004
arm                              allyesconfig
i386                          randconfig-a005
ia64                             allmodconfig
i386                             allyesconfig
x86_64                            allnoconfig
powerpc                          allmodconfig

clang tested configs:
hexagon              randconfig-r041-20230101
i386                          randconfig-a006
hexagon              randconfig-r045-20230101
x86_64                        randconfig-a016
arm                  randconfig-r046-20230101
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a012
i386                          randconfig-a013
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a015
i386                          randconfig-a011
i386                          randconfig-a004
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
