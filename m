Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48C0577C31
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 09:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbiGRHKy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 03:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbiGRHKx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 03:10:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5F5175BB
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 00:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658128252; x=1689664252;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=UpRgkG2jSDoMt2JvxwZyFYHSlNElx5udQbzHxmfeWKY=;
  b=SKPqiexWsrDSMvIbQ2gBo3YAiireNe6cNAqiyA01qRzLAUs+9/UXhS1c
   XpElCzqYrWWXVRlR3C6xpWD6gLgqff9eHUQER1OMNEGEum7zjj+ZhzCxP
   W2Vm1am1XaS+gi5QDlTqqoIkktffhLZ9CDdrfaCr21Tf6ZjyWJvLjJOUx
   FODXFxY+x9kbU6sCE5rW0Mvigih8gKnvCeOiIcyHpDLZI9YzR9L+wXQ94
   vV8AlGj3d4SeMprmaO7+PKqBoHC6n3/f2JComDGFMYQLBa9a4R1tlzpwG
   /8lef53WHgK67miHqzKNejfVbUSTK87+v3v94153d1rCaYvukoFLaLBtR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="283719537"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="283719537"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 00:10:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="572289268"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 18 Jul 2022 00:10:28 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDKtf-00048M-S7;
        Mon, 18 Jul 2022 07:10:27 +0000
Date:   Mon, 18 Jul 2022 15:10:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 2157f5caaed59128d70a1dd72f5ec809cad54407
Message-ID: <62d5075f.UFmf4m1wPOUGd0TO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 2157f5caaed59128d70a1dd72f5ec809cad54407  ipoib: switch to netif_napi_add_weight()

elapsed time: 724m

configs tested: 131
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                           h5000_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                      tqm8xx_defconfig
xtensa                    xip_kc705_defconfig
m68k                        m5307c3_defconfig
arm                          simpad_defconfig
xtensa                          iss_defconfig
arm                         lubbock_defconfig
arm                          gemini_defconfig
sh                           se7705_defconfig
m68k                        stmark2_defconfig
arc                        nsimosci_defconfig
arm                            xcep_defconfig
arc                         haps_hs_defconfig
powerpc                      pcm030_defconfig
mips                            ar7_defconfig
alpha                             allnoconfig
arc                    vdk_hs38_smp_defconfig
m68k                            mac_defconfig
arm                       omap2plus_defconfig
powerpc                      chrp32_defconfig
powerpc                 mpc834x_itx_defconfig
um                             i386_defconfig
arc                     nsimosci_hs_defconfig
powerpc                      bamboo_defconfig
arm                         cm_x300_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
loongarch                           defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220717
ia64                             allmodconfig
csky                              allnoconfig
arc                               allnoconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                          randconfig-a005
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a015
x86_64               randconfig-a014-20220718
x86_64               randconfig-a016-20220718
x86_64               randconfig-a012-20220718
x86_64               randconfig-a013-20220718
x86_64               randconfig-a015-20220718
x86_64               randconfig-a011-20220718
x86_64                        randconfig-a011
x86_64                        randconfig-a013
i386                 randconfig-a015-20220718
i386                 randconfig-a011-20220718
i386                 randconfig-a012-20220718
i386                 randconfig-a014-20220718
i386                 randconfig-a016-20220718
i386                 randconfig-a013-20220718
i386                          randconfig-a014
i386                          randconfig-a016
i386                          randconfig-a012
arc                  randconfig-r043-20220717
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                     tqm5200_defconfig
arm                        spear3xx_defconfig
arm                         s3c2410_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                  colibri_pxa270_defconfig
powerpc                     mpc512x_defconfig
powerpc                     ppa8548_defconfig
powerpc                     mpc5200_defconfig
powerpc                    socrates_defconfig
powerpc                 mpc836x_mds_defconfig
arm                          moxart_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                          collie_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a004
i386                          randconfig-a002
i386                 randconfig-a004-20220718
i386                 randconfig-a001-20220718
i386                 randconfig-a005-20220718
i386                 randconfig-a006-20220718
i386                 randconfig-a002-20220718
i386                 randconfig-a003-20220718
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a015
i386                          randconfig-a013
i386                          randconfig-a011
x86_64               randconfig-a004-20220718
x86_64               randconfig-a003-20220718
x86_64               randconfig-a001-20220718
x86_64               randconfig-a002-20220718
x86_64               randconfig-a006-20220718
x86_64               randconfig-a005-20220718
s390                 randconfig-r044-20220717
hexagon              randconfig-r041-20220717
hexagon              randconfig-r045-20220717
riscv                randconfig-r042-20220717

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
