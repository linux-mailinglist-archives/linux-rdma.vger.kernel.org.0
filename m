Return-Path: <linux-rdma+bounces-23125-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zAAcHt3dVGpMgAAAu9opvQ
	(envelope-from <linux-rdma+bounces-23125-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 14:45:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7DF74B0E2
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 14:45:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=YmsmaoUE;
	dkim=pass header.d=redhat.com header.s=google header.b=Wg0idmWf;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23125-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23125-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E860930A9046
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 12:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD003F44E2;
	Mon, 13 Jul 2026 12:41:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2472441A6
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 12:41:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783946482; cv=none; b=n+5gb+YKB5ym+ZnFC6aIO61oAn2dfA9jZZIswT0B2tmuWFze0gKG4wNt2qraEroYlcNvogRWoJ0ajs/CBpZsluy/Vw6a6t2tOdYoK3+T+EjCsxL2ak8PPWYV2UpqJ3GJmqryU1YyOVuZDiKIs/U2SgVRpo0q69bLxnIROgRZ6EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783946482; c=relaxed/simple;
	bh=+6w9nSKJH9JMJ42X7wy4DiU8aFZnj7MHy6bfOFosGq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqcF0LZz2AQ9MPMKRrH/4jVY7WCkbKR0sJEQHMEcoB0V/muKXPRV7h+y9zNUGISGcvl8Uws533cwIG1+UjtoI8YshwWud615GTjaaSD0zUYkT8LxHnvRiCwhpxWe8EFWjP8xHdu2SZXxmwxYMHf4GpPrkCrFF9K+jc8f+e1k9dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YmsmaoUE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wg0idmWf; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783946479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MyUykw6qcPcrbWgBXlGi5nNPBFpq9OkYd7/mE4kMao4=;
	b=YmsmaoUEd/FgXnB32u+T8Hwaz1sv7IbyHTQKZ78drU1linH0VZcP/1iI881JDAsA5DvKR3
	t5+atvYQQd+9OWvB5Q3hG5Jm4Ibwx4WCFqwkrcu6bbtZAOBG2U+pxOlOnuQm3R98csRCL7
	h5hoDUL4MwryXhb6FuRcBcvWSroJ9QU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-LejH_3N2PYqUl-rPQoYYhQ-1; Mon, 13 Jul 2026 08:41:18 -0400
X-MC-Unique: LejH_3N2PYqUl-rPQoYYhQ-1
X-Mimecast-MFC-AGG-ID: LejH_3N2PYqUl-rPQoYYhQ_1783946477
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-39c79b2836dso8557311fa.3
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 05:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783946477; x=1784551277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MyUykw6qcPcrbWgBXlGi5nNPBFpq9OkYd7/mE4kMao4=;
        b=Wg0idmWfs3y3WNqoTqpiP0bN+5/vr3dzFULK+ChG7Q1cGtFGeXsjpuLUyMzsxcMELk
         3XpaC9u8nmETaOrkLH3hCyra8AHNNLg8JVFejy+DYq0zrTigzYyi47CqFxvtQ/Ip+M7u
         u1PTHDO1M7NbWKE5wO4bHCk4KumYf6FpxlJquO2zvM6V5IOssA5NqyDEfgc0hbdUa6gx
         5/U9KC/2R6vqNRx5BxpWqgSQuaneJ5N3h4WpShRgDsY+YrwAWMZpImJa/CwYUjGEdLD7
         3c/GT0EZWZEskPffGxUgJF2yp05tBxgdrphOxuo4V6dW2fLbLYke2ccHRIJj/IcGKfHW
         EZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783946477; x=1784551277;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MyUykw6qcPcrbWgBXlGi5nNPBFpq9OkYd7/mE4kMao4=;
        b=Q6Z7hWlAOEhWxCgjK8de89wUN5d8YOsYPLUh8vbdd4QW/X7pSFjgKN7Zla/YWapwwI
         HyBSF01BXT/12WVXlv4zjjyHkdhYX/N9U822JiuuO1oY1O3b8If+FOraQDsiD+OCZ1FG
         FZGmtGbeR78Be/dYyzYh4gnZBUPUNFEdnDkN1wxrUDDl0UfH1ikplCwFc1XQg9uiWxms
         huH+a0K9O1WZ735iF9b+5XQ1lDMunRaj1nAxc4zj7ov1CbuhlneIjLJaufqtbfBjVk1c
         t1J2hQjBRACntc1FDipUYkka61EpJHh3Qyt9rBfLOwztkvYJGixWwZ5Sc8Ku/Y1rVdSa
         uSFg==
X-Gm-Message-State: AOJu0YwV/a8evHWGaQ8OhUSIse9wZBvqMqt6abYGY3zGYSQvtQyltDsW
	mR0zm6ppytA2pUf2YCMhsp0LRc8mIS/wfvIhQF9JKja1dolYkOP8S7FO677GJEUfLJYRNDXz1TF
	2NAQVZbsrAwEY3HFuUIqkLuvGJrzEHhbq5Ve+MFM+dFYuYzzE0CVqAIyudpx9/pM=
X-Gm-Gg: AfdE7ckty90R9MbOGAI6dvb0mjVxJhJxIwM/qJN1jadpPXR58ZY15KE29O6hEIfQtx2
	5aQPx+MFh7vIUqV1uEucqoxD+Hmu9wI3IC6tC5iWkZli27bgXhv2jI+U+/8104EcazDpTqkWslv
	GiddHgWtrHVbRxslW2wK1Gj4m3Dh0rRlZhwpeVMI24t7LRc8H2g0LYihaThWrN+cxy37mKfBTzb
	Eix6mFO4GAUM15Ll7Wy0Ky5ZVgW+bP9bVUzhoLF4qC+wOoFD3n0l1L5xZBVJ7v+YR1gNJDecIb1
	lwih9L0fC2JTcnzrGtyTzXb1iT8DbvLUlTwg0ETwfj9BsW74/vXw22JT18WzsxH1gdYf6tK8ZFG
	F0OVN+pANQziNFH7Jy7qmavXqOquXxZtmswy40gldgvrcnojh2F7wQigxeZJ2jSlQG9hs/8zVdz
	MtCrZ3Y029zA==
X-Received: by 2002:a2e:a80d:0:b0:39c:a244:1b00 with SMTP id 38308e7fff4ca-39caa88b6f1mr18743171fa.32.1783946476889;
        Mon, 13 Jul 2026 05:41:16 -0700 (PDT)
X-Received: by 2002:a2e:a80d:0:b0:39c:a244:1b00 with SMTP id 38308e7fff4ca-39caa88b6f1mr18743111fa.32.1783946476484;
        Mon, 13 Jul 2026 05:41:16 -0700 (PDT)
Received: from lima-fedora43 ([142.126.90.92])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39c84b84954sm27377591fa.23.2026.07.13.05.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 05:41:16 -0700 (PDT)
Date: Mon, 13 Jul 2026 08:41:03 -0400
From: Kamal Heib <kheib@redhat.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH rdma-rc 0/2] RDMA/ionic: Fix NULL pointer dereferences
Message-ID: <alTc3yfXNyGyzjCw@lima-fedora43>
References: <20260709220353.729951-1-kheib@redhat.com>
 <20260712091326.GG33197@unreal>
 <alPrQa9ZgDaGuPYo@lima-fedora43>
 <20260713091733.GJ33197@unreal>
 <alTICI1PQ_7D7_ea@lima-fedora43>
 <20260713113521.GM33197@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713113521.GM33197@unreal>
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
	TAGGED_FROM(0.00)[bounces-23125-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 8F7DF74B0E2

On Mon, Jul 13, 2026 at 02:35:21PM +0300, Leon Romanovsky wrote:
> On Mon, Jul 13, 2026 at 07:12:08AM -0400, Kamal Heib wrote:
> > On Mon, Jul 13, 2026 at 12:17:33PM +0300, Leon Romanovsky wrote:
> > > On Sun, Jul 12, 2026 at 03:30:09PM -0400, Kamal Heib wrote:
> > > > On Sun, Jul 12, 2026 at 12:13:26PM +0300, Leon Romanovsky wrote:
> > > > > On Thu, Jul 09, 2026 at 06:03:51PM -0400, Kamal Heib wrote:
> > > > > > Fix two potential NULL pointer dereferences in the ionic driver by
> > > > > > adding the missing NULL checks before dereferencing netdev pointers.
> > > > > 
> > > > > How is it possible to have ionic IB driver without netdev?
> > > > > 
> > > > > Thanks
> > > > >
> > > > 
> > > > Thanks for your review, after taking a deeper look:
> > > > 
> > > > For Patch 2 (ionic_create_ibdev): You are right. Since lif is embedded in
> > > > netdev via netdev_priv() and they are allocated/freed together,
> > > > lif->netdev cannot be NULL if lif is valid, Please drop this patch.
> > > > 
> > > > For Patch 1 (ionic_query_device): This one should remain.
> > > > ib_device_get_netdev() is a core RDMA API that explicitly returns NULL in
> > > > multiple code paths:
> > > > 
> > > > - Invalid port: if (!rdma_is_port_valid(ib_dev, port)) return NULL;
> > > > - No port_data: if (!ib_dev->port_data) return NULL;
> > > > - NULL netdev pointer stored in port_data
> > > > 
> > > > Also, the return value from ib_device_get_netdev() is being checked in
> > > > multiple places in both drivers and the RDMA core.
> > > > 
> > > > Let me know what you think?
> > > 
> > > I think that you shouldn't copy/paste answers from your favorite AI tool.
> > > 
> > > Thanks
> > >
> > 
> > With all due respect..., Your response is not contributing to the
> > discussion about the patch, if you don't like the change or you think
> > that it is not justified, you can say so.
> 
> Kamal,
> 
> You pasted a response from Claude/Codex while at the same time, you are expecting
> me to spend time and effort explaining why all of it does not apply to the current
> code.
>

Lean,

AI is havely used in multiple kernel development areas including RDMA.
Also, I think you should already know that from the company that you
work for...

Many respected kernel developers already using AI as productivity tool,
Judging a patch based on whether AI may have used or not is not a
valid argument, again if you don't like the change or you think it is
not justified, you can say so.


> Thanks
> 
> > 
> > > > 
> > > > Thanks,
> > > > Kamal
> > > > 
> > > > > > 
> > > > > > Kamal Heib (2):
> > > > > >   RDMA/ionic: Fix potential NULL pointer dereference in
> > > > > >     ionic_query_device
> > > > > >   RDMA/ionic: Fix potential NULL pointer dereference in
> > > > > >     ionic_create_ibdev
> > > > > > 
> > > > > >  drivers/infiniband/hw/ionic/ionic_ibdev.c | 8 ++++++++
> > > > > >  1 file changed, 8 insertions(+)
> > > > > > 
> > > > > > -- 
> > > > > > 2.55.0
> > > > > > 
> > > > > > 
> > > > > 
> > > > 
> > > 
> > 
> 


