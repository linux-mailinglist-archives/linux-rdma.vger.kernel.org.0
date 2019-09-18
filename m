Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD11BB670E
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Sep 2019 17:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbfIRP0p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Sep 2019 11:26:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41609 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbfIRP0o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Sep 2019 11:26:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so34522pgg.8;
        Wed, 18 Sep 2019 08:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LiAWN9xORF5xFL1JkWkW/9SG66pr86a0+pRqejPd480=;
        b=XaSZ/TWsDUgqsagB9dEfwjvTpGSvorvAV1wIHHsCCyxW64Ki/2ydr991J8yFnJt6tE
         fewToVOs9+y1ltFdFEE6jKr5+U7NK3zm0vHWwfvTY8RFnzfV1BCmLrcj9SKqzseAvU35
         ePR3i93NIg/J9ofEODMbYFoi798YW16IPZJTzeJ4tNEquA8qLfBrcCbiJPRd/rBjSBJV
         D5jir5vlxFai5QVI2GPF8tSfkpNOv1eIO4OxDoaUJuno4+IiwSA1TUGL40ZIZdUT/XPu
         6yBMrGU0hHw+ZX00Om7z8jeAVAcYP2MjvkxIOixQuWL9R99N4G14ZICkZGAFuX7tLc9x
         byzA==
X-Gm-Message-State: APjAAAXes3uMFJA2Ce2GwhWLqeq1TyuI2CVmDeQbXX3qnEDFuqp+CRjr
        ev/RzTpjK0/0Xno4exvo16I=
X-Google-Smtp-Source: APXvYqwJHAUTD10zmU3ovj2Iq95Th7CemQfRKfGZtJAD1OgQmP2ykY90nHlBMWj/MOriee05BBRKig==
X-Received: by 2002:a63:4c5c:: with SMTP id m28mr4733884pgl.333.1568820403481;
        Wed, 18 Sep 2019 08:26:43 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id s3sm3739294pjq.32.2019.09.18.08.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 08:26:42 -0700 (PDT)
Subject: Re: [PATCH v4 15/25] ibnbd: private headers with IBNBD protocol
 structs and helpers
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-16-jinpuwang@gmail.com>
 <4fbad80b-f551-131e-9a5c-a24f1fa98fea@acm.org>
 <CAMGffEnVFHpmDCiazHFX1jwi4=p401T9goSkes3j1AttV0t1Ng@mail.gmail.com>
 <CAMGffE=Vsbv5O7rCSq_ymA-UXPaSWT_bMfZ+AK-2f1Z=zMMtyQ@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <66dcf1ac-53b8-aa0c-cda2-4919281500d0@acm.org>
Date:   Wed, 18 Sep 2019 08:26:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMGffE=Vsbv5O7rCSq_ymA-UXPaSWT_bMfZ+AK-2f1Z=zMMtyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/16/19 8:39 AM, Jinpu Wang wrote:
> - Roman's pb emal address, it's no longer valid, will fix next round.
> 
> 
>>>
>>>> +static inline const char *ibnbd_io_mode_str(enum ibnbd_io_mode mode)
>>>> +{
>>>> +     switch (mode) {
>>>> +     case IBNBD_FILEIO:
>>>> +             return "fileio";
>>>> +     case IBNBD_BLOCKIO:
>>>> +             return "blockio";
>>>> +     case IBNBD_AUTOIO:
>>>> +             return "autoio";
>>>> +     default:
>>>> +             return "unknown";
>>>> +     }
>>>> +}
>>>> +
>>>> +static inline const char *ibnbd_access_mode_str(enum ibnbd_access_mode mode)
>>>> +{
>>>> +     switch (mode) {
>>>> +     case IBNBD_ACCESS_RO:
>>>> +             return "ro";
>>>> +     case IBNBD_ACCESS_RW:
>>>> +             return "rw";
>>>> +     case IBNBD_ACCESS_MIGRATION:
>>>> +             return "migration";
>>>> +     default:
>>>> +             return "unknown";
>>>> +     }
>>>> +}
>>>
>>> These two functions are not in the hot path and hence should not be
>>> inline functions.
>> Sounds reasonable, will remove the inline.
> inline was added to fix the -Wunused-function warning  eg:
> 
>    CC [M]  /<<PKGBUILDDIR>>/ibnbd/ibnbd-clt.o
> In file included from /<<PKGBUILDDIR>>/ibnbd/ibnbd-clt.h:34,
>                   from /<<PKGBUILDDIR>>/ibnbd/ibnbd-clt.c:33:
> /<<PKGBUILDDIR>>/ibnbd/ibnbd-proto.h:362:20: warning:
> 'ibnbd_access_mode_str' defined but not used [-Wunused-function]
>   static const char *ibnbd_access_mode_str(enum ibnbd_access_mode mode)
>                      ^~~~~~~~~~~~~~~~~~~~~
> /<<PKGBUILDDIR>>/ibnbd/ibnbd-proto.h:348:20: warning:
> 'ibnbd_io_mode_str' defined but not used [-Wunused-function]
>   static const char *ibnbd_io_mode_str(enum ibnbd_io_mode mode)
> 
> We have to move both functions to a separate header file if we really
> want to do it.
> The function is simple and small, if you insist, I will do it.

Please move these functions into a .c file. That will reduce the size of 
the kernel modules and will also reduce the size of the header file.

Thanks,

Bart.

