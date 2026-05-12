Return-Path: <linux-rdma+bounces-20497-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JJiN6M7A2oq2AEAu9opvQ
	(envelope-from <linux-rdma+bounces-20497-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 16:39:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E50522BB5
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 16:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91F4530B1E50
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 14:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0CA3B5E08;
	Tue, 12 May 2026 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KhLOlev2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2DE3B5DFB
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596446; cv=none; b=ISVQWZT6DrfaWxPY9FFeAuRybqCG83VWvm0hd8aA1zafe0GfBxC+YM1uG7ag88JmaApeZridC1jNe5LDWR+Y+rbM5Psx+7urEPP8Qv442AL5b5OPh9ONADSFVAv3oLxy1gYNAcgcMKOpE9Kl8KW07uMCeAoBqy96guMAqgXnEzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596446; c=relaxed/simple;
	bh=lguXdpmenBKNjKb3kMukWh098QKOWYF7xQRPV8EmRAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djFK6IQycpNa5AQuSt3PZ6kBuAGg9K4EpdJAD/bCedXKnLtyC2PgtzLgr/VkzEwJBsucUadHKTlOEAwptSY5qDc5igLMjq1Dn/lNF38/ttoDX+Iqd0SoyQsMTXPWJUgQV4cPusRmKULkmr2QyklGG2lg/BDueki+vXmxDdt4u10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KhLOlev2; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-90caad2e944so123688085a.2
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 07:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778596443; x=1779201243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rBAsTJEZ2P7qfR67PDMNrE+EVjqd0CUpXcRsRMYcCxU=;
        b=KhLOlev2SPOOg+siphPgU7OCtpeJMaCubJuWV5DusBobhjOeaZFR4MJ1MZhQogdLbC
         4LQNHqB1nZy4t81sadUhEgCCdNnRxjzi0ZeEPmwDN7ytyh3KRk4Q1ZBsGCGwpCWP/cgF
         Sn5OXrYb5uynuTXPabIcYZehXZvdP6hREQHJuYfanSSIXBaORe6GfC0TP1CjD773/VOA
         lSjg60rlrNIuODDNF91aRUG4VQgNcgJrg/nqWviqawNQl1JvDNsqdHZA9HXqiWWwBLeq
         gIGCwIJ2APS6hn1SRSvXlBKPB/uXLrVnUZ/BI6lak5Lmmv160ujHEvdTcZwa5sZSwbF6
         mRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778596443; x=1779201243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBAsTJEZ2P7qfR67PDMNrE+EVjqd0CUpXcRsRMYcCxU=;
        b=jrh7qopk1tA8Lcn/KX8BuxRFWZiMJNLoQPmkqqOqKbu89saLm4RwvKBTc4JsBUdsPP
         H/XNpqfiJt8qCLhYbRGODz7E9GJA6pJ+QqVD23nnF0y/KM/InCL+TOheuG2tV/IiQz0r
         NefvbTGdjq/sDlXzJxijZL6D9Og7VAZWXxNNdsy0p5Z5YqT3duU2YszVxo+iVvvn6U11
         8/iCBiWu6yJxOIxchu4N93MwxfOC7AsCNxUtTVXradieDQq+ydJGSSKLeJW6j7DkJI6P
         /y13Ozm5IqdccWrz1S9Zo9Er2rdRkWsz6lMsQjAmVPS8hcEAc3CkuiITBhnFWSW0ib1I
         vMsg==
X-Forwarded-Encrypted: i=1; AFNElJ8MIrstjAd2B7fKEw1n0e41ObCq/UTwUeDTjMkRG0/xRoXZs279kz3osdglJ3UxoBgbzm670WTmK0T/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3UDsChkePam4UUx/v134QpdTZ38+6G77FxPofORSMHUrVBdCu
	oIQWtIU2Mc0oZh661aenGYRnMV7Jpi38cGcmAOxkl4kKFDCQ9tF2mNjLXqud0qB851Q=
X-Gm-Gg: Acq92OFmcocEAaWmGpPpuxJ9V/oDP/cWLWT6yb0JPVgn+vkVtXOdgeHNs/O/Lw+3q4B
	Ur8n8AmZg5qMZg0PpnQphvdmGU6TZZtdy8+ZpF8DRycrniFv7AABCMffplVT2lGf8k/37Me1lr9
	o4cqDa7XywcLJiXIRlp/kJ0lmGkQ/3aWDmLo/8XHjp0Jct74VRZAE8l2Svljk0dW9UYQzrDEZ7y
	TlkzFgYgU5O3M4JfwpyFawXBlTFlJcOPc2483Vme1a01aRMX/BGKXYJ2X2M33pJISmzfQiZBaMl
	he0bH8Zs+C0/9qwgE+0oKR4nP0OXnSP5z+2w8qn+pCnSQO6ge0NWo8VnOXgpCVQAQGpX5NdpLga
	TwLijsGRKOr08LouvXwlLSexBO2epCn+gVj3bVHYv3VodWVYo3Z7uoY65jGox3l930EX6oAG0Io
	GCWQvwOKGt6asMWH7xRja29RmUqCntIeWdzxrwqhRF6X60ZhZQUAuzVXU/zCWKYb7H79Nnv2+1w
	1yRzw==
X-Received: by 2002:ae9:f20f:0:b0:90e:f911:28ce with SMTP id af79cd13be357-90ef9112afbmr85923685a.53.1778596443257;
        Tue, 12 May 2026 07:34:03 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91b976sm3486921385a.39.2026.05.12.07.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 07:34:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wMoBO-000000007Dk-18dE;
	Tue, 12 May 2026 11:34:02 -0300
Date: Tue, 12 May 2026 11:34:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	edwards@nvidia.com, kees@kernel.org, parav@nvidia.com,
	mbloch@nvidia.com, yishaih@nvidia.com, lirongqing@baidu.com,
	huangjunxian6@hisilicon.com, liuy22@mails.tsinghua.edu.cn,
	jmoroni@google.com
Subject: Re: [PATCH rdma-next v2 1/2] RDMA/uverbs: expose CoCo DMA bounce
 requirement to userspace
Message-ID: <20260512143402.GB7702@ziepe.ca>
References: <20260506111447.2697789-1-jiri@resnulli.us>
 <20260506111447.2697789-2-jiri@resnulli.us>
 <20260512130329.GU15586@unreal>
 <agMzG-ZX6TRoikrI@FV6GYCPJ69>
 <20260512140510.GA7702@ziepe.ca>
 <agM0bHFFDnSBL8RK@FV6GYCPJ69>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agM0bHFFDnSBL8RK@FV6GYCPJ69>
X-Rspamd-Queue-Id: 99E50522BB5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20497-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:email,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 04:08:44PM +0200, Jiri Pirko wrote:
> Tue, May 12, 2026 at 04:05:10PM CEST, jgg@ziepe.ca wrote:
> >On Tue, May 12, 2026 at 04:03:07PM +0200, Jiri Pirko wrote:
> >> >> @@ -1419,6 +1421,10 @@ int ib_register_device(struct ib_device *device, const char *name,
> >> >>  	 */
> >> >>  	WARN_ON(dma_device && !dma_device->dma_parms);
> >> >>  	device->dma_device = dma_device;
> >> >> +	if (dma_device &&
> >> >> +	    cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> >> >> +	    is_swiotlb_force_bounce(dma_device))
> >> >
> >> >It is the wrong place. When I worked on my DMA series, I tried something
> >> >similar (a call into SWIOTLB) to notify users that RDMA would not work.
> >> >
> >> >The general feedback was that this is a layering violation, and that any
> >> >knowledge of SWIOTLB (and its API) should not leak out of the DMA API.
> >> >
> >> >You shouldn't call to is_swiotlb_force_bounce() here.
> >> 
> >> What do you suggest as alternative? We need to somehow tell the user
> >> what is the situation.
> >
> >For now CC_ATTR_GUEST_MEM_ENCRYPT is likely sufficient.
> >
> >Later we should be able to detect if the device is in T=1 mode
> >directly.
> 
> Okay, so we assume for now that every device is T=0 (which I believe is
> the reality). Once T=1 device appears, it changes this "if statement".
> Do I understand that correctly?

Yes, that is what I was thinking

Jason

