Return-Path: <linux-rdma+bounces-18338-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFnXCSrGumlobwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18338-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:35:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A76EF2BE518
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFD7632133D6
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 15:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6E83E9F73;
	Wed, 18 Mar 2026 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fw7fK5sc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4E23E9F6C
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846522; cv=pass; b=BaUz+Rw69qcvp8gAaxd/TnHIuJPRdamLKjHzWWX1KBbsaxCMy17Lr5pmpjBPa5BH60daYLDD16HAo/AiJNWMRe7XER+meo+sbTwIdnYDEv9AVTmRWZWjRPkk19c+NtER3Mv8+15kqhm6DCp5YY6H7RVAOLG0/z1c89I+lQsOAv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846522; c=relaxed/simple;
	bh=LZRLNHYEINYw4SgEs9g+UWyAH8/8JeIkPaszKE3ufbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvnJIt+roEbfIx3PPpjq82Y/YHHCCLEyNnkMwMsh0iO9GiajuTGZTfRnObCkS3nIRc6CDAEFNyKK5rAeYDm9jyZGgZjSImk8A3plIMMt+TK9qtUMtx5mMUgkYdHifZWniAJxbG9k1nNoKJ7G47qvil8abAW6JBv7Zoc4gHuE0Ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fw7fK5sc; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59e4a04f059so7041439e87.2
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 08:08:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773846519; cv=none;
        d=google.com; s=arc-20240605;
        b=N0cd1R4Ijr9wnHOGzic3tkq/HM/ZaXwU7qxiwRullzha+UBzevZOo2WTLOTRsVbFBb
         ApMzHx+0ISo8rIiF9F/QOR3apoYfFxJRWFnhfsRM8F/qN+Ucxc3KMPJcdXazNmeO3Nz2
         AYRs1hrNhPLjiTc5olYLQDzotssk+qK+b4CyAgI6N7VXFdY0EJVyjJZjxvbZz3KM635T
         B2U/by+aS6yv26e0Chwp+J5Mbm85SPW0SGAwioH9pLx/4nwfryqv37RcNe6z8iIVVG8I
         AxwLUalp/2fzWEr1H7SVNliBpZ+LR7vaIFjGpCZ5WKOk7MaPtw/dv9lDmvV/OvTF1y3M
         fIZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LZRLNHYEINYw4SgEs9g+UWyAH8/8JeIkPaszKE3ufbc=;
        fh=uAFU//LHbibtHi2XM183UndMs2vwqK3wEh/0tInXhVE=;
        b=l3jvW7960gz9TGRul8XyozLYZbHViUvZOhKGCbfsgJKiyN7BjoiB4K1aGT5Tmk5y3T
         VZWK98aoqM9d15zInbyR61212lAoZgmnkDftfkK6aqwtV28tyHYMT5Eyhnz19Tctvm7D
         NNfTz64NOXN6VXg12NbTtAE0VwnyuJBMqqm1nZvgzAp0CRVpPzjJistuecUO2Hm87kAR
         xkjIKZPjagS8ja8zuBj4N7eKSxcj5NKZrEQUZ4JN5Y3Bq8udibsfiR3zZ1dGyh+TQP1+
         rYW9h8yk7XsWxlxuIpVbjYr849gJsFbMQ3Y+g7+3/RCzHYZbX4a9Y6gbuwqN3NzWV9d0
         rGkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773846519; x=1774451319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZRLNHYEINYw4SgEs9g+UWyAH8/8JeIkPaszKE3ufbc=;
        b=fw7fK5scyxYs5lRQwXywKBM02weV1KH4f9K2PmeVNJnbDUXOHmu2MKcxJ8lBlfE2G4
         pY7jFhtzVVE8tRkPpzYdXW+i0ldctaBiNybadfhGBzjMLtTiXTyO0wULYy0mtsroTC0H
         OI+1iXm7/0szSOMCRj3ReowN854U+SmdzEL0mQ0F2v1XjpO2tnp4oiuvcaf1QQWvZmra
         i0Dz0iNpg+PKwR7BYLlRLlDRzbFcBU3zInAdI+j1iMqAzAbyPpuqlSD3yX3RTmO8rZCH
         LVluPT89wnj554+h7YbsU1/xAQ/LXKFFeyqqnIRqJao4q1p9No9NMKmA27OTmIgXHxh0
         /KYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773846519; x=1774451319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LZRLNHYEINYw4SgEs9g+UWyAH8/8JeIkPaszKE3ufbc=;
        b=JXGRUjtrMeqXJDI+JXD0xLR9QUbVGnMQhDypJbD9Nehw2RrypZS/3m+5OrSHhmpZUU
         vH66xYMxa8duvJoTXWSc0GEI6L20IU8o0sG+31jM1HilhuU1RMDFz+vhWPxPyBGEJyYn
         yN+KE5GKGzGyZTyLDMQIM5lp9p/RSehVmEMEXr5NXDqrxfC0DrkKg5o3i48OP7+lCx4w
         uVjFxS4v53Zn8wOQccYC6MZkvcDQrjyRKLTsv7azwyE94keFT4lmDyLdSVN1yDMqSxwS
         8AlwSvpJtEJkI+WIiQsZfQ5hg0tXcZLutgr6w/K8P0R8bd9MmhNJg2/9JM7e7L66Vw6c
         NfWg==
X-Forwarded-Encrypted: i=1; AJvYcCXUo0kqnUptNrs2HV4EBk/1dK83vIZ1OaeSJNZlA3LQUgTVcgWXdjodcf960HZCB5mDxS6NDnp/Ph1W@vger.kernel.org
X-Gm-Message-State: AOJu0YxmVEvPqoCBjOJ77pLEbyGOTcIrfjoIN8yuPvCjfSOIocVQye0t
	6Gb0S7zNZM+/rJUGiat3PSWzfdSLH+zxBXwwNwndT6ZsfnlpCxlR1MOnSKxDLxEKBWbQwg1C+sG
	cAd9im0D/1eWMoqB2ubpJbms6qcgfWrVsl9fIJ25FVA==
X-Gm-Gg: ATEYQzzB1bMKqvyHgjw/Lu4R6UHHFzbimDkpda+51SNFoJDAxjunGwa5tp6RbzrXzq1
	IRqpyRDgkn+1wHIBtngcSxW62RCRMqHJmsYuLhGxR0jO2Mj49HtDD3PlqwFsjsI7BCvdOvtDuaI
	ah1c20abLMfBZyEZreKjAtmbfboxHrGWbSkIZl2eGzbPTSWY1AnJoEjMIv6Or5sOAyQpTBFEC+h
	uo4rvpwBEohlz5bc0cgO1rmChwtb+9CZhln3ZrRiEX008p4l1b67t8OyfO44rYAPQLw7s9h2jTe
	F8NGR+Va4KJLZX/AeWcqgTXsviPfyc06lIi5IC+4
X-Received: by 2002:a05:6512:24c5:20b0:5a1:23fd:de8e with SMTP id
 2adb3069b0e04-5a27943c96emr1047931e87.0.1773846518792; Wed, 18 Mar 2026
 08:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313154023.298325-1-marco.crivellari@suse.com>
 <20260316201301.GL61385@unreal> <CAAofZF61VPo8VAX8zXUZnY-ydDYAR0N0mN2egaeTzXbiaKQbDw@mail.gmail.com>
 <20260317162429.GA61385@unreal> <CAAofZF4jW2hD+UsBG8w3zYPeGGaHeSx0tSY2Prd2dXLLBkaf1g@mail.gmail.com>
 <20260318150225.GD352386@unreal>
In-Reply-To: <20260318150225.GD352386@unreal>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 18 Mar 2026 16:08:27 +0100
X-Gm-Features: AaiRm535aFjaR59wTrtxwZQ-Bx9z8AtzKfrvelmbhSqJGpVLl7IEvF-FP4bI35c
Message-ID: <CAAofZF7okguNbq-9fk1naYVQP0gPZaSuL2eRdguhWr2J=JTXKQ@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Replace use of system_unbound_wq with system_dfl_wq
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linutronix.de,suse.com,ziepe.ca];
	TAGGED_FROM(0.00)[bounces-18338-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: A76EF2BE518
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 4:02=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
> [...]
> > I noticed the workqueue is declared as static into a C file. So I
> > changed it a bit, tell me if
> > it's not the right approach.
>
> Your fix is the most accurate and technically sound among all proposals.
>
> Thanks

Thanks for your feedback Leon. I will send the v2 with the above code.


--=20

Marco Crivellari

L3 Support Engineer

