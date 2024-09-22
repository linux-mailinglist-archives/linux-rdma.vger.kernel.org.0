Return-Path: <linux-rdma+bounces-5039-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E832297E1F3
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Sep 2024 16:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8BD281554
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Sep 2024 14:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442B26AA7;
	Sun, 22 Sep 2024 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7FIZKiw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED08F2F43;
	Sun, 22 Sep 2024 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727014282; cv=none; b=Pdn7aXZnShsmnlb9SF9/OzPoKHo8m0qSQh7TlIer2UfB2X09sDbOQ+42LGR83o4h52rWddLR7IPI8xLN0P2+pmV4A6OwVl9zTssAkby2zXRQnE3ddbcXghPLt6w5CqFf/bllGO0Ld+gqc4v1bKvQ2KBqwD0Vupxd8hSGCBXHMsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727014282; c=relaxed/simple;
	bh=wAXsNMNFFHsAjUwVy2rvo29jltEyM8GR38+m9/8I4Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyjcZnl//smb72vwDbupWAAeY7myMrKa7R12LstSPbIb+yorclqG8d2RB1s/JW9hidg28brVhnveMuVZw8o5cP6EWxZl3Z3jstS27Bl+YR7Tyrp8VQ6h6JaFPlZYJC/p03P29JCXW8Ibz7tw+mqmhMrTJ6B06tKtw3RrYa78/3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7FIZKiw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A49C4CEC3;
	Sun, 22 Sep 2024 14:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727014281;
	bh=wAXsNMNFFHsAjUwVy2rvo29jltEyM8GR38+m9/8I4Ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7FIZKiwmWD/7d0Q5ZRBIyxiHEKzTIq6EgjJOFUIWB0icoab1X00AAg06hmh4IuW/
	 jjBiKOd5w5Sj2xOXbRLMHRO9le01mioUJdGk1K3bEtRtxP27e2OM8mSuIsRr2H3IY1
	 B05wpv1+oguKE3btkpBgZpwLuKmAuRN8RgancFNLIAT7edIudA7cS4jwwwGhsNKC7u
	 aJGcrIlb9VJCphPbBBhqE396wWJbhXI6nCw4NGpDVFArIhmzL8RTVfLzLmXZnm5L44
	 v3agXi4sRlxwFqsQjeblCwfyrf7M8GhZ2LoxdJySmVulQXXUV36ErRNZVx4OXdAj2p
	 bMpa8kikALGHA==
Date: Sun, 22 Sep 2024 17:11:10 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Christoph Hellwig <hch@infradead.org>,
	Haakon Bugge <haakon.bugge@oracle.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Allison Henderson <allison.henderson@oracle.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	OFED mailing list <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>
Subject: Re: [MAINLINE 0/2] Enable DIM for legacy ULPs and use it in RDS
Message-ID: <20240922141110.GC11337@unreal>
References: <20240918083552.77531-1-haakon.bugge@oracle.com>
 <Zuwyf0N_6E6Alx-H@infradead.org>
 <C00EA178-ED20-4D56-B6F2-200AC72F3A39@oracle.com>
 <Zu191hsvJmvBlJ4J@infradead.org>
 <525e9a31-31ee-4acf-a25c-8bf3a617283f@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <525e9a31-31ee-4acf-a25c-8bf3a617283f@linux.dev>

On Sat, Sep 21, 2024 at 10:28:48AM +0800, Zhu Yanjun wrote:
> 在 2024/9/20 21:51, Christoph Hellwig 写道:
> > On Fri, Sep 20, 2024 at 09:46:06AM +0000, Haakon Bugge wrote:
> > > > I would much prefer if you could move RDS off that horrible API finally
> > > > instead of investing more effort into it and making it more complicated.
> > > 
> > > ib_alloc_cq() and family does not support arming the CQ with the IB_CQ_SOLICITED flag, which RDS uses.
> > 
> > Then work on supporting it.  RDS and SMC are the only users, so one
> 
> Some other open source projects are also the users.

What are these projects? I see only RDS and SMC.

Thanks

> 
> Zhu Yanjun
> 
> > of the maintainers needs to drive it.
> > 
> 
> 

