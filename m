Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE037A5C72
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Sep 2023 10:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjISI1L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Sep 2023 04:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjISI1K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Sep 2023 04:27:10 -0400
Received: from out-222.mta0.migadu.com (out-222.mta0.migadu.com [91.218.175.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2E6E6
        for <linux-rdma@vger.kernel.org>; Tue, 19 Sep 2023 01:27:04 -0700 (PDT)
Message-ID: <01d9dd18-3d63-fabb-33d4-0de528f15a9a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695112022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Lj0k9xctIwHLWjwijGkd0QkcaIP74Qqk4Ij/vSRQV8=;
        b=VAOyiQlf1d3pGYKaggr63hy6vCFbK8M+iZsfIq0JrZ4BnhVU5KQLX9yUD532Xu3SH0XwCt
        cosMlQb3zQk9nTHECHhB/Dw+QRhxAQzq9XmzeV7gMh3EuAnYusExd7f9JlWkcjdCdcxlaY
        AInCm+0i9Ms3/6BgxsN9OilMt9wguhY=
Date:   Tue, 19 Sep 2023 16:26:54 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rtrs: Fix the problem of variable not
 initialized fully
To:     Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
References: <20230919020806.534183-1-yanjun.zhu@intel.com>
 <20230919081712.GD4494@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230919081712.GD4494@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/9/19 16:17, Leon Romanovsky 写道:
> On Tue, Sep 19, 2023 at 10:08:06AM +0800, Zhu Yanjun wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> No functionality change. The variable which is not initialized fully
>> will introduce potential risks.
> Are you sure about not being initialized?

About this problem, I think we discussed it previously in RDMA maillist.

And at that time, IIRC, you shared a link with me. The link is as below.

https://www.ex-parrot.com/~chris/random/initialise.html

 From what we discussed and the above link, I think it is not 
initialized fully.


Zhu Yanjun

>
> Thanks
>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/ulp/rtrs/rtrs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
>> index 3696f367ff51..d80edfffd2e4 100644
>> --- a/drivers/infiniband/ulp/rtrs/rtrs.c
>> +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
>> @@ -255,7 +255,7 @@ static int create_cq(struct rtrs_con *con, int cq_vector, int nr_cqe,
>>   static int create_qp(struct rtrs_con *con, struct ib_pd *pd,
>>   		     u32 max_send_wr, u32 max_recv_wr, u32 max_sge)
>>   {
>> -	struct ib_qp_init_attr init_attr = {NULL};
>> +	struct ib_qp_init_attr init_attr = {};
>>   	struct rdma_cm_id *cm_id = con->cm_id;
>>   	int ret;
>>   
>> -- 
>> 2.40.1
>>
