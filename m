Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC37A64F905
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Dec 2022 14:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiLQNUB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 17 Dec 2022 08:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLQNUA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 17 Dec 2022 08:20:00 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3035413F51
        for <linux-rdma@vger.kernel.org>; Sat, 17 Dec 2022 05:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671283200; x=1702819200;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=fRf9FU5wZ7DVuiF7XjxUbj1MPdWorFLo58KTOUNq+/Q=;
  b=JCS4cppjl96PAXeHbCB60XcVI6k3ZELGXb8DyEni+Y2ArrP+DMAj7qmH
   2d6zwJY1Bdz82UumLEcybwZZzJsqmsAq1V08gMMChpjd3BZPp3FCUQPSH
   KgZ4V4POxx/7H+o+DYpMp3ySj7FX9G/VeztAhZc4cRkrufQpfk2s4ddh1
   MRyGozAXk88rEVNwV+fwhGb7DAwMAzunamW74IfSrLjDfdnJI/us96zIq
   xjPkIWGl5hg/8u5T6SAYXfUjyh8KUHUUT6kjbZSN/DnTshaH+wQ0w8iMn
   vlBSBAIGxBzwuuKa6GyoF7qkBioS1d/8PEVkIS7+SwlfzfCQaJaLm93z3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="299461258"
X-IronPort-AV: E=Sophos;i="5.96,252,1665471600"; 
   d="scan'208";a="299461258"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2022 05:19:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="680750897"
X-IronPort-AV: E=Sophos;i="5.96,252,1665471600"; 
   d="scan'208";a="680750897"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 17 Dec 2022 05:19:57 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p6X6b-0007lm-0j;
        Sat, 17 Dec 2022 13:19:57 +0000
Date:   Sat, 17 Dec 2022 21:19:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 5244ca88671a1981ceec09c5c8809f003e6a62aa
Message-ID: <639dc1f8.lBJHlu6Cp9nf/UND%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 5244ca88671a1981ceec09c5c8809f003e6a62aa  RDMA/siw: Fix pointer cast warning

elapsed time: 727m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
powerpc                           allnoconfig
alpha                               defconfig
ia64                             allmodconfig
s390                                defconfig
s390                             allmodconfig
i386                                defconfig
x86_64                              defconfig
x86_64                        randconfig-a013
sh                               allmodconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
m68k                             allyesconfig
x86_64                               rhel-8.3
m68k                             allmodconfig
x86_64                    rhel-8.3-kselftests
mips                             allyesconfig
x86_64                           rhel-8.3-kvm
arc                              allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a011
alpha                            allyesconfig
arm                                 defconfig
x86_64                        randconfig-a004
x86_64                           allyesconfig
s390                             allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a015
i386                          randconfig-a001
riscv                randconfig-r042-20221216
i386                          randconfig-a003
i386                          randconfig-a014
i386                             allyesconfig
x86_64                           rhel-8.3-bpf
i386                          randconfig-a012
x86_64                        randconfig-a006
i386                          randconfig-a005
arc                  randconfig-r043-20221216
i386                          randconfig-a016
s390                 randconfig-r044-20221216
arm64                            allyesconfig
arm                              allyesconfig
x86_64                            allnoconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a016
x86_64                        randconfig-a012
arm                  randconfig-r046-20221216
hexagon              randconfig-r041-20221216
x86_64                        randconfig-a005
x86_64                        randconfig-a014
i386                          randconfig-a002
hexagon              randconfig-r045-20221216
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a006
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
