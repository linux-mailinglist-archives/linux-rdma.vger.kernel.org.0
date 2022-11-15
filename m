Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832C66295B7
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Nov 2022 11:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiKOKYL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 05:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiKOKYK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 05:24:10 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4161F9F3
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 02:24:09 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668507847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3gBWndsAywsNeFNGw3BysgXyFmtMAqbTGaKsaICV1+I=;
        b=RxioBAsMkEc1/tFs0I6Vgb/WN0Vkhrub7yiD8BQcjhLULUpvzAiQp6HVS2Ut7qwpzSg5nW
        CJ49dkPp3vB2AMFL5AD/Fa1LXJ3tqRnA6HKJzibu2r3iNhk+D+eE/GJSiEytG8+i+TkVTC
        FpdEa6HuVJpvk4fDNwjtCq4jQ5EkZEc=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH RFC 02/12] RDMA/rtrs-srv: Refactor
 rtrs_srv_rdma_cm_handler
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     jinpu.wang@ionos.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
References: <20221113010823.6436-1-guoqing.jiang@linux.dev>
 <20221113010823.6436-3-guoqing.jiang@linux.dev>
 <CAJpMwyiArxegKZMnGVsZ42Ucgv8N=7CJUs1d0W0+rN3y-x0W=w@mail.gmail.com>
Message-ID: <91d969ea-138d-b688-0c75-1d8ddfc2918e@linux.dev>
Date:   Tue, 15 Nov 2022 18:24:06 +0800
MIME-Version: 1.0
In-Reply-To: <CAJpMwyiArxegKZMnGVsZ42Ucgv8N=7CJUs1d0W0+rN3y-x0W=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 11/14/22 10:39 PM, Haris Iqbal wrote:
> On Sun, Nov 13, 2022 at 2:08 AM Guoqing Jiang<guoqing.jiang@linux.dev>  wrote:
>> The RDMA_CM_EVENT_CONNECT_REQUEST is quite different to other types,
>> let's checking it separately at the beginning of routine, then we can
>> avoid the identation accordingly.
>>
>> Signed-off-by: Guoqing Jiang<guoqing.jiang@linux.dev>
>> ---
>>   drivers/infiniband/ulp/rtrs/rtrs-srv.c | 17 ++++++-----------
>>   1 file changed, 6 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
>> index 79504aaef0cc..2cc8b423bcaa 100644
>> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
>> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
>> @@ -1948,24 +1948,19 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
>>   static int rtrs_srv_rdma_cm_handler(struct rdma_cm_id *cm_id,
>>                                       struct rdma_cm_event *ev)
>>   {
>> -       struct rtrs_srv_path *srv_path = NULL;
>> -       struct rtrs_path *s = NULL;
>> -
>> -       if (ev->event != RDMA_CM_EVENT_CONNECT_REQUEST) {
>> -               struct rtrs_con *c = cm_id->context;
>> -
>> -               s = c->path;
>> -               srv_path = to_srv_path(s);
>> -       }
>> +       struct rtrs_con *c = cm_id->context;
>> +       struct rtrs_path *s = c->path;
>> +       struct rtrs_srv_path *srv_path = to_srv_path(s);
> This isn't correct for the RDMA_CM_EVENT_CONNECT_REQUEST event. At
> that moment, cm_id->context is still holding a pointer to struct
> rtrs_srv_ctx. Even though it never gets used for this event here, its
> not right IMO to dereference in this incorrect manner.

But rtrs_rdma_connect will deference the context again for connect request.

> How about we move the check for the RDMA_CM_EVENT_CONNECT_REQUEST
> event outside (just like you did), but let the pointers be NULL, and
> only dereference after the if condition for
> RDMA_CM_EVENT_CONNECT_REQUEST event?

Ok, will do it though it need more lines which I tried to avoid.

Thanks,
Guoqing
