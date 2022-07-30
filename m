Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A34E5858E4
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Jul 2022 08:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiG3Gp5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 30 Jul 2022 02:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiG3Gp4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 30 Jul 2022 02:45:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D4A60D1
        for <linux-rdma@vger.kernel.org>; Fri, 29 Jul 2022 23:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659163555; x=1690699555;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rtwTGz62knQ6YOwk7kQszdhLN0sjnKQIZnptv2Or7qc=;
  b=gLMGGWQoyLt4v/9KUf5ieBgoAGx/UD0ZOw2NENSDblAwZOhAU8wxWqwW
   kF/i8YdWntMk/LG5x8m3do9IqBLtZIbcskWgWfNbjVpHHnqMx1jWWgEim
   CGSLdgzWWp4V6Gs6+/E+RT8OjsXl+qakSkgDbNiqfI+FzXnqP1yhUO9Ri
   aUH1AND9g99eHt7d9bOlCjb5PhX1PtQerNNNCb6/WLQUTVj7YBdQr4EJL
   QWiishfi8t85ofzilt22HDUHQ8c3y61/0+/FE9H0agOl6FbsCDDISl2ho
   e24mhr20HbUtdM5//gn31kn0k37NaFPGqrsYWZTUHQjE54TpLkMEL5OEn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="288910702"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="288910702"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 23:45:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="577197378"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Jul 2022 23:45:54 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHgET-000CXz-1R;
        Sat, 30 Jul 2022 06:45:53 +0000
Date:   Sat, 30 Jul 2022 14:45:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 dd390cba54bbd74fb675a4ac0a78dc23a20d49e2
Message-ID: <62e4d377.nhEU6fIL2P69Qyb9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: dd390cba54bbd74fb675a4ac0a78dc23a20d49e2  IB/qib: Fix repeated "in" within comments

elapsed time: 792m

configs tested: 76
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
i386                                defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                             allyesconfig
x86_64                              defconfig
i386                          randconfig-a012
x86_64                           rhel-8.3-kvm
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
ia64                             allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
um                           x86_64_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                      bamboo_defconfig
m68k                          hp300_defconfig
sh                              ul2_defconfig
nios2                               defconfig
sh                         ecovec24_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm                         lpc18xx_defconfig
powerpc                 mpc8540_ads_defconfig
xtensa                    xip_kc705_defconfig
i386                          randconfig-c001
powerpc                      pcm030_defconfig
m68k                                defconfig
mips                         tb0226_defconfig
sh                     sh7710voipgw_defconfig
loongarch                           defconfig
loongarch                         allnoconfig

clang tested configs:
hexagon              randconfig-r041-20220729
riscv                randconfig-r042-20220729
hexagon              randconfig-r045-20220729
s390                 randconfig-r044-20220729
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-k001
mips                     loongson1c_defconfig
arm                         palmz72_defconfig
x86_64                        randconfig-a014
arm                       imx_v4_v5_defconfig
powerpc                      katmai_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
