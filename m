Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E263E5AB8C7
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Sep 2022 21:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiIBTQW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Sep 2022 15:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIBTQV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Sep 2022 15:16:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A172871B
        for <linux-rdma@vger.kernel.org>; Fri,  2 Sep 2022 12:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662146180; x=1693682180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5UQGGp6qhyGi26kiVY2gy/Acet61+ruqlv08GiDqyH4=;
  b=cqkb5ySm/Q8c36oheI0CwMvqQcdQDSf0COUt8TEvSiFbP5k8aGMePcRV
   lfbppNUpEKLQlGNxvEbZhKKgqJI75s4R4lNfnR57Rj4plPFqveXYRYaON
   HyEHGRribJPzjegdMoFtSTVfx0dT9K1NSjDc2qv+xGNaeUbJpohlB5gM2
   IWTyLIuFkhJDXM61eYTJFhFry3NGvND2P5fxlmeXVwxgvCsannOaH+DoF
   Dhz5IQf+VqWASMoaHlkcbgFG18he413Jpd8qcafSXJvfxgA8CSHjewbxS
   ztu1uRnXDHTuUeC3yzQJ3VVK7KJ2CPs9zIk/FGP8RhpaH0/WGpQw3Fy/g
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="279081136"
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="279081136"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 12:16:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="646216902"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 02 Sep 2022 12:16:18 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUC9J-0000VJ-1M;
        Fri, 02 Sep 2022 19:16:17 +0000
Date:   Sat, 3 Sep 2022 03:15:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, jgg@ziepe.ca, leon@kernel.org
Cc:     kbuild-all@lists.01.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 3/3] RDMA/rtrs-clt: Kill xchg_paths
Message-ID: <202209030331.GmBYWKZb-lkp@intel.com>
References: <20220902101922.26273-4-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902101922.26273-4-guoqing.jiang@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Guoqing,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rdma/for-next]
[also build test ERROR on linus/master v6.0-rc3 next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guoqing-Jiang/misc-changes-for-rtrs/20220902-182137
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
config: parisc64-allmodconfig (https://download.01.org/0day-ci/archive/20220903/202209030331.GmBYWKZb-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1cb28fde63a272543476132ec83f6eb121111fae
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Guoqing-Jiang/misc-changes-for-rtrs/20220902-182137
        git checkout 1cb28fde63a272543476132ec83f6eb121111fae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/infiniband/ulp/rtrs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/atomic.h:80,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:67,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from ./arch/parisc/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/math64.h:6,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/infiniband/ulp/rtrs/rtrs-clt.c:13:
   drivers/infiniband/ulp/rtrs/rtrs-clt.c: In function 'rtrs_clt_remove_path_from_arr':
>> include/linux/atomic/atomic-arch-fallback.h:90:34: error: initialization of 'struct rtrs_clt_path **' from incompatible pointer type 'struct rtrs_clt_path *' [-Werror=incompatible-pointer-types]
      90 |         typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
         |                                  ^
   include/linux/atomic/atomic-instrumented.h:1978:9: note: in expansion of macro 'arch_try_cmpxchg'
    1978 |         arch_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
         |         ^~~~~~~~~~~~~~~~
   drivers/infiniband/ulp/rtrs/rtrs-clt.c:2297:21: note: in expansion of macro 'try_cmpxchg'
    2297 |                 if (try_cmpxchg((typeof(ppcpu_path))ppcpu_path, clt_path, next))
         |                     ^~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +90 include/linux/atomic/atomic-arch-fallback.h

29f006fdefe6f8 include/linux/atomic-arch-fallback.h Peter Zijlstra 2020-08-29  86  
29f006fdefe6f8 include/linux/atomic-arch-fallback.h Peter Zijlstra 2020-08-29  87  #ifndef arch_try_cmpxchg
29f006fdefe6f8 include/linux/atomic-arch-fallback.h Peter Zijlstra 2020-08-29  88  #define arch_try_cmpxchg(_ptr, _oldp, _new) \
29f006fdefe6f8 include/linux/atomic-arch-fallback.h Peter Zijlstra 2020-08-29  89  ({ \
29f006fdefe6f8 include/linux/atomic-arch-fallback.h Peter Zijlstra 2020-08-29 @90  	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
29f006fdefe6f8 include/linux/atomic-arch-fallback.h Peter Zijlstra 2020-08-29  91  	___r = arch_cmpxchg((_ptr), ___o, (_new)); \
29f006fdefe6f8 include/linux/atomic-arch-fallback.h Peter Zijlstra 2020-08-29  92  	if (unlikely(___r != ___o)) \
29f006fdefe6f8 include/linux/atomic-arch-fallback.h Peter Zijlstra 2020-08-29  93  		*___op = ___r; \
29f006fdefe6f8 include/linux/atomic-arch-fallback.h Peter Zijlstra 2020-08-29  94  	likely(___r == ___o); \
29f006fdefe6f8 include/linux/atomic-arch-fallback.h Peter Zijlstra 2020-08-29  95  })
29f006fdefe6f8 include/linux/atomic-arch-fallback.h Peter Zijlstra 2020-08-29  96  #endif /* arch_try_cmpxchg */
29f006fdefe6f8 include/linux/atomic-arch-fallback.h Peter Zijlstra 2020-08-29  97  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
