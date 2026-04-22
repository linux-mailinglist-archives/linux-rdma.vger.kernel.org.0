Return-Path: <linux-rdma+bounces-19477-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cclfGm/36GlYSQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19477-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 18:29:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D2F448A88
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 18:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 147623005A97
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 16:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874E135DA5B;
	Wed, 22 Apr 2026 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pJvx2Y7f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC84637CD28
	for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2026 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875372; cv=none; b=Qa8D7sEEvelqv1vlfhJIq42Mx9OESSNcNOPvMet3qYlzcvfkl6elFE3ZKge8fcZ6nWXNlEScqQL/IeN2KQFASm/wv3Xxg8ecGkSIA03kpXTLftX3jN5Z5dYHiHFE3z1Q5HnYfTHYKH1o1TASHs0wVLg3Rj/sxVlLWc6kgauKOyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875372; c=relaxed/simple;
	bh=7nUTpLDZcNwHVIBFnUXlZ2h+DqdD9r7qtP5b75FfdX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1LIOFXdVRn10sWAFqIJkvIWnegizOxvrTQPQFAs0kftCZ+w9eVBaEOFaJN1CdZjUnfN/QyGu8GWFcTVqHI2kco05uVkhFUVFAki3A7JgSpWpznr+yGOLuegZEG3kuA6vmO0BcZc4MvUDQci8nW58LtdDqgBKK5k+argt7wc/tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pJvx2Y7f; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50e5ad864a6so31616891cf.0
        for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2026 09:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776875370; x=1777480170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h9IY/0ZHCf/patsFxziV9u+pjgUJWDhTV7Q7rdgygPM=;
        b=pJvx2Y7fJ5pRaa87U2jGMRAagGCpZPf/KPXYOkaL7GhCt6l6UhqQZ/A0y/BhTI0DcR
         7ESGzMELWUIIPm4cauAh9D/DzCJU3MXqnZn2QEj6UXZlGvpe5AaCgULd5jhGWP5gbC5k
         cjW1khqmaDO4AAgE+7i1Jw32Lif3HY4W15HkkQ1O8iHli1j3wVrEWMW1GJlZlvSYlXmi
         RGyaDzp7uoxx3YF1rVKy04lCwZazcXGkSorGhtUb9eygF71AqmacasFi+VsHlXGIZeln
         +7qjZktq7NYcYRfxHPfvoZyhSRbvw9gYj1nNZUu7kCiMf3BpsGBEvSzo4Jfcxon6U5zl
         k5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875370; x=1777480170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9IY/0ZHCf/patsFxziV9u+pjgUJWDhTV7Q7rdgygPM=;
        b=pohh8UAqMJ58sLxZIT+3k+vZ7235FRpDi2YBo1TuACdUq5lFr08T/Z0MT0/Qc7oIni
         etX04lM4VVhWZR3LgeNB7QngVCMnbLXurhAQSvZXlPhab56yOIJQx0Okf5raIlCnDPGz
         qf/aC5inEOFfmVwrSezSBPeyjlUSF+FRSYEe0pPcM1xj4r7LjPV6YEwovOi0doQ7Qyb7
         7t9UDpqCHDT6NUcghekD+7eZFCX2YRwZi/Scsy0OafLLNDPsS9wE6HJdjRNL5YbGNopm
         X0HphqsYP0t9qrKaQ5zLuUhGko6GMTdpFXdZ0ni9F1b9IP6O7E3YPiby60BpleCflhpN
         66Pg==
X-Forwarded-Encrypted: i=1; AFNElJ+dJvOMrAIO8dYnI9RmqzpNTaZRynq1YljoBnUJVLlIKDlcWUOO/CoVbI7Hr4RKHHju87A82F9rxiXE@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/4LqgVJA3jSzGo7ELV8YEg+JvCyPBeOln1EI6W4g/+TmFcHXA
	JanDdnp3iSFYBvlRlNsldvFa36yv+UJz44Ax7bl/Ov74Vtd/G3mfh+A0tmUhxUyL+rw=
X-Gm-Gg: AeBDieu95RVLerzdd11IgQ2ik9PRserBS61FT2uzT1s3hO7QrHK3s+3iRCjK5S6mP6b
	NVVGkhf6SGKxsPspRQbN+pk3WirKy7dBI192rG3QsU/mmuNoEzUvCSAmqzlRIM/B3wal1UJpbtP
	5/i3sEHWgXjbtC2nNkMAt7TDlqRyk/7oEhCMFwqAyAe5heAsZThil45pUMdTMP4yKI/A8FyCtYN
	/b9K9mEqQ3c5BkxJPMXHizENh+LQFBBQD+k09B2EDa/BHD2JS2FDAhngtEXqUFohfaXxfobj0lB
	YMFWREuypolKxLROKdeU3Pb7kEsir0uhrZWyz7y0sH5RVLjZDNwVMsW3Kq7e8BBRVZZ1x2kL2g8
	oeriaoYIiIl/XgDXwIP4C3q9y274tw5xXHtouzYNzImVhk0ZEq5onsOKRdp+Y6JE/XElF/m2DEs
	ujW768HNwjlAtMZOt7Z7/oIUmtfjIK7GgFtu/PHvzcGfHLKgkdO7+6LeJV3OpFyF7N8JPSuAlke
	H2BrRncwkXjxj8d
X-Received: by 2002:ac8:58c6:0:b0:50e:635b:5579 with SMTP id d75a77b69052e-50e635b57e4mr184629681cf.19.1776875369960;
        Wed, 22 Apr 2026 09:29:29 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e5d5ecffdsm83483301cf.29.2026.04.22.09.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:29:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wFaS8-00000008cG7-3pDK;
	Wed, 22 Apr 2026 13:29:28 -0300
Date: Wed, 22 Apr 2026 13:29:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex@shazbot.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Stanislav Fomichev <sdf@meta.com>,
	Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
Message-ID: <20260422162928.GL3611611@ziepe.ca>
References: <20260420183920.3626389-1-zhipingz@meta.com>
 <20260420183920.3626389-2-zhipingz@meta.com>
 <20260422092327.3f629ad6@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422092327.3f629ad6@shazbot.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19477-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:dkim,ziepe.ca:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1D2F448A88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 09:23:27AM -0600, Alex Williamson wrote:
> In general though, I'm really hoping that someone interested in
> enabling TPH as an interface through vfio actually decides to take
> resource targeting and revocation seriously.  There's no validation of
> the steering tag here relative to what the user has access to and no
> mechanism to revoke those tags if access changes.  In fact, there's not
> even a proposed mechanism allowing the user to derive valid steering
> tags.  Does the user implicitly know the value and the kernel just
> allows it because... yolo? 

This is the steering tag that remote devices will send *INTO* the VFIO
device.

IMHO it is entirely appropriate that the driver controlling the device
decide what tags are sent into it and when, so that's the VFIO
userspace.

There is no concept of access here since the entire device is captured
by VFIO.

If the VFIO device catastrophically malfunctions when receiving
certain steering tags then it is incompatible with VFIO and we should
at least block this new API..

The only requirement is that the device limit the TPH to only the
function that is perceiving them. If a device is really broken and
doesn't meet that then it should be blocked off and it is probably not
safe to be used with VMs at all.

Jason

