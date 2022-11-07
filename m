Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9509D61EB5C
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 08:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiKGHKf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Nov 2022 02:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiKGHKe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Nov 2022 02:10:34 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3E25F4C
        for <linux-rdma@vger.kernel.org>; Sun,  6 Nov 2022 23:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667805033; x=1699341033;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jeJeBaZoyYsVbXNPHkQhv86781qemAQkMJ4zLzIq4jI=;
  b=oFb/lKOV6OtE3X7kNFRgugQ9uEkv4VxNST4D79Z2j+36t/0O5MQ2IM6V
   UomuBjBwFznx0xMwT6iqHY1o4DNe2j3MtAcFw8MGoY+cMfV3MDfBGyWBC
   lnLyWkFwSNjEKpf5e2zFNHoBvVaOv7jkiQVyVYTIOAA2FFZv8NAsgYuO0
   wB4w/yFr4dtfXdSzVegUpejA1KRO/Tw1oTEqN8zxVosgJi2BpimE9opUT
   ONLm6713sCUBPqt7kcslr9dBF4R62C6y2cduzJ1vhkJBXnWfdkfh+kWGZ
   7U9CCIh7YRgkURsOAYs/aiy/Z9uhfO/7/mQ3/APO4udSE/20SQ8pM63QB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="297834595"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="297834595"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 23:10:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="613763289"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="613763289"
Received: from lkp-server01.sh.intel.com (HELO 462403710aa9) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Nov 2022 23:10:31 -0800
Received: from kbuild by 462403710aa9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1orwH8-0000Q0-28;
        Mon, 07 Nov 2022 07:10:30 +0000
Date:   Mon, 07 Nov 2022 15:09:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 abef378c434e6f5abd46fd536e9972374fb74e98
Message-ID: <6368af46.dahtti3mwe9vLfMD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: abef378c434e6f5abd46fd536e9972374fb74e98  RDMA/mlx5: Change debug log level for remote access error syndromes

elapsed time: 720m

configs tested: 64
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                                defconfig
m68k                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arc                                 defconfig
um                             i386_defconfig
x86_64                        randconfig-a015
s390                                defconfig
x86_64                              defconfig
alpha                               defconfig
s390                 randconfig-r044-20221106
x86_64                          rhel-8.3-func
um                           x86_64_defconfig
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a016
x86_64                           allyesconfig
i386                          randconfig-a001
arc                  randconfig-r043-20221106
s390                             allmodconfig
i386                          randconfig-a003
s390                             allyesconfig
x86_64                               rhel-8.3
i386                          randconfig-a005
riscv                randconfig-r042-20221106
i386                          randconfig-a012
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a014
i386                 randconfig-a002-20221107
i386                 randconfig-a003-20221107
i386                 randconfig-a001-20221107
i386                 randconfig-a004-20221107
mips                             allyesconfig
sh                               allmodconfig
x86_64                        randconfig-a006
arm                                 defconfig
i386                 randconfig-a005-20221107
powerpc                           allnoconfig
i386                             allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a006-20221107
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a015
hexagon              randconfig-r041-20221106
i386                          randconfig-a013
i386                          randconfig-a002
hexagon              randconfig-r045-20221106
i386                          randconfig-a011
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
