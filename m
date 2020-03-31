Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69D7C199837
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2020 16:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbgCaONC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Mar 2020 10:13:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44310 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730358AbgCaONB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Mar 2020 10:13:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id b72so10367830pfb.11;
        Tue, 31 Mar 2020 07:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pDPoyb50ipf2PSCWKmSvKKT3EtwQc1EYTQvbcON3/IM=;
        b=AsovXVd5HCIxXMk7LiyBvAUFCDqV8OWSWDWe537ws1aI5yGeRqcOln8aBUkRoRUqYm
         7C3+glxWp9hg7Opw98TfzT+CCZWSk6T8lgfFVbKrSewP8OBb9wVWNX6YLwzJOTtpYdqH
         XD3yIdjJalgQC+N2G5dejF2XBMdjaQKoO0b+yyHGVpia4G22po1aL6Rw/9sYxMd0uDWg
         UODv0AtPej32yFleANKLnn7S80El+OdsOUpsauB/uipPprygCawsCUFx4Mx53FYYfQlM
         JneBjxl51yIhdba/uZKCgSrqi2S3j44nCsJxLA3jqhyp6ojd9XaASSDkE3w8NhE25fVL
         WRbQ==
X-Gm-Message-State: ANhLgQ1Yvt2CCq+gdBUaXh21bWGR2tlsgUY/Qh2S1WuFZi0WVOq3jerU
        qwjrlgIgLpuXDq6yGm6wVGYF61PgaFk=
X-Google-Smtp-Source: ADFU+vud4u/ZVfomi5/aP0XOpttI95G1OGU8F48U6pLW7dFlluEw1mx9ypniq14UBW0ZQPjdHXyajA==
X-Received: by 2002:aa7:9aaa:: with SMTP id x10mr18280549pfi.326.1585663980324;
        Tue, 31 Mar 2020 07:13:00 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:af99:b4cf:6b17:1075? ([2601:647:4000:d7:af99:b4cf:6b17:1075])
        by smtp.gmail.com with ESMTPSA id h64sm12438793pfg.191.2020.03.31.07.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 07:12:59 -0700 (PDT)
Subject: Re: [PATCH v11 18/26] block/rnbd: client: main functionality
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-19-jinpu.wang@cloud.ionos.com>
 <27b4e9a5-826f-d323-3d19-3f64c79e03eb@acm.org>
 <CAMGffEmWPyBAHWJpkVvWuptgoX0tw4rs4jJH1TuJ0jRrkMBdYQ@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a02887c4-2e54-3b55-612a-29721b44eb7b@acm.org>
Date:   Tue, 31 Mar 2020 07:12:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAMGffEmWPyBAHWJpkVvWuptgoX0tw4rs4jJH1TuJ0jRrkMBdYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/31/20 2:25 AM, Jinpu Wang wrote:
> On Sat, Mar 28, 2020 at 5:59 AM Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> On 2020-03-20 05:16, Jack Wang wrote:
>>> +     /*
>>> +      * Nothing was found, establish rtrs connection and proceed further.
>>> +      */
>>> +     sess->rtrs = rtrs_clt_open(&rtrs_ops, sessname,
>>> +                                  paths, path_cnt, RTRS_PORT,
>>> +                                  sizeof(struct rnbd_iu),
>>> +                                  RECONNECT_DELAY, BMAX_SEGMENTS,
>>> +                                  MAX_RECONNECTS);
>>
>> Is the server port number perhaps hardcoded in the above code?
>
> Yes, we should have introduced a module parameter for rnbd-clt too, so
> if admin changes port_nr, it's possible to change it also on rnbd-clt.

What if someone decides to use different port numbers for different rnbd 
servers? Shouldn't the port number be configurable per connection 
instead of making it a kernel module parameter? How about extracting the 
destination port number from the address string like srp_parse_in() does?

Thanks,

Bart.
