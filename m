Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A6E7D7CFB
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Oct 2023 08:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjJZGpv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 02:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZGpu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 02:45:50 -0400
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7E3AC
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 23:45:48 -0700 (PDT)
Message-ID: <88297e58-6da5-3dfd-549d-0c36f4e014bc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698302746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c6B5B2PZer5KRwC5FJhyTcDNBwl4ijj4ugnRbwh4icA=;
        b=egAG5yXUN56KNzunIkC5H8awZ+uiir2IccYjBpM0jRaLfakfNMzklTA8m89pShBrBX5omx
        xFxiV4E3Ikrq1vEbSGSqN/nfxRZMsVVIC7JxEhozMDweR8UWmBopNJISunwONKxqAoJORP
        OidUk6MSL+XLgCcr1mbZDb4hIof+0cE=
Date:   Thu, 26 Oct 2023 14:45:43 +0800
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH 16/19] RDMA/siw: Remove siw_sk_assign_cm_upcalls
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
 <20231009071801.10210-17-guoqing.jiang@linux.dev>
 <SN7PR15MB5755801084BA9B601315A31699DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <SN7PR15MB5755801084BA9B601315A31699DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 10/25/23 21:19, Bernard Metzler wrote:
>> -----Original Message-----
>> From: Guoqing Jiang<guoqing.jiang@linux.dev>
>> Sent: Monday, October 9, 2023 9:18 AM
>> To: Bernard Metzler<BMT@zurich.ibm.com>;jgg@ziepe.ca;leon@kernel.org
>> Cc:linux-rdma@vger.kernel.org
>> Subject: [EXTERNAL] [PATCH 16/19] RDMA/siw: Remove siw_sk_assign_cm_upcalls
>>
>> Let's move it into siw_sk_save_upcalls, then we only need to
>> get sk_callback_lock once. Also rename siw_sk_save_upcalls
>> to better align with the new code.
>>
>> Signed-off-by: Guoqing Jiang<guoqing.jiang@linux.dev>
>> ---
>>   drivers/infiniband/sw/siw/siw_cm.c | 19 ++++++-------------
>>   1 file changed, 6 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/siw/siw_cm.c
>> b/drivers/infiniband/sw/siw/siw_cm.c
>> index c3aa5533e75d..6866ec80473c 100644
>> --- a/drivers/infiniband/sw/siw/siw_cm.c
>> +++ b/drivers/infiniband/sw/siw/siw_cm.c
>> @@ -39,17 +39,7 @@ static void siw_cm_llp_error_report(struct sock *s);
>>   static int siw_cm_upcall(struct siw_cep *cep, enum iw_cm_event_type
>> reason,
>>   			 int status);
>>
>> -static void siw_sk_assign_cm_upcalls(struct sock *sk)
>> -{
>> -	write_lock_bh(&sk->sk_callback_lock);
>> -	sk->sk_state_change = siw_cm_llp_state_change;
>> -	sk->sk_data_ready = siw_cm_llp_data_ready;
>> -	sk->sk_write_space = siw_cm_llp_write_space;
>> -	sk->sk_error_report = siw_cm_llp_error_report;
>> -	write_unlock_bh(&sk->sk_callback_lock);
>> -}
>> -
>> -static void siw_sk_save_upcalls(struct sock *sk)
> To simplify, I'd suggest doing it the other way around,
> so having siw_sk_assign_cm_upcalls() including the
> functionality of siw_sk_save_upcalls() first.

I guess you mean below. If so, I will update it in v3.

  static void siw_sk_assign_cm_upcalls(struct sock *sk)
-{
-       write_lock_bh(&sk->sk_callback_lock);
-       sk->sk_state_change = siw_cm_llp_state_change;
-       sk->sk_data_ready = siw_cm_llp_data_ready;
-       sk->sk_write_space = siw_cm_llp_write_space;
-       sk->sk_error_report = siw_cm_llp_error_report;
-       write_unlock_bh(&sk->sk_callback_lock);
-}
-
-static void siw_sk_save_upcalls(struct sock *sk)
  {
         struct siw_cep *cep = sk_to_cep(sk);

@@ -58,6 +48,11 @@ static void siw_sk_save_upcalls(struct sock *sk)
         cep->sk_data_ready = sk->sk_data_ready;
         cep->sk_write_space = sk->sk_write_space;
         cep->sk_error_report = sk->sk_error_report;
+
+       sk->sk_state_change = siw_cm_llp_state_change;
+       sk->sk_data_ready = siw_cm_llp_data_ready;
+       sk->sk_write_space = siw_cm_llp_write_space;
+       sk->sk_error_report = siw_cm_llp_error_report;
         write_unlock_bh(&sk->sk_callback_lock);
  }

> There is another function siw_sk_assign_rtr_upcalls(),
> which re-assigns the upcalls for special handling of
> an explicit RTR->RTS handshake if requested later during
> connection setup.

Ah, one is assign rtr upcall and another is assign cm upcall.
Thanks for the explanation.

Guoqing
