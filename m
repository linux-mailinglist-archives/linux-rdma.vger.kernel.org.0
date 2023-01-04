Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99BD65DE09
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jan 2023 22:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240210AbjADVGd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Jan 2023 16:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240289AbjADVGP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Jan 2023 16:06:15 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85741CB2B
        for <linux-rdma@vger.kernel.org>; Wed,  4 Jan 2023 13:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672866374; x=1704402374;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zoyyn0EhvaAADCDIHizml6ytfcWyNNMmaGghEYuqrko=;
  b=WpZXbshHCuOELPBivdlUoEOYD+nr3SQccL6fH0lhAGEGFBYlZeOr/TTw
   P5h5hJLO0mNt4bdYJjjYQYxmp2j/p2b8WAD8rahPnqZlqVXGoekgbVPVt
   xhcmEgisa+y4GBP3qdAsZiy5FW6W5bYTt5R3ckDlptzXoXxWKFXxXpVpH
   uIX/WYFdG+KyrBZCeQja3mPVpuAoKl06Lf4XnqQWuFY1lBBaH2lTXF22P
   D82VKylUIMGIGHAJZJ6rwaaki//nVe1v9/eotdZ871Wvg6Y5f8xKborcr
   gjyRKwGA9LPAMWzI8rnUvsLDnytjrrM0vLQG/v4df7/mA0HKb5fNjTKRK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="349265173"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="349265173"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 13:06:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="829287600"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="829287600"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 04 Jan 2023 13:06:10 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pDAxe-0000mF-0i;
        Wed, 04 Jan 2023 21:06:10 +0000
Date:   Thu, 05 Jan 2023 05:05:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 bd99ede8ef2dc03e29a181b755ba4f78da2644e6
Message-ID: <63b5ea14.7TdXbGgX5zJzJFSF%lkp@intel.com>
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
branch HEAD: bd99ede8ef2dc03e29a181b755ba4f78da2644e6  RDMA/irdma: Remove extra ret variable in favor of existing err

elapsed time: 722m

configs tested: 80
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
alpha                            allyesconfig
arc                                 defconfig
arc                              allyesconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                            allnoconfig
s390                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
s390                             allyesconfig
ia64                             allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64               randconfig-a004-20230102
x86_64                              defconfig
x86_64               randconfig-a002-20230102
x86_64               randconfig-a003-20230102
x86_64                           rhel-8.3-bpf
x86_64               randconfig-a001-20230102
i386                          randconfig-a005
i386                                defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a006-20230102
x86_64               randconfig-a005-20230102
x86_64                           rhel-8.3-kvm
x86_64                               rhel-8.3
x86_64                           allyesconfig
powerpc                           allnoconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
mips                             allyesconfig
arm                                 defconfig
arm                              allyesconfig
powerpc                          allmodconfig
i386                             allyesconfig
sh                               allmodconfig
arm64                            allyesconfig
riscv                randconfig-r042-20230101
s390                 randconfig-r044-20230101
arc                  randconfig-r043-20230102
arm                  randconfig-r046-20230102
arc                  randconfig-r043-20230101
i386                 randconfig-a005-20230102
i386                 randconfig-a006-20230102
i386                 randconfig-a001-20230102
i386                 randconfig-a002-20230102
i386                 randconfig-a003-20230102
i386                 randconfig-a004-20230102
i386                          randconfig-c001
powerpc              randconfig-c003-20230101
s390                 randconfig-r044-20230103
arc                  randconfig-r043-20230103
riscv                randconfig-r042-20230103

clang tested configs:
i386                 randconfig-a012-20230102
i386                 randconfig-a011-20230102
i386                 randconfig-a014-20230102
i386                 randconfig-a013-20230102
i386                 randconfig-a015-20230102
i386                 randconfig-a016-20230102
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230102
s390                 randconfig-r044-20230102
hexagon              randconfig-r045-20230101
hexagon              randconfig-r045-20230102
arm                  randconfig-r046-20230101
riscv                randconfig-r042-20230102
hexagon              randconfig-r041-20230101
x86_64               randconfig-a011-20230102
x86_64               randconfig-a014-20230102
x86_64               randconfig-a012-20230102
x86_64               randconfig-a013-20230102
x86_64               randconfig-a015-20230102
x86_64               randconfig-a016-20230102
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
