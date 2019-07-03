Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBE415EDE4
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 22:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfGCUvy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jul 2019 16:51:54 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46469 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfGCUvx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jul 2019 16:51:53 -0400
Received: by mail-ot1-f68.google.com with SMTP id z23so3778320ote.13
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jul 2019 13:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zW1OwnYVOooizraWdaGGJJpOfe0feNTO95gb0InqYU0=;
        b=JU/G4KlCf5+qIg2c/GtWp5H/XiDUv/70KDD4HoqCo/T0qtrc5tuzuVlXnYJu80Co9r
         K2GuokAtnIxYEJuIM/2MWzNgaAR8jmWTsFogXcLgbpZrT483mS2PIROSd562LeNIlYKj
         CaohSvxXNvrs5VOO7u5pwa+hOCqfJo2E5IFqvr+Ut6Q/I6IKtAJJTgEutFFOub3tQ9wl
         7Y0PNUjY//KPCBjPgQBauGq3fcq4Sz4R5LUQMULRGa5oHHVJM6i5NL6EhxPtjCKa8bXf
         rhSKRFmkDgCO3HMV8gYSk3DOhyA5V+6yb4PZ+2Pwf/m3iLm/9bOmZvOA7j6GA2nI2T/n
         jijg==
X-Gm-Message-State: APjAAAXmdWOo0NuJ5LXl/27CDcF98Ou5Jh7uoaJkQ4cVJhN5sN23gwH8
        +E0zuveBg/6xgjgAp74Og3o=
X-Google-Smtp-Source: APXvYqxht4FztF21IKWHJbXlcXztJjQ74V6WGu1IiODWdBqpwmtdZAYki/WU6+jRx6rvviIdFjczVA==
X-Received: by 2002:a9d:144:: with SMTP id 62mr26565224otu.180.1562187113234;
        Wed, 03 Jul 2019 13:51:53 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id y184sm1033194oie.33.2019.07.03.13.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 13:51:52 -0700 (PDT)
Subject: Re: [PATCH rdma-next v3 1/3] linux/dim: Implement RDMA adaptive
 moderation (DIM)
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Yamin Friedman <yaminf@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>
References: <20190630091057.11507-1-leon@kernel.org>
 <20190630091057.11507-2-leon@kernel.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2b8e1c1c-a80a-bf02-0ca7-5124bcef2419@grimberg.me>
Date:   Wed, 3 Jul 2019 13:51:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190630091057.11507-2-leon@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> From: Yamin Friedman <yaminf@mellanox.com>
> 
> RDMA DIM implements a different algorithm from net DIM and is based on
> completions which is how we can implement interrupt moderation in RDMA.
> 
> The algorithm optimizes for number of completions and ratio between
> completions and events. In order to avoid long latencies, the
> implementation performs fast reduction of moderation level when the
> traffic changes.
> 
> Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
> Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>   include/linux/dim.h |  36 +++++++++++++++
>   lib/dim/Makefile    |   6 +--
>   lib/dim/rdma_dim.c  | 108 ++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 146 insertions(+), 4 deletions(-)
>   create mode 100644 lib/dim/rdma_dim.c
> 
> diff --git a/include/linux/dim.h b/include/linux/dim.h
> index aa9bdd47a648..1ae32835723a 100644
> --- a/include/linux/dim.h
> +++ b/include/linux/dim.h
> @@ -82,6 +82,7 @@ struct dim_stats {
>    * @prev_stats: Measured rates from previous iteration (for comparison)
>    * @start_sample: Sampled data at start of current iteration
>    * @work: Work to perform on action required
> + * @dim_owner: A pointer to the struct that points to dim
>    * @profile_ix: Current moderation profile
>    * @mode: CQ period count mode
>    * @tune_state: Algorithm tuning state (see below)
> @@ -95,6 +96,7 @@ struct dim {
>   	struct dim_sample start_sample;
>   	struct dim_sample measuring_sample;
>   	struct work_struct work;
> +	void *dim_owner;

This is different than the net consumers that init an embedded dim
struct. I imagine that the reason is to not have this dim space in every
ib_cq struct?

Would suggest to name it to 'priv' or 'dim_priv'

Otherwise,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
