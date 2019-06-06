Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D331736894
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 02:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfFFADu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 20:03:50 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46482 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfFFADu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 20:03:50 -0400
Received: by mail-ot1-f65.google.com with SMTP id z23so273973ote.13
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 17:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VCqan5aaSRzDRt7Zgnf+r+5VEuOzmoqpGy71Ve+Gmr0=;
        b=dsAqtphKOq9nBwuKPmtrDhsVUpteKankgIpHdm3VO4jiZffsmme42evsAui6qL4q0Y
         2Xqo+5xLkiVDibqyEd+gtBF1MZckiePL5BItR/SjzHIlIwHtUsohFwN4NakY+L66Qrux
         E1pKq2+0kHsT8jVy4RUQZ1inQzFguH47GWzJRbzDOPAjZGK5iepiaGi0AzDehWwYmXVj
         RC6JAVprrZoR9lOfGQWvwPCwboqdQE+opWUNIvNkCKnNw0dJFPHz6NyD5d2RKnjjSBSQ
         e+xH2QhhEfXpzF6F/yFy1ESrqDLX71m8DAOYKCC5zeFpAH2IkhtZcKCJ1IqHTRHHrcD/
         Aqlg==
X-Gm-Message-State: APjAAAXGLwGsvnoV1R0vty2MvVNhL3aigKo0zyKDTwi/IrmxY15d1gBC
        QRD44S337OFU24pYvouRRvI=
X-Google-Smtp-Source: APXvYqwnnaSjbZQeFvfHq/3ZPYT40PFXyBwMNVWKqgC9HlQSmPTFjVoQSVZ+TpZ96q8Pa2URziqaPw==
X-Received: by 2002:a9d:3603:: with SMTP id w3mr4977527otb.108.1559779428950;
        Wed, 05 Jun 2019 17:03:48 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id x91sm87935otb.10.2019.06.05.17.03.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 17:03:48 -0700 (PDT)
Subject: Re: [PATCH 18/20] RDMA/mlx5: Improve PI handover performance
To:     Max Gurtovoy <maxg@mellanox.com>, leonro@mellanox.com,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com,
        hch@lst.de, bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-19-git-send-email-maxg@mellanox.com>
 <b3055107-a91a-a62b-a642-82d14fe3209b@grimberg.me>
 <11c5be7b-05c1-29aa-b407-a4a2655ea288@mellanox.com>
 <cd290591-66f8-6665-90b7-0eb4b4d7ffb4@grimberg.me>
 <5a5e5112-3109-aa9a-899c-6cb54bafc1bb@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b7382272-0d5a-ff46-84b4-d375b87cb1e2@grimberg.me>
Date:   Wed, 5 Jun 2019 17:03:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5a5e5112-3109-aa9a-899c-6cb54bafc1bb@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>>> You just doubled the number of resources (mrs+page_vectors) allocated
>>>> for a performance optimization (25% in large writes). I'm asking myself
>>>> if that is that acceptable? We tend to allocate a lot of those (not to
>>>> mention the target side).
>>>
>>> We're using same amount of mkey's as before (sig + data + meta mkeys 
>>> vs. sig + internal_klm + internal_mtt mkey).
>>
>> But each mkey has twice of mtt/klm space..
> 
> No. It's the same size (I reduced the HCA cap, remember ?)

I see...

So we can drop this...

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
