Return-Path: <linux-rdma+bounces-14636-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE437C741A5
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 14:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 98E253093E
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 13:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D556133A6EF;
	Thu, 20 Nov 2025 13:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fSkyQJNl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD14633A00C
	for <linux-rdma@vger.kernel.org>; Thu, 20 Nov 2025 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644304; cv=none; b=rpG5QgiZnJXjph+H8/Fl4/fF5dmd0PqeZcgmJo0Tve5op9nob9djkznZ6draCh4bEp8czNjt5pPydtEmqykzffsbqBPeQNbxu88QNKKS3dTk9HSeZogdEkDA/RvzRbXBm83ht/f5MtaxkXBke9NYomgFiNj4MaZUsHXC2rT7MIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644304; c=relaxed/simple;
	bh=z7r4WHxVUtr1NMbU5nNm8Tdf6q2L60iSUkYRUyKe6jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvI4M3VVu6W5PYoNk3e0NhVX6lkJQYiPDJQ7hRb17OHXQOoCuLjtEN2YcYIZQeBnAI7+U3Fba2VpHkRFY0nXp4m2UDXRFWq6IXN9t8Do/UUNWJzU65xDiM4FiamtQxl8eT236GJk4UVda5EoXnJR9Uh7H9RWh8CGoFhddlVIB5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fSkyQJNl; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-882475d8851so8990156d6.2
        for <linux-rdma@vger.kernel.org>; Thu, 20 Nov 2025 05:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763644302; x=1764249102; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JES5bgPJDV47VcKGaFXyOFEoQxZuffh7DW8c1ztEko4=;
        b=fSkyQJNl7ijr+/2cmkTH4oSH1Gk+I0/iZWQxyxueqVY1n2pabSRgdaOFyHi/LrsTm5
         0PFDEBNdqb8yhg53t/T+VVZYtOaYsZWTUo6sbfZVduSrx18ngYao68rW0/9G2IHZ2zVF
         9dfvD+czAy1IAhkhGGKI6vhI5xjrj3JIKARmVHPriediBH8J7hWb5+92+a0tqqW8fhsg
         +jW5XKoFh19C/nGIE83d7oMi0MNv7OtTlZQoGwhIUvTaUW14NoZKEJmk968v+M7I/B/P
         PLggMmokqAd6e4HUC9Oup2ma72kuxV+32LDYvVOf492shbjEyxXXKWPqa9y04VXDSrEb
         HYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763644302; x=1764249102;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JES5bgPJDV47VcKGaFXyOFEoQxZuffh7DW8c1ztEko4=;
        b=QEiC1dV7ns6u6I5wljROghalnvBw4R3ofehyuUPOq2tMJl/eyOJKhY74XjGD+9eH+m
         /98mPIDM6fJIEK6qtcxbWr+mU0rB3T6teZS1XRDdMpxWwN8pHur2yYF9O9saewrQbOIp
         ejG1KnW/uONEVxTEv20ZtmpGaCZ7KPlx+NRG4k0d9GIrGdvfDo4ngmkAXLRveyfAbfiC
         LinADvaVu7ChAE1rjOLXBrPBkkxLr6j9P6hyd9Ui882LxV62GAm/RJOqs4m+tw7td7Jc
         9knQmmy2aHPfry6XKOpYSnkFwvX0S3TyHALk1L2wjPJtkNYyvdIH8btOL5+ICaWEASqN
         sJPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4eLPHymh2yW2zgnh5P4O4SJwt7pO2bFJmzGdm/rzHiIe7hAfjbAWGF0PtfbtHBv2CglPaoay5YmUv@vger.kernel.org
X-Gm-Message-State: AOJu0YzVS2fxZTq9qJiOlbqlBuTO13MW01ujsZaqXbWrIvEmE2zpf8T1
	g3BN1ZfHoJYdTEjl1yGseh5dIEz/srukoCTwxPOBLYqFLO61fM4v5y76NPBITZxvM4A=
X-Gm-Gg: ASbGncvHm88spDnJKNAjCTnf+gkvTqalVfS36TjAuNNPRMdYJ4Dmrhn8kI8E/AtBpuC
	zRGKpM+7U2Q3yDuRIXUSKHPH/zw0rxUJ0+HDmovEpugrV7lcgY7oP5hI0qYhN5bmft68io9Ap1A
	33N4W6cXWPCzzISuHv+ACofSXp/dxEo0baZGOgNsnwzwOXog95Jtd1mAhDtwdWjr6saZJBKsomv
	ipcJ/CIHAePaEYjtuHWjlB/k60FZb1Uz4GytwDMSsQ8U7zwmh4dw3A3p05MCxLW+dyQBBDJl4Gi
	ZaDXZrX/4kYlfurf04DcD8XiwAP81LISsMmP/lyXJoEpprZ3u0zWYkaXrfqEKxf4W66+XiofqBN
	faKJDKVYdT9ifDCJRvULhqCAphxksepke8BbDGocI4ODNuhO7czpuEwFVDpVM99+Tx0yR9KT8LP
	nNnC7SjRNkOkUbmUGdF+ObxQcjKGy+oXhN0Uz0hX/WplbqyjfWCTbLmYpk
X-Google-Smtp-Source: AGHT+IHUyj9QWoo5TmaUnG9IBAR+U26ffxDmpit7Q/yb1e+2MliI7nWwHpoJvZBywyonblLVVSOP9A==
X-Received: by 2002:a05:6214:caf:b0:880:8a77:55b7 with SMTP id 6a1803df08f44-884718809a2mr24532376d6.58.1763644301536;
        Thu, 20 Nov 2025 05:11:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e59ee34sm16797466d6.54.2025.11.20.05.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 05:11:40 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vM4Ro-00000000gIW-0Mnj;
	Thu, 20 Nov 2025 09:11:40 -0400
Date: Thu, 20 Nov 2025 09:11:40 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [RFC 2/2] Set steering-tag directly for PCIe P2P memory access
Message-ID: <20251120131140.GT17968@ziepe.ca>
References: <20251117160028.GA17968@ziepe.ca>
 <20251120072442.2292818-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251120072442.2292818-1-zhipingz@meta.com>

On Wed, Nov 19, 2025 at 11:24:40PM -0800, Zhiping Zhang wrote:
> On Monday, November 17, 2025 at 8:00 AM, Jason Gunthorpe wrote:
> > Re: [RFC 2/2] Set steering-tag directly for PCIe P2P memory access
> >
> > On Thu, Nov 13, 2025 at 01:37:12PM -0800, Zhiping Zhang wrote:
> > > RDMA: Set steering-tag value directly in DMAH struct for DMABUF MR
> > >
> > > This patch enables construction of a dma handler (DMAH) with the P2P memory type
> > > and a direct steering-tag value. It can be used to register a RDMA memory
> > > region with DMABUF for the RDMA NIC to access the other device's memory via P2P.
> > >
> > > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > > ---
> > > .../infiniband/core/uverbs_std_types_dmah.c   | 28 +++++++++++++++++++
> > > drivers/infiniband/core/uverbs_std_types_mr.c |  3 ++
> > > drivers/infiniband/hw/mlx5/dmah.c             |  5 ++--
> > > .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 12 +++++---
> > > include/linux/mlx5/driver.h                   |  4 +--
> > > include/rdma/ib_verbs.h                       |  2 ++
> > > include/uapi/rdma/ib_user_ioctl_cmds.h        |  1 +
> > > 7 files changed, 46 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/core/uverbs_std_types_dmah.c b/drivers/infiniband/core/uverbs_std_types_dmah.c
> > > index 453ce656c6f2..1ef400f96965 100644
> > > --- a/drivers/infiniband/core/uverbs_std_types_dmah.c
> > > +++ b/drivers/infiniband/core/uverbs_std_types_dmah.c
> > > @@ -61,6 +61,27 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DMAH_ALLOC)(
> > >               dmah->valid_fields |= BIT(IB_DMAH_MEM_TYPE_EXISTS);
> > >       }
> > >
> > > +     if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_ALLOC_DMAH_DIRECT_ST_VAL)) {
> > > +             ret = uverbs_copy_from(&dmah->direct_st_val, attrs,
> > > +                                    UVERBS_ATTR_ALLOC_DMAH_DIRECT_ST_VAL);
> > > +             if (ret)
> > > +                     goto err;
> >
> > This should not come from userspace, the dmabuf exporter should
> > provide any TPH hints as part of the attachment process.
> > 
> > We are trying not to allow userspace raw access to the TPH values, so
> > this is not a desirable UAPI here.
> 
> Thanks for your feedback!
> 
> I understand the concern about not exposing raw TPH values to
> userspace.  To clarify, would it be acceptable to use an index-based
> mapping table, where userspace provides an index and the kernel
> translates it to the appropriate TPH value? Given that the PCIe spec
> allows up to 16-bit TPH values, this could require a mapping table
> of up to 128KB. Do you see this as a reasonable approach, or is
> there a preferred alternative?

?

The issue here is to secure the TPH. The kernel driver that owns the
exporting device should control what TPH values an importing driver
will use.

I don't see how an indirection table helps anything, you need to add
an API to DMABUF to retrieve the tph.

> Additionally, in cases where the dmabuf exporter device can handle all possible 16-bit
> TPH values  (i.e., it has its own internal mapping logic or table), should this still be
> entirely abstracted away from userspace?

I imagine the exporting device provides the raw on the wire TPH value
it wants the importing device to use and the importing device is
responsible to program it using whatever scheme it has.

Jason

