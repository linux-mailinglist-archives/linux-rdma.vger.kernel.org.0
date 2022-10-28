Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB856106BE
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 02:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJ1AUP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 20:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbiJ1AUO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 20:20:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C7145053
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 17:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666916414; x=1698452414;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/R3G/9gz6oVwICMIGt08yLNMcwpA76N+/7YquVbYX6A=;
  b=CN81r4d6K5mpySkNUYldbWjj2/RuJzaJmUpNWEYyba7vgQa+Zi6SPZNs
   +omJjCLEP+3RHwXP/ryOho//g+kugdWdPiStYcwr7SxFGXzfZb50pj25e
   EwKkA3k7vujnPSt17RDKkn5ft4iqf42I3cJyQ/jFlP2E4mwhnLek5C1DA
   EmKJy841yTa18LSeEgV3HrzG3RfdJgiTEgcCtv7vqgyBAE8qL2gSOdkq3
   x/XHVXLBrvRk8Kq2WClClt1SFtZWaIehBjSAQFKOOmVe/0lT42ngbDPq2
   r8Kxn5KdrEO5GGop1oHisxdB/9mzOLxxjz2/SrHexgcqBzM83BkpzYplI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="308364272"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="308364272"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 17:20:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="665880672"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="665880672"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 27 Oct 2022 17:19:55 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ooD6I-0009Hz-1X;
        Fri, 28 Oct 2022 00:19:54 +0000
Date:   Fri, 28 Oct 2022 08:19:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 569ab362c3073a14cad5ba5b20c76d86ff14fa03
Message-ID: <635b2003.RjHLi6Uzw2KFxMDV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: 569ab362c3073a14cad5ba5b20c76d86ff14fa03  RDMA/qedr: clean up work queue on failure in qedr_alloc_resources()

elapsed time: 723m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
riscv                randconfig-r042-20221026
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                         rhel-8.3-kunit
powerpc                           allnoconfig
arm                                 defconfig
x86_64                        randconfig-a002
arc                  randconfig-r043-20221026
i386                          randconfig-a012
s390                 randconfig-r044-20221026
sh                               allmodconfig
i386                          randconfig-a014
x86_64                        randconfig-a004
i386                          randconfig-a016
x86_64                        randconfig-a006
arm64                            allyesconfig
i386                             allyesconfig
ia64                             allmodconfig
arm                              allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011

clang tested configs:
hexagon              randconfig-r045-20221026
hexagon              randconfig-r041-20221026
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
