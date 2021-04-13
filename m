Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC7B35E723
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 21:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345972AbhDMTfI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 15:35:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20133 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231882AbhDMTfC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Apr 2021 15:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618342481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=czqLIaE5Dp97Yw1CgohwL/ISh6V7XUMz5DGcxDH9UnY=;
        b=UWOlOBqvIPGl7aatSQkesf59uo2evLI768bZ3freZ06xaaI6xRR5o8voCrBmzFAs5+S7LC
        W184dFXvZFuX1IXpo30JTaZgu7+vP8flQmsxk+n2vmL3Gr2W4r6TiOROqt2FFrqFTtbcoV
        4XbvUOgqB7Ws4YwwQjMFpV8LIXis+Xc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-jLVW8J3DM2KiHzCy3Bgqiw-1; Tue, 13 Apr 2021 15:34:39 -0400
X-MC-Unique: jLVW8J3DM2KiHzCy3Bgqiw-1
Received: by mail-wr1-f72.google.com with SMTP id b4so1029628wrq.9
        for <linux-rdma@vger.kernel.org>; Tue, 13 Apr 2021 12:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=czqLIaE5Dp97Yw1CgohwL/ISh6V7XUMz5DGcxDH9UnY=;
        b=Fbo92Vz8UpKRVdRgya4G80fETK6uXUOFG8XQhN8a8YF6XkACSfftnnrUgfKKhAc9/B
         MvVh4/htMNj5Xa+p1PMbh66s4ktUl6wQTOLO6h8HtUy9/21g63+HF7goZbnOePKHL1RY
         omi0V58ZBje3h1U4QOMxH6RjB6dD7bvCRDiNhrwkSPSUeERBlkIeU4zybOYSU5p/+4q+
         4ejnMzYiZsuaxes6sqDhKjmCiz/k4OxTJtu3kG66umdCruePULDiBKwkcGHGuRH6D5Xn
         Z8lCIb48n8OEMock91FpKwj0ELGYo9k6LuNC9TUieZSCDMowa+pPLNVn3H3ep3PlIknG
         5F1Q==
X-Gm-Message-State: AOAM531lZf1rgaU1U+Scs9KZus3wyuRId9niYpuKgdRKKVP0tQhtj5nN
        Ur2h6fmvlw58pIda68VZXTuT2vui5PgkdFJTSa6yG+kKLBWyCzZM2XgJsqR1TL1DdO3rNPaLV/u
        hdTganIQCLqRATNc9RDGCwA==
X-Received: by 2002:a05:600c:2159:: with SMTP id v25mr1526631wml.80.1618342478357;
        Tue, 13 Apr 2021 12:34:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDJp4g0HgptAM9dfYvV3bB5Hj8bxlI97hLveiWvzHpsuExvyuEt354mwO/acUYoAePsaZp1Q==
X-Received: by 2002:a05:600c:2159:: with SMTP id v25mr1526615wml.80.1618342478108;
        Tue, 13 Apr 2021 12:34:38 -0700 (PDT)
Received: from [192.168.68.110] ([5.29.16.216])
        by smtp.gmail.com with ESMTPSA id s13sm21383364wrv.80.2021.04.13.12.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 12:34:37 -0700 (PDT)
Subject: Re: [PATCHv5 for-next 1/1] RDMA/rxe: Disable ipv6 features when
 ipv6.disable in cmdline
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Zhu Yanjun <yanjun.zhu@intel.com>, zyjzyj2000@gmail.com,
        Yi Zhang <yi.zhang@redhat.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, jgg@ziepe.ca
References: <20210413234252.12209-1-yanjun.zhu@intel.com>
 <ad1ca691-2d7f-905a-2a41-818f6cc34c50@redhat.com> <YHWtDNjhwKJgws24@unreal>
From:   Kamal Heib <kheib@redhat.com>
Message-ID: <9d410fde-ade3-c7fe-e73e-ca0103ec67c5@redhat.com>
Date:   Tue, 13 Apr 2021 22:34:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YHWtDNjhwKJgws24@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 4/13/21 5:39 PM, Leon Romanovsky wrote:
> On Tue, Apr 13, 2021 at 04:56:05PM +0300, Kamal Heib wrote:
>>
>>
>> On 4/14/21 2:42 AM, Zhu Yanjun wrote:
>>> From: Zhu Yanjun <zyjzyj2000@gmail.com>
>>>
>>> When ipv6.disable=1 is set in cmdline, ipv6 is actually disabled
>>> in the stack. As such, the operations of ipv6 in RXE will fail.
>>> So ipv6 features in RXE should also be disabled in RXE.
>>>
>>> Link: https://lore.kernel.org/linux-rdma/880d7b59-4b17-a44f-1a91-88257bfc3aaa@redhat.com/T/#t
>>> Fixes: 8700e3e7c4857 ("Soft RoCE driver")
>>> Reported-by: Yi Zhang <yi.zhang@redhat.com>
>>> Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
>>> ---
>>> V4->V5: Clean up signature block and remove error message
>>> V3->V4: Check the returned value instead of ipv6 module
>>> V2->V3: Remove print message
>>> V1->V2: Modify the pr_info messages
>>> ---
>>>  drivers/infiniband/sw/rxe/rxe_net.c | 13 ++++++++++++-
>>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
>>> index 01662727dca0..984c3ac449bd 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_net.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
>>> @@ -208,7 +208,13 @@ static struct socket *rxe_setup_udp_tunnel(struct net *net, __be16 port,
>>>  	/* Create UDP socket */
>>>  	err = udp_sock_create(net, &udp_cfg, &sock);
>>>  	if (err < 0) {
>>> -		pr_err("failed to create udp socket. err = %d\n", err);
>>> +		/* If UDP tunnel over ipv6 fails with -EAFNOSUPPORT, the tunnel
>>> +		 * over ipv4 still works. This error message will not pop out.
>>> +		 * If UDP tunnle over ipv4 fails or other errors with ipv6
>>> +		 * tunnel, this error should pop out.
>>> +		 */
>>> +		if (!((err == -EAFNOSUPPORT) && (ipv6)))
>>> +			pr_err("failed to create udp socket. err = %d\n", err);
>>>  		return ERR_PTR(err);
>>>  	}
>>>  
>>> @@ -620,6 +626,11 @@ static int rxe_net_ipv6_init(void)
>>>  	recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
>>>  						htons(ROCE_V2_UDP_DPORT), true);
>>>  	if (IS_ERR(recv_sockets.sk6)) {
>>> +		/* Though IPv6 is not supported, IPv4 still needs to continue
>>> +		 */
>>> +		if (PTR_ERR(recv_sockets.sk6) == -EAFNOSUPPORT)
>>> +			return 0;
>>> +
>>>  		recv_sockets.sk6 = NULL;
>>>  		pr_err("Failed to create IPv6 UDP tunnel\n");
>>>  		return -1;
>>>
>>
>> I think the following change is much simpler than changing the udp_sock_create()
>> helper function?
>>
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c
>> b/drivers/infiniband/sw/rxe/rxe_net.c
>> index 01662727dca0..b56d6f76ab31 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_net.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
>> @@ -621,6 +621,11 @@ static int rxe_net_ipv6_init(void)
>>                                                 htons(ROCE_V2_UDP_DPORT), true);
>>         if (IS_ERR(recv_sockets.sk6)) {
>>                 recv_sockets.sk6 = NULL;
>> +               if (PTR_ERR(recv_sockets.sk6) == -EAFNOSUPPORT) {
> 
> You have "recv_sockets.sk6 = NULL;" in the line above.
> 

Sorry, my bad...

The idea is to handle this issue in the error path of rxe_net_ipv6_init()
instead of changing the udp_sock_create(), also to make sure that
"recv_sockets.sk6" is set to NULL.

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c
b/drivers/infiniband/sw/rxe/rxe_net.c
index 01662727dca0..445a47f82f42 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -615,17 +615,25 @@ static int rxe_net_ipv4_init(void)

 static int rxe_net_ipv6_init(void)
 {
+       int err = 0;
 #if IS_ENABLED(CONFIG_IPV6)

        recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
                                                htons(ROCE_V2_UDP_DPORT), true);
        if (IS_ERR(recv_sockets.sk6)) {
+
+               if (PTR_ERR(recv_sockets.sk6) == -EAFNOSUPPORT) {
+                       pr_warn("Create IPv6 UDP tunnel is not supported\n");
+                       err = 0;
+               } else {
+                       pr_err("Failed to create IPv6 UDP tunnel\n");
+                       err = -1;
+               }
+
                recv_sockets.sk6 = NULL;
-               pr_err("Failed to create IPv6 UDP tunnel\n");
-               return -1;
        }
 #endif
-       return 0;
+       return err;
 }

>> +                       pr_warn("Create IPv6 UDP tunnel is not supported\n");
>> +                       return 0;
>> +               }
>> +
>>                 pr_err("Failed to create IPv6 UDP tunnel\n");
>>                 return -1;
>>         }
>> -- 
>> 2.26.3
>>
>>
>> Thanks,
>> Kamal
>>
> 

