Return-Path: <linux-rdma+bounces-21407-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFibMD2TF2p1JwgAu9opvQ
	(envelope-from <linux-rdma+bounces-21407-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 02:58:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 409DA5EB727
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 02:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4039F3012BDA
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 00:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FE67E0FF;
	Thu, 28 May 2026 00:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Dl5XrIOY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF08521C16A
	for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 00:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779929913; cv=none; b=GgBkQCuF/IG2gXGbhkewrNH48flEzL700iZ/EfIXhGN2TFMQgm5FqNttYJs/NZSuyRjcAzguoAieuqaQMzdgve7mdqta6xtDsKvW8ioo3YYAMZnOZ/i5wTv7652vEW4QQhkkaWEdqYX3ePtcpzAnUKttBSkLPwxKzj6jV3uvWS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779929913; c=relaxed/simple;
	bh=gbEcFPQKn1zApRTsa4tDEyQ17KuggKwrseEgKq7enmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1/T53uYfONPxGTp590gm3ChTb+JSGc081zrqlbXArOGMl/H5V0YN7bN2+9JyKoziQv72icGdAQin/F640dFjyV7AQ9REFVx0xPmUua4QRzuOmtypILtBxWBdAOA2fyiiiENCCWbyVAeARyw/mwofVcCESk0tx+kowOQYFoYHxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Dl5XrIOY; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50e5eb0fabaso139453101cf.0
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 17:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779929909; x=1780534709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=McgFI3nwjV5DgFwyURR1/Gpfj3fCvJ4YlksrMBKUDXI=;
        b=Dl5XrIOYz8wDI/WijNGMFJlZetJE3O9XFTaHaQakn1EYelvn6HHZDSrA+4oN3aAfZO
         nksnwhR5R+zQ9afUxVatVNaoL1L+RbLTqaaX7+THRXbK5846pcfOJg+VLZlKfwkmUvYO
         WS9LLtie0qeGsLp6BoN2hFL2Nl78uXkFDDdfiNS2UWcXOt5qKu4dJ0ArbUHvKECx9RgA
         aXdCVEv4VryoIj5XZPGc+VkUaPLG8E9Cp1FoFvz3JXXNk6Wcd12bquJhFQddAkss0dWc
         +ZCKzQ+mbZBlNOtMH/xoy28oD+EP4PZgom+P0uhX+x2I+L3zLP0dP+fqLsnPwhTMjgrN
         +Q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779929909; x=1780534709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McgFI3nwjV5DgFwyURR1/Gpfj3fCvJ4YlksrMBKUDXI=;
        b=AnXEs/yJpNvQhotAZv+pOzYMpDFvUK+z/dSULkWYpaJX5eJLAtYMTeL7ed/eOekAu6
         T8m98soNp0MtzMx7I/caaKGCtPaFHWcjQpF298kYef/YpzEY4rctt2ezriRVChROQtUH
         rmsNWZUpg9NA4msVGuoWYbg+0IAmPCzJ/8WWdOK/Xz3bS6VNUnGtBFQIobv+SP2HPBX7
         KmAU+A1eFiOyBYVpbHY21utKTn5eDqNAk7n8uEx7WWKTC+RKQGJoUVIWD7FvrrM/2pyh
         9IhpYiT8+bvHmyZWFVqSkeZojdmX9NQO+uyhZEpxU2mCxyHtFBoqBKCTFVliEOuo6bZi
         kNmw==
X-Gm-Message-State: AOJu0Yx2FBoRrXVUAAmV65+XGamhJ34m3NvRCLiftsVzw+YNYynpqh+U
	sIPA5FD15RKkszCj/BJb0Vu3kH+9jcY9IrUGYJREY8YfFudnhhYVO03gYnl8/Lsbr6c=
X-Gm-Gg: Acq92OHEvhlhGey6mbxf0YZoap6ukkoghBcJKC5RDTWncKKrdGrpxaF7iFRKvjdlH6x
	9KPU0lB1IXPC7itKVXkTA8P4RwC7WIkCV2JJ7jRoWEEEGvVnOhjMlyN9jUCNXng6IU/KrLUVGsY
	2j7K24tXleJyHU/fO0P/m3pmk2sGYKbnsmbgwFJIAhj3hUWXZYk23HMIeouO1dGaWnAyhq1S8yL
	svdNRnWst2SJeWtOVzph81mqDbCJnbkRvl6tDnX/pYXbacficEVN7T1rXMPTrwseS7AVal4o1Kd
	TnvVZSfXyAAOrV+mciJaDN0naR/35vkctqcUDr3y85/SQ6voyPd1tpMHaoM73ZDFt5AAmFDpSWx
	t9mCAWja//3OxyXRPquniq+72UZdXoC0Frkrw4lgyjkiGhgjO4pU96/HZ6oRSbAa33rIezsYbN5
	E/YShViTovRnme4efVUKj4wzpwGm2qU5MefvNX6PcPT30xTbIwbyil8/9J+12WDn5+B/t91FmT1
	PU4sO6JAuD+7+6k
X-Received: by 2002:a05:622a:5c1a:b0:516:d66e:7b20 with SMTP id d75a77b69052e-516d66ec055mr324890671cf.36.1779929909420;
        Wed, 27 May 2026 17:58:29 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8130d540sm182547056d6.38.2026.05.27.17.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 17:58:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wSP4u-0000000Fu21-1tHL;
	Wed, 27 May 2026 21:58:28 -0300
Date: Wed, 27 May 2026 21:58:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com,
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com,
	mbloch@nvidia.com, yanjun.zhu@linux.dev, marco.crivellari@suse.com,
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com,
	ynachum@amazon.com, huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com,
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com, jmoroni@google.com
Subject: Re: [PATCH rdma-next v8 00/15] RDMA: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <20260528005828.GG3528738@ziepe.ca>
References: <20260527170948.2017439-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527170948.2017439-1-jiri@resnulli.us>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21407-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ziepe.ca:mid,ziepe.ca:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 409DA5EB727
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 07:09:33PM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> This patchset introduces a generic buffer descriptor infrastructure
> for passing memory buffers (dma-buf or user VA) to uverbs commands,
> and wires it up for CQ and QP creation in the uverbs core, efa, mlx5,
> bnxt_re and mlx4 drivers.
> 
> Instead of adding ad-hoc per-buffer UAPI attributes for each new buffer
> type, each command declares dedicated UVERBS_ATTR_UMEM attributes that
> carry one buffer descriptor each. Each descriptor specifies a buffer
> type, covering both VA and dma-buf. A consumption check ensures
> userspace and driver agree on which attributes are used.
> 
> The patchset:
> 1-2,4. Plumbing: rename ib_umem_get() to ib_umem_get_va() and re-route
>    it through ib_umem_get_attr_or_va(); no behaviour change.
> 3. Introduces the core buffer descriptor infrastructure and UAPI.
> 5. Factors out CQ buffer umem processing into a helper.
> 6. Adds the CQ buffer UMEM attribute and driver wrappers.
> 7-10. Converts efa, mlx5, bnxt_re and mlx4 to use the new CQ helpers,
>    with drivers taking umem ownership.
> 11. Removes the legacy umem field from struct ib_cq, now that all
>    drivers use the new helpers.
> 12. Adds optional whole-QP, RQ and SQ UMEM attributes to QP creation.
> 13. Converts mlx5 QP creation to use the new attributes.
> 14-15. Adds mlx5 driver-namespace UMEM attributes for CQ and QP
>    doorbell records.
> 
> ---
> Based on top of: jgg-for-next 9733e9f580fdda2e8c1cd349caddd93f026ab6f5
> 
> See individual patches for changelog.
> 
> v7: https://lore.kernel.org/all/20260526144152.1422310-1-jiri@resnulli.us/
> v6: https://lore.kernel.org/all/20260520101129.899464-1-jiri@resnulli.us/
> v5: https://lore.kernel.org/all/20260517063006.2200680-1-jiri@resnulli.us/
> v4: https://lore.kernel.org/all/20260507125231.2950751-1-jiri@resnulli.us/
> v3: https://lore.kernel.org/all/20260504135731.2345383-1-jiri@resnulli.us/
> v2: https://lore.kernel.org/all/20260411144915.114571-1-jiri@resnulli.us/
> v1: https://lore.kernel.org/all/20260203085003.71184-1-jiri@resnulli.us/
> 
> Note this re-works the original patchset trying to handle this:
> https://lore.kernel.org/all/20260203085003.71184-1-jiri@resnulli.us/
> The code is so much different I'm sending this is a new patchset.
> 
> Jiri Pirko (15):
>   RDMA/umem: Rename ib_umem_get() to ib_umem_get_va()
>   RDMA/umem: Split ib_umem_get_va() into a thin wrapper around
>     __ib_umem_get_va()
>   RDMA/core: Introduce generic buffer descriptor infrastructure for umem
>   RDMA/umem: Route ib_umem_get_va() through ib_umem_get_attr_or_va()
>   RDMA/uverbs: Push out CQ buffer umem processing into a helper
>   RDMA/uverbs: Add CQ buffer UMEM attribute and driver helpers
>   RDMA/efa: Use ib_umem_get_cq_buf() for user CQ buffer
>   RDMA/mlx5: Use ib_umem_get_cq_buf_or_va() for user CQ buffer
>   RDMA/bnxt_re: Use ib_umem_get_cq_buf_or_va() for user CQ buffer
>   RDMA/mlx4: Use ib_umem_get_cq_buf() for user CQ buffer
>   RDMA/uverbs: Remove legacy umem field from struct ib_cq
>   RDMA/uverbs: Use UMEM attributes for QP creation
>   RDMA/mlx5: Use UMEM attributes for QP buffers in create_qp
>   RDMA/mlx5: Use UMEM attribute for CQ doorbell record
>   RDMA/mlx5: Use UMEM attribute for QP doorbell record

I think other than the remarks in v7 I sent after this was posted, and
the few things in v8 this is fine

Jason

