Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7504DCF47
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Mar 2022 21:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiCQU00 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Mar 2022 16:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiCQU0Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Mar 2022 16:26:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0C7149672
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 13:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647548708; x=1679084708;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=W69FxdYiWt76TiSRkohslX4/Vne3SVsUJ1oOz7CYny0=;
  b=mFk2/PbKc/lwso9ZaPiwXm6d3m4jLlGrG+cjpetxbLCIeWO9It0JZima
   YnTCxtlQzJOlTDX32DI7jvdLrZ9Ea5VS3PqLKy8sxwlTTvj8WKrcjFChq
   xqHJrsFwhaIgjaX9IS1rNNo4Xd//rMW4L2JJ1A2yGwA9xkWs2RJmRDf73
   MKDQqT3vtZB+ITbfVvbiOaaq5me9uIJxPHgJ1GxboVMy4CI2yrkRHDT9I
   b9CuMQ2CNtx1FdMwWexGNAYc8kxSIghfDw3mdr13NRZsPi86gXW3cvelX
   eQYsplwq4Mi7S+PPXAVtSikQz7mRgy/m0mZuoP17FOQgDFefBxmpo0C+0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="281773012"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="281773012"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 13:25:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="513570648"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 17 Mar 2022 13:25:06 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUwgD-000E2K-Up; Thu, 17 Mar 2022 20:25:05 +0000
Date:   Fri, 18 Mar 2022 04:24:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 3197706abd053275d2a561cfb7dc8f6cfaf7d02c
Message-ID: <623398e6.XlOuCxLde3Z3SsTV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 3197706abd053275d2a561cfb7dc8f6cfaf7d02c  RDMA/rxe: Use standard names for ref counting

elapsed time: 733m

configs tested: 119
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
sh                               alldefconfig
powerpc                     tqm8548_defconfig
xtensa                              defconfig
mips                  maltasmvp_eva_defconfig
x86_64                           alldefconfig
sh                         ecovec24_defconfig
arm                      jornada720_defconfig
mips                  decstation_64_defconfig
mips                      loongson3_defconfig
mips                      maltasmvp_defconfig
sh                ecovec24-romimage_defconfig
sparc                            alldefconfig
powerpc                       holly_defconfig
mips                       capcella_defconfig
arm                        clps711x_defconfig
m68k                       m5208evb_defconfig
riscv                               defconfig
sh                          rsk7201_defconfig
powerpc                      pasemi_defconfig
powerpc                      mgcoge_defconfig
powerpc                     ep8248e_defconfig
sh                            titan_defconfig
powerpc                     sequoia_defconfig
mips                         tb0226_defconfig
alpha                            alldefconfig
sh                          sdk7780_defconfig
arm                           stm32_defconfig
arm                        cerfcube_defconfig
sh                        dreamcast_defconfig
m68k                            q40_defconfig
mips                     decstation_defconfig
mips                           xway_defconfig
sh                            migor_defconfig
arm                  randconfig-c002-20220317
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
csky                                defconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                               defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a016
arc                  randconfig-r043-20220317
riscv                randconfig-r042-20220317
s390                 randconfig-r044-20220317
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
arm                  randconfig-c002-20220317
x86_64                        randconfig-c007
riscv                randconfig-c006-20220317
powerpc              randconfig-c003-20220317
mips                 randconfig-c004-20220317
i386                          randconfig-c001
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a015
i386                          randconfig-a011
i386                          randconfig-a013
hexagon              randconfig-r045-20220317
hexagon              randconfig-r041-20220317

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
