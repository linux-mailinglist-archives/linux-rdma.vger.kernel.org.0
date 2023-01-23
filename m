Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D568B6774BA
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jan 2023 06:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjAWFFC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Jan 2023 00:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAWFFB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Jan 2023 00:05:01 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B5316AC6
        for <linux-rdma@vger.kernel.org>; Sun, 22 Jan 2023 21:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674450300; x=1705986300;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/tCwyOHDFUBxLL/eITNTJD4FgMIkTnZ6qsUnDco84Iw=;
  b=ilcUjmjBC9BJeWP5wvTJOYLFWpSSI4xIed7x8CuhmvjijzE2RbWflUSr
   7z+7p+HRS8BmIYZmUCrKm6aa5bgVZDFpCsWgE5qso/RuyFfLEgqENXgOm
   WiwT/tDMicyQL6c9ZxbjVkLxzAaXN79KxXDh0w+NIfpPzu+G2AnGgOWmC
   BO/n86fOFJsBD9oEMCRzeYC86LoVoBp1FXLzKSlPjSTJvvKXtHX1UFjPx
   Pr9ADQzAoS4TC96d/ogztCDZoPCmfCiNRZNUS69RkXcIT/ERcQnMT+U8t
   AD7Ny5XoreU6lKr6EmEQUiO7LVxgiNQD1HLaTgup9nfbeDo5Oo4P9guLM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="309547800"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="309547800"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2023 21:04:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="693719947"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="693719947"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Jan 2023 21:04:57 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJp0q-0005R2-36;
        Mon, 23 Jan 2023 05:04:56 +0000
Date:   Mon, 23 Jan 2023 13:04:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 6601fc0d15ffc20654e39486f9bef35567106d68
Message-ID: <63ce1551.6n7bazXSCGxTB8Zh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: 6601fc0d15ffc20654e39486f9bef35567106d68  IB/hfi1: Restore allocated resources on failed copyout

elapsed time: 722m

configs tested: 80
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
powerpc                           allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
i386                          randconfig-a001
i386                                defconfig
x86_64                              defconfig
i386                          randconfig-a003
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
x86_64                          rhel-8.3-func
x86_64               randconfig-a002-20230123
ia64                             allmodconfig
s390                             allyesconfig
x86_64               randconfig-a001-20230123
sh                               allmodconfig
i386                          randconfig-a005
x86_64               randconfig-a006-20230123
x86_64                               rhel-8.3
x86_64               randconfig-a004-20230123
x86_64               randconfig-a003-20230123
x86_64                           rhel-8.3-syz
m68k                             allyesconfig
x86_64               randconfig-a005-20230123
i386                             allyesconfig
riscv                randconfig-r042-20230122
mips                             allyesconfig
powerpc                          allmodconfig
arm64                            allyesconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
arc                  randconfig-r043-20230122
m68k                             allmodconfig
x86_64                           rhel-8.3-kvm
arm                              allyesconfig
s390                 randconfig-r044-20230122
x86_64                           rhel-8.3-bpf
arc                              allyesconfig
alpha                            allyesconfig
arc                  randconfig-r043-20230123
arm                  randconfig-r046-20230123
sparc                               defconfig
powerpc                         ps3_defconfig
arm                           tegra_defconfig
powerpc                        cell_defconfig

clang tested configs:
i386                          randconfig-a002
x86_64                          rhel-8.3-rust
i386                 randconfig-a012-20230123
i386                 randconfig-a013-20230123
i386                 randconfig-a011-20230123
i386                 randconfig-a014-20230123
i386                 randconfig-a016-20230123
hexagon              randconfig-r045-20230122
i386                 randconfig-a015-20230123
arm                  randconfig-r046-20230122
hexagon              randconfig-r041-20230122
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
x86_64               randconfig-a012-20230123
x86_64               randconfig-a014-20230123
x86_64               randconfig-a016-20230123
x86_64               randconfig-a015-20230123
hexagon              randconfig-r041-20230123
hexagon              randconfig-r045-20230123
s390                 randconfig-r044-20230123
riscv                randconfig-r042-20230123
arm                         s5pv210_defconfig
arm                         mv78xx0_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                    gamecube_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
