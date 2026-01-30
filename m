Return-Path: <linux-rdma+bounces-16257-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wF8WH8vDfGmgOgIAu9opvQ
	(envelope-from <linux-rdma+bounces-16257-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 15:44:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6514BBB14
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 15:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34667300A77F
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 14:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00C5326941;
	Fri, 30 Jan 2026 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="G572Xvqv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39283315D21
	for <linux-rdma@vger.kernel.org>; Fri, 30 Jan 2026 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769784258; cv=none; b=dBv8Q7uTqoP6HbOUEI53IqLhuLVEDHg43alXbcIFer9fh+NFhu8Lga09Z5ZUZZjWQV6RAc9mpR5u1RglstPy7vWKU09RCfQ7YPw//S/JQh4szM5xY2SIKFtDoRqiWf8XuV5f/dE3+AzCbw5vlP9Q6gG3EQ/GyX0CDHqvYHIi/P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769784258; c=relaxed/simple;
	bh=VsbMM5xoKqA8UQ3isRtzAP4PmVkOh9whfmV8sar8q8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/2jnyer26LvKT/sWgwT1nw08Qyz/VgJvdZ1nh9ir8qPs+j7HGeAoFmF1ywM5xyPMLcdfSbWMykkwubaOkvQfKSd3Ujo2Khnrwgwl6C9saX2BLmCgDdJpZ1tF5t11KQaN+QGMgLm2hG5BvrJsAW+npGfyShSN6gG1qu6uUB98jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=G572Xvqv; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-505aaab61d9so10741191cf.0
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jan 2026 06:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769784256; x=1770389056; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UlIFC23S9unnjQhVGEC3vUha1a+Kfy5xxpLqRiUCtvQ=;
        b=G572XvqvqEJ95BhX2bAuiQ/O5wI4h8d/DRsGbf3bogEs27PccC/FQ9DAz/U4GD5IIA
         /QshJGOAPahQIA8znGcPtyDORLvxPEHNhRbhESmpvY6wWD5tgB/7tS460R14YJJkMo+0
         6P/HA5MGamiEsVxo2G0Ux2BIqTt+1DZM9SDgakye920Jk6xQTS9XOjRWOxZz+rJkrpBr
         8nv3x6TuipUUnMw5cQvHttzzVcP6rCgHC6OLjc2ujgi50QiKkG5I4LSbzV/EDJvaQMsg
         7m7EiE5TkuVUtJ9zbigdaa2b2446bdwwa8jlXFFHbp4YBpiz68Lj+We8pesk7AiM2ton
         5rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769784256; x=1770389056;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UlIFC23S9unnjQhVGEC3vUha1a+Kfy5xxpLqRiUCtvQ=;
        b=p1cAlvnPAe7TfSRsMeKA4OZMF/Y9TEUDEenYVilS7dHfDiDlmJsoNeQJr30/KUPppa
         2F3fQwQ9MwLrYfrsPEBJjHxgZK1MEJIQoWwnsqDDGSudf5xEMF4UaLkrk4nk8T/W9W5F
         W24+hwZGIQR+erki9K/VI+lVs5lmHbhKn6FRlogN06GgchB6XvJjVGZNK2LSS1u/EyS8
         59WpgN5HIPgJLI2L46WaFciaTqZZrCNi15m2UfGlA/kRcKvVL4G8qgOW6njzlzQCz5xj
         yHYh2XMGjKfsThi5dNOyIDYZYYxPJSTqvo1HlS50CT+8Xu13pKZ8G+ub6mMD8omffEo2
         ggMA==
X-Forwarded-Encrypted: i=1; AJvYcCWgKNNNuI2WGeWu7U6YbgNGDGYu49KCN9QRemqq9ivsaoaqG7HXUmGpqWCI5Ir45oCT18IngwBeFgPl@vger.kernel.org
X-Gm-Message-State: AOJu0YxMfvDIGW2HQZOLT56lAVyYmzBqEwxpv55ppwc/gbriCwGMQS0b
	vhQZRSiToIaccVBA8gKygjRmZimV7zr3B/WQcHA7rjKw4N0Ly//w009CO9eRmODqSxg=
X-Gm-Gg: AZuq6aIUeWVP8ikRVBgUF6rUf5FpRgplKn+gUbfPy7g+012r+cIpp+BsW3sCUZPPXIg
	sxs+QpoEj5JduMw3IAPjJ8Egu7d5C3X2W7U84fMqnFugvzZZQ14WvZN19uFzzyPGN101nWjpHP8
	X/s27h5BNx/5OKKquzwGOSebGxC/mN5Zkt8yttCjKmdem6zVEhVjIWn3KksKo61n0TDqklpGaml
	hyKGbImkR6nLO4ApEhqlsj1BhqmtqrumG+xk78qSttE9FfoE5SuuuZgeelfA3RaOHMdTK+gG1wS
	LPVMePVNc3pJ6SYLISHdiUI86B90fSK44mxj3SyW8jO39fHPhQ5TTiJP+5Qm/4BF0AaHAk6azlQ
	XYIQhmuaKNzJntLpPmY2zmvuLSkYPVxxfYW3DpS2pNZ6weVzaRCMXYAvL0/dVPVWQQl9wKxOI9D
	5Dhrh9icBoHP8lWujVq0lGZEDIfG4JOJ+KrJosXqt15UkCk3oTZjOBGCMwup/V1Vrp7yY=
X-Received: by 2002:ac8:7f0f:0:b0:501:51b6:cd3e with SMTP id d75a77b69052e-505d21a4775mr39321141cf.29.1769784256186;
        Fri, 30 Jan 2026 06:44:16 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c426sm56137391cf.7.2026.01.30.06.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 06:44:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vlpjL-0000000B0t1-0Fhg;
	Fri, 30 Jan 2026 10:44:15 -0400
Date: Fri, 30 Jan 2026 10:44:15 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v5 4/8] vfio: Wait for dma-buf invalidation to complete
Message-ID: <20260130144415.GE2328995@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-4-f98fca917e96@nvidia.com>
 <31872c87-5cba-4081-8196-72cc839c6122@amd.com>
 <20260130130131.GO10992@unreal>
 <d25bead8-8372-4791-a741-3371342f4698@amd.com>
 <20260130135618.GC2328995@ziepe.ca>
 <d1dce6c1-9a89-4ae4-90eb-7b6d8cdcdd91@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1dce6c1-9a89-4ae4-90eb-7b6d8cdcdd91@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,amd.com,gmail.com,ffwll.ch,redhat.com,collabora.com,chromium.org,linux.intel.com,suse.de,intel.com,8bytes.org,arm.com,shazbot.org,nvidia.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-16257-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: D6514BBB14
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 03:11:48PM +0100, Christian König wrote:
> On 1/30/26 14:56, Jason Gunthorpe wrote:
> > On Fri, Jan 30, 2026 at 02:21:08PM +0100, Christian König wrote:
> > 
> >> That would work for me.
> >>
> >> Question is if you really want to do it this way? See usually
> >> exporters try to avoid blocking such functions.
> > 
> > Yes, it has to be this way, revoke is a synchronous user space
> > triggered operation around things like FLR or device close. We can't
> > defer it into some background operation like pm.
> 
> Yeah, but you only need that in a couple of use cases and not all.

Not all, that is why the dma_buf_attach_revocable() is there to
distinguish this case from others.

Jason

