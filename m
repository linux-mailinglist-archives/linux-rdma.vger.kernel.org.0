Return-Path: <linux-rdma+bounces-2173-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4E18B7AAA
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 16:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE497B24800
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 14:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222C47710F;
	Tue, 30 Apr 2024 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnRYaDqu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D334B770F0;
	Tue, 30 Apr 2024 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488935; cv=none; b=Hutin9EBq+15js2UpNBySCq6wpvkyG2GC5PGDz0WZbBz9sgsF6YQumZvrWP6vibnyLtBNRcjTG2XkoQa56eBuzTOC2jUJ7ilvMn09Au0qobb5QEhJ2F3/gnnHG9Op+HTDXpb+p0wPvLPlton6VELNZAcWw9sexmGokB6OWrEpFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488935; c=relaxed/simple;
	bh=LbxazFNKPGjXRCPe1IyWjuxFW/SlZaB4365pwSAW8+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=faLYB2BcRqSQjod/46zjeSXoPxz4sK20pfVTL6x88sVTXyP70gext+mrFPkQka7A0Mob+x2xB3OpIlD4LrtW0VhyoUVfNoeBjfie6faBm/0byx17CUp4tkboCtLcfSgDuTbkFvz9yaTaRjNM/fvKYPW79YqSJy/KvOMo8pCjCA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnRYaDqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DF5C2BBFC;
	Tue, 30 Apr 2024 14:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714488935;
	bh=LbxazFNKPGjXRCPe1IyWjuxFW/SlZaB4365pwSAW8+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KnRYaDquIH5vCbfYChkYJBhK1EZaWADduXl6Fg7XQLgeRQDK/cJmD1VqaKVJTbcMM
	 oQ34qgZNxYt9INylKudmTRmO41ojDM46nhRptIl0tgp/AwPF5gwdqNZz7tHKSyE1Ig
	 ylhaTfVaDJylpvr9VHdoWRHGeqX0f1Hjq+bQlJsQ6YsRISjex84gFr2+sigBQaJWbz
	 jEQ21N90yRRqtdoNd2ouQ1FYldOwaZXTOrGPVm6C9r1HzShWy/kmvb6ZZXpurNvQtR
	 82J+xC2wnR9rELh7cX8DzzhiIctjmKj6XqtRAj5f2KQbHxlLVpoGkZqBbFqqgvnTA7
	 c/1fUGisE/KEg==
Date: Tue, 30 Apr 2024 07:55:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Leon Romanovsky <leon@kernel.org>, Dennis Dalessandro
 <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, linux-netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] IB/hfi1: allocate dummy net_device dynamically
Message-ID: <20240430075534.435a686e@kernel.org>
In-Reply-To: <20240430141039.GH100414@unreal>
References: <20240426085606.1801741-1-leitao@debian.org>
	<20240430125047.GE100414@unreal>
	<49973089-1e5e-48a2-9616-09cf8b8d5a7f@cornelisnetworks.com>
	<20240430141039.GH100414@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 17:10:39 +0300 Leon Romanovsky wrote:
> > Nothing right now. Should be safe to sent to net-next.  
> 
> Jakub, can you please take this patch?

We'll need a repost, it wasn't CCed to netdev.

