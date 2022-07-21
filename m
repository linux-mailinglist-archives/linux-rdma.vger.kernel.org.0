Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864A157D6C5
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jul 2022 00:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiGUWTT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jul 2022 18:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbiGUWTL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jul 2022 18:19:11 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB07015A3B
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jul 2022 15:19:10 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id l9-20020a056830268900b006054381dd35so2197967otu.4
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jul 2022 15:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FsRwVidl3qW95/gHbeOWe0iF4qd+2MWyG/8yMDZ9goE=;
        b=CotBAYtWmAaf1odoiDWiBQbU3lj8M6L8M5l54V50TPCihF9I2l65fu8O0if5P3iVg8
         k/cztIJnrw+MoycEE6BDp+sUpGvwH3IduhUJrEqRmJ4YqbUFZTc2lWF/1ee6e9B23zrk
         mAk9ohHZdnzCkkdl8mGdbeny//hPpWYOEJl+TZ85wKfpA6wnQU3uUvxZtvt5z/J2XrMS
         NWCGElRRmiYaMSKE+PGA4VM3aQx5QqPuawQSA/jflHVQc41Xrp1ko3tcFpITvppIHg1x
         2b8E/Rlu6gcJawn3DxBhS4Phk4Lk4shbWTNZytFaqeJB1OKnx3GpAr+sOhNy/4FOKoeu
         7e7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FsRwVidl3qW95/gHbeOWe0iF4qd+2MWyG/8yMDZ9goE=;
        b=s8XdRNl6ubqkn/TO2RYj5L0TxHSYSVFS/c42tiFP8GGLs3VgZuoKbMbpVZEThpaECO
         bgcbgPvQHGQJRy/uN29/AkCOIXGdipSo20mItivAHD56DvDeqSVm7nCCL7ra1+jT8C4P
         iJuBP5FUkyF18OvoEifsINTAjI6MygKXtL4/FnwzY8LIrej8lTGd8yfJw6a/kDzHkWC4
         WtWGnA9yjA7PciNHpIESS1SxyF99VlY65O4vF4dDeAzXyr3B4eSj1REBZugC4gMAg0rh
         7Xx3tMYvAvhusLPn0yIers+vzW+PL7qcE+7af+OVnpULOgsL7+RFt/pbCxeugWJqaFn+
         r2UQ==
X-Gm-Message-State: AJIora8tNe2V3HxaW3DgtdGuvZ6KefL4ychdlWcUv6M0orT5AVs4krKy
        rCAXw31FyDbjDCP5tKXLAvg=
X-Google-Smtp-Source: AGRyM1uhi4OyfFLC3YMJex24CQFKZ9GVqL9/XkM15FnMxl2I+NGdFeWdPZf2LzT+SZOIGgd28GzjKQ==
X-Received: by 2002:a9d:6c43:0:b0:61c:9d1e:b43e with SMTP id g3-20020a9d6c43000000b0061c9d1eb43emr227339otq.365.1658441950291;
        Thu, 21 Jul 2022 15:19:10 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:26e5:db00:e7ca:8ba1? (2603-8081-140c-1a00-26e5-db00-e7ca-8ba1.res6.spectrum.com. [2603:8081:140c:1a00:26e5:db00:e7ca:8ba1])
        by smtp.gmail.com with ESMTPSA id h1-20020a9d2f01000000b0061c2f9b3b6esm1315734otb.32.2022.07.21.15.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 15:19:09 -0700 (PDT)
Message-ID: <318d02a4-8028-551c-5cda-e7934153e03d@gmail.com>
Date:   Thu, 21 Jul 2022 17:19:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND RFC PATCH for-next] Revert "RDMA/rxe: Create duplicate
 mapping tables for FMRs"
Content-Language: en-US
To:     Haris Iqbal <haris.iqbal@ionos.com>,
        Li Zhijian <lizhijian@fujitsu.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>
References: <1658312958-13-1-git-send-email-lizhijian@fujitsu.com>
 <CAJpMwyier2gtHoMhkrFeNXmqjUo9ab2Ba4Ef_YZoCwv__9cz=Q@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <CAJpMwyier2gtHoMhkrFeNXmqjUo9ab2Ba4Ef_YZoCwv__9cz=Q@mail.gmail.com>
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

On 7/20/22 05:50, Haris Iqbal wrote:
> On Wed, Jul 20, 2022 at 12:22 PM Li Zhijian <lizhijian@fujitsu.com> wrote:
>>
>> Below 2 commits will be reverted:
>>      8ff5f5d9d8cf ("RDMA/rxe: Prevent double freeing rxe_map_set()")
>>      647bf13ce944 ("RDMA/rxe: Create duplicate mapping tables for FMRs")
>>
>> The community has a few bug reports which pointed this commit at last.
>> Some proposals are raised up in the meantime but all of them have no
>> follow-up operation.
>>
>> The previous commit led the map_set of FMR to be not avaliable any more if
>> the MR is registered again after invalidating. Although the mentioned
>> patch try to fix a potential race in building/accessing the same table
>> for fast memory regions, it broke rnbd etc ULPs. Since the latter could
>> be worse, revert this patch.
>>
>> With previous commit, it's observed that a same MR in rnbd server will
>> trigger below code path:
> 
> Looks Good. I tested the patch against rdma for-next and it solves the
> problem mentioned in the commit.
> One small nitpick. It should be rtrs, and not rnbd in the commit message.
> 
> Feel free to add my,
> 
> Tested-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> 
>>  -> rxe_mr_init_fast()
>>  |-> alloc map_set() # map_set is uninitialized
>>  |...-> rxe_map_mr_sg() # build the map_set
>>      |-> rxe_mr_set_page()
>>  |...-> rxe_reg_fast_mr() # mr->state change to VALID from FREE that means
>>                           # we can access host memory(such rxe_mr_copy)
>>  |...-> rxe_invalidate_mr() # mr->state change to FREE from VALID
>>  |...-> rxe_reg_fast_mr() # mr->state change to VALID from FREE,
>>                           # but map_set was not built again
>>  |...-> rxe_mr_copy() # kernel crash due to access wild addresses
>>                       # that lookup from the map_set
>>

Where is the use case for this? All the FMR examples I am aware of call rxe_map_mr_sg()
between each reg_fast_mr/invalidate_mr() sequence. I am not familiar with rtrs.
What is it?

Bob
