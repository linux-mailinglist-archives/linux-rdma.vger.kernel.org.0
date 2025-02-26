Return-Path: <linux-rdma+bounces-8106-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F726A4540E
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 04:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CFAB3A6054
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 03:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE93125A331;
	Wed, 26 Feb 2025 03:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z3T5jCnf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F348324EF86
	for <linux-rdma@vger.kernel.org>; Wed, 26 Feb 2025 03:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740541032; cv=none; b=ZuWrwwxrCiMnwBBpr7fg6J2IrMsaV7ZuycjxJ+79ymcEnxePucEG1tWm6pWX77deZdeCP0v4VkXGD1aMor9juJcl6WAzDLGRRLT8C4lHg0+0FEjmTvEVUpF0ctEG8RbcaNss7JCysDOd64MgqZXLT1TlKAdRKswIJAlwvBh4vlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740541032; c=relaxed/simple;
	bh=+d150ORAuwcNcBo0bktXkOORXUeaVvLFU+FwfnagMfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGPLVlJvha5rUs+KhvOGQ3VEN0Ew9mSzQ5AvBfxy7NgMvcUpD9xrK+byB8Ag055hXUJVP22TUTIhC7LD2YfUO/iIZNBgWfesFJdCz28HNdzu/ngSkgZA3pn1jS4qSVZquBJj0kay8FNCYn1/n5fsD3kWu5W74R3YEekZa43Ah+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z3T5jCnf; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Feb 2025 03:37:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740541029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OSEd15iaG/YVJV5R/ef6IG1gpof8ihg018EdijbCkTM=;
	b=Z3T5jCnfrOToJENKnoI4nrqp8h67TYclznwQJonLGnH1MdtaRh3U+rUtMFZPuW0Dk8odJH
	R4iQgoi7LhyL5GTLrvs8kGPdUDv01NPJGyMemu9nACJyOIPWXt0cJb/0+8XAOmWn/tADbD
	O2yePYAenoNjBuS57LxLyRnB5A5YBNs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@mellanox.com>, Leon Romanovsky <leon@kernel.org>,
	Maher Sanalla <msanalla@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/core: fix a NULL-pointer dereference in
 hw_stat_device_show()
Message-ID: <Z76MYRaWm9AE0SaW@google.com>
References: <Z7gARTF0mpbOj7gN@google.com>
 <CY8PR12MB7195F3ACB8CFA05C4B8D26D3DCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250221174347.GA314593@nvidia.com>
 <CY8PR12MB7195A82F6CE17D9BDC674D72DCC62@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250224151127.GT50639@nvidia.com>
 <CY8PR12MB7195E91917FD5329932FA3FCDCC02@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z7z_NcGWIr3_Dxtt@google.com>
 <20250224233004.GD520155@nvidia.com>
 <Z708JNt6-vPIuDBm@google.com>
 <20250225131618.GN520155@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225131618.GN520155@nvidia.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 25, 2025 at 09:16:18AM -0400, Jason Gunthorpe wrote:
> On Tue, Feb 25, 2025 at 03:42:28AM +0000, Roman Gushchin wrote:
> 
> > diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> > index 0ded91f056f3..6998907fc779 100644
> > --- a/drivers/infiniband/core/device.c
> > +++ b/drivers/infiniband/core/device.c
> > @@ -956,6 +956,7 @@ static int add_one_compat_dev(struct ib_device *device,
> >         ret = device_add(&cdev->dev);
> >         if (ret)
> >                 goto add_err;
> > +       device->groups[2] = NULL;
> >         ret = ib_setup_port_attrs(cdev);
> >         if (ret)
> >                 goto port_err;
> 
> That's horrible - but OK, maybe something like that..
> 
> Does it work? Or does the driver core need groups after the initial
> setup?
> 
> Could we have two group lists and link them together? IIRC there was a
> way to do that without creating a sub directory

It does work.

I just sent a decent implementation of this idea, please, take a look.

Thank you!

