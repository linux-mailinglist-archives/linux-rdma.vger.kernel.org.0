Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFED94732A6
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Dec 2021 18:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbhLMRF0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Dec 2021 12:05:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32139 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234830AbhLMRF0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Dec 2021 12:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639415124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P3TFAsQRIClwPso3h55COFgCPYMd8YWk5SFNWP4ZjE4=;
        b=Rways+O3ABMXXRf4PRznr30GC+mOmrtNtdexSVDADbJiBkw0LEKCR4XiTeaCRXCLIErOXM
        ySSVjG4L6D9MNLRNGJwv29ICp1cvDMUPbpTxqdjWHs2QQ6MmuYYzEN3eZz//gN7TOtcPPm
        2VfPMa/t4vG65xSYdfDlfGmnV3c3u7A=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-531-WowjUveuNhSfYyfszSs4yA-1; Mon, 13 Dec 2021 12:05:23 -0500
X-MC-Unique: WowjUveuNhSfYyfszSs4yA-1
Received: by mail-pg1-f198.google.com with SMTP id s8-20020a63af48000000b002e6c10ac245so9291496pgo.21
        for <linux-rdma@vger.kernel.org>; Mon, 13 Dec 2021 09:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P3TFAsQRIClwPso3h55COFgCPYMd8YWk5SFNWP4ZjE4=;
        b=MLd7LIgiCL7aDpKRL7Y9oi1K+kv30pt7tEPam3dAD/XrnMnggi63F/ZdOVtW2777Oe
         fLU3ub1DEjBcodVfCeo7XvPLKuRdMPVEiv1A7QeMC9y+Yhd4vBOnr372yyW+c5ZlQPZ2
         KjU6xu1enwAq0/gZ1TheUyEcgLQxSa8C/X4FZdNT1Z6RWP0nbku9+3uPo6RT3x06f5wo
         29ZJ/K5qfw1PldZr4tXevEiE+EOvxzPEokA97Cj2JrA1q+KpFtr0v35yOLKIojGtIIXz
         7I/jba0CfTWKzUma7Ri34K9Cf0mXerA+Y9HbxgnjWxDic1vkA5GEohTk7/gxitv8qcp7
         YG3w==
X-Gm-Message-State: AOAM5307Iu1OtTSAI3Ujt566a0Oy6dkZqRNtR8SWlKhNtR7HB+RSheGA
        DXlmeIAvaDIOTaihIkBiAOXnI+OkgPkAj/hIw0lNiliz/EO90n49v7TVYFg0G5ACJT9TyEfZ5EY
        +Xa/BXKgA6dmidcTkcZqmuLRbRzup97Z8n224zQ==
X-Received: by 2002:a17:90b:380e:: with SMTP id mq14mr46750257pjb.74.1639415121992;
        Mon, 13 Dec 2021 09:05:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJweCD/BYcw5iFp2acEXHQ/MEQ0f3B9dz/WJMFgzdqdERWwIqxZTxR5zsqDQX6IfaVpAytwC00r7vtPxTCtTNr0=
X-Received: by 2002:a17:90b:380e:: with SMTP id mq14mr46750204pjb.74.1639415121558;
 Mon, 13 Dec 2021 09:05:21 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me> <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
 <CAHj4cs_VZ7C7ciKy-q51a+Gc=uce0GDKRHNmUdoGOd7KSvURpA@mail.gmail.com>
 <84208be5-a7a9-5261-398c-fa9bda3efbe3@grimberg.me> <CAHj4cs8dgNNE5qcX3Y4ykuTYU8z_kea6=q64Pn_2vsdodgOJZQ@mail.gmail.com>
 <CAHj4cs-aDo7DufnKazyKuZVR-1AWr5FK1LDsN=Do=CVUJ2pH3g@mail.gmail.com>
 <9f115198-bafc-be4e-1c90-06444b8a37f6@grimberg.me> <CAHj4cs8wBwDGhhtEPodyBdR-sCqJLYhwLhNHuPDm+KCan0hwWg@mail.gmail.com>
 <42ccd095-b552-32f7-96b0-d34d46f7c83e@grimberg.me>
In-Reply-To: <42ccd095-b552-32f7-96b0-d34d46f7c83e@grimberg.me>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Tue, 14 Dec 2021 01:05:09 +0800
Message-ID: <CAHj4cs9EazUmtbjPKp5TXO4kRPcSShiYbhmsHwfh7SOTQAeoyw@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 13, 2021 at 5:05 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >>>>>> Hello
> >>>>>>
> >>>>>> Gentle ping here, this issue still exists on latest 5.13-rc7
> >>>>>>
> >>>>>> # time nvme reset /dev/nvme0
> >>>>>>
> >>>>>> real 0m12.636s
> >>>>>> user 0m0.002s
> >>>>>> sys 0m0.005s
> >>>>>> # time nvme reset /dev/nvme0
> >>>>>>
> >>>>>> real 0m12.641s
> >>>>>> user 0m0.000s
> >>>>>> sys 0m0.007s
> >>>>>
> >>>>> Strange that even normal resets take so long...
> >>>>> What device are you using?
> >>>>
> >>>> Hi Sagi
> >>>>
> >>>> Here is the device info:
> >>>> Mellanox Technologies MT27700 Family [ConnectX-4]
> >>>>
> >>>>>
> >>>>>> # time nvme reset /dev/nvme0
> >>>>>>
> >>>>>> real 1m16.133s
> >>>>>> user 0m0.000s
> >>>>>> sys 0m0.007s
> >>>>>
> >>>>> There seems to be a spurious command timeout here, but maybe this
> >>>>> is due to the fact that the queues take so long to connect and
> >>>>> the target expires the keep-alive timer.
> >>>>>
> >>>>> Does this patch help?
> >>>>
> >>>> The issue still exists, let me know if you need more testing for it. :)
> >>>
> >>> Hi Sagi
> >>> ping, this issue still can be reproduced on the latest
> >>> linux-block/for-next, do you have a chance to recheck it, thanks.
> >>
> >> Can you check if it happens with the below patch:
> >
> > Hi Sagi
> > It is still reproducible with the change, here is the log:
> >
> > # time nvme reset /dev/nvme0
> >
> > real    0m12.973s
> > user    0m0.000s
> > sys     0m0.006s
> > # time nvme reset /dev/nvme0
> >
> > real    1m15.606s
> > user    0m0.000s
> > sys     0m0.007s
>
> Does it speed up if you use less queues? (i.e. connect with -i 4) ?
Yes, with -i 4, it has stablee 1.3s
# time nvme reset /dev/nvme0

real 0m1.225s
user 0m0.000s
sys 0m0.007s

>
> >
> > # dmesg | grep nvme
> > [  900.634877] nvme nvme0: resetting controller
> > [  909.026958] nvme nvme0: creating 40 I/O queues.
> > [  913.604297] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> > [  917.600993] nvme nvme0: resetting controller
> > [  988.562230] nvme nvme0: I/O 2 QID 0 timeout
> > [  988.567607] nvme nvme0: Property Set error: 881, offset 0x14
> > [  988.608181] nvme nvme0: creating 40 I/O queues.
> > [  993.203495] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> >
> > BTW, this issue cannot be reproduced on my NVME/ROCE environment.
>
> Then I think that we need the rdma folks to help here...
>


-- 
Best Regards,
  Yi Zhang

