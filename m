Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C503068CD17
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Feb 2023 04:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjBGDFo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Feb 2023 22:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjBGDFe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Feb 2023 22:05:34 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA642D58
        for <linux-rdma@vger.kernel.org>; Mon,  6 Feb 2023 19:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675739132; x=1707275132;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ipJgHJBL43UvpckzuTR+ZaC6we4rAPBfNpPVsZD+lRI=;
  b=BqSiV+iIhAFUl0vQYwabnQHLdx4LNxqkwnMi95AVwF57s7Rgu0YsKHvc
   Itajxb4iaugnCJP9xLHRl3oB0PwEEY9qTpYFhCv3e0LBQg+cvlBys6DUa
   q9AjzkkWHWyLqHp8vIVLCeKDWEXGOqH8x3OzT53XesfdTRLbO8zMxRv6B
   vC9f+hs43Vo0PXNme+VTPtN9VWTOrOyX0+wR4V/Zz8D0PgJtU9Is5jfMp
   rEky+RwL1pSHyAovmQ+tAYbPryJlaySQNznugqiPMwVoAIUGL750hJ73k
   JoACXDBmJgYT9K1BizGJVgnQPDIieS4GUbFAU6yDblp6QWCnWkYy0hUqk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="329406315"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="329406315"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 19:05:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="666686369"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="666686369"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Feb 2023 19:05:29 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPEIS-0002zS-0v;
        Tue, 07 Feb 2023 03:05:28 +0000
Date:   Tue, 07 Feb 2023 11:05:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 283861a4c52c1ea4df3dd1b6fc75a50796ce3524
Message-ID: <63e1bfe4.eHAAWSMU6wQWxDuM%lkp@intel.com>
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
branch HEAD: 283861a4c52c1ea4df3dd1b6fc75a50796ce3524  RDMA/cxgb4: Fix potential null-ptr-deref in pass_establish()

elapsed time: 724m

configs tested: 31
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
m68k                             allyesconfig
powerpc                           allnoconfig
um                           x86_64_defconfig
arc                                 defconfig
um                             i386_defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
s390                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
s390                             allyesconfig
x86_64                              defconfig
i386                                defconfig
x86_64                               rhel-8.3
sh                               allmodconfig
arm                                 defconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                           allyesconfig
i386                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
x86_64                            allnoconfig

clang tested configs:
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
