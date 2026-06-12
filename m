Return-Path: <linux-rdma+bounces-22178-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZyisGVIDLGpxJgQAu9opvQ
	(envelope-from <linux-rdma+bounces-22178-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 15:02:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF7167998B
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 15:02:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b="Pun1hT/a";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22178-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22178-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 543D730134AE
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBC13D3482;
	Fri, 12 Jun 2026 13:02:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F0F3E3170
	for <linux-rdma@vger.kernel.org>; Fri, 12 Jun 2026 13:02:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781269324; cv=none; b=oWIfcf8s4PwK4f4aQs6r9jelsRnKlDjak/bU3H1RPKnel/T8/wk24Gov/bFtLARuSDv23ubo5cjsBHh58OjwlkCQoeJGR6nig+5zR2q75WOmEW0bqOux6GOy/+dV2+hhNEJNvj6RWRTcXJGDvziyz8vMQmnHGHAq1OHx6vFt60Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781269324; c=relaxed/simple;
	bh=ThH54gMV6tbGr+fgOVeUsCTRqVwecw79Ubd71Y2H1lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnbCK2v/WD4h8XLNcxBV+K/paNv3kB8HhTmssLLlXOAfZdmRjKtvfSITEwiooBtI8fzzo+XQNG/fSyuizjIL1SX57S4vM9rhC6AZ1V1wiln5ZTow9q+9dLbteJ2/sUF35GBseT9QYIqrKRfP6aZ4azodJJo0xGeQyEJqrTDgtNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Pun1hT/a; arc=none smtp.client-ip=209.85.161.44
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-69d7e72b052so592674eaf.2
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jun 2026 06:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781269321; x=1781874121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gd5oYe5vuNIzqkAX3BjHZ/rVlhX+TR/gHR5DuETcImk=;
        b=Pun1hT/alDJ+LBmszRxddaTHrF5s5Rlzy+f2KmDsVJxyJArIPU4ryWxXpT5/FuXwwx
         XPWW+hteteSNn7sBikCadMbSydqg65OSw1OqXCWb/VRRpFSMe2mtAyHOmOiLxWZ9edbh
         baxvHQrpMn8qAXR2bw4Qls8XImT3dTngQH62JrQ6rB5MRa1lbDt833Lb/gcqOAYzDnxC
         gRYhvuogTUll6KNfxf5T7N414HvbLKVhuBwSlTvgn+KTvNgC6GNIwDcm6DiTgoRaj7Xx
         9/H8QDD4Y6gG/CFxyvqNguyeoVsy1p1jHvnYZp31czQM5YKsiBu1N4fw35vsVBm8Kwkx
         k9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781269321; x=1781874121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gd5oYe5vuNIzqkAX3BjHZ/rVlhX+TR/gHR5DuETcImk=;
        b=B3XWP4FCJlfL9MD4/AMKQ7YKwVMPXE4rLDjnRkKsSFE8UIbY+yxmnf4GAMrQ3GbkxS
         fYG2iH6JH+H4X9q8ar96qOpMIm1Omg05PKP7pSiwaDMV1imm16i/sUcUsptxK6wr+7IY
         J2AczXVmwckuUrauWaSaAdv4b3xwa8EZuHn3+YsfGigQPuTCV6La2T7Xa3ZZtqXU+zjg
         ZFjpvImhjUMWbwlBwJqsswy4G7zn+xaow3SsW8+trloYkjLbVyIrg8rQhXptWQ5BETSE
         l44n8Fn7WPS3PBo6CsUpQvMwpOXqhYntJRP0uqNVSMX/wJxnVF0BsuLnF6HecdpbyEzS
         IQTA==
X-Gm-Message-State: AOJu0YynlN2ovc36207kZTQ4DgYd9p1t3N1R9pnsvo+D83C24WY4LwJD
	t2hqs7etwPb+Whubxiqd7D2sAWjcoV+BsHK+OZrPSOsAR9mpgG7qHBbRRznXnusSpw8=
X-Gm-Gg: Acq92OFKPrrVL2JZnbXeJBGHu9ktZfWzsaLrAg5IIbAyVsNTGJqPDb3ZPNwBINcc1Nw
	ddSW/z3hys98EphFdPthrqGEAOh0V3c7fCarpKl9i+wlqm+1qaD0ke3RtscY2Z73FT0AJ/H8tMi
	G9HwpMMFjMWg163rdH2+NmnrFvJqKrYSxfBlTtocadWhn0gpiA4H9NDO0enOAAPoyoDBra9FQcn
	Rps4gpk7PYgfx4J+qtN3sd+1BnPbgnr7ezRUcF574CYLQ2D9N03l40AYkphDJ4lya2VsZVEdk8C
	j8+DSubprkWGVOW/5eczd7v/p0h4KK5isW6D2WibfOyU9/ut+UP659nX/KU2CP5sxsE0r1D8dDH
	9lRZM0nSnTL5fIKaefFQNwxHkAurBdY8HfjpBxqCOFfNkCRb19pF0kY/4gsnPnNg866GCpFhzHL
	tekFJpw7l24f+xqhMfbsymuW7s5K3YXgrWbw8zirooZPjB2RGKJCCUlPOCjw+Lds6onT8e3PgVT
	y2NBCodSPuyH2qL
X-Received: by 2002:a05:6820:189b:b0:69d:a29f:392c with SMTP id 006d021491bc7-69edc7a9d55mr1531259eaf.56.1781269320722;
        Fri, 12 Jun 2026 06:02:00 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a06367dsm200151685a.43.2026.06.12.06.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:02:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wY1WJ-00000007l62-0NYS;
	Fri, 12 Jun 2026 10:01:59 -0300
Date: Fri, 12 Jun 2026 10:01:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com,
	sfual@cse.ust.hk
Subject: Re: [PATCH rdma-next 4/6] RDMA/uverbs: Add ioctl method for CQ resize
Message-ID: <20260612130159.GJ1066031@ziepe.ca>
References: <20260611151229.879514-1-jiri@resnulli.us>
 <20260611151229.879514-5-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611151229.879514-5-jiri@resnulli.us>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22178-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:linux-rdma@vger.kernel.org,m:leon@kernel.org,m:mrgolin@amazon.com,m:sfual@cse.ust.hk,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ziepe.ca:dkim,ziepe.ca:mid,ziepe.ca:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6CF7167998B

On Thu, Jun 11, 2026 at 05:12:27PM +0200, Jiri Pirko wrote:
> +static int UVERBS_HANDLER(UVERBS_METHOD_CQ_RESIZE)(
> +	struct uverbs_attr_bundle *attrs)
> +{
> +	struct ib_cq *cq =
> +		uverbs_attr_get_obj(attrs, UVERBS_ATTR_RESIZE_CQ_HANDLE);
> +	u32 cqe;
> +	int ret;
> +
> +	if (IS_ERR(cq))
> +		return PTR_ERR(cq);

I think this is impossible?

> +DECLARE_UVERBS_NAMED_METHOD(
> +	UVERBS_METHOD_CQ_RESIZE,
> +	UVERBS_ATTR_IDR(UVERBS_ATTR_RESIZE_CQ_HANDLE,
> +			UVERBS_OBJECT_CQ,
> +			UVERBS_ACCESS_READ,
> +			UA_MANDATORY),

Because of UA_MANDATORY?

Jason

