Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10825175F46
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 17:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgCBQNM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 11:13:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41775 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgCBQNM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Mar 2020 11:13:12 -0500
Received: by mail-pf1-f193.google.com with SMTP id j9so5775464pfa.8;
        Mon, 02 Mar 2020 08:13:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3+dIBAApkK6uKRLL0kbVD638hNHlpBx3vySmZQs4F6E=;
        b=bLlRMKsko172PR9wf4YG9vMod2HI8T1CrQ8O8jmJyEyMvbIB4d0Zsx4eiQ9JUprAe1
         WrD4nNCnA48vNNQ9yNROzlgloeOxbxwQk/M6KM8sfivc6OoSkbpqbiW2iA2FszqpfGmL
         vboCj9U89DEiOG7n9vrOxo2louyWkN0+glqd6wZVTzds7CLVgR8GuMpiDVCxoBW5zYbV
         x4rhHT4D9I3iCukqLD5OjXUaq2yLtcYOVaUJ9K9694ozi2nFEu5+LEVl2q2l2qjeWDFE
         XuD5aaY75J//l/n6id7nLrpTZsUAYCurfbLV6bJMR/oX1Utc5QIgreNyfJLYiwE7cwQv
         vR+w==
X-Gm-Message-State: APjAAAU77EPY9jb1zdpEL2wdrhXHGrPA9Lj4992HjN5a2psdX4mJ0dRV
        4Rxf4pBKuqboRAsfUVKrdRk=
X-Google-Smtp-Source: APXvYqwf/oN0E2PCDuYpDsOXptxDOZ4CtnMUFC8N/KNI5toReQSMOm0ZWsXcRj0zIbuyKmRnMybQqw==
X-Received: by 2002:a63:8148:: with SMTP id t69mr20017889pgd.187.1583165591682;
        Mon, 02 Mar 2020 08:13:11 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id w1sm21963031pgr.4.2020.03.02.08.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 08:13:10 -0800 (PST)
Subject: Re: [PATCH v9 05/25] RDMA/rtrs: client: private header with client
 structs and functions
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
References: <20200221104721.350-1-jinpuwang@gmail.com>
 <20200221104721.350-6-jinpuwang@gmail.com>
 <eb1759a7-c51b-eaeb-f353-4b948b1d64e3@acm.org>
 <CAMGffEmM8dtcO=uYg5drafaz5FjGV4ynQBpyGZFZwVMptgxcBw@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <fc0c1962-d5d6-96c0-cd5b-3e51a1aeb98e@acm.org>
Date:   Mon, 2 Mar 2020 08:13:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMGffEmM8dtcO=uYg5drafaz5FjGV4ynQBpyGZFZwVMptgxcBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/2/20 5:49 AM, Jinpu Wang wrote:
> On Sun, Mar 1, 2020 at 1:51 AM Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> On 2020-02-21 02:47, Jack Wang wrote:
>>> +struct rtrs_clt {
>>> +     struct list_head   /* __rcu */ paths_list;
>>
>> The commented out __rcu is confusing. Please remove it and add an
>> elaborate comment if paths_list is a list head with nonstandard behavior.
> Will change to a normal comment, we want to use rculist, but no such
> annotation usage for normal list_head, only hlist_head in kernel tree,
> Do you know why?

Hi Jack,

I'm not aware of any annotation for RCU lists nor for RCU list elements 
that is recognized by sparse. What I do myself is to add a comment to 
each list_head that explains whether it represents a list head or a list 
element and also what the strategy is for ensuring thread-safety.

Thanks,

Bart.

