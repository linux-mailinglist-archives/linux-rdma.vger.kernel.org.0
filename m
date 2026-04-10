Return-Path: <linux-rdma+bounces-19213-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DGDAJUe2WkAmggAu9opvQ
	(envelope-from <linux-rdma+bounces-19213-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 18:00:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DCA3D9F89
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 18:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B8F1303F632
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 15:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9533D9DAA;
	Fri, 10 Apr 2026 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nZWgR+OE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1723A3E86
	for <linux-rdma@vger.kernel.org>; Fri, 10 Apr 2026 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775836147; cv=none; b=nZL+3q2viE3QgPK+hanvKR5Ap1Jxnkja8QPNLjWd+YMpMNl7mnY+Wxe9PIThm+U3vmla2d4fQdjElYt3x17b5DnEU9fRbOwZwf2IlxtcrzBO1isVDSDKBQhIIIT1iW1gqilKHiJTmEbCEhYF/6LwLoQC6eik6q926E/Hywfdc3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775836147; c=relaxed/simple;
	bh=0Q0+8gWU/OnHPwUzDqNWTjffaSeWf0ubCqA+tJYMO5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYTOGUwvmyL+P2kD2sJxhGxHJys7Errng620ZV8JNWwbSSP2gWbIJANwnYBLg1UjoIRmR3ckhb/pQQS70ecJIhOUiSuU9+9aMwKlaP2tGY/qa0KgtEAsecTQitsWFPrf1weRP2+T/s4AbJjNwk6Bqlv9E7fbZ2GQYgOTcoyRwBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nZWgR+OE; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50d9436f2adso24697441cf.3
        for <linux-rdma@vger.kernel.org>; Fri, 10 Apr 2026 08:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775836145; x=1776440945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ObmojYrR1bT1z5x62+Qhk3lWqZ4Kveh/kQz01OPOloE=;
        b=nZWgR+OEuOvD0Y8zTsqOexDYJ2I3U/Tv38Yw3J6/b7oGY5Q+FHq0gJsjYxOIImYqwI
         xTmZs/g4Pjm9YNNWOzW9LUTKpp80ds8/SrUw659aKCHxJ5FUffs9qffTDZT8NANKzNxk
         RFf8Q67PcKe7S1xy7jIlNUUzD8/vShrr43pJXQinAOSYzxtQtHLR9mF8N0scGlDh+BwI
         GFIde74szTWdOqLjibq4Sh2Oaw7MQX2WKDajZSKr423oTrFb1/vXXrH9obGGFK+uZ1jq
         h+bXt3KvpXqLLheGZUHNgtZewOsEPBPsBacKOO9aC7VzDaNilT40ATxTnmeeOmtrHox0
         z3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775836145; x=1776440945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObmojYrR1bT1z5x62+Qhk3lWqZ4Kveh/kQz01OPOloE=;
        b=YbK0agoXJz2RERv5z8O3hCDCtwt6v0DMjg1Qea1VIwQfeLWPnWUg3yoHqv9ZFqeMtM
         METocIfANwz8hfFWAUp6pdwxXts8NuENaZRe9SS5rAqYKdfcwqbKcFQvgwI+Nnc1Ucrd
         6+Pi4wPMepEg+Vipk5MYd0VJTnvJXNkoNx69/hBIENy2rZYnvp2fYvKA5kGDciNTkm1c
         rJyvR9KsejNwv0K+MEuiLInzxIAntEmBcqiYAipAxCF8lgiecKYkznLMBbDGqSVcuJdr
         ujFn/L0dJBqEm2PJe37XGkZIn2jsEFOgdZi6ROwML7WT1EUNN4Ph4Zju6oQ6Nno8+xWx
         2mwA==
X-Forwarded-Encrypted: i=1; AJvYcCWwnRWSr2Nn3fSWr6KdXqELojgPkRYZX9gSqQ5fLMoqHwksLX1v8YhHULeeY3U4ayqem5sg4Un2qSEp@vger.kernel.org
X-Gm-Message-State: AOJu0YxIkiatuJvcxfcAOycy27ryJAbh4AZ8GRc/AVZJpullEVO6YOrl
	e3Ti06vUpxo6L1cENweX9+ZOcJ+CxfDYKgWD0s213yBo6bEz30j8azp8UVYHAMY2ra8=
X-Gm-Gg: AeBDievOyzc4AH1oqOC99pJeKv9wXSDP4FSGPx9xD5RJV1CLmwgXA/wZ2Ehma4xtmD5
	zgPUqm54a0Vcn7s42D0eP1LhlpFcGvSDK279qRKz9kx6KH5n5BvgDsBEPjdthbEAx02vA4/kJRu
	cHGQX6tyFwQksCeZVYV+/NSlxuUG9/1+g8J2g4uuVPwkor4QZ92FaChIybekAu92RY7w8veRxaC
	tucGo7JjR0IJHyRePqOzVq2fakRExbhbLt1K+5FbL8bnMY+4RYEjvOA7ZG/Cysf0mSj3XPU2mly
	EgghDLEhBJV+Kay0VWY2wVMFq4wjfXwRBcO5n5NKdDhCF3hfLSVI1niCJFyGIxEKmbmC8Uxi3wq
	cfH0h1tlXGmCxUeUVErRnomXnd7HhxqNQBQfW0h0sRFvxNj3y/ZTYaIQuvaQ70UUXsoOXdi4kdX
	rAjH8tnZI6hgI4fp48kTKwzaiNlCavUVFSCllCpXszWg/tqsgXMCWSGcIe0PNseL9cz8p23Q==
X-Received: by 2002:ac8:690c:0:b0:506:8738:651d with SMTP id d75a77b69052e-50dd5c6c83cmr59257571cf.62.1775836144664;
        Fri, 10 Apr 2026 08:49:04 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd5cde374sm26640791cf.17.2026.04.10.08.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:49:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wBE6R-0000000Ejyx-0q5y;
	Fri, 10 Apr 2026 12:49:03 -0300
Date: Fri, 10 Apr 2026 12:49:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Long Li <longli@microsoft.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <DECUI@microsoft.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH rdma-next 0/8] RDMA/mana_ib: Handle
 service reset for RDMA resources
Message-ID: <20260410154903.GB2551565@ziepe.ca>
References: <20260307014723.556523-1-longli@microsoft.com>
 <20260307173814.GN12611@unreal>
 <20260313165928.GH1704121@ziepe.ca>
 <20260316200843.GK61385@unreal>
 <SA1PR21MB66832D0A369DE7E411ACCDEDCE41A@SA1PR21MB6683.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB66832D0A369DE7E411ACCDEDCE41A@SA1PR21MB6683.namprd21.prod.outlook.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[ziepe.ca];
	TAGGED_FROM(0.00)[bounces-19213-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:dkim,ziepe.ca:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4DCA3D9F89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 11:43:49PM +0000, Long Li wrote:

>    Today a DPC event on one NIC kills all RDMA connections and can
>    crash entire training jobs. 

All rdma connections on that nic, right?

>    If the ib_device persists and the driver
>    recreates firmware resources after recovery, raw verbs users can
>    resume without full teardown, and RDMA-CM users get the same
>    disconnect/reconnect behavior they have today.

No, I don't think this is feasible. There is too much state, the
kernel cannot just recreate things and transparently keep going
without userspace handshaking this. IMHO It is just the wrong model.

We have always gone for the model that userspace has to be involved in
the RAS and it has to recreate its operations on a fresh new verbs
FD. I think anything else is going to be so complicated and fragile.

I can't see any sensible way an already open verbs FD can survive a
device reset.

Jason

