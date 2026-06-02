Return-Path: <linux-rdma+bounces-21626-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u+roM7LkHmoGYwAAu9opvQ
	(envelope-from <linux-rdma+bounces-21626-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 16:12:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5EC62F2E3
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 16:12:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=MsScU2Pn;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21626-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21626-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9B2E300E2B3
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 14:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A483E92A5;
	Tue,  2 Jun 2026 14:12:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EB036308A
	for <linux-rdma@vger.kernel.org>; Tue,  2 Jun 2026 14:11:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780409520; cv=pass; b=YIgSv74zrKGse4aHM6mWNR+W+w95jPSGtJUuzvhTdAJTkAOM1Qrk7eiAPSfsJn79yyL6bR7cd07VUWrvhdqrBGWlP1NX0op3FR8yiFpbDVrfxx4sgHVdeD0ZPDrEc9FI+GZEvPeXtdgpEggbCc3jpKdyTI9RMdUyToowMdh8d8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780409520; c=relaxed/simple;
	bh=W+nroI2BEJDK3lCtz9+3OoxUUVaTBR/pUci9vKlILCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shoqYPShdIHtGP1MpWGUUTPGsDPTegntad3IoHdJ80d7pScFxC+x0+EF4gfT2TM6qNpoMPLuzai/AQ05uKRHEj0mDdPOlwqAkkCKykUl+IHHactyN3K9/Z2HgKK1wLaXd5iG0k9TDkTtvZXANzajfNYHWYdgXMpikzBa2k+cQdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MsScU2Pn; arc=pass smtp.client-ip=209.85.160.49
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-43cce364a91so1126283fac.2
        for <linux-rdma@vger.kernel.org>; Tue, 02 Jun 2026 07:11:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780409518; cv=none;
        d=google.com; s=arc-20240605;
        b=T9tE5XlklNWuL8rlOQfZVpmzMBmFs39eUcUCAMch69SCU/HTragD8RrLJjVTZF6lZO
         8i4SLRsQ+py/mzLdk3lSyfTbuUQ9tcKXLok635QaLTrwzV1VB5vueRunipGdp37CI7j5
         /PTRwYHEyz8Czt61UkCC+jNar/YQ1lHwWbThGSzEn8LOEZ2qkNbLaFYUeCwuw2oQr21U
         XlecJ0d+37hS13KgmQdU4yjpt1iP09KDtnmuxkpy4Tu00eJqVynZnOJtvqY8aMfhy1rV
         7hU+JcLVZzXSoqwWzYCQSDYnDnYSJhyGlAU417ywvuuhUF5nyrsRlchxXYAvg23qD02a
         4eZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=W+nroI2BEJDK3lCtz9+3OoxUUVaTBR/pUci9vKlILCw=;
        fh=rV8bFmjGRJ3S/B8x3ey1pIA+kzrsMUl33qmv5qiNFfI=;
        b=LPT6aCEWN9TlgRJVEhb6AoEfSm8M+YFyUZdR+5T7mSBmkO340cPHjYuiYuU1LKZMTn
         P49ebc0B3mjdGelhoXTZ1APRwyq4WStjLvUjju4XcFRgPceUOwKfFXAtXqmXgzWJNLSR
         fdINZg0cG642dP9iOIs2UjFRZnt4HeeKZ0HlIFzHe5ss0F/+F2Ue5ZV98XdMLz0+jyhZ
         H/xd/W+atzEq5zeEHc9ugYrMGw1jCYjjQvX/CGWry2UDuUj85cUMeWyC0Qx6RHGj8Ofw
         XDGw9BOlxyZ8Ve5xiMwtkubgFOpUH8upwF9NGTHmA/+K3MIfSnHceHmz6XZXwYnrYUOB
         EMJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780409518; x=1781014318; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W+nroI2BEJDK3lCtz9+3OoxUUVaTBR/pUci9vKlILCw=;
        b=MsScU2PnSCLT/9PfgFzjzTmvXdpZrWbe7HzBZ9Auh46SRMpwo4NAUCEAITX96LAYUX
         5U1/DUPQRZScd+XzviDxzbm0DDYwZNl+DMInbYcemgQx1T5+Y+Hfw8YsH8y36j7QSM+P
         heifIhmAYD5lfbxOiid4BJDaIjzdErkS6YhQe9PVeF8nCdGebQZrtDVbK5H3EYO36+tP
         c53/0WT8VNoOcvR3/k5FO50IpPiMNFZn0CdYoiTQXFE+F6EnqXvUtfjmOU2w0X2nxz6+
         huT2I5lstLt312a+r1fgxRhcrnFMl1VlfBEZYsF3TajkOoker+BH/vc3Zm1zaUqqcAGT
         wPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780409518; x=1781014318;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+nroI2BEJDK3lCtz9+3OoxUUVaTBR/pUci9vKlILCw=;
        b=T3Z5I4i9zvQyWI6SG1C6+gNGC2Ymi7KhapEhUC1mG8piX2cxNycZ3xbN9r/jC1CUSZ
         V8YawuqQjqqhVT9rpYZCRQmd0+t5LvhQrvp+Fxk5qTbOQG9I2tTg3aGru0Kfg7Pwk1I6
         iqWZbXV/imopksTjgDMk1JheIXCaNlTyEAV0QdPFZaakrMIOq2znDE+4hf8r3r3TFHtz
         BR9qH1PE/1cFdCFN3UguiVxdOqzeLejC0+mfWOdOoCO8+qSdHwJf3zWD0souQMInzST9
         46RSI7lkQlKcp4EGpTKUaAd7W+3hOJfKJJHDudNdiuubxMt4WSXjwNNa8N7KCI2DkFbx
         LH2Q==
X-Gm-Message-State: AOJu0Yw5JKmRiZqLmRTqnA12RnoOVz/qE24v+YyH6DFx+mYgdxUJJFIe
	JvNh2IC/t+MBHec3bV3GDTJMvks8mEm3GIggtDs7oWPZu7/fpISb5l5GZCJ4EmAMhH0yBOqTP2Q
	FgtVgAY0B65xRMmYliUZU5aL6IMBQuumdLE0gLo5oNd7blwco7yollmi98KM=
X-Gm-Gg: Acq92OH0k9cUe+6wgmrcM6cNTdM9ggfRbbiP5fAWPPxJPGVeHzH63Lj62jIaHzwgJed
	KNDlkR2g+8UyYIj9HrvqO+aO9oM5kLJtjQfJAbeYzvlQ1v+cLJNBMbVuemqNfWoYpReGgrD7np2
	vcC9Fj+AX5GTDv5ikLdgJZOPgBOhBeQHEVBrqqWuQoirf1R0vpymDr6ToBCm+8GjTooh7quumut
	kK3eTaBIK+nMdwDgcH6td3eoVFtAkHjrr/LIjrKNp0JnMp3iJAmQqhIH9xGCA6Zj7JKVKNxMoPT
	j3IEAqXyVOZFO51LHTFGJl0k4I4sD5hogLwkVVzSlZw3Rf/K
X-Received: by 2002:a05:6870:3c86:b0:43d:30c1:6573 with SMTP id
 586e51a60fabf-43d30c4ea53mr2094259fac.6.1780409518084; Tue, 02 Jun 2026
 07:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ahjB87k54bYdFbft@grain> <CAHYDg1T3m=mn17zLRZp3+zcJq+GeDGcOU_99ZZmWxYasEDKN=g@mail.gmail.com>
 <CAM5jBj4LPZxejjq2VFJZiwPWkZf3_rNxBRcT-8yrnfDXFSot-A@mail.gmail.com>
In-Reply-To: <CAM5jBj4LPZxejjq2VFJZiwPWkZf3_rNxBRcT-8yrnfDXFSot-A@mail.gmail.com>
From: Jacob Moroni <jmoroni@google.com>
Date: Tue, 2 Jun 2026 10:11:46 -0400
X-Gm-Features: AVHnY4KP8zpG1N1ng-O-FgnrKGWydvyvoKAb-9JZjpx1Fb0aXgQjYDb15gr8Po4
Message-ID: <CAHYDg1QH=tMy8xbYn4D-L9iyp9iCVCEU190H9_gFLTWMABqhpw@mail.gmail.com>
Subject: Re: [PATCH] RDMA/irdma: Fix typo in SQ completions generation
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gorcunov@gmail.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,m:leon@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21626-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D5EC62F2E3

BTW, your fix matches the OOT driver code:
https://github.com/intel/ethernet-linux-irdma-and-idpf/blob/main/rdma-driver/src/irdma/utils.c#L3561

Regarding the "unrelated issue" - is it an irdma issue? Anything we
can help with?

- Jake

