Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 414AEC0A1D
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2019 19:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfI0RQc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Sep 2019 13:16:32 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36552 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfI0RQc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Sep 2019 13:16:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id f19so1352045plr.3;
        Fri, 27 Sep 2019 10:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RNfU8SMnxj+higWP0jV8ynN/lW/e0hOoNDbR3t713zo=;
        b=lIEKSsgV6WVwYYze9xLZwYxndKC2iV3LjEv+Yfh8wRc9R4/x41jkUz6r1Sl1K1mMbS
         RR+vG5rFrCFAzgaOWtYvPxRJld9c3C8cj0RNKAe1GeCVWOCX4/Ksaz9DPOGxR2h8T/9r
         fC4T0uSZlhOMWR7FKiXwZP90dbWe/PdqkQqx3WG0foxUpZrQhJaSumDxfQVGKyjJpYJk
         UONeNLTAn8bbRmMdKRfBB8wjznXCPd4wsTjjqMabJBXUAUfbdPvrkIdY8LoYOeKugJWm
         WSQTKaBWZLYsjQNktpsCvp7XkpK7eBTpJi7K9x7j97FsvbqeoA7Lv/Zk8l4L+Weof0Pd
         piZQ==
X-Gm-Message-State: APjAAAW0rvdX4ys8GfyTdIiWWbRqXGcq57hEoUu69vs7QWA5APfgwu1i
        NdLzuEjQGKDTMm+f6fORLUE=
X-Google-Smtp-Source: APXvYqzcL/Tqhb5gG2ywYAm1G7rYdRw8swzeDVXQKsFWKzH09mnNAcXt+jlZgTP9aiz8MZHqn+AKJw==
X-Received: by 2002:a17:902:d681:: with SMTP id v1mr5972574ply.310.1569604591178;
        Fri, 27 Sep 2019 10:16:31 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id i1sm4345760pfg.2.2019.09.27.10.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 10:16:30 -0700 (PDT)
Subject: Re: [PATCH v4 17/25] ibnbd: client: main functionality
To:     Roman Penyaev <r.peniaev@gmail.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-18-jinpuwang@gmail.com>
 <bd8963e2-d186-dbd0-fe39-7f4a518f4177@acm.org>
 <CAHg0HuwzHnzPQAqjtYFTZb7BhzFagJ0NJ=pW=VkTqn5HML-0Vw@mail.gmail.com>
 <5c5ff7df-2cce-ec26-7893-55911e4d8595@acm.org>
 <CAHg0HuwFTVsCNHbiXW20P6hQ3c-P_p5tB6dYKtOW=_euWEvLnA@mail.gmail.com>
 <CAHg0HuzQOH4ZCe+v-GHu8jOYm-wUbh1fFRK75Muq+DPpQGAH8A@mail.gmail.com>
 <6f677d56-82b3-a321-f338-cbf8ff4e83eb@acm.org>
 <CAHg0HuxvKZVjROMM7YmYJ0kOU5Y4UeE+a3V==LNkWpLFy8wqtw@mail.gmail.com>
 <CACZ9PQU6bFtnDUYtzbsmNzsNW0j1EkxgUKzUw5N5gr1ArEXZvw@mail.gmail.com>
 <e2056b1d-b428-18c7-8e22-2f37b91917c8@acm.org>
 <CACZ9PQU8=4DaSAUQ7czKdcWio2H5HB1ro-pXaY2VP9PhgTxk7g@mail.gmail.com>
 <b31be034-eae0-77f7-aabf-92c8f8a984e5@acm.org>
 <CACZ9PQWTBiYbjYa=s9+QOWXXr+_hNP5VYP_mC2wi5VJZLTE_kw@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <84f5e08b-9586-8e6d-3e35-ce6f1976ba31@acm.org>
Date:   Fri, 27 Sep 2019 10:16:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACZ9PQWTBiYbjYa=s9+QOWXXr+_hNP5VYP_mC2wi5VJZLTE_kw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/27/19 9:50 AM, Roman Penyaev wrote:
> On Fri, Sep 27, 2019 at 6:37 PM Bart Van Assche <bvanassche@acm.org> wrote:
>> I agree that BLK_MQ_F_HOST_TAGS partitions a tag set across hardware
>> queues while ibnbd shares a single tag set across multiple hardware
>> queues. Since such sharing may be useful for other block drivers, isn't
>> that something that should be implemented in the block layer core
>> instead of in the ibnbd driver? If that logic would be moved into the
>> block layer core, would that allow to reuse the queue restarting logic
>> that already exists in the block layer core?
> 
> Definitely yes, but what other block drivers you have in mind?

I'd like to hear the opinion of Jens and Christoph about this topic. My 
concern is that if the code for sharing a tag set across hwqs stays in 
the ibnbd driver and if another block driver is submitted in the future 
that needs the same logic that in order to end up with a single 
implementation of the tag set sharing code that the authors of the new 
driver would have to be asked to modify the ibnbd driver. I think it 
would be inappropriate to ask the authors of such a new driver to modify 
the ibnbd driver.

Bart.

