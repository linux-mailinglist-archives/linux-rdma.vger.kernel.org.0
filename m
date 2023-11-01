Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B707DE709
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Nov 2023 22:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbjKAVCz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Nov 2023 17:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjKAVCx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Nov 2023 17:02:53 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B651D10D
        for <linux-rdma@vger.kernel.org>; Wed,  1 Nov 2023 14:02:51 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-5845a94dae1so135735eaf.0
        for <linux-rdma@vger.kernel.org>; Wed, 01 Nov 2023 14:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698872571; x=1699477371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tJxSbMv2TALuSDN74bU3ey5ZvKGaDqawsfyJvfeARyM=;
        b=TZFUKZB4MpsRyDBIgrFOC0kKOuAVwyw044WeF9aWuumjY1bVthA1umdyONw3AqWCQw
         FY15cT1Slyv6ZOwRLZ6x/HgRpP3nTzNYqmeHT9Mv6JnF8jPxqd/BBwhLbWYh0HUYYYzd
         3gfh9BjZO+1iOjQ1rn+uU8j0RvkwJx15q0IO5KWGtBUHVP7cCCOT3qqKY/Br+tXc7i9M
         jDtZR4JS0kt08YQEoyML4a2WqamnYmMabC4sKe6ScilrZj11DMEle36lEu6pBfHqaA9/
         9Qf2wP9KGBMBfDcjhB3eNZtMkZbiCM2XqF4K/ctPMCC0jD8dE6u8pRWYW/dmHwUwiiQd
         zpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698872571; x=1699477371;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJxSbMv2TALuSDN74bU3ey5ZvKGaDqawsfyJvfeARyM=;
        b=Q7W/ajDAiYd/sxLx18ySJW0jAu4bWYcWDg8EiM7dAzCdd+hN02VFhhrAjuSjjArfhs
         AjPEaW5UJ1F+qhTnFB5EhUa5gBgQ+eOMscQqvueNRjMjimDRLga19Z3LXHIPUt/GlLjO
         QKtaSWXh+wQlJ5lQsokxZqEchoQK0yzQRaJX+WD4bD2zNtpbl7diIWDh+UcIcdM4Dzgw
         lZeYa/WovQvAY+ce2NiYk2xDPEE85S18d7ahevhIKp5lqCJZ5oK+lyw+1YKGOJYa1n96
         hORaG+lT+RjrtckNMAKE64m81+71ZEBmHGLXjyFLMnBHVN4U6+AP5hNvsTkI/Ekuabbl
         Kjbg==
X-Gm-Message-State: AOJu0YxbNPTpLOyEURUBwcMshfoyx8MLm7XqtwXF0Q6b5ltZM4dybV1y
        HJS5r3VT1aEHFzAuINHzJX7C1V/hgmNHvQ==
X-Google-Smtp-Source: AGHT+IEPhH/d6cuMw6ocMD3tWTpAvIG/QLmPmjogGRsm/+JLRZDiLDNJ3zwf34PV4y4ajifNnz20ig==
X-Received: by 2002:a05:6820:20b:b0:581:ea79:7052 with SMTP id bw11-20020a056820020b00b00581ea797052mr4704157oob.2.1698872570935;
        Wed, 01 Nov 2023 14:02:50 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:d647:5652:bce0:5754? (2603-8081-1405-679b-d647-5652-bce0-5754.res6.spectrum.com. [2603:8081:1405:679b:d647:5652:bce0:5754])
        by smtp.gmail.com with ESMTPSA id c13-20020a4aaccd000000b00584017f57a9sm725741oon.30.2023.11.01.14.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 14:02:50 -0700 (PDT)
Message-ID: <b23a7787-a95b-4280-bbc9-4305ac828c05@gmail.com>
Date:   Wed, 1 Nov 2023 16:02:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rxe mcast
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
References: <5b5d7549-1d1b-46ec-a6a3-baeaf4dfb179@gmail.com>
 <20231101182949.GC1850209@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20231101182949.GC1850209@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 11/1/23 13:29, Jason Gunthorpe wrote:
> On Wed, Nov 01, 2023 at 01:07:28PM -0500, Bob Pearson wrote:
>> Jason,
>>
>> I wrote a test program to verify that multicast is working in rxe
>> since there don't seem to be any pyverbs tests that actually test this.
>> It turns out that it doesn't work for several reasons most of which
>> I have fixed. But there is one that I can't figure out.
>>
>> The rxe driver calls dev_mc_add() with a MAC address to add the
>> multicast MAC address to the device which shows up when you type
>> 'ip maddr'. But nothing comes through from the network to the driver.
>> Wireshark does see the packets but they don't get to the IP or
>> UDP layers in the netdev stack.
> 
> I think you also need to attach a multicast IP address to the RXE
> socket ?
> 
>> So creating the IP mcast address seems critical to letting the
>> netdev stack receive traffic.
> 
> Yes
>   
>> I tried creating a separate UDP socket bound to the mcast address
>> but it doesn't seem to create the required IP address.
> 
> I don't think that is how you do it... There is a set sock opt thing
> you need, IIRC. It has been a long time since I last wrote code for it
> 
> Check what iperf did and that will be the basic thing that has to be
> cloned in the kernel
> 
> Jason


Thanks Jason,

That found it. I traced set socket opt down to ip_mc_join/leave_group
and ipv6_sock_mc_join/drop which seems to be working. Now ip maddr
reports both the link and inet addresses and packets are getting up
to the rxe driver without running iperf on the side.

Some fixes coming soon.

Bob
