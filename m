Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7728F6E3CC9
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Apr 2023 01:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjDPXc0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Apr 2023 19:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDPXcZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 16 Apr 2023 19:32:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB681997
        for <linux-rdma@vger.kernel.org>; Sun, 16 Apr 2023 16:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681687943; x=1713223943;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Wg2edH0dBWymRRDcntBC/0HT8HmsMD2L+WQ+HPcFBNA=;
  b=kAVnEMHeMPig78G24CCZZNO1ygMEATHkefXjamY1YBROzBRKj5F0BpOQ
   VWnSzDrc2HqGXdY2pru2uau3ifzyv0IHpzYOZfoK5OCumORg3yLGK+oda
   OAh42g02zLh8xzJcKny2t59LCnhmWtMVxWJReBYyLml82zAxVOvUvhCJt
   UoYJARFbEPt0MiylTzUl5wgXXtC2ng16IBgfekCQm5Uk16pTZTAE24mam
   7MyWui9rv6v/p8njmqR+Iyrh+n8rV2lK/Rhkwe4dkfrqENfoEOjHpevBV
   3VWNIySBtfD710sLhlKdSGmF86ahtqjoMUf7xUUWKCfyQPvnLkicT4fbb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="347502524"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="347502524"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 16:32:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="1020216921"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="1020216921"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 16 Apr 2023 16:32:21 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1poBr2-000buN-2W;
        Sun, 16 Apr 2023 23:32:20 +0000
Date:   Mon, 17 Apr 2023 07:31:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 bd4ba605c4a92b46ab414626a4f969a19103f97a
Message-ID: <643c8551.mn/qMWYI6iYWiqpk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: bd4ba605c4a92b46ab414626a4f969a19103f97a  RDMA/mlx5: Allow relaxed ordering read in VFs and VMs

elapsed time: 727m

configs tested: 96
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230416   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r013-20230416   gcc  
arc                  randconfig-r043-20230416   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                             mxs_defconfig   clang
arm                  randconfig-r011-20230416   clang
arm                  randconfig-r021-20230416   clang
arm                  randconfig-r046-20230416   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230416   clang
arm64                randconfig-r012-20230416   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r025-20230416   gcc  
hexagon              randconfig-r041-20230416   clang
hexagon              randconfig-r045-20230416   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r022-20230416   gcc  
ia64                 randconfig-r026-20230416   gcc  
ia64                 randconfig-r036-20230416   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230416   gcc  
loongarch    buildonly-randconfig-r006-20230416   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r003-20230416   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r005-20230416   gcc  
mips                 randconfig-r022-20230416   clang
mips                 randconfig-r025-20230416   clang
nios2        buildonly-randconfig-r004-20230416   gcc  
nios2                               defconfig   gcc  
openrisc     buildonly-randconfig-r003-20230416   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r021-20230416   gcc  
parisc               randconfig-r023-20230416   gcc  
parisc               randconfig-r024-20230416   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc                   motionpro_defconfig   gcc  
powerpc                  mpc885_ads_defconfig   clang
powerpc              randconfig-r016-20230416   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r015-20230416   gcc  
riscv                randconfig-r042-20230416   gcc  
riscv                          rv32_defconfig   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r035-20230416   clang
s390                 randconfig-r044-20230416   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r023-20230416   gcc  
sh                          urquell_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r031-20230416   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r005-20230416   gcc  
xtensa               randconfig-r006-20230416   gcc  
xtensa               randconfig-r032-20230416   gcc  
xtensa               randconfig-r034-20230416   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
