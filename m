Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5B818A975
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 00:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgCRXtl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 19:49:41 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:34054 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbgCRXtk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Mar 2020 19:49:40 -0400
Received: by mail-qv1-f67.google.com with SMTP id o18so89164qvf.1
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2020 16:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x8b6+B0ZmGbe/KsLpXXCgEez+7ji4ZVNHFWJbYGybDw=;
        b=UYvHH4eZJ7A3yCDKmkY5vTTbYfMrkFQgWDvVCFefYJgzH9R5exqNMOIlm1gMBtqUmK
         KVcRDaYWZasrNGQHN0yKEAsNvFIwaPUPUtJQ5uMg+9atY+EhNqUHU3CUpTgRObM3Fa6X
         KM5GfvBKOEQ9dV6sAPF1E6OYpbRVyDUiKw8iuvpVj9L1wF/ztc/MhM5+8DazpqYU35B2
         B2zCI4ekJThcRxz8M/DrslKEYRY1m+kdYobqtqHIUYbTdMcFVmr4NgzkY0XKo1WJ991z
         WlDoB32+MWOWtN/f6Xrpnx7rTNUKu1iLpNE+zMh7qZW5vKNgTU5QElAg0A9pe5/csJcE
         mZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x8b6+B0ZmGbe/KsLpXXCgEez+7ji4ZVNHFWJbYGybDw=;
        b=cSBR33oqT5qC/KE9cn1vbXniz96h5xJ7w1yzv9u1GLbhh99xwjIcWVxI3IqbVlgsOl
         y5jDSKj1Ncr9vle65mf3HOqV1nN6kqZNvvyh7Za8X4SD5IG+pMqwxBx45nfVbJtbAx4E
         EjlAwWtcbKMjgUne2PXwxRIAx9X9e4GzcTnugVTFGdqZQZhW/GtYlI3OAoHsM9TwqnZN
         5Gvip8gagzxw7Vt/T+z69yrcU9BkimjkFmYrsD6QBT/FldeEyZ0CDgVj38xQJLOnmJ+d
         is8tY32xXJONSsrGkof3Mf6ZO6znZxhilOmOR4UL8AdlXSqU6KiylvCJmdrQhDFNpVLU
         MG0w==
X-Gm-Message-State: ANhLgQ1XacApO0B2lqYmBsFmrhd7csLn2ItlicY5OA5eULAOIXIFCqgR
        5AByM7OTfn+1YHBV+Q/j/unerQ==
X-Google-Smtp-Source: ADFU+vtMh3MpGKyMT4gES+QNvHlF4xhsL17r187tjiZZRiM38bPC6nmRpMqywEmt/goIVNjPq4cVKA==
X-Received: by 2002:a05:6214:205:: with SMTP id i5mr437502qvt.223.1584575379907;
        Wed, 18 Mar 2020 16:49:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id u40sm232547qtc.62.2020.03.18.16.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 16:49:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jEiRO-0005Hj-Vb; Wed, 18 Mar 2020 20:49:38 -0300
Date:   Wed, 18 Mar 2020 20:49:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Subject: Re: [PATCH for-rc] IB/hfi1: Insure pq is not left on waitlist
Message-ID: <20200318234938.GA19965@ziepe.ca>
References: <20200317160510.85914.22202.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317160510.85914.22202.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 17, 2020 at 12:05:10PM -0400, Dennis Dalessandro wrote:
> +static void flush_pq_iowait(struct hfi1_user_sdma_pkt_q *pq)
> +{
> +	unsigned long flags;
> +	seqlock_t *lock = pq->busy.lock;
> +
> +	if (!lock)
> +		return;
> +	write_seqlock_irqsave(lock, flags);
> +	if (!list_empty(&pq->busy.list)) {
> +		list_del_init(&pq->busy.list);
> +		pq->busy.lock = NULL;
> +	}
> +	write_sequnlock_irqrestore(lock, flags);

I'm trying to grasp how a seqlock is protecting a list_empty and
list_del_init, and this seems.. uh.. insane?

The only place that uses seqlock in infiniband is in hfi1

It only calls seqlock_init and write_seqlock

Never read_seqlock

So, this isn't a seqlock, it is a normal spinlock obfuscated as a
seqlock.

Please clean this mess too.

I don't know what to do with this patch, it might well be functionally
right, but everything about reading it screams wrong wrong wrong. I
don't want to send it to Linus in -rc like this.

At least add something to the commit message asking temporary
forgiveness for this madness.

Also s/insure/ensure/, right?

Jason
