Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3332D53F3D9
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jun 2022 04:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiFGCLl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jun 2022 22:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiFGCLk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jun 2022 22:11:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F624FD3
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jun 2022 19:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654567899; x=1686103899;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/CMWrGFW1bGfwV4wHp+8r2vbYUYxUVRynXIAaQUrxYE=;
  b=Tje1Hl00QzcCPtSG704oLh4XZHFPRnk6qiWfmt6q32MOill8JHGqZhg5
   NeaLe8nCqbThzA264PQ+BNwukZ9O9hIy8OQHSF4ZHCo7ijszm0AKF6QVp
   CMIf4LbUWaL0qXFI6EDwwRSzHi4WAdn0FW4DwbISW6/jL3KRzZ27HynCT
   tAXv0IuNeRs45Kcf7p23ronRyPnRgeiodxbiDk7NCen3n536QfRwak3i8
   u4uAbpYEjowp1p/Bp19+8KDEtvwenybm7P6zWiF6dNas9quHg9JjdSqYH
   8qV6R9wNwJznM5PKPzVJRXEXh0YETVpLpCRaa+Xxo+TOQVsJ5H+uZVaP4
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="274239872"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="274239872"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 19:11:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="608997404"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 Jun 2022 19:11:37 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyOgy-000DEt-Lw;
        Tue, 07 Jun 2022 02:11:36 +0000
Date:   Tue, 07 Jun 2022 10:11:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:hmm] BUILD SUCCESS 5a865a32bf9b449da35956df247b69b78dc55ed1
Message-ID: <629eb3bc.bqdtlOU//bSyPRno%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git hmm
branch HEAD: 5a865a32bf9b449da35956df247b69b78dc55ed1  RDMA/erdma: Add driver to kernel build environment

elapsed time: 726m

configs tested: 113
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                          randconfig-c001
m68k                         amcore_defconfig
arm                          pxa3xx_defconfig
sh                   rts7751r2dplus_defconfig
sh                         ap325rxa_defconfig
arc                     haps_hs_smp_defconfig
xtensa                generic_kc705_defconfig
arc                      axs103_smp_defconfig
mips                        vocore2_defconfig
arm                      jornada720_defconfig
arc                                 defconfig
sh                ecovec24-romimage_defconfig
powerpc                     taishan_defconfig
sh                            shmin_defconfig
sh                           se7750_defconfig
sh                          sdk7786_defconfig
arm                        mvebu_v7_defconfig
ia64                        generic_defconfig
powerpc                    sam440ep_defconfig
powerpc                      chrp32_defconfig
nios2                         10m50_defconfig
arc                          axs103_defconfig
powerpc                     rainier_defconfig
arc                            hsdk_defconfig
arm                            qcom_defconfig
openrisc                    or1ksim_defconfig
m68k                                defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220605
riscv                             allnoconfig
h8300                            allyesconfig
m68k                             allyesconfig
xtensa                           allyesconfig
m68k                             allmodconfig
csky                                defconfig
mips                             allyesconfig
nios2                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
alpha                               defconfig
alpha                            allyesconfig
mips                             allmodconfig
sh                               allmodconfig
s390                                defconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
s390                             allmodconfig
riscv                          rv32_defconfig
parisc                              defconfig
parisc64                            defconfig
riscv                    nommu_k210_defconfig
parisc                           allyesconfig
riscv                            allmodconfig
riscv                            allyesconfig
s390                             allyesconfig
sparc                               defconfig
powerpc                          allyesconfig
i386                             allyesconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
sparc                            allyesconfig
powerpc                          allmodconfig
i386                                defconfig
um                             i386_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
ia64                             allmodconfig
arm64                               defconfig
ia64                             allyesconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
ia64                                defconfig
i386                          randconfig-a001
x86_64                        randconfig-a004
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a008
i386                          randconfig-a007
x86_64                        randconfig-a006
i386                          randconfig-a010
i386                          randconfig-a012
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a009
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
powerpc              randconfig-c003-20220606
riscv                randconfig-c006-20220606
s390                 randconfig-c005-20220606
i386                 randconfig-c001-20220606
mips                 randconfig-c004-20220606
x86_64               randconfig-c007-20220606
arm                  randconfig-c002-20220606
i386                          randconfig-a002
x86_64                        randconfig-a009
x86_64                        randconfig-a007
i386                          randconfig-a006
x86_64                        randconfig-a010
i386                          randconfig-a011
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a008
i386                          randconfig-a004
x86_64                        randconfig-a012

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
