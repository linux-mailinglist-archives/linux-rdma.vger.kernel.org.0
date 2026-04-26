Return-Path: <linux-rdma+bounces-19570-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fIcNLciW7mnbvgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19570-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 00:50:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D5046B629
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 00:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC45D3001A4D
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 22:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899D71BD9C9;
	Sun, 26 Apr 2026 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="J/brFA1+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FE22AD37
	for <linux-rdma@vger.kernel.org>; Sun, 26 Apr 2026 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777243839; cv=none; b=gRFh6CCyc69Sw6WDrZboT/52Il7y1+Eyg1Uqdd1RgngZlRkm6SbhHrtdAlz4YFhmgwrMxJjiqKrnVnnDO5wnbgvo9CqFw0PweB0iiAkK+PvHKF5eAtYWVN/GmOseIWbJe+QV3P9T+eCshhqsvgfO+YTWDxEgWxJ5ZE2muJOtqqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777243839; c=relaxed/simple;
	bh=QrKz2jfHl34IRS7z3hsatQCci5gTQ4mRZ/PJSwBMc8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWY6TxIoSCfyOXFknfiq4DxJH8ZrB2uOyD4GWp9DAJibu7Vt1x1urHOWlYuMjL0C+TNbW6mn3m7G7QyQpWfcLo217bouBcgW+bEOagQcIHU5CojiMfM5qqi+crcvmGO55DbjRwepmgU2fTznRAiv+MfwfGUntmIZ3pJDZV6mARQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=J/brFA1+; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8acae26e564so115966216d6.2
        for <linux-rdma@vger.kernel.org>; Sun, 26 Apr 2026 15:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777243836; x=1777848636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tNJST0MnlAqczS/H5JIwYkKmkjJSbsGqSKXE5vOhVdg=;
        b=J/brFA1+l5TbCYweUnmhwDVfDNxy7h/e03DtjWRoOC2UJ7JreomYbPLu+7t4ob4jzx
         bNaRF9r6Mch0M297zhYTOfoxORqpqRvjyq2wcuaTNh7wAlsbGpEo+dHO3WCmbSbv38DN
         Hj6iXufD6mSZbFxYb+bxkVDO0gn4EzAsWXmEyYIDBd3ulUww2nJBiVKB6POYYHMFczd8
         pKim43FjXsprahDEKQC/dMMCVqhHfq4Ld3QzGkzfqjJRF6Oi5Gyz3ywbG5FwreH4KHPl
         BceyK8uC7+qSWWDXdq82c8gbl96FNMYwhpa4KJD2AcZeE0BwxaeouNz+2+3VqE8v6O03
         Dyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777243836; x=1777848636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNJST0MnlAqczS/H5JIwYkKmkjJSbsGqSKXE5vOhVdg=;
        b=Wrxv/ux2PI8UR+1qy4jhkEK28lbnx5mFNdbLIu2jyxbkp+4Iw4VBPI2r7w6WUCwXkE
         m5KGXpSPmiyZt1nfaI09ZIv9TgNo78hVJWdYWykm0r1LoC55diXgzG3+ahMIwyczeZ4K
         8Y/2Dg4oELIoBOrthT76fYnknzjUIx8BHuXko2vRG/cDGb/oSCfhavLUfQtm4VW+GB9K
         0Dds8zqd+R2OE8t0wIjSJ+tN5H7OScdsnG5fCMy+vlb6qADA6N5bh0zCLXTTb9zxilWE
         69SeAgEPmyGtHDgg2kMoccCV+MsHm8Dd1qI3Q9YbPgP3PXemfwZ3Zvas4vJhy2PdaW1z
         lLjA==
X-Forwarded-Encrypted: i=1; AFNElJ8julHOyOFYRjn2tVfEJBlot8HaeGr6prfq5OxhscHTVLrBmc06EUDaAAHFbLiTJNoeVZpPD2coFV3T@vger.kernel.org
X-Gm-Message-State: AOJu0YxdCOscwXoZd877A+jCwHnA/n/HmzdtCPk69uSTKgR5XSeZSqhL
	TGQlntXnCxovbpLFaXgFKG/Xsd5q/S2N2kOzzJ2QMWnmUeADJffAEtnFPF4Q7rzAgv0=
X-Gm-Gg: AeBDieug5zaKL8fiFX+k5UkbsY17ci2y1mYxuaO7GVsDtc4+KhcB/vhWezZYp+/uyxk
	HTI4yxaBA8mCA6bRVeVn5GoaTGnevUPN+v+3PQZ6Gp5+dq+zRTTS4rhUfyLxpAOVC3Fu2MHemnW
	73sB0OFqVo7BTiYckpwcnYQ0cbzICUmlpHADs8vDWxpJ2i94MYJ61cjLx3MlwqE7kmVdAp1WcsV
	1iFAtTNO0IgS+v4hIWjAzGaZwppAExKBRB2B+PUn0e2xlZDP8RFcYjiY47ZFDOOU5pIzuhLQmwv
	ah0u/FoUUbRKzEldRDE5gxvGWz56cDz7izxmZrpugrFb9rm8+C4XfJzoxi699IbmQmFOdyUlhzI
	PB5Spc0wRQGtIrBGYgkhIuIC5HQetM0DlB/BLP+blFIRN540/XxkNVc6lyI0sqZW1bcpYy4iF28
	zkimWsFHnOt0hBbflSQgT0OL0otKJS4c++Ou7Dvc00AvEBf/K/ZABcxyL4/4076z1qmWhoUOu4A
	GJ+bEgHc7fRcHk2
X-Received: by 2002:a05:6214:311d:b0:8ac:b738:45dd with SMTP id 6a1803df08f44-8b0281c71f3mr652124586d6.34.1777243836359;
        Sun, 26 Apr 2026 15:50:36 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5c261sm249874056d6.23.2026.04.26.15.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 15:50:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wH8J8-0000000HABf-2P2D;
	Sun, 26 Apr 2026 19:50:34 -0300
Date: Sun, 26 Apr 2026 19:50:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, linux-rdma@vger.kernel.org,
	mrgolin@amazon.com, gal.pressman@linux.dev, sleybo@amazon.com,
	parav@nvidia.com, mbloch@nvidia.com, yanjun.zhu@linux.dev,
	marco.crivellari@suse.com, roman.gushchin@linux.dev,
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com,
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com,
	ohartoov@nvidia.com, michaelgur@nvidia.com, shayd@nvidia.com,
	edwards@nvidia.com, sriharsha.basavapatna@broadcom.com,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v2 01/15] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <20260426225034.GA3540346@ziepe.ca>
References: <20260411144915.114571-1-jiri@resnulli.us>
 <20260411144915.114571-2-jiri@resnulli.us>
 <20260421134635.GG3611611@ziepe.ca>
 <pun4bxcclwqmurxzxuqlkv5qdpiqcxqjpbhrz7vtsjf2paallz@6f3w32ww4gl7>
 <sdmwjrxzgbg4iz5cspcdkvvdb7rjgdggkw4njct3pkdsvhsq24@qstis6jnplap>
 <20260422165101.GO3611611@ziepe.ca>
 <20260426135340.GH440345@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426135340.GH440345@unreal>
X-Rspamd-Queue-Id: 91D5046B629
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19570-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ziepe.ca:dkim,ziepe.ca:mid]

On Sun, Apr 26, 2026 at 04:53:40PM +0300, Leon Romanovsky wrote:
> > Well, brainstorming idea. I'd like to hear from Leon too
> > 
> > But if we set the general goals as:
> > 
> > 1) All umem creations should have a struct ib_uverbs_buffer_desc at
> >    the UAPI boundary
> > 2) ib_uverbs_buffer_desc should pass directly to umem code without any
> >    driver touching it. ib_uverbs_buffer_desc should be the only way to
> >    create a umem from a driver.
> > 3) Existing UWH umem descriptions must continue to work if the desc is
> >    not provided, by reforming them into a desc
> > 3) Cleanup and lifecycle should be centralized
> 
> I have mixed feelings about this. My CQ conversion showed that even a simple
> task like creating a CQ umem (numb_of_entries * size_of_entries) ends up full
> of creative hacks in various drivers. Because of that, I see real value in
> pushing as much logic as possible into the core code instead of duplicating it
> across drivers. However, my later attempt to change the QP path made it clear
> that creating umems in the core is not a viable goal in the general case.
> 
> Another outcome of that work was realizing that CQ resize (and probably MR
> rereg as well) becomes messy when we keep the "old" umem around. Splitting
> creation and cleanup into different layers probably will going to hurt us
> at some point of time.
> 
> To summarize:
> 1. The most practical fix is likely to provide a driver callback to create
>    the umem when needed, as you suggested.
> 2. We should reduce the use of UWH as much as possible in favor of a
>    well-defined schema. In the long run, we want to add more umem types,
>    and many drivers should work out of the box under that model.
> 3. Explicit behavior is preferable. If a driver creates something, the
>    driver should also clean it up.
> 
> I'm not saying no to your proposal, just expressing my thoughts.

So, I think making small steps that upgrade all drivers will be
helpful here.

If we can get all drivers calling the same attrs function and giving
their uhw parameters that is a good step closer to being able to put
that in a function if that is how things need to go down the road.

And it does #2..

Not sure about #3, we already moved toward core destroying umems it
may not be a good idea to try to undo that now.. But maybe we just
keep that for CQ and leave QP as driver managed?

Jason

