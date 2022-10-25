Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF04860D385
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Oct 2022 20:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiJYS0Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Oct 2022 14:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiJYS0X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Oct 2022 14:26:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E420EF5B4
        for <linux-rdma@vger.kernel.org>; Tue, 25 Oct 2022 11:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666722382; x=1698258382;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=UmyuBbkDo23ku1fzDFV50FYxFb7ytd2CpIbo2dIoJhU=;
  b=fkxGfgky5JEBLjjfTzSUxOdjKZwzFMnPrEzWNh5Gq1wtCMe/W0xBPMUf
   R0SYwJLhkN6dWjjMsKdKXvILZ+1SE710bv6Ek62mMVlToyWjXeewQtOtN
   0btX2mxX1wvNtyY8nccrWcmifsxHIkY9VOVJNa52ehah9vRvo80Z/9iid
   4qTd6nXWN5zXMIjnsvcQu9LT5mV05tf2OmmCwlhZnBRfzKRylFr19oB7G
   B+DK2z4G1BESHT5gmeZZ2eLkPsSH+9+4IJdG4y/HBFNPUnRYlUdl02FW9
   rkj/SU8Z00EEuPYvKKgYxJrkdMcIG8tCyFJ2Tpy5rzkovbrlpbYrROYWo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="287477164"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="287477164"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 11:26:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="700642242"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="700642242"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 25 Oct 2022 11:26:20 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1onOd2-0006WC-0L;
        Tue, 25 Oct 2022 18:26:20 +0000
Date:   Wed, 26 Oct 2022 02:25:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 cca19da0d9985814a3b170d936945c37bb1ece79
Message-ID: <63582a1d.Uq6Hp8NJc3dmx937%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: cca19da0d9985814a3b170d936945c37bb1ece79  RDMA/rxe: Remove unnecessary mr testing

elapsed time: 723m

configs tested: 95
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
powerpc                           allnoconfig
arc                                 defconfig
alpha                               defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
sh                               allmodconfig
i386                 randconfig-a011-20221024
x86_64                          rhel-8.3-func
i386                 randconfig-a014-20221024
mips                             allyesconfig
x86_64                    rhel-8.3-kselftests
i386                                defconfig
s390                             allmodconfig
x86_64               randconfig-a014-20221024
powerpc                          allmodconfig
x86_64               randconfig-a013-20221024
s390                                defconfig
i386                 randconfig-a013-20221024
arm                                 defconfig
i386                 randconfig-a012-20221024
x86_64                           rhel-8.3-syz
i386                 randconfig-a016-20221024
x86_64               randconfig-a012-20221024
i386                 randconfig-a015-20221024
x86_64               randconfig-a016-20221024
x86_64               randconfig-a011-20221024
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a015-20221024
x86_64                           rhel-8.3-kvm
s390                             allyesconfig
arm64                            allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
arm                              allyesconfig
m68k                             allyesconfig
ia64                             allmodconfig
i386                             allyesconfig
powerpc                       eiger_defconfig
powerpc                      chrp32_defconfig
csky                             alldefconfig
sh                            migor_defconfig
sh                      rts7751r2d1_defconfig
m68k                           sun3_defconfig
sh                        dreamcast_defconfig
sh                          urquell_defconfig
arm                        mini2440_defconfig
sh                          lboxre2_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64               randconfig-k001-20221024
powerpc                     sequoia_defconfig
arm                       multi_v4t_defconfig
powerpc                 mpc837x_rdb_defconfig
loongarch                         allnoconfig
parisc64                         alldefconfig
sh                             sh03_defconfig
arm                          pxa3xx_defconfig
powerpc                       ppc64_defconfig
powerpc                 mpc834x_itx_defconfig
arc                  randconfig-r043-20221023
arc                  randconfig-r043-20221024
s390                 randconfig-r044-20221024
riscv                randconfig-r042-20221024
arc                  randconfig-r043-20221025
arm                            hisi_defconfig
arm                          exynos_defconfig
i386                          randconfig-c001
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
s390                 randconfig-r044-20221025
i386                 randconfig-a001-20221024
i386                 randconfig-a002-20221024
x86_64               randconfig-a001-20221024
i386                 randconfig-a005-20221024
i386                 randconfig-a003-20221024
x86_64               randconfig-a003-20221024
x86_64               randconfig-a006-20221024
i386                 randconfig-a004-20221024
i386                 randconfig-a006-20221024
x86_64               randconfig-a004-20221024
x86_64               randconfig-a002-20221024
x86_64               randconfig-a005-20221024
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
