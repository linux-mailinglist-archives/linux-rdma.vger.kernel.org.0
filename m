Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F9666D739
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 08:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbjAQHvd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Jan 2023 02:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbjAQHvW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Jan 2023 02:51:22 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7028FD
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 23:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673941881; x=1705477881;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=drRvIpAaE1oZ+kySD4NQ6jECXeTkdM6hU8TLjUi8v3Y=;
  b=Htvgxt0rKRrUtAyUJMHiELK+1vjetWemGPersam32rNGiff1vP45AsfF
   4yNiYlCQ2Y9+E3MZYrm0XJW2ZoTYvsikPMNH+Gh6s4HKM+FbqLBSdIexb
   18mNh8mh6HEzox49A0zfknLRyCo9XQAZUB76tk9bK/AJBQy00uFH20dqT
   WQ4tPb2nC5pEgGfkkEJVe3KRYBTqty7Z0XYv1Hw/8aXIq04Tv50k1O3cb
   GmXc1uhQHcrZ3MUUL5NW7u7P7O8VTIMyaue8QpwQVEy7fA/aCQHjRVqa7
   wQZ7jqlYX6MHVfNjgxy7RDvMCbYuHhDOGwGeaReP0GsIROS2NyC/FJLWK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="324687078"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="324687078"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 23:51:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="988036627"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="988036627"
Received: from lkp-server02.sh.intel.com (HELO f57cd993bc73) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jan 2023 23:51:19 -0800
Received: from kbuild by f57cd993bc73 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pHgkZ-00014U-0L;
        Tue, 17 Jan 2023 07:51:19 +0000
Date:   Tue, 17 Jan 2023 15:50:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 41f4a67e6d2488489039a1d78c289143641046d0
Message-ID: <63c6535c.bhA68XORxeG8ArIw%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: 41f4a67e6d2488489039a1d78c289143641046d0  lib/scatterlist: Fix to calculate the last_pg properly

elapsed time: 722m

configs tested: 108
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
x86_64               randconfig-a011-20230116
s390                             allmodconfig
x86_64               randconfig-a013-20230116
x86_64               randconfig-a012-20230116
x86_64               randconfig-a014-20230116
x86_64               randconfig-a016-20230116
s390                                defconfig
x86_64               randconfig-a015-20230116
x86_64                            allnoconfig
s390                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
i386                             allyesconfig
i386                                defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
i386                 randconfig-a013-20230116
i386                 randconfig-a012-20230116
i386                 randconfig-a016-20230116
i386                 randconfig-a014-20230116
i386                 randconfig-a015-20230116
i386                 randconfig-a011-20230116
ia64                             allmodconfig
m68k                         apollo_defconfig
um                               alldefconfig
mips                         db1xxx_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                 kfr2r09-romimage_defconfig
riscv                randconfig-r042-20230116
arm                  randconfig-r046-20230117
s390                 randconfig-r044-20230116
arc                  randconfig-r043-20230117
arc                  randconfig-r043-20230116
sh                        sh7763rdp_defconfig
sh                         ap325rxa_defconfig
alpha                            alldefconfig
arc                         haps_hs_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                         s3c6400_defconfig
arm                            lart_defconfig
sh                        sh7757lcr_defconfig
i386                          randconfig-c001
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
arm64                               defconfig
sh                        dreamcast_defconfig
arm                       multi_v4t_defconfig
s390                          debug_defconfig
x86_64               randconfig-k001-20230116

clang tested configs:
i386                 randconfig-a002-20230116
i386                 randconfig-a004-20230116
i386                 randconfig-a001-20230116
i386                 randconfig-a003-20230116
i386                 randconfig-a005-20230116
i386                 randconfig-a006-20230116
arm                     am200epdkit_defconfig
mips                           mtx1_defconfig
powerpc                     pseries_defconfig
x86_64               randconfig-a003-20230116
x86_64               randconfig-a004-20230116
x86_64               randconfig-a006-20230116
x86_64               randconfig-a005-20230116
x86_64               randconfig-a001-20230116
x86_64               randconfig-a002-20230116
riscv                randconfig-r042-20230115
arm                  randconfig-r046-20230116
s390                 randconfig-r044-20230115
hexagon              randconfig-r041-20230115
hexagon              randconfig-r041-20230116
hexagon              randconfig-r045-20230115
hexagon              randconfig-r045-20230116
i386                              allnoconfig
powerpc                   lite5200b_defconfig
mips                  cavium_octeon_defconfig
x86_64                        randconfig-k001
x86_64                          rhel-8.3-rust
arm                         lpc32xx_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
