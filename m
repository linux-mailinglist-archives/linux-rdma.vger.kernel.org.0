Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58FE688C81
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Feb 2023 02:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjBCB3L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Feb 2023 20:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjBCB3K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Feb 2023 20:29:10 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231D417CDE
        for <linux-rdma@vger.kernel.org>; Thu,  2 Feb 2023 17:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675387750; x=1706923750;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=eCI0TR78/Ztft+cxVGKE41LR1R94LjGLbrix27tBgPA=;
  b=JhehXFbDXWpfOZRtNDBNmGLVwm3h++zBmFNFDUIAxYa4PH402GCql2gw
   iZnHT1o4w9RJJYreTgHU/ZgjqEfmaGyzXjdlHzgd+pHZyGenGUT9s54bX
   0vmvwMSsv9NxrSbeMTVETmMlc950b8kj/PlM5kDnXKDyjhEA6K/VZ53Fq
   c+FCrJdY2goROmRZl6kNi1txMf/G1u//uXTnIxUzB+2fHW/ZmZDf0O9fu
   fBQCV3Cd6EhtthzYm4HhmEjTPPqLb95TzqGG2UCt9qx7Gs7QSR9UdqA7o
   o/Cdm4tTYUkcKodC5jtNXqDx5c0GR/S2eW4YSHGgtAIjSnGTUuShzDQYj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="393219949"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="393219949"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 17:29:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="615524658"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="615524658"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Feb 2023 17:29:08 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNksw-00073y-0p;
        Fri, 03 Feb 2023 01:29:02 +0000
Date:   Fri, 03 Feb 2023 09:28:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 ef42520240aacfc0d46c8d780c051d135a8dc9b7
Message-ID: <63dc6335.MzJubDngXDMZolAz%lkp@intel.com>
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
branch HEAD: ef42520240aacfc0d46c8d780c051d135a8dc9b7  RDMA/cxgb4: add null-ptr-check after ip_dev_find()

elapsed time: 969m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
alpha                            allyesconfig
arc                              allyesconfig
arc                                 defconfig
m68k                             allyesconfig
m68k                             allmodconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                              defconfig
powerpc                           allnoconfig
sh                               allmodconfig
x86_64                               rhel-8.3
mips                             allyesconfig
x86_64               randconfig-a001-20230130
x86_64                           allyesconfig
x86_64               randconfig-a003-20230130
x86_64               randconfig-a002-20230130
x86_64               randconfig-a004-20230130
powerpc                          allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64               randconfig-a006-20230130
x86_64               randconfig-a005-20230130
i386                          randconfig-a001
i386                          randconfig-a003
ia64                             allmodconfig
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arc                  randconfig-r043-20230202
s390                 randconfig-r044-20230202
riscv                randconfig-r042-20230202
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                                defconfig
i386                             allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
arm                  randconfig-r046-20230202
hexagon              randconfig-r045-20230202
hexagon              randconfig-r041-20230202
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
