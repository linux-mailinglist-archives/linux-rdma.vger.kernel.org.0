Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AE63EDD57
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Aug 2021 20:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhHPSxQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Aug 2021 14:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhHPSxP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Aug 2021 14:53:15 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088A7C061764
        for <linux-rdma@vger.kernel.org>; Mon, 16 Aug 2021 11:52:44 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id t1-20020a4a54010000b02902638ef0f883so5205119ooa.11
        for <linux-rdma@vger.kernel.org>; Mon, 16 Aug 2021 11:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YnVHJLf7ZCaatmtlUyKXqDSI6TtcsykmP0ZdNamnfKE=;
        b=qarLtztox3jva6k3zNsUbCrYfqkG8cx1kRdNMAEcKrKqFe1bI0IMrc+q5p+R/pBWuY
         mjY89xtg+QjoYwNECpMm2SkzV3QCSZga1edAIPCMr/b2yYmVVSUKxJzSfJl3AGKoOTOd
         P2OGnux9Wu6vVy//i0ngsEnxIbHulHVzoyMZw/ilyT6eXAB92SkvyQ1ZxQhyC6vwMcOm
         0dB73ZjsfiJgyMcJLPL3F6zM7Zw2jJHkoYU1hFdYViVhbSmpyId4JtI0dJ93fRuHUqNb
         4sxTvQtnO0aY2w+sSWExtn344jadSwJ6uw+s7nqbJqD6WUlG2NHEI7AMjXXjLgLX8TSI
         aIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YnVHJLf7ZCaatmtlUyKXqDSI6TtcsykmP0ZdNamnfKE=;
        b=RNHH7Fx1B3vvaxD8u9+XpseJsUgbITmnPUaCPbA2VGTlCjDjpOMNqMaZoM01OpX2gP
         Ko1ci6qe6+Y41QrcqJB5HI/O/INrDTXg0OmIcashY4LjI5vKmocym5DVRGpqrOESjBbp
         KHOvz7e2haeBOehjMXLKKTNQeCeEAS44Z6gXCUnJ0psh3IW/TMs6MIf0qUkFqlzRATYD
         ZFAnuJfb47rBqJicHiR62zApuuBlpycTr74Iqq+KeRuJNuvqDvrB09DAdX3RV1i8/Zt5
         Im9eEaU4e1Ardsga5RNP/LCoD68cUCfrA+2yzbVDxKVlkntSlzFw30OPXsAqxFd6T9ol
         3rXw==
X-Gm-Message-State: AOAM533v0etmsyJII0xAC/oAfDXE4il03A6D/UjrxoxO/uefpQYBy/0T
        Gbi4GoqNDJYA7nNpDbGaXWQ=
X-Google-Smtp-Source: ABdhPJzwnuu3becjTqw9NO7A9fcElxewn77Dn5p/TKe7XAotZUNtI+JZJVAFRP3n1Rd+9rHIQKtJ0g==
X-Received: by 2002:a4a:d2c7:: with SMTP id j7mr12543179oos.24.1629139963419;
        Mon, 16 Aug 2021 11:52:43 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:f296:ccb:d9e6:82b0? (2603-8081-140c-1a00-f296-0ccb-d9e6-82b0.res6.spectrum.com. [2603:8081:140c:1a00:f296:ccb:d9e6:82b0])
        by smtp.gmail.com with ESMTPSA id i1sm32114ooo.15.2021.08.16.11.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 11:52:43 -0700 (PDT)
Subject: Re: [PATCH v2] providers/rxe: Set the correct value of resid for
 inline data
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Xiao Yang <yangx.jy@fujitsu.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20210809150738.150596-1-yangx.jy@fujitsu.com>
 <7279c618-d373-d7ce-c67c-97e519b48e94@gmail.com>
 <CAD=hENc2gt98YyhOC=EsSTsN0=-EZ7Pz1Kht96HYNA+qvdfWyQ@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <324764c2-4f41-0106-70e0-aaccb3c50c15@gmail.com>
Date:   Mon, 16 Aug 2021 13:52:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAD=hENc2gt98YyhOC=EsSTsN0=-EZ7Pz1Kht96HYNA+qvdfWyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/15/21 10:55 PM, Zhu Yanjun wrote:
> On Sat, Aug 14, 2021 at 6:11 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> On 8/9/21 10:07 AM, Xiao Yang wrote:
>>> Resid indicates the residual length of transmitted bytes but current
>>> rxe sets it to zero for inline data at the beginning.  In this case,
>>> request will transmit zero byte to responder wrongly.
>>>
>>> Resid should be set to the total length of transmitted bytes at the
>>> beginning.
>>>
>>> Note:
>>> Just remove the useless setting of resid in init_send_wqe().
>>>
>>> Fixes: 1a894ca10105 ("Providers/rxe: Implement ibv_create_qp_ex verb")
>>> Fixes: 8337db5df125 ("Providers/rxe: Implement memory windows")
>>> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
>>> ---
>>>  providers/rxe/rxe.c | 5 ++---
>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
>>> index 3c3ea8bb..3533a325 100644
>>> --- a/providers/rxe/rxe.c
>>> +++ b/providers/rxe/rxe.c
>>> @@ -1004,7 +1004,7 @@ static void wr_set_inline_data(struct ibv_qp_ex *ibqp, void *addr,
>>>
>>>       memcpy(wqe->dma.inline_data, addr, length);
>>>       wqe->dma.length = length;
>>> -     wqe->dma.resid = 0;
>>> +     wqe->dma.resid = length;
>>>  }
>>>
>>>  static void wr_set_inline_data_list(struct ibv_qp_ex *ibqp, size_t num_buf,
>>> @@ -1035,6 +1035,7 @@ static void wr_set_inline_data_list(struct ibv_qp_ex *ibqp, size_t num_buf,
>>>       }
>>>
>>>       wqe->dma.length = tot_length;
>>> +     wqe->dma.resid = tot_length;
>>>  }
>>>
>>>  static void wr_set_sge(struct ibv_qp_ex *ibqp, uint32_t lkey, uint64_t addr,
>>> @@ -1473,8 +1474,6 @@ static int init_send_wqe(struct rxe_qp *qp, struct rxe_wq *sq,
>>>       if (ibwr->send_flags & IBV_SEND_INLINE) {
>>>               uint8_t *inline_data = wqe->dma.inline_data;
>>>
>>> -             wqe->dma.resid = 0;
>>> -
>>>               for (i = 0; i < num_sge; i++) {
>>>                       memcpy(inline_data,
>>>                              (uint8_t *)(long)ibwr->sg_list[i].addr,
>>>
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> 
> The Signed-off-by: tag indicates that the signer was involved in the
> development of the patch, or that he/she was in the patch’s delivery
> path.
> 
> Zhu Yanjun
> 

Sorry, my misunderstanding. Then I want to say

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>

The patch looks correct to me.
