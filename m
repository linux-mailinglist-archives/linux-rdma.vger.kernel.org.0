Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465995272DD
	for <lists+linux-rdma@lfdr.de>; Sat, 14 May 2022 18:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbiENQWk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 14 May 2022 12:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiENQWj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 14 May 2022 12:22:39 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE0127FFD
        for <linux-rdma@vger.kernel.org>; Sat, 14 May 2022 09:22:38 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w123so13737709oiw.5
        for <linux-rdma@vger.kernel.org>; Sat, 14 May 2022 09:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Xv1v+MjmyV1NGwAYXYU+lcwje05VSUkR0+vaUF07Ua4=;
        b=GIzh4ZN8tT/YYNbH9MOKvpLWN7vW2S7tiuLwukmKI/rcxGD3rxlyy66nPvjkMJrECq
         6PSVT+GyKpNqEadJxYuPLEvW6Pk1TaTzHTXbS53QuXmDx5Ri2oCc+YFLVD44ZLZ1sIBZ
         NHxSg7EckTVEHkOOxpJ1I5I9os0CFz1FA6Mxj671CWBXxwaQ8plt7q9KPi4ktIu2QOMM
         kdmj/s9w6M3orGEvr1wGt8K3mB1i/6IQJBTHSdaOMO/ZET52iH9whqjkNjSCOHWM9alj
         1XC8mMu39y4aDZPJD97SH8O9hMvej3jqj127hnHbJg3BcOBUGt56x0ds497AqQTlhCkE
         jCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xv1v+MjmyV1NGwAYXYU+lcwje05VSUkR0+vaUF07Ua4=;
        b=VVm7nQk6DU1V+fmf0o4rB1RzOFN08G9nUSdxhWbq8X4Gr1FYbbmO5oEenAmEIWv1NL
         qIOU6IYa/v99tp1Qphp9qhvYeP6eRAL5/cOIOoGh7hMz/OHxVtotWz24j5on4RvvImcd
         K6udtrzkrbiOdC0hWqCGMP38+lpZzAN+VdTQuWbtqOBJ7oUZuhEz3USLRE/0I0tM59r3
         RkKVxLYCrjTWpZB9NLnpw54NlCaurqhnW52lx2CbwPGkipFDqg+xm5BYOz4BxxJvmP5U
         3hp4ABoLYSCvtKtZSppFIeyklPDlDuImKjZM8c29NWeUxyoQlanTgNKET21kOhUk2fIg
         QBYw==
X-Gm-Message-State: AOAM530P1+SN4p8eiczknbiHjVtRSrujcdSPADsjQTybQ0VHEftbMK70
        +BCD+zjUWudekHWTp7aYTSZ3j0CHqmg=
X-Google-Smtp-Source: ABdhPJx3AhIhknElMeXW8QDWYKSOGnn7/mNHKICYuB3wuIT3oG7MDd1/rszAj3e1jcSTWXTwUcpMyg==
X-Received: by 2002:a05:6808:178b:b0:326:d02b:3add with SMTP id bg11-20020a056808178b00b00326d02b3addmr4593574oib.34.1652545357352;
        Sat, 14 May 2022 09:22:37 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:7fc0:37e:f57e:caea? (2603-8081-140c-1a00-7fc0-037e-f57e-caea.res6.spectrum.com. [2603:8081:140c:1a00:7fc0:37e:f57e:caea])
        by smtp.gmail.com with ESMTPSA id e2-20020a4ada02000000b0035eb4e5a6c0sm2387615oou.22.2022.05.14.09.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 09:22:37 -0700 (PDT)
Message-ID: <64bb14e5-2511-e78f-8618-d1877cc856bb@gmail.com>
Date:   Sat, 14 May 2022 11:22:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Question about AETH_NAK_PSN_SEQ_ERROR
Content-Language: en-US
To:     Chengguang Xu <cgxu519@mykernel.net>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <2eeb36ab-0f4d-fc9a-44a6-9b6bfa2f7970@mykernel.net>
 <7f51a1c8-757f-21c2-cf8d-fd91b5e26563@mykernel.net>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <7f51a1c8-757f-21c2-cf8d-fd91b5e26563@mykernel.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/14/22 09:20, Chengguang Xu wrote:
> 
> 在 2022/5/14 21:35, Chengguang Xu 写道:
>> Hello Folks,
>>
>>
>> There is a logic(below code) in check_ack() in rxe_comp.c,  the case (AETH_NAK_PSN_SEQ_ERROR)
>> indicates sending side received a nak ack which means opposite side had an psn seq error(expected psn < received psn).
>> I don't fully understand the comment(/* a nak implicitly acks all packets with psns before */) here,
>> could someone give me a hint for this?

For a start go to

https://www.infinibandta.org/ibta-specification/

and follow the directions to get access to the InfiniBand Architecture Specification Vol. 1. It should be
free but you have to provide contact information. Unless your company is a member of the IBTA.

If you already have access then look at IBA 9.7.5.1.2 Coalesced Acknowledge Messages.

Any response carrying a packet sequence number implicitly acks all request packets with
a PSN smaller than the one carried in the response packet. It may ack or nak the request packet
with the same psn.

> 
> Carefully checking rxe_resp.c and found the psn in the ack (with AETH_NAK_PSN_SEQ_ERROR) is resp.psn not received pkt->psn.  :-)
> 
resp.psn will carry the correct response psn for the current response packet. This will be the same
as the psn of the req packet for send/write, and atomic requests but will be one of the range
of psns of a read request response. I.e. if the mtu is 4K and the read is 1MB there will be
256 read response packets to reply to the read request with psns starting at the psn of the
request and increasing by 1 until the message is done. The next request packet must leave a gap of
255 psns.
> 
> 
>>
>> Also, set qp->comp.psn as pkt->psn will skip some psns(from qp->comp.psn to pkt->psn) in the retry, is it correct?
>>
>> Many thanks in advance!
>> Chengguang
>>
>> -------------------------
>>
>>   case AETH_NAK:
>>             switch (syn) {
>>             case AETH_NAK_PSN_SEQ_ERROR:
>>                 /* a nak implicitly acks all packets with psns
>>                  * before
>>                  */
>>                 if (psn_compare(pkt->psn, qp->comp.psn) > 0) {
>>                     rxe_counter_inc(rxe,
>>                             RXE_CNT_RCV_SEQ_ERR);
>>                     qp->comp.psn = pkt->psn;
>>                     if (qp->req.wait_psn) {
>>                         qp->req.wait_psn = 0;
>>                         rxe_run_task(&qp->req.task, 0);
>>                     }
>>                 }
>>                 return COMPST_ERROR_RETRY;
>>
>>
>>
> 
> 

