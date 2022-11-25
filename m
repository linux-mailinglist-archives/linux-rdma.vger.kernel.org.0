Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DC2638DA2
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Nov 2022 16:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiKYPre (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Nov 2022 10:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiKYPrc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Nov 2022 10:47:32 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16F626F5
        for <linux-rdma@vger.kernel.org>; Fri, 25 Nov 2022 07:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669391251; x=1700927251;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=udO2mAB3UYwaZm1FQ0nfjtO6Vea8qkmzs99kXm7+1V8=;
  b=cRegS1rIrRiGvfXMnDVacnBKVZqF6OZCxtvhT0jBHVOkFZbaSXRyhwwn
   UouK+o1r0jFA51CNM6OrEavGWTLudra6Wjqwv+FSQ6Mn2wLKPSJaXYes7
   Nkd+BcaWB5Sx/+rsSWyG2O7zVYBFVly0ylnJ1TTMDBIQVe9iae4fIuGZl
   Ll8d/q8+AW65nOCNnz92NqQLd+fl+7mQ+K2RZIxoF7UOOlRcMatV/yPcF
   W+lDuz98aN2DFCLbYx4qcpUdZ+2U5sHDDDJIF+MCmqHbpvEmpm7xup3RW
   Y+GhY/A6utV9J8eAKwCaoGniHg+ssnUp5fLoWuwb3uadmE4bcEifHITQy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="316324511"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="316324511"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 07:47:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="642734368"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="642734368"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 25 Nov 2022 07:47:29 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oyavJ-0005I9-1f;
        Fri, 25 Nov 2022 15:47:29 +0000
Date:   Fri, 25 Nov 2022 23:46:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 b4d46c57d2fb0fa2611fa2ffbaf715925989f83f
Message-ID: <6380e35b.Mr8KGq56azln+xv6%lkp@intel.com>
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
branch HEAD: b4d46c57d2fb0fa2611fa2ffbaf715925989f83f  RDMA/erdma: Fix a typo in annotation

elapsed time: 1219m

configs tested: 60
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
s390                                defconfig
s390                             allmodconfig
sh                               allmodconfig
s390                             allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
arc                  randconfig-r043-20221124
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
ia64                             allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                            allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                             allyesconfig
i386                                defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
sh                   sh7770_generic_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                 mpc837x_mds_defconfig
mips                         rt305x_defconfig
m68k                        stmark2_defconfig
powerpc                      ep88xc_defconfig
ia64                        generic_defconfig
arm                       multi_v4t_defconfig
sh                           se7206_defconfig
sh                        dreamcast_defconfig
arm                        shmobile_defconfig
powerpc                     tqm8548_defconfig
powerpc                    klondike_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig

clang tested configs:
riscv                randconfig-r042-20221124
hexagon              randconfig-r041-20221124
hexagon              randconfig-r045-20221124
s390                 randconfig-r044-20221124
x86_64                        randconfig-k001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
arm                        multi_v5_defconfig
powerpc                     pseries_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
