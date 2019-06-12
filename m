Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72C4642A11
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 16:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438144AbfFLO5w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 10:57:52 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37688 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436945AbfFLO5w (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jun 2019 10:57:52 -0400
Received: by mail-qt1-f193.google.com with SMTP id y57so18863406qtk.4
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jun 2019 07:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BwBlPXdSCryD3x+1tbBO8hZdMEj6Rzb+S71oL8LDE00=;
        b=gDOjXffxisp8Bwl9zggIIIA2bZBdyehE3iHzmcrla9jPr6X+N7uaiEYBnmfS8KjPqh
         yBDk9e4+IGw7+WJoMDKu3UuS4IAuVm0Dfd7Xr5GUt+XEDKxsJhyEYoiV5CDPUy9100Q8
         xzxWwfjzw0oslCOjNxKlIQIMHsDqovzzNu3HTOKD7IdjjrpKoRW6xZo8/IKO2RmmL7J8
         jRnj5ybzRiGou3tapT9v4XDIKc9qL+x9Th3rxu+gsFmCqcfPIZMeIlddCOSyfnucM+Q/
         Uy8pb8Fxt4ZWs49W75UNyaOXf6FW1QTyGVi9Ljm9EvlkfjIG94LGIb+9D/XAgiODi91Y
         ccRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BwBlPXdSCryD3x+1tbBO8hZdMEj6Rzb+S71oL8LDE00=;
        b=toj61XdNgMuageGstbw2HxCehFJVA+ihk66qIU6JbtjlZTAjrR11WcD1IhBbWqC908
         m5CamAHJIsFF5jNtBWAOgnSei47REJhk1wp/AY2uCw46Ov6K1xTo/U6MHBOr0txzNVxo
         E2PjxK8QoLovMvT4b2DZ4f7e7f291gLzas8m1hXmOdr1QLsy1TCTm9CFqky4+t12EO2C
         guFx6DcuNT5/8+efZynuZaxDbEgo5eEnE75v79IjDhJTnWIzMjtbVAW2MOkt0Vo1n1+y
         XpJklTPK3joRAiIZ9Gz9RN5BEVJitfkv+6h9renqY1uyZU7Ep8f528X11u2AzbkhRlZg
         mf5w==
X-Gm-Message-State: APjAAAVc8y9ZJBfuRMYUnl2mjaVARzxSg2z+4+78qrV2yQxDG7T18JLe
        VZMHHFl5sDg4b07ZGD2w0YxtzQ==
X-Google-Smtp-Source: APXvYqzvyY7yG/KSov715iOif+B7bV36JccgvV5wSWwtWjYiq/QXDZyGLGFyUAiCRZLPEl+w0C6XAQ==
X-Received: by 2002:ac8:c45:: with SMTP id l5mr55148988qti.63.1560351471461;
        Wed, 12 Jun 2019 07:57:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id d3sm11904qti.40.2019.06.12.07.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 07:57:51 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hb4hC-0003hs-DD; Wed, 12 Jun 2019 11:57:50 -0300
Date:   Wed, 12 Jun 2019 11:57:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mark Zhang <markz@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-next v3 09/17] IB/mlx5: Support statistic q counter
 configuration
Message-ID: <20190612145750.GG3876@ziepe.ca>
References: <20190606105345.8546-1-leon@kernel.org>
 <20190606105345.8546-10-leon@kernel.org>
 <20190611175419.GA19838@ziepe.ca>
 <285c454e-2a20-d9e0-56a4-7738dd375d17@mellanox.com>
 <20190612120802.GE3876@ziepe.ca>
 <20190612121227.GQ6369@mtr-leonro.mtl.com>
 <20190612134440.GF3876@ziepe.ca>
 <847457f6-e1df-2f4e-e86c-f53ec5879455@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <847457f6-e1df-2f4e-e86c-f53ec5879455@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 12, 2019 at 02:47:20PM +0000, Mark Zhang wrote:
> >>>>>> +static int mlx5_ib_counter_unbind_qp(struct ib_qp *qp, bool force)
> >>>>>> +{
> >>>>>> +	struct mlx5_ib_dev *dev = to_mdev(qp->device);
> >>>>>> +	struct rdma_counter *counter = qp->counter;
> >>>>>> +	int err;
> >>>>>> +
> >>>>>> +	err = mlx5_ib_qp_set_counter(qp, NULL);
> >>>>>> +	if (err && !force)
> >>>>>> +		return err;
> >>>>>> +
> >>>>>> +	/*
> >>>>>> +	 * Deallocate the counter if this is the last QP bound on it;
> >>>>>> +	 * If @force is set then we still deallocate the q counter
> >>>>>> +	 * no matter if there's any error in previous. used for cases
> >>>>>> +	 * like qp destroy.
> >>>>>> +	 */
> >>>>>> +	if (atomic_read(&counter->usecnt) == 1)
> >>>>>> +		return mlx5_core_dealloc_q_counter(dev->mdev, counter->id);
> >>>>>
> >>>>> This looks like a nonsense thing to write, what it is trying to do
> >>>>> with that atomic?
> >>>>>
> >>>>> I still can't see why this isn't a normal kref.
> >>>>>
> >>>>
> >>>> Hi Jason,
> >>>>
> >>>> Have discussed with Leon, unlike other resources, counter alloc/dealloc
> >>>> isn't called explicitly. So we need a refcount to record how many QPs
> >>>> are bound on this counter, when it comes to 0 then the counter can be
> >>>> deallocated. Whether to use atomic or kref the code is similar, it is
> >>>> not able to take advantage of kref/completion.
> >>>
> >>> That doesn't explain the nonsense "atomic_read(&counter->usecnt) == 1"
> >>> test
> >>
> >> It means that all QPs "returned" this counter.
> > 
> > It doesn't make sense to do something like that with an atomic, either
> > you know there is no possible atomic_inc/dec at this point (which begs the
> > question why test it), or it is racy
> > 
> 
> How about add a new parameter "last_qp", if it is true then deallocate 
> the counter? So that the "atomic_read()" check can be performed in core 
> layer.

Maybe, but there still needs to be some kind of locking protecting
parallel aomtic_inc/dec

I still think this should be a kref.

Jason
