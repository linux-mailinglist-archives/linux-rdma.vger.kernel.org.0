Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02CE61FF5D
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 21:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbiKGUQK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Nov 2022 15:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbiKGUQK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Nov 2022 15:16:10 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A4219035
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 12:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667852167; x=1699388167;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jtdy39MElQrD8BefytKTpXnZ62L+oP4UF764dAJBiY0=;
  b=cSB1tNfUzjWfT5QZttcvkiqsgvGYbNZjFi46z/wN+WRCB3efWyRzG8yB
   cV2v4yfjBWWZY+z7nR6YtqAgs5vrTT/PVVs4jWZniJTAJUCRuCSR86T3K
   CR/HmERayGW8oXY+haW/KfvuRFbDegq6B95QpQgsby147RIJR4GGzxP2O
   JFa9s9TbtaenSusDoFq1k3pMQBD5sucw+E4abgpbM2QdBroOVowkZ33R7
   4GINelzMrqEefuP5QuHjViK6UtSyODKtiKU+sFL/Phf+va/1pKE8GgTkN
   bbO7WIeefULg5WvFwtxCopj7zt3Dyf8fGmcJIbGDJzko8IAe/JfwAELGF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="293882604"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="293882604"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 12:16:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="778638948"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="778638948"
Received: from lkp-server01.sh.intel.com (HELO 462403710aa9) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Nov 2022 12:16:05 -0800
Received: from kbuild by 462403710aa9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1os8XM-000113-2R;
        Mon, 07 Nov 2022 20:16:04 +0000
Date:   Tue, 08 Nov 2022 04:15:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 0ca9c2e2844aa285c3656a29d4803839cfa8bca9
Message-ID: <6369675e.6N+8J0hLSCTAqcjN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 0ca9c2e2844aa285c3656a29d4803839cfa8bca9  RDMA/erdma: Implement atomic operations support

elapsed time: 724m

configs tested: 79
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allmodconfig
s390                                defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                               rhel-8.3
s390                             allyesconfig
arc                  randconfig-r043-20221107
ia64                             allmodconfig
i386                 randconfig-a002-20221107
i386                 randconfig-a003-20221107
i386                 randconfig-a004-20221107
i386                 randconfig-a005-20221107
i386                 randconfig-a001-20221107
i386                 randconfig-a006-20221107
i386                             allyesconfig
i386                                defconfig
x86_64               randconfig-a006-20221107
x86_64               randconfig-a001-20221107
x86_64               randconfig-a004-20221107
x86_64               randconfig-a003-20221107
x86_64               randconfig-a005-20221107
x86_64               randconfig-a002-20221107
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-c001-20221107
mips                 randconfig-c004-20221107
powerpc                       ppc64_defconfig
loongarch                           defconfig
parisc64                         alldefconfig
sh                   sh7724_generic_defconfig
x86_64                           alldefconfig
powerpc                      bamboo_defconfig
sh                           se7721_defconfig
sh                           se7705_defconfig
sh                     sh7710voipgw_defconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20221107
riscv                randconfig-r042-20221107
s390                 randconfig-r044-20221107
hexagon              randconfig-r045-20221107
x86_64               randconfig-a015-20221107
x86_64               randconfig-a014-20221107
x86_64               randconfig-a016-20221107
x86_64               randconfig-a011-20221107
x86_64               randconfig-a013-20221107
x86_64               randconfig-a012-20221107
powerpc                    mvme5100_defconfig
mips                      malta_kvm_defconfig
mips                     cu1000-neo_defconfig
arm                         orion5x_defconfig
mips                        omega2p_defconfig
hexagon              randconfig-r041-20221108
hexagon              randconfig-r045-20221108
i386                 randconfig-a013-20221107
i386                 randconfig-a015-20221107
i386                 randconfig-a016-20221107
i386                 randconfig-a011-20221107
i386                 randconfig-a014-20221107
i386                 randconfig-a012-20221107

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
