Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F2F5ED60F
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Sep 2022 09:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiI1H2v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Sep 2022 03:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbiI1H2N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Sep 2022 03:28:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6426E62EF
        for <linux-rdma@vger.kernel.org>; Wed, 28 Sep 2022 00:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664349976; x=1695885976;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=afVGWLdHvF/uMZOzyViD/fEH06ALmznyAmWDLbsZEbE=;
  b=ZCBqPm8EvSlzqaJbRLXQbN87Cur4JoX0INWzbVKSdlWj0PoOikblle+r
   TJzOPiVZwkRcf+8wtE7EADpWrvtFw2A5nSkgsbY7i/Yjt/7J3SsthWzqI
   Hr6wYmFRLMEyfpqqlow76uKrSHw2s/edXv42PBta1rGnTnUUx8kcCj/NF
   At7neakcUGkPUWKJcVIDBESp2zqytXlEP+55GRG20nVbQPn4DVtrFUqQU
   8OWCb0ZiNq7utL9M0jPxZ8cgtioquD6MDcZS1apmPzoHHoZV9NYhWUqez
   QYcJNjRs3DsZOO1b7N2or9mt7d94JoxOH8zoOmwYnVWM3GhXhv+vHiGN6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="281901233"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="281901233"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 00:25:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="599475130"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="599475130"
Received: from lkp-server01.sh.intel.com (HELO 6126f2790925) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Sep 2022 00:24:59 -0700
Received: from kbuild by 6126f2790925 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1odRRC-00002D-1e;
        Wed, 28 Sep 2022 07:24:58 +0000
Date:   Wed, 28 Sep 2022 15:24:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 cbdae01d8b517b81ed271981395fee8ebd08ba7d
Message-ID: <6333f6a6.n1U6sLR0G/70xRwL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: cbdae01d8b517b81ed271981395fee8ebd08ba7d  IB/hfi1: Use skb_put_data() instead of skb_put/memcpy pair

elapsed time: 984m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
alpha                               defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
s390                             allmodconfig
s390                                defconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
s390                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                                defconfig
arm                                 defconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
i386                 randconfig-a001-20220926
arm                              allyesconfig
i386                             allyesconfig
arm64                            allyesconfig
i386                 randconfig-a004-20220926
i386                 randconfig-a002-20220926
i386                 randconfig-a003-20220926
i386                 randconfig-a006-20220926
i386                 randconfig-a005-20220926
arc                  randconfig-r043-20220925
riscv                randconfig-r042-20220925
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arc                  randconfig-r043-20220926
s390                 randconfig-r044-20220925
x86_64                        randconfig-a006
ia64                             allmodconfig
m68k                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220925
hexagon              randconfig-r041-20220926
hexagon              randconfig-r045-20220926
hexagon              randconfig-r041-20220925
riscv                randconfig-r042-20220926
x86_64                        randconfig-a001
s390                 randconfig-r044-20220926
x86_64                        randconfig-a003
i386                 randconfig-a013-20220926
i386                 randconfig-a012-20220926
i386                 randconfig-a011-20220926
i386                 randconfig-a014-20220926
i386                 randconfig-a015-20220926
x86_64                        randconfig-a005
i386                 randconfig-a016-20220926
x86_64               randconfig-a013-20220926
x86_64               randconfig-a011-20220926
x86_64               randconfig-a012-20220926
x86_64               randconfig-a014-20220926
x86_64               randconfig-a015-20220926
x86_64               randconfig-a016-20220926

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
