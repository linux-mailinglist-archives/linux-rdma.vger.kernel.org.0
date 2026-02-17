Return-Path: <linux-rdma+bounces-16978-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAvUNVb4lGktJgIAu9opvQ
	(envelope-from <linux-rdma+bounces-16978-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 00:23:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB8E151DFE
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 00:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60A7F3050196
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B7029D297;
	Tue, 17 Feb 2026 23:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fNiJdoh7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A922C158D
	for <linux-rdma@vger.kernel.org>; Tue, 17 Feb 2026 23:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771370523; cv=none; b=nHr8ZU/0XcLqPmwvSBnOEV6lErn1wHCiL/1PYuYP+sfyVwMncPBUWEkC3hQd7zkb4SzeKzIOYc8+y/uLZOcMAadOfgctaAdyhUYBEsOADxNQZEo5FLfuQWS1sJDFYtqCHo0YAZDzesP2YIzWdjhXh7S4pWPbb4EbQmKE6lCXTrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771370523; c=relaxed/simple;
	bh=OblmYM9WWiisjE/6TqzHdLNs0Y4TXmCYasbXL2cC8D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bl/+lS+By/iEJZU3gCBNI9oo/1MM9yXkVBeExKJi8LJFVMp34+EZKLn5QhmBZRdWcTlrDxF+M+wbp4L6Ls7AppXVWDYmJzHZiCTcvWkOa9R3gwlJKMCOwMgjFmtdV3rpjbFiPriOAohoUzA4pwsWhZBABA5svcgmEdeO1isRYGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fNiJdoh7; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8947ddce09fso46788606d6.3
        for <linux-rdma@vger.kernel.org>; Tue, 17 Feb 2026 15:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1771370521; x=1771975321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N9itz70MBFEuMtUMcJoE97qrZaxRcndtDBe6PsMByMY=;
        b=fNiJdoh7iIJ1Uz+Sw+b1X0DhZFgpiRGSXDVIZ4GwAWpSIqmK0myK5vvVHtGwUtVvO2
         OGf0z/lCJpsJK8cAyuNyYFh+d/dGhwNNQHXfFMAhba7PJOOOUGZ7oCG6MQM7pWyuJHum
         Svvi8EkVTAYGHN8/KPHFRepC31BjsN41j1Bv7A90G10ojuh3uqT1c0Td2I101XXv0hFD
         0ac8sgUEwQkzQndAs8EGgX4ACsGjfw/HTjuOzvOs0RGcEl12Rvdy6cV/64hjHmzGxoMX
         Y6bW8rNTWS1FxxWTTLUsk+Dc1bDXKeYUdDXqHI0NAbmeVjGgFLPmvgIJxkvnqU0WVzzr
         +IUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771370521; x=1771975321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9itz70MBFEuMtUMcJoE97qrZaxRcndtDBe6PsMByMY=;
        b=gncQR6LZum6pFX8qVuEHifIPMpsig7eUERIzMFkePBZm8pAFxOQesHXAflNvkXMBoD
         8bEWutmrG88sjpKJj1G62szjtWePnVptFRVmePKcyO0WFE8AUbCRh+ufUuRmRHCiZHSc
         f3s/CJyJvpqvNvreAMLHGDM0hp4neREnbqwHEVvj1SBTq6JszkcKTk83qbV/RnKw6Zug
         4aBCPKeDkDQOosSzCafdTdtbetW6tPPf4fYBkXiS8vzErdwQJBAYDNhCteCw9d46VMEb
         FkOr4FCGqTkyIQ6kyU+cluyOSy/XeDH5tQHfdi+WeZ6TzHwhzik73+JIFUjXlbr4TS5F
         bIhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZpgTBPPaxutAYYtqdyz2uBTrFMbUIqVinTAiFdoLz1jh/AgQwcSVeykLuUH3n6R4JOYcH6M2406mW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz10meqv1RZfQ4ziwIeQhSMa2Pcepv6jBf1lX9bL7y/Ptx/YrMx
	k/+K1iPOaI0Z4RI9eokDdOfZLPUKNCR4+tB7ma9puXlz7RWKGybbMNNNi/2o0dfs54k=
X-Gm-Gg: AZuq6aJvBwy/507+8/s5CwoxZL0xySe+rtVi/TtpSWf5hBFUuiagY+/LCreUc3mClEv
	LdQlEdp3b3FmP0XpkAou0cahgo3w+NmSdO/WqVbXfTfDelc6ef+H5vy/k1V32oNglNMqiEbZC30
	YlLiaH4ah80vRvoksMP+d25YVnMazoBtyqlbt9XwlswaRi3Sh2cwyAQLu3fprT5QPbKqYU/8Chz
	1WrREiCbcwwQjczPEeNEEp/ZRuVxJX4vdh8JhfE+x10qYgT/4fUYfyy8TTb+9FBOyOvJ/Vw3DSg
	bwNU5qymDTz0H4t+Upzf2iQSrcNNtYMH2AfNbou996CXlhHWtXMFQ7O33ocSKWLsv1+3FRRpY7g
	rHunwI3mRY6GcVuGtcDT7lmsT1gjdG+cheIrxyB8xJpnIqDkDditqhZuUrZYAXZTHUK6Ic9QUnS
	Y7pkUubdCko7vremC7wVJ1YnksczBxmDgjsLC8Bqd8Sj5ckPrYTRSmEXJNnhfhZh7r47adcnYwg
	7L/uAI=
X-Received: by 2002:a05:6214:2128:b0:894:48f9:9de5 with SMTP id 6a1803df08f44-899580f1ac8mr329106d6.51.1771370520820;
        Tue, 17 Feb 2026 15:22:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89949b3d543sm34183106d6.16.2026.02.17.15.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 15:22:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vsUOE-00000006WZZ-3tKY;
	Tue, 17 Feb 2026 19:21:58 -0400
Date: Tue, 17 Feb 2026 19:21:58 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Moroni <jmoroni@google.com>
Cc: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com,
	leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC] RDMA/irdma: Add support for revocable dmabuf import
Message-ID: <20260217232158.GQ750753@ziepe.ca>
References: <20260217182116.1726438-1-jmoroni@google.com>
 <20260217184559.GP750753@ziepe.ca>
 <CAHYDg1QdYZjT81gB6geWKpeRR1TEPKnk9XD1eXcMriVAOHCo4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHYDg1QdYZjT81gB6geWKpeRR1TEPKnk9XD1eXcMriVAOHCo4w@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16978-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EB8E151DFE
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 06:08:54PM -0500, Jacob Moroni wrote:
> Hi,
> 
> Thanks for taking a look.
> 
> > Really need to explain this better, I forget how iwarp works - but you
> > can't release the rkey/stag in a way that something else can get it
> > reallocated.
> 
> I think the HW command names are a little confusing, but for irdma, the key
> allocation is actually handled by the driver. The key can't be reused until
> the region is fully deregistered (which calls irdma_free_stag), so a new
> registration can't grab the same key even if the dmabuf revocation occurs.

Hmm, maybe that is OK then. Please explain it though more clearly like
this paragraph
 
> > Finally, we don't actually support revocable mappings at the core code
> > level. We either have fully pinned or fully movable, so this is not
> > right to just change to ib_umem_dmabuf_get(), that assumes the HW is
> > fault capable.
> 
> Ack. It sounds like what I really want is more like ib_umem_dmabuf_get_pinned
> but with a functional invalidate_mappings method?

Yes, method provided by the driver.

> > Probably what you want to do is add a revoke callback to the pinned
> > importer?
>
> That does seem ideal.

Probably, but  I  mean some argument to the
ib_umem_dmabuf_get_pinned(), not a whole new op for MRs..

> Re-registering it as a 0 length region (will check
> the spec) seems like the easiest way to achieve it. Using a special PD
> for quarantine purposes should also work, but it would add a little more
> state and an object to manage (could we keep it in struct ib_device?).

Yes these are good options, but if they rkey is preserved it is not
strictly necessary to do these things. Pedentically the user should be
able to re-reg that mkey and revive it, but nobody does that and you
don't have to try to implement it.

> Should I create a new kernel device method for this? If so, then I wonder if
> it makes sense to expose it as a generic "invalidate_mr" method and let
> the drivers choose now to actually implement it (many can probably just
> forward the call to their internal rereg_mr logic).

I have on and off thought about doing something like that with rereg
mr as it would be more general, but I think for now just extending the
ib_umem_dmabuf_get_pinned() is reasonable, and avoids the races.

Keep in mind umems are used for more than just MRs, so a global op
gets a bit tricky.

Jason

