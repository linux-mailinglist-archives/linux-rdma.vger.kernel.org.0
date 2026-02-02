Return-Path: <linux-rdma+bounces-16373-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIhHHP/kgGleCAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16373-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 18:55:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF39CFD12
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 18:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B94BB3072DBB
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 17:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289BF385EE6;
	Mon,  2 Feb 2026 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="igZUMrAf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EF937AA8B
	for <linux-rdma@vger.kernel.org>; Mon,  2 Feb 2026 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770054529; cv=none; b=HoN+toC/I76pPanCpZmr1drR/VVOUijrFdjhN5We7xkNozxZuUvlyAJLwiWJ0JT4WX+psOR0MeDqKyHS1o1nfRWQH8RfPrhWKrdoBbsnszadSsCGn7Jr3066PWuJWCzZ2fQxbbSi7pJnFK6jUkuDEC5xsiBXyybSDl8ZaJe2Dug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770054529; c=relaxed/simple;
	bh=6dtaK4BNp5JBV2+EDfCfVk7Xlp2ophIrv+W7i2yKB1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vgikg5tbier7RwVzMq4BoASfAuuPflGKri1NUk670DGrADFvix/8/tstS4hE89ZgIR4X7SHc+5a5zqZsJTNh2M0aUY3h1zgQZ+Z3P7JrxdTXLQbZpljqpUpeHrDkQdODYhP6rLXMryrwCgqEKVv1yjvlqYAIBsKdcUT+6ejHLIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=igZUMrAf; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c6a50c17fdso501276985a.2
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 09:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770054527; x=1770659327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b+uct2bTH2yIpAa3f7B5xCyqGN9Xhx5LqsAQ6ESIFu8=;
        b=igZUMrAfAi4wTFyKTfEivlbUnJ2ZEDcm2wq4T3jJwphgHxaCMbRoVTR/Wgjb4K75Fu
         PEsKFtI8ChU6AFeZzmZtYIbtVbbkYYCl26Ccxf58c+nM17AlobuA9F9s6mFG6okvtS5z
         U4+JjSPuH5jumj0D7ObGULSmYk+wdl3DjMZFOQfxKTp01rdqs89b7ZN0um540/8AoeVx
         Lo9Ycx7yVH+Ssc60FMaZJUfyRJZ+kNTaYUVJ893tBkiVd859if0fitxt0quAhN7HpH5q
         EN8hWt9v5KEwgyoZgTQJVYQINFl8l8SEBfFLT5cNFYyf7zuYQEU2ozj/AGvgmY3wGpDv
         38dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770054527; x=1770659327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+uct2bTH2yIpAa3f7B5xCyqGN9Xhx5LqsAQ6ESIFu8=;
        b=PSzEI5Dvn9oj6KkpBKtELszVx8U97Z1BnjWamNGn1dO/LXhmTNQhsl0H3CWf5v7Frl
         Q1YIpA3fKQCXqwuzrGLcvuSZslzNJUpWsfDg0pI6dDLb6xYO9VW/vHLFTtDzACKFuK/0
         /CarFqNAzUfG6ikRTQ7fD6fJJbtlCV3HlQf+oh5rx5+3sNgyELhEazl4aIadi+QP1mHG
         Z4GFxG88NwZKSEIiCaFNe6dBuoMrtsPnBgRclwDAJmPwTEFht7otZlawuDtxq9f8dT4N
         isvZSRDKs9q2142FTKH1T28vjX1FVypa0V8vfkBK75s/05upO/ShoXiVwgnat0bIWmZl
         1Peg==
X-Forwarded-Encrypted: i=1; AJvYcCX6ZiDQZvK1/prAvYzxMXSa2Tj0GI3U9EjUYp16cbfi0GGVPaJwfQulJUVsgboKepf42phzq3zPICmX@vger.kernel.org
X-Gm-Message-State: AOJu0YwKT8or9O/u3UZUDkkPRkr2Mbqvz7hhoFXXUAqa6ZeTR63sVjGo
	HBUzDtk6d2toDTGTa/fqvxGD7Gcx6VQmcoQyKiZZXV76+P/K9BB2yK+Bn7SSZMBgEIE=
X-Gm-Gg: AZuq6aLd972DA+cpr37AGSEzfR1MK1pTOn7p015499+xA8wMIgi/7voRg2arEHxZNPF
	GuOXaJ6eKXdQOgyBrUYYf+E1g+xg1l9oEhk8n+cVrS1tnAO0V4pk27jAMt2Na+m3gd6gD58KSIk
	0RaKVTbKhYcA+Ab9xgHR7vNZLTqZbUVH0EEs6bTW3fcf4x9BB6uOZdP5QL6WziyjJuUzbxWktW2
	sBen9xy6nxM/3yVxUH5Hs7RBhgRhNQw1SgukXZNxm0Ys13SUZQoftuC+SZ4qORdek/jAab1aGJ5
	+7YEKrz7xRbIRyeqL5toiU6MPvcNb8SAIa1C8Jv/fGbDNanhmTm1ZQ1vNlQhZGoOqxWyaiVcf71
	9wCQJ9GaEwhU4CJmvtOt9sLq30jMr6FPFFREQY4sRixO/kC1Qwog8spu2egMfwRfVsvAa0OGKIO
	rRj4zknmTk/urzSnK3iDxMrkAvlDOTZMU4DjPOyUZdkQRxMkLgmUQP5a5Mc6tFJz5Ge9w=
X-Received: by 2002:a05:620a:31a4:b0:8c9:ea75:8d7a with SMTP id af79cd13be357-8c9eb341e77mr1613983485a.59.1770054527098;
        Mon, 02 Feb 2026 09:48:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c713580985sm1247525985a.8.2026.02.02.09.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 09:48:46 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vmy2X-0000000G5Bl-40hm;
	Mon, 02 Feb 2026 13:48:45 -0400
Date: Mon, 2 Feb 2026 13:48:45 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	Jiri Pirko <jiri@nvidia.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v9 5/5] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
Message-ID: <20260202174845.GK2328995@ziepe.ca>
References: <20260127103109.32163-1-sriharsha.basavapatna@broadcom.com>
 <20260127103109.32163-6-sriharsha.basavapatna@broadcom.com>
 <20260128153248.GK1641016@ziepe.ca>
 <CAHHeUGVLi8ZxK3qpJ+nk6DcDd8365fdru-vPmkKtF6k-P4FAcw@mail.gmail.com>
 <CAHHeUGVZCojAmjmqm7yPys2N2TYApPnbMN3dcb4dnWDL_sAA0g@mail.gmail.com>
 <20260128194253.GX1641016@ziepe.ca>
 <CAHHeUGUNzi3x5bAQeHKkMY2Mb3nE7eFJAVF=NHNXoQ3RRLGzcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHHeUGUNzi3x5bAQeHKkMY2Mb3nE7eFJAVF=NHNXoQ3RRLGzcw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-16373-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CCF39CFD12
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 07:49:29PM +0530, Sriharsha Basavapatna wrote:
> I have the revised patchset ready. Let me know how you want to proceed
> -  if I should send it out (without the uverbs kernel patch for QP
> umem) or if I should wait for the kernel patch and rebase it before
> sending.

How about change the Author on that patch to youself and some
co-developed & signed-off for Jiri and send it out, I'd at least like
to look at the other changes.

Jiri said he would send his series, there is still time I can stitch
something together.

Jason

