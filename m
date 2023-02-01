Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4FF685E31
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Feb 2023 05:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjBAEOT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Jan 2023 23:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBAEOS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Jan 2023 23:14:18 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8885422F
        for <linux-rdma@vger.kernel.org>; Tue, 31 Jan 2023 20:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675224857; x=1706760857;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jeOPSALIVkc1+l6IQ11uW3ybrSAmsen6tERBmiFXK2w=;
  b=Qtr5mgZrmX1DjWwBCLVJqyqImo5y91tHsrkpWWf+ciziXX3swC6LcaSl
   XdoxLx8rm1F+66b45AaN7jyvsP0xYI+6D9HackcRniFkcnFErWwCYZqri
   QqdQ0fLzUVVUeOcj3Qp/z3kwoAE4QQEYhupSItSAiBuVxSLaOAk+7kYMN
   tXqbZGSWUo3U0DnpalFGogLNUGrvfyGaRloTvEFJWwiu5qRLD7M/LCKD+
   YkMQ78L87OXtaeMrYE4wq69632pEL+K1VFJthrVamC4ekMTiw0RhKv4mK
   CiX5og5FlwtHBKsg188jCbQHKkm9fZNui6Qn5WSbfRkaqHOCKCNjbi4Lx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="392589370"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="392589370"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 20:12:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="838628554"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="838628554"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 31 Jan 2023 20:12:43 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pN4UE-000533-2q;
        Wed, 01 Feb 2023 04:12:42 +0000
Date:   Wed, 01 Feb 2023 12:12:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 f9c47b2caa7ffc903ec950b454b59c209afe3182
Message-ID: <63d9e6b8.+2niLh3f4h72z99v%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: f9c47b2caa7ffc903ec950b454b59c209afe3182  IB/hfi1: Assign npages earlier

elapsed time: 720m

configs tested: 67
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                                 defconfig
x86_64                            allnoconfig
alpha                               defconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                              defconfig
powerpc                           allnoconfig
x86_64                               rhel-8.3
x86_64               randconfig-a001-20230130
x86_64               randconfig-a003-20230130
x86_64               randconfig-a004-20230130
x86_64               randconfig-a002-20230130
x86_64               randconfig-a006-20230130
x86_64               randconfig-a005-20230130
x86_64                           allyesconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allmodconfig
ia64                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
i386                          randconfig-c001
i386                 randconfig-a003-20230130
i386                 randconfig-a001-20230130
i386                 randconfig-a004-20230130
i386                 randconfig-a006-20230130
i386                 randconfig-a002-20230130
i386                 randconfig-a005-20230130
um                             i386_defconfig
um                           x86_64_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                                 defconfig
arm                              allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm64                            allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64                        randconfig-k001
x86_64               randconfig-a014-20230130
x86_64               randconfig-a015-20230130
x86_64               randconfig-a016-20230130
x86_64               randconfig-a013-20230130
x86_64               randconfig-a011-20230130
x86_64               randconfig-a012-20230130
i386                 randconfig-a014-20230130
i386                 randconfig-a013-20230130
i386                 randconfig-a015-20230130
i386                 randconfig-a016-20230130
i386                 randconfig-a012-20230130
i386                 randconfig-a011-20230130

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
