Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6B46571FB
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Dec 2022 03:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbiL1CHJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Dec 2022 21:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiL1CG4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Dec 2022 21:06:56 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032D9F4C
        for <linux-rdma@vger.kernel.org>; Tue, 27 Dec 2022 18:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672193209; x=1703729209;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hAdAgnwAVteq2XsbpK6lLR9Tvy31KuihFnwlua5dmpE=;
  b=XY7p/3xYjyI8llQbMo0UDAI4f4nJKPLkjnuN8lLPCRvPfn32hvXNYh6J
   TamINX0wPYyeUCJ3OStQX3WoVFwFa+CalsRYb/qwaY06bZJUEzTMlDZqX
   LOlutpVSXnqI//DHR6Vj/JCOpRfz1rAY0iTO5X1iSi3Q1g7fzstPrRiNw
   HDe2sY17tStKriV40k//kB9ZGWWIGisLBVC+g1JrdYT5I+wHpXUimKOGq
   IQHul9woPtPp70msOPi5Bk9YxxaS/22SPvcY96D3L8MfJiLk5ZxkMTahM
   Of/SQG0IaO7HAJVhaJVNYEidbSkDETmzo5/h4frX1sGPGipjJUVYVjlke
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="301152775"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="301152775"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 18:06:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="646594933"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="646594933"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 27 Dec 2022 18:06:46 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pALqA-000FKV-0W;
        Wed, 28 Dec 2022 02:06:46 +0000
Date:   Wed, 28 Dec 2022 10:06:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 cab30a98352511c0cb3ab6deb5d06b55fe4eb10a
Message-ID: <63aba498.gS/yoLzt8uhFixkc%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: cab30a98352511c0cb3ab6deb5d06b55fe4eb10a  RDMA/cxgb4: remove unnecessary NULL check in __c4iw_poll_cq_one()

elapsed time: 725m

configs tested: 85
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
powerpc                           allnoconfig
um                           x86_64_defconfig
sh                               allmodconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
mips                             allyesconfig
m68k                             allyesconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
i386                 randconfig-a012-20221226
i386                 randconfig-a011-20221226
x86_64                           allyesconfig
i386                 randconfig-a013-20221226
i386                 randconfig-a014-20221226
i386                 randconfig-a016-20221226
i386                 randconfig-a015-20221226
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                                defconfig
ia64                             allmodconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
powerpc                          allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a014-20221226
x86_64               randconfig-a013-20221226
x86_64               randconfig-a011-20221226
x86_64               randconfig-a012-20221226
x86_64               randconfig-a016-20221226
x86_64               randconfig-a015-20221226
arm                                 defconfig
i386                             allyesconfig
arc                  randconfig-r043-20221227
arm                  randconfig-r046-20221227
arc                  randconfig-r043-20221226
riscv                randconfig-r042-20221226
s390                 randconfig-r044-20221226
arm64                            allyesconfig
arm                              allyesconfig
x86_64                            allnoconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20221225
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20221225
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
x86_64                          rhel-8.3-rust
i386                 randconfig-a004-20221226
x86_64               randconfig-a002-20221226
i386                 randconfig-a001-20221226
i386                 randconfig-a003-20221226
i386                 randconfig-a002-20221226
x86_64               randconfig-a003-20221226
i386                 randconfig-a006-20221226
i386                 randconfig-a005-20221226
x86_64               randconfig-a006-20221226
x86_64               randconfig-a001-20221226
x86_64               randconfig-a004-20221226
x86_64               randconfig-a005-20221226
hexagon              randconfig-r041-20221227
hexagon              randconfig-r041-20221226
arm                  randconfig-r046-20221226
hexagon              randconfig-r045-20221226
hexagon              randconfig-r045-20221227
riscv                randconfig-r042-20221227
s390                 randconfig-r044-20221227
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
