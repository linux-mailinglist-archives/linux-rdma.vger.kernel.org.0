Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D495F0ABE
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Sep 2022 13:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiI3LjL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Sep 2022 07:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbiI3Lio (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Sep 2022 07:38:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE27132AA2
        for <linux-rdma@vger.kernel.org>; Fri, 30 Sep 2022 04:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664537451; x=1696073451;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=vKzx+x+WkxBKb3ZkLR6tz0V1qCz+KY2b/FFv9Wf/OMc=;
  b=doYa8hHL4Sz7S9m6zy42PEQvXNjUAUlma64C0+AAl3kbGc8hQF2uD3Tw
   mqtbCPhUGQk5n7MAZlI1wFx+7MPZg1LZzoiX140moi5yHwZEevJyiktKB
   76AuDA4v5FNpAOpWyYD20S9cmW3R/MK2xIRbaFJTBKEmdtCho1xaNsyI9
   8bCsQNhD4UgX72+zxrxN9INZxiAjnmFX2xW5BIcSU4bU/G/KzptdnUVlq
   pAF/JqkBjLhx/N5mQ4EJPtUdLWW1yWtkVM4r461xrpPa5i1zeVrnp/mwt
   lL2xhowYUjgoWKNhzd3a0f/Zn5Etasn48FniPQ0QVUkhk2DkPXh/Hxv2v
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="303655518"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="303655518"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 04:30:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691218583"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="691218583"
Received: from lkp-server01.sh.intel.com (HELO 14cc182da2d0) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 30 Sep 2022 04:30:29 -0700
Received: from kbuild by 14cc182da2d0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oeEDs-0000yF-2p;
        Fri, 30 Sep 2022 11:30:28 +0000
Date:   Fri, 30 Sep 2022 19:30:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 8ad891ed435ba24465e0650942267e90a060675f
Message-ID: <6336d340.1+QSR0bDvAuhpzGj%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 8ad891ed435ba24465e0650942267e90a060675f  RDMA/rxe: Remove error/warning messages from packet receiver path

elapsed time: 1461m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
arc                                 defconfig
um                           x86_64_defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
i386                                defconfig
x86_64                          rhel-8.3-func
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                    rhel-8.3-kselftests
mips                             allyesconfig
x86_64                              defconfig
sh                               allmodconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
i386                             allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20220925
riscv                randconfig-r042-20220925
alpha                            allyesconfig
i386                 randconfig-a001-20220926
arc                              allyesconfig
i386                 randconfig-a004-20220926
i386                 randconfig-a005-20220926
m68k                             allyesconfig
arc                  randconfig-r043-20220926
i386                 randconfig-a006-20220926
m68k                             allmodconfig
i386                 randconfig-a002-20220926
s390                 randconfig-r044-20220925
i386                 randconfig-a003-20220926
arm                                 defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220925
hexagon              randconfig-r041-20220926
hexagon              randconfig-r045-20220926
hexagon              randconfig-r041-20220925
riscv                randconfig-r042-20220926
s390                 randconfig-r044-20220926
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                 randconfig-a011-20220926
i386                 randconfig-a014-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a012-20220926
x86_64               randconfig-a012-20220926
x86_64               randconfig-a013-20220926
x86_64               randconfig-a011-20220926
i386                 randconfig-a016-20220926
i386                 randconfig-a015-20220926
x86_64               randconfig-a016-20220926
x86_64               randconfig-a015-20220926
x86_64               randconfig-a014-20220926

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
