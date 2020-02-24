Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 852A016A4A0
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 12:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgBXLNY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 06:13:24 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:54109 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgBXLNY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Feb 2020 06:13:24 -0500
Received: by mail-wm1-f46.google.com with SMTP id s10so8573839wmh.3
        for <linux-rdma@vger.kernel.org>; Mon, 24 Feb 2020 03:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2EFZZQCzJN83vSrACDZHiwPtb42hfnDcC0BvCSC34bY=;
        b=F9tOvpLp+Ja5Nq5dQH4K56SbQXd+31Wmsa84O/3PI8Go/RrlEh+sRK35enkYmVYCoy
         d9CALYkM88ZJbSxgWoOwGn/Eq0iqHV6NYPZQMAv5C+PpvEM+ejSUFw7FFxsO7STcEXrr
         KppzfVaVAYr281LeixCHvwqV3iEWtUA5bfnGScaZyIC6znTRXWz9Nnx7AmR1b3MP1aTI
         h2l1oLjPyDk7tTTT+ZWhh+aElVS8IogUXCmj9D2jIklcvvw0IvIgcTsbahRYtqGD2VQM
         agVFs1IHZ4MStHMHuAmzeqG8d7vOIEnyHgy1rBUoukxjz70z+l0tJggFU/PBCRfMsrcM
         91Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2EFZZQCzJN83vSrACDZHiwPtb42hfnDcC0BvCSC34bY=;
        b=DTdoS/JZUD4AmnxG9iM1WWR+DPe65rAVtQoVxzML3VE5Z8ijVZ/QolPGm0g1xpgSPJ
         vIFUICVgBhXycsgVVY9B73G/1NO4p18FRRh9hXGJNYzVIsSoRTXzL6npyxWXNYJ1LpGr
         BiA0/NnXzk1r7sFuRkDe02qsbdcjGY2HrpXHFnSScUH814SLFPoN/c6JQAoPbEsQ3SzQ
         lPF6fltxq49rx/YKaYTAv7nbk61cB2y7pznS02yy+4KJqgGhmWHFu97mKj4OtGYHvT/c
         IEUkpUEr7BT0mkPs/7pZPXfzODAuP8cfXgiGzt1+tpJsMkkw0/ytG1jzlqcbi03GBpcL
         Ka+Q==
X-Gm-Message-State: APjAAAWAY1wKywgaZIgApjO8bG5CG/2yv0WAfB/TKpTbTugGSwHcLRzX
        XcJ0J1Yt3kE6WPflvKAamfuhnERpgi8=
X-Google-Smtp-Source: APXvYqy6vV6bf9TKMKROM39JfuMkV9dMuyD+rgdhZkV5kIV80VcbsLb9BGObGwzE9vzVPKA/pa0pUA==
X-Received: by 2002:a1c:490b:: with SMTP id w11mr20521639wma.96.1582542802284;
        Mon, 24 Feb 2020 03:13:22 -0800 (PST)
Received: from [10.80.2.221] ([193.47.165.251])
        by smtp.googlemail.com with ESMTPSA id s139sm18509838wme.35.2020.02.24.03.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 03:13:21 -0800 (PST)
Subject: Re: Regarding using UMR feature from. rdma-core API
To:     Umang Patel <umangsp.1199@gmail.com>
References: <CANS8p=-hYd9x9n2-DUxuvHirD2b9MTS=gDOskfD_mipD+kb=vQ@mail.gmail.com>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Cc:     linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@mellanox.com>
Message-ID: <9635ad56-093e-3ab9-0c50-70b97cf87949@dev.mellanox.co.il>
Date:   Mon, 24 Feb 2020 13:13:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CANS8p=-hYd9x9n2-DUxuvHirD2b9MTS=gDOskfD_mipD+kb=vQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/24/2020 12:54 PM, Umang Patel wrote:
> Hello!
> 
> As you said, I have already read the mlx5dv_wr_post() manual but I am
> still having trouble even after following the instructions given in
> it. I have created a normal client-server code for transferring some
> data from client to server using rdma. I am using the the rdma-core
> repo for the code. For posting the send request with the UMR feature,
> i use the function "mlx5dv_wr_mr_list" and to post the send request
> without UMR feature, i use the function "ibv_wr_send". The two
> functions that I mentioned are similar as mentioned in the manual. I
> have written my code in such a way that it asks whether or not to use
> the UMR feature and I have put an if else in the code which runs the
> function according to the user's answer whether or not to use the
> function and rest of the code is the does not change for with UMR and
> without UMR. However, I am unable to receive the data with
> mlx5dv_wr_mr_list function. Whereas, using ibv_wr_send, I am able to
> receive the correct data.
> 
> Can you please look into it? Am I missing something in the code that i
> have to add for the UMR feature or the server side requires something
> else? what is the problem? I have attached the client-server code with
> this email.
> 
> Thank You!
> 

The mlx5dv_wr_mr_list() is not a replacement for ibv_wr_send() to send 
data to the server, it just refers to the mkey layout (i.e. registers a 
memory layout based on list of ibv_sge. etc.,  see its manual).

Yishai
