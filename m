Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839846653A5
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jan 2023 06:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjAKFZE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Jan 2023 00:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjAKFYP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Jan 2023 00:24:15 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC24FCCA
        for <linux-rdma@vger.kernel.org>; Tue, 10 Jan 2023 21:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673414272; x=1704950272;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6N3B8IGRP3Ua3OrzU73GRcCRBNdWUgE3dLoSZL0q88Y=;
  b=FOhYxmABOSvEXBiu80WGkjoQEaVGXp98yVEdt1Yy9ncGpvgdY7HSVIlP
   Fx4Gi3lrGEDni+vNGeHzn+ohs6FOrgbifnRihr+tDv5GDdxFS2sBy+jQz
   a/cRqK9v7dQfmoUaDtF7t2qQwRhDxxS+fbzStpZaw7XV7HVKQchOjFCZE
   8ABtTn8RmomhbngEgboL+62ylP8MLIWXbNEKZmTOyqNlOp/gWiAMx6y6r
   pQseCn1cHiN+uW5fI7p1PJacDv5N7GPyqyVedIEazm24XZXPZSCGV7oot
   p1QjhRqwUkaYYpQzoFukw84BiDjFerdpoMGJJGvFNYMAbTTm15I5VVrdN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="322032670"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="322032670"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 21:17:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607232565"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="607232565"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 10 Jan 2023 21:17:50 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pFTUj-0008nK-25;
        Wed, 11 Jan 2023 05:17:49 +0000
Date:   Wed, 11 Jan 2023 13:17:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 1ec82317a1daac78c04b0c15af89018ccf9fa2b7
Message-ID: <63be4670.UohTAbkDzNvqdOht%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 1ec82317a1daac78c04b0c15af89018ccf9fa2b7  IB/hfi1: Use dma_mmap_coherent for matching buffers

elapsed time: 724m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
sh                               allmodconfig
x86_64                            allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
ia64                             allmodconfig
x86_64                              defconfig
arc                  randconfig-r043-20230110
x86_64                               rhel-8.3
riscv                randconfig-r042-20230110
s390                 randconfig-r044-20230110
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
m68k                             allyesconfig
x86_64                           allyesconfig
i386                                defconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a006
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
hexagon              randconfig-r041-20230110
arm                  randconfig-r046-20230110
hexagon              randconfig-r045-20230110
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
