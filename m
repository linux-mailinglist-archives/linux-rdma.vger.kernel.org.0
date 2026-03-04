Return-Path: <linux-rdma+bounces-17499-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNPkDFKSqGkLvwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17499-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 21:13:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7FA207789
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 21:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 129713044BAB
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 20:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BAF383C87;
	Wed,  4 Mar 2026 20:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hkxLvpfh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A5C382397
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 20:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772655115; cv=none; b=CvGtptm4Bpm75wvtjFxgYOKVvyXrf2gCJwXJjpoj0YUuYMhtjbjtVZLNJQa8/6DVAoHqNcRfZ1DDH5FA2cqii2Z5pye4RnmpeOKd04jCYA7YWJjXHrJ1tgslr79pezSD7l66SatOJp+CEe7jrE85FoxYqf8W0zuI/Q+/1fTLo0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772655115; c=relaxed/simple;
	bh=+Ny4QP+mfSTD9TfzS6LP717MbExjZQzaWip2PzBx8Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TieJsTEjb30+ywvy+x7xUT9MOB6RsNgG62ltnw1YxF6AZCP5l1YHMAmaGYLPS+gMCY7XOtvZ8dnsYZ7y5xXO+EJg/CM/BcedryJFYBaQXq1MxHcA3rQuwYpPwpL4cJUjb84eF8BLkexhm4bmgLiqFm1jecw/xHhFRkGtSo7/YK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hkxLvpfh; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cb40149037so750099485a.2
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2026 12:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772655112; x=1773259912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ny4QP+mfSTD9TfzS6LP717MbExjZQzaWip2PzBx8Rw=;
        b=hkxLvpfhuH/fIqBn1y2+H7WYWeGmjn3p9329bc9ZMQEXlqajhD8zjcsPy/UbEEEXIP
         5+O+c1OtvN6whhfIhVJBtBJFrODqfNdG/gBFoFYEGbGXCfyvF3sbSJGBv4j++qCeu+yP
         CMQiAg8s5OYSiu6SGa8X7c0zwhTQtB4o6WV8EyUuHFMMZLAySlLLxlnq7Ct/wo4R82BR
         4UJ74ejLrfBUdGSisY9oSwWkKvtO3yApB9SBPRliJuB2XwLAtNT5LTjpFrdL6Fn+eLez
         W9pyKyeoQQdqvJKlGAM+qpS1OaRG1zlkrWVmyVLb5QaZAvS0oFd7ZJZbTiQmdImrswgk
         YRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772655112; x=1773259912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ny4QP+mfSTD9TfzS6LP717MbExjZQzaWip2PzBx8Rw=;
        b=nc5uUbaDb8onNClpj/xWHIEvGMv903kh6FdFL/Lq/wG8zYYKKukhvE4engXF0+eqUK
         E7L+3X7/aiXYE9b05rkFFdTkja+D0VJk3o98yV1Km6eKr0pbHBIqO88OuxtiE+bBYIN7
         f7DfmW2stTh4Nv0R+2eFFqc048ZOHypSzUAgh7jDd9rUf+ny7SqVRt51dsEz3PH2ULfm
         kKfv6ysS8cns7nEhAQz5EhqXQnoHHXl8Zm6T6BPo8xgUW7Vf9/ankzgZBAas1t5fKquj
         mH43CnFkMFX9hEgNi9JdD2qF7NxBNPOYD42cu7i79kUl+sbGsmaaHJkMeUfGrvNGW2QS
         um/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPO7BwjtMhr+AZYMVVMcNJbjymbgzwmQLkLad7gOYV5Kcuj54kf+rxmEkSFs8V+Wg1dwA+U6pzL8Gr@vger.kernel.org
X-Gm-Message-State: AOJu0YyavXanNOLAw7KimtFwZfJ0zZdDcVrl/Mb38VyvqST74X0vFUrn
	Cv5+KTOeaCnuNCWsd7WNexGtIs6slyjGVaPa0b9qR50tIjQ/Lj0vNNR4giu2tRNHv64=
X-Gm-Gg: ATEYQzzqNQhSvzL/HuYOvovKNIIZqGO8JLfVke+SzslIOWwI0tfyeJY1ZdVp2kB7EwZ
	N1LfqSI6k6PR6iHVm5TEf27YtaNlxV4xXVOQHau0lFjwEukIpnw5Erx4jW4byYOqeQdER0fYxAH
	7WH0Kw+Z6QaN5SbNMoQjUUBPIL99xqRi6pRtRLl6LEMmWBmS98dg4M3bx8PwYkOLTHmo6cF7VQN
	Z20u7qObDIQiwMVWR9CXrh+HE6F4DPs7nmlVQymVM3AYXsHJ+gKtarL+8UpRwjZiMj8U4sdDl18
	/d5H6qCVOHgIDuWLZJ7XxnLDt4Pf5TZC99AtXvwGlLDcErba4Oldy/92huJVXhWX39/f0IGzTYa
	UaE2oiNEtZJPbsfoWgt/15eoQWQHsC3V8OuNHG3KPvkppnPuWZpxjETkRhutgrm5dUpQq1TxKCq
	mciY2w12rM02II7JHfpVaMwDhpl23OhC3GeCEt5hTlCVpSqT+XvdOgFJbUyRaLJnMHeGyxmLgv4
	QCd53FE
X-Received: by 2002:ac8:5f90:0:b0:504:3c8f:f9bf with SMTP id d75a77b69052e-508db413ccfmr43341111cf.74.1772655112470;
        Wed, 04 Mar 2026 12:11:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5075feb4db9sm110731301cf.22.2026.03.04.12.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 12:11:52 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vxsZT-00000005OXj-1UJX;
	Wed, 04 Mar 2026 16:11:51 -0400
Date: Wed, 4 Mar 2026 16:11:51 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
	mbloch@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, rama.nichanamatlu@oracle.com,
	manjunath.b.patil@oracle.com, anand.a.khoje@oracle.com
Subject: Re: [PATCH] net/mlx5: poll mlx5 eq during irq migration
Message-ID: <20260304201151.GI964116@ziepe.ca>
References: <20260304161704.910564-1-praveen.kannoju@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304161704.910564-1-praveen.kannoju@oracle.com>
X-Rspamd-Queue-Id: 6B7FA207789
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-17499-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 04:17:04PM +0000, Praveen Kumar Kannoju wrote:
> Interrupt lost scenario has been observed in multiple issues during IRQ
> migration due to cpu scaling activity. This further led to the presence of
> unhandled EQE's causing corresponding Mellanox transmission queues to
> become full and get timedout. This patch overcomes this situation by
> polling the EQ associated with the IRQ which undergoes migration, to
> recover any unhandled EQE's and keep the transmission uninterrupted from
> the corresponding queue.

What? This does not seem like something we should do like this.

IRQ migration is not supposed to loose interrupts, this seems like a
IRQ layer bug to me. If it is buggy and loosing interrupts it should
probably inject a spurious interrupt around these events so all
devices can be enjoy the bug fix.

Basically you need to explain with alot more detail why the IRQ was
lost, not just some hand wavey "migration something something"..

BTW there are known bugs in things like qemu that can loose interrupts
around changes to the MSI (and worse than that too), but I thought
they were all fixed now?

Jason

