Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9ADE76AC
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 17:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391102AbfJ1QjW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 12:39:22 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46863 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733084AbfJ1QjW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 12:39:22 -0400
Received: by mail-qk1-f195.google.com with SMTP id e66so9055528qkf.13
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 09:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9KsNTBJ6fYfkomOPww0YFjuQOVs1JLXNAN2fMq0txvs=;
        b=oLC4FfxrsYJZLGK3Y0QD9213kqDZw8Lwl1l6ghci8OMnA5kTTbw3FY9Wlo9FwJUlRB
         A2JNa0htrbvd7yW+1cmtT2YtxQlbTQ5akuNIeNityv02zAWLsBepKbsLL766Svu2bR7A
         gntte3tdCfW5lDPP4pjlRQtW6MPWxp5ygeDvd3cfj8vGvWRVRk1lJoQ/owuaYdVWCYum
         yjRq0MHVes+NcYs3iT0GR7fnN1M0I0DxxmO8QiE8altwiySQmZjnBR+Y/fcvOOKLV1FN
         zANYnZujLyNE3KOqAYrFVO79Ya9JxWlEQ0zrB4kpCP+x1n+KrDDkUWNRAe7C8toKlYIw
         KMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9KsNTBJ6fYfkomOPww0YFjuQOVs1JLXNAN2fMq0txvs=;
        b=eCBRJNhn9TxMtaB7OZSZZCS6huLBlLhl4bLFj/kqQQS5sl/CXYA9RQIZhxF//M/mxs
         kc1NnXMGB8CMqFbZbqY0KmTFU/K79YTkGqND1ZQ4wYtKfbGFiKE4lYAwiAI40ZPpDKq/
         ydtuHMSD59tbQIrcATjHNwmnzTDJNqpK+EUoRb2u++n7pfQKlaHvqbbmimCSp1itvuFP
         rZ+cp8qbuAgfUXfVaDhE0JJgLrPIqmuDBejc6jV/alKl9bNqvF8z8BRtYflGM5qRx87T
         S8/639qnr3xI6sNOPoBoqmGfJzfDRmDv4oECm2+OSjElc69ryEs77vbvtE20k4QOQ4dY
         XQIg==
X-Gm-Message-State: APjAAAW6Wv3I0b9+n1lqFQvLyXgCJvEfgipB1xaCJ54jG7EUCp8CjuoM
        VWJW/3EG6A5P8ataLdlymNBQ1g==
X-Google-Smtp-Source: APXvYqzsKRImXnCT+GgV26OwxlrMWN+Y++tvKhFhMquf7M5jnG8J7cxrIwqlOcMdmXgc++YqGUdGWA==
X-Received: by 2002:a37:8b03:: with SMTP id n3mr16466680qkd.493.1572280761588;
        Mon, 28 Oct 2019 09:39:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id b9sm1189750qkk.61.2019.10.28.09.39.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 09:39:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iP836-0001Du-MR; Mon, 28 Oct 2019 13:39:20 -0300
Date:   Mon, 28 Oct 2019 13:39:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@hisilicon.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-rc 0/2] RDMA/hns: Fixes related to 64K page
Message-ID: <20191028163920.GA4672@ziepe.ca>
References: <1571908917-16220-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571908917-16220-1-git-send-email-liweihang@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 24, 2019 at 05:21:55PM +0800, Weihang Li wrote:
> Currently, some configurations can only support 4K page in hip08, this
> series fixes them.
> 
> Lijun Ou (1):
>   RDMA/hns: Fix to support 64K page for srq
> 
> Yangyang Li (1):
>   RDMA/hns: Bugfix for qpc/cqc timer configuration

Applied to for-next

Thanks,
Jason
