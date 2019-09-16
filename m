Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA42B3F96
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2019 19:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbfIPRZQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Sep 2019 13:25:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41225 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbfIPRZQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Sep 2019 13:25:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so371409pgg.8;
        Mon, 16 Sep 2019 10:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zsVhWs+rZSQ9pmPp93CkIV3JOWjcR8BN6wXm6TfggU4=;
        b=ggpj5aZB0HsJ6jCKeDm+N/L3I0GQOmS9TWQj6HZZpI/NyM3i7TV+KcvffJIVnPSqK3
         nvFsw9IN7SUBW2PKC/uyDT29dpWUqt/lLjSHBI6j073cZbwBxN7GAZCxkVmpQVWAmuTD
         aXtIgJbHXFnBEKrbtD7awjANd5gphLNszCEcqtF1iLzm+j72X5VAiiAM0VGYtJHeUYjN
         +JOG4c8p+VIziZFT4h4GWmJ95+AXEu7J0+kjLADrzgGk0Twjj2ONGULSGr5edcAAKRZA
         r2Lqtmx1XMSuDxJrj/UGBjToxCkzvIFn3BaKTBD56Xg0XF2kKImyO+Rd6BD6385OaODW
         WRQA==
X-Gm-Message-State: APjAAAUPzDf+1uH6SxBfvBRUidi8pkhs67PRoYcnZUziQ38i6EUBgkGU
        /1hFFSIAyM9KdjWQhkQk96s=
X-Google-Smtp-Source: APXvYqxT2OZ8W+ffke5agKcEDwOXkz6O6frQr2306GKIMGIjlZ5J2dLWhPTweusEJaFXPupFvDr7kQ==
X-Received: by 2002:aa7:8189:: with SMTP id g9mr440437pfi.78.1568654715966;
        Mon, 16 Sep 2019 10:25:15 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id f188sm52105937pfa.170.2019.09.16.10.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 10:25:14 -0700 (PDT)
Subject: Re: [PATCH v4 15/25] ibnbd: private headers with IBNBD protocol
 structs and helpers
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-16-jinpuwang@gmail.com>
 <4fbad80b-f551-131e-9a5c-a24f1fa98fea@acm.org>
 <CAMGffEnVFHpmDCiazHFX1jwi4=p401T9goSkes3j1AttV0t1Ng@mail.gmail.com>
 <CAMGffEmnTG4ixN1Hfy7oY93TgG3qQtF9TkpGzi=BxWm5a2i3Eg@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a7d4b3eb-d0c7-0c9d-ce64-da37a732564a@acm.org>
Date:   Mon, 16 Sep 2019 10:25:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMGffEmnTG4ixN1Hfy7oY93TgG3qQtF9TkpGzi=BxWm5a2i3Eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/16/19 7:57 AM, Jinpu Wang wrote:
>>>> +#define _IBNBD_FILEIO  0
>>>> +#define _IBNBD_BLOCKIO 1
>>>> +#define _IBNBD_AUTOIO  2
>>>>
>>>> +enum ibnbd_io_mode {
>>>> +     IBNBD_FILEIO = _IBNBD_FILEIO,
>>>> +     IBNBD_BLOCKIO = _IBNBD_BLOCKIO,
>>>> +     IBNBD_AUTOIO = _IBNBD_AUTOIO,
>>>> +};
>>>
>>> Since the IBNBD_* and _IBNBD_* constants have the same numerical value,
>>> are the former constants really necessary?
 >>
>> Seems we can remove _IBNBD_*.
 >
> Sorry, checked again,  we defined _IBNBD_* constants to show the right
> value for def_io_mode description.
> If we remove the _IBNBD_*, then the modinfo shows:
> def_io_mode:By default, export devices in blockio(IBNBD_BLOCKIO) or
> fileio(IBNBD_FILEIO) mode. (default: IBNBD_BLOCKIO (blockio))
> instead of:
> parm:           def_io_mode:By default, export devices in blockio(1)
> or fileio(0) mode. (default: 1 (blockio))

So the user is required to enter def_io_mode as a number? Wouldn't it be 
more friendly towards users to change that parameter from a number into 
a string?

Thanks,

Bart.

