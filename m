Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5A31BF58C
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2019 17:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfIZPLh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Sep 2019 11:11:37 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42240 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfIZPLg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Sep 2019 11:11:36 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so1188712pls.9;
        Thu, 26 Sep 2019 08:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OuASP01wRvo2xYO/wcTqKnQ8tF7BPFqCLNRQYPLq3tQ=;
        b=isNTXHiJ5VogdwC2sBtkDgWU9nIMpBOQ6X2POXUFKfcjmbOVKH8do0u2Ux5ocmLek3
         /QctVfJ3zlFxOhqc/K5yNUgLq/DPg53JDO6lcxb8VgLb/EQrAfVZ8T7aAuvbo9itp4ii
         cNq2Px6rLpfdStqv3f61SKKOdS39DuaqRI26BKoQ8sFmxvvbF2/buoTaFSa93u8fz9n5
         A4UxhlOIsA9wzMIN/H0QgWV9V5XkM4QK109V7XAHg91ZNw8KIFfMY0RTAi081en8JUcl
         7dPfg4zdaAEcOveLnhZ589BqFrV7u234zgRrSZ+FfSS3V2gl3rU2h4RIFCRvgtU5tzk6
         xOYw==
X-Gm-Message-State: APjAAAW1nzrYZD4nA5zRY6n7TkVtsNsfQ0w99zGBqyD1Hxh/SgS00I6y
        NCmWqyOVBX3w4l7ETICxKGo=
X-Google-Smtp-Source: APXvYqznmcrLKEXl+XedRu5HbNl0anfwGRY4P5k18F0+4/d4N8ppHTh2A/P7Al2ElJZxMTAZlO/IKQ==
X-Received: by 2002:a17:902:9305:: with SMTP id bc5mr4422495plb.63.1569510696143;
        Thu, 26 Sep 2019 08:11:36 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id e4sm2903938pff.22.2019.09.26.08.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 08:11:35 -0700 (PDT)
Subject: Re: [PATCH v4 21/25] ibnbd: server: functionality for IO submission
 to file or block dev
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-22-jinpuwang@gmail.com>
 <d1208649-5c25-578f-967e-f7a3c9edd9ce@acm.org>
 <CAMGffE=RpTjDX-LL2E5t_eOF8iwG=UpgWFcnB3tz-N-PQ0etoQ@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ab90033d-6045-fcdf-f238-80d8b4852559@acm.org>
Date:   Thu, 26 Sep 2019 08:11:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMGffE=RpTjDX-LL2E5t_eOF8iwG=UpgWFcnB3tz-N-PQ0etoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/26/19 7:04 AM, Jinpu Wang wrote:
> On Wed, Sep 18, 2019 at 11:46 PM Bart Van Assche <bvanassche@acm.org> wrote:
>> On 6/20/19 8:03 AM, Jack Wang wrote:
>> Isn't the use of O_DSYNC something that should be configurable?
> I know scst allow O_DSYNC to be configured, but in our production, we
> only use with O_DSYNC,
>   we sure can add options to allow it to configure it, but we don't
> have a need yet.

Shouldn't upstream code be general purpose instead of only satisfying 
the need of a single user?

>>> +struct ibnbd_dev *ibnbd_dev_open(const char *path, fmode_t flags,
>>> +                              enum ibnbd_io_mode mode, struct bio_set *bs,
>>> +                              ibnbd_dev_io_fn io_cb)
>>> +{
>>> +     struct ibnbd_dev *dev;
>>> +     int ret;
>>> +
>>> +     dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>>> +     if (!dev)
>>> +             return ERR_PTR(-ENOMEM);
>>> +
>>> +     if (mode == IBNBD_BLOCKIO) {
>>> +             dev->blk_open_flags = flags;
>>> +             ret = ibnbd_dev_blk_open(dev, path, dev->blk_open_flags);
>>> +             if (ret)
>>> +                     goto err;
>>> +     } else if (mode == IBNBD_FILEIO) {
>>> +             dev->blk_open_flags = FMODE_READ;
>>> +             ret = ibnbd_dev_blk_open(dev, path, dev->blk_open_flags);
>>> +             if (ret)
>>> +                     goto err;
>>> +
>>> +             ret = ibnbd_dev_vfs_open(dev, path, flags);
>>> +             if (ret)
>>> +                     goto blk_put;
>>
>> This looks really weird. Why to call ibnbd_dev_blk_open() first for file
>> I/O mode? Why to set dev->blk_open_flags to FMODE_READ in file I/O mode?
> 
> The reason behind is we want to be able to symlink to the block device.
> And for File io mode, we only allow exporting block device.

This sounds weird to me ...

>> Please use the in-kernel asynchronous I/O API instead of kernel_read()
>> and kernel_write() and remove the fileio_wq workqueue. Examples of how
>> to use call_read_iter() and call_write_iter() are available in the loop
>> driver and also in drivers/target/target_core_file.c.
>
> What the benefits of using call_read_iter/call_write_iter, does it
> offer better performance?

The benefits of using in-kernel asynchronous I/O I know of are:
* Better performance due to fewer context switches. For the posted code 
as many kernel threads will be active as the queue depth. So more 
context switches will be triggered than necessary.
* Removal the file I/O workqueue and hence a reduction of the number of 
kernel threads.

Thanks,

Bart.
