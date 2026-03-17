Return-Path: <linux-rdma+bounces-18261-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HpsEdRouWmZDwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18261-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 15:44:36 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6902AC371
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 15:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1B26307DF16
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 14:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BF63E6DD0;
	Tue, 17 Mar 2026 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HpnK0maG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1FB3E3DA7
	for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2026 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773757936; cv=pass; b=jAUzECDEstYUE7tcN36Q5bBa9Ea3AmYU5QYPR/b1FC7JGqLUZovrJ2nNjLgK5o6Q7+6wRR6Ipru/Wt1P2JvssOB1gxXze3Hw0H643F8mmHpLUzPRVhE0yFq7wsNaAMfiS+sLdpw+YfXmEdVr5+uK0Lh54vltFs4htHQM33A1sCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773757936; c=relaxed/simple;
	bh=gBaOM0il2x8LAWwHnZzzl+t5G0wyiJqAlKJyL4cOf8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlQWsqnxXXEZI3VHaNxuMVCb5cQtypaVi9kTFY+XVkBcoMv38Bzy3PF1gQnVhL8bDGQtStjHuqGfp5OS0fYrDyhi1PLRmPgrT7s33T/O+pnS/7kSAHFAGpRaq6dmZEDS7uWX5b/mT7+JUtW8ue77JR9ivdzqmEflnKmSQi9NBHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HpnK0maG; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a1307438ddso5736496e87.1
        for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2026 07:32:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773757933; cv=none;
        d=google.com; s=arc-20240605;
        b=RROa3OmAJ4rUsbksGSDngxeCiyBetWKlXU741XNzzLMWbMukYXOEzKZ+sbVjbIyAyG
         HEsqB0NxXvHkVR7KLJSJkdzeEm6EUboV7bz03Pp7o/aEZm2G51DVfsb2HVXVfWRxZu6D
         RkCmI69o67yW+PJ+ZxrdlPBflitNJrs5g8CGBCFNOysq5ffqr454JfK+PbMOQssekbh0
         9DD5d8by9bkgmJk71aqGjDO+Yjix8RLlqbXE1L0Va/YxE8amGw0uDZAMLbYrjoBfqO17
         4E3HNDmB1r17TuovfEgYQNvPsSyTcpYbocmjUHxN4Drv93qFB4unF5WYvDbYgc0QcDRG
         8kvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gBaOM0il2x8LAWwHnZzzl+t5G0wyiJqAlKJyL4cOf8A=;
        fh=a55ICUG4vwn8LlPN967LJRDUjtdnqlJ+ikiifwlTvik=;
        b=ODpQwSnf8gXoJpfdeq6qx/kL1+tdRgoZQ5Qh1aE4wsGSvtzW2E8a+d/za4COsHdIIy
         mHscQiGT4tji9hdHOPc5bcvORHZI8YfvJ6Cb/KJ8/xch1lvDLhebxby2CwGXZ69NaiQ3
         t/7w+lFojwmPEdT/mbuFXa7nvdISDegHYaNR87sd7IzJxA0cWAwd3Gbeopdbqc6SmB+M
         no6ZYTRg0m+dHvRsjPOP5NI4FOBh+binzaVtJflzXTmjYwHfHYUGdkY77u9pDKp/G7zb
         dhh/Nvl/PQxHk3IkeH3D/RzSXkCq7iRlnB2D+9V2Oy51GAtxTNsHcnS2ccjtS3IajjmU
         N+Hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773757933; x=1774362733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBaOM0il2x8LAWwHnZzzl+t5G0wyiJqAlKJyL4cOf8A=;
        b=HpnK0maG3x7Lpfb6D6TFqJLPBQ2o/nW1GVns4wyDHj5XH+wsv5MauccX1dxowwlMT6
         ft5yIQLuLLqUpKPNU8yc97OD2n+UjG0S70CZtwyJfpYPbTuiED0rWEnS2jTEpaxWkqdI
         P1ZLRYGXBR/lcqRAnQI5FOzbSZPZL6j+MD53xlRRCKEI2TTii5ZpR5FYwIYzoQk/OqV/
         Fqxa7vjYHcvBI6Nbdz8bNs45isMoLxk7oIT/BbGau6C806dkpFkWmCEPBAYPKKViBASU
         NE+275V3d7Ad4BTdSTQtcpMJGz5pyp1KeVglyso0APfmOKrUzLXgGitUsaXsPJSutBZg
         waWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773757933; x=1774362733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gBaOM0il2x8LAWwHnZzzl+t5G0wyiJqAlKJyL4cOf8A=;
        b=eDWO6VY3ahGK5lf8KMrir2VYDnjnIh4kQkgokShkRIobLSJTPXde1tgkYBXtNB2dJ8
         wdKEnv6d+BksGIUKxWlMMSnXO975m3V/P5+IkInxnPd6zAHVhx6DtqC4LfwrjmALTQ8b
         q/DtcRA0GSJFfFfphModnlsagHLvJBKOX7SDGqYcWaWdaNaWjPIB6zA1uMHpxKy0Wk+9
         BDZ5lOIv6KU9Ma8/+tAs8Qo/wYy4sB+sUEBLEClwqGqGJzbPEkQ1+Yj7bsyGfnbYhMKo
         42ID7YTDXXeByPA1gqQq6awJYGgYViAxPsPlL9kT9eWaTnF4da8bz14aEOfHhuqTC3HC
         ogBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoAoWAOdEA9d3GF7TCshpk+8BKhnJ1kHvyIwaZlfp90FMzOaOeLtyOqxjkMD1msAcim7ot/6jKmXz6@vger.kernel.org
X-Gm-Message-State: AOJu0YzPOYmycrODEnF54HBJwFkzK6oxwvXAuh/Yj1+he/Gas9N0wlOH
	2mOV9nbLotRqgnWnj38kRuxNwhiIeDbDS2CmgFbioQ+b+SN01l21Pp2256Lc0RPeR3JVuKc7sT4
	NrOaE6ZBEMRoRyzwV6Wvel4jZEQGHcIGq6hEr3alwYQ==
X-Gm-Gg: ATEYQzwJar8jbgtSQGIHujyK9RWa8hg3qVeQ4t2ph/KwXCRkJJ9ee1Gpl6kBRoarylV
	7Qoz0OYx+l4foEJIa2FWkcikQzYUaTlCYA4a1USJZrPMrJFkvla80d/pKzWP4Fg+gSiHgHIbZ9n
	BZU3n5EWohJaIbzV581M9bNncFFcNJ/Pfg0Ie8dyAVLGd0njPZyWO/B9lPQbyLuEspFFXyP9K1D
	SZO8Rjd6evk4CeUQCpeD3bu+RH+09ZQ2akiRDmDVojpeDpuKEv2khZfI09+YX9mTWxr/AtYwLm8
	/uhsfzXEcsLIxb5h4FXcZKzOMBnHh64WDyDoh+uJ
X-Received: by 2002:a2e:a983:0:b0:38a:f5a6:9181 with SMTP id
 38308e7fff4ca-38af5a6a249mr8967291fa.26.1773757932807; Tue, 17 Mar 2026
 07:32:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313154023.298325-1-marco.crivellari@suse.com> <20260316201301.GL61385@unreal>
In-Reply-To: <20260316201301.GL61385@unreal>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 17 Mar 2026 15:32:01 +0100
X-Gm-Features: AaiRm52Q5Dew1K65-nP7x89xuUIW-PguecWKwAOwcoFLmjLaKISMUG0hxShgPZA
Message-ID: <CAAofZF61VPo8VAX8zXUZnY-ydDYAR0N0mN2egaeTzXbiaKQbDw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linutronix.de,suse.com,ziepe.ca];
	TAGGED_FROM(0.00)[bounces-18261-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC6902AC371
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 9:13=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
> [...]
> I recall earlier efforts to replace system workqueues with per=E2=80=91dr=
iver queues,
> because unloading a driver forces a flush of the entire system workqueue,
> which is undesirable for overall system behavior.
>
> Wouldn't it be better to introduce a local workqueue here and use that in=
stead?
>
> Thanks

Hi,

There is only this wq here. But we can do so if needed, no problem.

Where do you think is the most appropriate place for the workqueue struct
declaration? Like `struct prefetch_mr_work` maybe?

Do you have suggestions for an appropriate place to allocate the workqueue?

Thanks!

--=20

Marco Crivellari

L3 Support Engineer

