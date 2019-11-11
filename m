Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56C95F6F35
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Nov 2019 08:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfKKHqT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Nov 2019 02:46:19 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56058 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfKKHqT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Nov 2019 02:46:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so12145065wmb.5
        for <linux-rdma@vger.kernel.org>; Sun, 10 Nov 2019 23:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EI8aChzwfAWkyMCZFCy4LE3/+zUA+FObXBInOoUvoJs=;
        b=I6l+X27r8WsuxZH9ZPwTY3OpBDeB8W4Pq+R+qkYF8St87HjbG1Wqjm+uKVw8AnwQVV
         FJ6dpmkPzO8icBsSo2GrHDWV0IP9ERt9oF9z+/7KyqSUcbgb2ow6isEmmafk6KKkmKAZ
         g3fTIP5htUrnVod2adwRGTXeJL19If6+0HaMhdBmxC7IBx/KAr07fRZnEDXr6/1YjcoA
         ZO8DaTxBGBk1/J6UlMWx76bVBfAl84U9pqy9rAhnTaRq6ag9NziejTeG6fXT8CaWaZL9
         TRNvJkd1XURnb3KNcBg04zNDZuD6BEnXZKQagMddsoDtQ1Q42INmvCodTsENwljSiNbR
         AAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EI8aChzwfAWkyMCZFCy4LE3/+zUA+FObXBInOoUvoJs=;
        b=WEsJ7voIHHuCKXXbH6cXkDeqRnHVTk8HVy1deZwnDQB0JO3apvQOvLgiScroj6XwL5
         hphAKuitSTGw6OOE0bchBpl7Q6NUJqzOjCE4XXuRG/z6qjvRy1dMPxH3J3FYITlTWMWK
         zU12HXGQKXbjGGr/Au7QopSGDrEX7D6y22cxwLfVEmy3h2TMRJ8ytaMGWY+Jvu/k8YxB
         7vzjK/NsWrvbctDsSbGMKTqcd5yKRV351ecqLRppQSnSLAjAd8Q2r8O5G2v+ZrqpBY/M
         BVeKm34R3Rd9BvDCN817LHvDc7RQ3aFDulnMZaEOKNEt+nE376OTBZEFKMf0JTvMdVAG
         r8ag==
X-Gm-Message-State: APjAAAUHqZ8qlucoPDBWLXUJRe3HNI9PCpk6KHuHctBpdboeX/vovl0t
        a/vcLk0h6x13lJpV5Ggx5TDm3P4XPzQ=
X-Google-Smtp-Source: APXvYqwZDGYrWjh4QySPtj1LH+MOg7ciBDpudRJfLglUoq4TKF2NfSLr6+XcdUr8UxVXgKcPwRftmQ==
X-Received: by 2002:a7b:c747:: with SMTP id w7mr20367155wmk.62.1573458376923;
        Sun, 10 Nov 2019 23:46:16 -0800 (PST)
Received: from [10.80.2.221] ([193.47.165.251])
        by smtp.googlemail.com with ESMTPSA id v8sm20955617wra.79.2019.11.10.23.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 23:46:16 -0800 (PST)
Subject: Re: [PATCH rdma-core 0/6] verbs: Custom parent-domain allocators
To:     linux-rdma@vger.kernel.org
Cc:     Yishai Hadas <yishaih@mellanox.com>, haggaie@mellanox.com,
        jgg@mellanox.com, maorg@mellanox.com
References: <1572254099-30864-1-git-send-email-yishaih@mellanox.com>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <47e62c53-2032-bdb6-e288-d1dbcc9b0e9f@dev.mellanox.co.il>
Date:   Mon, 11 Nov 2019 09:46:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1572254099-30864-1-git-send-email-yishaih@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/28/2019 11:14 AM, Yishai Hadas wrote:
> This series extends the parent domain object with custom allocation callbacks
> that can be used by user-applications to override the provider allocation.
> 
> This can be used for example to add NUMA aware allocation.
> 
> The API was introduced in the mailing list by the below RFC [1] and was
> implemented by mlx5 provider.
> 
> A detailed man page exists as part of the series to describe the usage and the
> behavior.
> 
> A PR was sent as well [2].
> 
> [1] https://www.spinics.net/lists/linux-rdma/msg84590.html
> [2] https://github.com/linux-rdma/rdma-core/pull/596
> 
> Haggai Eran (1):
>    verbs: custom parent-domain allocators
> 
> Yishai Hadas (5):
>    Update kernel headers
>    mlx5: Extend mlx5_alloc_parent_domain() to support custom allocator
>    mlx5: Add custom allocation support for QP and RWQ buffers
>    mlx5: Add custom allocation support for DBR
>    mlx5: Add custom allocation support for SRQ buffer
> 
>   kernel-headers/rdma/ib_user_ioctl_verbs.h  |  22 ++++++
>   kernel-headers/rdma/rdma_user_ioctl_cmds.h |  22 ------
>   libibverbs/man/ibv_alloc_parent_domain.3   |  54 +++++++++++++++
>   libibverbs/verbs.h                         |  12 ++++
>   providers/mlx5/buf.c                       |  59 +++++++++++++++++
>   providers/mlx5/cq.c                        |   2 +-
>   providers/mlx5/dbrec.c                     |  34 +++++++++-
>   providers/mlx5/mlx5.h                      |  23 ++++++-
>   providers/mlx5/mlx5dv.h                    |   6 ++
>   providers/mlx5/srq.c                       |  25 +++++--
>   providers/mlx5/verbs.c                     | 103 ++++++++++++++++++++---------
>   11 files changed, 297 insertions(+), 65 deletions(-)
> 

The PR was merged, thanks.

Yishai
