Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA9D612235
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Oct 2022 12:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJ2Kbc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 29 Oct 2022 06:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJ2Kbb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 29 Oct 2022 06:31:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9216FA31
        for <linux-rdma@vger.kernel.org>; Sat, 29 Oct 2022 03:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667039490; x=1698575490;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=9gYVTqETC5VHmsKyJoV90XdLUCAcaZSitKtQ3rcc9f8=;
  b=Lq+cR0+bAPzJuwodSOamG4GCgzy4wYW75hkpNXGEdquxDbrE+jyGF8XJ
   9ZEwbSJO9OoC/sy6eP50eMBcwYetebxc5B5oz4qsQOmSQNM/Xzj0cD2ac
   Eigzn+tUWFWYTLuadVWd1nmx5mQfBrmBHYSb69wdnUv57FE6Hhzsvaaag
   kFJRyDkArKL83fEs770pDzwqBcf0JbAbsVqDu4gRW200MvtHrx8++2wV0
   ONie4pZMY+6qTpwZTk/L4nYbFjkn/4yDz6n2b4QzjcfP1/swb9GmbtFnR
   yI9lELzVuHHa6PX0spElvGKzQkfOROPoE9E96eVBoHmsh9YMmMpGvcT1X
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="289049290"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="289049290"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 03:31:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="611013207"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="611013207"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 29 Oct 2022 03:31:28 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ooj7f-000AwB-11;
        Sat, 29 Oct 2022 10:31:27 +0000
Date:   Sat, 29 Oct 2022 18:30:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 692373d186205dfb1b56f35f22702412d94d9420
Message-ID: <635d00cb.vQ/pqxxhI7g0i/do%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 692373d186205dfb1b56f35f22702412d94d9420  RDMA/rxe: cleanup some error handling in rxe_verbs.c

elapsed time: 938m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                               defconfig
arc                                 defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                                defconfig
arc                              allyesconfig
alpha                            allyesconfig
s390                             allmodconfig
m68k                             allmodconfig
m68k                             allyesconfig
ia64                             allmodconfig
s390                             allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
arc                  randconfig-r043-20221028
riscv                randconfig-r042-20221028
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
s390                 randconfig-r044-20221028
x86_64                         rhel-8.3-kunit
i386                                defconfig
x86_64                        randconfig-a004
i386                          randconfig-a001
x86_64                        randconfig-a002
i386                          randconfig-a003
x86_64                        randconfig-a006
i386                          randconfig-a005
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
arm                                 defconfig
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a016
arm64                            allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a015
arc                  randconfig-r043-20221029

clang tested configs:
hexagon              randconfig-r041-20221028
hexagon              randconfig-r045-20221028
i386                          randconfig-a002
x86_64                        randconfig-a005
x86_64                        randconfig-a001
i386                          randconfig-a004
x86_64                        randconfig-a003
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a015
hexagon              randconfig-r045-20221029
hexagon              randconfig-r041-20221029
s390                 randconfig-r044-20221029
riscv                randconfig-r042-20221029

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
