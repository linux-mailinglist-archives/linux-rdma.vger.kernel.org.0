Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A93A62B763
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Nov 2022 11:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiKPKNx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Nov 2022 05:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiKPKNe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Nov 2022 05:13:34 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F18B2B617
        for <linux-rdma@vger.kernel.org>; Wed, 16 Nov 2022 02:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668593580; x=1700129580;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8XZBn4ckGdeTovntN3R6CJRTbwcZ1UeNNgYloHFjwUo=;
  b=ORTJnNdCCVj9gjK5IzpwiZU1S9a/L+nZu5Wvo440D/ZwKNmwqfs+QUd9
   pY7pB1QUB1MOoqjUY6fx0rqW1WHKLgiXZgtjawcIkI6sg4INGTmh4oToB
   8Jp/Q6ogDmyoxT4uGfDpA9xBlquncf+xNX9U1dEmz03GntIyw/OwTOcii
   iWiu3FcziHln/mnZS9vh2jUB6VozOO91k+Kwu1h7MhUQuqHrNNXK9XNJ5
   oKPHiNV4sfr6/jGnOVOMMxH0NmJFTAt1jE3wzeumDXmPcq3IuUxnIBaPs
   rVSPEPTWtR0P25busAicMLPeGeybDDMR39nEWIp2twWeukl+oH/YRdsHZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="295872790"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="295872790"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 02:12:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="670443436"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="670443436"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 16 Nov 2022 02:11:58 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ovFOf-0002Ez-1B;
        Wed, 16 Nov 2022 10:11:57 +0000
Date:   Wed, 16 Nov 2022 18:11:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 60da2d11fcbc043304910e4d2ca82f9bab953e63
Message-ID: <6374b73e.kWUADkNP7WScCV8H%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 60da2d11fcbc043304910e4d2ca82f9bab953e63  RDMA/siw: Set defined status for work completion with undefined status

elapsed time: 725m

configs tested: 78
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allmodconfig
s390                                defconfig
powerpc                          allmodconfig
m68k                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
alpha                            allyesconfig
arc                              allyesconfig
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a002
x86_64                         rhel-8.3-kunit
arc                  randconfig-r043-20221115
m68k                             allyesconfig
x86_64                           rhel-8.3-kvm
s390                 randconfig-r044-20221115
ia64                             allmodconfig
x86_64                              defconfig
x86_64                        randconfig-a006
riscv                randconfig-r042-20221115
x86_64                               rhel-8.3
x86_64                        randconfig-a004
x86_64                           allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                                defconfig
i386                          randconfig-a005
i386                          randconfig-a014
i386                          randconfig-a012
arm                                 defconfig
i386                          randconfig-a016
arm64                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig
s390                             allyesconfig
powerpc                           allnoconfig
x86_64                            allnoconfig
mips                             allyesconfig
sh                               allmodconfig
i386                 randconfig-a002-20221114
i386                 randconfig-a004-20221114
i386                 randconfig-a003-20221114
i386                 randconfig-a005-20221114
i386                 randconfig-a006-20221114
i386                 randconfig-a001-20221114
mips                     decstation_defconfig
arm                      footbridge_defconfig
sh                         apsh4a3a_defconfig
openrisc                 simple_smp_defconfig
m68k                            q40_defconfig
sparc                       sparc32_defconfig
powerpc                      makalu_defconfig
xtensa                  nommu_kc705_defconfig
arm                          pxa910_defconfig
sh                          rsk7264_defconfig
loongarch                        alldefconfig
sh                   sh7770_generic_defconfig
mips                           ip32_defconfig

clang tested configs:
x86_64               randconfig-a012-20221114
x86_64               randconfig-a016-20221114
x86_64               randconfig-a015-20221114
x86_64               randconfig-a013-20221114
x86_64               randconfig-a011-20221114
x86_64               randconfig-a014-20221114
hexagon              randconfig-r041-20221115
hexagon              randconfig-r045-20221115
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
