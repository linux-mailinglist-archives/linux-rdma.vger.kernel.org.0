Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA5C316AC2F
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 17:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgBXQxQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 11:53:16 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:45900 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgBXQxQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Feb 2020 11:53:16 -0500
Received: by mail-wr1-f44.google.com with SMTP id g3so11187273wrs.12
        for <linux-rdma@vger.kernel.org>; Mon, 24 Feb 2020 08:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8gYjpHBS7nc0WvuyaavD1sLLi0bzDb70g/PnjLB0v6Y=;
        b=dUxuC7cf+abZJboB4ZHDov4S/l9mG1OTZ5VKSRAp1m/1Q4YVdxJB3s4iM/7G6CFd6O
         GZuJeffTqP9QHxkizg4Wug7tMVlJKvPoxDe2NrJiC+wB3tTkzgTI29eBMHYI0Zkof5sR
         +guS89HI1o5AVchr+xrWqj6ARY8JWFSXl9ll1Ib3rTptO+wZEzmTwwbPrQwupiaLBWtC
         X43OD2vC2dwBesoKDNjxotq9l46vv35Fo2PJqcbC8FyTe7m9ViT33+PaT1II/xZqYxS/
         SAs/vHzxWOztgdXI4RmqkPIDRLkf0u+X5Ra+bg5S1MPSRuJBEOtdsh0wZMmQIQ3hUZEk
         kv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8gYjpHBS7nc0WvuyaavD1sLLi0bzDb70g/PnjLB0v6Y=;
        b=RgiLcqr+ZFEi3b8fKSRsdgjZW5dRThbQejX1wxAe84ooUfdqjPRB0C6SC51D2jXChw
         pnSnNrqTCS5PbhS9dH1z1nUN9WPP71oHKHt9dvE75xk6ksDZpbFsBPohzfJkcW7Z3A0N
         IZKDFCID9NZZqPJTO4FJhhJTAz/iMtK8FJMlJn9+R7L2IZvlGSpU0JGtDRGVMZ6rH1V0
         BT5yxPLB+xygi7NumCF1X2u737f+9t8iFI74SGLNifnDP4TJ+JZMwzmWnFKFOw+6QDuv
         2w8rhZlI5ey6ASPoej3GwOdA5qma/ojci+Rwcctx5lXNFI7h4cbFef4QBLbhl3Ak9TQ0
         yQ7Q==
X-Gm-Message-State: APjAAAW5DUt87gg7rFIcmwO+IdgDRHwOVwsHG5WDCPNaWlQK1Ki059iP
        Y1TppCiqZFI+pb8jHx/r3S26RcPHg9E=
X-Google-Smtp-Source: APXvYqz9WQTnaksrKHoPDPXM/czfkmxC8CMBFFMPTToOsTVea1Cwq+9u/V4JjbZ1vxKiMz3NBLTAJQ==
X-Received: by 2002:a5d:504e:: with SMTP id h14mr9204768wrt.82.1582563192901;
        Mon, 24 Feb 2020 08:53:12 -0800 (PST)
Received: from [10.80.2.221] ([193.47.165.251])
        by smtp.googlemail.com with ESMTPSA id c6sm3109774wrx.39.2020.02.24.08.53.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 08:53:12 -0800 (PST)
Subject: Re: Regarding using UMR feature from. rdma-core API
To:     Umang Patel <umangsp.1199@gmail.com>
References: <CANS8p=-hYd9x9n2-DUxuvHirD2b9MTS=gDOskfD_mipD+kb=vQ@mail.gmail.com>
 <CANS8p=-8waZ5TSQ3Ei+DO+M5gr5VW8itbByzgCDrnog-KDxy1A@mail.gmail.com>
Cc:     linux-rdma@vger.kernel.org
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <3843b642-d42e-9822-8e02-2ab5bc5bf669@dev.mellanox.co.il>
Date:   Mon, 24 Feb 2020 18:53:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CANS8p=-8waZ5TSQ3Ei+DO+M5gr5VW8itbByzgCDrnog-KDxy1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/24/2020 4:25 PM, Umang Patel wrote:
> So that means if i use ibv_wr_send or ibv_post_send after
> mlx5dv_wr_mr_list, then the send request will be posted with the UMR
> feature?
> 

Once an RDMA operation (send/receive) will use this UMR lkey the 
hardware will scatter the data according to its pattern. All of this is 
basically part of the man page where all mlx5 builders are described 
(i.e. mlx5dv_wr_post).

I'll send a PR to have a direct pointer for the UMR builders to this man 
page.

Yishai

> On Mon, Feb 24, 2020 at 4:24 PM Umang Patel <umangsp.1199@gmail.com> wrote:
>>
>> Hello!
>>
>> As you said, I have already read the mlx5dv_wr_post() manual but I am
>> still having trouble even after following the instructions given in
>> it. I have created a normal client-server code for transferring some
>> data from client to server using rdma. I am using the the rdma-core
>> repo for the code. For posting the send request with the UMR feature,
>> i use the function "mlx5dv_wr_mr_list" and to post the send request
>> without UMR feature, i use the function "ibv_wr_send". The two
>> functions that I mentioned are similar as mentioned in the manual. I
>> have written my code in such a way that it asks whether or not to use
>> the UMR feature and I have put an if else in the code which runs the
>> function according to the user's answer whether or not to use the
>> function and rest of the code is the does not change for with UMR and
>> without UMR. However, I am unable to receive the data with
>> mlx5dv_wr_mr_list function. Whereas, using ibv_wr_send, I am able to
>> receive the correct data.
>>
>> Can you please look into it? Am I missing something in the code that i
>> have to add for the UMR feature or the server side requires something
>> else? what is the problem? I have attached the client-server code with
>> this email.
>>
>> Thank You!

