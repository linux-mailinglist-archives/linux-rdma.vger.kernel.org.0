Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E765B63B702
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Nov 2022 02:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbiK2BVK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Nov 2022 20:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbiK2BVJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Nov 2022 20:21:09 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA8C3FB86
        for <linux-rdma@vger.kernel.org>; Mon, 28 Nov 2022 17:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669684869; x=1701220869;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=w/Ygz+uXGJpvu8NZMp1IhsfwE6Dpfa5qg+3/aaPdECY=;
  b=CkmX0LuiVuc5L+sszs5JcFlT55eVLBg2pY2T7hcEW/5ndzdDeOpNptb5
   4S0dL59GUoeFEC6Sbkxmd5IEzW1/KYeVXAa2WgHuBJ6ZJoMwwEN62jMdY
   ZyVyg8DpmMJE9UQ9HjdcLoydwYoMXZqupjnnHewomYVZiyEbcL9NWtRuu
   Iev2bU3HC4COi3JcN0Es0XbxspdujULgf0cutcHq13N9fWUt0wYcSPFUq
   jQqKGMHGppWxU+zn+BrXl5w6lDOB15eEs4LxX7p4JyHqU7R3PQqI5YNiR
   bMO/BVWvPSxtmWZAnFH1+vr+q5RycVTCijflTdACpPdjGrEvRWUAt9pMg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="401279020"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="401279020"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 17:21:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="643605506"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="643605506"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Nov 2022 17:21:06 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ozpJ4-0008Tj-0p;
        Tue, 29 Nov 2022 01:21:06 +0000
Date:   Tue, 29 Nov 2022 09:20:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 ea5ef136e215fdef35f14010bc51fcd6686e6922
Message-ID: <63855e53.cJ2Kayk3tzS4DlU2%lkp@intel.com>
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
branch HEAD: ea5ef136e215fdef35f14010bc51fcd6686e6922  RDMA/nldev: Add checks for nla_nest_start() in fill_stat_counter_qps()

elapsed time: 770m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                           allnoconfig
alpha                            allyesconfig
m68k                             allmodconfig
x86_64               randconfig-a002-20221128
arc                              allyesconfig
arc                                 defconfig
x86_64               randconfig-a001-20221128
s390                             allmodconfig
i386                 randconfig-a002-20221128
alpha                               defconfig
i386                 randconfig-a003-20221128
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a001-20221128
i386                 randconfig-a004-20221128
arc                  randconfig-r043-20221128
i386                 randconfig-a005-20221128
i386                 randconfig-a006-20221128
x86_64               randconfig-a006-20221128
s390                                defconfig
x86_64               randconfig-a003-20221128
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64               randconfig-a004-20221128
x86_64                         rhel-8.3-kunit
m68k                             allyesconfig
x86_64               randconfig-a005-20221128
x86_64                           rhel-8.3-kvm
s390                             allyesconfig
x86_64                              defconfig
ia64                             allmodconfig
i386                                defconfig
sh                               allmodconfig
x86_64                               rhel-8.3
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
hexagon              randconfig-r045-20221128
riscv                randconfig-r042-20221128
hexagon              randconfig-r041-20221128
s390                 randconfig-r044-20221128
x86_64               randconfig-a012-20221128
x86_64               randconfig-a014-20221128
i386                 randconfig-a012-20221128
x86_64               randconfig-a011-20221128
i386                 randconfig-a011-20221128
i386                 randconfig-a013-20221128
i386                 randconfig-a014-20221128
i386                 randconfig-a015-20221128
x86_64               randconfig-a016-20221128
x86_64               randconfig-a015-20221128
i386                 randconfig-a016-20221128
x86_64               randconfig-a013-20221128

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
