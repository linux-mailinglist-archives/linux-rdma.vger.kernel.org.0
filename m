Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13EFA1658D7
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 08:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgBTHzg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Feb 2020 02:55:36 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:33924 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgBTHzf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Feb 2020 02:55:35 -0500
Received: by mail-wr1-f52.google.com with SMTP id n10so3521410wrm.1
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 23:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kjwOiA4V0C3DgeNEfosXgxWqr71YgcrFpDhSbWkD23c=;
        b=QykNF1nSt5O+0h3p/75r+aNbeSsjrBUDpKtN7wU698XK/bqQpTe6Bi37L+Paa7uefX
         hwRTldmfKwYOSWqaXe/qwnfBjWVlihXP55Dd3AJBwKYBDhxTTvonNfOOfGWCW+5eps68
         tiCqtAgAvKjmc6BomKbVYmbAi6qrvWqt9ew/94lDFChNSPuYRpox8OuAsQ3RKGG6eQbj
         t585zKOZ3SSNriNsSrG0eoqeyVVqwUw+RQQIYjjGj/AFKCTg8H9wkf2aRrHkkKd4Jux4
         XobfbqU2b68G7LEHQ6CgmaEUkNJqATrKSl5XdnbTRlW3o00ycepWs+Sb45jiVP6a6TCp
         C1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kjwOiA4V0C3DgeNEfosXgxWqr71YgcrFpDhSbWkD23c=;
        b=gDgYO6eJCn3m98tzQoOiwZaGGJPwwtViePSQjQhhbj3Uz/cGUu06Do/YjDqZcaHWAP
         Vqg34fhEfWYuEpB3Kx/eRx9VQ9fQRlPbc02P2CnbkxKIHnt3dP86RLA23HQEIpCIBm5i
         4lNt9lA1MkFM/a7Zfq9BagbWAlaGftvHx6bhnIaWtiJCzEmHJfcd7TiupCUnxxwBizUZ
         60SzBQcYGNAlFEEJoh6BKZFPg42IcYEujJKmJXAxEZqweqCBCcEC2GL22FZjBSPQ9owH
         n9SjgM1aOhI9NqadaBFyLOLlxwCnTMy0wfbJwBp1+L9hrEJ90fgqHVOqAXwPpG9GA5Gf
         l/hQ==
X-Gm-Message-State: APjAAAUuzQ/xNDn500I8eVG/ghiirlpjGLlSL1UTTMCQb6crOeEzFEAr
        c1PvhfEOzm8e2Vm8iFoiLtBSl1tz2ZI=
X-Google-Smtp-Source: APXvYqz6JGabgu/FQcw/CqLQB32hEYWmS+90xNkOvGcFwRYghbjMWRDetIwA+fE51XXkC1nTywSvOA==
X-Received: by 2002:adf:97d6:: with SMTP id t22mr40104763wrb.407.1582185332513;
        Wed, 19 Feb 2020 23:55:32 -0800 (PST)
Received: from [10.80.2.221] ([193.47.165.251])
        by smtp.googlemail.com with ESMTPSA id d9sm3388508wrx.94.2020.02.19.23.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 23:55:31 -0800 (PST)
Subject: Re: Regarding rdma-core repo
To:     Umang Patel <umangsp.1199@gmail.com>
References: <CANS8p=_m7r93sOdKrdLpaog3dQ7KJ+qjsZdEf9R6KZhDzoZy8g@mail.gmail.com>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Cc:     linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@mellanox.com>
Message-ID: <192afd41-7972-c9b5-0f4f-b74890bbe647@dev.mellanox.co.il>
Date:   Thu, 20 Feb 2020 09:55:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CANS8p=_m7r93sOdKrdLpaog3dQ7KJ+qjsZdEf9R6KZhDzoZy8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/19/2020 8:18 PM, Umang Patel wrote:
> Hello!
> 
> I am interning right now and working on a project which uses the
> rdma-core repo. Thus, I would like to ask you some of doubts regarding
> the repo since i am stuck at a place. Can you please help me out with
> this? I promise I will not take much of your time.
> 
> I want to know how the function "mlx5dv_wr_mr_list" works. I am able
> to execute the function on the client side which completes
> successfully. However, I am unable to receive any data on the server
> side sent by the client. Is there some sort of special receive
> function I have to use or some other methodology to receive data on
> the server side. 

This API is some MR related builder, no special receive is needed here.
You can take a look at mlx5dv_wr_post() man page which describes the 
expected usage and concept.

Yishai
