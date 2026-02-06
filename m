Return-Path: <linux-rdma+bounces-16655-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMpsK+cAhml0JAQAu9opvQ
	(envelope-from <linux-rdma+bounces-16655-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 15:55:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5480FFF53B
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 15:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01B6830071ED
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 14:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2831441B34B;
	Fri,  6 Feb 2026 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="X1YTRZSE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6633EDAC5
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770389730; cv=none; b=uyhUAx2KymgwQgJ0nu+DDZttyfBNFZB+VQu2hNVoItUP9Cwyxq7q0FmeRdCehmKAKs2Avq3lUllmTLf46Tn7O8OX6PGvERxNzCRc9sdzQS2VA85S8+yFITg5fns8DOKvSXtFAPnwNJlM7OC2UfaW/u2XhJZW3r0aGEBdwQb0RBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770389730; c=relaxed/simple;
	bh=w4gwfpnCmNDKtFsdpn+Fl24IctApZJ7psH9b64M746U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5vMUmMfCjUcbgt4PTzGt6BIJLeL+1fdpfgqLJTd0c0WQ9cHPHg+pl49u1ybe6yYA1ejRTEhCSkrh8t5rEIWOEHyTaU2yIrpyP8zFEfnn6XSmQm450nifI9v4KJ+AiK2Frmeoo/tgV23zrFo6szGklaSycaoIH/GikgMh/5WI8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=X1YTRZSE; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-505e2e4c35fso21381051cf.3
        for <linux-rdma@vger.kernel.org>; Fri, 06 Feb 2026 06:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770389728; x=1770994528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QEVbG+OGHuK+wSRx1ZB0TTnPh8Fd39eaNNr9LKUs9VM=;
        b=X1YTRZSERGs9Jk5pRRpL+B+nUUChC8tdwROARVRwz4s8vUtaF1Z8LJgkVSjC2UeChQ
         uZTpzQFgIVkmd7fmt9KBs7FxXVvQX0s8RUDncrxaue+BQN9AZYiCW0Zte8xEOlx5DSzK
         Z6g07ZObvV8HWCBtlEjUX5sBPjretd79s9w/ml8/59EUp3G7zdDCdU9fjl/loZRm/Dhw
         S5UT/FRdBC4r6UR0rWvxxiEnpuaaPSAOJNxQNUmhsdS6awhNTZFdV3T0H/o+Rpv+DQL/
         2TVDKSl9yOpB9rRYnwaxs04yI+zBbLVVHSVSFgy87v6CGF+8RF0A5dh62OLG54dzuZE1
         5kFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770389728; x=1770994528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEVbG+OGHuK+wSRx1ZB0TTnPh8Fd39eaNNr9LKUs9VM=;
        b=eZuVZJsB+bLiXZs8yVKIfYMEb+Wq85yQk6zzkpyAVgWmXdBzfDh9IBbtVl8tHYYgc3
         CbPUMNu8ptkiuUWg2w8sCe2GcOXcm+Ba+iVokjLyUW1nx+C5CYjbZBit4csSyEUKm6Y3
         jC2e01dcUICwqGMunjr6nDbui1ODMsGCjGDAF5BLqrO1IK8EdNED1BY71jetMgQjr/0l
         RAXpVkUsb5NV51W7bMTIrWvXd0cPexXBv7woiOvlkaljsqofZJYCZ2vPNbyMyUl5Jhyr
         X6XXkeN/WROoLu0MWNo4dPh7kMqWGGy1B9ZZeRhi0EY6z/hDydRYqCz4/zgJcJouI6it
         yGag==
X-Forwarded-Encrypted: i=1; AJvYcCXbEJa1WzTMuVGM35mdKRHQh9Hbig4OHREulVpdOCdvAIANL0lWFkxUjj2wi+WXly4XBvE/F4EvZ+2K@vger.kernel.org
X-Gm-Message-State: AOJu0YzctElsUjt4Vyq5b4kGX88HDI8ySA+XoL9jgUw0d0euOZ9t4xBN
	Vrxe55aZ7i636x07QXAmRws+M7H6kx33sNY0Te6oTAqzHcbntKfspC9qnD+4hpQqmmc=
X-Gm-Gg: AZuq6aKr8Ijlj96gVdAPj7SCkGQNwTvCr1w9i/XapvYuEFLKaywiYDpCvFpdaGGOqeU
	V+vSl+LAW5xFPgzhWfFoQFFDINxlwqqvHgqUzdYg06su0iQZNn3I704pELW4o870Ugdoj170LHn
	leXGwczPs5wOgZ5pAnDm4nCJH8d50CzOZx6uswg9Aeo94ta7saUM9mHOWP7RQ2M4sH6nluSFp66
	oHdfAEjsI5Vvn7ck+0gRDv1WInh/DV02OHTH8iyHkVIm1J+yLyyrfberTsMw3z2AK6Gw7j6glJu
	x8wHfuv6YC2P7a1XjwetidVVQTpYg5nWbUDK6D/y3L7DjI1x1ad68qVSHMKANp45l5pw+8qKOxq
	VQY2Y3GS4yLBC/4CE/y7xv3BJdmBnj+ysUvQ2lyip4Q4RBwy3b6xyfBZ9dTO3yKvaMo8w3rLNeS
	Z17+wVftcDwTe7bf5z4RF2tycS1K+x3eWBBJ9//zH0Utte+f3CSMd7pSmRlH3BEFdoi9c=
X-Received: by 2002:a05:622a:514:b0:505:e448:1b10 with SMTP id d75a77b69052e-506399bb207mr36141991cf.41.1770389728337;
        Fri, 06 Feb 2026 06:55:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953bf59596sm18799476d6.22.2026.02.06.06.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 06:55:27 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1voNF1-00000008VuF-0RYM;
	Fri, 06 Feb 2026 10:55:27 -0400
Date: Fri, 6 Feb 2026 10:55:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Long Li <longli@microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: return PD number to the user
Message-ID: <20260206145527.GL943673@ziepe.ca>
References: <20260204135813.870538-1-kotaranov@linux.microsoft.com>
 <20260204142827.GF2328995@ziepe.ca>
 <20260204174643.GA12824@unreal>
 <DU8PR83MB0975E65E87B49534950E9447B499A@DU8PR83MB0975.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU8PR83MB0975E65E87B49534950E9447B499A@DU8PR83MB0975.EURPRD83.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-16655-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 5480FFF53B
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 12:03:18PM +0000, Konstantin Taranov wrote:
> > 
> > On Wed, Feb 04, 2026 at 10:28:27AM -0400, Jason Gunthorpe wrote:
> > > On Wed, Feb 04, 2026 at 05:58:13AM -0800, Konstantin Taranov wrote:
> > > > From: Konstantin Taranov <kotaranov@microsoft.com>
> > > >
> > > > Implement returning to userspace applications PDNs of created PDs.
> > > > Allow users to request short PDNs which are 16 bits.
> > >
> > > Why does userspace ever need to see a PDN? Please justify that in the
> > > commit message
> > 
> > Probably for the debug and we have restrack for it.
> > 
> 
> Sure, I will add the explanation in v2. Overall, it is for
> applications working on top of the rdma-core (e.g., mana DPDK).  The
> use-case is similar to what mlx4 and mthca have for address vectors
> in rdma-core for isolation.  As the whole process of working with
> WQs and CQs is implemented in that applications (e.g., mana DPDK),
> they need to know PDN to build a correct request. What is more, the
> HW folks put a limit of 16 bits to the PDN field, requiring a flag
> to ensure that we get a PDN that fits into the field.
> 
> I hope that it justifies the change as most ib providers have pdn in
> the user-space.

But they don't put it in a WQE and don't check in HW it is exactly the same as
the PDN the WQ already has.

You have PDs in AHs and other related objects which make sense, but a
WQ only has one PD, it is illogical to pass in a PDN in a WQE, because
it can never take on a different value.

If it can take on a different value then your HW's security model is
broken.

Jason

