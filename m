Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DFC5A563C
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 23:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiH2Vcw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 17:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiH2Vcv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 17:32:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E38460C7
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 14:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661808771; x=1693344771;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=fPci53mxqXElEABc2ERovrcZLD+RxymmMITQa0wDffo=;
  b=KxSLRTSeMrc65mBfxiQe8Nqbd/u9rexLQqW9SrCasGFV4pHIJiU0d0n7
   J3e8SVrh0y0Rw1rn+4TQoL0QNx8rMEA3kwYmOpY9YTMfha4KCUubqdtF+
   wMWHHlH0AuKcgRz10uicQCZn75Rns5j3HcNcp2iZcOLBx30s9OoLQLLeA
   70iOXrZmHPHLTtKB/iodNZWl/Qkc0diU317J2sYxBnx+seuEOe8GoqOlC
   1g+9h+m/clBICCQmu62/QCVUBAX90VUlmDrAOtxMZjLOzIagVe6sKZq/B
   jWGaaXvv89pg7VKGBWxxNvhGN5c3Yj+tviWmxvaVb6GjIu+NUqRHwRUHW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="295007650"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="295007650"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 14:32:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="700725411"
Received: from lkp-server02.sh.intel.com (HELO e45bc14ccf4d) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Aug 2022 14:32:49 -0700
Received: from kbuild by e45bc14ccf4d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSmNE-0000Ky-34;
        Mon, 29 Aug 2022 21:32:48 +0000
Date:   Tue, 30 Aug 2022 05:32:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 ecf8dd4b9c3d9c7e8d4c725869226e465f315459
Message-ID: <630d306f.79vAG6coU4Y1nGPe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: ecf8dd4b9c3d9c7e8d4c725869226e465f315459  IB/cm: Refactor cm_insert_listen() and cm_find_listen()

elapsed time: 723m

configs tested: 77
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                 randconfig-a004-20220829
i386                 randconfig-a005-20220829
i386                 randconfig-a001-20220829
i386                 randconfig-a003-20220829
powerpc                           allnoconfig
i386                 randconfig-a002-20220829
powerpc                          allmodconfig
i386                 randconfig-a006-20220829
arc                              allyesconfig
x86_64                              defconfig
mips                             allyesconfig
x86_64                               rhel-8.3
arm64                            allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                           allyesconfig
arm                              allyesconfig
m68k                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
sh                               allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
arc                  randconfig-r043-20220829
x86_64               randconfig-a003-20220829
x86_64               randconfig-a004-20220829
x86_64               randconfig-a002-20220829
i386                                defconfig
x86_64               randconfig-a001-20220829
x86_64               randconfig-a005-20220829
x86_64               randconfig-a006-20220829
i386                             allyesconfig
xtensa                           alldefconfig
sh                            migor_defconfig
sh                      rts7751r2d1_defconfig
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
ia64                             allmodconfig
loongarch                           defconfig
loongarch                         allnoconfig
arm                         axm55xx_defconfig
sh                           se7343_defconfig
sh                        edosk7705_defconfig

clang tested configs:
hexagon              randconfig-r041-20220829
hexagon              randconfig-r045-20220829
s390                 randconfig-r044-20220829
riscv                randconfig-r042-20220829
i386                 randconfig-a011-20220829
i386                 randconfig-a014-20220829
i386                 randconfig-a013-20220829
i386                 randconfig-a015-20220829
i386                 randconfig-a012-20220829
i386                 randconfig-a016-20220829
x86_64               randconfig-a011-20220829
x86_64               randconfig-a012-20220829
x86_64               randconfig-a013-20220829
x86_64               randconfig-a014-20220829
x86_64               randconfig-a016-20220829
x86_64               randconfig-a015-20220829

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
