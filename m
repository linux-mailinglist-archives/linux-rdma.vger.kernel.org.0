Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014EA233871
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jul 2020 20:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgG3ShA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jul 2020 14:37:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:7567 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgG3ShA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Jul 2020 14:37:00 -0400
IronPort-SDR: OHFHGhw96uDcEE3H4FL42n+o8ut/OGa+boAt8RMPwvQYH+6xeAVlL+Nk4ZFWCmjB3RPU5Ds68p
 JSofGpAR8Pag==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="213205282"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="213205282"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 11:36:59 -0700
IronPort-SDR: Tsd/Gj2kS0F7lFqw1vc4545ti5rf4k83HZi+n5McBjvUK8mzfNpdbc6jlp0YdObFUV5a0M8lgc
 ZY/5LxNbG3AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="491223442"
Received: from lkp-server02.sh.intel.com (HELO d4d86dd808e0) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jul 2020 11:36:57 -0700
Received: from kbuild by d4d86dd808e0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k1DQG-0000BN-Hs; Thu, 30 Jul 2020 18:36:56 +0000
Date:   Fri, 31 Jul 2020 02:36:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 54a485e9ec084da1a4b32dcf7749c7d760ed8aa5
Message-ID: <5f231332.U2Mpduj3wqD8Sa/g%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-rc
branch HEAD: 54a485e9ec084da1a4b32dcf7749c7d760ed8aa5  IB/rdmavt: Fix RQ counting issues causing use of an invalid RWQE

elapsed time: 1215m

configs tested: 72
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
c6x                              allyesconfig
arc                              allyesconfig
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
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                             defconfig
x86_64               randconfig-a001-20200730
x86_64               randconfig-a004-20200730
x86_64               randconfig-a002-20200730
x86_64               randconfig-a006-20200730
x86_64               randconfig-a003-20200730
x86_64               randconfig-a005-20200730
i386                 randconfig-a005-20200730
i386                 randconfig-a004-20200730
i386                 randconfig-a006-20200730
i386                 randconfig-a002-20200730
i386                 randconfig-a001-20200730
i386                 randconfig-a003-20200730
i386                 randconfig-a016-20200730
i386                 randconfig-a012-20200730
i386                 randconfig-a014-20200730
i386                 randconfig-a015-20200730
i386                 randconfig-a011-20200730
i386                 randconfig-a013-20200730
i386                 randconfig-a016-20200729
i386                 randconfig-a012-20200729
i386                 randconfig-a013-20200729
i386                 randconfig-a014-20200729
i386                 randconfig-a011-20200729
i386                 randconfig-a015-20200729
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
