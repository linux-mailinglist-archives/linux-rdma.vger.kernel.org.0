Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18CB5A563D
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 23:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiH2VdL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 17:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiH2VdK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 17:33:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36236DFF
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 14:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661808789; x=1693344789;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=oNnqQZHtPfVAv0V++XDJ9qwb8vdOQd1N4uuGcDzIzFw=;
  b=Xh6dI9audQpPfEJhYuyS9M/FSYvP8uo9U+HGY9XtPfwvz0jAKUy9MyPi
   F1dHzXOF3jbQMeWpYILwo5XQ88rs4T5sDD4lHUb+Uxg1eWNi8tsh2kWjr
   iveM8vM5gg6L/71emm2ayCax5s4tQ4N7nyyYyo2hfujZ5q2CVEugYva6x
   NaEPPrPmpokXY7IWo2hhb2yPVaoGWojIQALbKGa+PlXelAZXLEeKuGjAE
   0e7NtZV6olvZsKFpLtQSaKKR7FbpbQniie8oBzEaulzBZfUvXBhrD1eA7
   wv1gcScspzA4Vwu7TnmMx+oXhfY6X/u062yDHwEP4nRaL2x/rsRib/xxO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="358968783"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="358968783"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 14:32:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="787240051"
Received: from lkp-server02.sh.intel.com (HELO e45bc14ccf4d) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 29 Aug 2022 14:32:49 -0700
Received: from kbuild by e45bc14ccf4d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSmNE-0000Kh-2m;
        Mon, 29 Aug 2022 21:32:48 +0000
Date:   Tue, 30 Aug 2022 05:32:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 27cfde795a96aef1e859a5480489944b95421e46
Message-ID: <630d306b.huUvGcTOqVC0VmaD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: 27cfde795a96aef1e859a5480489944b95421e46  RDMA/cma: Fix arguments order in net device validation

elapsed time: 722m

configs tested: 87
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
arc                                 defconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
alpha                               defconfig
x86_64                    rhel-8.3-kselftests
i386                                defconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arc                  randconfig-r043-20220829
i386                 randconfig-a001-20220829
i386                 randconfig-a003-20220829
i386                             allyesconfig
i386                 randconfig-a002-20220829
ia64                             allmodconfig
i386                 randconfig-a004-20220829
i386                 randconfig-a005-20220829
i386                 randconfig-a006-20220829
x86_64               randconfig-a002-20220829
x86_64               randconfig-a005-20220829
x86_64               randconfig-a006-20220829
x86_64               randconfig-a003-20220829
x86_64               randconfig-a001-20220829
x86_64               randconfig-a004-20220829
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
xtensa                           alldefconfig
sh                            migor_defconfig
sh                      rts7751r2d1_defconfig
nios2                               defconfig
m68k                        m5407c3_defconfig
sh                          r7780mp_defconfig
m68k                          multi_defconfig
sh                                  defconfig
sh                          r7785rp_defconfig
sh                             shx3_defconfig
mips                       bmips_be_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm                           h5000_defconfig
arm                        keystone_defconfig
arm64                            alldefconfig
arc                          axs103_defconfig
sh                          lboxre2_defconfig
parisc64                            defconfig
loongarch                           defconfig
loongarch                         allnoconfig
nios2                            allyesconfig
s390                             allyesconfig
arm                         axm55xx_defconfig
sh                           se7343_defconfig
sh                        edosk7705_defconfig
parisc                           allyesconfig

clang tested configs:
x86_64               randconfig-a011-20220829
x86_64               randconfig-a014-20220829
x86_64               randconfig-a015-20220829
x86_64               randconfig-a012-20220829
x86_64               randconfig-a013-20220829
hexagon              randconfig-r041-20220829
x86_64               randconfig-a016-20220829
riscv                randconfig-r042-20220829
s390                 randconfig-r044-20220829
hexagon              randconfig-r045-20220829
i386                 randconfig-a011-20220829
i386                 randconfig-a014-20220829
i386                 randconfig-a013-20220829
i386                 randconfig-a012-20220829
i386                 randconfig-a015-20220829
i386                 randconfig-a016-20220829

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
