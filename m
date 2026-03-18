Return-Path: <linux-rdma+bounces-18319-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLPpIUm9ummqbQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18319-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 15:57:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D1A2BDAA1
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 15:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF534311050D
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 14:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B503DEFFF;
	Wed, 18 Mar 2026 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MvQ4gbGY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02DC3DEAE0
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845261; cv=none; b=kXIiX/PQhC1C64zeZHIJtyJ0dAiRuLeELdnMKhMexrHryEOF86TgpIBFPptVrHbbUy3N4Tg1BJ13ctN/v5UFvgopYWbtDzdcaQaCJsarevAJhyKdZe/DOprjUhOIC0plDQWGUzFY67DXNvp13i0rlrt4c4P1D8JYFBh1PFVw8q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845261; c=relaxed/simple;
	bh=g20IlxnyFB5ur1iWCZoqo6T8/IypSiEk3ILIh7oEDT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FrPiBZDkXX7b8+bPe6tJV+HdrN9XPz1eWoFbGZM/h8BKGV4hso2QTrlF/S5EOesqFoHmhyjHansdsXYEXuO4zCo5oQxeAlns3c2rsU5kwTSeE3opYE+diKmMgXhwnQ2HrEHyAph/9Hp1tU6IMw2ScvjlSgt+xxNFe5OyHaoGVEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MvQ4gbGY; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <51303177-9a94-4525-9da1-19402ae31c7f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773845256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LX7n7LmTnumw/UXvQNiBiI5k0zJwPGwfnsGE8K8wimU=;
	b=MvQ4gbGYQnd0FffPgph9cAdhXWH1FvmEIPMgkMx6UCEoOrywNfzH7sdNp2Pg0/2n4gM7qf
	zux0gReOuMWoa6DCUK+o5yeBEaQm+FcylQ2FSqpb5vZMnnj9BUNoCn2eMc/QiTSgbHKBRo
	D63q/JmcmGTBOfZYLNoyuUWr9tTYZ1M=
Date: Wed, 18 Mar 2026 07:47:29 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Replace use of system_unbound_wq with
 system_dfl_wq
To: Marco Crivellari <marco.crivellari@suse.com>,
 Leon Romanovsky <leon@kernel.org>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20260313154023.298325-1-marco.crivellari@suse.com>
 <20260316201301.GL61385@unreal>
 <CAAofZF61VPo8VAX8zXUZnY-ydDYAR0N0mN2egaeTzXbiaKQbDw@mail.gmail.com>
 <20260317162429.GA61385@unreal>
 <CAAofZF4jW2hD+UsBG8w3zYPeGGaHeSx0tSY2Prd2dXLLBkaf1g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CAAofZF4jW2hD+UsBG8w3zYPeGGaHeSx0tSY2Prd2dXLLBkaf1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linutronix.de,suse.com,ziepe.ca];
	TAGGED_FROM(0.00)[bounces-18319-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 02D1A2BDAA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

在 2026/3/18 5:20, Marco Crivellari 写道:
> On Tue, Mar 17, 2026 at 5:24 PM Leon Romanovsky <leon@kernel.org> wrote:
>> [...]
>>
>> Actually, RXE already have one workqueue in rxe_alloc_wq(), just use it.
> 
> Hi Leon,
> 
> I noticed the workqueue is declared as static into a C file. So I
> changed it a bit, tell me if
> it's not the right approach.
> You can see the diff below:
> 
> ---
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
> index ff8cd53f5f28..c56bae376c7f 100644
> --- a/drivers/infiniband/sw/rxe/rxe.h
> +++ b/drivers/infiniband/sw/rxe/rxe.h
> @@ -121,4 +121,6 @@ void rxe_port_up(struct rxe_dev *rxe);
> void rxe_port_down(struct rxe_dev *rxe);
> void rxe_set_port_state(struct rxe_dev *rxe);
> 
> +extern struct workqueue_struct *rxe_wq;
Hi, Marco

https://patchwork.kernel.org/project/linux-rdma/patch/20260318025739.5058-1-yanjun.zhu@linux.dev/

Please see the above link. A fix has already been ready for this problem.

Zhu Yanjun

> +
> #endif /* RXE_H */
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c
> b/drivers/infiniband/sw/rxe/rxe_odp.c
> index d440c8cbaea5..ff904d5e54a7 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -545,7 +545,7 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
>                 work->frags[i].mr = mr;
>         }
> 
> -       queue_work(system_dfl_wq, &work->work);
> +       queue_work(rxe_wq, &work->work);
> 
>         return 0;
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c
> b/drivers/infiniband/sw/rxe/rxe_task.c
> index f522820b950c..801d06c969c9 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.c
> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> @@ -6,7 +6,7 @@
> 
> #include "rxe.h"
> 
> -static struct workqueue_struct *rxe_wq;
> +struct workqueue_struct *rxe_wq;
> 
> int rxe_alloc_wq(void)
> {
> 
> ---
> 
> Thanks!
> 


