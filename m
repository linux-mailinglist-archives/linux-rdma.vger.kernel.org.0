Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07B6474093
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Dec 2021 11:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbhLNKjd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Dec 2021 05:39:33 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:43803 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbhLNKjb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Dec 2021 05:39:31 -0500
Received: by mail-wr1-f46.google.com with SMTP id v11so31567952wrw.10
        for <linux-rdma@vger.kernel.org>; Tue, 14 Dec 2021 02:39:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6tqg7ZllETzZFYUuz7AvFPji63lPc6QcMad0j8o0TuE=;
        b=8O51pjSLoWIagSeMwffj8OYdpiOMF3oQMhnoSc+yyyHXI/bzQo9K+mjSPJsromCOFN
         nSYeOu2QeQjxpvA/lfAkKo30S4HXk3cnUwzInCyLQl0vkUtHpqmgKynokQGiW5MP+/TY
         K6w1tL7ymJTAkX5ycPvHleL/agMABxRaSAcYZgSS19vllH191qvHlssnvh6EygsrWFrL
         b2eLosZu3HULBCY4zQ6eXip5vFB2dPh3CJ3fk5c6SvGXHQexlBQhKgMjhT9Pa4CtU6Wt
         Hoo389jAHFG/EIlUQz7MBnUKLqmrc8jTube0BaPZZBdXUBqsYdF2NzfslJYh5q1gCIH1
         QddQ==
X-Gm-Message-State: AOAM531GX9JBi3wfNyLxfM/LM89HBuabR+aWl6OsUr5Ght55mX7vt0tl
        gnETbs8xCs7lSvE4MV9a8BH6+1Jt1k4=
X-Google-Smtp-Source: ABdhPJwbBepmVuVd8nDai1PFqvJwBc1g05Q4FiPml3SRRwSfBVvbU+WWHsACssYVtDsO1RnCvPyEdA==
X-Received: by 2002:adf:c182:: with SMTP id x2mr4967032wre.646.1639478370531;
        Tue, 14 Dec 2021 02:39:30 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u13sm1944913wmq.14.2021.12.14.02.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 02:39:29 -0800 (PST)
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To:     Yi Zhang <yi.zhang@redhat.com>, Max Gurtovoy <maxg@mellanox.com>
Cc:     "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me>
 <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
 <CAHj4cs_VZ7C7ciKy-q51a+Gc=uce0GDKRHNmUdoGOd7KSvURpA@mail.gmail.com>
 <84208be5-a7a9-5261-398c-fa9bda3efbe3@grimberg.me>
 <CAHj4cs8dgNNE5qcX3Y4ykuTYU8z_kea6=q64Pn_2vsdodgOJZQ@mail.gmail.com>
 <CAHj4cs-aDo7DufnKazyKuZVR-1AWr5FK1LDsN=Do=CVUJ2pH3g@mail.gmail.com>
 <9f115198-bafc-be4e-1c90-06444b8a37f6@grimberg.me>
 <CAHj4cs8wBwDGhhtEPodyBdR-sCqJLYhwLhNHuPDm+KCan0hwWg@mail.gmail.com>
 <42ccd095-b552-32f7-96b0-d34d46f7c83e@grimberg.me>
 <CAHj4cs9EazUmtbjPKp5TXO4kRPcSShiYbhmsHwfh7SOTQAeoyw@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c6d43a10-44bc-e73a-8836-d75367df049b@grimberg.me>
Date:   Tue, 14 Dec 2021 12:39:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHj4cs9EazUmtbjPKp5TXO4kRPcSShiYbhmsHwfh7SOTQAeoyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>> Hi Sagi
>>> It is still reproducible with the change, here is the log:
>>>
>>> # time nvme reset /dev/nvme0
>>>
>>> real    0m12.973s
>>> user    0m0.000s
>>> sys     0m0.006s
>>> # time nvme reset /dev/nvme0
>>>
>>> real    1m15.606s
>>> user    0m0.000s
>>> sys     0m0.007s
>>
>> Does it speed up if you use less queues? (i.e. connect with -i 4) ?
> Yes, with -i 4, it has stablee 1.3s
> # time nvme reset /dev/nvme0

So it appears that destroying a qp takes a long time on
IB for some reason...

> real 0m1.225s
> user 0m0.000s
> sys 0m0.007s
> 
>>
>>>
>>> # dmesg | grep nvme
>>> [  900.634877] nvme nvme0: resetting controller
>>> [  909.026958] nvme nvme0: creating 40 I/O queues.
>>> [  913.604297] nvme nvme0: mapped 40/0/0 default/read/poll queues.
>>> [  917.600993] nvme nvme0: resetting controller
>>> [  988.562230] nvme nvme0: I/O 2 QID 0 timeout
>>> [  988.567607] nvme nvme0: Property Set error: 881, offset 0x14
>>> [  988.608181] nvme nvme0: creating 40 I/O queues.
>>> [  993.203495] nvme nvme0: mapped 40/0/0 default/read/poll queues.
>>>
>>> BTW, this issue cannot be reproduced on my NVME/ROCE environment.
>>
>> Then I think that we need the rdma folks to help here...

Max?
