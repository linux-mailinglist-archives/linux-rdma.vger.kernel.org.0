Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD37266E3EE
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 17:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjAQQpY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Jan 2023 11:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjAQQpT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Jan 2023 11:45:19 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE741A48E
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 08:45:17 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id d188so15238340oia.3
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 08:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G+F+r4aQ7FOWiPEjKmDO0YApQXNhGDgLjx2/ZZSd01w=;
        b=FPu2vbVzba9+FffIP31sN+hB4Lic5h29tBrBb34AELKjbXX1rK/nyLlRjCvCFfnDP+
         e/YiHOuX0umadYCExB71CDXunnWOfIgbUjlauKJegpH3sLW5Nj8vHZZCrHA1wGHeCZ2X
         UFui1LD6IdXFoDODlNKMKCnfL/8N9H6SMYzkk3uNWf9+cajeOFiFttUjpw5d/e63Gq1l
         HXa4l8aLQoSa8xh8D0/dOtqA/2D3fBxTro5Dq6HRPcAJAb6jN8XEfg25Xq18W+GNkxNm
         Q+lyQbBeuMpJqfLuOQPHe7mkEMXFkPOOXCByDK+i+ZV7+vIRdsAoH9a2eJ061vpeiFpy
         1L4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G+F+r4aQ7FOWiPEjKmDO0YApQXNhGDgLjx2/ZZSd01w=;
        b=Fen9v0r9xm3ACvsP7wRRtAxdCb3ZPgAX5B6zjC+hYoayDfkUL7mH23qHlE6pgysFAk
         4OQJIviFBwNF9udLYAfCtI982mdjoUmJ4bDracEOjHaNZLYy9fK20AOjNycm8yB9t0Uc
         dIOsZHl+O+aVtFN6kRQRLGINBS5bD8AHcTrh2QNFvimoAo4P8UsSo4PwpPDdmZDarAgk
         HkyrefkJdfZXfqqLui1Rce6ycVq1+BVfBCf3EdK8BL1i2S12noVXHu9xPOsz2g4r8ewe
         HKKQMFfOVkU4UlhJxrvwBtMkg85K4yvdWL3mOtQ2SDIEsCRA4gMSvdL5abE91bpE5sVN
         9C0A==
X-Gm-Message-State: AFqh2kpQgh6eA1Z4acOhrO29SAJlDyIdYfgGZTkM1dDo6JVG3Laj6e2d
        zVQhe9ZgVuaKBWIHLInSKICs1bAtb4yJIw==
X-Google-Smtp-Source: AMrXdXt3Wq9AgTsfDETAzrIwficqdAvsDjwfPwyOCE9BRQB5mUpjVfmC1dworD0pPZiR3OefHHHAXw==
X-Received: by 2002:a05:6808:308a:b0:35e:b08e:165 with SMTP id bl10-20020a056808308a00b0035eb08e0165mr2325993oib.14.1673973916993;
        Tue, 17 Jan 2023 08:45:16 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:ea18:3ee9:26d1:7526? (2603-8081-140c-1a00-ea18-3ee9-26d1-7526.res6.spectrum.com. [2603:8081:140c:1a00:ea18:3ee9:26d1:7526])
        by smtp.gmail.com with ESMTPSA id dz9-20020a056808438900b0035b4b6d1bbfsm14898574oib.28.2023.01.17.08.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 08:45:16 -0800 (PST)
Message-ID: <f7916dca-960c-a722-cd2b-d9b330092670@gmail.com>
Date:   Tue, 17 Jan 2023 10:45:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH for-next v3 4/6] RDMA-rxe: Isolate mr code from
 atomic_write_reply()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     leonro@nvidia.com, linux-rdma@vger.kernel.org
References: <20230113232704.20072-1-rpearsonhpe@gmail.com>
 <20230113232704.20072-5-rpearsonhpe@gmail.com>
 <CAD=hENc4W7ZXCa73oOnKbspf9TeVdZ096AYwHGp-HEtoT+m86g@mail.gmail.com>
 <Y8am/zTHUWDIhBos@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <Y8am/zTHUWDIhBos@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/17/23 07:47, Jason Gunthorpe wrote:
> On Tue, Jan 17, 2023 at 09:36:02AM +0800, Zhu Yanjun wrote:
>> On Sat, Jan 14, 2023 at 7:28 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>>
>>> Isolate mr specific code from atomic_write_reply() in rxe_resp.c into
>>> a subroutine rxe_mr_do_atomic_write() in rxe_mr.c.
>>> Check length for atomic write operation.
>>> Make iova_to_vaddr() static.
>>>
>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>> ---
>>> v3:
>>>   Fixed bug reported by kernel test robot. Ifdef'ed out atomic 8 byte
>>>   write if CONFIG_64BIT is not defined as orignally intended by the
>>>   developers of the atomic write implementation.
>>> link: https://lore.kernel.org/linux-rdma/202301131143.CmoyVcul-lkp@intel.com/
>>>
>>>  drivers/infiniband/sw/rxe/rxe_loc.h  |  1 +
>>>  drivers/infiniband/sw/rxe/rxe_mr.c   | 50 ++++++++++++++++++++++++
>>>  drivers/infiniband/sw/rxe/rxe_resp.c | 58 +++++++++++-----------------
>>>  3 files changed, 73 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
>>> index bcb1bbcf50df..fd70c71a9e4e 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
>>> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
>>> @@ -74,6 +74,7 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
>>>  void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
>>>  int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
>>>                         u64 compare, u64 swap_add, u64 *orig_val);
>>> +int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, void *addr);
>>>  struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
>>>                          enum rxe_mr_lookup_type type);
>>>  int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
>>> index 791731be6067..1e74f5e8e10b 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
>>> @@ -568,6 +568,56 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
>>>         return 0;
>>>  }
>>>
>>> +/**
>>> + * rxe_mr_do_atomic_write() - write 64bit value to iova from addr
>>> + * @mr: memory region
>>> + * @iova: iova in mr
>>> + * @addr: source of data to write
>>> + *
>>> + * Returns:
>>> + *      0 on success
>>> + *     -1 for misaligned address
>>> + *     -2 for access errors
>>> + *     -3 for cpu without native 64 bit support
>>> + */
>>> +int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, void *addr)
>>> +{
>>> +#if defined CONFIG_64BIT
>>
>> IS_ENABLED is better?
> 
> is_enabled won't work here because the code doesn't compile.
> 
> Jason

exactly.
