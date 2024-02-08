Return-Path: <linux-rdma+bounces-963-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 341B084D6D6
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 01:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53A9283E39
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 00:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0A11E534;
	Thu,  8 Feb 2024 00:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VV9rhDBO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990B01E49D
	for <linux-rdma@vger.kernel.org>; Thu,  8 Feb 2024 00:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707350528; cv=none; b=QfUzJFKqgB/MJCnuT3iNK5+tG6+oCy2NC1ajTcaNtT96cBhE35C3sujRSl0UEOzpB6ZGxxo3jbXn8/3Tio0cTE+k09++PVhNytg++VOWwMNNOQXbEgVf3zdOMn+p9IT9ktFlUs9Wgmb7NFnkU2GHOUB7y5x0daJQllvGQjuvVu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707350528; c=relaxed/simple;
	bh=jU9UPU6CCOx0Ms/+32B+CPrNzUSW9uHfWHU/Fsh2shM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U58Bl9upEILuQ+dNXrVYcTsDRJD+ln2kaWoCsTtbRNPmItZwYVM8uzn09JJ9s1TEUkw9TBj6o3kWltFtOykrZfg4terJrKNk3oJrFLpx68Tfqe/SErE6SvFQZuYj6UvC67YbQoCdjMpDfNkFPLoqmgaBJv3Tk8KjntFXpyaqeSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VV9rhDBO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707350525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+R4xecPaCggNDEiXUarzDRFlAEXoZkMvAXp9PbQ1lg=;
	b=VV9rhDBOBVm/i11pR7byxsIOc4F1CHFjllSTYcGqbLaZl5ScY85APvSqK2+1b2vFPsjJrT
	mjqzTWOJG3cTrcfAGF7P68w++NVaTSl3uNY8kbNOBThlUeRBvNsM1ah8Am6BxT2sV3L46t
	3kKZ5P5OkLvmxSVip72sieNoIWF4VIc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-zuYGW0mTPH-d16M9VTDQjQ-1; Wed, 07 Feb 2024 19:02:03 -0500
X-MC-Unique: zuYGW0mTPH-d16M9VTDQjQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-42793cd9d33so13744801cf.2
        for <linux-rdma@vger.kernel.org>; Wed, 07 Feb 2024 16:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707350523; x=1707955323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+R4xecPaCggNDEiXUarzDRFlAEXoZkMvAXp9PbQ1lg=;
        b=dH6NjJJMP8B80xNZU937ga5Bw1xsc3GRPLwkuNYkaO7AertdQJ19PH4wCmEtIoS9Wp
         igI9hiwlcdrAoTHS/Xo4N6Ey78VlXkWFcht0VXzdNqEGiqBHljOH0igWm0dLu8bi2IyF
         Zg0wimvfAzflYVtXZXywPDsZWpp4Z7M6f6K/ua+IyN+UEuWt3z6mnH6G/me+nZWcpgL1
         IjaG3QCa+2P+MlxlwAyDxaWCjlfYxUQbngoVtC9VNLIlmJ4SCUgMF9rFa+ST1Odueaq3
         qkP0jCXLpbHUJPANOoVImjw9sayrNr3rkS9mUKdGzpOLBwX3fB4eAFGbSOZg5HKg10Jp
         KkGA==
X-Gm-Message-State: AOJu0Yx0v2F/301sB7fYPjRGnIAjND7XB42ND3JCwwcfSLbNI32yypZN
	bJwt5Ps+MXnfs3KG0+Pbn142PYHYX+JC0c1Px+vmBUg2k1opDqCgbkvNY29j5NJJHntOQ1SQX6e
	UsIKYO1gMk6Za7304A9elfEYYHqBQB8kj32RELzSmSPkvuH1gYY22WFaE4C0=
X-Received: by 2002:ac8:4c81:0:b0:42a:ad64:5be1 with SMTP id j1-20020ac84c81000000b0042aad645be1mr5756722qtv.15.1707350523498;
        Wed, 07 Feb 2024 16:02:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGh4R8pqYIrWlt7DGiw7yA6IS5qD1HgOHv+tTclCHHxIDjMW7JGeL1OKxm6+WLokMapGPiGRw==
X-Received: by 2002:ac8:4c81:0:b0:42a:ad64:5be1 with SMTP id j1-20020ac84c81000000b0042aad645be1mr5756708qtv.15.1707350523218;
        Wed, 07 Feb 2024 16:02:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0SaWZeuIU/Nn2XaKP3b+aYO6qkuTOotITZS45OT1qe5uMeO7j5W6KlZkhkc/OJ31O/JbAHTe4SD6KRHwu8x+ObKhq8jhHBW4ro5vFTTKKsreDJbWqGt8KYH3ABfve6cj94yfvEyem
Received: from fedora-x1 ([70.51.82.231])
        by smtp.gmail.com with ESMTPSA id oo9-20020a05620a530900b007859ed62a9fsm791683qkn.40.2024.02.07.16.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 16:02:02 -0800 (PST)
Date: Wed, 7 Feb 2024 19:01:53 -0500
From: Kamal Heib <kheib@redhat.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Michal Kalderon <mkalderon@marvell.com>,
	Ariel Elior <aelior@marvell.com>
Subject: Re: [PATCH for-rc] RDMA/qedr: Fix qedr_create_user_qp error flow
Message-ID: <ZcQZ8cjtll07RQ2q@fedora-x1>
References: <20240206175449.1778317-1-kheib@redhat.com>
 <20240207073114.GA56027@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207073114.GA56027@unreal>

On Wed, Feb 07, 2024 at 09:31:14AM +0200, Leon Romanovsky wrote:
> On Tue, Feb 06, 2024 at 12:54:49PM -0500, Kamal Heib wrote:
> > Avoid the following warning by making sure to call qedr_cleanup_user()
> > in case qedr_init_user_queue() failed.
> 
> <...>
> 
> > diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
> > index 7887a6786ed4..0943abd4de27 100644
> > --- a/drivers/infiniband/hw/qedr/verbs.c
> > +++ b/drivers/infiniband/hw/qedr/verbs.c
> > @@ -1880,7 +1880,7 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
> >  		rc = qedr_init_user_queue(udata, dev, &qp->urq, ureq.rq_addr,
> >  					  ureq.rq_len, true, 0, alloc_and_init);
> >  		if (rc)
> > -			return rc;
> > +			goto err1;
> 
> "goto err1" will cause to call to qedr_cleanup_user() which will call to qedr_free_pbl()
> with qp->urq.pbl_tbl) which can be NULL.
> 
> Thanks
>

I see, what about something like the following:

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 7887a6786ed4..f118ce0a9a61 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1879,8 +1879,17 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
                /* RQ - read access only (0) */
                rc = qedr_init_user_queue(udata, dev, &qp->urq, ureq.rq_addr,
                                          ureq.rq_len, true, 0, alloc_and_init);
-               if (rc)
+               if (rc) {
+                       ib_umem_release(qp->usq.umem);
+                       qp->usq.umem = NULL;
+                       if (rdma_protocol_roce(&dev->ibdev, 1)) {
+                               qedr_free_pbl(dev, &qp->usq.pbl_info,
+                                             qp->usq.pbl_tbl);
+                       } else {
+                               kfree(qp->usq.pbl_tbl);
+                       }
                        return rc;
+               }
        }
 
        memset(&in_params, 0, sizeof(in_params));


Thanks!

 
> >  	}
> >  
> >  	memset(&in_params, 0, sizeof(in_params));
> > -- 
> > 2.43.0
> > 
> > 
> 


