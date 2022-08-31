Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1343E5A86C8
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Aug 2022 21:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiHaTda (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Aug 2022 15:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiHaTd2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Aug 2022 15:33:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2CFE86A2
        for <linux-rdma@vger.kernel.org>; Wed, 31 Aug 2022 12:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661974407; x=1693510407;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=e34+6qUQpWQiCnBN8Pwb0qvUYT8B0mzjaFjdlXREPj8=;
  b=OpTEF/nV2Cimb/L6vE5pEpuSK8k9WLk1SM8Isz4stLlSoMVDdIWbEl7n
   xJdUoz8acvq8HnBVFD8Y72QdvGnVRoKRQ+oJJVwdBwzahgXxeDjN2Aevq
   KxJU9vmmpSwgIWYZGr5JNJ/kGY7z8mHWoBsNP2M+7QOXq3S4/dJn26Mfg
   nceaU8CcEawC98qYXFlgpdoLAT764T4oleLkl+YovxYDuIBXteDB0wYZC
   wJmX1MnoE4NQLIEEtaqeFl82IsWwNePvRdhJOn0+JNpxqeErRVjDV74jk
   GQBFCsrNhgBO5vxooAo4pFwsnxdcmprM15o9t0XeLnjBT8bs60TjmjNNE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="359486882"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="359486882"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 12:33:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="787966054"
Received: from lkp-server02.sh.intel.com (HELO 811e2ceaf0e5) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 31 Aug 2022 12:33:24 -0700
Received: from kbuild by 811e2ceaf0e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTTSm-0000dK-0r;
        Wed, 31 Aug 2022 19:33:24 +0000
Date:   Thu, 01 Sep 2022 03:32:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 2c02249fcbfc066bd33e2a7375c7006d4cb367f6
Message-ID: <630fb74e.W4qQ3OqHzJ6UlTmt%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 2c02249fcbfc066bd33e2a7375c7006d4cb367f6  RDMA/rxe: Delete error messages triggered by incoming Read requests

elapsed time: 725m

configs tested: 77
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
arc                  randconfig-r043-20220830
x86_64                        randconfig-a006
i386                                defconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a013
x86_64                        randconfig-a011
m68k                             allyesconfig
i386                          randconfig-a014
i386                             allyesconfig
x86_64                              defconfig
m68k                             allmodconfig
arc                              allyesconfig
arm64                            allyesconfig
i386                          randconfig-a012
arm                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a016
x86_64                        randconfig-a015
i386                          randconfig-a003
i386                          randconfig-a001
x86_64                               rhel-8.3
i386                          randconfig-a005
ia64                             allmodconfig
x86_64                           allyesconfig
arc                        nsim_700_defconfig
parisc                generic-32bit_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                          lboxre2_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arc                           tb10x_defconfig
arm                       multi_v4t_defconfig
parisc64                            defconfig
powerpc                      cm5200_defconfig
s390                 randconfig-r044-20220831
arc                  randconfig-r043-20220831
riscv                randconfig-r042-20220831
arm                            hisi_defconfig
powerpc                      pcm030_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                     rainier_defconfig
arm                      jornada720_defconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r045-20220830
hexagon              randconfig-r041-20220830
riscv                randconfig-r042-20220830
x86_64                        randconfig-a005
s390                 randconfig-r044-20220830
i386                          randconfig-a013
x86_64                        randconfig-a016
i386                          randconfig-a011
x86_64                        randconfig-a012
i386                          randconfig-a015
x86_64                        randconfig-a014
i386                          randconfig-a004
i386                          randconfig-a002
i386                          randconfig-a006
arm                        vexpress_defconfig
arm                         socfpga_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
