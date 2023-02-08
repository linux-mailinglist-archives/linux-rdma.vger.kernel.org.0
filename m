Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB51F68F983
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Feb 2023 22:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjBHVNW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Feb 2023 16:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjBHVNS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Feb 2023 16:13:18 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C733B0D2
        for <linux-rdma@vger.kernel.org>; Wed,  8 Feb 2023 13:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675890797; x=1707426797;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4WOlAH+CpzCOS9aw41oI98dYR/PX2N9gmAlBaQqfyrY=;
  b=EgVSVyAlGdV1pJmsKbQbHb6llHdgSAyFYsZsf0QKIgyYNMeAqPy+taY8
   fu45LeN3wS2xGgSjl5vUEqpokiSh/8hPuNbF1nyQjc3HR54A9i+vfKvk2
   5/5pv2hrD7VqdcUdkD0w30Hf/Sxln3N49ljP7expx9lcCo7qEswneLnvL
   M1OHZU0fEPa8MjxESh73ADMiXFFDTI4ReW4bIiRlYvlwKpr+ULWRu37lk
   whNCsR2KSBW+e/rK4wb8LkOexXe1xUmkFw/Nc739Xw5mS80jiGotIhZCr
   Vu9POiLIEypNSKxLUKqdth9BIBRUAJNxr32uemhXq2MtP19aMu4PMUJDl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="310285229"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="310285229"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 13:13:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="810073995"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="810073995"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2023 13:13:15 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPrkg-0004ee-1a;
        Wed, 08 Feb 2023 21:13:14 +0000
Date:   Thu, 09 Feb 2023 05:12:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 9cd9842c46996ef62173c36619c746f57416bcb0
Message-ID: <63e4105a.M57MBZOPJqc1tq+P%lkp@intel.com>
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
branch HEAD: 9cd9842c46996ef62173c36619c746f57416bcb0  RDMA/irdma: Cap MSIX used to online CPUs + 1

elapsed time: 720m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
x86_64                           rhel-8.3-bpf
um                           x86_64_defconfig
i386                                defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                           rhel-8.3-syz
x86_64                              defconfig
arm                                 defconfig
x86_64                        randconfig-a015
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                             allyesconfig
x86_64                               rhel-8.3
arc                                 defconfig
i386                 randconfig-a011-20230206
s390                             allmodconfig
m68k                             allyesconfig
i386                 randconfig-a014-20230206
alpha                               defconfig
m68k                             allmodconfig
arm64                            allyesconfig
s390                                defconfig
arm                              allyesconfig
powerpc                           allnoconfig
x86_64                           allyesconfig
powerpc                          allmodconfig
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a012-20230206
s390                             allyesconfig
mips                             allyesconfig
x86_64                          rhel-8.3-func
i386                 randconfig-a016-20230206
arc                              allyesconfig
i386                 randconfig-a013-20230206
i386                 randconfig-a015-20230206
ia64                             allmodconfig
s390                 randconfig-r044-20230206
arc                  randconfig-r043-20230205
sh                               allmodconfig
alpha                            allyesconfig
arm                  randconfig-r046-20230205
arc                  randconfig-r043-20230206
riscv                randconfig-r042-20230206

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20230205
i386                 randconfig-a002-20230206
riscv                randconfig-r042-20230205
hexagon              randconfig-r045-20230206
x86_64                          rhel-8.3-rust
i386                 randconfig-a003-20230206
i386                 randconfig-a001-20230206
i386                 randconfig-a006-20230206
hexagon              randconfig-r041-20230206
i386                 randconfig-a005-20230206
i386                 randconfig-a004-20230206
x86_64               randconfig-a001-20230206
x86_64               randconfig-a005-20230206
x86_64               randconfig-a002-20230206
arm                  randconfig-r046-20230206
s390                 randconfig-r044-20230205
hexagon              randconfig-r045-20230205
x86_64               randconfig-a004-20230206
x86_64               randconfig-a003-20230206
x86_64               randconfig-a006-20230206

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
