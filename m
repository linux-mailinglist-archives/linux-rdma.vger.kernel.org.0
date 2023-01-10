Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0F56637FD
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jan 2023 05:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjAJEE6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 23:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjAJEEh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 23:04:37 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B5533D7D
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 20:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673323476; x=1704859476;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lL1FeMLGR2Ses219o3jZVpMrn1u+InncSFUkdrdeOxs=;
  b=J77vNUvZdK0Bl7zm/1c4/T+xlp94t+hfZxeuGyOlVEKHHtrwMIEKMgtW
   vo/5mPbq6nB0F15K5HPybfDk9cK0adbUdAc03rfaxX4JUjyydWDUEWCqw
   aWRwzkNh9Ox7mlLcITsD7bv49fT56TMNypAWmpMKrIKgPMR5dCWBK5Boz
   AAs6GP6oYV9RMXx5wDfERyIpfAe8jrPbZfQpuOQ4/mFeTm24qWxtu4LAU
   Aho7gA+ephSQ9es8Ntfa4jnQir3Qav1ABenjOAKscu1AgW3B83zWs/BQz
   aFYlAq+kpPMMaQNqJiH2x3J3z16jSiVSbE8qeYS5BvOAcQm9lCgmWc8qC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="302751566"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="302751566"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 20:04:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="985621638"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="985621638"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jan 2023 20:04:34 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pF5sI-0007X0-0K;
        Tue, 10 Jan 2023 04:04:34 +0000
Date:   Tue, 10 Jan 2023 12:04:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 1d91855304c2046115ee10be2c93161d93d5d40d
Message-ID: <63bce3b8.aK1Y56gerFlDHkQy%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 1d91855304c2046115ee10be2c93161d93d5d40d  RDMA/hns: Support cqe inline in user space

elapsed time: 731m

configs tested: 92
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
x86_64                            allnoconfig
powerpc                           allnoconfig
sh                               allmodconfig
s390                             allmodconfig
mips                             allyesconfig
s390                                defconfig
s390                             allyesconfig
ia64                             allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                          allmodconfig
arm                                 defconfig
arm64                            allyesconfig
x86_64                              defconfig
arm                              allyesconfig
x86_64                               rhel-8.3
i386                 randconfig-a014-20230109
i386                 randconfig-a011-20230109
i386                 randconfig-a013-20230109
i386                                defconfig
i386                 randconfig-a012-20230109
i386                 randconfig-a016-20230109
x86_64                           allyesconfig
i386                 randconfig-a015-20230109
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
m68k                             allyesconfig
i386                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm                  randconfig-r046-20230108
arc                  randconfig-r043-20230108
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a014-20230109
x86_64               randconfig-a016-20230109
x86_64               randconfig-a012-20230109
x86_64               randconfig-a011-20230109
x86_64               randconfig-a013-20230109
x86_64               randconfig-a015-20230109
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          randconfig-c001
ia64                             alldefconfig
sh                             shx3_defconfig
arc                         haps_hs_defconfig
mips                      maltasmvp_defconfig
s390                 randconfig-r044-20230109
arc                  randconfig-r043-20230109
riscv                randconfig-r042-20230109
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
i386                 randconfig-a001-20230109
i386                 randconfig-a004-20230109
x86_64               randconfig-a003-20230109
i386                 randconfig-a002-20230109
i386                 randconfig-a003-20230109
x86_64               randconfig-a002-20230109
x86_64               randconfig-a004-20230109
i386                 randconfig-a006-20230109
x86_64               randconfig-a005-20230109
i386                 randconfig-a005-20230109
hexagon              randconfig-r045-20230108
x86_64               randconfig-a001-20230109
x86_64               randconfig-a006-20230109
riscv                randconfig-r042-20230108
hexagon              randconfig-r041-20230108
s390                 randconfig-r044-20230108
x86_64                        randconfig-k001
powerpc               mpc834x_itxgp_defconfig
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
hexagon              randconfig-r041-20230109
hexagon              randconfig-r045-20230109
arm                  randconfig-r046-20230109

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
