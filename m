Return-Path: <linux-rdma+bounces-3890-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674799336E2
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2024 08:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984A01C211BC
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2024 06:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4853E13ACC;
	Wed, 17 Jul 2024 06:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwQ4loqR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052F714A8F;
	Wed, 17 Jul 2024 06:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197382; cv=none; b=ocCNPipGcAyrfqeBbcp/tRsdXryKpG9V8ahPRmdC82CoUUcn/lv7pBadbd6OlNCSfS7k6mjkmrUxI9lDLpwKgCFeaUm8WP2GeZ+t9Ho6g3Fgf4Gkf7tArrI8hSsuha8u4ejJoFkzoWIW06rLvFkE18TXjhluMmDcWk3Oo3Lz5N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197382; c=relaxed/simple;
	bh=wE03A0Zwu1xnxWFNkSN/D+C35LB9BhEsjDtPFTlUifM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/pkQ2PFw+nPOBQJT015qTPz90YYM/vmZIaPt5AkKXZAXKcaJEzDlZ2fyYrVy5EXfHP7BsNQ9g/J5mgKAUbQ5dBamR/bcDsiPhLFJ4D0YIR4LtGwdMS7a9qL1SdKN1W7oWmTacEYWlLBQBGD/F844w8DCzeQe+S5+HDHIyDoTTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwQ4loqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964D0C32782;
	Wed, 17 Jul 2024 06:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721197381;
	bh=wE03A0Zwu1xnxWFNkSN/D+C35LB9BhEsjDtPFTlUifM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SwQ4loqRovk4AIyvlTDFzFYNJemGN2Txum8WP7nZ0rYHMrbJHdPKCM0iJ27jSDbSs
	 OA3R//h/LyCef7W452F9jt6eBuIZCNBN8Oz20MGxpb7trGsNJ6dm3zku+p8j2ighJ2
	 AjLzOM3rrnjmnYughmgHG8R7VqEAJBtRzxRO7eYJsCRSHilIN1cfV4JM2YUwZHQSb1
	 YuFNWBzs+rulm4zxCqvr3fN3wsCP5yvgBTinHswRU9D+Ez4sVXnXJkVf+c+pDA42Zl
	 GnLIZo8dYpjwKso8phzSKDFgEr1ZH0sTmzhhmETTHuolTNPYXYrXVwy20sJ+mK3OPu
	 IS3Pmzn7D8CnQ==
Date: Wed, 17 Jul 2024 09:22:50 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	Wei Hu <weh@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH rdma-next 1/1] RDMA/mana_ib: indicate that
 inline data is not supported
Message-ID: <20240717062250.GE5630@unreal>
References: <1721126889-22770-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240716111441.GB5630@unreal>
 <PAXPR83MB0559406ED7CCDAFC0CAEC63DB4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240716142223.GC5630@unreal>
 <PAXPR83MB05595BBC92EB695753EB8563B4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240716170608.GD5630@unreal>
 <PAXPR83MB0559D97004241D37765A151DB4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR83MB0559D97004241D37765A151DB4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>

On Tue, Jul 16, 2024 at 05:25:22PM +0000, Konstantin Taranov wrote:
> > 
> > Yes, you are. If user asked for specific functionality (max_inline_data != 0) and
> > your device doesn't support it, you should return an error.
> > 
> > pvrdma, mlx4 and rvt are not good examples, they should return an error as
> > well, but because of being legacy code, we won't change them.
> > 
> > Thanks
> > 
> 
> I see. So I guess we can return a larger value, but not smaller. Right?
> I will send v2 that fails QP creation then.
> 
> In this case, may I submit a patch to rdma-core that queries device caps before
> trying to create a qp in rdma_client.c and rdma_server.c? As that code violates
> what you described.

Let's ask Jason, why is that? Do we allow to ignore max_inline_data?

librdmacm/examples/rdma_client.c
  63         memset(&attr, 0, sizeof attr);
  64         attr.cap.max_send_wr = attr.cap.max_recv_wr = 1;
  65         attr.cap.max_send_sge = attr.cap.max_recv_sge = 1;
  66         attr.cap.max_inline_data = 16;
  67         attr.qp_context = id;
  68         attr.sq_sig_all = 1;
  69         ret = rdma_create_ep(&id, res, NULL, &attr);
  70         // Check to see if we got inline data allowed or not
  71         if (attr.cap.max_inline_data >= 16)
  72                 send_flags = IBV_SEND_INLINE;
  73         else
  74                 printf("rdma_client: device doesn't support IBV_SEND_INLINE, "
  75                        "using sge sends\n");

> 
> Thanks
> 
>  
> 

