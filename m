Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59985BE177
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2019 17:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfIYPiW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Sep 2019 11:38:22 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33142 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfIYPiW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Sep 2019 11:38:22 -0400
Received: by mail-pl1-f196.google.com with SMTP id d22so2636097pls.0;
        Wed, 25 Sep 2019 08:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mwXD8BeUZwOJwA0xYoWQeyeHEZxAfwLDii4KSPni+rE=;
        b=XL1wXjE1kyDU2Te7/wyvcjizsJX/LRzzf9clWuz2VKJgMrGGvDpnt7TDZkfJdUoZWz
         5r3ZIM/GJpjWwJxpufxgQ7LRUzKdVQntC3VOeRldD8oTq4sGNafCBDMrJ5+WjWZr4h5t
         y9fyYRYA+8STlbXuMzDhHGagTkMQ5Lba09bLvDusAfsBQswRhnl5KhnsiGtgq5gO3riY
         23ZJek6yHabb+9JJGduOJNuvV5X16US5TYMdEGnlivVo6BgGqolH8nY5JbMwHc/D0fnw
         vlTTv7JJ5vfS4i/M8jaAvicD0aI9P1XOIELne+Fw+Je6UgW1GLxK2zGxXbnXIo9ONwg8
         fWtw==
X-Gm-Message-State: APjAAAXoC3Fehw/nef8J76JImaTa0z7jI5aM79prtA6Hx5uTybMqxiHd
        KAi8tUZLGuhN/r4QGZ+tlmw=
X-Google-Smtp-Source: APXvYqw2QVx6ZYqb9EVR2ouZUDWypYDS8/Xro7qbOcN/8ZNyD5g2hwr3eOQO/kUUe8DKZVk91ANr2A==
X-Received: by 2002:a17:902:b902:: with SMTP id bf2mr10352442plb.56.1569425901504;
        Wed, 25 Sep 2019 08:38:21 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id l189sm8683645pgd.46.2019.09.25.08.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 08:38:20 -0700 (PDT)
Subject: Re: [PATCH v4 02/25] ibtrs: public interface header to establish RDMA
 connections
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-3-jinpuwang@gmail.com>
 <0607ca2d-6509-69da-4afc-0be6526b11c4@acm.org>
 <CAHg0HuyL2V4YqPFvSzaahGL7vHG5mKybudpxkE3hZYsLg1wM+g@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <7de72505-4e53-3eac-2a63-91cf446a91c7@acm.org>
Date:   Wed, 25 Sep 2019 08:38:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHg0HuyL2V4YqPFvSzaahGL7vHG5mKybudpxkE3hZYsLg1wM+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/25/19 3:20 AM, Danil Kipnis wrote:
> On Mon, Sep 23, 2019 at 7:44 PM Bart Van Assche <bvanassche@acm.org> wrote:
>>> +/**
>>> + * ibtrs_clt_open() - Open a session to a IBTRS client
>>> + * @priv:            User supplied private data.
>>> + * @link_ev:         Event notification for connection state changes
>>> + *   @priv:                  user supplied data that was passed to
>>> + *                           ibtrs_clt_open()
>>> + *   @ev:                    Occurred event
>>> + * @sessname: name of the session
>>> + * @paths: Paths to be established defined by their src and dst addresses
>>> + * @path_cnt: Number of elemnts in the @paths array
>>> + * @port: port to be used by the IBTRS session
>>> + * @pdu_sz: Size of extra payload which can be accessed after tag allocation.
>>> + * @max_inflight_msg: Max. number of parallel inflight messages for the session
>>> + * @max_segments: Max. number of segments per IO request
>>> + * @reconnect_delay_sec: time between reconnect tries
>>> + * @max_reconnect_attempts: Number of times to reconnect on error before giving
>>> + *                       up, 0 for * disabled, -1 for forever
>>> + *
>>> + * Starts session establishment with the ibtrs_server. The function can block
>>> + * up to ~2000ms until it returns.
>>> + *
>>> + * Return a valid pointer on success otherwise PTR_ERR.
>>> + */
>>> +struct ibtrs_clt *ibtrs_clt_open(void *priv, link_clt_ev_fn *link_ev,
>>> +                              const char *sessname,
>>> +                              const struct ibtrs_addr *paths,
>>> +                              size_t path_cnt, short port,
>>> +                              size_t pdu_sz, u8 reconnect_delay_sec,
>>> +                              u16 max_segments,
>>> +                              s16 max_reconnect_attempts);
>>
>> Having detailed kernel-doc headers for describing API functions is great
>> but I'm not sure a .h file is the best location for such documentation.
>> Many kernel developers keep kernel-doc headers in .c files because that
>> makes it more likely that the documentation and the implementation stay
>> in sync.
 >
> What is better: to move it or to only copy it to the corresponding C file?

Please move the kernel-doc header into the corresponding .c file and 
remove the kernel-doc header from the .h file.

Thanks,

Bart.
