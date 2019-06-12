Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F13F442503
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 14:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438466AbfFLMIE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 08:08:04 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42596 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436551AbfFLMIE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jun 2019 08:08:04 -0400
Received: by mail-qk1-f195.google.com with SMTP id b18so9935815qkc.9
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jun 2019 05:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6NOeCBOrnBN0RlmAADU+m3uzIx8oDA95tOg6QXSnSmk=;
        b=FUsucM0vbLBFRiGfEx4qHdE+losYgcDKwv+ykgVpuzBzJFjlhTraEhG4VdaD1+OL0L
         JID1uJR/dTgRfyTEVCBW77l/oNUNUz8TaLRErZD23mhMSGQU4j89xf29BTdtZA0l9IaL
         NnkJbiybo05fQg1Kjs/XG3sAv7f3OkfttrWCXQNxpYO1S/G+YkAx25UsrbEv4rLscAEE
         82jC1+ZcIW+fF7h9JpsLD7RILceSd+kH2aKYXzovdA2W+k0u+HvBHMcfegcV2Y3nNEVF
         dh+8q+rhGJQeNIVLq8E9BD3p3vPB46KrT6m5qoFcBWajLKAZaCAivsdZVjS356iXBmY3
         OBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6NOeCBOrnBN0RlmAADU+m3uzIx8oDA95tOg6QXSnSmk=;
        b=aYQW7rbTQZ6Mgd5UxdkByvDiQXMdRFhzWUCyUDgA4kCQwit/R7QqnUs/6hnL4GLczu
         QyMa+EMsm0yFrCGywXG42KZuZvXxyfQ9qfGgR+qP91KfL12YmvSddX5s5hN7O768uVQj
         t2iwNab5RkJBTHuUWzjKiQ32NsGLPH9CEHkSertgWo5Fkh26WCeARF5pA0qL0/2obtaR
         hbQjZz099a5HW+dOxLTRlbMjZxDigk1zFcU2qCFymKNl9gXJQFC6a/nay+cQd3VLGDc7
         X+m6ydaftVvmfaoxAyl9zCklBxD+YW8KEq9J+Y3r42hbvMQMdh5S9rnsSRVPCRYGy9B9
         mSfw==
X-Gm-Message-State: APjAAAVkKqggOqAvQWwQDDWJxA7iwol3v7V1ufh6Ktp7f4DQNJbwjgkK
        SAVigWVkvVNyuwi3XMJOp2/IKw==
X-Google-Smtp-Source: APXvYqxzDKa1Pnbe4ZvLLSe5dWy27ZlSHxeqpR1fzEI1tSMBKWdjniZlLhyLICMD1Aae/SGwKrZbTw==
X-Received: by 2002:a05:620a:15d3:: with SMTP id o19mr46494877qkm.213.1560341283009;
        Wed, 12 Jun 2019 05:08:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id k6sm7887218qkd.21.2019.06.12.05.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 05:08:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hb22s-0002VB-33; Wed, 12 Jun 2019 09:08:02 -0300
Date:   Wed, 12 Jun 2019 09:08:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mark Zhang <markz@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-next v3 09/17] IB/mlx5: Support statistic q counter
 configuration
Message-ID: <20190612120802.GE3876@ziepe.ca>
References: <20190606105345.8546-1-leon@kernel.org>
 <20190606105345.8546-10-leon@kernel.org>
 <20190611175419.GA19838@ziepe.ca>
 <285c454e-2a20-d9e0-56a4-7738dd375d17@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <285c454e-2a20-d9e0-56a4-7738dd375d17@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 12, 2019 at 12:01:23PM +0000, Mark Zhang wrote:
> On 6/12/2019 1:54 AM, Jason Gunthorpe wrote:
> > On Thu, Jun 06, 2019 at 01:53:37PM +0300, Leon Romanovsky wrote:
> >> From: Mark Zhang <markz@mellanox.com>
> >>
> >> Add support for ib callbacks counter_bind_qp() and counter_unbind_qp().
> >>
> >> Signed-off-by: Mark Zhang <markz@mellanox.com>
> >> Reviewed-by: Majd Dibbiny <majd@mellanox.com>
> >> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >>   drivers/infiniband/hw/mlx5/main.c | 53 +++++++++++++++++++++++++++++++
> >>   1 file changed, 53 insertions(+)
> >>
> >> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> >> index 8b7bcf8f68fb..66c94a060718 100644
> >> +++ b/drivers/infiniband/hw/mlx5/main.c
> >> @@ -5533,6 +5533,57 @@ static int mlx5_ib_get_hw_stats(struct ib_device *ibdev,
> >>   	return num_counters;
> >>   }
> >>   
> >> +static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
> >> +				   struct ib_qp *qp)
> >> +{
> >> +	struct mlx5_ib_dev *dev = to_mdev(qp->device);
> >> +	u16 cnt_set_id = 0;
> >> +	int err;
> >> +
> >> +	if (!counter->id) {
> >> +		err = mlx5_cmd_alloc_q_counter(dev->mdev,
> >> +					       &cnt_set_id,
> >> +					       MLX5_SHARED_RESOURCE_UID);
> >> +		if (err)
> >> +			return err;
> >> +		counter->id = cnt_set_id;
> >> +	}
> >> +
> >> +	err = mlx5_ib_qp_set_counter(qp, counter);
> >> +	if (err)
> >> +		goto fail_set_counter;
> >> +
> >> +	return 0;
> >> +
> >> +fail_set_counter:
> >> +	mlx5_core_dealloc_q_counter(dev->mdev, cnt_set_id);
> >> +	counter->id = 0;
> >> +
> >> +	return err;
> >> +}
> >> +
> >> +static int mlx5_ib_counter_unbind_qp(struct ib_qp *qp, bool force)
> >> +{
> >> +	struct mlx5_ib_dev *dev = to_mdev(qp->device);
> >> +	struct rdma_counter *counter = qp->counter;
> >> +	int err;
> >> +
> >> +	err = mlx5_ib_qp_set_counter(qp, NULL);
> >> +	if (err && !force)
> >> +		return err;
> >> +
> >> +	/*
> >> +	 * Deallocate the counter if this is the last QP bound on it;
> >> +	 * If @force is set then we still deallocate the q counter
> >> +	 * no matter if there's any error in previous. used for cases
> >> +	 * like qp destroy.
> >> +	 */
> >> +	if (atomic_read(&counter->usecnt) == 1)
> >> +		return mlx5_core_dealloc_q_counter(dev->mdev, counter->id);
> > 
> > This looks like a nonsense thing to write, what it is trying to do
> > with that atomic?
> > 
> > I still can't see why this isn't a normal kref.
> > 
> 
> Hi Jason,
> 
> Have discussed with Leon, unlike other resources, counter alloc/dealloc 
> isn't called explicitly. So we need a refcount to record how many QPs 
> are bound on this counter, when it comes to 0 then the counter can be 
> deallocated. Whether to use atomic or kref the code is similar, it is 
> not able to take advantage of kref/completion.

That doesn't explain the nonsense "atomic_read(&counter->usecnt) == 1"
test

Jason
