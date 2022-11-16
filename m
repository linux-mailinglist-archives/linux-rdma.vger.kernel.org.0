Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D3F62B070
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Nov 2022 02:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiKPBOB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 20:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiKPBOA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 20:14:00 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2A727173
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 17:13:56 -0800 (PST)
Subject: Re: [PATCH RFC 05/12] RDMA/rtrs-srv: Correct the checking of
 ib_map_mr_sg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668561235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oubu4qStIv2OE2IdDQNJFKQnk9YVpMbbS5o02UElcYo=;
        b=IhBFIAhZorKZGHKTEVjopP0EjjdLkbrb2D36E/O5lSHHlWbEWZDu+m/jBVwrpCSg3GfvcD
        FeYpLxTKaJn6K9b/AI22qgAPab/VzUqfPOBCXAHMpdFFhu4De9JWjSU6uXWkqN7gjqLLTj
        BM6jdIuko7fuhUEb22a34c6LA4YL8JE=
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     haris.iqbal@ionos.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
References: <20221113010823.6436-1-guoqing.jiang@linux.dev>
 <20221113010823.6436-6-guoqing.jiang@linux.dev>
 <CAMGffEn3sYLbF1_05mjHvtOM4DPGKR3AYYTBip0BD=4V9g9-+A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <9f626b16-ee9a-e8f6-2db9-2277fddab0e5@linux.dev>
Date:   Wed, 16 Nov 2022 09:13:49 +0800
MIME-Version: 1.0
In-Reply-To: <CAMGffEn3sYLbF1_05mjHvtOM4DPGKR3AYYTBip0BD=4V9g9-+A@mail.gmail.com>
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



On 11/15/22 7:46 PM, Jinpu Wang wrote:
> On Sun, Nov 13, 2022 at 2:08 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>> We should check with nr_sgt, also the only successful case is that
>> all sg elements are mapped, so make it explict.
>>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
>> ---
>>   drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
>> index 88eae0dcf87f..f3bf5bbb4377 100644
>> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
>> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
>> @@ -622,8 +622,8 @@ static int map_cont_bufs(struct rtrs_srv_path *srv_path)
>>                  }
>>                  nr = ib_map_mr_sg(mr, sgt->sgl, nr_sgt,
>>                                    NULL, max_chunk_size);
>> -               if (nr < 0 || nr < sgt->nents) {
>> -                       err = nr < 0 ? nr : -EINVAL;
>> +               if (nr != nr_sgt) {
>> +                       err = -EINVAL;
> but with this, the initial errno are lost, we only return EINVAL

OK, assume you mean 'nr' here, I can change it back as iser_memory did.
But seems the only negative value returned from ib_map_mr_sg is also
"-EINVAL" from ib_sg_to_pages after go through hw drivers.

BTW, I looked all call sites of ib_map_mr_sg, seems they have different
kind of checking.

1. if (ret < 0 || ret < nents)

2. if (ret < nents) or if (ret < 0)

3. if (ret != nents)

Thanks,
Guoqing
