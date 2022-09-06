Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC805ADD04
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Sep 2022 03:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiIFBnL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Sep 2022 21:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiIFBnK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Sep 2022 21:43:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6277D6745D
        for <linux-rdma@vger.kernel.org>; Mon,  5 Sep 2022 18:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662428589; x=1693964589;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1PLR2Dfyl0V2v40j6JmcODoH1otj5v/RM1g+3DnXVgc=;
  b=GEHABouX9dL2mWxzESAFLP3g06DfdESkcXWUrQVpbqN6Aunues19f9iS
   zWDyD5uJeq6G0fUhc9gRC7ckTIDIFIi/OlhmN9Hz2E8l8Sm8/cesI25y+
   +3fKDEhSV6wuIZ4WyM2mVUFrLBfkuuLyAM4R8tDiyT6O5nMJCwNZ7pct4
   KodUWAmKG9B5KUG6Hilee/C5tePh9Em9NTI+XF1MdkX/6yEnAIMxZCVjX
   iDGL7uLdkA+9hyZhyyTQuNDTm3D3Ta7SirX7t0QuV9NrYSNSwt10AnSd7
   JM+IHb9HiKOCRgwj00NNy3Q6tmjFSO/RpaukyKngk+uAWs8LM40Wycx8r
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="276216126"
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="276216126"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 18:43:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="942268887"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 05 Sep 2022 18:43:05 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVNcH-0004ii-0y;
        Tue, 06 Sep 2022 01:43:05 +0000
Date:   Tue, 06 Sep 2022 09:42:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 e58f889e293e6bd13ae2b48208a4d0d15592bf5a
Message-ID: <6316a58e.pTGOVdjQm2asuZG2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: e58f889e293e6bd13ae2b48208a4d0d15592bf5a  RDMA/hfi1: Remove the unneeded result variable

elapsed time: 741m

configs tested: 138
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                             allyesconfig
i386                                defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arc                  randconfig-r043-20220905
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
m68k                        m5272c3_defconfig
powerpc                         ps3_defconfig
m68k                             alldefconfig
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
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm                                 defconfig
sh                           se7780_defconfig
sh                   sh7770_generic_defconfig
alpha                            alldefconfig
powerpc                      pasemi_defconfig
openrisc                    or1ksim_defconfig
x86_64               randconfig-a001-20220905
x86_64               randconfig-a006-20220905
x86_64               randconfig-a004-20220905
x86_64               randconfig-a003-20220905
x86_64               randconfig-a002-20220905
x86_64               randconfig-a005-20220905
arm64                            allyesconfig
arm                              allyesconfig
m68k                          hp300_defconfig
arm                        realview_defconfig
arc                          axs103_defconfig
alpha                               defconfig
mips                     loongson1b_defconfig
mips                      loongson3_defconfig
arm                           h3600_defconfig
sh                        sh7757lcr_defconfig
arm                            hisi_defconfig
ia64                         bigsur_defconfig
sh                          r7780mp_defconfig
openrisc                 simple_smp_defconfig
sh                             sh03_defconfig
powerpc                      pcm030_defconfig
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
i386                 randconfig-c001-20220905
s390                          debug_defconfig
arm                         vf610m4_defconfig
arc                        vdk_hs38_defconfig
mips                         bigsur_defconfig
arm                            zeus_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-a014-20220905
x86_64               randconfig-a011-20220905
x86_64               randconfig-a016-20220905
x86_64               randconfig-a012-20220905
x86_64               randconfig-a015-20220905
x86_64               randconfig-a013-20220905
hexagon              randconfig-r045-20220905
hexagon              randconfig-r041-20220905
riscv                randconfig-r042-20220905
s390                 randconfig-r044-20220905
i386                 randconfig-a016-20220905
i386                 randconfig-a012-20220905
i386                 randconfig-a015-20220905
i386                 randconfig-a011-20220905
i386                 randconfig-a013-20220905
i386                 randconfig-a014-20220905
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
