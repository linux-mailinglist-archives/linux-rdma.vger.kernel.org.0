Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74D768E416
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Feb 2023 00:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjBGXBx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Feb 2023 18:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBGXBw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Feb 2023 18:01:52 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFCE3FF0D
        for <linux-rdma@vger.kernel.org>; Tue,  7 Feb 2023 15:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675810901; x=1707346901;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=qPqVaUsJfL9HmDMu1TX+bc5cfTmP5RHgoZulAdZfs6g=;
  b=QcZdfmgzY51nBX9ne/O0OY9diAbqNIIITqZ54PSOpnAlqjiuxzZqEfSY
   uDG7pLVM8rIbPmsN1/rsjLZQzbwadink7PdgwHHz6pOfph/A2MW+p6qds
   8sFJ2cs/St7cVLNE9VR1CeFP0CNP7W6upPeUfn5XRdw+l7twk2gxqZ6qN
   Rvj4WObUNFD3XjXYNqZ/+GoBgxfLPXAezUiuZmEhuoBNSEzTtx2QL72uy
   0jEaFrpCJlHUPXC5WlYDymNfFCQMn1wCpgLAWN3bXh5F1lVqA8Lo9fgWL
   PjwR48J5jBn5pGFEofUUyJa7i9RLaGRseLHB6QbLdqleMsujbKc7UAfih
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="309299959"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="309299959"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 15:01:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="697446146"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="697446146"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 07 Feb 2023 15:01:39 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPWy2-0003xJ-1D;
        Tue, 07 Feb 2023 23:01:38 +0000
Date:   Wed, 08 Feb 2023 07:01:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 8e6e49ccf1a0f2b3257394dc8610bb6d48859d3f
Message-ID: <63e2d846.oz3j7lOKtiuU5VNQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 8e6e49ccf1a0f2b3257394dc8610bb6d48859d3f  RDMA/mlx5: Check reg_create() create for errors

elapsed time: 725m

configs tested: 67
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
sh                               allmodconfig
x86_64                              defconfig
x86_64                           rhel-8.3-bpf
x86_64                               rhel-8.3
powerpc                          allmodconfig
m68k                             allyesconfig
mips                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
ia64                             allmodconfig
i386                                defconfig
x86_64                           allyesconfig
x86_64               randconfig-a013-20230206
x86_64               randconfig-a011-20230206
x86_64               randconfig-a012-20230206
x86_64               randconfig-a014-20230206
i386                 randconfig-a011-20230206
arm                                 defconfig
i386                 randconfig-a014-20230206
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a012-20230206
x86_64                          rhel-8.3-func
i386                 randconfig-a013-20230206
x86_64               randconfig-a015-20230206
x86_64               randconfig-a016-20230206
i386                 randconfig-a016-20230206
arm                              allyesconfig
x86_64                           rhel-8.3-syz
i386                 randconfig-a015-20230206
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arm64                            allyesconfig
i386                             allyesconfig
arc                  randconfig-r043-20230205
arm                  randconfig-r046-20230205
arc                  randconfig-r043-20230206
riscv                randconfig-r042-20230206
s390                 randconfig-r044-20230206

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a002-20230206
x86_64               randconfig-a004-20230206
x86_64               randconfig-a003-20230206
x86_64               randconfig-a001-20230206
x86_64               randconfig-a005-20230206
x86_64               randconfig-a006-20230206
riscv                randconfig-r042-20230205
hexagon              randconfig-r045-20230206
hexagon              randconfig-r041-20230206
i386                 randconfig-a002-20230206
i386                 randconfig-a004-20230206
arm                  randconfig-r046-20230206
i386                 randconfig-a003-20230206
s390                 randconfig-r044-20230205
i386                 randconfig-a001-20230206
hexagon              randconfig-r045-20230205
i386                 randconfig-a005-20230206
i386                 randconfig-a006-20230206

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
