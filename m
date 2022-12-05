Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C51642137
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Dec 2022 02:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiLEBsh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Dec 2022 20:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiLEBsg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 4 Dec 2022 20:48:36 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E603D5F46
        for <linux-rdma@vger.kernel.org>; Sun,  4 Dec 2022 17:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670204915; x=1701740915;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=uej+EbVbAN8ViEhjGBl9GEONrkQt0PErFwnAbxmBuoo=;
  b=MaHOxqWjLBqP7VXKEceAbqGWp9qN4yw5piJxo0C9uugB/dm1gKljHuN7
   pv7yLX7UXQiHuIccr8Kxv4d55Ai+pTEOnCOIBNtp2BDN65+06v01F2vR7
   zypT+STlT88QLRvjT5xU5HGAW6oeuSYsiWdFKYMfgWn5SeLy9Wh6c4UiQ
   Mrynhh3LLo4VSQe9Hj2XY0C1hkw/Sqd4m0xEblZvylxkgiXvkQQSwCNZA
   YmSs7kyDh08GJtMdobHDTc0FBTjDB0pFMtq91IjMQPUclYB4g+p6ed4DJ
   tHngveX37EctSbtHSAOamXfVaKrBXvWicN6cfcsSVzmU1iY4omr3dAAT/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="314948487"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="314948487"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 17:48:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="647767192"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="647767192"
Received: from lkp-server01.sh.intel.com (HELO 4d912534d779) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 04 Dec 2022 17:48:34 -0800
Received: from kbuild by 4d912534d779 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p20av-0001AD-1a;
        Mon, 05 Dec 2022 01:48:33 +0000
Date:   Mon, 05 Dec 2022 09:48:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 6978837ce42f8bea85041fc08c854f4e28852b3e
Message-ID: <638d4dd8.33W9dUwqxNvivK6A%lkp@intel.com>
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
branch HEAD: 6978837ce42f8bea85041fc08c854f4e28852b3e  RDMA/mlx5: no need to kfree NULL pointer

elapsed time: 725m

configs tested: 100
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
i386                                defconfig
x86_64                               rhel-8.3
arc                                 defconfig
alpha                               defconfig
i386                          randconfig-a012
x86_64                        randconfig-a011
s390                                defconfig
s390                             allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a001
s390                             allyesconfig
i386                          randconfig-a014
arm                                 defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
mips                             allyesconfig
x86_64                        randconfig-a004
i386                          randconfig-a016
x86_64                           allyesconfig
x86_64                        randconfig-a002
m68k                             allmodconfig
i386                          randconfig-a003
arc                              allyesconfig
arm                  randconfig-r046-20221204
powerpc                           allnoconfig
x86_64                           rhel-8.3-kvm
powerpc                          allmodconfig
ia64                             allmodconfig
alpha                            allyesconfig
sh                               allmodconfig
arc                  randconfig-r043-20221204
i386                             allyesconfig
m68k                             allyesconfig
i386                          randconfig-a005
x86_64                        randconfig-a006
arm                              allyesconfig
arm64                            allyesconfig
i386                 randconfig-a016-20221205
i386                 randconfig-a013-20221205
i386                 randconfig-a012-20221205
i386                 randconfig-a015-20221205
i386                 randconfig-a011-20221205
i386                 randconfig-a014-20221205
x86_64                            allnoconfig
x86_64               randconfig-a014-20221205
x86_64               randconfig-a011-20221205
x86_64               randconfig-a012-20221205
x86_64               randconfig-a013-20221205
x86_64               randconfig-a016-20221205
x86_64               randconfig-a015-20221205
arm64                            alldefconfig
powerpc                 canyonlands_defconfig
arc                     nsimosci_hs_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
hexagon              randconfig-r041-20221204
x86_64                        randconfig-a012
s390                 randconfig-r044-20221204
x86_64                        randconfig-a014
i386                          randconfig-a011
x86_64                        randconfig-a016
i386                          randconfig-a013
hexagon              randconfig-r045-20221204
i386                          randconfig-a002
x86_64                        randconfig-a005
i386                          randconfig-a015
x86_64                        randconfig-a001
riscv                randconfig-r042-20221204
x86_64                        randconfig-a003
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a004-20221205
x86_64               randconfig-a005-20221205
x86_64               randconfig-a003-20221205
x86_64               randconfig-a006-20221205
x86_64               randconfig-a002-20221205
x86_64               randconfig-a001-20221205
i386                 randconfig-a003-20221205
i386                 randconfig-a004-20221205
i386                 randconfig-a001-20221205
i386                 randconfig-a002-20221205
i386                 randconfig-a005-20221205
i386                 randconfig-a006-20221205
x86_64                        randconfig-k001
hexagon              randconfig-r041-20221205
arm                  randconfig-r046-20221205
hexagon              randconfig-r045-20221205

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
