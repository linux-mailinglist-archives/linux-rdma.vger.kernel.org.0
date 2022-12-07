Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997AD646405
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Dec 2022 23:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiLGW0Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Dec 2022 17:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiLGW0X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Dec 2022 17:26:23 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95532716DC
        for <linux-rdma@vger.kernel.org>; Wed,  7 Dec 2022 14:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670451982; x=1701987982;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=R0DXSLGdqS9qnFVBboFES5eJOfx39vu5wXSSY0bPLng=;
  b=DYeVloA8wgqP6DKQfh0MAxi3Fj+DdN5uiUmTZoQCxViNIN+O5fQpyg7A
   09bpy5sQ/sful41e4UMGQHANE0nHz1X+o0onh5gbkzARieunH/iwWzy/Y
   ts9kL0PplH+gjupqZ37aU1k7B1bfzkOLSO/Itt3IY9GK/RVZDdXW+7JPg
   JDeV1YXVesGdgM0p/1BGW8qzw9/pHZrOnvomMHMTN8ijeZOakjgT5oFDe
   4BIF5Hxy0uHHI38LDUHa+7RDtu0dgfgHO9o7cSsVYV9hPPTRmrylK0MUG
   lEQvfkJ5wukhMdIP4qK9x+OwGOs52yLNsLwkBjjcMI4svz80gTZTkBaHM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="379184237"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="379184237"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 14:26:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="677527764"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="677527764"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 07 Dec 2022 14:26:20 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p32rs-0000cD-09;
        Wed, 07 Dec 2022 22:26:20 +0000
Date:   Thu, 08 Dec 2022 06:25:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 d074f0aebde5649f7a9f1807551efc019b8e81c4
Message-ID: <639112df.fvrElpBPYID/Rg+R%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: d074f0aebde5649f7a9f1807551efc019b8e81c4  RDMA/hfi1: use sysfs_emit() to instead of scnprintf()

elapsed time: 728m

configs tested: 124
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
i386                                defconfig
powerpc                           allnoconfig
x86_64                              defconfig
arc                                 defconfig
x86_64                        randconfig-a004
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a002
s390                             allmodconfig
alpha                               defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                        randconfig-a006
s390                                defconfig
i386                          randconfig-a014
x86_64                        randconfig-a013
sh                               allmodconfig
i386                          randconfig-a012
s390                             allyesconfig
i386                          randconfig-a016
x86_64                        randconfig-a011
ia64                             allmodconfig
i386                          randconfig-a001
i386                             allyesconfig
mips                             allyesconfig
x86_64                               rhel-8.3
i386                          randconfig-a003
x86_64                           rhel-8.3-syz
x86_64                           allyesconfig
powerpc                          allmodconfig
x86_64                         rhel-8.3-kunit
m68k                             allyesconfig
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20221207
m68k                        m5272c3_defconfig
m68k                             allmodconfig
arm                                 defconfig
arc                              allyesconfig
openrisc                    or1ksim_defconfig
m68k                         apollo_defconfig
riscv                randconfig-r042-20221207
alpha                            allyesconfig
s390                 randconfig-r044-20221207
sh                          kfr2r09_defconfig
arm64                            allyesconfig
arm                              allyesconfig
x86_64                            allnoconfig
arm                           viper_defconfig
sh                         microdev_defconfig
arm                         nhk8815_defconfig
m68k                            mac_defconfig
arm                        trizeps4_defconfig
powerpc                     tqm8555_defconfig
powerpc                     redwood_defconfig
m68k                           sun3_defconfig
xtensa                generic_kc705_defconfig
arc                     nsimosci_hs_defconfig
riscv             nommu_k210_sdcard_defconfig
i386                          randconfig-c001
mips                          rb532_defconfig
m68k                         amcore_defconfig
mips                            ar7_defconfig
mips                        vocore2_defconfig
sh                   sh7770_generic_defconfig
m68k                                defconfig
nios2                               defconfig
m68k                          amiga_defconfig
arm                         cm_x300_defconfig
xtensa                    xip_kc705_defconfig
um                               alldefconfig
csky                                defconfig
ia64                        generic_defconfig
sh                           se7343_defconfig
mips                  decstation_64_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sh                   sh7724_generic_defconfig
mips                         db1xxx_defconfig
sh                             espt_defconfig
arc                      axs103_smp_defconfig
mips                     decstation_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                  randconfig-c002-20221207
x86_64                        randconfig-c001

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
mips                           ip22_defconfig
i386                          randconfig-a011
x86_64                        randconfig-a016
arm                         palmz72_defconfig
i386                          randconfig-a002
x86_64                        randconfig-a012
arm                   milbeaut_m10v_defconfig
i386                          randconfig-a015
arm                      pxa255-idp_defconfig
arm                  randconfig-r046-20221207
i386                          randconfig-a006
x86_64                        randconfig-a014
i386                          randconfig-a004
hexagon              randconfig-r041-20221207
hexagon              randconfig-r045-20221207
powerpc                  mpc866_ads_defconfig
powerpc                      ppc64e_defconfig
mips                          ath25_defconfig
mips                           mtx1_defconfig
powerpc                 mpc8313_rdb_defconfig
x86_64                        randconfig-k001
arm                        multi_v5_defconfig
mips                          ath79_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                          allyesconfig
mips                       lemote2f_defconfig
powerpc                     ppa8548_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
