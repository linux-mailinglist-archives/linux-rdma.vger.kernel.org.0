Return-Path: <linux-rdma+bounces-21057-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKi2MPnUDWrW3wUAu9opvQ
	(envelope-from <linux-rdma+bounces-21057-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 17:36:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D223591037
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 17:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAD623035F02
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 15:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3933F1AA5;
	Wed, 20 May 2026 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="P8HS2sTN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9025C3EF648
	for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289144; cv=none; b=f3kOnPjRd3hDSeOZD9ehKDYnUw+s2u9ffvpObm6+1F5Kf67zu0baZlBtuidM5m3kbYBn4mwCtOX7vTRqNi9DsVYYiMn0D7j4cqsD3U1R3xn2oI+evNUP15R+rrGSbfw8XzrJ6h1u/GOs9O22dyhGwfJDcQUX/pPGCvCkncauwl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289144; c=relaxed/simple;
	bh=Rxk+buGIGsQmzg//hxJcGCtRrQLOwCkE7hFd49hGnv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSwsh9KSzQsesb0KsZ9OglJ1f9ZHEvygitq70i9IFLpHawKKK3KI4uFA3/tN4nf/N3O3xVxizDwzXMxC1LO1fJG7e6180gNPaXioP+eQkVjRfxz/WoA5TuRo1/KY1RtV12Ea2FWnRiqsikVkBxkVpcteIHW9TSennBEFnI7el8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=P8HS2sTN; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8b7105dfb35so63755326d6.3
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 07:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779289141; x=1779893941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rxk+buGIGsQmzg//hxJcGCtRrQLOwCkE7hFd49hGnv4=;
        b=P8HS2sTNv/+D9N/jUzxtxoCMDaLeW9gK5L0+h9hgq/30NJcyEotNTMhC54Mosmpq0q
         kzdKSX6yiR0JsCrzJW5q8yUhh09yb4nM9bSiykdOOIF8oBWl3PjRC7UnPnCjVTaeBt24
         0eLMpoWEy1TkD3IlnS+iTtMuH8F/Zr5KCl59GbAvwdmdsIHvwP8VCz4ZwEcB1rQjn8Ko
         wptdO+JceT0L5bN9KrLWQQfeXg502iE3jtpDbofSTLLVat4Ts86TIvlrw0Sf6erPZdT6
         zKR8IqRmtx10UOpN1CPnnbxKstu4nHEwfC1HeTEsOhE+3Xu6bBeicEB5db4LfqEcGmb+
         obDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779289141; x=1779893941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rxk+buGIGsQmzg//hxJcGCtRrQLOwCkE7hFd49hGnv4=;
        b=cbw2RemQBY+eKiyKM/QDbJRtM9iAe9Afq+z5gRkNksloYf7CqDirBS417HfPKPsj35
         nXQy9lQ+aQJlitIRD9Jqd7gfNb1+5RcD+5RNPDnReCBW8iRaJp/GAUhw4IAhcduJHv+8
         1J59xLIuIiK6JpDROv4mDk7eZzJ4QL6D1gbdw0C0Iu44B1CAj4wzXlFjUeDCVi3Kj4ay
         tHSiIv9Rhr3NdqHumOoSasWnSWLJa128/FO2Juvgg+v5gQNTXthMaBgOu2Uf0kHu8p6S
         O00lCD3DkRPNKIH2Mm64ZWDhRgev+ygy0ViyoRNHysiqkF3huqCLYf4QXy4rSNsyv7C1
         cceg==
X-Forwarded-Encrypted: i=1; AFNElJ/J+qKJN/SrlAQv92WDiBtd+XceE0GL2WdFCkQIqj+wFh9O9LFLliA763XZPfcSJD74RQgjeNqca9wv@vger.kernel.org
X-Gm-Message-State: AOJu0YzagDh3ZHTtIJ+Xaem72RoVK4q/yS1yqjxSKuyV4K7+scNBEmWZ
	mSXu0jmjzvFDwhgWjeDAuRb/qDdnK+yWgQGWanqGtHOhcnsNv18I3ahOxCGND+4xarQs6GA/bv9
	yP2rx
X-Gm-Gg: Acq92OH3rC0Nd7nxfa+KUJ+2O2K1Qxic7XvMd672xrMlD0cez7re4lK8U5Fd39xy+1y
	B/Zs45+wajO/KB4BgM29jS06xpe7aA82UC9Fxqwfqn6odAiuKYFjW5B+QXkmD7fcaFhqUZUMGjM
	JTO2BZJ2ZVfaPa+Ttd1s7P3queUTOyHezXzwo5hFqYqYDmknbW2gNNL9OWq5RQLYIaYfUwIck/b
	l0Azt/YvsQbKB/ji07Pi/3KP5oV79N6heXQe429dxt9r9dnmIQ7Xuao3k3uoll6DzObMXRD3Mvu
	YuOlyv6AZ2MxIchK4/qswpdS/0ABNiAPQm6Ov2BirQIgqMKF9K+iHGEMDb/K24tUOHONNxHMWgu
	yDfftIgyNyuDyryHKn9s8JF+lNIUnJkGwWr7u54q/9HXRaz3gamBE3UO/m4brZpQlePg7jJqtce
	JagIwonYPfRlGQPd6j1/SgLH1xfEJK7o87QcYy4JNZGo7lKMj8R5Uu91YI7vWeE0zYV0bOEZ/H+
	AP24FPa/LwjgMPG
X-Received: by 2002:a05:6214:5a0b:b0:8ad:87a2:3c1a with SMTP id 6a1803df08f44-8ca0f8fe21dmr420796326d6.46.1779289141302;
        Wed, 20 May 2026 07:59:01 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca3618fdd7sm124440226d6.27.2026.05.20.07.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:59:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPiNw-0000000HIzZ-13Em;
	Wed, 20 May 2026 11:59:00 -0300
Date: Wed, 20 May 2026 11:59:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v7 0/9] RDMA/bnxt_re: Support QP uapi extensions
Message-ID: <20260520145900.GV7702@ziepe.ca>
References: <20260519150041.7251-1-sriharsha.basavapatna@broadcom.com>
 <CAHHeUGW4q6bVxHqk+YcTfLc7AEw1k4=m99m-7F1adMoeqgW7sQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHHeUGW4q6bVxHqk+YcTfLc7AEw1k4=m99m-7F1adMoeqgW7sQ@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21057-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4D223591037
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 10:24:36PM +0530, Sriharsha Basavapatna wrote:

> Sashiko is reporting 'Failed', I'm not sure why.
> https://sashiko.dev/#/patchset/20260519150041.7251-1-sriharsha.basavapatna%40broadcom.com

I assume the backend service glitched for a while. Outages seem to be
common in the AI services space

Jason

