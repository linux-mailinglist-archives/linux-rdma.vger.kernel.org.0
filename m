Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAE94A546A
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Feb 2022 02:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiBABEH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jan 2022 20:04:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:48249 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231382AbiBABEH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 31 Jan 2022 20:04:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643677447; x=1675213447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7lr+DTfQgwLBsv/7YtqBNaKGIQpj/h8ENBW6s02i64k=;
  b=eqm2mwEvOlbQ6Ghie8j6I5AnP3ayWhu2k+PPeceKQYZAB3xNXutGUDRJ
   k2Hpkn2QtaZg6ojbnsxDPyvkA0DflrwS7eFJPOChw7ayslJ+6i+yC7AcD
   G5H2Cy/kCpPfSdgi+dEA7b/ZRu7rJSh6f9MVjz2LGd1dT1EhO4dbT7ziE
   Casm6MmYLM11994go1kCTB5yroxBvqWFznkI3FTEUKgJsml3dru1tWo3u
   BMM/fHm5Z1Rw0z+vDd0FBVtuoO+5uwRvn9UwDTiBiWKc5E5CW0vyjzjiC
   VI9kSewuzRKFPQiul9jLdz1nrzi6EKIAXO5rgTJq6Z04wX+n7Gwfw3MZ9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="227569499"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="227569499"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 17:04:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="479424371"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 31 Jan 2022 17:04:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEhaW-000SXW-6T; Tue, 01 Feb 2022 01:04:04 +0000
Date:   Tue, 1 Feb 2022 09:03:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH for-next v10 07/17] RDMA/rxe: Use kzmalloc/kfree for mca
Message-ID: <202202010836.EmoG3Ot8-lkp@intel.com>
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
[also build test WARNING on next-20220131]
[cannot apply to rdma/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Bob-Pearson/Move-two-object-pools-to-rxe_mcast-c/20220201-061231
base:    26291c54e111ff6ba87a164d85d4a4e134b7315c
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20220201/202202010836.EmoG3Ot8-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/f9d560658bbbd5a17cc3c62e566cb9bb77697530
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Bob-Pearson/Move-two-object-pools-to-rxe_mcast-c/20220201-061231
        git checkout f9d560658bbbd5a17cc3c62e566cb9bb77697530
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/infiniband/sw/rxe/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/infiniband/sw/rxe/rxe_mcast.c:57:6: warning: no previous prototype for '__rxe_destroy_mcg' [-Wmissing-prototypes]
      57 | void __rxe_destroy_mcg(struct rxe_mcg *grp)
         |      ^~~~~~~~~~~~~~~~~


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
