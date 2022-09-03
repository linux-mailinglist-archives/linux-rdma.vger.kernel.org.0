Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415E75ABCB7
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Sep 2022 06:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiICEEV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 3 Sep 2022 00:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiICEEU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 3 Sep 2022 00:04:20 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A9F120A3
        for <linux-rdma@vger.kernel.org>; Fri,  2 Sep 2022 20:54:31 -0700 (PDT)
Subject: Re: [PATCH 3/3] RDMA/rtrs-clt: Kill xchg_paths
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662177269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2oKlpZuSoAcoai98ZQn5OpWkjNBi4K5GklWzXK8RLwk=;
        b=o5L8VdXwec2XITcnvvqZJMPvBZCiSgDnOfme+BdUvx9Hy9pSAsw8LdOy96/+OWyLwhchf7
        hUzpBbTScOGB/rBtgEKl6M2W6ZlvYCA9YR6cwkHXeSdII4UVA0sPcYYONx2DKZYxXLPS1O
        28V6P7AxkChvUYyx2WwbQFPRa0PiCZE=
To:     kernel test robot <lkp@intel.com>, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, jgg@ziepe.ca, leon@kernel.org
Cc:     kbuild-all@lists.01.org, linux-rdma@vger.kernel.org
References: <20220902101922.26273-4-guoqing.jiang@linux.dev>
 <202209030331.GmBYWKZb-lkp@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <1ac63952-ad51-7d6c-1776-689f3686a23a@linux.dev>
Date:   Sat, 3 Sep 2022 11:54:24 +0800
MIME-Version: 1.0
In-Reply-To: <202209030331.GmBYWKZb-lkp@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 9/3/22 3:15 AM, kernel test robot wrote:
> Hi Guoqing,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on rdma/for-next]
> [also build test ERROR on linus/master v6.0-rc3 next-20220901]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Guoqing-Jiang/misc-changes-for-rtrs/20220902-182137
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> config: parisc64-allmodconfig (https://download.01.org/0day-ci/archive/20220903/202209030331.GmBYWKZb-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/1cb28fde63a272543476132ec83f6eb121111fae
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Guoqing-Jiang/misc-changes-for-rtrs/20220902-182137
>          git checkout 1cb28fde63a272543476132ec83f6eb121111fae
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/infiniband/ulp/rtrs/
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>     In file included from include/linux/atomic.h:80,
>                      from arch/parisc/include/asm/bitops.h:13,
>                      from include/linux/bitops.h:67,
>                      from include/linux/log2.h:12,
>                      from include/asm-generic/div64.h:55,
>                      from ./arch/parisc/include/generated/asm/div64.h:1,
>                      from include/linux/math.h:6,
>                      from include/linux/math64.h:6,
>                      from include/linux/time.h:6,
>                      from include/linux/stat.h:19,
>                      from include/linux/module.h:13,
>                      from drivers/infiniband/ulp/rtrs/rtrs-clt.c:13:
>     drivers/infiniband/ulp/rtrs/rtrs-clt.c: In function 'rtrs_clt_remove_path_from_arr':
>>> include/linux/atomic/atomic-arch-fallback.h:90:34: error: initialization of 'struct rtrs_clt_path **' from incompatible pointer type 'struct rtrs_clt_path *' [-Werror=incompatible-pointer-types]
>        90 |         typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
>           |                                  ^
>     include/linux/atomic/atomic-instrumented.h:1978:9: note: in expansion of macro 'arch_try_cmpxchg'
>      1978 |         arch_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>           |         ^~~~~~~~~~~~~~~~
>     drivers/infiniband/ulp/rtrs/rtrs-clt.c:2297:21: note: in expansion of macro 'try_cmpxchg'
>      2297 |                 if (try_cmpxchg((typeof(ppcpu_path))ppcpu_path, clt_path, next))
>           |                     ^~~~~~~~~~~
>     cc1: some warnings being treated as errors

My bad, thanks for the report!

Guoqing
