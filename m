Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8936F55A7D2
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jun 2022 09:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiFYHqC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Jun 2022 03:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiFYHqB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 25 Jun 2022 03:46:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB1F4755A
        for <linux-rdma@vger.kernel.org>; Sat, 25 Jun 2022 00:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656143160; x=1687679160;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=WfQXLky4p0RUiBPdWnbPcEBSrS4+KyySPM4MS+sV/Ig=;
  b=kFEaY3KKy0B8FB7E4WMROPI7FAWGtPhx5u8+Aqjdhk6gN/yc2rvM/Uga
   THa+dXY3MQlB+5++O2Ljo1YEWVjCHloPPHQJGF10LVqx9tTlRUb+SR2EO
   esUoZ6eO1uPJ/BumJQuZhXakZ0BGF10H+QMg+CXTyllyt6YU+YiiWNMEW
   LtQTjyBOtvRDCOwMdnW9+cZZrWRAoRyWZdE64ILTNnQqTJNF6r5jNIs70
   o4mJqvOyJlvJI3X7gnS48Y9zxgvFLMD02CfII1VLu2JNeYy+O4LiElyBT
   8j9ORXLYvVflxMfPocVC5YmMd9ymhq9Ln8qAluNtPTB6+QXZ7qPvfXjmo
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="264206713"
X-IronPort-AV: E=Sophos;i="5.92,221,1650956400"; 
   d="scan'208";a="264206713"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 00:46:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,221,1650956400"; 
   d="scan'208";a="691840021"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jun 2022 00:45:57 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o50UP-0005Vt-72;
        Sat, 25 Jun 2022 07:45:57 +0000
Date:   Sat, 25 Jun 2022 15:45:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:hmm] BUILD SUCCESS efa0855c5b846c25e7cda02159ee35647ab6530e
Message-ID: <62b6bd07.hrmiQE7JXrR1SghG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git hmm
branch HEAD: efa0855c5b846c25e7cda02159ee35647ab6530e  RDMA/erdma: Add driver to kernel build environment

elapsed time: 725m

configs tested: 46
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
ia64                             allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
sh                               allmodconfig
i386                             allyesconfig
i386                          randconfig-a003
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
arc                  randconfig-r043-20220624
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220624
hexagon              randconfig-r045-20220624
s390                 randconfig-r044-20220624
riscv                randconfig-r042-20220624

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
