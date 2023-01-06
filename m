Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E759A65FD56
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Jan 2023 10:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjAFJO2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Jan 2023 04:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjAFJOU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Jan 2023 04:14:20 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B93D68CBE
        for <linux-rdma@vger.kernel.org>; Fri,  6 Jan 2023 01:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672996460; x=1704532460;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dirC9X32ULFrSSOXkrVMfBss3FXf6X+H17O3DSjsF0w=;
  b=Zf3TSQMS2yl+IGgYy5h3FKKiuuJHK6e6UYIlnu6lc6anXbUhFl2P5HOD
   sxVqK1W7i/8F7pmhD++9y55wUMsLz7lAHg556gLFFkKQgpbRwYHpZGAfR
   233jkAMesBHYRdvjjBnx5AofwkLhFS7ow722QS4eYj/Wo42lUW13XjoPr
   5seeFpLzoKQlBLmn1dXNhQUfpE6tNfDEhI+ZVZYTr7+0TOw2PMddThUWL
   WcDnZWA5woI5wmO5eHH1WCgxhB7/bt0M9XDZkPHPtRI41Xq4f2pMGdAr6
   Xo9BqarQUeBDC+qRgQfLQoyNcImz+TlCNz7XFgdl7Rl1OfPDeKcGMxU9O
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="321145960"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="321145960"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 01:14:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="649268758"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="649268758"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 06 Jan 2023 01:14:17 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pDino-0003BB-2z;
        Fri, 06 Jan 2023 09:14:16 +0000
Date:   Fri, 06 Jan 2023 17:13:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD SUCCESS
 007b4a4ba03956cd492624e87443de535a4ec833
Message-ID: <63b7e63c.kAJvJ2jJMQDGYy9w%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: 007b4a4ba03956cd492624e87443de535a4ec833  lib/scatterlist: Fix to merge contiguous pages into the last SG properly

elapsed time: 726m

configs tested: 84
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
s390                 randconfig-r044-20230105
s390                             allyesconfig
arc                  randconfig-r043-20230105
um                           x86_64_defconfig
i386                          randconfig-a003
um                             i386_defconfig
i386                          randconfig-a001
x86_64                              defconfig
i386                          randconfig-a005
i386                          randconfig-a014
x86_64                           allyesconfig
ia64                             allmodconfig
x86_64                               rhel-8.3
riscv                randconfig-r042-20230105
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a012
x86_64                          rhel-8.3-func
arm                                 defconfig
i386                          randconfig-a016
i386                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
arm                          simpad_defconfig
mips                           gcw0_defconfig
powerpc                      bamboo_defconfig
sh                               allmodconfig
arm64                            allyesconfig
x86_64                        randconfig-a006
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-kvm
arm                              allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a002
x86_64                        randconfig-a004
arc                 nsimosci_hs_smp_defconfig
arm                      footbridge_defconfig
powerpc                   motionpro_defconfig
arm                         cm_x300_defconfig
i386                             allyesconfig
arm                           u8500_defconfig
arm                            hisi_defconfig
m68k                       m5208evb_defconfig
mips                  decstation_64_defconfig
um                                  defconfig
sparc                       sparc32_defconfig
arc                     haps_hs_smp_defconfig
powerpc                         wii_defconfig
m68k                           sun3_defconfig
sh                           se7343_defconfig
powerpc                     pq2fads_defconfig
m68k                        mvme16x_defconfig
parisc64                         alldefconfig

clang tested configs:
arm                  randconfig-r046-20230105
i386                          randconfig-a002
hexagon              randconfig-r045-20230105
i386                          randconfig-a004
x86_64                          rhel-8.3-rust
i386                          randconfig-a013
hexagon              randconfig-r041-20230105
i386                          randconfig-a006
i386                          randconfig-a011
i386                          randconfig-a015
arm                      tct_hammer_defconfig
arm                         bcm2835_defconfig
powerpc                 mpc8560_ads_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
arm                                 defconfig
arm                              alldefconfig
arm                            dove_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
