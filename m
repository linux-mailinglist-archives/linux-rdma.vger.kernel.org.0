Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E6A6106BD
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 02:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiJ1AUA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 20:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbiJ1AT7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 20:19:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242461BE88
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 17:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666916398; x=1698452398;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tp44aYby7770n3IcTx7ZAIyBcJXrUncR7sK7vSvdtTE=;
  b=hhVeEFpOpnXfBm2SYiDOdO71DUO8tFHFVRpVkhPjqxrj5cj0p9Sq47PF
   qFYxR7GbEABSZSN22gVjxGPfyngxtziI8TTWNresku1py1L6E1EZyA8QF
   rk5QTPR7c9zTPRxGcOpfgP/Ln1IXUW4zQ4v3z/eM1xVDsnfENDs034Oo4
   5+8+pR+/zt0tAPM23SKrCkI5e/EtMKAJ2215qtTB/STr0KcnVHRQKg78R
   uoScN+chTYkihagB5fJa8dunFleXWfiM2NUDntF7WoGoj0h2h4MoDYbU+
   HMilKZ01rwhPvmpHutbnrPzez5DWw1Sf559NWTNEoP4zr0aSP8ZnLTpA9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="308364211"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="308364211"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 17:19:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="583744066"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="583744066"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 27 Oct 2022 17:19:55 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ooD6I-0009I1-1b;
        Fri, 28 Oct 2022 00:19:54 +0000
Date:   Fri, 28 Oct 2022 08:19:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 bbdad4967431bda9424aff2295c23d48c5059941
Message-ID: <635b2006.58egwmY79XPOLX5L%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: bbdad4967431bda9424aff2295c23d48c5059941  RDMA/core: Fix order of nldev_exit call

elapsed time: 723m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
x86_64                              defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                  randconfig-r043-20221027
arc                              allyesconfig
m68k                             allyesconfig
x86_64                               rhel-8.3
m68k                             allmodconfig
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
x86_64                        randconfig-a013
i386                                defconfig
s390                                defconfig
x86_64                        randconfig-a011
i386                          randconfig-a001
s390                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                        randconfig-a004
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a003
powerpc                           allnoconfig
x86_64                        randconfig-a002
powerpc                          allmodconfig
i386                             allyesconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a006
mips                             allyesconfig
arm                                 defconfig
sh                               allmodconfig
i386                          randconfig-a005
i386                          randconfig-a014
s390                             allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
hexagon              randconfig-r041-20221027
hexagon              randconfig-r045-20221027
riscv                randconfig-r042-20221027
s390                 randconfig-r044-20221027
x86_64                        randconfig-a012
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a014
i386                          randconfig-a006
i386                          randconfig-a011
i386                          randconfig-a004
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
