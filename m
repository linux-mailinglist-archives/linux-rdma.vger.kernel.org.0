Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9511612FA20
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 17:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgACQME (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 11:12:04 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46377 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbgACQMD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 11:12:03 -0500
Received: by mail-pg1-f196.google.com with SMTP id z124so23602161pgb.13;
        Fri, 03 Jan 2020 08:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=na72982VyaZ2LIwSLngfXzsK0lJgFaHfmVBR9ya1hCo=;
        b=dzjUv+mqunuuYRZDxGlawcDd+iZglrqDCmkrTj+jHIVgfBmq17WPbHHKXllraequdM
         EUe1iDbGN8SARaUUBAg20n/3vgkZVU6nvDAXkiLaCR/Kd+vi6xftGgvtJMATlglgdQv9
         rFX8iyiDxS99vz9NGX0bbH/7pMH3qwv0bUkI/esEL+DUCUYUdCJHdEJ6frkVjkxm/QTy
         Z25fGRdk4tkcvJLHqGqdUVJvYv1IsJLbMZL0oPeHUR1zqiJ51ACqKflAZrB4dN8t9mk2
         3NAsSmA3+3RXDU9TiRBNR1f0C3fFRWKskGm/2vpygy/itPH7VHeJ0eXwv5aWF0HwynpS
         vsDg==
X-Gm-Message-State: APjAAAXBjsNTQ9AGxx1JZCJWPe8RHgThtbvO8vTdJ5qRA6dUoHaN+Hi/
        rji20AR6i/OTyaDmUHr71g4=
X-Google-Smtp-Source: APXvYqwWAYT/GnTJM8wEO0GZXNORoFyi9KblFSX9KUSi7kdhaOuHsbBOL086oILeosgxkDVmqhCGAA==
X-Received: by 2002:a63:da14:: with SMTP id c20mr74166351pgh.280.1578067923183;
        Fri, 03 Jan 2020 08:12:03 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id a195sm69152196pfa.120.2020.01.03.08.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2020 08:12:01 -0800 (PST)
Subject: Re: [PATCH v6 06/25] rtrs: client: main functionality
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-7-jinpuwang@gmail.com>
 <e242c08f-68e0-49b7-82e6-924d0124b792@acm.org>
 <CAMGffEn3M=E=77z5DqE_sohFuoct=2cctpgTAky6GHkDKGJ2cw@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b583b3db-8bc0-31e9-8d6a-5286f5a870de@acm.org>
Date:   Fri, 3 Jan 2020 08:12:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAMGffEn3M=E=77z5DqE_sohFuoct=2cctpgTAky6GHkDKGJ2cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/3/20 6:30 AM, Jinpu Wang wrote:
> On Tue, Dec 31, 2019 at 12:53 AM Bart Van Assche <bvanassche@acm.org> wrote:
>> On 2019-12-30 02:29, Jack Wang wrote:
>>> +static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
>>> +                           bool notify, bool can_wait)
>>> +{
>>> +     struct rtrs_clt_con *con = req->con;
>>> +     struct rtrs_clt_sess *sess;
>>> +     int err;
>>> +
>>> +     if (WARN_ON(!req->in_use))
>>> +             return;
>>> +     if (WARN_ON(!req->con))
>>> +             return;
>>> +     sess = to_clt_sess(con->c.sess);
>>> +
>>> +     if (req->sg_cnt) {
>>> +             if (unlikely(req->dir == DMA_FROM_DEVICE && req->need_inv)) {
>>> +                     /*
>>> +                      * We are here to invalidate RDMA read requests
>>> +                      * ourselves.  In normal scenario server should
>>> +                      * send INV for all requested RDMA reads, but
>>> +                      * we are here, thus two things could happen:
>>> +                      *
>>> +                      *    1.  this is failover, when errno != 0
>>> +                      *        and can_wait == 1,
>>> +                      *
>>> +                      *    2.  something totally bad happened and
>>> +                      *        server forgot to send INV, so we
>>> +                      *        should do that ourselves.
>>> +                      */
>>
>> Please document in the protocol documentation when RDMA reads are used.
> We don't use RDMA READ, it's requested RDMA read meaning, server side will do
> RDMA write to the buffers.

Please make the comment more clear. The comment says "RDMA read" twice.

Thanks,

Bart.
