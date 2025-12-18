Return-Path: <linux-rdma+bounces-15075-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8472CCC96F
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 16:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A458D301BE94
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 15:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1E1340A63;
	Thu, 18 Dec 2025 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5Hlguoy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428B4285CB9;
	Thu, 18 Dec 2025 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073387; cv=none; b=rwNL9HPnp6O3MDSJkbitbCE0wM9hEnIu46tyxLMVQCaiLciMewQqqBc/kskrcTcyDTDeZji4gMfTi8Hu/PzGDTvgcUhs+i+qage/hHmyEqw8ozQRyXlnkS68ilfcRGsgv2YC6MD1PWuJ5As4UsiNKCjp8L3B4OGxy6BOl69/QsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073387; c=relaxed/simple;
	bh=GZll0z/En2rKdyHIaCAvdOkQU78HXLv1Q7anHBfqUf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHXht9JQWCFPUlncZ2+jJlRQBJMm6oKlAI2Ob6NWbrSbvE5fxOmVZzxFRE0KhK/EJPWYZUUmlqContuZ6Rv8+ge6+52yrXgMJUNjHPZpUa1bbY7vD4JjiSky4arV/tpVUjfpnldKjgWwTMU0MWYjzLvphn8CT/esL+TBz9Z96bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5Hlguoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66770C4CEFB;
	Thu, 18 Dec 2025 15:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766073386;
	bh=GZll0z/En2rKdyHIaCAvdOkQU78HXLv1Q7anHBfqUf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V5HlguoyJtHAX8xeX4vrFWcc25b42A0RjfqVhCzGzsOMBmGcfFs7LFm0HrZtVOFZ0
	 1lv2qhh9Ht1R72l1vxjpEp1U11aTPxJDeiNI2csNDs6XA9rMS55se+uUgZeWNSGJ1n
	 IsU4trjjR0SgNTG5yGL32N7lATSOJm86xZxLs03nZIFUTeaxytx86H+dmCc8Nninlc
	 MTwG7wPWBId2YC1qjM3kBs9ZIEGereqQK0uGmr2r0N5sVCtHn+wbv9JJykTFU2BpGk
	 7EcdkTOUYVBwKVwU5fUD0Mtk+ijOGlxL4v6LjKHmz0bvKrJhTaDgc4q+Ec1zVbQspj
	 SDBMnCqoZ7fAA==
Date: Thu, 18 Dec 2025 17:56:23 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <20251218155623.GC400630@unreal>
References: <aRKu5lNV04Sq82IG@kspp>
 <20251202181334.GA1162842@nvidia.com>
 <5ac954bb-ad4d-4b4c-b23b-47350b428404@linux.dev>
 <20251204130559.GA1219718@nvidia.com>
 <80620d09-8187-45b1-a490-07c52733ac21@linux.dev>
 <2191ee0f-a528-4187-ae5b-5aba18741701@linux.dev>
 <7e3a294f-5dc2-4e8c-aacc-0286c1592038@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e3a294f-5dc2-4e8c-aacc-0286c1592038@linux.dev>

On Sun, Dec 14, 2025 at 09:00:51PM -0800, Zhu Yanjun wrote:
> 
> 
> 在 2025/12/5 20:41, Zhu Yanjun 写道:
> > 
> > 
> > 在 2025/12/4 9:48, yanjun.zhu 写道:
> > > On 12/4/25 5:05 AM, Jason Gunthorpe wrote:
> > > > On Wed, Dec 03, 2025 at 09:08:45PM -0800, Zhu Yanjun wrote:
> > > > > >        unsigned int        res_head;
> > > > > >        unsigned int        res_tail;
> > > > > >        struct resp_res        *res;
> > > > > > +
> > > > > > +    /* SRQ only. srq_wqe.dma.sge is a flex array */
> > > > > > +    struct rxe_recv_wqe srq_wqe;
> > > > > 
> > > > > drivers/infiniband/sw/rxe/rxe_resp.c: In function get_srq_wqe:
> > > > > drivers/infiniband/sw/rxe/rxe_resp.c:289:41: error: struct
> > > > > rxe_recv_wqe has
> > > > > no member named wqe
> > > > >    289 |         qp->resp.wqe = &qp->resp.srq_wqe.wqe;
> > > > >        |                                         ^
> > > > 
> > > > I didn't try to fix all the typos, you will need to do that.
> > > 
> > > Exactly. I will fix this problem. This weekend, I will send out an
> > > official commit.
> > Hi, Jason
> > 
> > The followings are based on your commits and Leon's commits. And it can
> > pass the rdma-core tests.
> > 
> > I am not sure if this commit is good or not.
> 
> Hi, Jason && Leon
> 
> Any update? If this looks good to you, I will send out an official commit
> based on the following commit.

You are RXE maintainer, send the official patch.

Thanks

