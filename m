Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D12612003
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Oct 2022 06:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJ2EZI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 29 Oct 2022 00:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJ2EZH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 29 Oct 2022 00:25:07 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF45317CD
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 21:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667017505; x=1698553505;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jcbJcTsdmg09Zs8Ecik/ZtNQTVFIz2kuvJh9BVOo4LA=;
  b=heQGAZaNURSyvhBAHaeOulch3Pz4aRhJ81Nb/sjvNDBrkb6c2/ioCuLJ
   ibsPja1ve4sZ234lc0olXj3us+M8oa1qoEpifBLsRJ/a5P07HUWgO2L/t
   s6yxcRBVCBxJ4pjaB4BpkcJisoyHNozKSVuUe0HnpxqOUljAAe9/5V1gK
   JutwBsTgHZ2rHqs0WlMmUrcqVtQwlBRTecCTG8K3Rfi2ML2RNyhT2fbB+
   h/dUmRd+oiNfbs6f3VAif2iLec7v5JBJ1XZCQsIWizxdZD0Q5gJEor2HN
   5WcZm8DxCGEctmh4R906zr7TCw5L7K+TEKcC5z2P0VYp6dPdJTRgpIwdf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="289029638"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="289029638"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 21:25:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="610965778"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="610965778"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 28 Oct 2022 21:25:02 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oodP4-000Aa1-0U;
        Sat, 29 Oct 2022 04:25:02 +0000
Date:   Sat, 29 Oct 2022 12:24:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 4508d32ccced24c972bc4592104513e1ff8439b5
Message-ID: <635cab1a.w4t/UORMFB43Aaeq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 4508d32ccced24c972bc4592104513e1ff8439b5  RDMA/core: Fix order of nldev_exit call

elapsed time: 722m

configs tested: 76
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
m68k                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
alpha                            allyesconfig
powerpc                           allnoconfig
arc                              allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
m68k                             allmodconfig
sh                               allmodconfig
i386                                defconfig
s390                                defconfig
arm                                 defconfig
arc                  randconfig-r043-20221028
riscv                randconfig-r042-20221028
i386                          randconfig-a014
s390                             allmodconfig
arm64                            allyesconfig
i386                          randconfig-a001
s390                 randconfig-r044-20221028
i386                          randconfig-a003
arm                              allyesconfig
i386                          randconfig-a012
x86_64                        randconfig-a013
i386                          randconfig-a016
x86_64                        randconfig-a011
x86_64                        randconfig-a004
i386                          randconfig-a005
x86_64                        randconfig-a002
x86_64                        randconfig-a015
x86_64                        randconfig-a006
i386                             allyesconfig
s390                             allyesconfig
x86_64                              defconfig
i386                          randconfig-c001
arm                            hisi_defconfig
xtensa                  cadence_csp_defconfig
m68k                           virt_defconfig
powerpc                       holly_defconfig
arm                          pxa3xx_defconfig
sh                        dreamcast_defconfig
powerpc                      ep88xc_defconfig
powerpc                       ppc64_defconfig
powerpc                      makalu_defconfig
arm                           u8500_defconfig
arm                         lpc18xx_defconfig
arm                      jornada720_defconfig

clang tested configs:
hexagon              randconfig-r041-20221028
i386                          randconfig-a013
hexagon              randconfig-r045-20221028
i386                          randconfig-a011
x86_64                        randconfig-a014
i386                          randconfig-a002
x86_64                        randconfig-a012
i386                          randconfig-a015
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a016
i386                          randconfig-a006
x86_64                        randconfig-a003
x86_64                        randconfig-a005
s390                 randconfig-r044-20221029
hexagon              randconfig-r041-20221029
hexagon              randconfig-r045-20221029
riscv                randconfig-r042-20221029
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
