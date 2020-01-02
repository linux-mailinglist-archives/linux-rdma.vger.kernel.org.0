Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3746212E90B
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2020 18:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgABRA4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jan 2020 12:00:56 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43593 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728824AbgABRA4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jan 2020 12:00:56 -0500
Received: by mail-pg1-f193.google.com with SMTP id k197so22143307pga.10;
        Thu, 02 Jan 2020 09:00:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5tcamxKhmw09dyh0tkKc3Q6PTV+WMCx9Givmz6S60LQ=;
        b=KOlo3qHbKd7XZqbHzb/9grUodPAk0+Am9zX2BU8lQ1IOww5fpTGqAV7pGm1vR2MbEk
         MK0RaidpSYVJ2WH42AgMANxTywb9KyROAAWInCoX97kduS7dWMjnWpOL8tW2/PxqIXvr
         uyVZnUNpOkSbHagT3U+KkyqjT0rtRTu0vCpa0ebtRO2sXoebpFZtlvy9PCjSAv1M67xJ
         hyCOQ0oYN99os4953FxE4mqwrEsDPiuKSAo+u8KgJGXt5DppQ33LQxlU9yebj4SmzKGe
         L8VVEGi6E2x8lawTxc0R3u6NlSjnwhrJAGsSimKbM4DirHj5w9SthItN1Yb8npPK08QX
         9azw==
X-Gm-Message-State: APjAAAVhtQhcK25R4HTrsoZQ9jqG+t/NKuWJsqVGbTf7mWD7Q9aXy1YF
        vI0L+g9sf/26u7CdYx3GzgE=
X-Google-Smtp-Source: APXvYqwyrBYOaUv7DWqRsHciOcNNNbvHXebcZmqcbPcH8oLGuN4W5bJR8/FM3sEQ8uPbM6rR49OB5w==
X-Received: by 2002:a62:ed19:: with SMTP id u25mr91796220pfh.173.1577984455435;
        Thu, 02 Jan 2020 09:00:55 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b185sm47602432pfa.102.2020.01.02.09.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 09:00:54 -0800 (PST)
Subject: Re: [PATCH v6 03/25] rtrs: private headers with rtrs protocol structs
 and helpers
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-4-jinpuwang@gmail.com>
 <b13eccdd-09a2-70d5-1c78-3c4dbf1aefe8@acm.org>
 <CAMGffEmC3T9M+RmeOXX4ecE3E01azjD8fz2Lz8kHC9Ff-Xx-Aw@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <51f2aec2-db24-ce7b-b3e8-68f9561a584b@acm.org>
Date:   Thu, 2 Jan 2020 09:00:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAMGffEmC3T9M+RmeOXX4ecE3E01azjD8fz2Lz8kHC9Ff-Xx-Aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/2/20 7:27 AM, Jinpu Wang wrote:
> On Mon, Dec 30, 2019 at 8:48 PM Bart Van Assche <bvanassche@acm.org> wrote:
>> On 2019-12-30 02:29, Jack Wang wrote:
>>> +enum {
>>> +     SERVICE_CON_QUEUE_DEPTH = 512,
>>
>> What is a service connection?
> s/SERVICE_CON_QUEUE_DEPTH/CON_QUEUE_DEPTH/g, do you think
> CON_QUEUE_DEPTH is better or just QUEUE_DEPTH?

The name of the constant is fine, but what I meant is the following: has 
it been documented anywhere what the role of a "service connection" is?

>>> +struct rtrs_ib_dev_pool {
>>> +     struct mutex            mutex;
>>> +     struct list_head        list;
>>> +     enum ib_pd_flags        pd_flags;
>>> +     const struct rtrs_ib_dev_pool_ops *ops;
>>> +};
>>
>> What is the purpose of an rtrs_ib_dev_pool and what does it contain?
> The idea was documented in the patchset here:
> https://www.spinics.net/lists/linux-rdma/msg64025.html
> "'
> This is an attempt to make a device pool API out of a common code,
> which caches pair of ib_device and ib_pd pointers. I found 4 places,
> where this common functionality can be replaced by some lib calls:
> nvme, nvmet, iser and isert. Total deduplication gain in loc is not
> quite significant, but eventually new ULP IB code can also require
> the same device/pd pair cache, e.g. in our IBTRS module the same
> code has to be repeated again, which was observed by Sagi and he
> suggested to make a common helper function instead of producing
> another copy.
> '''

The word "pool" suggest ownership. Since struct rtrs_ib_dev_pool owns 
protection domains instead of RDMA devices, how about renaming that data 
structure into rtrs_pd_per_rdma_dev, rtrs_rdma_dev_pd or something 
similar? How about adding a comment like the following above that data 
structure?

/*
  * Data structure used to associate one protection domain (PD) with each
  * RDMA device.
  */

>>> +/**
>>> + * struct rtrs_msg_conn_req - Client connection request to the server
>>> + * @magic:      RTRS magic
>>> + * @version:    RTRS protocol version
>>> + * @cid:        Current connection id
>>> + * @cid_num:    Number of connections per session
>>> + * @recon_cnt:          Reconnections counter
>>> + * @sess_uuid:          UUID of a session (path)
>>> + * @paths_uuid:         UUID of a group of sessions (paths)
>>> + *
>>> + * NOTE: max size 56 bytes, see man rdma_connect().
>>> + */
>>> +struct rtrs_msg_conn_req {
>>> +     u8              __cma_version; /* Is set to 0 by cma.c in case of
>>> +                                     * AF_IB, do not touch that.
>>> +                                     */
>>> +     u8              __ip_version;  /* On sender side that should be
>>> +                                     * set to 0, or cma_save_ip_info()
>>> +                                     * extract garbage and will fail.
>>> +                                     */
>>
>> The above two fields and the comments next to it look suspicious to me.
>> Does RTRS perhaps try to generate CMA-formatted messages without using
>> the CMA to format these messages?
> The problem is in cma_format_hdr over-writes the first byte for AF_IB
> https://www.spinics.net/lists/linux-rdma/msg22397.html
> 
> No one fixes the problem since then.

How about adding that URL to the comment block above struct 
rtrs_msg_conn_req?

>>
>>> +     *errno = -(int)((payload >> 19) & 0x1ff);
>>
>> Is the '(int)' cast useful in the above expression? Can it be left out?
> I think it's necessary, and make it more clear errno is a negative int
> value, isn't it?

According to the C standard operations on unsigned integers "wrap 
around" so removing the cast should be safe. Anyway, this is not 
something I consider important.

Thanks,

Bart.
