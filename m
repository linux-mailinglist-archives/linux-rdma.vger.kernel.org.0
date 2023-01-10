Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33856637FE
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jan 2023 05:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjAJEFA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 23:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjAJEEh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 23:04:37 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C4434754
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 20:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673323476; x=1704859476;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=QqIwwliUQsuRLEW2uaRVBcl1vqBgfr8oi2tzwETGZnA=;
  b=T1nQpN17pBEjq7j+pohdk3vphuH2XfomS7nZJKcoRiCYtIHOBd3+KP1F
   F9lfjCKlIMIdMYM6IUoGCb9vECsaWD/pvOU+wVpPTD7wmXRIPewmOkNph
   Y3rN7r2ToZHyJHCWyp1397Yud1tH9JSRLSgpOhv5fiXM3K1iFaTmDnR+K
   ZbM9KmFZUxtRuFicSDNExm82jTB4qZQ1x/3FnaxpKq3c+y1HyTplsuk1v
   sE70RVyA77t0I2iEzyU+uixHrmjiY4wAc/7tnvwY5wPTXIoYk/SZy6wts
   P9H4CNRhivnKB84C5aa+gzPQ1vOvQEyu8KKpZOOj8vRq8zATxecXJC9WK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="321753184"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="321753184"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 20:04:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="902235898"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="902235898"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jan 2023 20:04:34 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pF5sI-0007X2-0Q;
        Tue, 10 Jan 2023 04:04:34 +0000
Date:   Tue, 10 Jan 2023 12:03:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 1aefe5c177c1922119afb4ee443ddd6ac3140b37
Message-ID: <63bce3ae.JozRd6wei+3wm+HQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: 1aefe5c177c1922119afb4ee443ddd6ac3140b37  RDMA/rxe: Prevent faulty rkey generation

elapsed time: 730m

configs tested: 89
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
powerpc                           allnoconfig
s390                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                         rhel-8.3-kunit
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                              defconfig
arc                              allyesconfig
ia64                             allmodconfig
alpha                            allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
arm                  randconfig-r046-20230108
arc                  randconfig-r043-20230108
arc                  randconfig-r043-20230109
riscv                randconfig-r042-20230109
s390                 randconfig-r044-20230109
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a015-20230109
i386                 randconfig-a011-20230109
i386                 randconfig-a013-20230109
i386                 randconfig-a014-20230109
i386                 randconfig-a016-20230109
i386                 randconfig-a012-20230109
i386                             allyesconfig
i386                                defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64               randconfig-a014-20230109
x86_64               randconfig-a016-20230109
x86_64               randconfig-a012-20230109
x86_64               randconfig-a011-20230109
x86_64               randconfig-a013-20230109
x86_64               randconfig-a015-20230109
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          randconfig-c001
ia64                             alldefconfig
sh                             shx3_defconfig
arc                         haps_hs_defconfig
mips                      maltasmvp_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
hexagon              randconfig-r045-20230109
arm                  randconfig-r046-20230109
hexagon              randconfig-r041-20230108
hexagon              randconfig-r041-20230109
hexagon              randconfig-r045-20230108
riscv                randconfig-r042-20230108
s390                 randconfig-r044-20230108
x86_64                        randconfig-k001
i386                 randconfig-a005-20230109
i386                 randconfig-a006-20230109
i386                 randconfig-a001-20230109
i386                 randconfig-a002-20230109
i386                 randconfig-a003-20230109
i386                 randconfig-a004-20230109
powerpc               mpc834x_itxgp_defconfig
x86_64               randconfig-a001-20230109
x86_64               randconfig-a002-20230109
x86_64               randconfig-a004-20230109
x86_64               randconfig-a003-20230109
x86_64               randconfig-a006-20230109
x86_64               randconfig-a005-20230109
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
