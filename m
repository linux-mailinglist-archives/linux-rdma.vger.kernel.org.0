Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7593F648F34
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Dec 2022 15:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiLJOe4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 10 Dec 2022 09:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiLJOey (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 10 Dec 2022 09:34:54 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CC818E22
        for <linux-rdma@vger.kernel.org>; Sat, 10 Dec 2022 06:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670682892; x=1702218892;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4CM3Nj3bt6LPFMNu1O2Be3BU9Xur6Xi3jPzlEuiSalk=;
  b=ekNafw0HHgpou7a1E4bBbJA5KUS9gNq3U8JEVxfZ23nnY5l1S3xDbKYK
   7Z6Um3k6v7zDjTktxA5Xx56Lt6MsJF2e4scyf4rb+7AyzFufi5lh3GZH5
   UQGYKxwV5KVl42uhZdo7t1kMIWQlY5zTxoiify3A+hHMKrRJ02Ed5GiHa
   Ze+bplc2lUd5VHaQ38oJ52B75K0/xSU0qOmTT0DjFTPT6u5wExnOYiOCe
   glAKZENgRqcTnsDGXBDfAIxbkOy+5eZxIXTSh2rS845EsXrNTVvuhiZdd
   rjoP0X524YnUOFaaEh8nB4M/0h/CqixN7geFFpqJHS+IBLtacdhIQuoXy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="319485303"
X-IronPort-AV: E=Sophos;i="5.96,234,1665471600"; 
   d="scan'208";a="319485303"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2022 06:34:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="711192673"
X-IronPort-AV: E=Sophos;i="5.96,234,1665471600"; 
   d="scan'208";a="711192673"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 10 Dec 2022 06:34:50 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p40wD-0002W3-35;
        Sat, 10 Dec 2022 14:34:49 +0000
Date:   Sat, 10 Dec 2022 22:34:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 124011e6e933bead5852c3f69b32dec43919fe1a
Message-ID: <639498e4.C4Jl7Kc3dYmVaS3H%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 124011e6e933bead5852c3f69b32dec43919fe1a  RDMA/rxe: Enable RDMA FLUSH capability for rxe device

elapsed time: 834m

configs tested: 67
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-rust
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
x86_64                              defconfig
i386                                defconfig
x86_64                        randconfig-a013
m68k                             allyesconfig
x86_64                        randconfig-a011
m68k                             allmodconfig
arc                              allyesconfig
x86_64                               rhel-8.3
alpha                            allyesconfig
x86_64                        randconfig-a015
arc                                 defconfig
arc                  randconfig-r043-20221209
s390                             allmodconfig
x86_64                           allyesconfig
s390                 randconfig-r044-20221209
alpha                               defconfig
arm                                 defconfig
s390                                defconfig
riscv                randconfig-r042-20221209
i386                          randconfig-a001
i386                          randconfig-a003
ia64                             allmodconfig
i386                          randconfig-a005
s390                             allyesconfig
i386                             allyesconfig
sh                               allmodconfig
i386                          randconfig-a014
x86_64                        randconfig-a004
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
i386                          randconfig-a012
mips                             allyesconfig
x86_64                        randconfig-a002
arm                              allyesconfig
powerpc                          allmodconfig
arm64                            allyesconfig
i386                          randconfig-a016
x86_64                        randconfig-a006
i386                          randconfig-c001

clang tested configs:
x86_64                        randconfig-a016
x86_64                        randconfig-a014
x86_64                        randconfig-a012
hexagon              randconfig-r041-20221209
hexagon              randconfig-r045-20221209
arm                  randconfig-r046-20221209
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
powerpc                     mpc512x_defconfig
powerpc                     skiroot_defconfig
x86_64                        randconfig-k001
mips                        omega2p_defconfig
powerpc                   lite5200b_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
