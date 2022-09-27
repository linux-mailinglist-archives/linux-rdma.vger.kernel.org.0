Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4ABF5EBB75
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Sep 2022 09:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiI0H2c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Sep 2022 03:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiI0H2b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Sep 2022 03:28:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012705AA23
        for <linux-rdma@vger.kernel.org>; Tue, 27 Sep 2022 00:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664263710; x=1695799710;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=o/qKaKXfO25DRKIiRQXSk8+4NM2zHoQahJ3AmInZ3KM=;
  b=G2nPQAU8McdAuEoEX6jDpUFfbHEQZ8+1fm944Zi+REgq8FfSECwp12c7
   /HnT/AwuJR1JzNIbM/41MCPTJsA1vpq23INMtwLlIqE0v8RJhP5LBDyt8
   dn93i2gUVM1+11iB7RF66viuGYOkz0U2ScIBqV/zRkz7JmfPH8brTNHyO
   0SJRtL74VoeZ7sXm7w6q215vtnISemlOFJpg8fpg8kHD3+dau/+AqnkWs
   FF0CjOEQMB6tKu9gzkmfS116v195yEVPHYvw6dUlDh82GLJ3w4a9auTRI
   COx3o7E+Hu0gMg/UVD31HzvForCY5VlF5C78GjxLxUWoYmruXDGq6kUal
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="280966977"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="280966977"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 00:28:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="950188641"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="950188641"
Received: from lkp-server02.sh.intel.com (HELO dfa2c9fcd321) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 27 Sep 2022 00:28:29 -0700
Received: from kbuild by dfa2c9fcd321 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1od512-0000lj-1O;
        Tue, 27 Sep 2022 07:28:28 +0000
Date:   Tue, 27 Sep 2022 15:27:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 02d326039547ecfc5376b21b3e9cb336bab7f512
Message-ID: <6332a5fe.+FKTCIlX0Ex+dahh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 02d326039547ecfc5376b21b3e9cb336bab7f512  RDMA/hns: Unified Log Printing Style

elapsed time: 725m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                              defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                                defconfig
x86_64                               rhel-8.3
arm                                 defconfig
i386                 randconfig-a001-20220926
i386                 randconfig-a004-20220926
i386                 randconfig-a005-20220926
i386                 randconfig-a002-20220926
i386                 randconfig-a003-20220926
i386                 randconfig-a006-20220926
x86_64                           allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
arc                  randconfig-r043-20220926
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
i386                             allyesconfig
sh                               allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                        randconfig-a004
x86_64                        randconfig-a002
ia64                             allmodconfig
x86_64                        randconfig-a006

clang tested configs:
i386                 randconfig-a011-20220926
i386                 randconfig-a014-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a012-20220926
i386                 randconfig-a015-20220926
i386                 randconfig-a016-20220926
hexagon              randconfig-r045-20220926
riscv                randconfig-r042-20220926
hexagon              randconfig-r041-20220926
s390                 randconfig-r044-20220926
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
