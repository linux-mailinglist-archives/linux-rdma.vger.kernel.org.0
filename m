Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92EB64790C
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Dec 2022 23:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiLHWwB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Dec 2022 17:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiLHWwB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Dec 2022 17:52:01 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792A08F72E
        for <linux-rdma@vger.kernel.org>; Thu,  8 Dec 2022 14:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670539920; x=1702075920;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=kneJ+lMo6teVmYu5yXWL+ZaKOU8LXyf6IaMh2KDLL54=;
  b=HUmjej0t06fDoPP2ZkBY76mhxtf9l4l/jwUqhBhjT3F44/qE13ZkyC4i
   EVwSWQLtW6rgchwdi4qa9O7aQYiq+Q+ndgzYRLrwT/6tHZM+oQcQN3Yup
   JWZMhHY29657vdhdcuqZP0pI0fFx1zl1JXlAGggAJHlwS7PlOh65DW3G/
   4bJ/qZfYwWx2VlTAM1sI6vc0Z1CaNOX8S5UE5T8AcXAqQ2lpKKexhScJI
   MtuL/s7d1Ge83bCJKYLrNBRRRJ5nxvDPzCNXSzRMuBDIjeLr3IhpI0Nxr
   Vr0BHPm3TSOlaUfZAAoYEl9HiLblQU8k03EaHWj87t0M1M4hwFN/GbgE0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="314960244"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="314960244"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 14:52:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="679717786"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="679717786"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Dec 2022 14:51:57 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p3PkC-0001Tc-2h;
        Thu, 08 Dec 2022 22:51:56 +0000
Date:   Fri, 09 Dec 2022 06:51:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 6cfe7bd0dfd33033683639039b5608d6534c19eb
Message-ID: <63926a83.SbnKeg4iRIQC7f9R%lkp@intel.com>
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
branch HEAD: 6cfe7bd0dfd33033683639039b5608d6534c19eb  RDMA/mlx5: Remove not-used IB_FLOW_SPEC_IB define

elapsed time: 728m

configs tested: 80
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                               rhel-8.3
sh                               allmodconfig
arm                  randconfig-r046-20221208
x86_64                              defconfig
arc                  randconfig-r043-20221207
arc                  randconfig-r043-20221208
x86_64                        randconfig-a013
mips                             allyesconfig
arc                                 defconfig
powerpc                          allmodconfig
x86_64                        randconfig-a011
arm                                 defconfig
s390                             allmodconfig
x86_64                           allyesconfig
arm                              allyesconfig
riscv                randconfig-r042-20221207
x86_64                          rhel-8.3-rust
arm64                            allyesconfig
x86_64                        randconfig-a015
ia64                             allmodconfig
alpha                               defconfig
s390                 randconfig-r044-20221207
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                          randconfig-a014
s390                                defconfig
i386                          randconfig-a012
m68k                             allyesconfig
m68k                             allmodconfig
i386                          randconfig-a016
arc                              allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
alpha                            allyesconfig
s390                             allyesconfig
i386                                defconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a004
i386                             allyesconfig
x86_64                        randconfig-a002
i386                          randconfig-a005
x86_64                        randconfig-a006
x86_64                            allnoconfig
arm                           h5000_defconfig
ia64                      gensparse_defconfig
arm                     eseries_pxa_defconfig
arc                        nsimosci_defconfig
arm                            qcom_defconfig
powerpc                mpc7448_hpc2_defconfig
openrisc                       virt_defconfig
arm                           h3600_defconfig
arm                          iop32x_defconfig
openrisc                            defconfig
sh                         microdev_defconfig
i386                          randconfig-c001

clang tested configs:
arm                  randconfig-r046-20221207
hexagon              randconfig-r041-20221207
x86_64                        randconfig-a014
hexagon              randconfig-r041-20221208
hexagon              randconfig-r045-20221208
hexagon              randconfig-r045-20221207
x86_64                        randconfig-a016
riscv                randconfig-r042-20221208
s390                 randconfig-r044-20221208
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a006
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
