Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A527659144
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Dec 2022 20:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbiL2Ts5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Dec 2022 14:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiL2Tsz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Dec 2022 14:48:55 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97D316596
        for <linux-rdma@vger.kernel.org>; Thu, 29 Dec 2022 11:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672343335; x=1703879335;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4lyucq2/UICTUfXTp9gS0LgxU3rMxvcY0L28V/PBiUY=;
  b=nNCtCHPnl7RL9ZfIsnroK7PNasXgnX60Pn/tcgBErxhKBJ+tafcjr/YJ
   sySzCEdgfSB5X980D4wsWZLYSV7Hqe1T7pie3lZ5Mv/PI8JYn2Shs5Q6e
   T9IAqGMBMlLOvdcRRuP04plfJQ7s5L/nninx4gee5lPlpLiaSWXzVVjVp
   38HiPh/d3S2hYumFoCl0bmVWzEtFdfuOu2dOJqy+MTNpiHI3fpVPBVj0m
   YKYtrAdpRrcotdg3owRSZPoyvdyg4akgOjaDv3r7GUvxjCFIuddFn9Z3Q
   GZKj1OLQcMkjpmMt77BU2u+y1C8W5yJk4P+dN9+h8K7a18FQ/m1wuQOys
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="323087977"
X-IronPort-AV: E=Sophos;i="5.96,285,1665471600"; 
   d="scan'208";a="323087977"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 11:48:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="777771071"
X-IronPort-AV: E=Sophos;i="5.96,285,1665471600"; 
   d="scan'208";a="777771071"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Dec 2022 11:48:30 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pAytB-000H25-0b;
        Thu, 29 Dec 2022 19:48:29 +0000
Date:   Fri, 30 Dec 2022 03:47:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 fb5b88f5b78192b7bb031367ece992d5ef7a7352
Message-ID: <63adeed3.nNv/6Hw856jWpdGt%lkp@intel.com>
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
branch HEAD: fb5b88f5b78192b7bb031367ece992d5ef7a7352  RDMA/srp: Move large values to a new enum for gcc13

elapsed time: 726m

configs tested: 74
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
powerpc                           allnoconfig
s390                             allmodconfig
alpha                               defconfig
i386                                defconfig
i386                 randconfig-a012-20221226
i386                 randconfig-a011-20221226
s390                                defconfig
x86_64                              defconfig
i386                 randconfig-a013-20221226
um                             i386_defconfig
arm                                 defconfig
um                           x86_64_defconfig
i386                 randconfig-a014-20221226
i386                 randconfig-a016-20221226
i386                 randconfig-a015-20221226
x86_64                               rhel-8.3
x86_64                           allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64               randconfig-a016-20221226
s390                             allyesconfig
x86_64               randconfig-a013-20221226
x86_64               randconfig-a011-20221226
x86_64                            allnoconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64               randconfig-a014-20221226
x86_64                         rhel-8.3-kunit
arm                              allyesconfig
ia64                             allmodconfig
arm64                            allyesconfig
x86_64               randconfig-a012-20221226
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a015-20221226
i386                             allyesconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
arm                  randconfig-r046-20221225
arc                  randconfig-r043-20221225
arc                  randconfig-r043-20221227
arm                  randconfig-r046-20221227
arc                  randconfig-r043-20221226
riscv                randconfig-r042-20221226
s390                 randconfig-r044-20221226
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func

clang tested configs:
i386                 randconfig-a001-20221226
i386                 randconfig-a003-20221226
i386                 randconfig-a002-20221226
i386                 randconfig-a006-20221226
i386                 randconfig-a005-20221226
i386                 randconfig-a004-20221226
x86_64               randconfig-a006-20221226
x86_64               randconfig-a003-20221226
x86_64                          rhel-8.3-rust
x86_64               randconfig-a001-20221226
x86_64               randconfig-a004-20221226
x86_64               randconfig-a002-20221226
x86_64               randconfig-a005-20221226
hexagon              randconfig-r045-20221225
riscv                randconfig-r042-20221227
hexagon              randconfig-r041-20221225
s390                 randconfig-r044-20221227
hexagon              randconfig-r041-20221227
hexagon              randconfig-r041-20221226
arm                  randconfig-r046-20221226
s390                 randconfig-r044-20221225
hexagon              randconfig-r045-20221226
riscv                randconfig-r042-20221225
hexagon              randconfig-r045-20221227

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
