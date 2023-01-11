Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FAA665130
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jan 2023 02:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjAKBpk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Jan 2023 20:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjAKBpj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Jan 2023 20:45:39 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA2C1903F
        for <linux-rdma@vger.kernel.org>; Tue, 10 Jan 2023 17:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673401538; x=1704937538;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=UdbKSu79ObUSLR1msoUsL1Ma9C616j7X/T4OjbZrgwE=;
  b=ab9fQEwjov9C61SW3aiK6c9LTfWWjDKWt2ezBfhBFcYJtIueihYfBbQ0
   gl/F/+oQSDAenAj8wGiXaJDrayHk8VlgzXGwAG/EhV0Z/9iXsNrZ/UnFZ
   UpIAgKmm87c50bCC4Kd5up6bNS+l7hax60OiF5FV6pRHAPQCpltJjeLqb
   TA/pZHXpzqbZhIyzq5XFG8K7oUpEI2qQ6gSMg2BdLfb6wVplrHoyN7wVs
   x9trRDVlgL1pN9OSKxu8AJ/PHvjp7BV2keAta4XdqxeRBZ4NWzcicg9LE
   XJqSt9sVtjVSM3gwxd0B5aVYX390z6PYi9hu8bpLJ/EyMWOb4cd8X4ng9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="385614697"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="385614697"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 17:45:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="720542236"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="720542236"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jan 2023 17:45:36 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pFQBL-0008aS-1n;
        Wed, 11 Jan 2023 01:45:35 +0000
Date:   Wed, 11 Jan 2023 09:44:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 b3deec25847bda34e34d5d7be02f633caf000bd8
Message-ID: <63be149b.v5FILF78cmutfcOg%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: b3deec25847bda34e34d5d7be02f633caf000bd8  IB/hfi1: Remove user expected buffer invalidate race

elapsed time: 721m

configs tested: 46
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
ia64                             allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
arm                                 defconfig
arc                                 defconfig
alpha                               defconfig
arm                              allyesconfig
s390                             allmodconfig
arm64                            allyesconfig
s390                                defconfig
s390                             allyesconfig
riscv                randconfig-r042-20230110
s390                 randconfig-r044-20230110
arc                  randconfig-r043-20230110

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001
mips                malta_qemu_32r6_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
