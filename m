Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A61669C41E
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Feb 2023 03:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjBTCZA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Feb 2023 21:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjBTCY7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 Feb 2023 21:24:59 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A98BDE3
        for <linux-rdma@vger.kernel.org>; Sun, 19 Feb 2023 18:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676859896; x=1708395896;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dYLrBZEcqbQ/OFekmCbY4/PFl7irVw3VbnSV9ibjPHo=;
  b=hHHQ704I852W0YdnZXWb5l+cImEPGctmEMMQ4ZU63vhm1ow3Z7ZFWXsj
   W/6lLtm0So34UYu3HynGAXN11r7IFgYml+sgEVl4wMBLbfderA+pIo/Zu
   kJ69XGT8D+FZdlw6Yy60UYC3sJjZmN/ZUSboPFdJByvqbIYZsvQmWJZXG
   Hsi5zo78dCU2qMvSW0quHXIXROCcVv1BQKmT8hFmNck/QpHmbOLrq0Mvb
   A75NSDISSN2kP9/O/HrdxA4x8+z0FfwWYgRyD5PSUrEi1n9LOwC1E1+Re
   OXT4QKV7i9nYdZGBW6fRdLaIB7qa+LzuEc6iwVQB0kFJG4R9Xfovfoe/8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="332315106"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="332315106"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 18:24:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="795026187"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="795026187"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 19 Feb 2023 18:24:54 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pTvrJ-000DYz-1s;
        Mon, 20 Feb 2023 02:24:53 +0000
Date:   Mon, 20 Feb 2023 10:23:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 66fb1d5df6ace316a4a6e2c31e13fc123ea2b644
Message-ID: <63f2d9bc.NGzfx4gIwlEBRS4L%lkp@intel.com>
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
branch HEAD: 66fb1d5df6ace316a4a6e2c31e13fc123ea2b644  IB/mlx5: Extend debug control for CC parameters

elapsed time: 761m

configs tested: 84
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
alpha                               defconfig
arc                              allyesconfig
arc                                 defconfig
arc                  randconfig-r043-20230219
arc                        vdk_hs38_defconfig
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm                      footbridge_defconfig
arm                            zeus_defconfig
arm64                            allyesconfig
arm64                               defconfig
csky                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
ia64                             allmodconfig
ia64                                defconfig
ia64                      gensparse_defconfig
loongarch                        allmodconfig
loongarch                         allnoconfig
loongarch                           defconfig
m68k                             allmodconfig
m68k                                defconfig
mips                             allmodconfig
mips                             allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                     asp8347_defconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                    nommu_k210_defconfig
riscv                randconfig-r042-20230219
riscv                          rv32_defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                                defconfig
s390                 randconfig-r044-20230219
sh                               allmodconfig
sh                         apsh4a3a_defconfig
sh                          rsk7203_defconfig
sparc                               defconfig
sparc64                             defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                               rhel-8.3

clang tested configs:
arm                  randconfig-r046-20230219
hexagon              randconfig-r041-20230219
hexagon              randconfig-r045-20230219
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
mips                        maltaup_defconfig
powerpc                    gamecube_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
