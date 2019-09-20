Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4B7BB944C
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2019 17:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393523AbfITPmR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Sep 2019 11:42:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37618 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391417AbfITPmQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Sep 2019 11:42:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id b10so3365512plr.4;
        Fri, 20 Sep 2019 08:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5k0Hu7l3DB3jRw+ooV6mnNF37HqLQwv8COStuG71sZ8=;
        b=BZ4j9grosqv1YQIhliQUvV8SIxv7teEfhu8+opvV4qZw42ikIFXMkCHOMtyRFjJG4h
         XTU8awVGYMvyW9uQ2DoAXHfWKW7hBqv0W0LEnQfyvoxH6VKZ1tHtvX+KgY0ZFbldXxpG
         d0dhjG6cliqfSoKpmPIVW/xIsjWq6mz+y70liviRdQU9z4WpHOGLPvPZE7v4h8ZQVvCl
         jfsksXis0ldzGHoDEzsl8wWgnK479Ki9ioxrHUMGwolcVZEW+2yTGfcMcw87NWKDW3hH
         utvGINl3X5fQZ18pp0NQFqyXYcnohLK/agidh0D1lqGjBnF9GFLoW2Bm3FTkEXj+Wkjf
         8F4w==
X-Gm-Message-State: APjAAAUl6gz8kfCfxMJBEsgPJXKmNE9hPOUfSNCSNEAh39qH2rKs+pKa
        dZzlI4+rwRQR9lo1T9GXvR4=
X-Google-Smtp-Source: APXvYqwHqVTt2crG6TDYmodv+VSYzm7WIYYYgdumgCr77pq+xmF6WVqVrNNO+9zBw0dFcwe5WlXRMg==
X-Received: by 2002:a17:902:b097:: with SMTP id p23mr18048328plr.261.1568994135216;
        Fri, 20 Sep 2019 08:42:15 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 7sm2630484pfi.91.2019.09.20.08.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 08:42:14 -0700 (PDT)
Subject: Re: [PATCH v4 20/25] ibnbd: server: main functionality
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-21-jinpuwang@gmail.com>
 <5ceebb9c-b7ae-8e0c-6f07-d83e878e23d0@acm.org>
 <CAHg0Huw8Sk-ORjDaFDsTiL00nfsHru20MpNqGmWrCa_pSWuQSQ@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ed4555f4-fbc3-a3f5-7180-69064452e377@acm.org>
Date:   Fri, 20 Sep 2019 08:42:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHg0Huw8Sk-ORjDaFDsTiL00nfsHru20MpNqGmWrCa_pSWuQSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/20/19 12:36 AM, Danil Kipnis wrote:
> On Wed, Sep 18, 2019 at 7:41 PM Bart Van Assche <bvanassche@acm.org> wrote:
>> On 6/20/19 8:03 AM, Jack Wang wrote:
>>> +static int process_msg_sess_info(struct ibtrs_srv *ibtrs,
>>> +                              struct ibnbd_srv_session *srv_sess,
>>> +                              const void *msg, size_t len,
>>> +                              void *data, size_t datalen)
>>> +{
>>> +     const struct ibnbd_msg_sess_info *sess_info_msg = msg;
>>> +     struct ibnbd_msg_sess_info_rsp *rsp = data;
>>> +
>>> +     srv_sess->ver = min_t(u8, sess_info_msg->ver, IBNBD_PROTO_VER_MAJOR);
>>> +     pr_debug("Session %s using protocol version %d (client version: %d,"
>>> +              " server version: %d)\n", srv_sess->sessname,
>>> +              srv_sess->ver, sess_info_msg->ver, IBNBD_PROTO_VER_MAJOR);
>>
>> Has this patch been verified with checkpatch? I think checkpatch
>> recommends not to split literal strings.
> 
> Yes it does complain about our splitted strings. But it's either
> splitted string or line over 80 chars or "Avoid line continuations in
> quoted strings" if we use backslash on previous line. I don't know how
> to avoid all three of them.

Checkpatch shouldn't complain about constant strings that exceed 80 
columns. If it complains about such strings then that's a checkpatch bug.

Bart.
