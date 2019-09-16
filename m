Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C090B3BB3
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2019 15:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfIPNpU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Sep 2019 09:45:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39867 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbfIPNpU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Sep 2019 09:45:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so33555pgi.6;
        Mon, 16 Sep 2019 06:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VQG7ALu4L/cSp4xpQkyFn1+C4l/g5Dbj9fB6d8n56Fk=;
        b=cd9vhQptq/E+/WcLZ11LVsI2SCRzQ4QZZ9uy5npR/IBgoV9y1CGMD25xjxtwXDcPhp
         NHRlQtz9HopW7BvNlhyrrGUW3xvLlRrDbLyfjPRtiVnvrz/0Q1tWj72yiKtpIPfU30IB
         Mry9okiB2wCwyBHp+QCn/Zy+XCnNdtqRy8k2sD+JzNlgV11YKKYmxX6rlxL50ogNozZ9
         lCPUTdcrZ4KF891OfaAWBkpzVGduqDR2Y64y/wTIu34pM1PHgh5tCPrB4d/nMrNpZIZP
         OEgCHa1MJpW9hvbqfxOSJttYyIiV7b6Sa2OWmno6dgRyu8dt4iIo01yPMK+DwfuJ5g6l
         7NOA==
X-Gm-Message-State: APjAAAVXw4q/p977JY/gmMGTap9xC1r/bNSd02mr0t/YAB9J22dHVDa9
        UmDgWoag/ChQKRoJdZ5seUt5MB/K
X-Google-Smtp-Source: APXvYqwl1GQ9X2TO7CvGZbc5So/gBQqguRdquR/9cCBbTE1nYdqX1XDTyFYJgCupgi9JYMIKYcAy3g==
X-Received: by 2002:a17:90a:154f:: with SMTP id y15mr57814pja.73.1568641519431;
        Mon, 16 Sep 2019 06:45:19 -0700 (PDT)
Received: from asus.site ([2601:647:4000:1bdb:75d0:9089:df96:87d3])
        by smtp.gmail.com with ESMTPSA id 37sm20295087pgv.32.2019.09.16.06.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 06:45:18 -0700 (PDT)
Subject: Re: [PATCH v4 15/25] ibnbd: private headers with IBNBD protocol
 structs and helpers
To:     Leon Romanovsky <leon@kernel.org>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>
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
 <20190916052729.GB18203@unreal>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <25bd79e1-9523-8354-873a-0ff1db92659a@acm.org>
Date:   Mon, 16 Sep 2019 06:45:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916052729.GB18203@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/15/19 10:27 PM, Leon Romanovsky wrote:
> On Sun, Sep 15, 2019 at 04:30:04PM +0200, Jinpu Wang wrote:
>> On Sat, Sep 14, 2019 at 12:10 AM Bart Van Assche <bvanassche@acm.org> wrote:
>>>> +/* TODO: should be configurable */
>>>> +#define IBTRS_PORT 1234
>>>
>>> How about converting this macro into a kernel module parameter?
>> Sounds good, will do.
> 
> Don't rush to do it and defer it to be the last change before merging,
> this is controversial request which not everyone will like here.

Hi Leon,

If you do not agree with changing this macro into a kernel module 
parameter please suggest an alternative.

Thanks,

Bart.
