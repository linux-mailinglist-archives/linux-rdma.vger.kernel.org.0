Return-Path: <linux-rdma+bounces-23118-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +GyyKS3IVGq6SwAAu9opvQ
	(envelope-from <linux-rdma+bounces-23118-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 13:12:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A33E574A335
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 13:12:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=GO6fWCEW;
	dkim=pass header.d=redhat.com header.s=google header.b=jxYPlO2i;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23118-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23118-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D046130091E0
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 11:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A3938655B;
	Mon, 13 Jul 2026 11:12:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2895F385D73
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 11:12:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941158; cv=none; b=ex8YW8x5dfZQbewT/TqqJsYHfXvcaSrEIQHCxYh5pI9A46oS1A3yGpVcoPA6cNRGaquKSivR0kqKrwNoFwxzBpEFjSxLZuHzZMKG3Bl5S6/ShMHLyWHlcEXIAUI34MbA1DdXFEsD9XHxlJSnzq3Ji7LQUshJnJOV1D0oMO4j/HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941158; c=relaxed/simple;
	bh=CItpHnwrptgQs9p4S4xJCBnXWCOQgo7NSd6Jft9/1xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=He2bRGFJZeKNdudyioEXkJtntBAu+5EbhBvuVd8vDo2cb3gLcCc69uAelI76A/cA5AuxJfzCyZ6mkUtHSCuIv5V3+zZbR2gYOrgZux3Mh5fnxB+8aPuKvk+owDKvbU8KPHOCq0/qNO9CR3K8Vy6mqD1mvBv+csrolAOLx3DJecM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GO6fWCEW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jxYPlO2i; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783941153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zwYzQhwaHfNPvezY7xd9aZaXwQI1INvyxV9tum5BbrM=;
	b=GO6fWCEWD7PNQbrRCMVX3O5E3QCoALGFgn6jAE6hI/K1dj9SUsbHXW1qaiO/P5tL9zoUbw
	W3WEPner1Pq68RZ2oS8FdaniM75wGobKaKK2R5k42RSU7lGWfC2VtArBsnIR8kxPlwWE6x
	FIIvlQ5uroIK+Mx0ZvejySLXo/lBg1A=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-SA5CcXqfOHKQt4nTStBaqg-1; Mon, 13 Jul 2026 07:12:21 -0400
X-MC-Unique: SA5CcXqfOHKQt4nTStBaqg-1
X-Mimecast-MFC-AGG-ID: SA5CcXqfOHKQt4nTStBaqg_1783941140
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e8004d60eso626956785a.1
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 04:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783941140; x=1784545940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zwYzQhwaHfNPvezY7xd9aZaXwQI1INvyxV9tum5BbrM=;
        b=jxYPlO2ibnBAwu9pTaEEaePg6uTPXtq1EMZX82DaOoQTmMOaHYQN3ov220UKC2n931
         zPLmveOW17RStGJoT9F5vxa1u4iuN9EPukCdNp4zxcVKqfvb33qieZrP74n5djjjXFwn
         LeIJ3AcL+vx+TLtyfupQ/t1DagELz1YcvZpnzIXS/Dt3dMwDOjmT1PjQfDL7WSBJ/eAb
         rHpkMqr8Bk5T499uRgBn2cYzstFenSRVcAJrQMBin3J3k4R+opD3joojGAaUPtfQAHbU
         s5KkSzCjgw7WcZz0iSN4PItNlosenpSgBZijVSHn8ya76bcR1EdpH5CPVl2RVGBqTz8u
         hOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783941140; x=1784545940;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zwYzQhwaHfNPvezY7xd9aZaXwQI1INvyxV9tum5BbrM=;
        b=JOfhJUlsxBAOaYD646V6a2udjOBrhgkw5pKprzpd3Lgz6Abd7orNXuz4x/juI0OA3J
         iCt/07LGiWbitgW66SGpxdmkQtbvJTCFibKAqgzqhJygk3+0sLwvi8DnvpMrxWCM5nh/
         JoRSZ/Lf9cIl6usn82raIS4Wi9W0MYOh7ljIzyWnN7UWdMiJyFtbNSyB1W6gft/l7U+o
         rEKI1f3nhS8IWBhbb3EjWzxaHzKWh9v7XkDUiNEjV6eDIzSpI1ON3JrrfH/H31lU0UhI
         LMfciQbnWE52n5wTa6QCv/Xt4Ew48/izy8MxnS44jzftsF0JUNyM+QZf4sZdygxBl3lB
         QLxg==
X-Gm-Message-State: AOJu0YwHsCba3ow3MvdIOTpw53/817k574JxYqZ0ZxV4tLoDDS0c1qlu
	9VkiT8FkqjDe+GYTKWl9LrTXx5rCFJVMR6VZFVQlqzZoErg5S4g0v4S5bZGb8WKuSj/5KzKEDOO
	X+0dcSYDqrzGVw1ke8lwu3q93FaMwDV+/5Apb+RIgX8h5QNGgsPsvSvKhHPOq8ws=
X-Gm-Gg: AfdE7cnL5qduncBCLGFpFfz+1uBFMA6vk/OX5nVQSxFoAS3VQtwtu0CSNhOXL7bEG9w
	CXu9IUOZ/Imqzm85p2QNsJcs7Q9Etmy8ty3IRCLXrLAkqff2onMmtJmLvTMCDi6IHopWoMZJVnF
	NQDBPhDDP9NRE+z44B5ocJB7tQUGa3TcCUxy7uih0fW3p/WKHrxoeTRspOv0tmVdnzQiZUhlvh+
	J2GTuyMlqIxJ/8zHv0lz5xc896bedwRnWVcxxxY02NdshEBN6ZUhUJwJpA3HHmBa9pli3VvOh4T
	OvxNBBA3gxTkWjFw/y8+avQH5Crxcs4niCHFgIOGxZFzKgX9mO7gfgppEV1riQv2WEgNwW79Drb
	NzHAjNE2np+/S4s/CPXBzRiqjEnlbE9mPc10ugUw/PEjAHOXSG/q7D3FbfWp+bdY+MVGHwExU2j
	m79mMI4wWogg==
X-Received: by 2002:a05:620a:6cc1:b0:92e:305a:d729 with SMTP id af79cd13be357-92ef2aebfd3mr867462085a.7.1783941140414;
        Mon, 13 Jul 2026 04:12:20 -0700 (PDT)
X-Received: by 2002:a05:620a:6cc1:b0:92e:305a:d729 with SMTP id af79cd13be357-92ef2aebfd3mr867459385a.7.1783941139989;
        Mon, 13 Jul 2026 04:12:19 -0700 (PDT)
Received: from lima-fedora43 ([142.126.90.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b4b1bbsm1061178285a.2.2026.07.13.04.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 04:12:19 -0700 (PDT)
Date: Mon, 13 Jul 2026 07:12:08 -0400
From: Kamal Heib <kheib@redhat.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH rdma-rc 0/2] RDMA/ionic: Fix NULL pointer dereferences
Message-ID: <alTICI1PQ_7D7_ea@lima-fedora43>
References: <20260709220353.729951-1-kheib@redhat.com>
 <20260712091326.GG33197@unreal>
 <alPrQa9ZgDaGuPYo@lima-fedora43>
 <20260713091733.GJ33197@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713091733.GJ33197@unreal>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23118-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A33E574A335

On Mon, Jul 13, 2026 at 12:17:33PM +0300, Leon Romanovsky wrote:
> On Sun, Jul 12, 2026 at 03:30:09PM -0400, Kamal Heib wrote:
> > On Sun, Jul 12, 2026 at 12:13:26PM +0300, Leon Romanovsky wrote:
> > > On Thu, Jul 09, 2026 at 06:03:51PM -0400, Kamal Heib wrote:
> > > > Fix two potential NULL pointer dereferences in the ionic driver by
> > > > adding the missing NULL checks before dereferencing netdev pointers.
> > > 
> > > How is it possible to have ionic IB driver without netdev?
> > > 
> > > Thanks
> > >
> > 
> > Thanks for your review, after taking a deeper look:
> > 
> > For Patch 2 (ionic_create_ibdev): You are right. Since lif is embedded in
> > netdev via netdev_priv() and they are allocated/freed together,
> > lif->netdev cannot be NULL if lif is valid, Please drop this patch.
> > 
> > For Patch 1 (ionic_query_device): This one should remain.
> > ib_device_get_netdev() is a core RDMA API that explicitly returns NULL in
> > multiple code paths:
> > 
> > - Invalid port: if (!rdma_is_port_valid(ib_dev, port)) return NULL;
> > - No port_data: if (!ib_dev->port_data) return NULL;
> > - NULL netdev pointer stored in port_data
> > 
> > Also, the return value from ib_device_get_netdev() is being checked in
> > multiple places in both drivers and the RDMA core.
> > 
> > Let me know what you think?
> 
> I think that you shouldn't copy/paste answers from your favorite AI tool.
> 
> Thanks
>

With all due respect..., Your response is not contributing to the
discussion about the patch, if you don't like the change or you think
that it is not justified, you can say so.

> > 
> > Thanks,
> > Kamal
> > 
> > > > 
> > > > Kamal Heib (2):
> > > >   RDMA/ionic: Fix potential NULL pointer dereference in
> > > >     ionic_query_device
> > > >   RDMA/ionic: Fix potential NULL pointer dereference in
> > > >     ionic_create_ibdev
> > > > 
> > > >  drivers/infiniband/hw/ionic/ionic_ibdev.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > > 
> > > > -- 
> > > > 2.55.0
> > > > 
> > > > 
> > > 
> > 
> 


