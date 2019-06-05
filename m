Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4678B36852
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 01:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfFEXq3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 19:46:29 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42787 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfFEXq3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 19:46:29 -0400
Received: by mail-oi1-f194.google.com with SMTP id s184so301088oie.9
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 16:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JzrCe+Oiynn+n1LeOclwiS4sHpbix71fY50VS5BE95w=;
        b=t/WsFE6mLE6NG0RF6vvAiDNCcQuRKG8/UlGz/l3MPu7MsRq4J56zLmZn5Hspe+Oz69
         xzRKdMC+ZVhuxX0p/XBL4ylzJhbmNDkGTE+0T93OxtuEdUQXiusIYcM96HOq0aGXaqxO
         k1V949HXC4YEIjxaACI5vbGUAaRsY/GwjTRLuV5mcOYy4VGigQWnL45mIE6tp1WjQEHl
         a2JGJCk39Li1QYrp4gzKDBJ46RmTfdXWQNc4ZK3EqXcYeL0OZn3XJ78z5K0VW+OFlUzg
         oUWfnvejNUDwKTjun8rJsmNg68IwA+qeI8MrG9gfc8DnNyS3OAIMUBycX7MHwVhL51eW
         dsBA==
X-Gm-Message-State: APjAAAWIvA2sX+EkAy/ITQiNxjSRwPg26tEJy3ZffHLVDvmlD0Kg/4+J
        GBHbcjnM6PRkjAdVpefQt9k=
X-Google-Smtp-Source: APXvYqzNbnsiUZgBK4mNwZZVuXS/V9W0Y7HRmbI9Aqt1gtjQ3TI0zYU7sAR7njDcASN4+W8PErKUUg==
X-Received: by 2002:aca:3888:: with SMTP id f130mr10590833oia.1.1559778388608;
        Wed, 05 Jun 2019 16:46:28 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id h2sm66596otk.25.2019.06.05.16.46.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 16:46:27 -0700 (PDT)
Subject: Re: [PATCH 04/20] RDMA/core: Introduce ib_map_mr_sg_pi to map
 data/protection sgl's
To:     Max Gurtovoy <maxg@mellanox.com>, leonro@mellanox.com,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com,
        hch@lst.de, bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-5-git-send-email-maxg@mellanox.com>
 <b9c0f67c-e690-b6db-b326-2c76cfcab7b9@grimberg.me>
 <0d18b282-3950-44f9-c0cd-50c0a87df301@mellanox.com>
 <25ae4114-2ea6-6c2e-f6f9-e476dc56cf87@grimberg.me>
 <2841cf54-017e-aa57-3b7b-c7aa2fa48cf1@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d20f4eea-ad42-5f8d-fdf4-60ab55e673f4@grimberg.me>
Date:   Wed, 5 Jun 2019 16:46:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2841cf54-017e-aa57-3b7b-c7aa2fa48cf1@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> That's why I suggest to return success/fail and not the number of
>> SG elems that were mapped.
> 
> It's not a problem doing it, but I wanted it to be similar return code 
> and the regular data mapping function.
> 
> I guess it safer to return success/fail..
> 
>>
>>> I don't understand the concern here.
>>>
>>> Can you give an example ?
>>
>> In case your max nents for data+meta is 16 but you get data_sg=15
>> and meta_sg=2, its not that if you map 15+1 you can trivially continue
>> from that point.
> 
> This can't happen since if max_nents is 16, I limit the max_data_nents 
> to 8 and max_meta_nents to 8.

Still there is a possibility that we cannot map all nents. Exactly like
srp sends all the nents and allocates more until it finishes in the
normal mr mapping.

>>>> Or, if this cannot happen we need to describe why here.
>>>
>>> failures can always happen :)
>>
>> Yes, but what I was referring to is the difference between the normal
>> mr_map_sg and the mr_map_sg_pi. srp for example actually uses the
>> continuation of the number of mapped sg returned, it cannot do the
>> same with the pi version.
> 
> Well I guess we can still use this API in SRP and set the pointers and 
> offsets correctly.

That is another option, but the mapping routine needs to perform a non
trivial klm/mtt trimming in the case we did not cover all the entries,
its not trivial because the data pages and the meta pages have
completely different alignments.

I'd say that its simpler to make this a success/fail until srp or alike
will actually use it and then we can make it continuation friendly.
