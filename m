Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFED4D6B3D
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Mar 2022 01:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiCKX6I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Mar 2022 18:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiCKX6H (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Mar 2022 18:58:07 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C12117CAF
        for <linux-rdma@vger.kernel.org>; Fri, 11 Mar 2022 15:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647043020; x=1678579020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9nw5BpuvJ9CMjQG262SVUYORocmfnCuZMp2zc1UV4Mg=;
  b=Xt5bD32AIXCCdy1nguOB1YOxInhDOXCfxHeI2NZAoAGEgbvnf8wcs8bi
   1SzPC5eHDgaHOEDJnOeTm66i7ItZugFXD7Ni8OM0nz7cTPR5ukhBb9xwQ
   upPF7CAD9oDyAyD5jV8RdoKEVA7eQQooZgUg/UW6ZVItx17bUBWGxR7y1
   KXkTjsNlkyhsTpZvfnn2jQDfNYEM3xTbcbDxMIXs3K4pAW1UCgQvgXTOr
   lYgwoCvfJx0/Z5qKkpBNEF/x6Zmn/vJb9ELkJcUvoBjPEeSgi3Xvmk2ZU
   LGWFU2yUaLevptKvv8KNumD59KB/Yq0P/8a7PwNSbb8eXbWcQbCxwQWzX
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="255865872"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="255865872"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 15:56:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="612305099"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 11 Mar 2022 15:56:57 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSp7w-0007Ho-Bq; Fri, 11 Mar 2022 23:56:56 +0000
Date:   Sat, 12 Mar 2022 07:56:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>, linux-rdma@vger.kernel.org
Cc:     kbuild-all@lists.01.org, yanjun.zhu@linux.dev,
        rpearsonhpe@gmail.com, jgg@nvidia.com, y-goto@fujitsu.com,
        lizhijian@fujitsu.com, tomasz.gromadzki@intel.com, tom@talpey.com,
        ira.weiny@intel.com, Xiao Yang <yangx.jy@fujitsu.com>
Subject: Re: [PATCH v3 2/3] RDMA/rxe: Support RDMA Atomic Write operation
Message-ID: <202203120740.G02NgRLo-lkp@intel.com>
References: <20220311115247.23521-3-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311115247.23521-3-yangx.jy@fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Xiao,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rdma/for-next]
[also build test ERROR on v5.17-rc7 next-20220310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Xiao-Yang/RDMA-rxe-Add-RDMA-Atomic-Write-operation/20220311-195406
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220312/202203120740.G02NgRLo-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/e2d651ea47e6ed9341efeec5b1cb960c5c12f31c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Xiao-Yang/RDMA-rxe-Add-RDMA-Atomic-Write-operation/20220311-195406
        git checkout e2d651ea47e6ed9341efeec5b1cb960c5c12f31c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   In function 'process_atomic_write',
       inlined from 'execute' at drivers/infiniband/sw/rxe/rxe_resp.c:828:9:
>> include/linux/compiler_types.h:346:45: error: call to '__compiletime_assert_463' declared with attribute error: Need native word sized stores/loads for atomicity.
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:327:25: note: in definition of macro '__compiletime_assert'
     327 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:349:9: note: in expansion of macro 'compiletime_assert'
     349 |         compiletime_assert(__native_word(t),                            \
         |         ^~~~~~~~~~~~~~~~~~
   arch/parisc/include/asm/barrier.h:38:9: note: in expansion of macro 'compiletime_assert_atomic_type'
      38 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/sw/rxe/rxe_resp.c:609:9: note: in expansion of macro 'smp_store_release'
     609 |         smp_store_release(dst, *src);
         |         ^~~~~~~~~~~~~~~~~


vim +/__compiletime_assert_463 +346 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  332  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  333  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  334  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  335  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  336  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  337   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  338   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  339   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  340   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  341   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  342   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  343   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  344   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  345  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @346  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  347  

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
