Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5197A68CC67
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Feb 2023 03:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjBGCDc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Feb 2023 21:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBGCDb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Feb 2023 21:03:31 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382E3199E8
        for <linux-rdma@vger.kernel.org>; Mon,  6 Feb 2023 18:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675735410; x=1707271410;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=j41y9/oU+bUUkd+XRs6omZQjq7meRIUB9zSlGyxWpuE=;
  b=fkFbHvwE58hVUNEPmtel9T6bxEoi6l5LsTiKP3SrY1DJHa6nutpMU/zc
   1pTN/jEBoZ1QW6uS66mC35FwI2oczX1329ZGVnHYV9K5lwhRpwiODA3lu
   N1rzfBVl5YjKgrztrT06TAUiKD5Afh3t6zj0gnSol/vIdF8ARnq8g6FHt
   inSICFP3kw94aJtbVWMY52hPZRqhF2a3IZdtfAeLGeXCdDwqZ7FE/HWZ6
   YWLS4w/TFxpmXPWVQQXog5iZVs3JbIkdDQqUdzymbMJ19aFp1W3vIxv1d
   juLgwAR41dvEG7hK6caVaMKHoXzycCIjtQz5nqMNcQ+TjBaxfAqrtANmI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="317392947"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="317392947"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 18:03:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="616637094"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="616637094"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Feb 2023 18:03:27 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPDKQ-0002wi-20;
        Tue, 07 Feb 2023 02:03:26 +0000
Date:   Tue, 07 Feb 2023 10:03:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 563ca0e9eab8acc8a1309e8b440108ff8d23e951
Message-ID: <63e1b163.O8AEslJvCeUszHJo%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: 563ca0e9eab8acc8a1309e8b440108ff8d23e951  RDMA/mana_ib: Prevent array underflow in mana_ib_create_qp_raw()

elapsed time: 737m

configs tested: 31
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
powerpc                           allnoconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                                defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
sh                               allmodconfig
x86_64                           allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                            allnoconfig

clang tested configs:
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
