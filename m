Return-Path: <linux-rdma+bounces-16977-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNpkB1X1lGlzJQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16977-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 00:10:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5BE151B93
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 00:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E84B23054659
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA29313547;
	Tue, 17 Feb 2026 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B2+P/SS+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3786B314D23
	for <linux-rdma@vger.kernel.org>; Tue, 17 Feb 2026 23:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771369749; cv=pass; b=gbTmsxI31WHDHn6M6p3DzmNQclsty/XNj4ev2SsvFfFJn4AkDP2fGcJXyDRPgv1B3g25SHqxgOYhDKt9S6tsIDHLJc21sfsvdbuWdIr/RpYQbx2//ykynpX6FULBC7lGiXdHI2RwnFNh4vto8HrIfFOdqNfntzUQDeRFlspTY1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771369749; c=relaxed/simple;
	bh=fSZ0z8ESozqbP9AsCgWTCkr8UVza8MF4kdq23RT5Zts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXJ4Hdzgx7Tugh0VOf28tPRhtX8bVEWmlFyGYZGTZYJ8dbgo5nARksaQgEprMdy+UhP2yogWqG8RsdISRmI0uqSkeHBt/M4OgS5h7BXWCCswpX0dd4vgD6sSigEObA9nPns7eFeRzisRQXpw+wFgk6M3RXt6t+1dLkVLzaFJgAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B2+P/SS+; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65c01595082so3476841a12.3
        for <linux-rdma@vger.kernel.org>; Tue, 17 Feb 2026 15:09:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771369746; cv=none;
        d=google.com; s=arc-20240605;
        b=Is0tyywy9uhEBi9zrZBnhgWE5oHASMjzae2RQy6Ebkk+tjVH4vg0qVoGgodpDFViiF
         0ydYMRqaHlRQl+8VnH/9rmDzqrixfPgkgbqu2m3DObhyTvVxpTIudNnsjvD/yBXQ3haK
         g0I//wh8kGFeeq8DlIX0sY6/VECm9WJOYMeWC2M7NzJUvDgYumApBLSnt2ni8md8lNpP
         Bd1aIbg9uRViRHco6/6CGvTN7gE/4BSVdEWu1O5pjcYjHN7tJB6oEKNvjOMZrnm8bS/M
         hjU4EkK0K8vSpbtg6+1Mrm2EIPR99jqmmSQI5msHWtgMzhYm/+dBhIyQM4JOwjyKN09t
         BtOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fSZ0z8ESozqbP9AsCgWTCkr8UVza8MF4kdq23RT5Zts=;
        fh=oK4FRmqemdbSj2I/zEX8X5AIXUsNTuVDHjQ4i6XZlzM=;
        b=T9ImXo9Zp//lwjyIG53OqrEMgxkcfYft3HntN0fbMk8q9RlXnThFdOoeEGeMfTE402
         BUNuCd75sxFPSiRptEjdJNuJVLq3K8/RiEAQGuLs0YWaZ2nBgpK4rC/PvR4GpsdUwcOH
         x9WqveggVquJL+G6qCAXyJC+9ACPSAuIgldI0/OJST9VYQQ7/t2b4yPzsa94wBl82T3l
         zRDohL05lQQv+rgp/ET2CvsHP78h3E8VKUfqOh/8/TysNNLX642THnEz7T0FFq8NCwEu
         NBWE+sgqjeQsC/o86uVnXTH+y3ps4e6ooBllkZd8Jk06Wl0545P5uWwYBVMOu/Qxx4H/
         Bsyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771369746; x=1771974546; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fSZ0z8ESozqbP9AsCgWTCkr8UVza8MF4kdq23RT5Zts=;
        b=B2+P/SS+yXvYE9DxsTLUzSl0EwNr99F2I6U/3csSZRxv9lKbCuVemH7GN7HbaGrBgI
         JfVFBJvWdY3DbGoZA+Y+TWAtp0MBLulrtFYUyptR2V7c2KT2v6tRrvv7qgK1s1N6Qy8c
         ZBwSrxFTpJIdQhi4amlT1WUaj2+0io/PolvfnQNC6B8OEynnvDrJfQUj5OXhIpCRGd5t
         hvCX1fdTp9lwb11neeCcHKrTDr6nrZEYwxTOYtKJI8G4GDK4O21V2O3hRAGxNXXy1tTI
         MjtjAICTlHDQ10RHpFFtOGNv5I+DD30+DKU+6oBY5Jm6Mp86ygjsdL+DHxjgBwqkkM7d
         kuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771369746; x=1771974546;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSZ0z8ESozqbP9AsCgWTCkr8UVza8MF4kdq23RT5Zts=;
        b=Rp5U05yuNV8wPIgryHhZaUy97hcW6Y8+QlXzlYeg+JjLVtJthSmOMFIN1dpSoeq9vK
         1UXKQlwKLq0Xh+JKdWy9VOW4HsjFxaAPAw0G4vdtDymNaPe2lwo3jOGZY2t7BScpKzTJ
         Rr4Arc/nMQ/mLiMY/BmcbXI9naQ9NN3dTnwNF8Fm2ADdQoMeDRnWp3UwqoNdn7PypXLD
         RjDXxnbuWS/fh8KY3MO0MYFeU/rDnWtjzlfiQjwoWUfN9xJo3KLTnoUBfxc6Z++l6TGw
         WBhTNNSEJ5ImbxePNTtcZ4+Jgif3spRdvMnpJE9gWtnvK/ApAsVCIRUGK55Y+4zLcca1
         hQ3g==
X-Forwarded-Encrypted: i=1; AJvYcCWEpJBs3+brFY9G+xPD+SmUHg1XEWI1m/KUkuWLZvmpb4wIN9/QYIqpLQvzQZzG3RUWkuG1wJ1oyXLW@vger.kernel.org
X-Gm-Message-State: AOJu0Yyir48dvaL8SwLii4QfWABi/TuV884W6d0RS4zQVI0c1Brkkl7H
	ZQT+QfhJ/MZ9HBbQ2FRiWmkyiB7piZpGO7921p+oL7F6+qF7WpjqADNthvO7vU8vEQCAgNxA66T
	f9Oy/iQe9KkE/vvP8XeiuDg91JuIItLb8NDWN33nt
X-Gm-Gg: AZuq6aJPG53mra3sQ5tOT+TjUHSjs7nK29te5JVAHZbqbulDAr5F7w4sf/FjBTo/6on
	Mf7DsxUdt96gw5rmPPmotaeogFaIAlRO95FHwiUjDpST0vAeJZbFOj5csRBQhtSSJDdJ/bw+6TW
	YHrfrJzIEUnS3DK83YNUVHh2LzT7VmHXRkWUT9ePr4hTzEbZrkEIlrOJx/IYxWnBiCBKGlVWXvY
	H4a7yMgXnnTmquOYhuNLfVj6kN+JiwN3jUb3JAWyO+mSBSkKZGU5Dzjq7iij4pad6o9CFV47Yru
	5pGumiKa
X-Received: by 2002:a17:907:9627:b0:b73:572d:3b07 with SMTP id
 a640c23a62f3a-b8fb4390643mr846648766b.28.1771369746134; Tue, 17 Feb 2026
 15:09:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217182116.1726438-1-jmoroni@google.com> <20260217184559.GP750753@ziepe.ca>
In-Reply-To: <20260217184559.GP750753@ziepe.ca>
From: Jacob Moroni <jmoroni@google.com>
Date: Tue, 17 Feb 2026 18:08:54 -0500
X-Gm-Features: AaiRm510z1pqjEuAIbq1dDc_vKPvec0YlQxJzE50w6T27L8IghEtEZF8yZCqUdI
Message-ID: <CAHYDg1QdYZjT81gB6geWKpeRR1TEPKnk9XD1eXcMriVAOHCo4w@mail.gmail.com>
Subject: Re: [RFC] RDMA/irdma: Add support for revocable dmabuf import
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com, leon@kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16977-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 7D5BE151B93
X-Rspamd-Action: no action

Hi,

Thanks for taking a look.

> Really need to explain this better, I forget how iwarp works - but you
> can't release the rkey/stag in a way that something else can get it
> reallocated.

I think the HW command names are a little confusing, but for irdma, the key
allocation is actually handled by the driver. The key can't be reused until
the region is fully deregistered (which calls irdma_free_stag), so a new
registration can't grab the same key even if the dmabuf revocation occurs.

That said, I am testing with the NIC in RoCEv2 mode, but I don't think it
changes the driver behavior in this area.

> Finally, we don't actually support revocable mappings at the core code
> level. We either have fully pinned or fully movable, so this is not
> right to just change to ib_umem_dmabuf_get(), that assumes the HW is
> fault capable.

Ack. It sounds like what I really want is more like ib_umem_dmabuf_get_pinned
but with a functional invalidate_mappings method?

> Probably what you want to do is add a revoke callback to the pinned
> importer?

That does seem ideal. Re-registering it as a 0 length region (will check
the spec) seems like the easiest way to achieve it. Using a special PD
for quarantine purposes should also work, but it would add a little more
state and an object to manage (could we keep it in struct ib_device?).

I was hoping it could be done in a way that doesn't require driver changes
but I don't think it's possible. There's no kernel rereg_mr method,
just rereg_user_mr.

Should I create a new kernel device method for this? If so, then I wonder if
it makes sense to expose it as a generic "invalidate_mr" method and let
the drivers choose now to actually implement it (many can probably just
forward the call to their internal rereg_mr logic).

Thanks,
Jake

