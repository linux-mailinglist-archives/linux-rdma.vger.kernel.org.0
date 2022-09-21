Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20E15E548B
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Sep 2022 22:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiIUUgx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Sep 2022 16:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiIUUgw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Sep 2022 16:36:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937A991D29
        for <linux-rdma@vger.kernel.org>; Wed, 21 Sep 2022 13:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663792603; x=1695328603;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+pnewE/lVPKjQiTOZVzTq5yUR9K734oE3qFv+TFVM0U=;
  b=R/nAj64FNEq74EdfcQXxU+srvkCODOl3W0cdk7jLYgqEY+DHgh90LKA/
   xmG7RuUXinQiM3qKXajrRXawnRtWumbGbRq39d11zmcq+d14Q76O2EwIM
   4A52byJ6rqS87ObIKrMJbBuUVzoRCBQTzNg6sdsk7Bg2TohNLzgVoM5IM
   0+njHIgpchxEUdKDR7DngyoyQkZe2cSieFijLfZLCsdtQPTTA7/DBou2W
   SrpxR5fahbnix2SGtqJ5cqL2c82RDgAxmhRywLWGXPrODMeXCefYAKb59
   YdDq31WAh3v9JGiANAS2Jn6FlbnmzAwGmGJLJDpalE33pFPh91eyElsbw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="297719932"
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="297719932"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 13:36:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="652690939"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Sep 2022 13:36:41 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ob6SW-0003wf-2Z;
        Wed, 21 Sep 2022 20:36:40 +0000
Date:   Thu, 22 Sep 2022 04:35:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 9bdb9350f3808bbff229167acb55cf0a3bd8f2ca
Message-ID: <632b759f.VWN6aBUlDswn+tEi%lkp@intel.com>
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
branch HEAD: 9bdb9350f3808bbff229167acb55cf0a3bd8f2ca  RDMA/erdma: Support dynamic mtu

elapsed time: 747m

configs tested: 83
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
arc                                 defconfig
um                             i386_defconfig
sh                               allmodconfig
um                           x86_64_defconfig
alpha                               defconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
m68k                             allmodconfig
arc                              allyesconfig
i386                          randconfig-a001
alpha                            allyesconfig
i386                          randconfig-a003
i386                                defconfig
i386                          randconfig-a005
arc                  randconfig-r043-20220921
x86_64                        randconfig-a004
riscv                randconfig-r042-20220921
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arm                                 defconfig
s390                 randconfig-r044-20220921
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig
x86_64                          rhel-8.3-func
s390                             allmodconfig
s390                             allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
m68k                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a014
i386                             allyesconfig
i386                          randconfig-a012
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                          randconfig-a016
s390                                defconfig
sh                             sh03_defconfig
sh                              ul2_defconfig
powerpc                      ppc6xx_defconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
i386                             alldefconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                      bamboo_defconfig
arm                           h5000_defconfig
m68k                        mvme147_defconfig
powerpc                        cell_defconfig
sparc64                          alldefconfig
i386                          randconfig-c001
sh                         ap325rxa_defconfig
xtensa                    smp_lx200_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     tqm8555_defconfig
nios2                            alldefconfig
powerpc                      cm5200_defconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r041-20220921
x86_64                        randconfig-a001
hexagon              randconfig-r045-20220921
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
