Return-Path: <linux-rdma+bounces-22015-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6/sZJH0KKGoq7wIAu9opvQ
	(envelope-from <linux-rdma+bounces-22015-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 14:43:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9BA6601FF
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 14:43:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=htVp2YLR;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22015-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22015-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39525305FC22
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 12:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AD24183A8;
	Tue,  9 Jun 2026 12:39:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05348407582
	for <linux-rdma@vger.kernel.org>; Tue,  9 Jun 2026 12:39:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781008775; cv=none; b=EXLOV2cP5FI6X+xLPGACEmIjD/pvsfsqAGyJRgr/nLf3hpAiqkChk9uaiO9Nb+jeV+TfUTRtrA/N121he3c6dKquurlztIS6pHQVsh3a/Xxg3Lhd3rO0DcXsdXT7y+fS2AUTa/QUy1/vaAKmJLmVhk9rJPKdC+YO8NfTe/Vg9yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781008775; c=relaxed/simple;
	bh=tozXJIoJ9ZyD/RgdiDOWZGrwfePx22dC2RLSdUqWzX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHZ6+PAKGDuYf9soTo6FVWdQswodDsi3EbZBTUDyGhhZs4lyeGGMnnAvjDUZWqcauXIl1eHxblK4AO6Az5Yx6sneI407vuz1uH08LCIedxPR+gELpLov5x4ppIMZ18lRGE+ff/IvqtAPEFlgy9SrO5RxSUlJSWaA5end9uopbvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=htVp2YLR; arc=none smtp.client-ip=209.85.219.42
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ce9df31840so41643796d6.1
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 05:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781008773; x=1781613573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kxrUDiRatz+tvaflvzMP2hSJHLTXJP3cEZpHwize94E=;
        b=htVp2YLROgRbbRYQOfJ3UjeXp0fnux9dOrYMQEVdgNnfOEPoU0BZEfYGbwnkPkkPbb
         WtjxMWlwd824E//d/OaZiDERzHr5HcTLDzUDYvRjC97n+ycH1dr2XpWBKsdTc+Hle4Ud
         P3HFHQs98sECqqc7rNI3KE6Rl3wfP10dnC4MmwqKKtvENxzOtAG5ai5G3aIPn7xg5/cx
         zNYzsjQcFMXaHHqwnoX1g39Be9bDKJCXI+FwFKj82jxCjY5szkOx7eex8sH6f7PjM+4R
         gHNkv4TATVmEWYOK6l09ECyUPEEycFdB0J07sWxep7UVsB0GM183ooYaFPfgtez1037H
         WObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781008773; x=1781613573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxrUDiRatz+tvaflvzMP2hSJHLTXJP3cEZpHwize94E=;
        b=lUhEzK48/97NDQfutCw1RoyMEFheQ35Ia7uYHe2n+qjzaBgCoplzbXwgI33N7PQvP1
         51+gYyl6d21wn9XNG1i0ZYguqeTbeTIFGwlV0IIopuQoAuBv+CSea7Yp7+AFqISzFV6M
         xIGGf6DJmjsc9Gh6tDx1fjI+1NLVeEdv4uTlUM8bn0JPUX4kWyYVVtmmwaOqNjC+eSl6
         xOyy/BWRsGvMmA/nmpkLzhpF3oUL/3MfkqlC6Wd8Mdbgscv14tgwlr5b4ZeRyE8FKy6F
         CLO/DmcD2h5JMs6zzpSD88vj/FVvwrcrCxrERKoTQ97vHGFrQEGlKvJ51j7PzUPhRliZ
         GMbg==
X-Forwarded-Encrypted: i=1; AFNElJ+OF2yz0IP5DH8SDv5ejrgnCzdcVWBK9tGn4vgatT1cdR8TFoGsvg1t0ZUIsr+sF2vFTOZp40HVPCuN@vger.kernel.org
X-Gm-Message-State: AOJu0YzqvDrXsfLf73iw53CfwIz+w4zk1Na+ZJhrPhltNnWAsLkAyAgG
	mySMn8nqfUSicg3p8OYjK0YIJHJ0mQeWgMrGDP3hJkmL5hwjquUZCyMrwg1IVk8zGww=
X-Gm-Gg: Acq92OGy3sE4H2ymNw+W5fjPU9OUKHBsW99lgRtIcAtPnwhqv41660l1+GctfBplbkx
	abZ+qy7rf7dIS/vFkiG2Pb/TIeKBZjMvFm7nxiEs+u2qfxPjvlOYH5iMQOob1P7u4pLrJmw0gwx
	xOVWGWBiceagpmuKx0702aU5rRfikbluwMGISmU4Q7s/aoxvMwH/XPBU8vifwTTzkRPfLgMQni5
	OZ+Ol73sP089I5XiaAtzYODOdQqh2d00ZEu4qSP5uB9i/toRM3PJU9xw/cqosE7scle4pn1XJgb
	FjeeK0h4RaGGOiIwMfZ7jNGNhc6IlOHP/MG2Q8pTH2SVa4Xi8lGkz8/gHKvlhvn/colFGCTXTFc
	td4bnl+On/hIhCrhz0Ysiq+1ApBxaSeFYHodbV8HY6uKC0MlUquBe/UI5tzFQisFiFaJjRcWlKo
	NaUcyCXQLSIp2FL51KyeC/5s+DhfMFXeadI0J5FzBYIKVgqGVsL31NsR5pNwXDBroxX+BnSpGgk
	9rfZR10a4lnTumN
X-Received: by 2002:ad4:5be5:0:b0:8cc:2a92:48f2 with SMTP id 6a1803df08f44-8cee625246bmr334792646d6.39.1781008772803;
        Tue, 09 Jun 2026 05:39:32 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd051d61sm201134896d6.29.2026.06.09.05.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 05:39:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wWvjv-00000001sjW-2NnW;
	Tue, 09 Jun 2026 09:39:31 -0300
Date: Tue, 9 Jun 2026 09:39:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next v3 1/1] RDMA/mana_ib: UC QP support for UAPI
Message-ID: <20260609123931.GH2764304@ziepe.ca>
References: <20260520100656.875006-1-kotaranov@linux.microsoft.com>
 <SA1PR21MB66836572AF65E8A2D147F96DCE112@SA1PR21MB6683.namprd21.prod.outlook.com>
 <PAWPR83MB098460109147A819963260A9B41D2@PAWPR83MB0984.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAWPR83MB098460109147A819963260A9B41D2@PAWPR83MB0984.EURPRD83.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22015-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kotaranov@microsoft.com,m:longli@microsoft.com,m:kotaranov@linux.microsoft.com,m:shirazsaleem@microsoft.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,ziepe.ca:dkim,ziepe.ca:mid,ziepe.ca:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF9BA6601FF

On Tue, Jun 09, 2026 at 09:40:30AM +0000, Konstantin Taranov wrote:
> > > +int mana_ib_gd_destroy_rnic_qp(struct mana_ib_dev *mdev, struct
> > > +mana_ib_qp *qp)
> > 
> > The function is renamed to _rnic_ to be shared between RC and UC, but  the
> > request/response structs are still named _rc_. Should these be  renamed to
> > _rnic_ as well for consistency? Or does the firmware use  the same destroy
> > command for both QP types?
> 
> Sure, they can be renamed. In the firmware, it is still called RC though, but it can
> be used for all QP types (even UD). So, the name _rc_ is just historical.
> 
> Long, do you want me to rename it?
> 
> Jason, can the patch series accepted, or do I need to send 
> IB_UVERBS_CORE_SUPPORT_ROBUST_UDATA first? 

Yeah, that's what I want to start seeing

And use the proper helpers too:

+	err = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
+	if (err)
+		goto destroy_qp;

Thats ib_respond_udata() now too

Jason

