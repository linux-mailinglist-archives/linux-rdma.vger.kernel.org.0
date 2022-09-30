Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3690D5F110F
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Sep 2022 19:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiI3Rmx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Sep 2022 13:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiI3Rmw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Sep 2022 13:42:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E01C1C9E16
        for <linux-rdma@vger.kernel.org>; Fri, 30 Sep 2022 10:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664559771; x=1696095771;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8HCs/FVi+Cx3qmG9RwLM/mCYtW5gVdGFrAnK54CUEpU=;
  b=B3BeLAKtI3jUYy6WZ9O+Fahn6ab+XTNNTjHFd7SUN9v6SlnTAwmH4Z9C
   2bThehgX4LjWBbQ7PtA6VAnWuoyKiUoC5aGkFNS3tU0OPWDQBY4cAAx5R
   kmW52bMNf11IfI1i+BjebFVvKmveLc/cAG0Keuf0R/VFCu1F7ZeKI8vp0
   5pAXoPPDn5FKw9nPdS2cMmWpP05US9uiGOR8s02Tv1EtgzG8/ojQ+F9A+
   tCaaZ3DLOkEbr7XfZ8tnRirQ9ZzWfW4W7XC30FDOCapkWCpO4WixLMxHE
   KeyL1mDofuWUZkBvjAZBAq9jP0W74Weaz3hMg96NuDUdy1LL8pWPkgTlV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="364095965"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="364095965"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 10:42:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="691334338"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="691334338"
Received: from lkp-server01.sh.intel.com (HELO 14cc182da2d0) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 30 Sep 2022 10:42:49 -0700
Received: from kbuild by 14cc182da2d0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oeK2C-0001NX-2r;
        Fri, 30 Sep 2022 17:42:48 +0000
Date:   Sat, 01 Oct 2022 01:42:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/for-testing] BUILD SUCCESS
 a154d273e4fe574da40357a1ab89fb2c485c259c
Message-ID: <63372a83.AwaP8zdyqeepfWx9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/for-testing
branch HEAD: a154d273e4fe574da40357a1ab89fb2c485c259c  Merge branch 'for-next' into wip/for-testing

elapsed time: 1685m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
s390                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
x86_64                              defconfig
i386                                defconfig
powerpc                           allnoconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
powerpc                          allmodconfig
mips                             allyesconfig
i386                             allyesconfig
arc                  randconfig-r043-20220925
riscv                randconfig-r042-20220925
sh                               allmodconfig
arc                  randconfig-r043-20220926
s390                 randconfig-r044-20220925
x86_64               randconfig-a002-20220926
x86_64               randconfig-a004-20220926
i386                          randconfig-a001
i386                          randconfig-a003
x86_64               randconfig-a001-20220926
x86_64               randconfig-a003-20220926
x86_64               randconfig-a005-20220926
x86_64               randconfig-a006-20220926
i386                          randconfig-a005
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220925
hexagon              randconfig-r041-20220926
hexagon              randconfig-r045-20220926
hexagon              randconfig-r041-20220925
riscv                randconfig-r042-20220926
s390                 randconfig-r044-20220926
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                 randconfig-a011-20220926
i386                 randconfig-a015-20220926
i386                 randconfig-a014-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a012-20220926
i386                 randconfig-a016-20220926
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
