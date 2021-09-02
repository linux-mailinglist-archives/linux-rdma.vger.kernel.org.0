Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3223FF456
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Sep 2021 21:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347373AbhIBTtS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 15:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347257AbhIBTtO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Sep 2021 15:49:14 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2A1C061575
        for <linux-rdma@vger.kernel.org>; Thu,  2 Sep 2021 12:48:16 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so3964179otk.9
        for <linux-rdma@vger.kernel.org>; Thu, 02 Sep 2021 12:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IxfL5YWFvxY5PwiHNSm+yYDZ5zvd9SMm/ud6Y9riILc=;
        b=ESN7vQrATm6sc8QN3o4RQ6WNF8n96nQPsU4aEPXM5zPNIEtqH5+BN0nDERCYsg91iw
         wM//RMwr9JQPoUk27J0+MtezQQv6y5+zjqtwdPWQ9jpveio+IMf3anKIY+3Jr0mLJ7gA
         BalzoeBX2FFbfn5k7X0JuMCxh2+MN7VSWW2nHim2TiysK51kp0k1Z6eCaokUP2uzWDbk
         3f2Ox0w2yx7I+eHk9qRgk1XBEjvAD53BllnwHLxb3wdxQ2upJVSuci1ybn5XlGmNqRjI
         TJC5zzXziaFeOJ8Bx+okt4/huHd/28Mg0BFZBnXN/Pi3TJxdeSZsq+4Vs8CDGN8sV+ZT
         naMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IxfL5YWFvxY5PwiHNSm+yYDZ5zvd9SMm/ud6Y9riILc=;
        b=jnEKvgQKBGJ/SzqY/XhzvWmHvr75QTrZWOUF3tqy8QUZGNLJsnmM1tUuDhPgKrNHAv
         4v0Ghvtyx8VrusfSQ+D8Jex/qOvQlZKF1CCGJtB/UDMQF+9K9t1Y5kGMJGrRjZzj/5NK
         N//H4T2Ep8ohz7dW9D+MvZ0bBCcdpHksU3RZCFddy7VstWUyv8QPYQxMXMzzCMZN5LLE
         pEhdVdegQ8JW9LLf1ESduEprx3sLvx9jp+3VdzA0bmWFaPac+pgZhgUEp/98/70UI2yq
         vKZA66hzOqVDAJSz3r1R0gf8XnpuZqKVgNPCl0H6+Pk5pOQxzTAVU/MNBYLYRiq0Fo8H
         0XDw==
X-Gm-Message-State: AOAM531EZtZ+7TCwxF0aeaBu4IAkQQPeqSC4fhlkTTPqZj0cmSJx8y8n
        B1crVXfllN9C7pOe9fZ3uXecJhhGTeY=
X-Google-Smtp-Source: ABdhPJyfrDVq9RA4aCGmF59tenRg5lLUe7vA7URmjaeH4diEjWkXVv6JrXpaCK2koBg8r6vm01VWWQ==
X-Received: by 2002:a9d:6f81:: with SMTP id h1mr4134503otq.242.1630612095491;
        Thu, 02 Sep 2021 12:48:15 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:4eab:3b55:82a2:257? (2603-8081-140c-1a00-4eab-3b55-82a2-0257.res6.spectrum.com. [2603:8081:140c:1a00:4eab:3b55:82a2:257])
        by smtp.gmail.com with ESMTPSA id a15sm515120otq.13.2021.09.02.12.48.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 12:48:15 -0700 (PDT)
Subject: Re: [PATCH v2] providers/rxe: Set the correct value of resid for
 inline data
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     Leon Romanovsky <leon@kernel.org>
References: <20210809150738.150596-1-yangx.jy@fujitsu.com>
 <7279c618-d373-d7ce-c67c-97e519b48e94@gmail.com>
 <CAD=hENc2gt98YyhOC=EsSTsN0=-EZ7Pz1Kht96HYNA+qvdfWyQ@mail.gmail.com>
 <324764c2-4f41-0106-70e0-aaccb3c50c15@gmail.com>
 <6122FAE1.4080306@fujitsu.com> <YSYQ6hLAebrnGow6@unreal>
 <61308B01.9050706@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <819eadbd-9f9d-669f-a552-18a9e434a43a@gmail.com>
Date:   Thu, 2 Sep 2021 14:48:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <61308B01.9050706@fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/2/21 3:27 AM, yangx.jy@fujitsu.com wrote:
> Hi Yanjun, Bob
> 
> Ping. :-)
> 
> Best Regards,
> Xiao Yang
> On 2021/8/25 17:44, Leon Romanovsky wrote:
>> On Mon, Aug 23, 2021 at 01:33:24AM +0000, yangx.jy@fujitsu.com wrote:
>>> Hi Leon,
>>>
>>> Could you review the patch?
>> There is no need, I trust to Zhu's and Bob's review.
>>
>> Thanks
>>
>>> Best Regards,
>>> Xiao Yang
>>> On 2021/8/17 2:52, Bob Pearson wrote:
>>>> On 8/15/21 10:55 PM, Zhu Yanjun wrote:
>>>>> On Sat, Aug 14, 2021 at 6:11 AM Bob Pearson<rpearsonhpe@gmail.com>   wrote:
>>>>>> On 8/9/21 10:07 AM, Xiao Yang wrote:
>>>>>>> Resid indicates the residual length of transmitted bytes but current
>>>>>>> rxe sets it to zero for inline data at the beginning.  In this case,
>>>>>>> request will transmit zero byte to responder wrongly.
>>>>>>>
>>>>>>> Resid should be set to the total length of transmitted bytes at the
>>>>>>> beginning.
>>>>>>>
>>>>>>> Note:
>>>>>>> Just remove the useless setting of resid in init_send_wqe().
>>>>>>>
>>>>>>> Fixes: 1a894ca10105 ("Providers/rxe: Implement ibv_create_qp_ex verb")
>>>>>>> Fixes: 8337db5df125 ("Providers/rxe: Implement memory windows")
>>>>>>> Signed-off-by: Xiao Yang<yangx.jy@fujitsu.com>
>>>>>>> ---
>>>>>>>    providers/rxe/rxe.c | 5 ++---
>>>>>>>    1 file changed, 2 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
>>>>>>> index 3c3ea8bb..3533a325 100644
>>>>>>> --- a/providers/rxe/rxe.c
>>>>>>> +++ b/providers/rxe/rxe.c
>>>>>>> @@ -1004,7 +1004,7 @@ static void wr_set_inline_data(struct ibv_qp_ex *ibqp, void *addr,
>>>>>>>
>>>>>>>         memcpy(wqe->dma.inline_data, addr, length);
>>>>>>>         wqe->dma.length = length;
>>>>>>> -     wqe->dma.resid = 0;
>>>>>>> +     wqe->dma.resid = length;
>>>>>>>    }
>>>>>>>
>>>>>>>    static void wr_set_inline_data_list(struct ibv_qp_ex *ibqp, size_t num_buf,
>>>>>>> @@ -1035,6 +1035,7 @@ static void wr_set_inline_data_list(struct ibv_qp_ex *ibqp, size_t num_buf,
>>>>>>>         }
>>>>>>>
>>>>>>>         wqe->dma.length = tot_length;
>>>>>>> +     wqe->dma.resid = tot_length;
>>>>>>>    }
>>>>>>>
>>>>>>>    static void wr_set_sge(struct ibv_qp_ex *ibqp, uint32_t lkey, uint64_t addr,
>>>>>>> @@ -1473,8 +1474,6 @@ static int init_send_wqe(struct rxe_qp *qp, struct rxe_wq *sq,
>>>>>>>         if (ibwr->send_flags&   IBV_SEND_INLINE) {
>>>>>>>                 uint8_t *inline_data = wqe->dma.inline_data;
>>>>>>>
>>>>>>> -             wqe->dma.resid = 0;
>>>>>>> -
>>>>>>>                 for (i = 0; i<   num_sge; i++) {
>>>>>>>                         memcpy(inline_data,
>>>>>>>                                (uint8_t *)(long)ibwr->sg_list[i].addr,
>>>>>>>
>>>>>> Signed-off-by: Bob Pearson<rpearsonhpe@gmail.com>
>>>>> The Signed-off-by: tag indicates that the signer was involved in the
>>>>> development of the patch, or that he/she was in the patch’s delivery
>>>>> path.
>>>>>
>>>>> Zhu Yanjun
>>>>>
>>>> Sorry, my misunderstanding. Then I want to say
>>>>
>>>> Reviewed-by: Bob Pearson<rpearsonhpe@gmail.com>
>>>>
>>>> The patch looks correct to me.

Hi,

What are you looking for? I reviewed the patch (above) and agree with you that it makes sense.
But it's not up to me to accept it. That would be Jason or Zhu.

BTW until this is fixed I it looks like inline WRs are broken for the extended QP API.

Bob
