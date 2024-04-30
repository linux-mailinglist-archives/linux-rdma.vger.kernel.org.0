Return-Path: <linux-rdma+bounces-2161-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5598B7678
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 14:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43911C20E5E
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 12:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B35F171672;
	Tue, 30 Apr 2024 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Rw92ooLQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767DD17166D
	for <linux-rdma@vger.kernel.org>; Tue, 30 Apr 2024 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481845; cv=none; b=HxsqJyWQ4B69EvKtXDrEaI2BTltuWah6gIVKThwW5p+3TiTz5AOJkypVf5hf7NRjSEiR7CcfFV22I1eTJKlsP7w2M+T551mYGCJtJrb5y904j8tE7NuwGrI8s7F5bUXHf03/W3Ji8XA3FR8PkqjT53AsGrrHUjfJPoaNEDUcQ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481845; c=relaxed/simple;
	bh=6QT0q2O5P7yUDN49ZBaxXbsmzFoWw+mrdy57yktGL+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozimGxuEwenLa8VeFxJYUHAUIeaQQYiVDZrtO0O0igD4Xvtux6MC6kY6DW1bKZUHGZfj2vIHMG85rd6yJivgrooLVxBMoLA0azJed8xnaCRD8O2ZBlE05GHy5hpYIhGsDxKQf3LxBko4UQnThwHCvH3qCzRt8D/C59NbFbp3j00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Rw92ooLQ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2b276bf78a4so578313a91.3
        for <linux-rdma@vger.kernel.org>; Tue, 30 Apr 2024 05:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714481843; x=1715086643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5uLT2hc2nyqyVJ8rbCN78QLwond+XzmKAS1fxzjXQbI=;
        b=Rw92ooLQioQENzl7PwwfVO4eEzyem5+Qyj7SKzanUTPqXnDhqPVJU3sbqAlgCHJAhf
         c0pjUwNB75mmNPUI6Ue7SfMRuiXnKf79wB6uwTetqaaBpmJFCgnf2jY/YsWmU/15tes0
         ZKToB4V2+qtBkBbfrJNFJdd1PgvfCOMq1Mjrqz/XgsmI3FDGe5Z/um8fVP5a0RGjF53T
         q5g9YVZ/fO0fVOlJpdYv/QdyEug2De9XVX7dCnU4FUG24MCXbWOVkvKBflKiN/bDkX3J
         0UqEAkS2b84/wIhXzQQwCrBWPtWNNcPk95RCUAdaXFQoQ3PPmezt9N+PyEyI9IHlyiwt
         5HCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714481843; x=1715086643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uLT2hc2nyqyVJ8rbCN78QLwond+XzmKAS1fxzjXQbI=;
        b=VIpXwhOyxQ4+wefzTdWrQkiEi4U1IWynZN7e9cuOh0LS+xOS8BtilEAcK/pp+I7Avq
         3Kib+sKXNvAyI9WbbuXcSrWhNE8LmunPdY6JhSyDjW961egZ8wGQg6BQ6tJAz2M92LzB
         ikdXoTJRQiQvVeo63jKh2wp8tX6DF4HuIL1Oav6olSqIFrcQq89K/Hc0m5hgnpy7Btur
         qCUsPJOWBMeAtk8GzTMxc7B2ScjGMjY9GlMbB4eIs9tBpJSTkg52muZ63acL6mveSS2m
         1BDLb8D7+GD7AGrdgZxSCG/pLYPxZKjcMmmjdP2KsKFYPlEo9u5GoOk/kxb6kDRK2NaH
         gYcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM1QHZNLxPZ30pyN04L3xz2NklJio5rR+VT7bGuPWNFyERLkwyEa/ntlSBiACZY9jau9Th3H5PtYEJK+DWSQVhoBvwhl4kiqrQGQ==
X-Gm-Message-State: AOJu0Yw17st5/J2JFxjpJPx0afz8P14M7hnseMqjKTr1cVCTFvmC/u5Q
	pDnWtbgPB6QTl4t1z+Uvq/TdL/03F0hLTzTI0z59SHmwnDtBv42xb91NtCd2P43/74ut/G6LrLL
	x9hI=
X-Google-Smtp-Source: AGHT+IEj+uWnR47Gzrthf1B7PKB4MKEOP/aomUlBZht7YwI1FpOC6x4BCa+6YhpjM40KQjA9TFAHzQ==
X-Received: by 2002:a17:90a:9318:b0:2a5:4105:186c with SMTP id p24-20020a17090a931800b002a54105186cmr13296149pjo.9.1714481842724;
        Tue, 30 Apr 2024 05:57:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id nv5-20020a17090b1b4500b002a2f055e52csm22551280pjb.34.2024.04.30.05.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:57:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s1n2u-0072aA-Gm;
	Tue, 30 Apr 2024 09:57:20 -0300
Date: Tue, 30 Apr 2024 09:57:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next 6/6] RDMA/mana_ib: implement uapi for creation
 of rnic cq
Message-ID: <20240430125720.GT231144@ziepe.ca>
References: <1713459125-14914-1-git-send-email-kotaranov@linux.microsoft.com>
 <1713459125-14914-7-git-send-email-kotaranov@linux.microsoft.com>
 <SJ1PR21MB345775858C05B9FE51C2BDF0CE112@SJ1PR21MB3457.namprd21.prod.outlook.com>
 <20240430123715.GD100414@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430123715.GD100414@unreal>

On Tue, Apr 30, 2024 at 03:37:15PM +0300, Leon Romanovsky wrote:
> On Tue, Apr 23, 2024 at 11:57:53PM +0000, Long Li wrote:
> > > Subject: [PATCH rdma-next 6/6] RDMA/mana_ib: implement uapi for creation
> > > of rnic cq
> > > 
> > > From: Konstantin Taranov <kotaranov@microsoft.com>
> > > 
> > > Enable users to create RNIC CQs.
> > > With the previous request size, an ethernet CQ is created.
> > > Use the cq_buf_size from the user to create an RNIC CQ and return its ID.
> > > 
> > > Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> > > ---
> > >  drivers/infiniband/hw/mana/cq.c | 56 ++++++++++++++++++++++++++++++---
> > >  include/uapi/rdma/mana-abi.h    |  7 +++++
> > >  2 files changed, 59 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/hw/mana/cq.c
> > > b/drivers/infiniband/hw/mana/cq.c index 8323085..a62bda7 100644
> > > --- a/drivers/infiniband/hw/mana/cq.c
> > > +++ b/drivers/infiniband/hw/mana/cq.c
> > > @@ -9,17 +9,25 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> > > ib_cq_init_attr *attr,
> > >  		      struct ib_udata *udata)
> > >  {
> > >  	struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
> > > +	struct mana_ib_create_cq_resp resp = {};
> > > +	struct mana_ib_ucontext *mana_ucontext;
> > >  	struct ib_device *ibdev = ibcq->device;
> > >  	struct mana_ib_create_cq ucmd = {};
> > >  	struct mana_ib_dev *mdev;
> > > +	bool is_rnic_cq = true;
> > > +	u32 doorbell;
> > >  	int err;
> > > 
> > >  	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
> > > 
> > > -	if (udata->inlen < sizeof(ucmd))
> > > +	cq->comp_vector = attr->comp_vector % ibdev->num_comp_vectors;
> > > +	cq->cq_handle = INVALID_MANA_HANDLE;
> > > +
> > > +	if (udata->inlen < offsetof(struct mana_ib_create_cq, cq_buf_size))
> > >  		return -EINVAL;
> > > 
> > > -	cq->comp_vector = attr->comp_vector % ibdev->num_comp_vectors;
> > > +	if (udata->inlen == offsetof(struct mana_ib_create_cq, cq_buf_size))
> > > +		is_rnic_cq = false;
> > 
> > I think it's okay with checking on offset in uapi message to decide if this is a newer/updated RNIC uverb.

Yes, this is the expected method

> You should really try to avoid changing MANA_IB_UVERBS_ABI_VERSION as it
> usually means that backward compatibility will be broken after such change.

Yes, please don't do that.

Jason

