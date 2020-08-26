Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BD925286E
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Aug 2020 09:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHZH1n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Aug 2020 03:27:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:61462 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgHZH1m (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 26 Aug 2020 03:27:42 -0400
IronPort-SDR: V5vt9Y/PSan95vkt/GfYWMHTrmdqFnhgpFIKaEZ/a/N8mwyGA4ayhHKCxTwa5BnOoEOzteGlWR
 sayMzAQKgTxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="241064072"
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="241064072"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 00:27:39 -0700
IronPort-SDR: XPQ02y8KBIVnV2EWcdb8x6KqDWdQbRDxOYpcJl7b9j8KB4p5/D5oG7yG3/oKk2+VTh/L5ZRL3S
 dfCLDisLpUVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="336763544"
Received: from lkp-server01.sh.intel.com (HELO 4f455964fc6c) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Aug 2020 00:27:38 -0700
Received: from kbuild by 4f455964fc6c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kApqL-0001LI-Ge; Wed, 26 Aug 2020 07:27:37 +0000
Date:   Wed, 26 Aug 2020 15:27:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 8dc105befe16b6504ecc17a235b3c22932fa33dc
Message-ID: <5f460edd.v/c4hNKTg2KI7B1K%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 8dc105befe16b6504ecc17a235b3c22932fa33dc  RDMA/cm: Add tracepoints to track MAD send operations

elapsed time: 722m

configs tested: 142
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
xtensa                           allyesconfig
powerpc                      pasemi_defconfig
parisc                generic-32bit_defconfig
sh                        apsh4ad0a_defconfig
microblaze                    nommu_defconfig
powerpc                          alldefconfig
mips                    maltaup_xpa_defconfig
sh                            shmin_defconfig
h8300                    h8300h-sim_defconfig
xtensa                generic_kc705_defconfig
mips                      bmips_stb_defconfig
mips                      maltasmvp_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc64                           defconfig
sh                               j2_defconfig
arm                        mvebu_v5_defconfig
arm                      tct_hammer_defconfig
mips                  maltasmvp_eva_defconfig
arm                            dove_defconfig
c6x                              allyesconfig
mips                          ath79_defconfig
arm                           sunxi_defconfig
arc                                 defconfig
powerpc                    mvme5100_defconfig
mips                             allyesconfig
arc                            hsdk_defconfig
mips                          rb532_defconfig
m68k                            q40_defconfig
arc                    vdk_hs38_smp_defconfig
mips                       capcella_defconfig
arm                        magician_defconfig
arm                          pxa910_defconfig
mips                      pic32mzda_defconfig
sh                ecovec24-romimage_defconfig
arm                        multi_v5_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                         cobalt_defconfig
arm                           h3600_defconfig
sh                   secureedge5410_defconfig
xtensa                           alldefconfig
microblaze                          defconfig
arc                        nsimosci_defconfig
arm                    vt8500_v6_v7_defconfig
arc                        vdk_hs38_defconfig
mips                         bigsur_defconfig
arm                           omap1_defconfig
arm                           h5000_defconfig
arm                          moxart_defconfig
arm                            mmp2_defconfig
m68k                       bvme6000_defconfig
arm                           corgi_defconfig
riscv                    nommu_virt_defconfig
mips                         mpc30x_defconfig
arm                             ezx_defconfig
mips                         rt305x_defconfig
arm                     davinci_all_defconfig
arm                          exynos_defconfig
riscv                            allmodconfig
arm                         at91_dt_defconfig
m68k                         amcore_defconfig
mips                  decstation_64_defconfig
sh                              ul2_defconfig
arm                       aspeed_g4_defconfig
sparc                               defconfig
sh                        dreamcast_defconfig
mips                      maltaaprp_defconfig
m68k                             allyesconfig
sh                         ap325rxa_defconfig
arm                            qcom_defconfig
arm                         s3c6400_defconfig
mips                        bcm63xx_defconfig
arm                          imote2_defconfig
arm                          pxa3xx_defconfig
xtensa                       common_defconfig
riscv                          rv32_defconfig
arm                       imx_v4_v5_defconfig
mips                         tb0226_defconfig
sh                          sdk7786_defconfig
powerpc                      ppc64e_defconfig
arm                        multi_v7_defconfig
mips                      pistachio_defconfig
arc                     nsimosci_hs_defconfig
sh                        edosk7705_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a002-20200826
i386                 randconfig-a004-20200826
i386                 randconfig-a003-20200826
i386                 randconfig-a005-20200826
i386                 randconfig-a006-20200826
i386                 randconfig-a001-20200826
x86_64               randconfig-a015-20200826
x86_64               randconfig-a016-20200826
x86_64               randconfig-a012-20200826
x86_64               randconfig-a014-20200826
x86_64               randconfig-a011-20200826
x86_64               randconfig-a013-20200826
i386                 randconfig-a013-20200826
i386                 randconfig-a012-20200826
i386                 randconfig-a011-20200826
i386                 randconfig-a016-20200826
i386                 randconfig-a015-20200826
i386                 randconfig-a014-20200826
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
