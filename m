Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AD8638CBC
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Nov 2022 15:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiKYOva (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Nov 2022 09:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKYOv3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Nov 2022 09:51:29 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9125521E11
        for <linux-rdma@vger.kernel.org>; Fri, 25 Nov 2022 06:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669387888; x=1700923888;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ARU+QlV2J2EKFlyWyjzKh0uQGxcrcXZWLRnheX2QFbM=;
  b=fIn+PXrPaFsU4fK6utrb31p5wXHRz434G5SN5ja1iyC6NvTaNlC9VxVs
   ckB4Ot1hGxkdJsL7XIfXqE+SIS/TfQSbztfeE8LdgBgnSVpFetq6vVNuq
   8Ngr4Ln6zNun6jDndiiyDRAE8Us19jNyTUyXOwCtdfAe6Kq6ICaHpZeGk
   Et4+oTMZatabk7a9ke/EcmDfwsi9yz1R6pH4b8SGp8WzveudntVJ2wBIJ
   59B5Jra53kGDOgmyJJMiwv3A0MrBt2+f+oLKc9Dcy/p80nDFRfVQqah0+
   eajVkZ6KQCV1T7lh9wBjeet0Y6IVducC1Vt9rn0Ano17QCJlqCnget1Tg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="315652644"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="315652644"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 06:51:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="817160784"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="817160784"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Nov 2022 06:51:26 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oya34-0005EU-0m;
        Fri, 25 Nov 2022 14:51:26 +0000
Date:   Fri, 25 Nov 2022 22:50:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 0edf42cbcc8690ef349d4432fea74d7791e3c645
Message-ID: <6380d652.xqoDLNCjdK5ORU+o%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 0edf42cbcc8690ef349d4432fea74d7791e3c645  RDMA/erdma: Notify the latest PI to FW for reflushing when necessary

elapsed time: 1163m

configs tested: 60
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
arc                  randconfig-r043-20221124
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
ia64                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                            allnoconfig
alpha                            allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
arc                              allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                             allyesconfig
i386                                defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
sh                   sh7770_generic_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                 mpc837x_mds_defconfig
mips                         rt305x_defconfig
m68k                        stmark2_defconfig
powerpc                      ep88xc_defconfig
ia64                        generic_defconfig
arm                       multi_v4t_defconfig
sh                           se7206_defconfig
sh                        dreamcast_defconfig
arm                        shmobile_defconfig
powerpc                     tqm8548_defconfig
powerpc                    klondike_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig

clang tested configs:
riscv                randconfig-r042-20221124
hexagon              randconfig-r041-20221124
hexagon              randconfig-r045-20221124
s390                 randconfig-r044-20221124
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-k001
arm                        multi_v5_defconfig
powerpc                     pseries_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
