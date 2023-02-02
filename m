Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23FE688B2D
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Feb 2023 00:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbjBBXzA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Feb 2023 18:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbjBBXy7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Feb 2023 18:54:59 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E876B000
        for <linux-rdma@vger.kernel.org>; Thu,  2 Feb 2023 15:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675382098; x=1706918098;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=VSXTsJ4O+T2F3LQF5ZiVmHsVLRXSmEeYuZItVSgbR38=;
  b=iCDxBEbez5rivS7ERrMgIqEs4dXFVWUPnnCk120oO5/JsDI/djImfW2P
   tkrHuRSWT1kX5iLQ83tVXfIgjUbAvtYjbFeyXAsdiJG1LXU+pLWxNDUyl
   NI7jye0pIK0/6hi1BH8xTq7Ad5oCu5KCicUOa9w1F/RVbAUzVwCQMmJTv
   3KXEcFhLaFhex8Ii6vRFuTIhYPsNqo+fsTp4lfMpjYeeUq+Z8Q9EZL0w1
   CJWi3Lfa+H6TCXDVxqyLdTOySC27bPy0SHX7NGVZgmGkJbgXjj7YSp+Xj
   DIgqXvJjyP2iWYCc28ubDGW7dIZ803E6gZYkUV8/zJRIy3IpxOl+CBrT5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="316605879"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="316605879"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 15:54:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="754258180"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="754258180"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Feb 2023 15:54:56 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNjPr-0006xs-2l;
        Thu, 02 Feb 2023 23:54:55 +0000
Date:   Fri, 03 Feb 2023 07:53:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 29419daf6c957f39d33f1f91db9385ac9f80820b
Message-ID: <63dc4d15.xPp7fudtYwpnUimf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: 29419daf6c957f39d33f1f91db9385ac9f80820b  RDMA/mana_ib: Prevent array underflow in mana_ib_create_qp_raw()

elapsed time: 874m

configs tested: 68
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
alpha                            allyesconfig
m68k                             allyesconfig
arc                              allyesconfig
arc                                 defconfig
alpha                               defconfig
um                           x86_64_defconfig
s390                             allmodconfig
um                             i386_defconfig
s390                                defconfig
s390                             allyesconfig
x86_64               randconfig-a001-20230130
x86_64               randconfig-a003-20230130
x86_64               randconfig-a004-20230130
x86_64               randconfig-a002-20230130
x86_64               randconfig-a006-20230130
x86_64               randconfig-a005-20230130
x86_64                              defconfig
ia64                             allmodconfig
powerpc                           allnoconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
x86_64                          rhel-8.3-func
mips                             allyesconfig
i386                 randconfig-a002-20230130
i386                 randconfig-a001-20230130
i386                 randconfig-a004-20230130
i386                 randconfig-a003-20230130
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
s390                 randconfig-r044-20230202
arc                  randconfig-r043-20230202
riscv                randconfig-r042-20230202
m68k                             allmodconfig
powerpc                          allmodconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                                defconfig
i386                             allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
arm                  randconfig-r046-20230202
hexagon              randconfig-r045-20230202
hexagon              randconfig-r041-20230202
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
powerpc                     pq2fads_defconfig
mips                         cobalt_defconfig

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
