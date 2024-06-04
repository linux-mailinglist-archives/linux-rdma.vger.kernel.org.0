Return-Path: <linux-rdma+bounces-2823-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B338FB13A
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 13:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF9D2842B9
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 11:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F93414535F;
	Tue,  4 Jun 2024 11:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnTyLfnr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C58E1422D1;
	Tue,  4 Jun 2024 11:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717501120; cv=none; b=P9oxVr3cxnOPZqheftZGFyxt742I7iWBQpFBayAEIVWOUbgF7WTJfPKFkg2f3fv/4Fl0D7DjWXv9sFxGjfP5PU3m6NQUH9DYjd64/EBAQNxLa0NrL3ny2I0DUwDwaKhK086t/pAtR+jg83glgJEgwNdic7A1xcjWTfsMFXAG7Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717501120; c=relaxed/simple;
	bh=GtcAYrRqb6w1aZ+SFaBxNrVc7F5CbXLwhUVHHa87tRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=at32HhmYE+RHjSaXBqhlGncO4EECLveAkIqPinHSEyVVdgWNBrF8NC7Hs5pi8TfiTVzMoTF8JqfhdbSQrfe3wvqC1JSF8qSBTyIY9ZcG7nGIKrxMflkGAedof2oZCMEPw8vZwSZzhJk2CwOueLQ4KxyyTOdhikJYtapST6cfHc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnTyLfnr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5E9C4AF07;
	Tue,  4 Jun 2024 11:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717501119;
	bh=GtcAYrRqb6w1aZ+SFaBxNrVc7F5CbXLwhUVHHa87tRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CnTyLfnr4EboZbPq1pMFsHretWsJBnWnfbhKZSEmBqgwfjw+QRkLYDZAGSYk2RURT
	 tTewdlPn07ynKSBXtPkxIdO3KqLYYWDHDsAB8X+rDyTBV6z1Oh5AcMk3c6hf0a4uVY
	 iTgnsNcbkxm0EfAkXuWTyPyBe6NEGpCsyoYoiJA1mZkWNdW+pi9gAGr6QmWC1LpUge
	 Q0W6haGun23zoK5mqRVcIz2t1YMfLZXFvV2iG/DqO0s1zsRleaYM5puf++rVrMG6rJ
	 jxsV6qa+lYumBUFOgv33R/brUzyJB3sMnoNRqxsA4FDuAzDlkYVSj1KqE/6ORtIgGe
	 jKPQY3aQrC1Bg==
Date: Tue, 4 Jun 2024 14:38:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Hillf Danton <hdanton@sina.com>, Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH -rc] workqueue: Reimplement UAF fix to avoid lockdep
 worning
Message-ID: <20240604113834.GO3884@unreal>
References: <4c4f1fb769a609a61010cb6d884ab2841ef716d3.1716885172.git.leon@kernel.org>
 <ZljyqODpCD0_5-YD@slm.duckdns.org>
 <20240531034851.GF3884@unreal>
 <Zl4jPImmEeRuYQjz@slm.duckdns.org>
 <20240604105456.1668-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604105456.1668-1-hdanton@sina.com>

On Tue, Jun 04, 2024 at 06:54:56PM +0800, Hillf Danton wrote:
> On Tue, 4 Jun 2024 11:09:58 +0300 Leon Romanovsky <leon@kernel.org>
> > On Mon, Jun 03, 2024 at 10:10:36AM -1000, Tejun Heo wrote:
> > > 
> > > And KASAN is reporting use-after-free on a completely unrelated VFS object.
> > > I can't tell for sure from the logs alone but lockdep_register_key()
> > > iterates entries in the hashtable trying to find whether the key is a
> > > duplicate and it could be that that walk is triggering the use-after-free
> > > warning. If so, it doesn't really have much to do with workqueue. The
> > > corruption happened elsewhere and workqueue just happens to traverse the
> > > hashtable afterwards.
> > 
> > The problem is that revert of commit 643445531829
> > ("workqueue: Fix UAF report by KASAN in pwq_release_workfn()")
> > fixed these use-after-free reports.
> > 
> Given revert makes sense,

Thanks, it is very rare situation where call to flush/drain queue
(in our case kthread_flush_worker) in the middle of the allocation
flow can be correct. I can't remember any such case.

So even we don't fully understand the root cause, the reimplementation
is still valid and improves existing code.

Thanks

