Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0429A63EEE1
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 12:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiLALGo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 06:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiLALFk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 06:05:40 -0500
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057875AE37
        for <linux-rdma@vger.kernel.org>; Thu,  1 Dec 2022 03:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669892702; i=@fujitsu.com;
        bh=5ATzsPe1GEEMgkDo9ZanwQxbHsRnXmINpPnwlyHojfU=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=hRUxmM1KOj1sEsNbkAzEsCVy8WhPH/IdNoBfGxXB6OAbiaSqbtghZLPfpP8UdcwSj
         Po2YCv6ZdZ131YvebUsoi2Jz1Spptkipd18FQe8qNLJZDKFbfqWFrJ7IC6VHT6xFkb
         YeivZy312KeSw8UN5dERokwogChXCZjD9nOu/6tF/K4agEQ4btdBms0COMW0uiM5MR
         J5rj9hvboI4NszZIGFm9GsH6qCdoRgxsRQkUIFioYDwTqwb7LJd8DTSrs4eXfBGs0u
         XrdMdYAY/iFAG6j9hPHe5qzRWppnNQp8GMkwGZTaP/s/cbQsfN3FiRDmSv6UmWO5ox
         cf5iDjZqyab0w==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleJIrShJLcpLzFFi42Kxs+GYpBvb1ZF
  ssO6PtsWVf3sYLab8Wsps8exQL4vFl6nTmC3OH+tnd2D12DnrLrvHplWdbB69ze/YPD5vkgtg
  iWLNzEvKr0hgzdj9ajprwQmBih/XX7M1MHbwdjFycggJbGGUWHXXs4uRC8heziTR2dbNCuFsZ
  ZRovnKBGaSKV8BO4vL6bawgNouAisTiyW/YIeKCEidnPmEBsUUFkiSubrgLViMs4Ccx78xDRh
  BbBKj+xIkz7CBDmQUWMUksOLqDGWJDG6PE8t9zwTrYBNQkdk5/CTaJU0BLYs+8A2CbmQUsJBa
  /OcgOYctLbH87BywuIaAo0bbkHzuEXSExa1YbE4StJnH13CbmCYxCs5AcOAvJqFlIRi1gZF7F
  aFacWlSWWqRrpJdUlJmeUZKbmJmjl1ilm6iXWqqbl19UkqFrqJdYXqyXWlysV1yZm5yTopeXW
  rKJERg1KcXJYTsYe5f+0TvEKMnBpCTK+9qrI1mILyk/pTIjsTgjvqg0J7X4EKMMB4eSBK9lG1
  BOsCg1PbUiLTMHGMEwaQkOHiURXrl2oDRvcUFibnFmOkTqFKMux9TZ//YzC7Hk5eelSonzXgA
  pEgApyijNgxsBSyaXGGWlhHkZGRgYhHgKUotyM0tQ5V8xinMwKgnzVoNM4cnMK4Hb9AroCCag
  IyLF2kCOKElESEk1MAXt+7jKSzfHi1XX2D3d9BXH/3st+9827ud/1KXMKG7ctyXkjvV2d5snj
  CeWXON8NXnp3n2Z6k9Wrp7zad3lmdtr20ruePpeeHRyxoWpc7l3rP8js4i/I+a9Zt3zy0If3W
  UmxnnqxghubZYMZPyqpPSt0+n/3X/PtXazzTzEr778S4haSdoPtdXe584osTh8KP518NB/n0a
  1Mw1eRjwb16xJXLC7bn75Aib9gOuZWhr3XbNtY/zrOnsZUtq3vLSacXjbVNHsANen3gliwQLW
  HhOiIhJ/fSo5LZUXpMcpMf1jQs2DT1zV8/V8zFbm39nwvPmnpP50RQW1LE+2dZeMFdNusiYY/
  Lrbb7nKX0lrrRJLcUaioRZzUXEiAPUPeyWhAwAA
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-17.tower-728.messagelabs.com!1669892701!330689!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24395 invoked from network); 1 Dec 2022 11:05:01 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-17.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Dec 2022 11:05:01 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 2823C1000DB;
        Thu,  1 Dec 2022 11:05:01 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 1B5E81000D7;
        Thu,  1 Dec 2022 11:05:01 +0000 (GMT)
Received: from [10.167.215.54] (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 1 Dec 2022 11:04:57 +0000
Message-ID: <4a0e7932-ce2f-2631-eec5-4eb86c4498ab@fujitsu.com>
Date:   Thu, 1 Dec 2022 19:04:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 1/8] RDMA: Extend RDMA user ABI to support atomic write
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
References: <20221015063648.52285-1-yangx.jy@fujitsu.com>
 <20221015063648.52285-2-yangx.jy@fujitsu.com> <Y30n4NtOepuzUhxN@nvidia.com>
From:   Xiao Yang <yangx.jy@fujitsu.com>
In-Reply-To: <Y30n4NtOepuzUhxN@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/11/23 3:49, Jason Gunthorpe wrote:
> On Sat, Oct 15, 2022 at 06:37:04AM +0000, yangx.jy@fujitsu.com wrote:
>> 1) Define new atomic write request/completion in userspace.
>> 2) Define new atomic write capability in userspace.
>>
>> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
>> ---
>>   include/uapi/rdma/ib_user_verbs.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
>> index 43672cb1fd57..237814815544 100644
>> --- a/include/uapi/rdma/ib_user_verbs.h
>> +++ b/include/uapi/rdma/ib_user_verbs.h
>> @@ -466,6 +466,7 @@ enum ib_uverbs_wc_opcode {
>>   	IB_UVERBS_WC_BIND_MW = 5,
>>   	IB_UVERBS_WC_LOCAL_INV = 6,
>>   	IB_UVERBS_WC_TSO = 7,
>> +	IB_UVERBS_WC_ATOMIC_WRITE = 9,
>>   };
> 
> Why is this 9? The following patch does
Hi Jason,

I reserve 8 for IB_UVERBS_WC_FLUSH and 14 for IB_UVERBS_WR_FLUSH.

> 
> @@ -985,6 +986,7 @@ enum ib_wc_opcode {
>          IB_WC_REG_MR,
>          IB_WC_MASKED_COMP_SWAP,
>          IB_WC_MASKED_FETCH_ADD,
> +       IB_WC_ATOMIC_WRITE = IB_UVERBS_WC_ATOMIC_WRITE,
> 
> Which corrupts the enum.

Good catch. I will correct it now.

Best Regards,
Xiao Yang
> 
> It should be like this:
> 
> +++ b/include/rdma/ib_verbs.h
> @@ -983,10 +983,10 @@ enum ib_wc_opcode {
>          IB_WC_BIND_MW = IB_UVERBS_WC_BIND_MW,
>          IB_WC_LOCAL_INV = IB_UVERBS_WC_LOCAL_INV,
>          IB_WC_LSO = IB_UVERBS_WC_TSO,
> +       IB_WC_ATOMIC_WRITE = IB_UVERBS_WC_ATOMIC_WRITE,
>          IB_WC_REG_MR,
>          IB_WC_MASKED_COMP_SWAP,
>          IB_WC_MASKED_FETCH_ADD,
> -       IB_WC_ATOMIC_WRITE = IB_UVERBS_WC_ATOMIC_WRITE,
>   /*
>    * Set value of IB_WC_RECV so consumers can test if a completion is a
>    * receive by testing (opcode & IB_WC_RECV).
> +++ b/include/uapi/rdma/ib_user_verbs.h
> @@ -466,7 +466,7 @@ enum ib_uverbs_wc_opcode {
>          IB_UVERBS_WC_BIND_MW = 5,
>          IB_UVERBS_WC_LOCAL_INV = 6,
>          IB_UVERBS_WC_TSO = 7,
> -       IB_UVERBS_WC_ATOMIC_WRITE = 9,
> +       IB_UVERBS_WC_ATOMIC_WRITE = 8,
>   };
>   
>   struct ib_uverbs_wc {
> 
> Jason
