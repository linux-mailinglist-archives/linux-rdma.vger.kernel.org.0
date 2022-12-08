Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811DE6471C4
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Dec 2022 15:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiLHO1f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Dec 2022 09:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiLHO1L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Dec 2022 09:27:11 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5B198947
        for <linux-rdma@vger.kernel.org>; Thu,  8 Dec 2022 06:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670509608; x=1702045608;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nwNNnrVv+02GzRpeIOl8dEz1Vu/hjF2zg4x2GdgcVoQ=;
  b=j1QR5J02QD1aehqyLigR48SBaTrlM+Wn9uNDroYLkdnG6rypWHglQEXI
   C8Yh3gLRjngt4p+7QIasLkjbiI9eGeI2ybnlw/MujfBL6T1nqJ62fzieY
   CmeRodDoc4nAlWeCaXmdAwQCwFDnK+u60EmFuXYPUSK8tthqQp3toTWFH
   ZRXd5jA82qqiaucM8vc1zvGK+uAApP6FjicMvaccb1CLXXdheI0wYimEM
   cx4hgFXr82vmVnI9R5/J/7T/TZ4cVMVD71CyH73UaGQ2fzUWaciVtihvm
   YsPL3yu0OmUuEQimpjpUqLM8PgETezWzkVCkMoAHTwSJaRMtBWJBO9FXd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="314829601"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="314829601"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 06:26:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="975877088"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="975877088"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Dec 2022 06:26:46 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p3HrJ-0001CF-1z;
        Thu, 08 Dec 2022 14:26:45 +0000
Date:   Thu, 08 Dec 2022 22:26:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 682c0722addae4b4a1440c9db9d8c86cb8e09ce5
Message-ID: <6391f400.4lDbI2RuIeW90K1y%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 682c0722addae4b4a1440c9db9d8c86cb8e09ce5  RDMA/hns: Fix XRC caps on HIP08

elapsed time: 723m

configs tested: 61
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arc                                 defconfig
um                           x86_64_defconfig
s390                             allmodconfig
um                             i386_defconfig
alpha                               defconfig
sh                               allmodconfig
m68k                             allyesconfig
s390                                defconfig
s390                             allyesconfig
mips                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
powerpc                          allmodconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                        randconfig-a013
arc                  randconfig-r043-20221207
x86_64                              defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a015
riscv                randconfig-r042-20221207
s390                 randconfig-r044-20221207
x86_64                          rhel-8.3-rust
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                          randconfig-a001
i386                          randconfig-a003
i386                                defconfig
x86_64                               rhel-8.3
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a005
arm                                 defconfig
x86_64                           allyesconfig
i386                          randconfig-a016
i386                             allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig
x86_64                            allnoconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a014
arm                  randconfig-r046-20221207
x86_64                        randconfig-a012
hexagon              randconfig-r041-20221207
x86_64                        randconfig-a016
hexagon              randconfig-r045-20221207
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
