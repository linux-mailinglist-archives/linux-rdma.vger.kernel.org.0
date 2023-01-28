Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABBF67F8AC
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Jan 2023 15:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjA1OZo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Jan 2023 09:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbjA1OZn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 28 Jan 2023 09:25:43 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A0AA5D1
        for <linux-rdma@vger.kernel.org>; Sat, 28 Jan 2023 06:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674915942; x=1706451942;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=WkG+uYRu2DKmUL0x/LB8hlOYOH0ccoZsL8UyUVF4n7M=;
  b=hCg4QNteqx22Oqh6vkDWNc6y5fAep//hnGlOYnb2S1J5GxEi2pSo/7CE
   12KBZ90mhy2LGUt0L/3wzSJBPA/fQzDGI/HuuOzC3MDQucNKCmI5lTeOf
   sTGS5bwC8iBpZAmjKjqfhCCaupCcIVvZzy0DudnlcrQUQ49y62dYnXKa/
   y7EEmA8vtMEpNBZH+h+Ugd1aFXxhCo5MQaWBVRB4UDSEG81ojmJ9W7KYd
   cr7N656NwyP4meXKjms0CHm/hn2chx+lGD1vwvMs1c4t9kGnoGqWp7hvb
   L0iVbYDLhb0PpFG1uQZHZOeCJICFc+45C8vrOIoHsXJC1qVjzaVMkLi2t
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="389672966"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="389672966"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 06:25:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="641038233"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="641038233"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Jan 2023 06:25:39 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLm98-0000n7-1X;
        Sat, 28 Jan 2023 14:25:34 +0000
Date:   Sat, 28 Jan 2023 22:24:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 627122280c878cf5d3cda2d2c5a0a8f6a7e35cb7
Message-ID: <63d53025.EEe18VzkHpQz/WCW%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 627122280c878cf5d3cda2d2c5a0a8f6a7e35cb7  RDMA/mlx5: Add work to remove temporary entries from the cache

elapsed time: 739m

configs tested: 82
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64               randconfig-a002-20230123
x86_64               randconfig-a005-20230123
x86_64               randconfig-a001-20230123
x86_64               randconfig-a006-20230123
x86_64               randconfig-a003-20230123
x86_64               randconfig-a004-20230123
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
i386                 randconfig-a004-20230123
i386                 randconfig-a006-20230123
i386                 randconfig-a005-20230123
i386                 randconfig-a002-20230123
i386                 randconfig-a003-20230123
i386                 randconfig-a001-20230123
um                           x86_64_defconfig
um                             i386_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                 randconfig-c001-20230123
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
m68k                         amcore_defconfig
powerpc                      makalu_defconfig
m68k                        mvme147_defconfig
m68k                          amiga_defconfig
mips                          rb532_defconfig

clang tested configs:
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
x86_64               randconfig-a016-20230123
x86_64               randconfig-a012-20230123
x86_64               randconfig-a015-20230123
x86_64               randconfig-a014-20230123
riscv                randconfig-r042-20230123
hexagon              randconfig-r041-20230123
hexagon              randconfig-r045-20230123
s390                 randconfig-r044-20230123
i386                 randconfig-a013-20230123
i386                 randconfig-a016-20230123
i386                 randconfig-a012-20230123
i386                 randconfig-a015-20230123
i386                 randconfig-a011-20230123
i386                 randconfig-a014-20230123
powerpc                 mpc832x_mds_defconfig
powerpc                      walnut_defconfig
arm                        mvebu_v5_defconfig
arm                           sama7_defconfig
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230124
hexagon              randconfig-r045-20230124
arm                  randconfig-r046-20230124

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
