Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7794A251658
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 12:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgHYKNY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 06:13:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:52307 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729723AbgHYKNV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Aug 2020 06:13:21 -0400
IronPort-SDR: 3I8Giezgj9Bs/GwFZ5abHBprt5hUcqAt334NgSuAW4wrKHRmZfRFAT1Aw/NMb30uHz9F21upsM
 NrdExdn2h8Fw==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="136142005"
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="136142005"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 03:13:20 -0700
IronPort-SDR: Ai5cJmoF9EQUm29G8mEJpBYlRWZWyW6e7aQ2S/msAY4A/xlBnzjrFEpIx6oHphY81WPu0KsMR1
 E/k/Z9ctvMyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="294947742"
Received: from lkp-server01.sh.intel.com (HELO 4f455964fc6c) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Aug 2020 03:13:19 -0700
Received: from kbuild by 4f455964fc6c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kAVx8-0000J8-AX; Tue, 25 Aug 2020 10:13:18 +0000
Date:   Tue, 25 Aug 2020 18:12:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 8d9290a4a8aa5d46073d558692d66a7190b81b90
Message-ID: <5f44e426.xdJeCL9AMWXqQwS6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 8d9290a4a8aa5d46073d558692d66a7190b81b90  RDMA/efa: Remove redundant udata check from alloc ucontext response

elapsed time: 886m

configs tested: 105
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
xtensa                generic_kc705_defconfig
powerpc                      ppc64e_defconfig
arm                            xcep_defconfig
mips                      pistachio_defconfig
mips                        vocore2_defconfig
arm                        clps711x_defconfig
powerpc                      ep88xc_defconfig
mips                     loongson1c_defconfig
parisc                generic-32bit_defconfig
arm                            zeus_defconfig
arm                              zx_defconfig
arc                              alldefconfig
arm                          badge4_defconfig
sh                          sdk7780_defconfig
sh                          r7785rp_defconfig
arm                             rpc_defconfig
h8300                    h8300h-sim_defconfig
powerpc64                        alldefconfig
arm                            mps2_defconfig
sh                           se7721_defconfig
arm                         nhk8815_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
x86_64               randconfig-a003-20200825
x86_64               randconfig-a002-20200825
x86_64               randconfig-a001-20200825
x86_64               randconfig-a005-20200825
x86_64               randconfig-a006-20200825
x86_64               randconfig-a004-20200825
i386                 randconfig-a002-20200824
i386                 randconfig-a004-20200824
i386                 randconfig-a005-20200824
i386                 randconfig-a003-20200824
i386                 randconfig-a006-20200824
i386                 randconfig-a001-20200824
i386                 randconfig-a002-20200825
i386                 randconfig-a004-20200825
i386                 randconfig-a005-20200825
i386                 randconfig-a003-20200825
i386                 randconfig-a006-20200825
i386                 randconfig-a001-20200825
x86_64               randconfig-a015-20200824
x86_64               randconfig-a016-20200824
x86_64               randconfig-a012-20200824
x86_64               randconfig-a014-20200824
x86_64               randconfig-a011-20200824
x86_64               randconfig-a013-20200824
i386                 randconfig-a013-20200824
i386                 randconfig-a012-20200824
i386                 randconfig-a011-20200824
i386                 randconfig-a016-20200824
i386                 randconfig-a015-20200824
i386                 randconfig-a014-20200824
i386                 randconfig-a013-20200825
i386                 randconfig-a012-20200825
i386                 randconfig-a011-20200825
i386                 randconfig-a016-20200825
i386                 randconfig-a015-20200825
i386                 randconfig-a014-20200825
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
