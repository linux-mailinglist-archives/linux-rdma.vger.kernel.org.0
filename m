Return-Path: <linux-rdma+bounces-3842-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 506D292F429
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2024 04:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B6A2814B6
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2024 02:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B9979D0;
	Fri, 12 Jul 2024 02:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DgtKMlG5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003D88827
	for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2024 02:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720752575; cv=none; b=W1aeE+wAwo2UqceBPpuhQhfjwdN0HgPKyTLdSgo7TChKgVXCACBzzuQKBWM2qmFplwnBkPjZjTi/Ld8s8fiO0gy6nJg9/yUqOiYOFtY0PmWFzdWPQqJES9uqB4Qtbq9MWnlH7X63cjCaBM6LOsBBoghFlcJxIL3NUTIKYSKa34g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720752575; c=relaxed/simple;
	bh=S57/KDq7P5Qt3wR3elqgGqliTx6bQ1P+tjGuNGv3hVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lx4wUcNSXMPK81wCB6dy/JjjzC5i+Ob1Qt2nKBOEfKq3rTENDj+ZhJgssnu7OcIxbSC+lenV1FwICSSO5KD9qr0Teji41p9Nasyp18NpyVhWMI/UWqUhKjrchX3oHO9I3F7HNcKfCPpXNf0i740uBptCIF+lxRyfcKeDECp/rHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DgtKMlG5; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=hpC7v1EFyxVgnyXWRHFU602gKIYNOFAAowQgLZKdJRw=;
	b=DgtKMlG53e4b8m3Qk4SIEJpO/3qqBpBZdsBPJWjtbhfoRGS0uD36wGFB/B+o4P
	beNtKcLQdQlpppJ+3eah+kLqzxjX2ZvbgQX/1Es2VbrHM1ugKLmEfC3WKDiqjbSU
	aSv7x7HevgrJ3+6xWKQlHykZXFeLZ06X1ldRsRkH4ZqtM=
Received: from localhost (unknown [125.33.20.250])
	by gzga-smtp-mta-g2-5 (Coremail) with SMTP id _____wDnDzfqmJBmKWHIAA--.747S2;
	Fri, 12 Jul 2024 10:46:02 +0800 (CST)
Date: Fri, 12 Jul 2024 10:46:02 +0800
From: Honggang LI <honggangli@163.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Greg Sword <gregsword0@gmail.com>, zyjzyj2000@gmail.com, jgg@ziepe.ca,
	leon@kernel.org, rpearsonhpe@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Restore tasklet call for rxe_cq.c
Message-ID: <ZpCY6qKbWC89Aj9w@fc39>
References: <20240711014006.11294-1-honggangli@163.com>
 <CAEz=Lcvxr4LRhesrWdrodMn2JAG32RzOKTPd=wh470tvH_rG6w@mail.gmail.com>
 <Zo-DSIrjIGavnuTD@fc39>
 <ebcebbc3-24c0-4a44-a08a-dc1ef2d1458b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebcebbc3-24c0-4a44-a08a-dc1ef2d1458b@linux.dev>
X-CM-TRANSID:_____wDnDzfqmJBmKWHIAA--.747S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw43Zw45Zw4UWryrJw4xJFb_yoWDZrXEgF
	Z8GFyjkrW2vw4UKryUKFs3XFsYg3y5Gry8J3y5GFy3Cry5A34DZr48Wr93uw1rX395CFyU
	u34avayv9r1q9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbVc_PUUUUU==
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/1tbiDxAaRWVOFLA+OAAAsJ

On Thu, Jul 11, 2024 at 03:46:24PM +0200, Zhu Yanjun wrote:
> Subject: Re: [PATCH] RDMA/rxe: Restore tasklet call for rxe_cq.c
> > 
> > > Please explain the deadlock in details.
> 
> I read the discussion carefully. I have the following:
> 1). This problem is not from RXE. It seems to be related with krping
> modules. As such, the root cause is not in RXE. It is not good to fix this
> problem in RXE.

Can't say it a problem in krping. As krping works over irdma/mlx5/siw.
The deadlock only happens with rxe.

> 
> 2). In the kernel upstream, tasklet is marked obsolete and has some design
> flaws. So replacing workqueue with tasklet in RXE does not keep up with the
> kernel upstream.
> 
> https://patchwork.kernel.org/project/linux-rdma/cover/20240621050525.3720069-1-allen.lkml@gmail.com/
> In this link, there are some work to replace tasklet with BH workqueue.
> As such, it is not good to replace workqueue with tasklet.

Yes, you are right. Tasklet is obsoleted. We need a better solution for
this issue. Please feel free to drop the patch.


