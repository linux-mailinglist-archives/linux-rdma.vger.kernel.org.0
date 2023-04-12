Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2056DE8B8
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Apr 2023 03:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjDLBPJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Apr 2023 21:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjDLBPI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Apr 2023 21:15:08 -0400
Received: from out-27.mta0.migadu.com (out-27.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8763C2F
        for <linux-rdma@vger.kernel.org>; Tue, 11 Apr 2023 18:15:05 -0700 (PDT)
Message-ID: <e22e7963-2077-45b8-97c8-8eef07862ef4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1681262103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/paw7IqEOEy+ovAEusbtsr+5TmeXfkuP4O/ugrRFms=;
        b=gWq0HyuDVhxDvo2LvDOCWQaxFBeV14vn++mXt+/sPxQkxTEWu3hiHHysZi8MRrxTYgTxkY
        /n0EfObL1YIuo5ukrVRT2Lu5hgGw3mZ28yVTjpnkfH2ZItYHNrc0J2hgrmSNyUnF5zNCTC
        RewTpOAFR1YCn/10cNnH4oqn63ZjL4U=
Date:   Wed, 12 Apr 2023 09:15:01 +0800
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH for-next 3/3] RDMA/rtrs: Avoid use-after-free in
 rtrs_clt_rdma_cm_handler
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1681108984-2-1-git-send-email-lizhijian@fujitsu.com>
 <1681108984-2-4-git-send-email-lizhijian@fujitsu.com>
 <46aa88fe-89f0-6880-9bb7-081d1d18023b@linux.dev>
 <1e1c082c-0c94-6594-d02c-9f7fbab80b0b@fujitsu.com>
Content-Language: en-US
In-Reply-To: <1e1c082c-0c94-6594-d02c-9f7fbab80b0b@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 4/11/23 09:33, Zhijian Li (Fujitsu) wrote:
>
>>> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
>>> index 4c8f42e46e2f..760a7eb51297 100644
>>> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
>>> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
>>> @@ -2074,6 +2074,7 @@ static int create_cm(struct rtrs_clt_con *con)
>>>            rtrs_err(s, "Failed to resolve address, err: %d\n", err);
>>>            goto destroy_cm;
>>>        }
>>> +again:
>>>        /*
>>>         * Combine connection status and session events. This is needed
>>>         * for waiting two possible cases: cm_err has something meaningful
>>> @@ -2083,10 +2084,15 @@ static int create_cm(struct rtrs_clt_con *con)
>>>                clt_path->state_wq,
>>>                con->cm_err || clt_path->state != RTRS_CLT_CONNECTING,
>>>                msecs_to_jiffies(RTRS_CONNECT_TIMEOUT_MS));
>>> -    if (err == 0 || err == -ERESTARTSYS) {
>>> -        if (err == 0)
>>> -            err = -ETIMEDOUT;
>>> -        /* Timedout or interrupted */
>>> +    if (err == -ERESTARTSYS) {
>>> +        /* interrupted,
>>> +         * try again to avoid the in-flight rtrs_clt_rdma_cm_handler()
>>> +         * getting a use-after-free
>>> +         */
>>> +        goto again;
>>> +    } else if (err == 0) {
>>> +        err = -ETIMEDOUT;
>>> +        /* Timedout */
>>>            goto errr;
>>>        }
>> Can event handler still be triggered in case of timeout?
> I have never hit such race.

But it is still possible with the theory.

>> And I guess either stop_cm -> rdma_disconnect or destroy_cm -> rdma_destroy_id
>> should prevent this kind of racy issue.
> In practice, they are possible that rtrs_clt_rdma_cm_handler() is in-flight during
> 'either stop_cm -> rdma_disconnect or destroy_cm -> rdma_destroy_id'. rtrs_clt_rdma_cm_handler() and
> cm's cleanup path need to hold mutex_lock(&con->con_mutex), once cm's cleanup path get this lock first
> rtrs_clt_rdma_cm_handler has to sleep, when rtrs_clt_rdma_cm_handler is wakeup again, some resources has been
> freed by cm's cleanup path.

First, stop_cm doesn't need to hold &con->con_mutex. But 
rtrs_clt_rdma_cm_handler
is called from rdma core layer which need  id_priv->handler_mutexinstead 
of con_mutex
I thinnk. Also RTRS has similar behavior as nvme host rdma, ib_srp and 
iser_verb.

@Jinpu/Haris, can we move destroy_cm right after stop_cm?*

*Thanks,
Guoqing
