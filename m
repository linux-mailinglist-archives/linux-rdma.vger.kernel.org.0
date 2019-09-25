Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16DDEBE53C
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2019 20:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfIYSzv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 25 Sep 2019 14:55:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35638 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfIYSzu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Sep 2019 14:55:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id a24so414098pgj.2;
        Wed, 25 Sep 2019 11:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eX5Uew2dci5QScNJhwErgylJ+Lxp35joNvqi9XXn+l8=;
        b=GDP85tGDa+QJf/7jbIww5fDp1L0lXhBKzuTj6yJvAmvIU8gYBALovt/oD/u4czs/tc
         2lDDEEqarQFgA3nmQ+40wChhL83QHrgUJ9mnLBDhlRTruWuMssGB2DfUdZ1A4LIseYwR
         0dmUWK373e+BQvGi/XwpUwxsA76SCmr0Z8gr5XQpK0MqweRXWGtb8bN+7gZJTqk+RNx+
         u7vO8dcHWdJMTX1qUOtU+/BTYuCQIHJEuANFLxuvd421zxELfSVD7+UTfpG3k4JghZe+
         zaGDP1a1shsiQDxz70B8XoPjbQjYJI3/ZCbo+aQEBBg8sP2waD2sVWBdTP1bX/wJXdZw
         n/Gg==
X-Gm-Message-State: APjAAAXWuWwlokP2z5VWaFUqOGgMk9NyO0IBcTxGVpoad71xOLUlnOV9
        /eL2SKfpm3y+/73iuT7gte4=
X-Google-Smtp-Source: APXvYqxzUlDNhoJRu0al5h65oVlGatLhW5KiZyIPOmdDTj5b1ILzoUoWRcQgIRAHqiKC/29o2NstVA==
X-Received: by 2002:a65:6102:: with SMTP id z2mr772367pgu.391.1569437749952;
        Wed, 25 Sep 2019 11:55:49 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c0:5:2d74:bb8d:dd9b:a53e? ([2620:15c:2c0:5:2d74:bb8d:dd9b:a53e])
        by smtp.gmail.com with ESMTPSA id h8sm6241592pfo.64.2019.09.25.11.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 11:55:48 -0700 (PDT)
Subject: Re: [PATCH v4 06/25] ibtrs: client: main functionality
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-7-jinpuwang@gmail.com>
 <d0bc1253-4f3d-981b-97f1-e44900fffb44@acm.org>
 <CAHg0HuzDGgmFKykAmBuAwJXoP1OGq-pQteS=vYMjcbp=cwu9GQ@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ee692ec2-7f65-19f5-f122-fed544074f5f@acm.org>
Date:   Wed, 25 Sep 2019 11:55:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHg0HuzDGgmFKykAmBuAwJXoP1OGq-pQteS=vYMjcbp=cwu9GQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/25/19 10:36 AM, Danil Kipnis wrote:
> On Mon, Sep 23, 2019 at 11:51 PM Bart Van Assche <bvanassche@acm.org> wrote:
>> On 6/20/19 8:03 AM, Jack Wang wrote:
>>> +static void ibtrs_clt_dev_release(struct device *dev)
>>> +{
>>> +     /* Nobody plays with device references, so nop */
>>> +}
>>
>> That comment sounds wrong. Have you reviewed all of the device driver
>> core code and checked that there is no code in there that manipulates
>> struct device refcounts? I think the code that frees struct ibtrs_clt
>> should be moved from free_clt() into the above function.
> 
> We only use the device to create an entry under /sys/class. free_clt()
> is destroying sysfs first and unregisters the device afterwards. I
> don't really see the need to free from the callback instead... Will
> make it clear in the comment.

There is plenty of code under drivers/base that calls get_device() and
put_device(). Are you sure that none of the code under drivers/base will
ever call get_device() and put_device() for the ibtrs client device?

Thanks,

Bart.

