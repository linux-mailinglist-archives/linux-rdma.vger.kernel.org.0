Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42409472375
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Dec 2021 10:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbhLMJFC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Dec 2021 04:05:02 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:39923 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbhLMJFC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Dec 2021 04:05:02 -0500
Received: by mail-ed1-f45.google.com with SMTP id w1so49494450edc.6
        for <linux-rdma@vger.kernel.org>; Mon, 13 Dec 2021 01:05:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VvG9DQ5/5HpD56CzSTMBJ4VkJAcWFU5OBdmd9GGGqNk=;
        b=JnhN0aGsu8UpLj2EYX5dQh2YXj7cXl1k2+9BiZItM/a+krrVABWcVHlZEvOR/1rvTo
         8nOGzCjTZZQz7diwj8moFdxkTNwvrpLDtOTrGRlxTK8DPTrFJKFw5DYzHrTJxXDliKM/
         z5Q9XOlAAI7InfsvuS6AjqiD1wcXazLtm47OUko+2eRqVfdzlAvf/y0eI8U9tsPNxqd9
         gNLUcR8Tq+0CyawiX7Zued3R0qTfUQFtwuPReOhFnu31q0GZA/raX14UtBv6+Vc2r/9W
         uu8DCn9ZhCsToyIRM9uvdyjmcjPZFnzlmLWEHRGHrg6aLnXbjZ+l5vZCmlJgANXlWlrs
         7PMA==
X-Gm-Message-State: AOAM531IaVUjY9u8CGaxmrdAcZffU6JZxbch1pAVkEU64zhF/DqttqT3
        Iu8trqA9AgO0nfhqCbf455NtdBM84+M=
X-Google-Smtp-Source: ABdhPJwElPTR9llfH17INB+MYBkhqjve6QwhagGaiJy/0ST8RMoiKRnihfDBMI49Qxd6rjDjwi54OA==
X-Received: by 2002:a17:906:6a08:: with SMTP id qw8mr42652554ejc.200.1639386300700;
        Mon, 13 Dec 2021 01:05:00 -0800 (PST)
Received: from [10.100.102.14] (85-250-228-224.bb.netvision.net.il. [85.250.228.224])
        by smtp.gmail.com with ESMTPSA id u23sm5951467edi.88.2021.12.13.01.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 01:05:00 -0800 (PST)
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To:     Yi Zhang <yi.zhang@redhat.com>
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
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <42ccd095-b552-32f7-96b0-d34d46f7c83e@grimberg.me>
Date:   Mon, 13 Dec 2021 11:04:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHj4cs8wBwDGhhtEPodyBdR-sCqJLYhwLhNHuPDm+KCan0hwWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>>>>> Hello
>>>>>>
>>>>>> Gentle ping here, this issue still exists on latest 5.13-rc7
>>>>>>
>>>>>> # time nvme reset /dev/nvme0
>>>>>>
>>>>>> real 0m12.636s
>>>>>> user 0m0.002s
>>>>>> sys 0m0.005s
>>>>>> # time nvme reset /dev/nvme0
>>>>>>
>>>>>> real 0m12.641s
>>>>>> user 0m0.000s
>>>>>> sys 0m0.007s
>>>>>
>>>>> Strange that even normal resets take so long...
>>>>> What device are you using?
>>>>
>>>> Hi Sagi
>>>>
>>>> Here is the device info:
>>>> Mellanox Technologies MT27700 Family [ConnectX-4]
>>>>
>>>>>
>>>>>> # time nvme reset /dev/nvme0
>>>>>>
>>>>>> real 1m16.133s
>>>>>> user 0m0.000s
>>>>>> sys 0m0.007s
>>>>>
>>>>> There seems to be a spurious command timeout here, but maybe this
>>>>> is due to the fact that the queues take so long to connect and
>>>>> the target expires the keep-alive timer.
>>>>>
>>>>> Does this patch help?
>>>>
>>>> The issue still exists, let me know if you need more testing for it. :)
>>>
>>> Hi Sagi
>>> ping, this issue still can be reproduced on the latest
>>> linux-block/for-next, do you have a chance to recheck it, thanks.
>>
>> Can you check if it happens with the below patch:
> 
> Hi Sagi
> It is still reproducible with the change, here is the log:
> 
> # time nvme reset /dev/nvme0
> 
> real    0m12.973s
> user    0m0.000s
> sys     0m0.006s
> # time nvme reset /dev/nvme0
> 
> real    1m15.606s
> user    0m0.000s
> sys     0m0.007s

Does it speed up if you use less queues? (i.e. connect with -i 4) ?

> 
> # dmesg | grep nvme
> [  900.634877] nvme nvme0: resetting controller
> [  909.026958] nvme nvme0: creating 40 I/O queues.
> [  913.604297] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> [  917.600993] nvme nvme0: resetting controller
> [  988.562230] nvme nvme0: I/O 2 QID 0 timeout
> [  988.567607] nvme nvme0: Property Set error: 881, offset 0x14
> [  988.608181] nvme nvme0: creating 40 I/O queues.
> [  993.203495] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> 
> BTW, this issue cannot be reproduced on my NVME/ROCE environment.

Then I think that we need the rdma folks to help here...
