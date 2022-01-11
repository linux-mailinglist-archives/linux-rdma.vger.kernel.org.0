Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE5148A763
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jan 2022 06:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiAKFd2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jan 2022 00:33:28 -0500
Received: from mga04.intel.com ([192.55.52.120]:49102 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230252AbiAKFd2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jan 2022 00:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641879208; x=1673415208;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jfjNhPkMryXbh/Xu0nuCRkUp5rEu2GNHzB4VkYqjPtM=;
  b=oHxcrqN1gC092S3SryLZaQwNX3Ce0KWw3P3tn76gEp14BhPxgdr8spWx
   uCmzAqGxQwHvV997vvBrHk0TYE1b+yWUTeQ70ROlxNViYo2LXfi19VcAl
   pejh/tOz7hRvG1qe8SVv01rFF9NFsUmtYuUs5sEsL1rkKR/8q3PAykzSz
   66QNFw+aOWi8hrcVXi7hpXWtNqzrW/T/2FbNwHT2gFuDScRiQ5NoCascf
   b/bUIRv2Yq9B+7N/3Yzn1yTJPEWbrHRTBYJi2NClicTKdUE4CgvyrDUM5
   VSAL0RuaxUlxByvoYxn+d1JgMHKnhveJxDZchEaVmHE33k8Oe+stwGXRJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="242219141"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="242219141"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 21:33:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="669698392"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jan 2022 21:33:27 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n79mg-0004Pq-Bn; Tue, 11 Jan 2022 05:33:26 +0000
Date:   Tue, 11 Jan 2022 13:33:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/for-testing] BUILD SUCCESS
 4ca56d7ae3e73fede0785f9a14ecbb9e078b40f0
Message-ID: <61dd1696.xx1A25vw7ew8XAtn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/for-testing
branch HEAD: 4ca56d7ae3e73fede0785f9a14ecbb9e078b40f0  Merge tag 'v5.16' into rdma.git for-next

elapsed time: 734m

configs tested: 54
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
