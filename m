Return-Path: <linux-rdma+bounces-21654-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VKpWJfhRH2oTkQAAu9opvQ
	(envelope-from <linux-rdma+bounces-21654-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 23:58:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 315636323F6
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 23:58:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=q5Caw3+b;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21654-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21654-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30269303AC08
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 21:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFDB3AB47C;
	Tue,  2 Jun 2026 21:57:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E8E370D7C
	for <linux-rdma@vger.kernel.org>; Tue,  2 Jun 2026 21:57:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780437451; cv=none; b=VwjqD3XjnPvKTZx2sjFqVdalUZFHRNDcN50trM+Z1neVaBdGbWR3QCzUTHlJuS1Rp0oJNNOGUOsggLZDNjBcFHQQPs2i82F/ZipCbzOEEoWBBx8NlJoPIlkbUWcknErspYKkbFHoG5iFHpkuVF/z1GEPsWLY1mKd+87R+0/sQ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780437451; c=relaxed/simple;
	bh=/uKj18xsSwzfXBhULeyb27nBNuJXAfpu5PbOw7oSUbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnNRth3bkOPnUAkjuoPGrk+0b2iwCN1oGBJfdqqY2PY1Dfd0Q3cT0Omcu6/1GeXA+xrjm6lhMg9/i4geERpYE97oUNWQp21m2K5XoyEU6uUeIQUGe76U5/GiGZo55KLwugrCpXRco8qrCBLKLtQVnhQCEPKq+UJwU3FJkhdt6fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q5Caw3+b; arc=none smtp.client-ip=209.85.208.182
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-396aacc5bcfso5807001fa.3
        for <linux-rdma@vger.kernel.org>; Tue, 02 Jun 2026 14:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780437448; x=1781042248; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGjehcWp7844vjC/IZzW2WAoswJMDMGA6SPubuDrvD0=;
        b=q5Caw3+bqrQoiwiV3lESOlXfcgveGnsXhkBCjL/qGltLmKDl+MBIc0lSg30JxfHb8d
         UPqtphQrAfmj5MFxHLvG0ZcS7DECOPuoFosnkcxQt+CTZwvplueJFyB0dJb9B5rcwfx3
         SgCkyXqJLOr3rVSOGKmuScxsHhSy6ZxUlNnSUyDxgnAW2k+4ji3uOixSz/fkvBeHbfAl
         BVkPr5Vxv8aFJC4Dy72S19RZ5/UcHf1vzZq8TUAb4wxurmQgLINMoO/rWjueyj/9+Q9r
         K8jGWWs0rk2kVyB3lMwmzh5PTRsenygVmxobXONU70YROkU2XhHU+sigk5V6Nj6p/ddA
         ulnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780437448; x=1781042248;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bGjehcWp7844vjC/IZzW2WAoswJMDMGA6SPubuDrvD0=;
        b=k3/t99los3TqZhIQuhTJP1M4yuxx6bNyCyf4aDGqubVV2Qo8qmLbQHXL+gkpu1NWza
         HfMbkz/I1XSfLiF+1ueR2nfN8PCzqScQAxOPlziBtVZj1xpYNmHoPvBEumSY+VtLLqT5
         sKcCeN7W07VA//cF28mBvgZIX3ZLmMBIFzJX2Iv0Uj9hqqXeSH9Ttis7lkjIQ9DK+KVQ
         4PbItUl6CaSTGG/YCbsFie0P+uY3f1GvtAeRf6UhY8LuGE5JLIj8lCUkg9Te0XamXwM2
         S+BLtKzUeHFcvZfYqPPeKvn0YrPzjN626FnaqnGV3yofffc/KcXPP068NsQ5vsC2t+Bv
         kF1g==
X-Gm-Message-State: AOJu0YyOeXWILl9jU8N4PkrMg0k9z7ilFx9BbTIeHl9dbABv/zsyP2v5
	hmikcvuwVY3qaIdXwy3Yz03WHz/v1uwYNwmqrG7Aj3lTa25vXRdCIcQm
X-Gm-Gg: Acq92OH7nC+E6xQZT/u4ruA+TuYvbSS32NkoNpEHs869S0DgSh8Vk+sMg8cHRyOVdI2
	6rN0tERWPSFCHBlZxJ/jtp/NvQ3ex78Gmj6p50cJgmCcYvM62IOVCUpXcEqeurzUOdl0tqZpLn7
	ppKmaYzYjmNLesYNrz2+nWe+jXZTwWmGf6/S7m+gb17GjGLVcec4s7xC3HesA3mihWni8x8lxUf
	jBGzErg8RR8TgTaO8m1XsJA6xxCIfPOF1NOpssJasnjEo6CkmpNyG4FnWJBVlymwqfIe7YOUw95
	wAjStdkAcKWDU5WHoH5CUA+SOxBsXBhCHDNxv2IGyCPijabGiYlN7F7Kel70G+BVWOqK+YCtx9g
	Fqoh0QviT+T4rLQUHehWnhRAVnKSzpQ/J/LrANRK/bng1Xid7WHj/SalOpfB7AHGROMlXYCGhB+
	FJ+/V6qFsr+ioigOjZuZ0FYs6UNhvw7067Kr0=
X-Received: by 2002:a05:6512:1513:20b0:5a8:5ca8:7f72 with SMTP id 2adb3069b0e04-5aa7c063ba8mr177399e87.4.1780437448240;
        Tue, 02 Jun 2026 14:57:28 -0700 (PDT)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b97b042sm203357e87.47.2026.06.02.14.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 14:57:27 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 5A2ED5A0061; Wed, 03 Jun 2026 00:57:27 +0300 (MSK)
Date: Wed, 3 Jun 2026 00:57:27 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Jacob Moroni <jmoroni@google.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] RDMA/irdma: Fix typo in SQ completions generation
Message-ID: <ah9Rx25KxG38I-Tg@grain>
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
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gorcunov@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jmoroni@google.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,m:leon@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21654-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gorcunov@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 315636323F6

On Tue, Jun 02, 2026 at 10:11:46AM -0400, Jacob Moroni wrote:
> BTW, your fix matches the OOT driver code:
> https://github.com/intel/ethernet-linux-irdma-and-idpf/blob/main/rdma-driver/src/irdma/utils.c#L3561
> 

Wow, didn't know about OOT driver :-) Thanks for pointing!

> Regarding the "unrelated issue" - is it an irdma issue? Anything we
> can help with?

Well, the issue I'm dealing with is messy yet (i mean i'm not sure if it
is irdma issue or not -- i'm loosing completions on posted operations when
hardware in reset mode and same time the card is physically removed). Look,
once I manage to collect all pieces of a problem I'll back with report ) At
moment I suspect that we need to *flush* queue here instead of cancelling it

---
static int irdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
{
	struct irdma_qp *iwqp = to_iwqp(ibqp);
	struct irdma_device *iwdev = iwqp->iwdev;

	iwqp->sc_qp.qp_uk.destroy_pending = true;

	if (iwqp->iwarp_state == IRDMA_QP_STATE_RTS)
		irdma_modify_qp_to_err(&iwqp->sc_qp);

	if (!iwqp->user_mode)
-->		cancel_delayed_work_sync(&iwqp->dwork_flush);


