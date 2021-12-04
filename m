Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD32468232
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Dec 2021 04:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384176AbhLDDzH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Dec 2021 22:55:07 -0500
Received: from mga06.intel.com ([134.134.136.31]:52314 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344410AbhLDDzH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 3 Dec 2021 22:55:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="297891522"
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="297891522"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 19:51:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="678323939"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 03 Dec 2021 19:51:30 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtM5B-000IQt-TY; Sat, 04 Dec 2021 03:51:29 +0000
Date:   Sat, 4 Dec 2021 11:50:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH v5 for-next 8/8] RDMA/rxe: Add wait for completion to obj
 destruct
Message-ID: <202112041120.xhWkLnk3-lkp@intel.com>
References: <20211202232035.62299-9-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202232035.62299-9-rpearsonhpe@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bob,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on next-20211203]
[cannot apply to v5.16-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Bob-Pearson/RDMA-rxe-Correct-race-conditions/20211203-072318
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
config: riscv-buildonly-randconfig-r002-20211203 (https://download.01.org/0day-ci/archive/20211204/202112041120.xhWkLnk3-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d30fcadf07ee552f20156ea90be2fdb54cb9cb08)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/0day-ci/linux/commit/c12d68c6954d3274daefc01f9813fccec12a31bd
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Bob-Pearson/RDMA-rxe-Correct-race-conditions/20211203-072318
        git checkout c12d68c6954d3274daefc01f9813fccec12a31bd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/ata/ drivers/infiniband/sw/rxe/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/infiniband/sw/rxe/rxe_pool.c:387: warning: expecting prototype for rxe_elem_free(). Prototype was for __rxe_fini() instead


vim +387 drivers/infiniband/sw/rxe/rxe_pool.c

   381	
   382	/**
   383	 * rxe_elem_free() - free memory holding pool element
   384	 * @elem: the pool elem
   385	 */
   386	void __rxe_fini(struct rxe_pool_elem *elem)
 > 387	{

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
