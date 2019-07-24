Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCC7B7373A
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2019 21:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfGXTDe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jul 2019 15:03:34 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41623 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfGXTDe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Jul 2019 15:03:34 -0400
Received: by mail-qt1-f196.google.com with SMTP id d17so46506109qtj.8
        for <linux-rdma@vger.kernel.org>; Wed, 24 Jul 2019 12:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JxYMRxDBbiQc911aIAHJmYAqUaYKY3lTrLmxrWOfQDA=;
        b=HYBM8NllR3h5xXaOnsFHsaekf2KO7v9LAlxcKEkHnhnUS91Fv/TZD8mJ+7qcBUrGev
         LU/MQbloVKx38/QnNklnrJLwOZ31JaETEM6L9qzc/Il5aUrUgmK6OGY7XP+gsna8Dyp6
         dwSXzKnoXU5yi2U1bvXt1klu6qb58WYrxQjv3KLleGoSug86dIg4luSmK9H3TEm1hWIS
         xwxL4gpOD4ZYgKHk4oHZGKiWz4JmonqBm81BPeP8K/hqHW9tBrUiB2QB15MwG7pLZvXn
         QXP7kA5l+EX7oTi2D43AIh90C9jsJFUJ58YapyhGGt89ZBiQAJSwnoOvVAJACIWGANy7
         q25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JxYMRxDBbiQc911aIAHJmYAqUaYKY3lTrLmxrWOfQDA=;
        b=qXLNK1kgFy72+Nf5dmkeLerKCgaaXXHRxwzNbnO3CqyH937qjyVYwFzTSdmZSv9WU5
         wTcJPglyRvzC1YCJQL322yGIeKJy3+jgbAmlu20eU28jI8NHt8hc4ABwBBQTB36K2qXz
         GUs6cvmcbyo8mCMr5x44cr7dw8/+kgiq/G8ATa2Shd6oaGDiim50LglE9UxCWJjs18T5
         3whrhKq2PxZBB8XUi5qfPZXptQI+pnXNFOnKDj1yomr9XNr8psp4uUHf7MfeqpmwiGF4
         nzI9884kBZf/lTjkpRalYlADzK9CODauZCCTxc1kKq+5hKv6IApY3vZP4IJx8f1gaJfU
         Youw==
X-Gm-Message-State: APjAAAW4La+bVkAej0t5Gk6FdUXjAPfGET4nOEizHlsNh9eTtalPP3s/
        70R+nwtVKUL88NDx1Fuxm3TOs7/TkSLTBA==
X-Google-Smtp-Source: APXvYqwIOGqxuNv4C1NUqdT2MjDRL5kDCXzqkjV+EBeUxQJWSwnUe75k0rTTBHGZMNHGgeQt07425g==
X-Received: by 2002:ac8:70d1:: with SMTP id g17mr59814923qtp.124.1563995013065;
        Wed, 24 Jul 2019 12:03:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id a67sm22207335qkg.131.2019.07.24.12.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 12:03:32 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hqMXz-0006W9-Tm; Wed, 24 Jul 2019 16:03:31 -0300
Date:   Wed, 24 Jul 2019 16:03:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Expose device statistics
Message-ID: <20190724190331.GA25015@ziepe.ca>
References: <20190707142038.23191-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190707142038.23191-1-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 07, 2019 at 05:20:38PM +0300, Gal Pressman wrote:
> Expose hardware statistics through the sysfs api:
> /sys/class/infiniband/efa_0/hw_counters/*.
> 
> Reviewed-by: Firas JahJah <firasj@amazon.com>
> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa.h         |  3 +
>  drivers/infiniband/hw/efa/efa_com_cmd.c | 35 +++++++++++
>  drivers/infiniband/hw/efa/efa_com_cmd.h | 23 +++++++
>  drivers/infiniband/hw/efa/efa_main.c    |  2 +
>  drivers/infiniband/hw/efa/efa_verbs.c   | 79 +++++++++++++++++++++++++
>  5 files changed, 142 insertions(+)

Am I right that this patch needs 

https://patchwork.kernel.org/patch/11053949/

before it won't crash?

Jason
