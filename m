Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF516359E8
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Nov 2022 11:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbiKWKaP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Nov 2022 05:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKWK3w (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Nov 2022 05:29:52 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B1DBC3B
        for <linux-rdma@vger.kernel.org>; Wed, 23 Nov 2022 02:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669198333; x=1700734333;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=aZIQpbSbB2WybS77RqQCBxx8pULruyFbUSLxVY9qSNU=;
  b=Qt12jvr+dYRtklfNG7KGtcUK0d3HCQIhz4heUuL+ofeIjLHgyeCM66uR
   qS0UxauaF1gHDIj0vjZv50UPHLefFuUwj4O2RUdityvE5YupvzhZ2dVX/
   hqxbrpZEKaYDFejjnggVayHp1ElSMixQnU0e7pwy4FQJ41CdAimfKhRj6
   mHleFxuMW3NoOinCklfpPyMadNHZGR9zKFmZ2SazfjcUlONmveA6AoFhY
   NwgH0BV7DJhp9tuwbQEvJxzSsRnRqd5pLUrwPqgfWprm2XiJbjtTk0COu
   t/y8sT/7vb12zAk+KmGuR/VUMPClNbnxFj2kR8Iz8d8lndCthy2JmdBBP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="297391252"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="297391252"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 02:12:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="766668334"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="766668334"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Nov 2022 02:12:09 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oxmjh-0002ct-0i;
        Wed, 23 Nov 2022 10:12:09 +0000
Date:   Wed, 23 Nov 2022 18:11:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 cb6562c380832a930ffd1722ac9d479b454aed4e
Message-ID: <637df1bd.joUp6oM+BJbFl10J%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: cb6562c380832a930ffd1722ac9d479b454aed4e  RDMA/rxe: Do not NULL deref on debugging failure path

elapsed time: 818m

configs tested: 71
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
s390                                defconfig
s390                             allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allyesconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                 randconfig-a011-20221121
i386                 randconfig-a013-20221121
i386                 randconfig-a014-20221121
i386                 randconfig-a012-20221121
x86_64                              defconfig
i386                 randconfig-a015-20221121
i386                 randconfig-a016-20221121
arc                              allyesconfig
alpha                            allyesconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
ia64                             allmodconfig
x86_64               randconfig-a012-20221121
x86_64               randconfig-a011-20221121
x86_64               randconfig-a013-20221121
x86_64               randconfig-a016-20221121
x86_64               randconfig-a015-20221121
x86_64               randconfig-a014-20221121
i386                                defconfig
arm                          simpad_defconfig
powerpc                  iss476-smp_defconfig
sh                             espt_defconfig
arc                    vdk_hs38_smp_defconfig
i386                             allyesconfig
x86_64                            allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
s390                 randconfig-r044-20221121
riscv                randconfig-r042-20221121
arc                  randconfig-r043-20221120
arc                  randconfig-r043-20221121
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001

clang tested configs:
i386                 randconfig-a004-20221121
x86_64               randconfig-a004-20221121
x86_64               randconfig-a001-20221121
i386                 randconfig-a001-20221121
x86_64               randconfig-a003-20221121
i386                 randconfig-a003-20221121
x86_64               randconfig-a002-20221121
x86_64               randconfig-a005-20221121
i386                 randconfig-a005-20221121
x86_64               randconfig-a006-20221121
i386                 randconfig-a002-20221121
i386                 randconfig-a006-20221121
powerpc                 mpc832x_rdb_defconfig
mips                     cu1000-neo_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
