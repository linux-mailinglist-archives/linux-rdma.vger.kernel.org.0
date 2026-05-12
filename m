Return-Path: <linux-rdma+bounces-20506-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NmOIRZuA2pS5wEAu9opvQ
	(envelope-from <linux-rdma+bounces-20506-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 20:14:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 853745271BE
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 20:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25DC33108930
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 17:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD8D3955E5;
	Tue, 12 May 2026 17:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MnT9kzPr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4097D3955D8
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 17:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608306; cv=none; b=RCkSpOM0KzhJ/9v0z5E4QWb2z+LdutPh5GJr0JWKzozucEvufaNcahv8jxVrDOPN4jPii1SP/i+VyD+vy5C+y6kgKqZNPX8AO6+VxDOA+N/sNm0WHOx9/MBgScONPTgnoMJL0XzhruGzIc4BTsg8QWn/IFIdgEjvuc2kZ0zQJSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608306; c=relaxed/simple;
	bh=09njTlfUCf1gDF3ba/GwC3BOT6cofEhhJUYQYVM6V40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJnC2RXfsS/XUZxILqrIKulzHD8ae1B6AmoeaQb8TkXTYjAkrrH9xCjzQHLgHCsSue+ImsCamR82CoYgw0XFwk2uSebB6r6f2vTY2Qm4jjzTYy40krhiE7kNOh0kegL09s+3CtTPvu1QO8L1tlhnhiv9Bu5g2fy5L5YqH6fubRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MnT9kzPr; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50e5c7eb565so56663501cf.3
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 10:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778608304; x=1779213104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oSEgyOX8n30bVGfst510afCYBQfAJO+9kx/84D2Cob4=;
        b=MnT9kzPrbiNBPESaYporRaPtXSeEsmhYI11VxfBkngUs1rceaOMkjULDDvYf8dDQ5D
         uxDJARc9zxU03BpTjHcC3G7i5ZEKmNkBbv2g9pCYxCx6AD3H6IN6aWEmNGYwRcQl+FRv
         M02EyhHxcolIWGMDJuXDNE4tvulnyKkbwhqly05WbMBpY6X9cGirKBiCsIuP3xi6SJbl
         G0PVEBIC5EiAaiJYSG4F2utqd3wxN2gZjPP2+Ua899rn44JGCxDwk9p/0yYYvXQJmZW7
         JbPREPc+AWEXQlk9zoI1xg4+bDkVW3o+64coc+t/wvZqg9otTAAyD9zzaJBa7ZEgqxpP
         YL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608304; x=1779213104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSEgyOX8n30bVGfst510afCYBQfAJO+9kx/84D2Cob4=;
        b=G+SA1Ja6a1uCUSdNJftKENFLMUUVrhtwld1Eay9L/jvKD7vIgZvyml6c94zNmZRwrV
         u1eajW6+VpC4obAwnZCWu5EmkbtfG7K91excp6JBzI6mG+j38inQ/2rhVCYw4CMpEnpg
         Ht9/wg3wCgFFqIzMV/a01WObQRS14Z23Zyxw5jfEdGHXRZ97RAUO9D4lQCEmOQixYtQh
         ZM5iieeeyHyd+6LWnMKQ0fQ+lJDvprXPgX8kkCyVvQqGvL8CPjb3ZuLb8U/bf5OqF3Cy
         gi8es4a5+tJImD34albGecpF/kmtsoQnXOgQZsKkPF+3ApAMAQHF1u26wpbvc/JEz9Ob
         ntyg==
X-Gm-Message-State: AOJu0YxF/JVW20Gn5m9cUK6fV7gU5fSU7Lv/FijW9plmiM65DrRzFRBg
	6ogA1sOyIi9+NH86xp/056MOomps4fzCDSooU3lZXQRENXsRwQajlN850qq44bs93Vw=
X-Gm-Gg: Acq92OFb1NeiRW6Q4oJ58//rgUlpRu4nfTVM3UKX1AG1PRwrEWC8TreLBqtkj6sMvAF
	KUrApLs/lSzLubx2lG2htle3y3ruxSHoYbia6kR1Uh66k4oponpOyEZt3nSbnKDm1UNLgTVSD4J
	mG+belbT/hlQUZWb7yyQmVgVKMgKUpPV7dUDYeuMhv04aJV2mv/nCMO3CndfmsW42SPDmpjUBDl
	C4Jp918ezPDpC9vnzeKP+3uCeOTLICJU0nFghQdZYgrN6a/3GDUAy7Wl8ecWJm+Sij+Bp4mA7li
	89jT5Opp+oM5IIXFEXDAwWGBiHrXLttmDT61xVNTXx8Yc5q5hiq/67xG/15tK5nfPtKhd/YQUDq
	0FLsgDZYvFFPKBgQdHf5iQ2DJXhbBHc/JjBJsFFu2Ti0AcQ1EigbvPL7LIFU2BGsT+XD9EY0RnF
	BT4Lm5YvXjvkpxzP1/pgDcaXsqsM84YeSQQT0m5S4r2L7Pf7GRBCiXi7lNYwXL/b4Pr4bws1tI6
	jcDh6jRXoNlKzkE
X-Received: by 2002:a05:622a:50e:b0:50f:783d:fbf9 with SMTP id d75a77b69052e-514d2218488mr54324861cf.49.1778608304145;
        Tue, 12 May 2026 10:51:44 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5149ed7747dsm114300421cf.5.2026.05.12.10.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:51:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wMrGg-00000000gGp-3BDu;
	Tue, 12 May 2026 14:51:42 -0300
Date: Tue, 12 May 2026 14:51:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com,
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com,
	mbloch@nvidia.com, yanjun.zhu@linux.dev, marco.crivellari@suse.com,
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com,
	ynachum@amazon.com, huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com,
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v4 05/16] RDMA/uverbs: Inline
 _uverbs_get_const_{signed,unsigned}()
Message-ID: <20260512175142.GH7702@ziepe.ca>
References: <20260507125231.2950751-1-jiri@resnulli.us>
 <20260507125231.2950751-6-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507125231.2950751-6-jiri@resnulli.us>
X-Rspamd-Queue-Id: 853745271BE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20506-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 02:52:20PM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> uverbs_get_raw_fd() and the related const helpers expand to
> out-of-line _uverbs_get_const_{signed,unsigned}() exported
> from ib_uverbs. Callers outside of drivers (for example the
> about to be introduced CQ buffer-desc filler in ib_core's umem.c)
> therefore cannot use them without unnecessary extra dependency.

oh. This is actually a systemic bug, the intention was no driver would
depend on ib_uverbs.ko because it was supposed to be loadable
independently of the drivers. This has become slowly messed up over
time.

The file ib_core_uverbs.c is supposed to have these functions. There
are many. So many..

I sent an AI off to fix it, lets imagine we won't need this patch..

Jason

