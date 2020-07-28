Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3248B23098C
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jul 2020 14:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgG1MFQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jul 2020 08:05:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:31418 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728560AbgG1MFQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Jul 2020 08:05:16 -0400
IronPort-SDR: aRM3pNhQNmc5Ekup8Jopo2Flp8PDctmhjJvncSJxKLlq1OU4tQj6lsCHvfRUSlaV/mftf9Ctib
 D9AJuuIfXg7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="148659176"
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="148659176"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 05:05:15 -0700
IronPort-SDR: IGS3wP9HiE9uj2acdtk3NK/r865wvC6HNdJ5tC21OU2uxy2IQlZjsAN0RfGBnYGZthwTQ6spUh
 UpZu9yxKnb3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="364473147"
Received: from lkp-server01.sh.intel.com (HELO d27eb53fc52b) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 28 Jul 2020 05:05:13 -0700
Received: from kbuild by d27eb53fc52b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k0OM4-0000s6-Uo; Tue, 28 Jul 2020 12:05:12 +0000
Date:   Tue, 28 Jul 2020 20:04:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 47fda651d5af2506deac57d54887cf55ce26e244
Message-ID: <5f201457.pz3aYelZFPxHvRYI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 47fda651d5af2506deac57d54887cf55ce26e244  RDMA/core: Fix return error value in _ib_modify_qp() to negative

elapsed time: 1090m

configs tested: 66
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          r7785rp_defconfig
mips                         tb0226_defconfig
mips                      loongson3_defconfig
um                            kunit_defconfig
nds32                            alldefconfig
arm                       imx_v4_v5_defconfig
mips                           gcw0_defconfig
mips                      fuloong2e_defconfig
arm                      pxa255-idp_defconfig
s390                                defconfig
arm                          prima2_defconfig
arm                      footbridge_defconfig
mips                        nlm_xlr_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
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
x86_64               randconfig-a014-20200728
x86_64               randconfig-a012-20200728
x86_64               randconfig-a015-20200728
x86_64               randconfig-a016-20200728
x86_64               randconfig-a013-20200728
x86_64               randconfig-a011-20200728
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
