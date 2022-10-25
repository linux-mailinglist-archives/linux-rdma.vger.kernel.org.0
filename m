Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB2360CD60
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Oct 2022 15:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiJYN0R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Oct 2022 09:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbiJYN0Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Oct 2022 09:26:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6F0F07F0
        for <linux-rdma@vger.kernel.org>; Tue, 25 Oct 2022 06:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666704374; x=1698240374;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=G9eriwdiaWUuYXwNYRxvc5JyOZc+vG1Lz2rG/UFDNIg=;
  b=JjIVojWEozqeHrUK+m2Af3Nc1alZlnClmONjc/CLFyWJpXIetZAMxNub
   zzq2KQGlj87+WB/2puzvCacAq6TiZ6tUOvzCO14Uzg3iCIZbJxQVlwzHW
   xDgBDEj0g6F3MZQERUQAPKaa1DV2yR7sW77JouwuRAFoigdAKi5LkqsIw
   hF35q/+/vEELUHJcrstu3ZdlHfgBvbCPBsHzcNSOzEy1qCaYm5Qf9Rw3h
   LYoXZEEK+sHaLBHIxdRlw0PJaEVlPELYsrau5GtFwaB7ANcgc1rCalKVG
   lTupA2GCNUGWl12moVFBeKX/TFgVWJf3u/Pxn6k8vdBWkvEskWlPhBzNF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="393986291"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="393986291"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 06:26:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="582770673"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="582770673"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2022 06:26:12 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1onJwZ-0006Im-30;
        Tue, 25 Oct 2022 13:26:11 +0000
Date:   Tue, 25 Oct 2022 21:25:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 c9eeabac5e8d27a3f40280908e089058bab39edb
Message-ID: <6357e3bd.nhMUZfSf5s8+3xUP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: c9eeabac5e8d27a3f40280908e089058bab39edb  RDMA/rxe: Remove unnecessary mr testing

elapsed time: 1195m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
arc                                 defconfig
um                             i386_defconfig
um                           x86_64_defconfig
alpha                               defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
powerpc                          allmodconfig
mips                             allyesconfig
s390                                defconfig
powerpc                           allnoconfig
s390                             allmodconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
sh                               allmodconfig
x86_64                              defconfig
i386                                defconfig
s390                             allyesconfig
ia64                             allmodconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                             allyesconfig
arc                  randconfig-r043-20221024
riscv                randconfig-r042-20221024
s390                 randconfig-r044-20221024
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64               randconfig-a013-20221024
x86_64               randconfig-a012-20221024
x86_64               randconfig-a011-20221024
x86_64               randconfig-a014-20221024
x86_64               randconfig-a015-20221024
x86_64               randconfig-a016-20221024
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                 randconfig-a004-20221024
i386                 randconfig-a001-20221024
i386                 randconfig-a002-20221024
i386                 randconfig-a003-20221024
i386                 randconfig-a005-20221024
hexagon              randconfig-r041-20221024
i386                 randconfig-a006-20221024
hexagon              randconfig-r045-20221024
x86_64               randconfig-a001-20221024
x86_64               randconfig-a003-20221024
x86_64               randconfig-a002-20221024
x86_64               randconfig-a004-20221024
x86_64               randconfig-a006-20221024
x86_64               randconfig-a005-20221024

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
