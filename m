Return-Path: <linux-rdma+bounces-16728-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNw7INNli2kMUQAAu9opvQ
	(envelope-from <linux-rdma+bounces-16728-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 18:07:31 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2596111D92F
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 18:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63D793007481
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 17:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F0D32AADA;
	Tue, 10 Feb 2026 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fzkMOj7J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADED531B825
	for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770743249; cv=none; b=JEdDRHIibVOkd369ajKjED1+/On377vL6e2SwZBvJi4UliRQmCz6x2I5HqKgk+/pKGXChSzm0+49um/NNiBrNUU9jqpvb87ljtEWAuBV6W0R4HBKm59A9v96OsYEwBkuIuxzXeBNtunSb+YvS/jYYsUCHGyfnewz53B8Usv7O5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770743249; c=relaxed/simple;
	bh=w8OKb/jhDH9cfvR1kOjnoJjeyNkj7Gwp4LOD9+UpDik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/PNEOYQyfyCAJ+8r+7XklYgmlY0JyY2nDhz6/khhJASWOF9qSsuqzycyangI0vHMOB8qBgVddZCYSwbsSpSIrjvshQR2KXdxXsYPoOfEK7epr666mSa9LCFl9uYgtbe8SLitEajCgDWo+kN8TYv/FKzzGtVKBAkj3StvQ2E8II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fzkMOj7J; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c70ce93afaso115451385a.0
        for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 09:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770743246; x=1771348046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SrFwdmd4IfXDyiWUVqEsyPPbF0BmDkHpNfafw376now=;
        b=fzkMOj7JhKoDuQGA3CBqRmW+jWY/bgAm1118J0f/X1XhKqGBC/std1h0gWRCnl+A05
         lNaSMEgtNsqON9hofoh8sF3pHqmGNQatckZ4FKvS/pa3kLJsvx7BnCcTCAnbk4P4Rpda
         MuzUMJDbYYiPqf7kBuWBLbsSo7vkDjZoYnjB52QCREXvpfnyMpgcTGe3OkljmdkV/tk/
         lXX4FIyfX9L2hGocG9IlIUUIcLNEBiZ13zA6d/JfrLjLnTaWMfVQKL7sEyJFujDmPZvP
         HyoFf0ZsSw+bB3j605SsROSvHbwlR0WLdzh6HTHgNoYiXe9W0bDqw2gtsEoUswg3D7bD
         7Aig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770743246; x=1771348046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrFwdmd4IfXDyiWUVqEsyPPbF0BmDkHpNfafw376now=;
        b=Fg1jKJBdT0PNXHNJnM5S48aC9psqTBB+X63/WfAbDtBu5JIkVv+y52lqLNLPUykxHc
         UIZ2xkji0eJrhc/bWzkKPQdxp6bDV1s6KIfrxS59DyKj4RAF3GnFs+NgHv+UDWruUJaE
         LplEZl1EFR7Z6B5lzzPwCCqbR3vG/DQ5Dqj5VwKlWudANNHt0kDWfTjFlDSM4BLza6kk
         RTgYP9rIgxZfjV8zXbb/w+fvc+AvpLenepUuyiySWz5N0Q88UAdF/XnLVRZtoyYFoVW6
         qtphqaKI8QwkFAUsbMFthD9zflmkJrcxjMT64kDvqekEgpqy0BaOVL42aWWNupmTBkAD
         3AMw==
X-Forwarded-Encrypted: i=1; AJvYcCUYlJn5gp8P+QWik05YGMi4PkURM9EcJ16vKhiLv+H9nxiHUwRDqw4WWzwClKoIaJBv3H+S2dqDfiZR@vger.kernel.org
X-Gm-Message-State: AOJu0YzBdZkqqQKY0fZtNYW6dItPIGTEzYcfnfRzemEmuabo7y4KBict
	0h98JUOVThds7sqGdbQTRsUdAgm9KLUwWRhfj1fj1w9lJJNRQMbw23iuNNNYx1zk7Lg=
X-Gm-Gg: AZuq6aLjF6CU+R9vsnEbd0Zq4mriYQOXe8hbGjVWZULTqMgmV+7BckCGyv43kjV1E5D
	tDquqi1fdtqabO19DTsQNdwgM2RRU8eZ1GWfmBtmb+25lKIaLbTf0jNhRz3SvsbNGxFG3CqRjKI
	zfz2VYbs6blsjl+IPseYokEOOp1NArUfNsw9eaNaRu10NbG4MSOfU/+hM7n07q36Mtq4EGEwSF6
	GpAwer+murGLbX+gFXiheruH9xoqY3iKDE/cQmk5lkLWd6iVhHyfqT3Csa0dFkCz5ile8Bus1/H
	5OkGnROX8eTGUcod/nC6eqxlrmm5+xW0Wc7pg1kXadtEMIGg0mgxQJkaUtgoPZlwLFeTiWaaDdT
	7Vtg9/wzfWAhfN6a3XJ90Ahvmvcy+ClGlbOBJGMnC4uIlqY4qwLv3WleBqOKs1gNKFIl6Utztx/
	3X/jz+1QhtzULsBGhmhREvUxfV9zoCVJF2Hm8Li1BrL63t3XWDB4zIrTj5VMZTUU1KlXuqnBjOI
	vB6yJ4=
X-Received: by 2002:a05:620a:7084:b0:8c6:a5c7:a7ee with SMTP id af79cd13be357-8caf1acb618mr1963914385a.53.1770743246205;
        Tue, 10 Feb 2026 09:07:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9fdfa05sm1072666185a.46.2026.02.10.09.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 09:07:25 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vprCu-00000004Tbb-42E6;
	Tue, 10 Feb 2026 13:07:24 -0400
Date: Tue, 10 Feb 2026 13:07:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v10 5/6] RDMA/bnxt_re: Direct Verbs: Support CQ
 verbs
Message-ID: <20260210170724.GC750753@ziepe.ca>
References: <20260203050049.171026-1-sriharsha.basavapatna@broadcom.com>
 <20260203050049.171026-6-sriharsha.basavapatna@broadcom.com>
 <20260206142322.GF943673@ziepe.ca>
 <CAHHeUGVH6vfLz5JM7VGEve4FiEyERdARNai5E5nAfMgzx=A6rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHHeUGVH6vfLz5JM7VGEve4FiEyERdARNai5E5nAfMgzx=A6rA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16728-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 2596111D92F
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 10:35:06PM +0530, Sriharsha Basavapatna wrote:

> >   But this isn't great, what you should be doing is using
> >   ib_umem_find_best_pgsz() to compute hwq_attr->sginfo->pgsize based
> >   on what page sizes the physical HW actually supports. If it only
> >   supports 4K then all those assignments from PAGE_SIZE are wrong, it
> >   should be SZ_4K.
> Ack, this will be handled in create_cq() to make sure page size is set
> correctly.

Okay just put whatever fixing you do to the umem flow here in its own
patch, it is fully generic and applies to all CQ users.

Jason

