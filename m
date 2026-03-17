Return-Path: <linux-rdma+bounces-18266-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIh4GwGCuWmxHAIAu9opvQ
	(envelope-from <linux-rdma+bounces-18266-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 17:32:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0EC2AE050
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 17:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55A3630BC598
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 16:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6278A3161A1;
	Tue, 17 Mar 2026 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvMKgq9d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FBB31327F;
	Tue, 17 Mar 2026 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764677; cv=none; b=ed351LE5HW10mZuH4pg3vXRFoUUbXH4QMSmxXQmL56HxmJY/7wPGftyrU/WBZJVV/EmpCp+Eg7dPtfDqGtM3X+amDYQNCSBGGIXkX1RsslMoIO7DNP5ber3HFFsuvB0ntSR/K982yUVhhwg8FGLHgtOpb4os2c/AGMz1NDkTv8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764677; c=relaxed/simple;
	bh=tg2TDiviKq7wj8EPRzpo5HT6fVsd7jc9gd/Lg9snXsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phxh/cTb44JV/CLhs+TaPjHmqaB98aH6DI2NnFbaZGZbppM5b43k2jmcxXl59uIWJo5IpKJG2lZnx76kfqcV7JZ4FGeGavPzHO9VnPRcqIVakMDSZNRMDXVK/zNDUMRRMoMT0pyr6IeXYxzWU02DyeZBqHc+sm5QLr0yZzMEp9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvMKgq9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D393C4CEF7;
	Tue, 17 Mar 2026 16:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773764677;
	bh=tg2TDiviKq7wj8EPRzpo5HT6fVsd7jc9gd/Lg9snXsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DvMKgq9dg5W8kF+CbgBRS+bDocU2RvPIvnS7+K7RI9XzIISbLFKWMi2r+JLPDLOwE
	 1iQa/Qy4RcWSA0HM5wp0igeECQxAd8Eh82fUR5fSA2fsgUXtBomEc4P25U77Fkji+0
	 5q8F7BI8YnP5n00zKw7xeT1dipYkTRSBXL0oKFShOhW5NG9a6UR2MuWHmtuSaTMWTq
	 7bIn8QVKj2cLcEPxvm+Vs1WajgMX2gKPsEZVFOfyx9PGWaINtlYfdwMWD4E5bFfx+L
	 cYh4vLt6DAeghiEVpXMgBgR7LTVNboJ068ha4+XReY1dpIBbvCucBL4sqWk9eE8sYc
	 BYEIH26mCDWdw==
Date: Tue, 17 Mar 2026 18:24:29 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] RDMA/rxe: Replace use of system_unbound_wq with
 system_dfl_wq
Message-ID: <20260317162429.GA61385@unreal>
References: <20260313154023.298325-1-marco.crivellari@suse.com>
 <20260316201301.GL61385@unreal>
 <CAAofZF61VPo8VAX8zXUZnY-ydDYAR0N0mN2egaeTzXbiaKQbDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAofZF61VPo8VAX8zXUZnY-ydDYAR0N0mN2egaeTzXbiaKQbDw@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linutronix.de,suse.com,ziepe.ca];
	TAGGED_FROM(0.00)[bounces-18266-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D0EC2AE050
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 03:32:01PM +0100, Marco Crivellari wrote:
> On Mon, Mar 16, 2026 at 9:13 PM Leon Romanovsky <leon@kernel.org> wrote:
> > [...]
> > I recall earlier efforts to replace system workqueues with per‑driver queues,
> > because unloading a driver forces a flush of the entire system workqueue,
> > which is undesirable for overall system behavior.
> >
> > Wouldn't it be better to introduce a local workqueue here and use that instead?
> >
> > Thanks
> 
> Hi,
> 
> There is only this wq here. But we can do so if needed, no problem.
> 
> Where do you think is the most appropriate place for the workqueue struct
> declaration? Like `struct prefetch_mr_work` maybe?
> 
> Do you have suggestions for an appropriate place to allocate the workqueue?

Actually, RXE already have one workqueue in rxe_alloc_wq(), just use it.

Thanks

> 
> Thanks!
> 
> -- 
> 
> Marco Crivellari
> 
> L3 Support Engineer

