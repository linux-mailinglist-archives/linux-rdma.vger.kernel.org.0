Return-Path: <linux-rdma+bounces-21259-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDRxF/bUFGrzQgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21259-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 01:02:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE13F5CF199
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 01:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0322D301ABAE
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 23:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1D12857EA;
	Mon, 25 May 2026 23:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WpsgWDEb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B73D262FC1
	for <linux-rdma@vger.kernel.org>; Mon, 25 May 2026 23:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779750127; cv=none; b=hyHejMtVE2n4vJCjAwQxgxNznlHKrJLq2GSnYnkPbCIiRJxutcBB4U49G/kD/+uw2MEiW0mX9d609k9EMBHbZ+u1rNHoX9IAsn/uQ9bmhYRswMnKpZTu2ENvvH1a0UdvAv6yAsrbHMpi7xWG2WhO5Q9qZLHwTsjQmL7UP6wSmiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779750127; c=relaxed/simple;
	bh=eu7oHNR9mcfU4ioBLEp3xWRPG5uK3jDdylzyfDDX5aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzJsAG2OoTcpvZ64C/gpRDaSbzMlXxxgJiwEBW7udpR3Vb/cChpqWlGuA1xokFiN/VsVFYs4FtGxL04QBm3umot2a39Ko7jAHdb7tl4v982jpaeNaFlXQD+oD9VdcfwWTL8oRjVXp/b+APfJ+ztkHco7kSYvgWIptAe9DKeeKNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WpsgWDEb; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-63270abd14fso3271088137.1
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2026 16:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779750125; x=1780354925; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QHgkHa6ZlvV1jsZqbopBOds1Pj5+WDOoiFTPjaNINSw=;
        b=WpsgWDEbcl/mfC97gfvBOT7Hw6/l9/kWQL/Ma8C0H7ac3HKyq+bIWmkMbAgdSFbtyo
         q23WeK1liMif77t34U/hWxZhXdaYHG2bojD96WSGMEZAIMgpYsxkmyuaFpEKmvgNvEos
         zTRDNUfE1iFQkXwpbAclkptHsrgAahLFdRFxY0PgCeIeDuWKibTWORIIDIQJz56xAZHR
         9EhV7Zwai8voxIq7sgc1wwQJZM8N9nsH6CWeCQd+WPRBcwoWZjMFjznNdEd3jn5JxjLT
         rBSvNgSCvoHLaX3SSP1UD58EME6mgKSrCZai71msRye3T5wjGd7ZMZcbQFt8OPGBK5O+
         3a2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779750125; x=1780354925;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QHgkHa6ZlvV1jsZqbopBOds1Pj5+WDOoiFTPjaNINSw=;
        b=QET2sni2RMh/ebF7RaC3GYXmT2ME+gC2TZUEQFaf/0WJhk7QHHXffQqTVx8AGcLxLr
         dIhtNaAAwRDcbKKG8waqKfmvbxyULiKfy76dPELgxjvmL72Wu5QOsUfZjpx4gXeEWWQm
         +IMVwMrd/BTagLCYVHLZy1OA43aSBXI3uaZkxrzokaOapii/huKwGsGkKR8prx5UW3ew
         H4lUsir2c76dyGH0TKMQCKQN3GCLwFN5+2FRn3af6eVACwuRhkqn2ZH3iDmQ0psQVKFw
         4irVgdsjXIb1Qnv7DMAHM1wKj2MOV2/rkLB5iJ8EKzoSGsXZyalGkxtID0/4HsGWh95k
         2PXA==
X-Forwarded-Encrypted: i=1; AFNElJ94jzu9hrnYMJ+dXd6/hwNud8xb+23xE6WgbeWSvZVP2rf8In1HvSLPtf4wRfQ+5LVeofRiQJ1YA1TV@vger.kernel.org
X-Gm-Message-State: AOJu0YyzRsIRISsWxs+Kezpo8Z9r4BtkRV/6k6e6d0Zz4/EIMdgoprrb
	rIr+mD60qraSqn7SbiYymNc+FLObpC4+HsaD63X8JD4WhPbS5i4JHe/m277sEjpmqjs=
X-Gm-Gg: Acq92OEya7zEF/1MGfBktAmXH7iQe0+yTzihrb36318cdmwH5+sZ6PvasWqqzkeQXPB
	KUvDpOp8ItdeHJ7MO9ls6Ju6v5z9jzed6ti8W0zvP5iM7zlI6IDjY7xoyOzXchZBRQG9IU7JZFm
	nJHfxxi3zK+vNGMJ6Pgz+ZVUsoQ+VLxLCLsZuOAzUMkz2/A44DNk7dTl0C6Y5IJpUFHF7imzerw
	pmZ9ba3xU/kTd8P6+Qyi34Qrn9cYjFWPVVviUALOYrZ7K7jV59n22uhc9pmqGHMqvBTTQszUmJ5
	WXau075ifhe0colNhMKnGwd0seF7C/BRj4HSlWbb7GJgrm1LRlHsNLMiqvn3nOLYmgz8XCoVIVq
	8NCiHgv+CRtllylDX+DOvZdcxYaBVoLNEyjuZJFSE839zpr6qrY79J2TkhMa8fPVeLDg/I9AaqB
	K4sriPIRny0hN4qfKJZ44T1SzAf2zV872noCGJsDMhqTeKGv5m6fxIwgPSUs7RoFNTSdsG1RBRm
	2UF/Q==
X-Received: by 2002:a05:6102:32ca:b0:633:2389:3a84 with SMTP id ada2fe7eead31-67c84613d08mr6201357137.24.1779750116975;
        Mon, 25 May 2026 16:01:56 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dcf4a9sm121808066d6.2.2026.05.25.16.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 16:01:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wReJ1-0000000BVd6-1lfG;
	Mon, 25 May 2026 20:01:55 -0300
Date: Mon, 25 May 2026 20:01:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: Long Li <longli@microsoft.com>, Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH rdma-next v2] RDMA/mana_ib: hardening:
 Clamp adapter capability values from MANA_IB_GET_ADAPTER_CAP
Message-ID: <20260525230155.GB2487554@ziepe.ca>
References: <20260312181642.989735-1-ernis@linux.microsoft.com>
 <20260316194929.GI61385@unreal>
 <SA1PR21MB66832D25A93394735624F454CE40A@SA1PR21MB6683.namprd21.prod.outlook.com>
 <20260317094408.GR61385@unreal>
 <SA1PR21MB66833EBAF447BA0B102862FCCE4DA@SA1PR21MB6683.namprd21.prod.outlook.com>
 <20260410154327.GA2551565@ziepe.ca>
 <LV0PR21MB66700DC2FB827B93ED6A5714CE592@LV0PR21MB6670.namprd21.prod.outlook.com>
 <20260413134602.GL3694781@ziepe.ca>
 <ahSbyYcq0sgfJnmZ@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahSbyYcq0sgfJnmZ@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-21259-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[ziepe.ca];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: AE13F5CF199
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 11:58:17AM -0700, Erni Sri Satya Vennela wrote:
> > “There is no reason they should be signed, you should just fix the
> > type.”
> 
> It is not allowed to change sign in props, so clamping is the best bet.

Why not? Fix the core code, it is just old junk they are signed, they
should't never have been.

Jason

