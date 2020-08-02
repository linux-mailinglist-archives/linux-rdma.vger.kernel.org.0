Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E0A2355A8
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Aug 2020 08:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgHBGVy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 2 Aug 2020 02:21:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:64439 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbgHBGVx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 2 Aug 2020 02:21:53 -0400
IronPort-SDR: LJE/e/wL65hocddSA71ep7XVdDrLCMCWQu5qGzmMrb6Q2Yuz/973BCGeoNPvfrlTSHLc0jHvZO
 UXUlVwGVLVAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9700"; a="139548189"
X-IronPort-AV: E=Sophos;i="5.75,425,1589266800"; 
   d="scan'208";a="139548189"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2020 23:21:51 -0700
IronPort-SDR: byIbXOYhtDPRnvb2yG/4gOexyyq8boQWppWuF41HNy5hstZb+QAm0RVSh5JBGFj83BxugOBvEM
 KjVDxID5CljA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,425,1589266800"; 
   d="scan'208";a="491982627"
Received: from lkp-server01.sh.intel.com (HELO e21119890065) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 01 Aug 2020 23:21:50 -0700
Received: from kbuild by e21119890065 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k27NV-0001XH-KV; Sun, 02 Aug 2020 06:21:49 +0000
Date:   Sun, 02 Aug 2020 14:21:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 76251e15ea73898b62ed0da3210189e50e1fe3c9
Message-ID: <5f265b59.qxkJ0YoiaN99EOU9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  for-next
branch HEAD: 76251e15ea73898b62ed0da3210189e50e1fe3c9  RDMA/rxe: Remove pkey table

elapsed time: 791m

configs tested: 91
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7750_defconfig
arm                       omap2plus_defconfig
mips                           ip27_defconfig
arc                              alldefconfig
arc                        nsimosci_defconfig
parisc                generic-64bit_defconfig
arm                          pcm027_defconfig
arm                      pxa255-idp_defconfig
sparc                       sparc32_defconfig
ia64                             allyesconfig
powerpc                     powernv_defconfig
arm                        keystone_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     ep8248e_defconfig
sh                        sh7785lcr_defconfig
openrisc                    or1ksim_defconfig
arm                         cm_x300_defconfig
sh                             espt_defconfig
mips                           ip32_defconfig
mips                      loongson3_defconfig
sh                           se7751_defconfig
sh                        sh7763rdp_defconfig
xtensa                       common_defconfig
sh                     sh7710voipgw_defconfig
m68k                          multi_defconfig
arm                      jornada720_defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20200802
x86_64               randconfig-a001-20200802
x86_64               randconfig-a004-20200802
x86_64               randconfig-a003-20200802
x86_64               randconfig-a002-20200802
x86_64               randconfig-a005-20200802
i386                 randconfig-a004-20200802
i386                 randconfig-a005-20200802
i386                 randconfig-a001-20200802
i386                 randconfig-a002-20200802
i386                 randconfig-a003-20200802
i386                 randconfig-a006-20200802
i386                 randconfig-a011-20200802
i386                 randconfig-a012-20200802
i386                 randconfig-a015-20200802
i386                 randconfig-a014-20200802
i386                 randconfig-a013-20200802
i386                 randconfig-a016-20200802
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
