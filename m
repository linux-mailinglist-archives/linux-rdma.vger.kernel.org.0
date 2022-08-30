Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28585A5FE1
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Aug 2022 11:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiH3JzG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Aug 2022 05:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiH3JzE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Aug 2022 05:55:04 -0400
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F09DEAF
        for <linux-rdma@vger.kernel.org>; Tue, 30 Aug 2022 02:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1661853301; i=@fujitsu.com;
        bh=Bzgfv16AWaMwbJzNowv7nfXLyaUIG+rfEmrugzWofiU=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=WLY+P54o/KVCGNNyYf5xy2pccMQNAEUcM31cRV7Vrxw5xJGjr8zcBvwPdM3SVXKSQ
         LB+LDXlfWN6Czrgp8+IQL+8MOHvks5QcyuN3cFg515RGpug+kfQOjoSSmu4u1Te9Mb
         SL8qU+zo9KWAbliQMWQInoyJVnrr9jybmVwqn8N3Wz9vvQH5xti3OB9OSq2zHLj5i8
         cE9SzHaVGyhClXq5uXMamueowpOj1zdALY127GVVfcXWgUWL2JwRYOic7y9cz87LA2
         sMdBSVyBGAkynUeJlXp1DOfYPpOeuCFRQdNppDzSRwQtT5iObJctwtcTjkTtM5f4mQ
         On1YnudnzalhA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRWlGSWpSXmKPExsViZ8ORpFt6jzf
  ZYN5sDosr//YwWjw71Mticf5YP7sDs8fOWXfZPXqb37F5fN4kF8AcxZqZl5RfkcCacWziApaC
  ReIVP9e1sjcw/hTuYuTiEBLYyCjxYddUFghnKZPEw+7PUM52RonbC0+ydzFycvAK2EnMP/OOG
  cRmEVCVWH9pBytEXFDi5MwnLCC2qECExMNHk8BsYYFIiVfzt4PVMAuIS9x6Mp8JxGYT0JC413
  KTEcQWEaiS6N5zC6omV2Ln1oPMEItnM0k8m3SIrYuRg4NTwF7izn5riBoLicVvDrJD2PISzVt
  ng90jIaAocaTzLwtIuYRApcSNx6kQYTWJq+c2MU9gFJ6F5NJZSC6ahWTqLCRTFzCyrGK0TCrK
  TM8oyU3MzNE1NDDQNTQ01TXRtTTWS6zSTdRLLdUtTy0u0TXUSywv1kstLtYrrsxNzknRy0st2
  cQIjKSUYpbYHYxb+37qHWKU5GBSEuVt2MabLMSXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mCN+UWUE
  6wKDU9tSItMwcY1TBpCQ4eJRHeM7eB0rzFBYm5xZnpEKlTjMYc53fu38vMMenPtb3MQix5+Xm
  pUuK8DXeASgVASjNK8+AGwZLNJUZZKWFeRgYGBiGegtSi3MwSVPlXjOIcjErCvF0gU3gy80rg
  9r0COoUJ6JSHS7hBTilJREhJNTAx11WyzguQPPnizu5tDPH3Vm/4fHmbSu4zGcOFdo/2GVz22
  f1LeIcYW/FOvvutMr6Rpe+ivrecfBb6TLjKaWrgp8UWEz98m8sdnFL/498JU1+pMG+FvI3ld9
  9Pail3PevD+PCAtPWqxffaehclOlv5+M/L3/XpXsvHpxETPwctXaRzzF7pM1PGFMY1PTzH2Ke
  /eXLIPsJG/6iEgaDMTkN/259/i3uTs7daWez/aH5phUbOf/HVz7YZtRSe+c71S/vGj+nGT0sj
  ZCKkvvEz2/40yns4e+sVLgHtFJH+Xxnr9t9t4rjV9ePDn6tNB7XiqgQPeM+8L/k82NHtxJEZO
  1eY1p4+59jgmyZ0rVr3dVqTEktxRqKhFnNRcSIAYhiOorEDAAA=
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-10.tower-585.messagelabs.com!1661853300!52566!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7018 invoked from network); 30 Aug 2022 09:55:01 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-10.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 30 Aug 2022 09:55:01 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id AC2E21AC;
        Tue, 30 Aug 2022 10:55:00 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id A051C1AB;
        Tue, 30 Aug 2022 10:55:00 +0100 (BST)
Received: from [10.167.226.45] (10.167.226.45) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 30 Aug 2022 10:54:57 +0100
Message-ID: <3ee61af3-5651-5b82-c163-49b154758f24@fujitsu.com>
Date:   Tue, 30 Aug 2022 17:54:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] RDMA/rxe: Delete error messages triggered by incoming
 Read requests
Content-Language: en-US
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     =?UTF-8?B?TWF0c3VkYSwgRGFpc3VrZS/mnb7nlLAg5aSn6LyU?= 
        <matsuda-daisuke@fujitsu.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
References: <Ywi8ZebmZv+bctrC@nvidia.com>
 <20220829054413.1630495-1-matsuda-daisuke@fujitsu.com>
 <708e6623-7b63-6741-a3ed-fedd4d96d1cb@fujitsu.com>
 <TYCPR01MB845514BAC6CDED312B2E8720E5769@TYCPR01MB8455.jpnprd01.prod.outlook.com>
 <4eccf566-a8b9-4a5d-d9a4-a24f5b765c3d@fujitsu.com>
In-Reply-To: <4eccf566-a8b9-4a5d-d9a4-a24f5b765c3d@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 30/08/2022 17:44, Li Zhijian wrote:
>
>
> On 29/08/2022 18:21, Matsuda, Daisuke/松田 大輔 wrote:
>> On Monday, August 29, 2022 4:36 PM, Li Zhijian wrote:
>>> On 29/08/2022 13:44, Daisuke Matsuda wrote:
>>>> An incoming Read request causes multiple Read responses. If a user MR to
>>>> copy data from is unavailable or responder cannot send a reply, then the
>>>> error messages can be printed for each response attempt, resulting in
>>>> message overflow.
>>>>
>>>> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
>>>> ---
>>>>    drivers/infiniband/sw/rxe/rxe_resp.c | 6 +-----
>>>>    1 file changed, 1 insertion(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
>>>> index b36ec5c4d5e0..4b3e8aec2fb8 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>>>> @@ -811,8 +811,6 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>>>>
>>>>        err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
>>>>                  payload, RXE_FROM_MR_OBJ);

Looks i was missing the the faulting point inside rxe_mr_copy()

mr_check_range() is the only point to return an error inside rxe_mr_copy()
and mr_check_range() would never fail in this moment, since it is always tested by RESPST_CHK_RKEY
before calling read_reply()

so it's safe to remove this print, and add some comments ?

Thanks
Zhijian



>>>> -    if (err)
>>>> -        pr_err("Failed copying memory\n");
>>> Not relate to this patch.
>>> I'm wondering why this err is ignored, rxe_mr_copy() does the real execution or rxe_mr_copy() would never fail ?
>>> IMO, when err happens, responder shall notify the request anyhow.
>> Practically, I have never seen rxe_mr_copy() failed before,
>> but I agree the implementation may be incorrect as you mentioned.
>>
>> As far as I tested, responder replied with the requested amount of payloads
>> even when rxe_mr_copy() is modified to fail. In this case,
>> requester may mistakenly believe that they get data correctly.
>>
>> For more details, see IB Specification Vol 1-Revision-1.5 Ch.9.7.5.1.3 (page.334).
>
> it seems it's suitable to reply NAK code "REMOTE ACCESS ERROR" to the requester side
> by returning RESPST_ERR_RKEY_VIOLATION here.
>
> see "9.7.5.2.4 REMOTE ACCESS ERROR" and "9.7.4.1.5 RESPONDER R_KEY VALIDATION"
>
>
>
>>
>> Daisuke Matsuda
>>
>>> Thanks
>>> Zhijian
>>>
>>>>        if (mr)
>>>>            rxe_put(mr);
>>>>
>>>> @@ -823,10 +821,8 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>>>>        }
>>>>
>>>>        err = rxe_xmit_packet(qp, &ack_pkt, skb);
>>>> -    if (err) {
>>>> -        pr_err("Failed sending RDMA reply.\n");
>>>> +    if (err)
>>>>            return RESPST_ERR_RNR;
>>>> -    }
>>>>
>>>>        res->read.va += payload;
>>>>        res->read.resid -= payload;
>

