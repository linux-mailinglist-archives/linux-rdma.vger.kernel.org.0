Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B6063E2DA
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Nov 2022 22:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiK3VjG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Nov 2022 16:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiK3VjG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Nov 2022 16:39:06 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50985450B0
        for <linux-rdma@vger.kernel.org>; Wed, 30 Nov 2022 13:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669844345; x=1701380345;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=F72ELqpq7TxyuF4Pyx4bZzWUiDwv+eA5Xp01TbTnFUI=;
  b=UkSjuFEw9NJCmm4mob+oTkvnduelVxAgYLWpy34vQntZDWnwGBz6OCMf
   NSBD5wMsNJY2/ddyVlOTC8wfzdxzDxjyktjAvkA4P/XZfyVkLQlG5CWi2
   xqkopOjRUTsG9eYxVW6nT42AIhgjdu2NK0n/xsRvWj8hU09pYZ4ej8Mab
   6EHcCUPvVhRnh4abDOVFRgaNsnsaAcNBP5omFf2Syta5i/pkBbElVmbp5
   sgC49Q5pHbdXT0fGdLxIOUrZbaw7S5Xi3HLuybMoz/g3WKXpXL8pYdMgo
   7fMcibjFLaCo8360vVgwP+EnEvJBf5XoKwM4AZD07JIEe12LLJMFL/3rT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="313146152"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="313146152"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 13:38:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="750518557"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="750518557"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 30 Nov 2022 13:38:45 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p0Umy-000Bln-3D;
        Wed, 30 Nov 2022 21:38:45 +0000
Date:   Thu, 01 Dec 2022 05:38:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 fc8f93ad3e5485d45c992233c96acd902992dfc4
Message-ID: <6387cd40.aaNcThprk/M/yAPG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: fc8f93ad3e5485d45c992233c96acd902992dfc4  RDMA/nldev: Fix failure to send large messages

elapsed time: 728m

configs tested: 81
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
um                           x86_64_defconfig
um                             i386_defconfig
alpha                               defconfig
powerpc                           allnoconfig
s390                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                             allmodconfig
sh                               allmodconfig
m68k                             allyesconfig
s390                             allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
mips                             allyesconfig
arc                  randconfig-r043-20221128
x86_64                           rhel-8.3-syz
powerpc                          allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
x86_64                               rhel-8.3
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                            allnoconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
arm                       omap2plus_defconfig
powerpc                      ep88xc_defconfig
sparc64                          alldefconfig
i386                 randconfig-a001-20221128
i386                 randconfig-a005-20221128
i386                 randconfig-a006-20221128
i386                 randconfig-a004-20221128
i386                 randconfig-a003-20221128
i386                 randconfig-a002-20221128
sh                           se7722_defconfig
sh                          polaris_defconfig
sh                           se7705_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm                        trizeps4_defconfig
m68k                          atari_defconfig
sh                             shx3_defconfig
mips                 decstation_r4k_defconfig
ia64                            zx1_defconfig
sh                        edosk7705_defconfig
x86_64               randconfig-a002-20221128
x86_64               randconfig-a001-20221128
x86_64               randconfig-a004-20221128
x86_64               randconfig-a006-20221128
x86_64               randconfig-a005-20221128
x86_64               randconfig-a003-20221128

clang tested configs:
hexagon              randconfig-r045-20221128
hexagon              randconfig-r041-20221128
riscv                randconfig-r042-20221128
s390                 randconfig-r044-20221128
x86_64               randconfig-a013-20221128
x86_64               randconfig-a012-20221128
x86_64               randconfig-a014-20221128
x86_64               randconfig-a011-20221128
x86_64               randconfig-a015-20221128
x86_64               randconfig-a016-20221128
i386                 randconfig-a014-20221128
i386                 randconfig-a011-20221128
i386                 randconfig-a013-20221128
i386                 randconfig-a016-20221128
i386                 randconfig-a012-20221128
i386                 randconfig-a015-20221128
x86_64               randconfig-k001-20221128
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
