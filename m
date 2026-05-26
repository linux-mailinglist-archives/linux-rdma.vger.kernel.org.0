Return-Path: <linux-rdma+bounces-21288-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B46Dq+ZFWqNWgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21288-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 15:01:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 377E85D5F57
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 15:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 857DB304649B
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 12:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5F926159E;
	Tue, 26 May 2026 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DT8oKbEF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232751F91F6
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800281; cv=none; b=RQs23v950vuT89BACFDPwG9P+iJ8BUR+JXLSggjlfW8L6zu4QI+8dAuMD+QnvBOpkd3R3PR09b5pSf5edaEyo+Of2n+9pNs8sRSNnClEevz7Q5vafGiup4XyoB688adwb7Mh1Vjei1AV+0DV0+YMTZJNd0KfZmex8QO/Lgyd0MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800281; c=relaxed/simple;
	bh=glVNOVD8gAB8ARSFAFANQr3d9gdhukxkEriIb9YMLe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9QfRvQnDQqbez3HT0cZrnHU6kZ307o10rHXXblI4gbueSywCk2/fLW7hz7vYXstCa5VJXRdKW42d08pUtyIVHxd8GkZ1KQ/43p5wK3mc1a6tAXZiEMRxy0e9L0ql72Vm7hnAkLCqa1f74VoG89ySSrH5vS9PBsHMBEm3qzv8Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DT8oKbEF; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50e614fdb42so82358481cf.3
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 05:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779800279; x=1780405079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pnSIGXr2DYxhyE9HUVE8MOB38M//n4fgb/csbPCCuDQ=;
        b=DT8oKbEFZWct9vsB+NXo3ZsegADeZSFnajAZk4Vb2Stt22rIE2Knz2xUxKzlZXE4Ih
         mRPdOy4UTQ0HDX8eMnI8nJ78b9JpUxrzCwKerr7gt0+ayMNYivLMtRbIJyotIKeWhiWP
         5v8Ste9n82aCqlxnBHUzx1qqI9zyP0I8VDpxDo0e76m22zH+kKYUm1DVbRUHDxJcJZ2y
         JEBCdX0ZlCh9l5RaUWzI6rUgY/bt5sVYMk4OFKPJtxWABwP3S0cKDOu35jQeMBCdcQit
         LYZHZVHnwUaE4vk/4h3c+t8DzlGEZTrYmVohd4IRMt7sujbvgmI/USOHa3bDpv9Ro1VS
         QJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779800279; x=1780405079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnSIGXr2DYxhyE9HUVE8MOB38M//n4fgb/csbPCCuDQ=;
        b=SrNg5cknYXvVfCTn+12uuTTuNQ8oHLE8fDN1+9NKFXVIfyMaq/ZWItXxLdFXcC+WAI
         N0bzPHs12TblA6mHGVsk2zv5dLzmEqY1NWEebxCD6D94ZxoT7ZSqnb70qUR4u1NtN5or
         QSObUtDrBPtKSZBffNvjb/lLXoAEY6Xx7i01g3OKfFiwscsE0R6A+XchanV2csjoRhPG
         GXz6F0w5q+o6FrWNuvoLyogI6m8nBtgkc5xW4NNj79ga1zrCOQeCH7Ckg/Gjq+xlZNUb
         Jc0jF6A/t66sXly298zs4mLV7oKJ0y9/RSM1nO3akkBHlStgDP/QTgKI8ahBkII2qYfo
         Y8EA==
X-Forwarded-Encrypted: i=1; AFNElJ/Poez6J0VK53MXQ2uvFB8iMM2fy0fkuC9toEFxJkQHZVffCGeF44+d8WVEet83F2IWEMJToUCo4s56@vger.kernel.org
X-Gm-Message-State: AOJu0Ywve4PX5k9IhsBmxxyO/Rc4BgAe8l1zRvsttwYGpJBqSGKUnSIv
	ogungeNjeXEwHBx5qGERMv1fvTOy7ab5TWOkUvJp+V98Zy2yqIOlR57Mo3x63MJ3k5s=
X-Gm-Gg: Acq92OEUQLfq3l2BKmW+X7JgoczOnaVRrpfKKqLTG5HlCCGg0fvx2yS6L9uJVX4K5C5
	4e5CbUHFdW7lfMv3QQo2mqDGI/WBqJKGfaoWaNlZBvzityRLgpGLqoWZtudvY+YX26V3Rac4Uew
	3vZ+OnI67ibxqPhFm7eduvVU7j+5Ea7UiS46vuStZTr6hAWT03WJhwRhxzblT/5htd1tFxMl5Yf
	IRcx2SXB4HIJXdQ2KiW+Vg5g3zNyAusYdTZKlmGEnDpIUyJF5ag8lEm0DD/lneYp155er6j10S5
	G6ZVRDoj0iqaDAxqqVaUpOCozNB3J0Vh5HPrtu3+DORk92j+sfWzwImoWgCln0xhfHVRmeLMR/E
	PgYxxtNYLakAq+jUrRNHsx4OIBzZQ8y3VT8Y3a1RjSH1UFiJh6yA27YAxWDV2H0+J0DwfxMGCdp
	kU0upDwt/MdVtoPrE5ETk+x4LwlvPuDjHfmGjySpz/K1O3l53wmy4azlCC1164+MxhQRj1NXDvm
	vxuUr+Y3qhzwVGNtLmlQr6NpyA=
X-Received: by 2002:a05:622a:5917:b0:516:f4ef:5c1 with SMTP id d75a77b69052e-516f4ef0d14mr115699921cf.38.1779800279005;
        Tue, 26 May 2026 05:57:59 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706a0be01sm20230721cf.7.2026.05.26.05.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 05:57:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wRrM6-0000000DR6z-0LtB;
	Tue, 26 May 2026 09:57:58 -0300
Date: Tue, 26 May 2026 09:57:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: lirongqing <lirongqing@baidu.com>
Cc: Leon Romanovsky <leon@kernel.org>, Yishai Hadas <yishaih@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: Fix boundary check in phys_addr_to_bar() for
 DMABUF export
Message-ID: <20260526125758.GG2487554@ziepe.ca>
References: <20260526124413.2220-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526124413.2220-1-lirongqing@baidu.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21288-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 377E85D5F57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 08:44:13AM -0400, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> In mlx5_ib_mmap_get_pfns(), the physical address range to be mapped via
> DMABUF is defined by both a starting physical address (phys_vec->paddr)
> and a length (phys_vec->len).
> 
> However, phys_addr_to_bar() only validates whether the starting physical
> address 'pa' falls within a PCI BAR's boundaries. It fails to verify
> if the entire requested memory range (pa + len) fits inside that BAR.
> This can potentially lead to out-of-bounds P2PDMA memory mappings if the
> requested range overlaps or exceeds the BAR limit.

No it can't. The mentry never crosses the end of a BAR.

Jason

