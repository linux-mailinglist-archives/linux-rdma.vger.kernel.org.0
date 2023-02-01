Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C2E685D94
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Feb 2023 03:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBAC7n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Jan 2023 21:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjBAC7m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Jan 2023 21:59:42 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D7F20075
        for <linux-rdma@vger.kernel.org>; Tue, 31 Jan 2023 18:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675220381; x=1706756381;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Ep8oVQHuFvJJw9b67U+oHlTOF4Iym2+duvw+Mopleug=;
  b=mdLcxdW8pbkiMkYVvDqpvD4DPeVN2Df2tdciGJAA1VAg4l8OqYBlxcoK
   Nt86i7jlPP+1e9QK8BeyXzatExiry/2FFve1E+9S+KmZQ1c3yrraQWFiA
   bWIx2iJJYRgf4ROFUE4I0b1TSZa6ZfNBmOPpHR+1SPFZDgCYb0oXQNHvX
   lY2VW9tV62z53JnPM01RmONAUTlcCcz9v6ZB/bXht3kk9qRijUcEfcc97
   0B9kvChjFVV+XTg2aUSVPfOe7iSmb7nLDjGT7eZmQ/QP6HXtmNlyyFe7Y
   3DX8YeyasPWewKAiMqgckJVW61oNF1JtxPEO/pql3IPo+4qEu/zjT47ob
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="311648612"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="311648612"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 18:59:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="807376005"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="807376005"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jan 2023 18:59:39 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pN3LW-0004xm-1z;
        Wed, 01 Feb 2023 02:59:38 +0000
Date:   Wed, 01 Feb 2023 10:58:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD SUCCESS
 c956940a4ab73a87d0165e911c001dbdd2c8200f
Message-ID: <63d9d568.WQp8Y3hehAtI5jfb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: c956940a4ab73a87d0165e911c001dbdd2c8200f  RDMA/umem: Use dma-buf locked API to solve deadlock

elapsed time: 720m

configs tested: 84
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                            allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
s390                             allmodconfig
alpha                            allyesconfig
x86_64                              defconfig
arc                              allyesconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
alpha                               defconfig
x86_64                               rhel-8.3
s390                                defconfig
ia64                             allmodconfig
um                             i386_defconfig
arc                                 defconfig
i386                 randconfig-a001-20230130
i386                 randconfig-a004-20230130
s390                             allyesconfig
i386                 randconfig-a003-20230130
i386                 randconfig-a002-20230130
i386                 randconfig-a005-20230130
i386                 randconfig-a006-20230130
x86_64                           allyesconfig
x86_64               randconfig-a001-20230130
x86_64               randconfig-a003-20230130
x86_64               randconfig-a004-20230130
x86_64               randconfig-a002-20230130
x86_64               randconfig-a006-20230130
x86_64               randconfig-a005-20230130
sh                               allmodconfig
powerpc                          allmodconfig
mips                             allyesconfig
i386                                defconfig
arc                  randconfig-r043-20230129
arm                  randconfig-r046-20230129
x86_64                           rhel-8.3-syz
arm                  randconfig-r046-20230130
x86_64                         rhel-8.3-kunit
arc                  randconfig-r043-20230130
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
parisc                generic-32bit_defconfig
m68k                          amiga_defconfig
loongarch                           defconfig
arm                            pleb_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                       holly_defconfig
arm                            mps2_defconfig
arm                      jornada720_defconfig
i386                          randconfig-c001

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a014-20230130
x86_64               randconfig-a012-20230130
x86_64               randconfig-a013-20230130
x86_64               randconfig-a011-20230130
x86_64               randconfig-a015-20230130
x86_64               randconfig-a016-20230130
hexagon              randconfig-r041-20230129
riscv                randconfig-r042-20230129
hexagon              randconfig-r045-20230130
hexagon              randconfig-r041-20230130
hexagon              randconfig-r045-20230129
s390                 randconfig-r044-20230129
riscv                randconfig-r042-20230130
s390                 randconfig-r044-20230130
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                 randconfig-a014-20230130
i386                 randconfig-a013-20230130
i386                 randconfig-a015-20230130
i386                 randconfig-a016-20230130
i386                 randconfig-a012-20230130
i386                 randconfig-a011-20230130
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
