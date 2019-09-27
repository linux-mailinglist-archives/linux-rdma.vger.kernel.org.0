Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFF5AC085C
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2019 17:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfI0PLj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Sep 2019 11:11:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37276 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfI0PLi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Sep 2019 11:11:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id y5so1776882pfo.4;
        Fri, 27 Sep 2019 08:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hnkI6n0Ukz1KQ7tR/thot/8ekpUK5f8/fZH4a2RHMwA=;
        b=czGbGCXb4T6F6bcmjoIpyIsgPMywn6kLGg7geYNoZNjMGF3fA6SzDsmoMf9+qlC//v
         LI+oLh2ABB6vbZT137CBN9Lao+n6HTcvf0/m45BHIiYS++fAGU+S21cDGMlhHfAYnoHi
         ta5zIfSSSuH9ypnUtDKxwr6aAl/kfpEiBQwTMJuxHcsPSZrykckPeh9gfBrZOky/qqt5
         tkMtfAatESEVStL9DLakpKYOy8HYkhL7tIz44RNqC/oTPOmvfc+fFB5/T+5n0h6cBV8r
         tduMzImANpVfAG5zAHsEsOartCsYWNwTbVICOMqRKaki/DiqXgMXqjwb+5VPg8pf7/6a
         j6wQ==
X-Gm-Message-State: APjAAAViEpZqjKAPdaMkShHB273Z22X1s4svfMcDodBS8+7EhVqgK9YE
        g8itTxgxO4MNEz8FizxHkOI=
X-Google-Smtp-Source: APXvYqzr3PcpoajXtodlT9Ow11OuUs77nWlrkkMlLiIQ6CBKPnL4N0NNyV2SqyHG9UyZKfrSb3rVLg==
X-Received: by 2002:a63:d111:: with SMTP id k17mr9879774pgg.355.1569597096523;
        Fri, 27 Sep 2019 08:11:36 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 37sm5604187pgv.32.2019.09.27.08.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 08:11:35 -0700 (PDT)
Subject: Re: [PATCH v4 10/25] ibtrs: server: main functionality
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-11-jinpuwang@gmail.com>
 <ab36427b-a737-9544-fbe8-cd53c0780994@acm.org>
 <CAMGffEmuY+ebhJz1iff7Cnb=qdHuhBaSs=DAKP_iKTOb2Ao2PA@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <c8f76dbc-0fb7-e137-3a1c-b72b3ebb5875@acm.org>
Date:   Fri, 27 Sep 2019 08:11:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMGffEmuY+ebhJz1iff7Cnb=qdHuhBaSs=DAKP_iKTOb2Ao2PA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/27/19 8:03 AM, Jinpu Wang wrote:
> On Tue, Sep 24, 2019 at 1:49 AM Bart Van Assche <bvanassche@acm.org> wrote:
>> On 6/20/19 8:03 AM, Jack Wang wrote:
>>> +static char cq_affinity_list[256] = "";
>>
>> No empty initializers for file-scope variables please.
 >
> Is it guaranteed by the compiler, the file-scope variables will be
> empty initialized?

That is guaranteed by the C standard. See also 
https://stackoverflow.com/questions/3373108/why-are-static-variables-auto-initialized-to-zero.

Bart.
