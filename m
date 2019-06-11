Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA3293D4EF
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 20:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406714AbfFKSEs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 14:04:48 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40030 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406724AbfFKSEr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jun 2019 14:04:47 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so15636528qtn.7
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jun 2019 11:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gTLBnYmDTqLRnXGqlTV+plX2ZSXK+alt7I/LDiXycoc=;
        b=d8Q4727jqUVQYarH4H8ldSsS7yIfhBPlxpnR7BWblmr2zHQTu0E616eNTTmVJ+e2UK
         w57eXt2AtCnZEnAAI5cAm+x/NSbZNqhxhs6vMBF4uvnIDGhAmm2NN6RFLxKEqxwrz5VA
         D4tkZyKDptyV4gqYtZzDrfq/TjdQ4Mt4hCxUFJPQfIj9TtwVha6BRDW958VRyZ7nc2a2
         vJAs9wOjFHE3Y4pjpJ4u/MkLPD/9mABhAEoDo9O2RlcPTNNWKat/RTjkMt6tQ6Jveum3
         UWlVmblDDcI5zAvhZ9EPgZZBDtAzYzfr717Z6/z7sW6Y8prid6wVY7c34SsW+FMncYjx
         Pc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gTLBnYmDTqLRnXGqlTV+plX2ZSXK+alt7I/LDiXycoc=;
        b=W8gN5m5TIB4/WXjnP5WyMWIuGXPpQCXOjocumFLU9Thb/FY8DJ0cfkmiJ50b4otj1S
         uUgba5/uT0ANCZw7ZKpFKZCVvj6JY5lkQOagPyl1SGHFmrIFAg8Oi0IHIjujGCetR890
         k68nugUih+wzRe3MRZZ1OTcYvm8Xbucsig7ctgINnNT07LWUvV983LPa7j3K/hXhwb3q
         VNHSmRPE3eRvx2n64UKoX33Zi8Mbqbk13JVL76QBXZetPSMSwRxp6njzqJf1VItceoIw
         xvLddLLO+RZRfoy2qsC48QisIVe4yN3SllFOH7AxorSLsep0mDxVIJIgkdcx3x4bOwYy
         9JQg==
X-Gm-Message-State: APjAAAUqPYP5XkuutETADaMtMB1g2CFSVNZguKl0qsFUUkuoZylb+CSq
        2rak2YhCY+uW0xvh0XqyEWzXRXefb6MkKA==
X-Google-Smtp-Source: APXvYqzJAOgnfn/ovKgJCFst1kxpnuP6NqdDmiS67jWrkJPxxft6Twj4UrwiURaUtz84/tPAzvh0uQ==
X-Received: by 2002:ac8:2439:: with SMTP id c54mr32728313qtc.160.1560276286900;
        Tue, 11 Jun 2019 11:04:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id h26sm4911088qta.58.2019.06.11.11.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Jun 2019 11:04:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hal8Y-0005G8-1k; Tue, 11 Jun 2019 15:04:46 -0300
Date:   Tue, 11 Jun 2019 15:04:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-next v3 13/17] RDMA/core: Get sum value of all
 counters when perform a sysfs stat read
Message-ID: <20190611180446.GA20174@ziepe.ca>
References: <20190606105345.8546-1-leon@kernel.org>
 <20190606105345.8546-14-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606105345.8546-14-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 06, 2019 at 01:53:41PM +0300, Leon Romanovsky wrote:
> @@ -302,6 +318,46 @@ int rdma_counter_query_stats(struct rdma_counter *counter)
>  	return ret;
>  }
>  
> +static u64 get_running_counters_hwstat_sum(struct ib_device *dev,
> +					   u8 port, u32 index)
> +{
> +	struct rdma_restrack_entry *res;
> +	struct rdma_restrack_root *rt;
> +	struct rdma_counter *counter;
> +	unsigned long id = 0;
> +	u64 sum = 0;
> +
> +	rt = &dev->res[RDMA_RESTRACK_COUNTER];
> +	xa_lock(&rt->xa);
> +	xa_for_each(&rt->xa, id, res) {
> +		counter = container_of(res, struct rdma_counter, res);
> +		if ((counter->device != dev) || (counter->port != port) ||
> +		    rdma_counter_query_stats(counter))
> +			continue;

rdma_counter_query_stats has:

int rdma_counter_query_stats(struct rdma_counter *counter)
+{
+	struct ib_device *dev = counter->device;
+	int ret;
+
+	if (!dev->ops.counter_update_stats)
+		return -EINVAL;
+
+	mutex_lock(&counter->lock);
+	ret = dev->ops.counter_update_stats(counter);
+	mutex_unlock(&counter->lock);

so again, this can't work and would blow up with lockdep if it was
ever tested. xa_lock is a spinlock, you can't nest mutex's inside
spinlocks.

Check all the xa_lock for this. No idea why you are not catching this
during testing. Maybe some might_sleeps() are needed.

Jason
