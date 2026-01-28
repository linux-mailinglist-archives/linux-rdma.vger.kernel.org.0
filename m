Return-Path: <linux-rdma+bounces-16168-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB56Ny1Temnk5AEAu9opvQ
	(envelope-from <linux-rdma+bounces-16168-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 19:19:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A8AA7AF0
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 19:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54DFA311E575
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 18:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4933837105C;
	Wed, 28 Jan 2026 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="emuyim7T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D2F371066
	for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 18:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623986; cv=none; b=Cq1Rux2QNQF5k1k3eVch/W5ntRRMFQV7W7auvKcVBkDNk9zHQsIkrsqAj5Y+XzZZo8cJbNxfjAbawCM3O6DEd79PmxfDW6oeezjkn8q1+VTlb7GaMOvzHGW1pi+p0ylnzYw48yBGNb99sw0PJjyhYR1+0qoRLO+PnF10fxGsofk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623986; c=relaxed/simple;
	bh=YaIZPczUt0JTVA89TpBrq/++CRfdlHNIhDlOkzrTVzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZZL8VLr9vSjWEzjGluPZceuc2GMZ9g1Qh7GfOcWA8EqOqh80VXQW96HBKv8nw+H5y6C95Lh9CA3cdCwJxYTkobBkUwonDQf8dpIA4Vk5Q5V489HhB6CauQGiQDVz4ww6J7JERGElNTrNOssfNrRLyOuOv5wrNFZlv23nrVqZRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=emuyim7T; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c7120353f1so16652885a.3
        for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 10:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769623983; x=1770228783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YaIZPczUt0JTVA89TpBrq/++CRfdlHNIhDlOkzrTVzQ=;
        b=emuyim7TvBe01y2dJMnjEtmtlTymOnFGE7QzSIKOn1RDR6jEGW76994v0XfsyY059Y
         DEaAvxyG7zNxBWWkP84kf+ls4MH4pWN/l8V81hJAHaYraMiJ012KGMsXmrI0Fs6/DuIL
         WIKJJE3AmR8MDfBtodzVXFXP01lNSksXMlayRgYv7t3zxPavh62/zSYS3lt36Kv2yCF7
         ZAxgbLC+bI05lcBtFopE8cJFnACQC0l+qXc+RPDq/OGZolRHLUCT+44hzONJmkz6Ua/A
         7p8nSimfltiW9AvwOQRHSCiUOYn8/lJsgO63SZDq7ladnJ/N4rVKlBZ3M2FREqOenkI7
         Iz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769623983; x=1770228783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaIZPczUt0JTVA89TpBrq/++CRfdlHNIhDlOkzrTVzQ=;
        b=BVhjyfF4+le580ApjgEeCyCpqyCp1qQ+pb/i/wVzH853NHV561rGm5DmSCxBiD+Nsf
         6QXYPNOsr0+odM1rOWhoHWYgts2dM08jVClz+a99aYcLXRgeF0G5FC6I4E2pahqEDiIO
         YFPyuaRAMcgipiez+k5RXcK0hbEBXFeZbIl82uhc0q++Q3jXuVbqyYH9xahOTdDxbAWm
         +LkDXazOVgYxtvdfXs3I1QmrGm5ljcBOjSWXgnC6bkb6/lnGdZFU8Y0dKY1KaiiBFTKa
         Bov1HavoiN6XQPLS5NtFsef0M+oDRYKT9IAodkd7xIGsYfccGQRF2NHVovlpffIPZ2+5
         37oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTn9RymRTAk0EhbZ5S3G4FhmAxjIEb4tgZugdPb2G+7AD8PhDuAqsTqT/FR9KFl7pep3zaih8AMiry@vger.kernel.org
X-Gm-Message-State: AOJu0YymPy5ZV2XO7SfWZ7aZIU0uqom96zcCSTJ3CRHE4PgCXohRkYUP
	V6KCyKfKT+lJ7bj85Lzy94D9wOuAwv5LYtG139np+5rJ5RuSUmwwBYYVQ64PFZzUg1vXN8sB004
	St5C7
X-Gm-Gg: AZuq6aKJGxeHr11wxxw6mVNpM85cJX238VCCTOF4l9kK7ryEzYXW0oL9/OHoPSR34xZ
	N+y2cDv62zn1LYVRWbCv57s+dYJpiTPhuZfEalCqF5IYX9d5mhbXcjunr+z6FJyxL0nSWLvrG9c
	wRAEd59APQ+FO6zD3nlZSdY8dEiPZ/h4IWHTP6wL0oEnhD8SdLB1xwsK7rGKXkHeMLAL7zBRTjm
	H++iNl+Dz/u2znp2iM+0f8gITpcGezh8gwqHFtshdthzVyxLThxlufVWOYl2Vy6Q3t0k5HzrrbM
	BiahynZremIE77NOo353hBIXfeTOBlYZ2ow2VuMI8HKpurvcPkzk7PJ/tiB7yv9v1+vkfM/QfPW
	3SeEKuxDDWn7SBPc82RpyaUFL8zWNml7i9+W0fJKkB4nVyvQbXtdJAMHJHW4bdJwoVtcipJs3lz
	cirIP6crzKrGaX0opU4fKCinBsQFuqO5fYZAfTGvsPQ92vcKTlF/BvWCn9HGQDcZA2wBA=
X-Received: by 2002:ae9:f404:0:b0:8c7:136e:bad7 with SMTP id af79cd13be357-8c7136ebb3cmr341643785a.85.1769623591045;
        Wed, 28 Jan 2026 10:06:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d375ce71sm21598586d6.45.2026.01.28.10.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 10:06:30 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vl9vx-00000009aHB-3e3a;
	Wed, 28 Jan 2026 14:06:29 -0400
Date: Wed, 28 Jan 2026 14:06:29 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Leon Romanovsky <leon@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH net-next 2/3] mm: vmalloc: export find_vm_area()
Message-ID: <20260128180629.GT1641016@ziepe.ca>
References: <20260123082349.42663-1-alibuda@linux.alibaba.com>
 <20260123082349.42663-3-alibuda@linux.alibaba.com>
 <aXPEFdEdtSmd6AzF@milan>
 <20260124093505.GA98529@j66a10360.sqa.eu95>
 <aXSjm1DXm6yP62tD@pc636>
 <20260124145754.GA57116@j66a10360.sqa.eu95>
 <20260127133417.GU13967@unreal>
 <20260128034558.GA126415@j66a10360.sqa.eu95>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128034558.GA126415@j66a10360.sqa.eu95>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,davemloft.net,linux-foundation.org,linux.alibaba.com,google.com,redhat.com,linux.ibm.com,vger.kernel.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-16168-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 43A8AA7AF0
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 11:45:58AM +0800, D. Wythe wrote:

> By leveraging vmalloc_huge() and the proposed helper to increase the
> page_size in ib_map_mr_sg(), each MTTE covers a much larger contiguous
> physical block.

This doesn't seem right, if your goal is to take a vmalloc() pointer
and convert it to a MR via a scatterlist and ib_map_mr_sg() then you
should be asking for a helper to convert a kernel pointer into a
scatterlist.

Even if you do this in a naive way and call the
sg_alloc_append_table_from_pages() function it will automatically join
physically contiguous ranges together for you.

From there you can check the resulting scatterlist and compute the
page_size to pass to ib_map_mr_sg().

No need to ask the MM for anything other than the list of physicals to
build the scatterlist with.

Still, I wouldn't mind seeing a helper to convert a kernel pointer
into a scatterlist because I have see that opencoded in a few places,
and maybe there are ways to optimize that using more information from
the MM - but it should be APIs used only by this helper not exposed to
drivers.

Jason

