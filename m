Return-Path: <linux-rdma+bounces-18295-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wH1MKgllumklWAIAu9opvQ
	(envelope-from <linux-rdma+bounces-18295-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 09:40:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 385DE2B835B
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 09:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 565B330BAEE9
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 08:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9231738229B;
	Wed, 18 Mar 2026 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OhJCiKeZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178EE280309
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773822911; cv=pass; b=UIHyPD8gjjQg1K3TLQUkpiBa6OXXZYY7L05Ixs0CxhJJ7mjrK4eyr+EQYCvKMCamiKSfMlckGnAwgKH/ys36feTpHNPoAgwSY41hfvFhYTi33Nevzd9m4fgVJSrStb8Vco8basVLxL5lDnWLxMdIcM9fk+yTTt+Yc1gwLYg2fKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773822911; c=relaxed/simple;
	bh=hDjIJiRif6m6kyt9niwff9AAi3vC8QIzJ8PNGnIZYnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCxfaXOTMxLS7Svx+3VlD9D3UDthV++0igUEivHRxMEBJ4OUAXuKfc21GQ6V//slyqkKA3ocSV3WGuqPNjcBI/m9yu/wRjoQ1a0/dq5x/PqBrSzb/JGIZgRAiXW1f+oj/lP9qq3tNiael2av90OVdNlxjA8jLt1xXH2DvHVprHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OhJCiKeZ; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a0fc5e2c59so7450838e87.1
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 01:35:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773822908; cv=none;
        d=google.com; s=arc-20240605;
        b=LO8UuRVJkHlhztycxKB2BAdtADF/t6rd0PK/92F9QXKjUy4iV1htixREOSyQo/b0MJ
         bTuXtHweySbJAq2kCwD8mEKA8tSKBVecsrMjOEPrhYOuPqOQ9E9yPNluQrYRmduRttV7
         pGSP9TyL040OsTutHUI4XaFlIB3Os2AWEL287NNqeYm1w/bfck8vij5hGG9JqQBS8uUP
         w+49YXGIbXzpQiNlYZMBfLGivMHEhMotZRvAhE5HGBBUZA2TRw45NOgRTFNU+K+XWj5b
         rgX9Vsltrl2GJlQBMpTBtD4bfitv20IXUacp80azSSOfL1h3QzkXZBS56nkg0mAjavOQ
         CR6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hDjIJiRif6m6kyt9niwff9AAi3vC8QIzJ8PNGnIZYnw=;
        fh=1XK68CQPvZs5A+UCt0ECYGt9wljEgUjXqv8ndqMz3B4=;
        b=Wfo9ZEUhIRF5cu7o54woQ4ng/SuFVFYQt9ibw78wSoXrshB09xHhpFQH54PjXcMiz7
         tcDE5eyhKbyOJwxrQxypASv901ELwjBBUBEhTo7Os/JdVlp2FRV3KT4jaT6aAdmvnb0b
         vHCTqcp7GZB15hR8nji88CX6XlAbTgJkd4xD6hWxVh/gW2aiZ1BKqS2qYFeLoy+NkmMv
         lAqU1FXoOBPp+9NwnBd7BcR72JjY+q+GR2qntLx98a72iR+uASZiyPHSinMaVcmCZ4BJ
         5NlMhUDNkaNYBuc525/vc0PoIGqiYw4LLqLiU8QmYVXtt1aIKsAleONzUuOiRUFZ8vx6
         1TQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773822908; x=1774427708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDjIJiRif6m6kyt9niwff9AAi3vC8QIzJ8PNGnIZYnw=;
        b=OhJCiKeZ+yN+glXdLen2RdEKTHnxvanNNCSrRGMq/FlmUbUVKcS9ZVZUDuQ3AKPqr/
         Xs0SharRVwFJB9Eq6w8LHaRhTetr5dXKTqKgYCDOjQURwLWQoi/DqbudZRIXvxrXDnxs
         TXeqPPZRT8eq5Wot9ywKYzJPkBCOy2J7SFsu7GX+1TplDWZkL0Hyawf1cLjkRkpVzGvv
         jVRsbq/DjmigN/RMocUp/DsggNRr7Qqxoh9Nq4lNp4A0IwJAXpdd3a1pnMJ4oa7ObQRQ
         s62IHfmcW/vO4hWOUZpB9RMYAUgYU75maUkP1EyseUVtTWVXglNa3nHxIctxIk5fokdB
         QsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773822908; x=1774427708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hDjIJiRif6m6kyt9niwff9AAi3vC8QIzJ8PNGnIZYnw=;
        b=a4qWd4RJfmYNxhEIvMg/2oEDGyNeKbgdAIm/5YFIDdAQsRnFtQN1zLAWabtt7MXcAN
         MqYXKJGiPZIZ88oXt7dMaT2nP6/eqlfkR8/lkYp8dAMfTUZGwoVtkyHdXHlNexDmjVUk
         0EpSQULocCdaOFFQju62Z6/+AHsBn3KRW2HUAaNkfi4WS7uGItImd3LU8QLQUNouOffQ
         P4PdkZPnRWvVfkKjE7zDy1h+jwGsZDtlfJ7Zlg69SQeOXoYBKGw4vJbje+jyZ0MA7M5M
         ZdJcPZngZNmVWyRSES92g8pYHTTSfrplWmZg+LkO39uAHyl1hTOfIpamCktv3SHzUwo4
         C32Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkg6gBPYzehIlt0TAwzXYzKV99iy5fArEYPPIUk5nPy1h/XKfZVWwwFIaknykOCNERMc52QcMl9upv@vger.kernel.org
X-Gm-Message-State: AOJu0YyZAvdkomBmO0W7GUDBkGBP11M4c0RYppWSx1YdtZsab8Gsl+Pf
	ZmPSjleOs1/G9DqxVZFriMJTVuhpoo2lMWmgvBGLGuG8l5d+5LTavAxo7UDZuIi6VqWHjPGZy5o
	h6HMhH8X92dxwb0lo/yck8T37X1WcXynWR1aJ17I1HTD3apSCb6nu
X-Gm-Gg: ATEYQzwCBQGP+Wabkg+RSDpVz1kidugqA/Z2JcylCN+JDc/VJpB3K+gQ46a9z8vlHUK
	vW9zjKK4PrjT2bqc/W85cGHLnIPH+7pX181TbXP78370taedRCwtkzuJ8BEH1qExIJ9fmVuEUZk
	VqhZ0s6GgMOHONooFUxFuXb9aA2eDbTiynXgrXiZqywjUjnZCEeV5irTCL06tOzWVIs58T824kb
	H3xAXKJ0L6RK1GWpfGITDnhcLuFmyZA/VtKTIWi7HyrzVec+veCR0Nfv5XrYfy4N3HKxD1KiLzi
	c5dsoI4OT6IiqLrZbRnya69zZswV+Qr0TnrrmCDU
X-Received: by 2002:ac2:4e44:0:b0:5a1:4b12:b153 with SMTP id
 2adb3069b0e04-5a2796c3232mr582500e87.39.1773822908236; Wed, 18 Mar 2026
 01:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313154023.298325-1-marco.crivellari@suse.com>
 <20260316201301.GL61385@unreal> <CAAofZF61VPo8VAX8zXUZnY-ydDYAR0N0mN2egaeTzXbiaKQbDw@mail.gmail.com>
 <20260317162429.GA61385@unreal>
In-Reply-To: <20260317162429.GA61385@unreal>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 18 Mar 2026 09:34:57 +0100
X-Gm-Features: AaiRm53AdI3l0Gw2Bkj1yyDK77sa5sAShSwye6nwLswzNuf4qJJsU2zP0_H_MTY
Message-ID: <CAAofZF4BtuF_Y22mZ8wmzYxejeuCy9dDASGFUqEfD6Vry6mkBw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linutronix.de,suse.com,ziepe.ca];
	TAGGED_FROM(0.00)[bounces-18295-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 385DE2B835B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 5:24=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
> [...]
> Actually, RXE already have one workqueue in rxe_alloc_wq(), just use it.
>
> Thanks

Thanks Leon, I will do as you suggested in the v2.

--=20

Marco Crivellari

L3 Support Engineer

