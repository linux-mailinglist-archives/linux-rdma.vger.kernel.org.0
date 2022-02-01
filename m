Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0154A63A6
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Feb 2022 19:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbiBASVf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Feb 2022 13:21:35 -0500
Received: from mga07.intel.com ([134.134.136.100]:54491 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230372AbiBASVe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 1 Feb 2022 13:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643739694; x=1675275694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KyOSWEaejFfh8yGXm841fhhAs/IxurylSze+gORwEsM=;
  b=KcaSVKl4Gw3VB2BbBwEyxdNQVYv/7fW+Iv0nhyWmZCjKQOFXv68kU/+8
   TmCpxr1FQM5wNAk7M+dm1nvpM3NPzKMi48iz3O/JVr9E9kgtBNyDUHes+
   a+bNsfH8aw1U2Ikv54Gv9+nKdyUVESZqUe6G5X9haZASP9gKVNssRLA7+
   0Yb6745v39GReCKDWpRNSPunQmjNpPpUtqVcVygcWjmTML31e9Zbt/w1M
   59y9hIzUZh78IGFRnErTP2pwRnzRXTZU8OTLuESigAQtdKiA55eOWkx5U
   fiwEfVRgayDZVyRCaIg0fJEVABnLp0VroeH+yeHeqAQ0fffBZKIDDnSh0
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="311064602"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="311064602"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 10:21:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="698497799"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Feb 2022 10:21:00 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nExm0-000TZo-5j; Tue, 01 Feb 2022 18:21:00 +0000
Date:   Wed, 2 Feb 2022 02:20:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH for-next v10 07/17] RDMA/rxe: Use kzmalloc/kfree for mca
Message-ID: <202202020207.bxuWR3xX-lkp@intel.com>
References: <20220131220849.10170-8-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131220849.10170-8-rpearsonhpe@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bob,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v5.17-rc2]
[cannot apply to rdma/for-next next-20220201]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Bob-Pearson/Move-two-object-pools-to-rxe_mcast-c/20220201-061231
base:    26291c54e111ff6ba87a164d85d4a4e134b7315c
config: arm-randconfig-r001-20220131 (https://download.01.org/0day-ci/archive/20220202/202202020207.bxuWR3xX-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6b1e844b69f15bb7dffaf9365cd2b355d2eb7579)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/0day-ci/linux/commit/f9d560658bbbd5a17cc3c62e566cb9bb77697530
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Bob-Pearson/Move-two-object-pools-to-rxe_mcast-c/20220201-061231
        git checkout f9d560658bbbd5a17cc3c62e566cb9bb77697530
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/infiniband/sw/rxe/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/infiniband/sw/rxe/rxe_mcast.c:57:6: warning: no previous prototype for function '__rxe_destroy_mcg' [-Wmissing-prototypes]
   void __rxe_destroy_mcg(struct rxe_mcg *grp)
        ^
   drivers/infiniband/sw/rxe/rxe_mcast.c:57:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __rxe_destroy_mcg(struct rxe_mcg *grp)
   ^
   static 
   1 warning generated.


vim +/__rxe_destroy_mcg +57 drivers/infiniband/sw/rxe/rxe_mcast.c

    55	
    56	/* caller is holding a ref from lookup and mcg->mcg_lock*/
  > 57	void __rxe_destroy_mcg(struct rxe_mcg *grp)
    58	{
    59		rxe_drop_key(grp);
    60		rxe_drop_ref(grp);
    61	
    62		rxe_mcast_delete(grp->rxe, &grp->mgid);
    63	}
    64	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
