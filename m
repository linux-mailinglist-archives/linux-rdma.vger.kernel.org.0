Return-Path: <linux-rdma+bounces-17051-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAvwHrnem2mu8gMAu9opvQ
	(envelope-from <linux-rdma+bounces-17051-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 05:59:37 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CFE171D6E
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 05:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4229B3024A4D
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 04:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AD83446C3;
	Mon, 23 Feb 2026 04:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsRko61U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD98F23EA85
	for <linux-rdma@vger.kernel.org>; Mon, 23 Feb 2026 04:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771822772; cv=none; b=qgmNHIY00DQcFNLMFVre6UwCmxdE5P8sgGo2TBuF7hK85YWB43tCeVsTePEPtDmc/TYMXgH9zhhLRZu7Ytj7u9UZ0X6Tn9VhAweApdDUoFVKgsRQx1HNbowvQlXEWcQ0N7MkwHgHUVN27MnF8yKEMcZ6bEykAs6Dzq5ESwbuww0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771822772; c=relaxed/simple;
	bh=LEFPyOaZEpHZmLXlHJrYQGoiUUQMfjxNFS9DsEDVwfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFfPwTNXlOXEgxQO3s52i55TrtjadWl6HlIkqHQt24kg+ItmgJRZTOFiQ7qO20WN5/ZcKPWJQAUPJnAY9rXtJJBa9U05P+dpiuFDfHdaa7mwvFCG55aujBZ2dfCbngsN6lowWM6VWo78/8Uu1MluxowAJ+2O63DvM15S+m609xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsRko61U; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ba6aa57d5fso3796584eec.1
        for <linux-rdma@vger.kernel.org>; Sun, 22 Feb 2026 20:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771822770; x=1772427570; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ar5KC76tgxYX5PKL9eOkCAkUY5PVkOEvBMJNrWwerKw=;
        b=CsRko61UrOS/LBnAhxuT+TWf8AuTTluYnyJBxljgNtgtNuGG9boFKJoaOwN4c3nkpx
         O1FhxiGi7tpK9YS062HKjOmg71nrE4ULTFC0rWU8gkgL5ovwFceONVcnsbbVyCZEbtMO
         /ACAjgFK/pzoRzC9YU5WQCND9Jr1qDUCfSQUHBnVKOPtyvfWmbDMSVcH1eSf0LH/GBTw
         d8NHME19BnqWxpQKf3Fj+ue6cKIw/IDhGdqlE75mHMBNJZm4KOkHl1Yptx6Dw1sa59H0
         R+uNyoHztlcytswgQPvkUhBR+lpL7T11kJ921W5ptoS+Ww6vmbNH+bNNkprR49e78kny
         f9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771822770; x=1772427570;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ar5KC76tgxYX5PKL9eOkCAkUY5PVkOEvBMJNrWwerKw=;
        b=g92gnFjC3tZTTi8h65uP2h+YaE5wc/BrPD4xkbNaGfdgzjSxQqxgkRYJ2N0u3WrlgD
         vn2t+S0KuARdulV239N2ZvudCl3ESAkBHAgBroqG2/ISdKOpYnMatqtDXBasPg0SvYCw
         AOGd/AdfOdwJSoYDvUryFhUFR9QE0G5umfSgHg+Nrcvoqw/VlxBcjbX3cj+EsNfqVLgm
         kP/yTWMYKfosiqo7U3lepBFS6uTtjUTJzZ5R0k2ZcM4iGflklUJPzfGGh774Cj8GHZVR
         1OR/R8/scy2Enktb8w3hldOTGr+EziFrAnVA3XN69/IVDZxUtYV730TV8z6+EmGlken4
         7DbA==
X-Forwarded-Encrypted: i=1; AJvYcCVja9YliRYBQN+2KG8X+MMocfMBOcBwUz/EdokqGZUqmGr+rZEMsp/sTGv8/t5dshOWmAfhccfh1PYL@vger.kernel.org
X-Gm-Message-State: AOJu0YyRgJKE/XfafxlFrFMEA5t9TdGzLmI39HvE2tSGUdhCoCSzhfC2
	CUq10usVKV4cYRnHFXleIxVyFJNQq6KpQ30ZFVtNTZyk1raNoD9RLioG
X-Gm-Gg: ATEYQzxd6xL7ycOB1QYUJZ+ZnPYgfZEVxXc7FSMywaNliky7CH7v9V/nKFnu0P94V8X
	dditCQB7Vzfi9HvuSS4BEyVDvUF8V3pz3O2jYR0h4JRupcW9ZSk8yCI+Dck36OE4hr4fHmxkz6W
	6UII5BYNmMax1FQG+RHVIjTlcjopEuplGM0/qz+lhKEi93RrGpdWYW42LDometWEiTpSnqTEcJl
	dRVdxnAI/R0y5LMMKmnXzSLurgU97l1kZheuq29OfKKZHyf4iFabrVWvAXuS0X5xNdAfIRh2rpx
	5xuXNdq0be11e0llSFUvQLVi0KmdxaWMEFFcunClZpyTzyVk4aXARJ6kJ7FKdQZmVrQw3N1NCRM
	xUHKFiNUjD2Mg/NqARiEv5JVyAtLcVneJwPNYJAuqlFUb1VL+epe+Rmxs8bBzUSu6RarCx9NPmA
	ejF+N28aiAA9nvO8z6OJAfdCImOngl8uhvEwbx
X-Received: by 2002:a05:7301:6783:b0:2ba:6b03:90af with SMTP id 5a478bee46e88-2bd7bb4b383mr3387725eec.6.1771822769743;
        Sun, 22 Feb 2026 20:59:29 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7da4775dsm4300363eec.2.2026.02.22.20.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 20:59:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 22 Feb 2026 20:59:28 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Edward Srouji <edwards@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next v3 2/3] RDMA/uverbs: Add DMABUF object type and
 operations
Message-ID: <716e8a8e-e4e0-468d-9314-10082c2bbb8d@roeck-us.net>
References: <20260201-dmabuf-export-v3-0-da238b614fe3@nvidia.com>
 <20260201-dmabuf-export-v3-2-da238b614fe3@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260201-dmabuf-export-v3-2-da238b614fe3@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-17051-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D4CFE171D6E
X-Rspamd-Action: no action

On Sun, Feb 01, 2026 at 04:34:05PM +0200, Edward Srouji wrote:
> From: Yishai Hadas <yishaih@nvidia.com>
> 
> Expose DMABUF functionality to userspace through the uverbs interface,
> enabling InfiniBand/RDMA devices to export PCI based memory regions
> (e.g. device memory) as DMABUF file descriptors. This allows
> zero-copy sharing of RDMA memory with other subsystems that support the
> dma-buf framework.
> 
> A new UVERBS_OBJECT_DMABUF object type and allocation method were
> introduced.
> 
> During allocation, uverbs invokes the driver to supply the
> rdma_user_mmap_entry associated with the given page offset (pgoff).
> 
> Based on the returned rdma_user_mmap_entry, uverbs requests the driver
> to provide the corresponding physical-memory details as well as the
> driver’s PCI provider information.
> 
> Using this information, dma_buf_export() is called; if it succeeds,
> uobj->object is set to the underlying file pointer returned by the
> dma-buf framework.
> 
> The file descriptor number follows the standard uverbs allocation flow,
> but the file pointer comes from the dma-buf subsystem, including its own
> fops and private data.
> 
> When an mmap entry is removed, uverbs iterates over its associated
> DMABUFs, marks them as revoked, and calls dma_buf_move_notify() so that
> their importers are notified.
> 
> The same procedure applies during the disassociate flow; final cleanup
> occurs when the application closes the file.
> 
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> Signed-off-by: Edward Srouji <edwards@nvidia.com>

When trying to build powerpc:ppc64e_defconfig:

ERROR: modpost: "dma_resv_wait_timeout" [drivers/infiniband/core/ib_core.ko] undefined!
ERROR: modpost: "dma_buf_move_notify" [drivers/infiniband/core/ib_core.ko] undefined!
ERROR: modpost: "dma_resv_reset_max_fences" [drivers/infiniband/core/ib_core.ko] undefined!

The code now requires CONFIG_DMA_SHARED_BUFFER which is not enabled for
this platform.

Guenter

