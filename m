Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3725680391
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jan 2023 02:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjA3Brp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 29 Jan 2023 20:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjA3Bro (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 29 Jan 2023 20:47:44 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A101ABC0
        for <linux-rdma@vger.kernel.org>; Sun, 29 Jan 2023 17:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675043263; x=1706579263;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lIfVP13RAr+Ol+qfCjf44gOFzP6H+AvyuoNL5rhm1qQ=;
  b=Pis8nS4MJ/VNNpC0fW39+kiWqYVobcbG7jXZM/FyJvpJtjsW33QvKJWV
   GOxYiCtZF2mKpjSGWU+pMGvHvur4p4QH+dSdFkqvP91ZYS/sO9c43O7Sk
   I0U7FFSc8uI+fcfCVA+x98uO71pqA8BbU3OWICIlMjOEe24OcPYya7hwM
   64TkYhBSHh+XbKSresU0VzT3ryq0Igovr6Xr6WHNcJOiLM35NYKLfjsfl
   4KH4JqtF2sVuaC0OPMrb6K8pEb0EBove8QEvEkDvVDYqGRXnhwSvelGuw
   8CwP/FP/eEOSYTdu2HvFwbGPrhB+GculawUNXgM3WG+aRgd0zj2n8Nm0i
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="307799692"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="307799692"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 17:47:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="772307165"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="772307165"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jan 2023 17:47:40 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMJGl-0003GQ-30;
        Mon, 30 Jan 2023 01:47:39 +0000
Date:   Mon, 30 Jan 2023 09:46:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 5d9745cead1f121974322b94ceadfb4d1e67960e
Message-ID: <63d7217b.m7zE6YLqMlvyJPAz%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: 5d9745cead1f121974322b94ceadfb4d1e67960e  RDMA/irdma: Fix potential NULL-ptr-dereference

elapsed time: 725m

configs tested: 88
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
arc                                 defconfig
um                           x86_64_defconfig
alpha                               defconfig
powerpc                           allnoconfig
s390                             allmodconfig
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
i386                                defconfig
s390                             allyesconfig
x86_64                        randconfig-a004
s390                                defconfig
x86_64                           rhel-8.3-kvm
i386                          randconfig-a001
x86_64                        randconfig-a002
x86_64                               rhel-8.3
x86_64                        randconfig-a013
i386                          randconfig-a003
x86_64                           rhel-8.3-bpf
arc                  randconfig-r043-20230129
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a011
i386                          randconfig-a005
mips                           ci20_defconfig
sh                               allmodconfig
x86_64                        randconfig-a006
arm                  randconfig-r046-20230129
arm                                 defconfig
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a014
x86_64                          rhel-8.3-func
ia64                             allmodconfig
i386                          randconfig-a012
x86_64                        randconfig-a015
parisc                              defconfig
mips                             allyesconfig
i386                          randconfig-a016
x86_64                           allyesconfig
powerpc                    amigaone_defconfig
powerpc                          allmodconfig
sh                         apsh4a3a_defconfig
arm64                            allyesconfig
arm                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                             allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                      ppc40x_defconfig
sh                           sh2007_defconfig
sh                      rts7751r2d1_defconfig
mips                      fuloong2e_defconfig
powerpc                        warp_defconfig
um                                  defconfig
arc                           tb10x_defconfig
i386                          randconfig-c001
sh                          kfr2r09_defconfig
sh                           se7705_defconfig
m68k                       m5475evb_defconfig
loongarch                 loongson3_defconfig
mips                          rb532_defconfig
loongarch                         allnoconfig

clang tested configs:
s390                 randconfig-r044-20230129
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a001
hexagon              randconfig-r041-20230129
riscv                randconfig-r042-20230129
x86_64                        randconfig-a003
hexagon              randconfig-r045-20230129
i386                          randconfig-a013
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a016
i386                          randconfig-a006
x86_64                        randconfig-a012
i386                          randconfig-a015
x86_64                        randconfig-a005
i386                          randconfig-a011
x86_64                        randconfig-a014
x86_64                        randconfig-k001
arm                      pxa255-idp_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
