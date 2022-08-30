Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86145A5FAE
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Aug 2022 11:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiH3JpE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Aug 2022 05:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiH3JpB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Aug 2022 05:45:01 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C798313F98
        for <linux-rdma@vger.kernel.org>; Tue, 30 Aug 2022 02:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1661852698; i=@fujitsu.com;
        bh=ya0OxJl9a8hIiHJm6w5IIjBbbitpIgMbhrImD+vhJcE=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=pK/xdcp/zvMCdfXLou+8xrkPIQW5zBl+9oC4Nfs0lVyFB/ok6MEt2UA6IQk1YSea4
         VWe54Wrc7r7Cac4cn04o4dLgr64SW7sKSLUeCOqmGmHWQnC2h2aTIfM/NTR89BnE6Y
         rOlBYoUx3zqFz+bvfj6UT6dbI2lbaOEw0TAChWQoYE7LWxIF5Y9odnfpjOVZfDd4xR
         owsog3c97oJP9mWYWjwZjqqgtDAduRurvBzquU6YTWCDvGrgmDMKaFvBgpoYAbSCCJ
         EfgkYQfQEgwiUnKJOvDvbhQxkZPxki4SE4J9XluNmpuvBKHB5co/IqE4N6mig3uVba
         NIpuyuSKibMsA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRWlGSWpSXmKPExsViZ8ORqCt5hzf
  ZYPkCI4sr//YwWjw71Mticf5YP7sDs8fOWXfZPXqb37F5fN4kF8AcxZqZl5RfkcCacftpbcEm
  oYoV60UbGFfzdzFycQgJbGGUmHG1g62LkRPIWcEk8WdREkRiO6PE63trwRK8AnYS358cZAGxW
  QRUJbq2H4SKC0qcnPkELC4qECHx8NEkMFtYIFLi1fztrCA2s4C4xK0n85lAbBGBKonuPbeg4r
  kSO7ceZIZY9pxRYk3vFnaQBJuAhsS9lpuMIDanQKzEnD/9TBANFhKL3xxkh7DlJZq3zmYGsSU
  EFCWOdP4FWswBZFdK3HicChFWk7h6bhPzBEbhWUhOnYXkpFlIps5CMnUBI8sqRuukosz0jJLc
  xMwcXUMDA11DQ1NdY0tdIwMDvcQq3US91FLd8tTiEl0jvcTyYr3U4mK94src5JwUvbzUkk2Mw
  EhKKVY/sYPx6cqfeocYJTmYlER5G7bxJgvxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4E25BZQTLE
  pNT61Iy8wBRjVMWoKDR0mE1/oiUJq3uCAxtzgzHSJ1itGY4/zO/XuZOSb9ubaXWYglLz8vVUq
  cV/w2UKkASGlGaR7cIFiyucQoKyXMy8jAwCDEU5BalJtZgir/ilGcg1FJmHcVyD08mXklcPte
  AZ3CBHTKwyXcIKeUJCKkpBqYDk4q3S56/+TaTcayyc3r/x596rr/WN0L0Z0TjZfG5B7ynukbV
  CrM12/RtO+QzbanXYvevtj5T3njvHvK012W3v73bKF40DnRuR/KQvyebj5XZOcr3RZRm88xSe
  RB/KS0NDNXdudHjRNaJp3fyDtd7Pwk9jlp93g7/a5dn/ZDIlzfmm952ZyNq3ZrGds/mBbksUs
  6cKuHWsWNurVJC1+lbm5jOr5j0YHGdVkixW/uPb64YVnB+oXO9kt3SvEkPZ3WvfAl5+fL4frf
  Zn555v4xrW3CsrWO76MDjKTv3GfO3KlnyHLrLNdt+bPHM45sS4n/fXy6Sycjg4ON2O7Orzmv1
  mdZJhz4Okvl/Lb868tWHI9QYinOSDTUYi4qTgQAmt3xD7EDAAA=
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-21.tower-548.messagelabs.com!1661852697!62334!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22430 invoked from network); 30 Aug 2022 09:44:57 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-21.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 30 Aug 2022 09:44:57 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 7C3E8100194;
        Tue, 30 Aug 2022 10:44:57 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 6FB77100192;
        Tue, 30 Aug 2022 10:44:57 +0100 (BST)
Received: from [10.167.226.45] (10.167.226.45) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 30 Aug 2022 10:44:54 +0100
Message-ID: <4eccf566-a8b9-4a5d-d9a4-a24f5b765c3d@fujitsu.com>
Date:   Tue, 30 Aug 2022 17:44:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] RDMA/rxe: Delete error messages triggered by incoming
 Read requests
Content-Language: en-US
To:     =?UTF-8?B?TWF0c3VkYSwgRGFpc3VrZS/mnb7nlLAg5aSn6LyU?= 
        <matsuda-daisuke@fujitsu.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
References: <Ywi8ZebmZv+bctrC@nvidia.com>
 <20220829054413.1630495-1-matsuda-daisuke@fujitsu.com>
 <708e6623-7b63-6741-a3ed-fedd4d96d1cb@fujitsu.com>
 <TYCPR01MB845514BAC6CDED312B2E8720E5769@TYCPR01MB8455.jpnprd01.prod.outlook.com>
From:   Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <TYCPR01MB845514BAC6CDED312B2E8720E5769@TYCPR01MB8455.jpnprd01.prod.outlook.com>
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



On 29/08/2022 18:21, Matsuda, Daisuke/松田 大輔 wrote:
> On Monday, August 29, 2022 4:36 PM, Li Zhijian wrote:
>> On 29/08/2022 13:44, Daisuke Matsuda wrote:
>>> An incoming Read request causes multiple Read responses. If a user MR to
>>> copy data from is unavailable or responder cannot send a reply, then the
>>> error messages can be printed for each response attempt, resulting in
>>> message overflow.
>>>
>>> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
>>> ---
>>>    drivers/infiniband/sw/rxe/rxe_resp.c | 6 +-----
>>>    1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
>>> index b36ec5c4d5e0..4b3e8aec2fb8 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>>> @@ -811,8 +811,6 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>>>
>>>    	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
>>>    			  payload, RXE_FROM_MR_OBJ);
>>> -	if (err)
>>> -		pr_err("Failed copying memory\n");
>> Not relate to this patch.
>> I'm wondering why this err is ignored, rxe_mr_copy() does the real execution or rxe_mr_copy() would never fail ?
>> IMO, when err happens, responder shall notify the request anyhow.
> Practically, I have never seen rxe_mr_copy() failed before,
> but I agree the implementation may be incorrect as you mentioned.
>
> As far as I tested, responder replied with the requested amount of payloads
> even when rxe_mr_copy() is modified to fail. In this case,
> requester may mistakenly believe that they get data correctly.
>
> For more details, see IB Specification Vol 1-Revision-1.5 Ch.9.7.5.1.3 (page.334).

it seems it's suitable to reply NAK code "REMOTE ACCESS ERROR" to the requester side
by returning RESPST_ERR_RKEY_VIOLATION here.

see "9.7.5.2.4 REMOTE ACCESS ERROR" and "9.7.4.1.5 RESPONDER R_KEY VALIDATION"



>
> Daisuke Matsuda
>
>> Thanks
>> Zhijian
>>
>>>    	if (mr)
>>>    		rxe_put(mr);
>>>
>>> @@ -823,10 +821,8 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>>>    	}
>>>
>>>    	err = rxe_xmit_packet(qp, &ack_pkt, skb);
>>> -	if (err) {
>>> -		pr_err("Failed sending RDMA reply.\n");
>>> +	if (err)
>>>    		return RESPST_ERR_RNR;
>>> -	}
>>>
>>>    	res->read.va += payload;
>>>    	res->read.resid -= payload;

