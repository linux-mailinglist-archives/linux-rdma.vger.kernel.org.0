Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9296198A9F
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2020 05:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgCaDo0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Mar 2020 23:44:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:25722 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727464AbgCaDo0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 30 Mar 2020 23:44:26 -0400
IronPort-SDR: 3PArbmJgx7XSyNGmU6Zn9X7aa/EVJr9NDJMZ6P0DewshyauVtNXvGpGWlStnT1feKeF6IAV8AG
 i0FE21OqHFkg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 20:44:25 -0700
IronPort-SDR: nFFiRvv7Ck2JFfK0Fimde6ogCJuQPv1G0WnxE9a9qKIt7eOzhR95bWgmPCaMjZZDNhZt/zcva0
 9Ysy56HenmhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,326,1580803200"; 
   d="scan'208";a="450019858"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 30 Mar 2020 20:44:24 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jJ7p9-0008Nd-OJ; Tue, 31 Mar 2020 11:44:23 +0800
Date:   Tue, 31 Mar 2020 11:43:35 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 b4d8ddf8356d8ac73fb931d16bcc661a83b2c0fe
Message-ID: <5e82bc67.Pv9KQlMEcaEVuUez%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  for-next
branch HEAD: b4d8ddf8356d8ac73fb931d16bcc661a83b2c0fe  RDMA/bnxt_re: make bnxt_re_ib_init static

elapsed time: 483m

configs tested: 216
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
sparc                            allyesconfig
powerpc                             defconfig
i386                             allyesconfig
ia64                                defconfig
xtensa                          iss_defconfig
i386                                defconfig
i386                              allnoconfig
i386                             alldefconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
alpha                               defconfig
csky                                defconfig
nds32                               defconfig
nds32                             allnoconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200330
x86_64               randconfig-a002-20200330
i386                 randconfig-a001-20200330
i386                 randconfig-a002-20200330
i386                 randconfig-a003-20200330
x86_64               randconfig-a003-20200330
x86_64               randconfig-a001-20200331
x86_64               randconfig-a002-20200331
x86_64               randconfig-a003-20200331
i386                 randconfig-a001-20200331
i386                 randconfig-a002-20200331
i386                 randconfig-a003-20200331
alpha                randconfig-a001-20200330
m68k                 randconfig-a001-20200330
nds32                randconfig-a001-20200330
parisc               randconfig-a001-20200330
riscv                randconfig-a001-20200330
mips                 randconfig-a001-20200330
c6x                  randconfig-a001-20200330
h8300                randconfig-a001-20200330
microblaze           randconfig-a001-20200330
nios2                randconfig-a001-20200330
sparc64              randconfig-a001-20200330
c6x                  randconfig-a001-20200331
h8300                randconfig-a001-20200331
microblaze           randconfig-a001-20200331
nios2                randconfig-a001-20200331
sparc64              randconfig-a001-20200331
csky                 randconfig-a001-20200330
openrisc             randconfig-a001-20200330
s390                 randconfig-a001-20200330
sh                   randconfig-a001-20200330
xtensa               randconfig-a001-20200330
csky                 randconfig-a001-20200331
openrisc             randconfig-a001-20200331
s390                 randconfig-a001-20200331
sh                   randconfig-a001-20200331
xtensa               randconfig-a001-20200331
x86_64               randconfig-b001-20200330
x86_64               randconfig-b002-20200330
x86_64               randconfig-b003-20200330
i386                 randconfig-b001-20200330
i386                 randconfig-b002-20200330
i386                 randconfig-b003-20200330
x86_64               randconfig-b001-20200331
x86_64               randconfig-b002-20200331
x86_64               randconfig-b003-20200331
i386                 randconfig-b001-20200331
i386                 randconfig-b002-20200331
i386                 randconfig-b003-20200331
x86_64               randconfig-c001-20200330
x86_64               randconfig-c002-20200330
x86_64               randconfig-c003-20200330
i386                 randconfig-c001-20200330
i386                 randconfig-c002-20200330
i386                 randconfig-c003-20200330
x86_64               randconfig-c001-20200331
x86_64               randconfig-c002-20200331
x86_64               randconfig-c003-20200331
i386                 randconfig-c001-20200331
i386                 randconfig-c002-20200331
i386                 randconfig-c003-20200331
x86_64               randconfig-d001-20200330
x86_64               randconfig-d002-20200330
x86_64               randconfig-d003-20200330
i386                 randconfig-d001-20200330
i386                 randconfig-d002-20200330
i386                 randconfig-d003-20200330
x86_64               randconfig-d001-20200331
x86_64               randconfig-d002-20200331
x86_64               randconfig-d003-20200331
i386                 randconfig-d001-20200331
i386                 randconfig-d002-20200331
i386                 randconfig-d003-20200331
x86_64               randconfig-e001-20200330
x86_64               randconfig-e002-20200330
x86_64               randconfig-e003-20200330
i386                 randconfig-e001-20200330
i386                 randconfig-e002-20200330
i386                 randconfig-e003-20200330
x86_64               randconfig-f001-20200331
x86_64               randconfig-f002-20200331
x86_64               randconfig-f003-20200331
i386                 randconfig-f001-20200331
i386                 randconfig-f002-20200331
i386                 randconfig-f003-20200331
x86_64               randconfig-f001-20200330
x86_64               randconfig-f002-20200330
x86_64               randconfig-f003-20200330
i386                 randconfig-f001-20200330
i386                 randconfig-f002-20200330
i386                 randconfig-f003-20200330
x86_64               randconfig-g001-20200330
x86_64               randconfig-g002-20200330
x86_64               randconfig-g003-20200330
i386                 randconfig-g001-20200330
i386                 randconfig-g002-20200330
i386                 randconfig-g003-20200330
x86_64               randconfig-g001-20200331
x86_64               randconfig-g002-20200331
x86_64               randconfig-g003-20200331
i386                 randconfig-g001-20200331
i386                 randconfig-g002-20200331
i386                 randconfig-g003-20200331
x86_64               randconfig-h001-20200331
x86_64               randconfig-h002-20200331
x86_64               randconfig-h003-20200331
i386                 randconfig-h001-20200331
i386                 randconfig-h002-20200331
i386                 randconfig-h003-20200331
x86_64               randconfig-h001-20200330
x86_64               randconfig-h002-20200330
x86_64               randconfig-h003-20200330
i386                 randconfig-h001-20200330
i386                 randconfig-h002-20200330
i386                 randconfig-h003-20200330
arc                  randconfig-a001-20200330
arm                  randconfig-a001-20200330
arm64                randconfig-a001-20200330
ia64                 randconfig-a001-20200330
powerpc              randconfig-a001-20200330
sparc                randconfig-a001-20200330
riscv                            allmodconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
