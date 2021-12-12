Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1997F471987
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Dec 2021 10:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhLLJpu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Dec 2021 04:45:50 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:46896 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhLLJpu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 12 Dec 2021 04:45:50 -0500
Received: by mail-wm1-f51.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso9691115wmr.5
        for <linux-rdma@vger.kernel.org>; Sun, 12 Dec 2021 01:45:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WHTBMchp3KBXczwZZpIAn+znCy/DsPxuUlwcS/DxvDk=;
        b=vE+h5RneMbvWAM+k2gUURl3K1WmV0Q43QLO+cEo0PVoJHNas+YXYA1cCSX8cPJ4pdg
         7/Sm+/bnBefMlc0FFy3VhG+nAdH0VMiNs7TkqtVePfZbaGxCPxBeQFAGhVTFshfCrqWz
         aNsrx6Fr6DjT4X69JXebfhKaABMauI2n2aWdy+X0rG0VZ0iMfqqeyHuplQkYGhIkZDRO
         3+dIRj4LDYKzMM48jSnFYIOrn6xi+0B70Nod6gnppqY/LsueBZv17r0CgY9jvycPQywP
         ET4nrP6Xj0qbz/tE/B8IT1VyUynYG/LTf1/QcK1e3LN7Yb+kU9kLoI+6NQ20SN49FURu
         6taw==
X-Gm-Message-State: AOAM531R4zCdor0L/1m9Hcc0Q0IeSKNB6p9DORsI2v2Bpvv/yGCSQS1H
        /aJkCwZ3Ufy9rkg5cwYWmSveZqdx0u8=
X-Google-Smtp-Source: ABdhPJwTcf2pLOyJ1ubM4Y8aZce0OOmggNf36Gt19UoUVjrQumDADB1GEIBKSLdgIDanHjoVwgDmvw==
X-Received: by 2002:a05:600c:378b:: with SMTP id o11mr29794895wmr.157.1639302348787;
        Sun, 12 Dec 2021 01:45:48 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r11sm7115126wrw.5.2021.12.12.01.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 01:45:48 -0800 (PST)
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
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9f115198-bafc-be4e-1c90-06444b8a37f6@grimberg.me>
Date:   Sun, 12 Dec 2021 11:45:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHj4cs-aDo7DufnKazyKuZVR-1AWr5FK1LDsN=Do=CVUJ2pH3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 12/11/21 5:01 AM, Yi Zhang wrote:
> On Fri, Jun 25, 2021 at 12:14 AM Yi Zhang <yi.zhang@redhat.com> wrote:
>>
>> On Thu, Jun 24, 2021 at 5:32 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>>>
>>>
>>>> Hello
>>>>
>>>> Gentle ping here, this issue still exists on latest 5.13-rc7
>>>>
>>>> # time nvme reset /dev/nvme0
>>>>
>>>> real 0m12.636s
>>>> user 0m0.002s
>>>> sys 0m0.005s
>>>> # time nvme reset /dev/nvme0
>>>>
>>>> real 0m12.641s
>>>> user 0m0.000s
>>>> sys 0m0.007s
>>>
>>> Strange that even normal resets take so long...
>>> What device are you using?
>>
>> Hi Sagi
>>
>> Here is the device info:
>> Mellanox Technologies MT27700 Family [ConnectX-4]
>>
>>>
>>>> # time nvme reset /dev/nvme0
>>>>
>>>> real 1m16.133s
>>>> user 0m0.000s
>>>> sys 0m0.007s
>>>
>>> There seems to be a spurious command timeout here, but maybe this
>>> is due to the fact that the queues take so long to connect and
>>> the target expires the keep-alive timer.
>>>
>>> Does this patch help?
>>
>> The issue still exists, let me know if you need more testing for it. :)
> 
> Hi Sagi
> ping, this issue still can be reproduced on the latest
> linux-block/for-next, do you have a chance to recheck it, thanks.

Can you check if it happens with the below patch:
--
diff --git a/drivers/nvme/target/fabrics-cmd.c 
b/drivers/nvme/target/fabrics-cmd.c
index f91a56180d3d..6e5aadfb07a0 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -191,6 +191,14 @@ static u16 nvmet_install_queue(struct nvmet_ctrl 
*ctrl, struct nvmet_req *req)
                 }
         }

+       /*
+        * Controller establishment flow may take some time, and the 
host may not
+        * send us keep-alive during this period, hence reset the
+        * traffic based keep-alive timer so we don't trigger a
+        * controller teardown as a result of a keep-alive expiration.
+        */
+       ctrl->reset_tbkas = true;
+
         return 0;

  err:
--
