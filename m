Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE561629A3
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 16:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgBRPmj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 10:42:39 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38698 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgBRPmj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 10:42:39 -0500
Received: by mail-qk1-f196.google.com with SMTP id z19so19888725qkj.5
        for <linux-rdma@vger.kernel.org>; Tue, 18 Feb 2020 07:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2mSny5W4Ut3S4FnKOpGpROBN3NZShW8OxUmADLvJA0w=;
        b=ZGue3+Zgf54lu/XTLaRz3WoNQwLBH4Zq5JhhH4PEi7B+Egs/0m9KQ3gFYx96WKwgFU
         SUJ+s8Q167w7ymw1rJo8VkZYc5V1iE5so87UT68+eEBoSzphQkf4SqP/sk+dhPiy5zID
         ZLLvpr2BrhrwRmAGgLiRdb2B2Wf3pWqGKzl2RwdClcSza9q3NUf9QIi9D4B3xQ43vBgU
         3X6+Dolu8+bOezfoU8mV8hhlPceoRgIpfPgfj5WfPeYMny2mb0KbSi7KPv5/fsBHTN9x
         XRcfwOs5to1mbAszBeHT/2elmVsDBXXaIzNdLBUDhbdEMl6nrF9eH9mjILb4WSNpHC8/
         Tygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2mSny5W4Ut3S4FnKOpGpROBN3NZShW8OxUmADLvJA0w=;
        b=jPTxc48o4Wfy9W/5xhIacjjqHo0TA7NS81lzaH05ReLX7tOFQ/dKT84MYB5emHjLHa
         wzoWf9xX6i5E+WJjFDog0J/xlpkY8Iiq2plyWQFSQ9/AJb2UKYfgFED+qbTuyVlGxArl
         4DnoEPK/+HkLbw7VJBtMOWYwbNmobRgaXKtRFMOqEzSzFlQkg0v6VvEP5QVQPfgWJSd0
         aZyUHgpxm/KHhv9D19JSFWkJVQrpPEYeRRCaI28Mb6jNb9L4gDZsS2B2jcxPW4BixLhh
         OqHv0nWATpZ/v6MhqT1le53YTcHhAENB5WSEyPFoHT2MDNBxWefrZokMrlwlAmGHqfmv
         aypg==
X-Gm-Message-State: APjAAAUvD8WSfscAjNPQQXWWqExrPov4kwGclLau1RH279imdLMSfEg4
        GQ1PG/j2dsemdflypHulzI1yRQ==
X-Google-Smtp-Source: APXvYqyNXluVOsAtmx5lDkTx9JhwiUDDRfdxcGLk/HqWdzCKBIhWX5FySS9o1kaxjI5yIVH4DDH3fA==
X-Received: by 2002:a37:b243:: with SMTP id b64mr20384737qkf.164.1582040558234;
        Tue, 18 Feb 2020 07:42:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p50sm2058839qtf.5.2020.02.18.07.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Feb 2020 07:42:37 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j451B-0005gB-FB; Tue, 18 Feb 2020 11:42:37 -0400
Date:   Tue, 18 Feb 2020 11:42:37 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v3 1/2] RDMA/core: Add helper function to
 retrieve driver gid context from gid attr
Message-ID: <20200218154237.GE31668@ziepe.ca>
References: <1582006810-32174-1-git-send-email-selvin.xavier@broadcom.com>
 <1582006810-32174-2-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582006810-32174-2-git-send-email-selvin.xavier@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 17, 2020 at 10:20:09PM -0800, Selvin Xavier wrote:
> Adding a helper function to retrieve the driver gid context
> from the gid attr.
> 
> Suggested-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
>  drivers/infiniband/core/cache.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  include/rdma/ib_cache.h         |  1 +
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> index 17bfedd..1b73a71 100644
> +++ b/drivers/infiniband/core/cache.c
> @@ -973,6 +973,47 @@ int rdma_query_gid(struct ib_device *device, u8 port_num,
>  EXPORT_SYMBOL(rdma_query_gid);
>  
>  /**
> + * rdma_read_gid_hw_context - Read the HW GID context from GID attribute
> + * @attr:		Potinter to the GID attribute
> + *
> + * rdma_read_gid_hw_context() reads the vendor drivers GID HW
> + * context corresponding to SGID attr. It takes reference to the GID
> + * attribute and this need to be released by the caller using
> + * rdma_put_gid_attr
> + *
> + * Returns HW context on success or NULL on error
> + *
> + */
> +void *rdma_read_gid_hw_context(const struct ib_gid_attr *attr)
> +{
> +	struct ib_gid_table_entry *entry =
> +		container_of(attr, struct ib_gid_table_entry, attr);
> +	struct ib_device *device = entry->attr.device;
> +	u8 port_num = entry->attr.port_num;
> +	struct ib_gid_table *table;
> +	unsigned long flags;
> +	void *context = NULL;
> +
> +	if (!rdma_is_port_valid(device, port_num))
> +		return NULL;
> +
> +	table = rdma_gid_table(device, port_num);
> +	read_lock_irqsave(&table->rwlock, flags);
> +
> +	if (attr->index < 0 || attr->index >= table->sz ||
> +	    !is_gid_entry_valid(table->data_vec[attr->index]))
> +		goto done;

Why all this validation and locking? ib_gid_attrs are only created by
the core code..

> +	get_gid_entry(entry);

And why a get? Surely it is invalid to call this function without a
get already held?

Jason
