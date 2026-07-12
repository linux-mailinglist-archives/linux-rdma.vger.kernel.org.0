Return-Path: <linux-rdma+bounces-23081-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SOwdGCPsU2rygAMAu9opvQ
	(envelope-from <linux-rdma+bounces-23081-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 21:33:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4BC745C59
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 21:33:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=XEkIbDLI;
	dkim=pass header.d=redhat.com header.s=google header.b=j3OVsfVd;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23081-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23081-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AF81300A8FF
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 19:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3367B3B3BFA;
	Sun, 12 Jul 2026 19:30:27 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEC43B2FD8
	for <linux-rdma@vger.kernel.org>; Sun, 12 Jul 2026 19:30:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783884627; cv=none; b=JKnAy82xEjCtJIDJ6D7v53Ts+SG9dVxu5x0+LwHLuzS18V1uFC7y7koiMUygsZ4gcOkY7ZHL71P6Af/3v8nkddh8NqYUDCZBx+higjPSXeMNtK0O8VpTrNaMlvo/pvqEsmDtJid80V8XmPEl+OhwFFEjnH9s25TivnrCN9O3FRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783884627; c=relaxed/simple;
	bh=sdm0WWMYkV5873N7p1Mf9a9I3cVlMrjivAvOIkQAGks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neL6eupRI75DietFYDIAX76/sD9O460TnMjHeWTn7dtP/XNEk2gQ8YqK3DJOtWL2wvDLRm2FIfpDH5mnSFciXt3aPr9c3ZevKIHQYBBwbx3fqzKzn6vBNO5Ybz3sHgoCZHQioSYiK1hhymT5rpiSgY/e8cAm5geWri4pvCG6zCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEkIbDLI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=j3OVsfVd; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783884624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iyq8xEcd5tyQ2fwVhgLM8NSqBgY5GuPj5GfrmNgCJ0w=;
	b=XEkIbDLI1OwElinXiqfROPLrRnEvYh+zhrdScxl9gHZSIKddkT1o3oggDoAeHI+cZw80t7
	BlXnpV06h1DiKO0uMSAfx9KhrtljVQOFbCo2Bi0AgHYkpRwBdxNuBzWkwEyav8JhQcJ81Z
	1COnPfwbcmpAazuVqH6Hs0FBbi0S2Lw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-kcvDsqW8OG-4nCojY-Eb3g-1; Sun, 12 Jul 2026 15:30:22 -0400
X-MC-Unique: kcvDsqW8OG-4nCojY-Eb3g-1
X-Mimecast-MFC-AGG-ID: kcvDsqW8OG-4nCojY-Eb3g_1783884622
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c26012cd0so31829911cf.0
        for <linux-rdma@vger.kernel.org>; Sun, 12 Jul 2026 12:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783884622; x=1784489422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Iyq8xEcd5tyQ2fwVhgLM8NSqBgY5GuPj5GfrmNgCJ0w=;
        b=j3OVsfVdVr7arCelr4k9qP0sQJIvkU+wxYBH8tg/ENX2F0L+wnbD6akTMwGMg3r1kT
         ++KwZ/XHOd2SpXfNlVv19cCZTsShamMe2VLz4+PxrMamY0kq+qyZtQDXut3r0bQ8tfva
         qnIOmp9nkAsQLTTyqdCZCNdjJjJyN9PslwwTZ+XRPcrLpMht1MwkAq726lVRTBPpshk5
         AmirPTM9gpqgUnDFy5t7gZIG8Z/zrqv+4oOH9Kl+14t1xGzlv5GrTykUTSffUcqppy1b
         b3baiO09Hv6MbYFsKB+tb1Lcfxmj2u0ADAS4fxXiCxtXidxFhTweMfJmnOuLdkX0Jr6h
         6LnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783884622; x=1784489422;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iyq8xEcd5tyQ2fwVhgLM8NSqBgY5GuPj5GfrmNgCJ0w=;
        b=hyYKr3ZwOTSCa1ZjTDxHVOUaXxZMg2/yMfyvSqysiW6OL+YuD3LMHYTnXBvyz+KMwC
         kxvzFW6SNNHTH/PS6OtgSiBUnJW41stqc09j6OP5d3R1B8j6yJKjt2GvWgExd4QHLB/u
         oyp7I71j3S3JK1eMgx61txZBb5p/9bu244falC0nsAQ4iuGeGOxMfFV+86IKNx7Q0yTH
         21Y/C0h4E2POkfqo7ay0cKShZrjS8OTqMS9qR/DBunlP5G1Rel2o91GJ/tm9mFG5Yxcp
         umTjqM9H5cXsZwC0G19BFZdhIEDTAttYYTBVhlzxsfaCUjYZOCctClM4Hc4WajpkHfYA
         pZ1w==
X-Gm-Message-State: AOJu0Yx4yYCiQPdOuvkU/vl+m/oHnIPE4cj7NRWi22RMv5TZrJMizFUk
	xbccY6Sep7aXNDf4fAzSn1tP/KwH6Am/G85Zailr+ae/3M4lo4r0Naaby00jtwP/nT+eR2Te7Kd
	B8I13MlMrj3EfpLKQlv4KO3H+xj+jEgATpc5UJEbc8FU4KtupqS260R811PnLw2Q=
X-Gm-Gg: AfdE7cn+ygA4ifms9MMpzypwawxWvFwTkM2R3xZ41CtbgwPGXijg6nDBUzz5GXmZOCC
	TJGtE6XwKmypV7UW64CPylqNMTTkP70nx3ZrC2RYVOYRez58n7js6NhtwnVRkNlGYiORacnCpHU
	IKL0nDHY5WcbtegJq0sgvQXkQXM+lYuTftbWt5Yk2RpzJys7pTcB5JsglIVKp8xOdxERRp0cEAp
	IuP7DHstI4JJ4w3oQzuY5HbVYIcuNJTVvd6SKp598S6iGKF9DLpAAUNYF/jqpZ0qGYp7zGkWeOo
	GDPPVKKzMhN6RJNYEi9JmK9AWrs49Bx75iNasenXmylMUpn1+CESHGHK/4hNdDuXqJT73tk6o1a
	ES93f0nai9jUG1cN9tq2JaxJUFbEfW1Ht9bPqnJyRHwEoVsaoGF5xP8RmpxMzkbeuZVSEtYg9Qa
	chhu11+n+LoQ==
X-Received: by 2002:a05:622a:43:b0:51c:1408:6c13 with SMTP id d75a77b69052e-51cbf213dbemr67292291cf.44.1783884621972;
        Sun, 12 Jul 2026 12:30:21 -0700 (PDT)
X-Received: by 2002:a05:622a:43:b0:51c:1408:6c13 with SMTP id d75a77b69052e-51cbf213dbemr67291911cf.44.1783884621384;
        Sun, 12 Jul 2026 12:30:21 -0700 (PDT)
Received: from lima-fedora43 ([142.126.90.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51cb880bdbasm58025881cf.20.2026.07.12.12.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 12:30:21 -0700 (PDT)
Date: Sun, 12 Jul 2026 15:30:09 -0400
From: Kamal Heib <kheib@redhat.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH rdma-rc 0/2] RDMA/ionic: Fix NULL pointer dereferences
Message-ID: <alPrQa9ZgDaGuPYo@lima-fedora43>
References: <20260709220353.729951-1-kheib@redhat.com>
 <20260712091326.GG33197@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712091326.GG33197@unreal>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23081-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kheib@redhat.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:abhijit.gangurde@amd.com,m:allen.hubbe@amd.com,m:jgg@ziepe.ca,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kheib@redhat.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lima-fedora43:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF4BC745C59

On Sun, Jul 12, 2026 at 12:13:26PM +0300, Leon Romanovsky wrote:
> On Thu, Jul 09, 2026 at 06:03:51PM -0400, Kamal Heib wrote:
> > Fix two potential NULL pointer dereferences in the ionic driver by
> > adding the missing NULL checks before dereferencing netdev pointers.
> 
> How is it possible to have ionic IB driver without netdev?
> 
> Thanks
>

Thanks for your review, after taking a deeper look:

For Patch 2 (ionic_create_ibdev): You are right. Since lif is embedded in
netdev via netdev_priv() and they are allocated/freed together,
lif->netdev cannot be NULL if lif is valid, Please drop this patch.

For Patch 1 (ionic_query_device): This one should remain.
ib_device_get_netdev() is a core RDMA API that explicitly returns NULL in
multiple code paths:

- Invalid port: if (!rdma_is_port_valid(ib_dev, port)) return NULL;
- No port_data: if (!ib_dev->port_data) return NULL;
- NULL netdev pointer stored in port_data

Also, the return value from ib_device_get_netdev() is being checked in
multiple places in both drivers and the RDMA core.

Let me know what you think?

Thanks,
Kamal

> > 
> > Kamal Heib (2):
> >   RDMA/ionic: Fix potential NULL pointer dereference in
> >     ionic_query_device
> >   RDMA/ionic: Fix potential NULL pointer dereference in
> >     ionic_create_ibdev
> > 
> >  drivers/infiniband/hw/ionic/ionic_ibdev.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > -- 
> > 2.55.0
> > 
> > 
> 


