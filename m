Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159E766A519
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jan 2023 22:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjAMV0b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Jan 2023 16:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjAMV03 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Jan 2023 16:26:29 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27A72DF4
        for <linux-rdma@vger.kernel.org>; Fri, 13 Jan 2023 13:26:27 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-15b9c93848dso15397412fac.1
        for <linux-rdma@vger.kernel.org>; Fri, 13 Jan 2023 13:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nrStFevsF8nwSzFjua9Ts3+pp2fcrAmQzRDTfwMTqh8=;
        b=f02sY3fRUAey5xjrgRvTqFouZ+76pAMV3r2SuH71PNHI3iWAji9tWG53zEISrR0uRk
         Dntp5KKBAovAvocH3FsrcLMnLxeT5u5P1L7VFM/+bvEzvQj7LhcV2kDVBeiUgRnFheOY
         watlWnDFhKF79osuhNQJBjqzBy4rbmlcUAD1vJswagFUEMnwS+MFWY0irD3BquiCnyLW
         9iNLVWZKi/sBVbOpy/zIitdXrV2kP/tc0/9Mhd0DyIYebajHHbvebhh+Dk38V5iosl+H
         1bhyvLNoFT3VxBmZEp7B7gAvCvrSw1oKU86mrZ2etysRyzqTjCzQ62K9hwYSWvwPz7K1
         pMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nrStFevsF8nwSzFjua9Ts3+pp2fcrAmQzRDTfwMTqh8=;
        b=xl/VD9FRZXJ+u6j3U2TO7Pf6b0dy+vBxFclLyYM98T2wtYp8TZX/ao0iPOHSPnr/69
         UWDEdj9HuasT6N/nWvBcolEfbPd7sOdBg1yrFnZgTrZDqW7MUepMYsN+MG3nxDmCbqgr
         G8fRZI6Uvj66iQD4HNq/idOxHsePO+kGWj7w43H9UHlE322kRmhL7QXE6gzqWUe1Gthj
         pMpI3Ns4tyRyzTtvcn3w2aW0VzlFckc6GQjhTMi2/YVFS+lhyh/IaTMxilu0Xw+hAXaY
         OLa6wQmo/amFUfX6bvErp/3LSeuUAN8n/bzWc+onBXyL+zqn21dz0FGhFBecukhrbkSx
         AOmA==
X-Gm-Message-State: AFqh2kpdFJXbvw2vtGmQraJOZUBfghuVN3Xiynp60rUVK0sO8tGLsAfv
        XMzSJoV0FcgG8qGr7aSIIus70e0HkjIjsA==
X-Google-Smtp-Source: AMrXdXtQNBuYN16dvWDDNuXCFVemaLMj/x673/6jajYaFQQLKhXjypO36EMjlVhswLTsSpSeTrFLeg==
X-Received: by 2002:a05:6870:d624:b0:143:5000:9cc9 with SMTP id a36-20020a056870d62400b0014350009cc9mr47215639oaq.22.1673645186542;
        Fri, 13 Jan 2023 13:26:26 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:3f47:8433:ec70:f475? (2603-8081-140c-1a00-3f47-8433-ec70-f475.res6.spectrum.com. [2603:8081:140c:1a00:3f47:8433:ec70:f475])
        by smtp.gmail.com with ESMTPSA id m11-20020a056820034b00b004f219b998eesm4791414ooe.43.2023.01.13.13.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 13:26:25 -0800 (PST)
Message-ID: <53e4292f-8fff-a250-69b5-95338a294b6d@gmail.com>
Date:   Fri, 13 Jan 2023 15:26:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH for-next v2 4/6] RDMA-rxe: Isolate mr code from
 atomic_write_reply()
To:     jgg@nvidia.com, linux-rdma@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
References: <20230113002116.457324-5-rpearsonhpe@gmail.com>
 <202301131143.CmoyVcul-lkp@intel.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <202301131143.CmoyVcul-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/12/23 21:43, kernel test robot wrote:
> Hi Bob,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on bd99ede8ef2dc03e29a181b755ba4f78da2644e6]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Bob-Pearson/RDMA-rxe-Cleanup-mr_check_range/20230113-082406
> base:   bd99ede8ef2dc03e29a181b755ba4f78da2644e6
> patch link:    https://lore.kernel.org/r/20230113002116.457324-5-rpearsonhpe%40gmail.com
> patch subject: [PATCH for-next v2 4/6] RDMA-rxe: Isolate mr code from atomic_write_reply()
> config: powerpc-allmodconfig
> compiler: powerpc-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/c7e5c2723da0d6b13e37cbff63dad653e5c8801c
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Bob-Pearson/RDMA-rxe-Cleanup-mr_check_range/20230113-082406
>         git checkout c7e5c2723da0d6b13e37cbff63dad653e5c8801c
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/infiniband/sw/rxe/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from <command-line>:
>    drivers/infiniband/sw/rxe/rxe_mr.c: In function 'rxe_mr_do_atomic_write':
>>> include/linux/compiler_types.h:358:45: error: call to '__compiletime_assert_870' declared with attribute error: Need native word sized stores/loads for atomicity.

Jason,
	Does this mean that powerpc doesn't support u64 as a native type? Perhaps this is
	why the Fujitsu folks used CONFIG_64BIT in the atomic write patch which seemed a
	little strange.
Bob


>      358 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |                                             ^
>    include/linux/compiler_types.h:339:25: note: in definition of macro '__compiletime_assert'
>      339 |                         prefix ## suffix();                             \
>          |                         ^~~~~~
>    include/linux/compiler_types.h:358:9: note: in expansion of macro '_compiletime_assert'
>      358 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:361:9: note: in expansion of macro 'compiletime_assert'
>      361 |         compiletime_assert(__native_word(t),                            \
>          |         ^~~~~~~~~~~~~~~~~~
>    arch/powerpc/include/asm/barrier.h:74:9: note: in expansion of macro 'compiletime_assert_atomic_type'
>       74 |         compiletime_assert_atomic_type(*p);                             \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/asm-generic/barrier.h:172:55: note: in expansion of macro '__smp_store_release'
>      172 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
>          |                                                       ^~~~~~~~~~~~~~~~~~~
>    drivers/infiniband/sw/rxe/rxe_mr.c:605:9: note: in expansion of macro 'smp_store_release'
>      605 |         smp_store_release(vaddr, value);
>          |         ^~~~~~~~~~~~~~~~~
> 
> 
> vim +/__compiletime_assert_870 +358 include/linux/compiler_types.h
> 
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  344  
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  345  #define _compiletime_assert(condition, msg, prefix, suffix) \
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  346  	__compiletime_assert(condition, msg, prefix, suffix)
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  347  
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  348  /**
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  349   * compiletime_assert - break build and emit msg if condition is false
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  350   * @condition: a compile-time constant condition to check
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  351   * @msg:       a message to emit if condition is false
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  352   *
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  353   * In tradition of POSIX assert, this macro will break the build if the
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  354   * supplied condition is *false*, emitting the supplied error message if the
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  355   * compiler has support to do so.
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  356   */
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  357  #define compiletime_assert(condition, msg) \
> eb5c2d4b45e3d2 Will Deacon 2020-07-21 @358  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  359  
> 

