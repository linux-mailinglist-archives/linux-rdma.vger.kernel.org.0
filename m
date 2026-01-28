Return-Path: <linux-rdma+bounces-16127-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CALVObjeeWnI0QEAu9opvQ
	(envelope-from <linux-rdma+bounces-16127-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 11:02:32 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ADF9F2B3
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 11:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF6033003834
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 10:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534B52C3257;
	Wed, 28 Jan 2026 10:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izLSfPGp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2A12C1598;
	Wed, 28 Jan 2026 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594550; cv=none; b=kNvPOs6aqoOZW88MZq8tQ5Uf9gijp23bKtMbP4UqqITjBWpKmsn6lCzrykOM64g+GMCaCU4LxHX+mq+EVJFqSJz+ex02jMlRLNRnnP/4/3pK0gbgv241sZDkUul+RTRhWJ21fz0GgnO0FMAnhZQfT+l4uczSh3Uj0G5B64jpWeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594550; c=relaxed/simple;
	bh=pSg0v6uq1jYl4MwZ6VPyaluvS7BIoOvbTX82TTqGaz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQesk0S44XmNMwIqGUxunSJNKYEIkjbPK0Olh1d1vGHZz6vs6wSP6NUC2FFLTMJsShbMoswbo8WpNqOheSeL4F/w8ZFL87p6V4kgNnbLQXlsM/rotSoKD6OpN4uAe6qkKnj5A3OwUfEwW0j53GcLfx68tteY8PNQqN+gXIAIMxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izLSfPGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EFAC4CEF1;
	Wed, 28 Jan 2026 10:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769594549;
	bh=pSg0v6uq1jYl4MwZ6VPyaluvS7BIoOvbTX82TTqGaz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=izLSfPGpEzYohaktn/srBW8ufGGQngsYf96hfXyLbAFimmf7r37Y+Xn0NTJ+M//mQ
	 sffUISi/EojsHEWD6DtUSHLugvHseaGRstp7j8H5fl1B8dQgAZfFcrleFOak35P7pU
	 73m2os2MpJNSFrnqh57eaoG4zvc67ZztpGoa6dJlHifr23OfD0pm71WG+6wwKLPweg
	 FepCpt+amLJZU5Ab9u/sCWDu4T7YqTWRLHDkj4tScEGXPMGo/z4abAHntdDtELZvYS
	 qX+lvSW/ZI+SeA4PUNO9kFe/O91S+Fi/WtWP/pluyTiHhk+1qLWRC0JwAdeVOJ9Ify
	 Zfg2L4EzhvQmQ==
Date: Wed, 28 Jan 2026 12:02:26 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>
Subject: Re: [PATCH] RDMA/rxe: Fix race condition in QP timer handlers
Message-ID: <20260128100226.GB12149@unreal>
References: <20260120074437.623018-1-lizhijian@fujitsu.com>
 <20260125140812.GE13967@unreal>
 <02afa3a2-42d1-48c2-a75e-0555e8803d65@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02afa3a2-42d1-48c2-a75e-0555e8803d65@fujitsu.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-16127-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,ziepe.ca];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fujitsu.com:email]
X-Rspamd-Queue-Id: 69ADF9F2B3
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 09:27:27AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 25/01/2026 22:08, Leon Romanovsky wrote:
> >> Ensure the QP's reference count is maintained and its validity is checked
> >> within the timer callbacks by adding calls to rxe_get(qp) and corresponding
> >> rxe_put(qp) after use.
> >>
> >> Signed-off-by: Li Zhijian<lizhijian@fujitsu.com>
> > Fixes line?
> 
> I believe the following `Fixes` tag is appropriate, as this commit introduced
> the WARN_ON that now triggers:
>   
> Fixes: d94671632572 ("RDMA/rxe: Rewrite rxe_task.c")
>   
> However, I'm not entirely certain if this race condition also existed
> before this commit, as it involved a significant rewrite.

Let's include the most recent fix. It is unlikely that anyone is still
running such an old version of RXE.

Thanks

> 
> Thanks
> Zhijian
> 
> > 
> > Thanks

