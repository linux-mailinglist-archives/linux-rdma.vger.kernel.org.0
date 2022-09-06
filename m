Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992F65ADD03
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Sep 2022 03:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiIFBnK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Sep 2022 21:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiIFBnJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Sep 2022 21:43:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1049C6B150
        for <linux-rdma@vger.kernel.org>; Mon,  5 Sep 2022 18:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662428588; x=1693964588;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=WFdB0yqfuFGaiM4eDX9KVpzjXksmaRqkPAcAPrFM1ZQ=;
  b=IXDd+kuk5APLwpYuUCLGZClI0YMhpSyc+yOECYlD9nRj3dFH58Lp9s+P
   d0dWjYZDkLATJlG94v2tmQTM0PBPwWy+2bXl9yshFYP08xoFkDcDps4BN
   qEH/niIsbG685WZKXl3zzOEJLo01wVG5hvRjA7l8hGZ9MzaFesSCoxh7s
   sV1eOAUhz90S+5+FDfiDa82DRBganKAh/R1nkxlNP5I1u+ySzEcanqZt7
   DQhupxizFmrbG4liEbw74eOMKy84GVrD/ExWaZlpIc875+Lato6lABq6Z
   SORTIf4X0jRjIHUQfb8dVj70Z9XUjbpV18gBks4LAsSknFkAQwJ8welfG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="297788642"
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="297788642"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 18:43:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="717514348"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 05 Sep 2022 18:43:05 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVNcH-0004id-0q;
        Tue, 06 Sep 2022 01:43:05 +0000
Date:   Tue, 06 Sep 2022 09:42:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 bc7a2c9b17773c89f2f9c09ac9f9233716d6cd08
Message-ID: <6316a588.iw9VBeuhjqOLwIab%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: bc7a2c9b17773c89f2f9c09ac9f9233716d6cd08  MAINTAINERS: Update maintainers of HiSilicon RoCE

elapsed time: 740m

configs tested: 123
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
mips                      loongson3_defconfig
arm                           h3600_defconfig
sh                        sh7757lcr_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                 randconfig-a003-20220905
i386                 randconfig-a005-20220905
i386                 randconfig-a006-20220905
i386                 randconfig-a001-20220905
i386                 randconfig-a002-20220905
i386                 randconfig-a004-20220905
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm                            hisi_defconfig
ia64                         bigsur_defconfig
powerpc                         ps3_defconfig
sh                          r7780mp_defconfig
openrisc                 simple_smp_defconfig
i386                             allyesconfig
i386                                defconfig
x86_64               randconfig-a001-20220905
x86_64               randconfig-a006-20220905
x86_64               randconfig-a004-20220905
x86_64               randconfig-a003-20220905
x86_64               randconfig-a002-20220905
x86_64               randconfig-a005-20220905
sh                             sh03_defconfig
powerpc                      pcm030_defconfig
sh                           se7780_defconfig
m68k                          hp300_defconfig
riscv                               defconfig
powerpc                     tqm8541_defconfig
arm                           corgi_defconfig
arm                      integrator_defconfig
sh                         ap325rxa_defconfig
arm                        spear6xx_defconfig
arm                          iop32x_defconfig
sh                         microdev_defconfig
arm                            lart_defconfig
sh                           se7721_defconfig
mips                  decstation_64_defconfig
arc                            hsdk_defconfig
s390                          debug_defconfig
arm                         vf610m4_defconfig
i386                 randconfig-c001-20220905
arm64                               defconfig
sh                            titan_defconfig
powerpc                       maple_defconfig
m68k                        m5407c3_defconfig
powerpc                     sequoia_defconfig
mips                            ar7_defconfig
xtensa                          iss_defconfig
arm                             pxa_defconfig
loongarch                        alldefconfig
powerpc                  storcenter_defconfig
powerpc                 mpc834x_itx_defconfig
sparc                            allyesconfig
sh                             shx3_defconfig
mips                           ip32_defconfig
sh                          sdk7780_defconfig
openrisc                            defconfig
arm                          pxa910_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
um                               alldefconfig
parisc                generic-32bit_defconfig
loongarch                 loongson3_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                  randconfig-c002-20220905
x86_64               randconfig-c001-20220905
ia64                             allmodconfig

clang tested configs:
i386                 randconfig-a016-20220905
i386                 randconfig-a012-20220905
i386                 randconfig-a015-20220905
i386                 randconfig-a011-20220905
i386                 randconfig-a013-20220905
i386                 randconfig-a014-20220905
x86_64               randconfig-a014-20220905
x86_64               randconfig-a011-20220905
x86_64               randconfig-a016-20220905
x86_64               randconfig-a012-20220905
x86_64               randconfig-a015-20220905
x86_64               randconfig-a013-20220905
riscv                randconfig-r042-20220905
hexagon              randconfig-r041-20220905
hexagon              randconfig-r045-20220905
s390                 randconfig-r044-20220905
mips                       lemote2f_defconfig
arm                    vt8500_v6_v7_defconfig
mips                          ath25_defconfig
mips                           ip22_defconfig
arm                          moxart_defconfig
arm                         palmz72_defconfig
arm                        spear3xx_defconfig
powerpc                       ebony_defconfig
mips                      bmips_stb_defconfig
x86_64               randconfig-k001-20220905

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
