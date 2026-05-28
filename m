Return-Path: <linux-rdma+bounces-21417-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEviLNPmF2rBUwgAu9opvQ
	(envelope-from <linux-rdma+bounces-21417-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 08:55:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFE25ED6B8
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 08:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FB5D3051D0A
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 06:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BD6344D82;
	Thu, 28 May 2026 06:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pOiNYrR2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E98C34041B;
	Thu, 28 May 2026 06:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779951305; cv=none; b=nN4It4wuntl6e4kzdeqFVtS9R1/XAIE1gU/YgLeUPfU6ecE0GDqMqBmA07KX5ePKa9vEm+WyvTm2ogDBW3GJ2JUDQc5LAlXI8Yuop0nz8RfaA67HdcnJqcFzi6SzA+vyhzceige/WkfuoAyn/6IqFCfsvwttlesUPAyQ/hDKNCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779951305; c=relaxed/simple;
	bh=u1DU5peFjSpRs6URdH7VcoG3ZkB9cx4wETsWbSJ3f+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OtVqBALLpdgzkX708+NI2LpjYOxigwAAOr152s8zO9MHu2IKrWVugVfRinMrUTdQCKsME2TTul9LjUD8KdRt8BoDxKiVjVxDvBop09XPxMmdfefp7MuykhuOGsbmIJkv5sLN/lMAoZhPAftiu5QjhylS60K3l4Jmgj3yDHwDr9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pOiNYrR2; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=dCg2jGDEX/uzVvST27JPh8tpYxI19P9jX5fkafhRajU=;
	b=pOiNYrR2g0XCxfWA6ijQM9hDyX+3UowOu8qPCreIANEDSfoLxweXqQuwn+MkzZ
	aQJlOUK6OxkekqNVxpI52UhW/yyXNHmrl4P0s3yMX7TEImhuH4cCNjXvVQ7oXWiE
	70xPkzkFF6qaUmgx7vyr5G4gOqGJgFaZRSk03lyc3SSE8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3R+Gr5hdqH9IuAA--.9510S2;
	Thu, 28 May 2026 14:54:37 +0800 (CST)
From: luoqing <l1138897701@163.com>
To: jgg@ziepe.ca
Cc: kees@kernel.org,
	l1138897701@163.com,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	luoqing@kylinos.cn,
	markzhang@nvidia.com
Subject: Re: [PATCH] rdma: infiniband: Added __alloc_cq request value Return value non-zero value determination
Date: Thu, 28 May 2026 14:54:35 +0800
Message-Id: <20260528065435.1269299-1-l1138897701@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260526122329.GC2487554@ziepe.ca>
References: <20260526122329.GC2487554@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3R+Gr5hdqH9IuAA--.9510S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr4xKw1fWFWUuFy8KryUJrb_yoW5KrW5pr
	ZxJ3WjyFyktF1xGwn7ta1v9FySqw4fWryUGF90934Durs0qr1Dt3ZxKF1Y9Fy7Cr4rGw1j
	qr1jvr15u34qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUHmhOUUUUU=
X-CM-SenderInfo: jorrjmiyzxliqr6rljoofrz/xtbC3g1FiWoX5q12tQAA3q
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,163.com,vger.kernel.org,kylinos.cn,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21417-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[l1138897701@163.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[163.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Queue-Id: 0BFE25ED6B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 09:23:29AM -0300, Jason Gunthorpe wrote:
> On Tue, May 26, 2026 at 05:18:16PM +0800, luoqing wrote:
> > From: luoqing <luoqing@kylinos.cn>
> > 
> > Currently, when __alloc_cq allocates memory for an InfiniBand Completion Queue (ib_cq) object,
> > it uses memory allocation functions that may not guarantee zero-initialization under certain error paths or memory pressure conditions.
> > If the allocated ib_cq object contains non-zero garbage data due to incomplete initialization,
> > the function may return a non-NULL pointer even though the object is not in a valid state. This can lead to undefined behavior,
> > memory corruption, and potential kernel crashes when the driver subsequently accesses uninitialized fields.
> > 
> > This patch adds explicit validation to ensure that the allocated ib_cq object is properly zeroed before being considered valid.
> > If the object fails the zero-check (i.e., contains non-zero bytes beyond expected initialized fields),
> > the function returns an error code (e.g., -ENOMEM or -EINVAL), logs a warning message, and prevents further usage of the corrupted CQ.
> > 
> > Signed-off-by: luoqing <luoqing@kylinos.cn>
> > ---
> >  drivers/infiniband/core/cq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> > index 3d7b6cddd131..756bc33c850d 100644
> > --- a/drivers/infiniband/core/cq.c
> > +++ b/drivers/infiniband/core/cq.c
> > @@ -224,7 +224,7 @@ struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private, int nr_cqe,
> >  		return ERR_PTR(-EINVAL);
> >  
> >  	cq = rdma_zalloc_drv_obj(dev, ib_cq);
> > -	if (!cq)
> > +	if (unlikely(ZERO_OR_NULL_PTR(cq)))
> >  		return ERR_PTR(ret);
> 
> Wow, this entire report is unintelligible.
> 
> ZERO_OR_NULL_PTR() has nothing to do with the memory contents.
> 
> Jason

Hi Jason,

Thank you for your quick response, and sorry for the confusion in my previous explanation.
Let me try to restate the issue more clearly.

In __ib_alloc_cq(), we allocate an ib_cq object using rdma_zalloc_drv_obj(), which is supposed to return zero-initialized memory.
However, when rdma_zalloc_drv_obj() returns ZERO_SIZE_PTR ((void *)16), the current code only checks !cq and treats it as a successful allocation (non-NULL).
This happens when the allocation size is zero — a condition that might not be properly validated in some driver registration paths.

If a driver inadvertently registers with an incomplete or zero-sized object requirement, cq becomes ZERO_SIZE_PTR, not NULL.
Later, when the kernel tries to use this CQ (e.g., initializing fields), it may access invalid memory, leading to a kernel crash or memory corruption.

Although this is fundamentally a driver registration issue (drivers should specify correct sizes), adding an extra defensive check in __ib_alloc_cq() — like ZERO_OR_NULL_PTR(cq) — would:

Prevent crashes caused by incomplete driver initialization

Add no meaningful overhead

Improve kernel robustness, especially for out-of-tree or legacy drivers

I understand that ZERO_OR_NULL_PTR is not about memory contents, but about the special zero-size pointer case.
In this context, it acts as a safeguard against a specific class of programming error.

Would you accept a patch that replaces !cq with ZERO_OR_NULL_PTR(cq) (or an explicit if (IS_ERR_OR_NULL(cq))) to cover this corner case?

Thanks for your patience and guidance.

Best regards,

luoqing


