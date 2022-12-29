Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18CB6588A2
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Dec 2022 03:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiL2C2J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Dec 2022 21:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiL2C1n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Dec 2022 21:27:43 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E235B12084
        for <linux-rdma@vger.kernel.org>; Wed, 28 Dec 2022 18:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672280862; x=1703816862;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=fpXyqdJc87OR1hDkAhtWos62l/yFcmROgGq+iqbQi2k=;
  b=c8uH8rKUj5jIbsTCsouewMPWgkC56Oj7TJcyt1CkizBUlDdVHHPjAFwb
   X2tJ1IsOyQk7UYCCDyMlt/N8MjXe1nCJSUiGLzNzjWvF9O6bdlCU8k3tJ
   c2nCkzQcJbXMmDzvjvMrGlYLE9qv4Xbthxc5rbz65XBCOzWLS7ev38/L8
   Ar+4fa8fclIxC8eI3dEHWgFvmqvBXsEymXdaNQkVjqVJ0Fm/Oop2BwcQL
   OddADzoKMR6VF7Bs9q8/3pyVpcojh+TmXGcZpFyig/EgQTm3l8KZMZ4L1
   fBc6jDoOPTruajHNfWAwAhkhy9DGzcDsu/DnnDXYafxHhafeA4O3oK/rW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="318647953"
X-IronPort-AV: E=Sophos;i="5.96,282,1665471600"; 
   d="scan'208";a="318647953"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 18:27:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="603510215"
X-IronPort-AV: E=Sophos;i="5.96,282,1665471600"; 
   d="scan'208";a="603510215"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Dec 2022 18:27:40 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pAidv-000GC3-2f;
        Thu, 29 Dec 2022 02:27:39 +0000
Date:   Thu, 29 Dec 2022 10:27:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 cf6a05c8494a8ae7fec8e5f1229b45ca5b4bcd30
Message-ID: <63acfb03.UaHBAiC0MlElQ+f0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: cf6a05c8494a8ae7fec8e5f1229b45ca5b4bcd30  RDMA/hns: Fix refcount leak in hns_roce_mmap

elapsed time: 795m

configs tested: 74
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
ia64                             allmodconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
s390                                defconfig
s390                             allmodconfig
x86_64                              defconfig
i386                                defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64               randconfig-a014-20221226
x86_64               randconfig-a013-20221226
x86_64               randconfig-a011-20221226
x86_64               randconfig-a012-20221226
x86_64               randconfig-a016-20221226
x86_64               randconfig-a015-20221226
arm64                            allyesconfig
arm                                 defconfig
s390                             allyesconfig
i386                 randconfig-a012-20221226
i386                 randconfig-a011-20221226
i386                 randconfig-a013-20221226
i386                 randconfig-a014-20221226
i386                 randconfig-a016-20221226
i386                 randconfig-a015-20221226
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
sh                               allmodconfig
arm                              allyesconfig
arm                  randconfig-r046-20221225
arc                  randconfig-r043-20221225
arc                  randconfig-r043-20221227
arm                  randconfig-r046-20221227
arc                              allyesconfig
powerpc                          allmodconfig
arc                  randconfig-r043-20221226
riscv                randconfig-r042-20221226
mips                             allyesconfig
alpha                            allyesconfig
s390                 randconfig-r044-20221226
m68k                             allyesconfig
i386                             allyesconfig
m68k                             allmodconfig
x86_64                            allnoconfig

clang tested configs:
i386                 randconfig-a004-20221226
i386                 randconfig-a001-20221226
i386                 randconfig-a003-20221226
i386                 randconfig-a002-20221226
x86_64               randconfig-a002-20221226
x86_64               randconfig-a003-20221226
i386                 randconfig-a005-20221226
x86_64               randconfig-a001-20221226
x86_64                          rhel-8.3-rust
x86_64               randconfig-a004-20221226
i386                 randconfig-a006-20221226
x86_64               randconfig-a005-20221226
x86_64               randconfig-a006-20221226
hexagon              randconfig-r045-20221225
riscv                randconfig-r042-20221227
hexagon              randconfig-r041-20221225
hexagon              randconfig-r041-20221227
hexagon              randconfig-r041-20221226
arm                  randconfig-r046-20221226
s390                 randconfig-r044-20221225
hexagon              randconfig-r045-20221226
riscv                randconfig-r042-20221225
hexagon              randconfig-r045-20221227
s390                 randconfig-r044-20221227

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
