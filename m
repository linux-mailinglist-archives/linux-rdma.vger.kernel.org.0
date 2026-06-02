Return-Path: <linux-rdma+bounces-21632-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mMI8OgggH2rZhAAAu9opvQ
	(envelope-from <linux-rdma+bounces-21632-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 20:25:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B3C6310CF
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 20:25:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=he5TYGh1;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21632-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21632-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B33230034BF
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 18:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8079391831;
	Tue,  2 Jun 2026 18:25:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A75E37DAA9
	for <linux-rdma@vger.kernel.org>; Tue,  2 Jun 2026 18:25:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424706; cv=none; b=VEI40rsf13eSLqYC0KO1FQwn5HlEEyWVBbbo/JUOcxjNyMdLkBiYYTfNcd9BUCKjTUqJWLfaijWqyzbPWXuufdF9Kgk8zy0XAiimxMajnlRt8AzCMSn91m4ukz0kzbXHyVBlWlPg07JY0Kj8zgkYm/wxC91FlsnkU/vKUcHlt+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424706; c=relaxed/simple;
	bh=yUSRoC/yVRThnKZnAysF12Qyel0GNxCsm+wCLUCOOAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nmwv7MV8qTqVQbj2kbBwAfzbe8GvRUyVZ/TwjNjFZF5l7Fs6zdx1JToqHJp/CaaNY44kz89laguz4SiSpsc5TiQS7029EN2wzJsQWmo5wMjQXc50NRV4ez+DXFQyMV46zBpmh5+BQmvigSNmD7NQC92SIe4Dyuuqfa7y25kB5uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=he5TYGh1; arc=none smtp.client-ip=209.85.219.53
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8cce22e029cso62099976d6.0
        for <linux-rdma@vger.kernel.org>; Tue, 02 Jun 2026 11:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780424705; x=1781029505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yUSRoC/yVRThnKZnAysF12Qyel0GNxCsm+wCLUCOOAc=;
        b=he5TYGh1zuEs+Gj/t1DCvLcVuP1HF8qSHpE40BZsjS4BR5LXQCkbNjzr67Cjttc7ED
         z5BTeBy5xWbub8lf6yb1B4lfE6vSvda9xGf4ZyYk++XDXkrGw67JReLhSwBf7cilfJsr
         BPr+pMgvn7d29dGaYCxCQ1ksAcuvkV98bYHCSToEWA/HMm1X8uUX5EiNZCvusW5cmqlI
         8FztBsFAlTDtq8n8JDkIubKNbBzMnsmLujdqy4yeDYUsBwyLfmWDxGZGwqMwz0SrZj9Y
         LXqK9bbkYVX5JTwbi6dV7fX2tGiCj/lzXswpsa9oP5vIchb85NMVhdA4eLQ9BIsEmh88
         xoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780424705; x=1781029505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUSRoC/yVRThnKZnAysF12Qyel0GNxCsm+wCLUCOOAc=;
        b=nWB3Kj836F4Keh7pzB3PLgZG4/HDuAUOT23fJ/4KlayDV/5TuIfYMDH2bwGJugn1Cf
         uHq6D7ZUgMvJMUMAt5Nf0A5W42vTfOQKaiVvwusY4OzID7M8m7h7wDnpIWghSvz6t4vw
         tyvo9oSUUqnhRf0Y0mrt7x/RpRFsiGxN+jYeAox1AFVqlNc0H9gdvtMFIX5bRZGuZ8Cy
         oVI1dXs+3mdfHM70hzgRR1yLBeSf0UPQG9cFQ+iLIBz9lbCL4wp7ji7UDIWYgYa6vk4n
         m6Fb79K7ea1WS/EIMNRX3GZevCH/qAlIVXj/bybLjcWs2dtQP4BEMy6eRWJsfdCQW/4Q
         C9gA==
X-Forwarded-Encrypted: i=1; AFNElJ8h/z3B3y8M0NXFVczAu6u6JuLQwWs/51d3gopRc+xG9j3BAYNUa/YutJTI+EwgwzSH4y14wyXhJ219@vger.kernel.org
X-Gm-Message-State: AOJu0YyDhjQQuCcU1I4+GbvElEMbNdBepqeH+hYKn+J1XF7mNmo2P/YA
	RV7qVWYTbaq2n502Czhc03nI9vgO038BtjqPEgD4ohMQEo9ZD1HhUTfcB4dd4rdfBf8=
X-Gm-Gg: Acq92OGWyeaBVETaPEJb3N5r3LtESw2B8st85/hOiZF0cJYZ9oixnApAT/0mlI6dsGE
	LUuvscEfut1FP/A1bI7JOcse1M0leHfCOtqAgI7O7wo3XQLYtKkk2+TxlF0d5KKthY8a99PD2k8
	jGBbKVqw3wp6l5n+RAO7+eIrEQpytJUg+ppSVw+u+p3y6QWUIiHo/jeEB3aLiHjsXTXCu36bgWm
	if/VfEh/bmAVJuQx5LNdYKx3e2052hH2+Tc40q1D6IqnD9N4pxa1ze18TKNsxAfCeOw3alXusKJ
	hGwkWXTquDVUgK1D4LwnzV3+5ZGY/cTMwjIgN27j+c4MLY52so2lA1RmzFwfycrqQ3wIi3IWnUK
	qzsZsgtPzffh0Dis9izR32Qllnzi30IAzyGmM5mEZDo89kP5NJVOKlTeBiirQkRTs4cNSXjZSU4
	6H2R8sY/c37lopizn5+ayAwo28FBH/8YpDPiciLliAQuBtbyI5G0mhYJ8u6G13DEsJ9ruZac+B9
	7rqO0QgDbCkVTgh
X-Received: by 2002:a05:6214:5f10:b0:8bd:3440:c024 with SMTP id 6a1803df08f44-8cebf46a7c3mr62644806d6.15.1780424704475;
        Tue, 02 Jun 2026 11:25:04 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea2164cfsm125467116d6.37.2026.06.02.11.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 11:25:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wUTnT-00000004NB4-10oP;
	Tue, 02 Jun 2026 15:25:03 -0300
Date: Tue, 2 Jun 2026 15:25:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Moroni <jmoroni@google.com>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] RDMA/irdma: Fix typo in SQ completions generation
Message-ID: <20260602182503.GI2487554@ziepe.ca>
References: <ahjB87k54bYdFbft@grain>
 <CAHYDg1T3m=mn17zLRZp3+zcJq+GeDGcOU_99ZZmWxYasEDKN=g@mail.gmail.com>
 <CAM5jBj4LPZxejjq2VFJZiwPWkZf3_rNxBRcT-8yrnfDXFSot-A@mail.gmail.com>
 <CAHYDg1QH=tMy8xbYn4D-L9iyp9iCVCEU190H9_gFLTWMABqhpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHYDg1QH=tMy8xbYn4D-L9iyp9iCVCEU190H9_gFLTWMABqhpw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21632-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jmoroni@google.com,m:gorcunov@gmail.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tatyana.e.nikolova@intel.com,m:leon@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,intel.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5B3C6310CF

On Tue, Jun 02, 2026 at 10:11:46AM -0400, Jacob Moroni wrote:
> BTW, your fix matches the OOT driver code:
> https://github.com/intel/ethernet-linux-irdma-and-idpf/blob/main/rdma-driver/src/irdma/utils.c#L3561

Oh lovely.

Can I delete irdma then if Intel would prefer to keep functional bug
fixes out of tree? Hmm?

Jason

