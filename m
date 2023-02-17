Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFCA69A4EA
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Feb 2023 05:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjBQEgG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Feb 2023 23:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBQEgF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Feb 2023 23:36:05 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5182822F
        for <linux-rdma@vger.kernel.org>; Thu, 16 Feb 2023 20:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676608561; x=1708144561;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lE2QC2IbAmnciGS2qmUZ1OUjk3jI1GZc9tNXf5C+zMw=;
  b=N54X9o/BvxJr1Yap+kgfVbpCs6EasgXAY/xs/VBSHAxnX9ZZlOGf5OyH
   7In6VAvlQ/5FWPWoQquspqtCvU6qGnT66gdb6e4uU04U04elJB/djjq3s
   IncZnyF4R+exxqfD3TLubZY7Novd13ORoDN5NmKQVyXfeUlEwSprpntqv
   EUz2Wxyd6Qhh6Hi0qosqWLbRyN6o4qk3Rgn74BfF79T1CzfUrOa2u5Pxl
   eqL8xwHMIzjlWAMrgovuWQ1A3yoorKn7Hyks414GBGfD5HvVqygUXBGRB
   hoVujTAJEt0BbaXXVjXYSGKZAP3P5K477Nc+pWKPEeTneFbrd+TxKmJRg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="320009622"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="320009622"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 20:36:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="672467001"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="672467001"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 16 Feb 2023 20:35:59 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pSsTX-000B7P-0P;
        Fri, 17 Feb 2023 04:35:59 +0000
Date:   Fri, 17 Feb 2023 12:35:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 a77a52385e9a761f896a88a4162e69fb7ccafe3f
Message-ID: <63ef0413.3A77FejVYbYqBVdU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LONGWORDS,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: a77a52385e9a761f896a88a4162e69fb7ccafe3f  RDMA/rxe: Fix missing memory barriers in rxe_queue.h

elapsed time: 720m

configs tested: 79
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
alpha                               defconfig
arc                              allyesconfig
arc                                 defconfig
arc                  randconfig-r043-20230212
arc                  randconfig-r043-20230213
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm                  randconfig-r046-20230212
arm64                            allyesconfig
arm64                               defconfig
csky                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
i386                 randconfig-a011-20230213
i386                 randconfig-a012-20230213
i386                 randconfig-a013-20230213
i386                 randconfig-a014-20230213
i386                 randconfig-a015-20230213
i386                 randconfig-a016-20230213
ia64                             allmodconfig
ia64                                defconfig
loongarch                        allmodconfig
loongarch                         allnoconfig
loongarch                           defconfig
m68k                             allmodconfig
m68k                                defconfig
mips                             allmodconfig
mips                             allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                randconfig-r042-20230213
riscv                          rv32_defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                                defconfig
s390                 randconfig-r044-20230213
sh                               allmodconfig
sparc                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                               rhel-8.3

clang tested configs:
arm                  randconfig-r046-20230213
hexagon              randconfig-r041-20230212
hexagon              randconfig-r041-20230213
hexagon              randconfig-r045-20230212
hexagon              randconfig-r045-20230213
i386                 randconfig-a001-20230213
i386                 randconfig-a002-20230213
i386                 randconfig-a003-20230213
i386                 randconfig-a004-20230213
i386                 randconfig-a005-20230213
i386                 randconfig-a006-20230213
riscv                randconfig-r042-20230212
s390                 randconfig-r044-20230212
x86_64               randconfig-a001-20230213
x86_64               randconfig-a002-20230213
x86_64               randconfig-a003-20230213
x86_64               randconfig-a004-20230213
x86_64               randconfig-a005-20230213
x86_64               randconfig-a006-20230213
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
