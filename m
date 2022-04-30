Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D22515C30
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Apr 2022 12:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbiD3KUJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 30 Apr 2022 06:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiD3KUJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 30 Apr 2022 06:20:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF537C159
        for <linux-rdma@vger.kernel.org>; Sat, 30 Apr 2022 03:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651313807; x=1682849807;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RuPn4icwcDB8YP1wDGpEdJ3DOJ7EGb0Eh9rbPtvIERE=;
  b=d2uOhUALDeiK9hOpqcLl6V7dyR8wakLAk7GjNxWLb2flMeOj+Nz15oZU
   xtNgCAXCaBRO282eDLyV72F376rxCUqfK2EIL9tSfoErMwzbsgjg/1kuJ
   a/rYbXiQ6zV7aBwt1tHNbN+KaNRwBb9PZlXYkRfgecZe3YpVvD7tCUZ2j
   HZItQsnh1J3KmSO1YzWZkqJdF5XG8uzJ9/EbXi04iePKysVNRuORbjlQI
   +3xu2TL+V4AFdGfEJGntj/+907cfxtcv3Z4qp6smBF1lOXixTeR0jO53i
   mKf/V/2Xxq4mtYNTDM5qzKu2z5CdeRA4desqrsTo3YwVGk3X5qZvLax40
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="327373210"
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="327373210"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 03:16:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="809482519"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 30 Apr 2022 03:16:45 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkk9c-00077d-KD;
        Sat, 30 Apr 2022 10:16:44 +0000
Date:   Sat, 30 Apr 2022 18:15:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 ff815a89398d8bbfdc14ced98252bdae92126225
Message-ID: <626d0c55.KBiT9eutTDJf213I%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: ff815a89398d8bbfdc14ced98252bdae92126225  RDMA/core: Avoid flush_workqueue(system_unbound_wq) usage

Unverified Warning (likely false positive, please contact us if interested):

drivers/infiniband/core/sa_query.c:1052:31: warning: Uninitialized variable: iter->seq [uninitvar]
drivers/infiniband/core/sa_query.c:848:16: warning: Uninitialized variables: wait_query.callback, wait_query.release, wait_query.client, wait_query.port, wait_query.mad_buf, wait_query.sm_ah, wait_query.id, wait_query.flags, wait_query.list, wait_query.seq, wait_query.timeout, wait_query.path_use [uninitvar]
drivers/infiniband/core/uverbs_cmd.c:3428:20: warning: The if condition is the same as the previous if condition [duplicateCondition]
drivers/infiniband/core/uverbs_cmd.c:522:23: warning: Parameter 'inode' can be declared with const [constParameter]
drivers/infiniband/sw/siw/siw_verbs.c:68:5: warning: Redundant initialization for 'rv'. The initialized value is overwritten before it is read. [redundantInitialization]

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-randconfig-p002-20220425
    |-- drivers-infiniband-core-sa_query.c:warning:Uninitialized-variable:iter-seq-uninitvar
    |-- drivers-infiniband-core-sa_query.c:warning:Uninitialized-variables:wait_query.callback-wait_query.release-wait_query.client-wait_query.port-wait_query.mad_buf-wait_query.sm_ah-wait_query.id-wait_query
    |-- drivers-infiniband-core-uverbs_cmd.c:warning:Parameter-inode-can-be-declared-with-const-constParameter
    |-- drivers-infiniband-core-uverbs_cmd.c:warning:The-if-condition-is-the-same-as-the-previous-if-condition-duplicateCondition
    `-- drivers-infiniband-sw-siw-siw_verbs.c:warning:Redundant-initialization-for-rv-.-The-initialized-value-is-overwritten-before-it-is-read.-redundantInitialization

elapsed time: 6552m

configs tested: 297
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-c001-20220425
powerpc              randconfig-c003-20220428
i386                          randconfig-c001
sh                            shmin_defconfig
mips                           ip32_defconfig
ia64                          tiger_defconfig
mips                     decstation_defconfig
m68k                            q40_defconfig
arm                           corgi_defconfig
sh                           se7724_defconfig
parisc                generic-32bit_defconfig
mips                         cobalt_defconfig
mips                  decstation_64_defconfig
arm                            zeus_defconfig
arm                      integrator_defconfig
arc                              alldefconfig
arm                           sunxi_defconfig
mips                             allyesconfig
mips                         tb0226_defconfig
arc                        nsimosci_defconfig
powerpc                      arches_defconfig
powerpc                 linkstation_defconfig
sh                     sh7710voipgw_defconfig
sh                        edosk7705_defconfig
h8300                            alldefconfig
powerpc                 mpc8540_ads_defconfig
arm                            xcep_defconfig
arm                           viper_defconfig
ia64                      gensparse_defconfig
powerpc                 mpc837x_rdb_defconfig
m68k                       bvme6000_defconfig
powerpc                     ep8248e_defconfig
s390                                defconfig
sh                        edosk7760_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      ppc6xx_defconfig
arm                       multi_v4t_defconfig
arm                      jornada720_defconfig
sh                           se7206_defconfig
powerpc                    adder875_defconfig
sh                           se7619_defconfig
mips                  maltasmvp_eva_defconfig
sh                   secureedge5410_defconfig
sh                          r7780mp_defconfig
sh                     magicpanelr2_defconfig
nios2                               defconfig
h8300                     edosk2674_defconfig
arm                      footbridge_defconfig
s390                             allmodconfig
powerpc                     taishan_defconfig
sparc                       sparc64_defconfig
powerpc                        cell_defconfig
parisc                generic-64bit_defconfig
arm                         cm_x300_defconfig
microblaze                      mmu_defconfig
arm                         lpc18xx_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                         assabet_defconfig
xtensa                generic_kc705_defconfig
openrisc                  or1klitex_defconfig
powerpc                     tqm8541_defconfig
powerpc                       holly_defconfig
mips                            gpr_defconfig
arc                           tb10x_defconfig
xtensa                          iss_defconfig
arm                            lart_defconfig
powerpc                         ps3_defconfig
sh                          r7785rp_defconfig
alpha                               defconfig
m68k                           sun3_defconfig
sh                              ul2_defconfig
sh                          sdk7786_defconfig
arc                                 defconfig
sh                          rsk7264_defconfig
powerpc                     mpc83xx_defconfig
sh                      rts7751r2d1_defconfig
m68k                        m5272c3_defconfig
sh                             shx3_defconfig
sh                           se7780_defconfig
mips                      maltasmvp_defconfig
arc                     nsimosci_hs_defconfig
m68k                       m5249evb_defconfig
xtensa                           alldefconfig
arm                          gemini_defconfig
arm                          exynos_defconfig
mips                             allmodconfig
arm                        oxnas_v6_defconfig
sh                          landisk_defconfig
arc                         haps_hs_defconfig
m68k                       m5208evb_defconfig
xtensa                  cadence_csp_defconfig
parisc                              defconfig
powerpc                     tqm8548_defconfig
sh                         ecovec24_defconfig
xtensa                         virt_defconfig
powerpc                      mgcoge_defconfig
powerpc                   motionpro_defconfig
m68k                       m5475evb_defconfig
powerpc                 mpc837x_mds_defconfig
arc                            hsdk_defconfig
arm                            qcom_defconfig
ia64                            zx1_defconfig
h8300                    h8300h-sim_defconfig
sh                           se7721_defconfig
sparc64                             defconfig
sh                   sh7724_generic_defconfig
mips                     loongson1b_defconfig
m68k                        m5307c3_defconfig
arm                          simpad_defconfig
m68k                          sun3x_defconfig
nios2                            allyesconfig
m68k                                defconfig
arm                        cerfcube_defconfig
um                               alldefconfig
sh                          rsk7201_defconfig
arm                        multi_v7_defconfig
sh                ecovec24-romimage_defconfig
microblaze                          defconfig
powerpc                     pq2fads_defconfig
sh                               j2_defconfig
powerpc                           allnoconfig
arc                 nsimosci_hs_smp_defconfig
arm                            pleb_defconfig
arm                         vf610m4_defconfig
arc                        nsim_700_defconfig
mips                       capcella_defconfig
m68k                        mvme147_defconfig
h8300                       h8s-sim_defconfig
sh                             sh03_defconfig
sparc64                          alldefconfig
sh                           se7750_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                       aspeed_g5_defconfig
powerpc                  storcenter_defconfig
riscv                            allmodconfig
arc                      axs103_smp_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                    amigaone_defconfig
powerpc                   currituck_defconfig
powerpc                      cm5200_defconfig
i386                             alldefconfig
m68k                        mvme16x_defconfig
mips                           jazz_defconfig
powerpc                      makalu_defconfig
powerpc                      chrp32_defconfig
sparc                               defconfig
arm                        mini2440_defconfig
ia64                             alldefconfig
powerpc                     tqm8555_defconfig
powerpc                    klondike_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                         ap325rxa_defconfig
parisc64                            defconfig
arm                        keystone_defconfig
x86_64                           alldefconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220428
arm                  randconfig-c002-20220425
x86_64               randconfig-c001-20220425
arm                  randconfig-c002-20220429
arm                  randconfig-c002-20220426
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
csky                                defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
sh                               allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a015-20220425
x86_64               randconfig-a014-20220425
x86_64               randconfig-a011-20220425
x86_64               randconfig-a013-20220425
x86_64               randconfig-a012-20220425
x86_64               randconfig-a016-20220425
i386                          randconfig-a012
i386                          randconfig-a016
i386                 randconfig-a011-20220425
i386                 randconfig-a012-20220425
i386                 randconfig-a013-20220425
i386                 randconfig-a014-20220425
i386                 randconfig-a016-20220425
i386                 randconfig-a015-20220425
x86_64                        randconfig-a002
arc                  randconfig-r043-20220425
s390                 randconfig-r044-20220425
riscv                randconfig-r042-20220425
arc                  randconfig-r043-20220428
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
riscv                randconfig-c006-20220428
mips                 randconfig-c004-20220428
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220428
powerpc              randconfig-c003-20220428
riscv                randconfig-c006-20220425
mips                 randconfig-c004-20220425
x86_64               randconfig-c007-20220425
arm                  randconfig-c002-20220425
i386                 randconfig-c001-20220425
powerpc              randconfig-c003-20220425
riscv                randconfig-c006-20220427
mips                 randconfig-c004-20220427
arm                  randconfig-c002-20220427
powerpc              randconfig-c003-20220427
s390                 randconfig-c005-20220425
riscv                randconfig-c006-20220429
mips                 randconfig-c004-20220429
arm                  randconfig-c002-20220429
powerpc              randconfig-c003-20220429
arm                       mainstone_defconfig
arm                       spear13xx_defconfig
mips                   sb1250_swarm_defconfig
arm                         shannon_defconfig
mips                     loongson2k_defconfig
arm                        vexpress_defconfig
arm                         palmz72_defconfig
arm                       cns3420vb_defconfig
powerpc                     tqm5200_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                     cu1830-neo_defconfig
powerpc                    mvme5100_defconfig
powerpc                      ppc44x_defconfig
arm                         s3c2410_defconfig
arm                      pxa255-idp_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                      walnut_defconfig
arm                              alldefconfig
mips                            e55_defconfig
arm                          moxart_defconfig
mips                           mtx1_defconfig
powerpc                    socrates_defconfig
arm                         bcm2835_defconfig
mips                          rm200_defconfig
arm                       netwinder_defconfig
mips                          ath25_defconfig
mips                       lemote2f_defconfig
mips                     loongson1c_defconfig
powerpc                        fsp2_defconfig
mips                      malta_kvm_defconfig
mips                           ip27_defconfig
mips                       rbtx49xx_defconfig
powerpc                          allmodconfig
i386                             allyesconfig
riscv                          rv32_defconfig
mips                     cu1000-neo_defconfig
arm                             mxs_defconfig
mips                         tb0287_defconfig
arm                          pxa168_defconfig
powerpc                 linkstation_defconfig
mips                      bmips_stb_defconfig
x86_64               randconfig-a002-20220425
x86_64               randconfig-a004-20220425
x86_64               randconfig-a003-20220425
x86_64               randconfig-a001-20220425
x86_64               randconfig-a005-20220425
x86_64               randconfig-a006-20220425
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a006-20220425
i386                 randconfig-a002-20220425
i386                 randconfig-a005-20220425
i386                 randconfig-a003-20220425
i386                 randconfig-a001-20220425
i386                 randconfig-a004-20220425
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220428
riscv                randconfig-r042-20220428
hexagon              randconfig-r045-20220428

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
