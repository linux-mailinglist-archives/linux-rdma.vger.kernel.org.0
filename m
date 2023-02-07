Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF6B68E415
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Feb 2023 00:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBGXBv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Feb 2023 18:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjBGXBu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Feb 2023 18:01:50 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D873FF0C
        for <linux-rdma@vger.kernel.org>; Tue,  7 Feb 2023 15:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675810901; x=1707346901;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=p53IjhJJKauQbEesyPKbkr8itgbsQ/+AuA8NRBsssYA=;
  b=kOuivuyT0pJBeeZBfK2lswnygqBVY/PIBuZYHZz41/ErHWRz4VfjaD4f
   4DciM6MvQp3ekUq/dV/4uILZZXlPXhZ0vYPWwoQ40wSroHdHiWqKHTvEQ
   7AYnLislV2ta2lBHpNuzIG4DKvMqN2OdY0l4UmPLT+qQpZxQ2qCKGMZ6j
   bTao9O0tnMJFeGWAObYlB6EoYJCEkagj/8k5ZVI5TIzaPGQcP6WVxvwuf
   CpybBIr94lYtqxV/7gQDfPzPShI3LiqymH88TOdmYbJg5+PYSn/ZwnR/J
   oa8Nme5ZyMI4lybNITREIWEQuHxWNxNb0I92/c6lZOIhS2NvdEFalOyFb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="309993361"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="309993361"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 15:01:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="699425186"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="699425186"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Feb 2023 15:01:39 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPWy2-0003xL-1J;
        Tue, 07 Feb 2023 23:01:38 +0000
Date:   Wed, 08 Feb 2023 07:01:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 2de49fb1c9bb8bfe283070fef2e9304d9842a30c
Message-ID: <63e2d843.fBNw8OrAlWy1mHTN%lkp@intel.com>
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
branch HEAD: 2de49fb1c9bb8bfe283070fef2e9304d9842a30c  RDMA/rtrs: Don't call kobject_del for srv_path->kobj

elapsed time: 724m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
sh                               allmodconfig
x86_64                           rhel-8.3-bpf
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
i386                                defconfig
ia64                             allmodconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64               randconfig-a013-20230206
x86_64               randconfig-a011-20230206
x86_64               randconfig-a012-20230206
x86_64               randconfig-a014-20230206
x86_64               randconfig-a015-20230206
x86_64               randconfig-a016-20230206
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
arm                                 defconfig
arc                  randconfig-r043-20230205
i386                 randconfig-a011-20230206
arm                  randconfig-r046-20230205
i386                 randconfig-a014-20230206
i386                             allyesconfig
i386                 randconfig-a012-20230206
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                 randconfig-a016-20230206
i386                 randconfig-a013-20230206
i386                 randconfig-a015-20230206
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
i386                 randconfig-a002-20230206
i386                 randconfig-a003-20230206
hexagon              randconfig-r041-20230205
i386                 randconfig-a001-20230206
x86_64                          rhel-8.3-rust
hexagon              randconfig-r045-20230205
i386                 randconfig-a004-20230206
i386                 randconfig-a006-20230206
x86_64               randconfig-a002-20230206
x86_64               randconfig-a004-20230206
i386                 randconfig-a005-20230206
x86_64               randconfig-a003-20230206
x86_64               randconfig-a001-20230206
x86_64               randconfig-a005-20230206
x86_64               randconfig-a006-20230206
riscv                randconfig-r042-20230205
s390                 randconfig-r044-20230205

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
