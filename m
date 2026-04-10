Return-Path: <linux-rdma+bounces-19218-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGV/Lipw2WnGpggAu9opvQ
	(envelope-from <linux-rdma+bounces-19218-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 23:48:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CDC3DD0A0
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 23:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 209B5302EEB5
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 21:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D123A963A;
	Fri, 10 Apr 2026 21:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="E4Z6DVMz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048B1347503
	for <linux-rdma@vger.kernel.org>; Fri, 10 Apr 2026 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775857607; cv=none; b=RuhNBnLDZ7Kuo7nmYZ1Ia1SkGf3rtP/qXSqKXDSFhbBFqGqrnniq0BTgfEdHQ0csVTJmCmlY9UwNlX237/hhFeEnscm/dTAcQq43YYjz9R1tdWaKZdYEOzlAMcxlYa+5NpZMKn3zdcjK/5uridYhRJA8e08yqbFTQVaNbHc641o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775857607; c=relaxed/simple;
	bh=GITtlFAdk/iYbZpZKDv5zRed5TTMIBoL7DDTwImRmf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wj/s7EmUuL6ItT/W7iR1BuBJmuxEs4E/sQ7JlszWln5QAhQac3b4uNA+9KpC5AodRxJdO2Rae0+O3c4ZEH7bQNvCqfMztqeZ4U19e3XzB2YLtrVb2w1c/eZuhZifPVLH3txMGoJJez95DHI5d4AUeWqjf6KzjnfOJG4gyesqfvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=E4Z6DVMz; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8d65f4073bfso366687785a.3
        for <linux-rdma@vger.kernel.org>; Fri, 10 Apr 2026 14:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775857605; x=1776462405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GITtlFAdk/iYbZpZKDv5zRed5TTMIBoL7DDTwImRmf8=;
        b=E4Z6DVMz0knvMdK19f+RGtgQR+OgWk0mQyA31cxofE1IQMs0/Rxft0jRWjYlrjMwL4
         bVR+h+fT16VcPsG1ypH7FDb97hm6wT+AAfP9urPIofjLNHhZuARd2R79LiZPXWRvonIs
         m0qBBhcYDFBUKvzWDxSulXe/mkDyXzoHzrQ6nRb3Ld//nRRKQ0ROwEJa/68SnDcdGdX9
         Uajs7Qt/9UaQrpG35JQhMhhH+cUnonvDbR1RAdzpkhWzLqLQm3kutkmd9Pd47R8LEJCC
         /dkEa2/rP+Z8ON2xwuw6S36BHFZmrnI+6LqfmkOvSwzNLC6eZ+xZ1ZciEzynMxzZClaz
         eRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775857605; x=1776462405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GITtlFAdk/iYbZpZKDv5zRed5TTMIBoL7DDTwImRmf8=;
        b=M3KkYzKx38Eud9kBWG2X3BdLonD7+BGmh5XulABKpxXTBvPaA6tPEyT8JUgq7IyrUo
         bytxarFJ4tC3CRzbog+kmemIE41+qdgq/3xCxC248fKK88s1/EhURnfm0bqwzN/E9HUX
         NsIHkiukUe6nJFc61lieVB3lTguB0qWtJIKFncWbRZQ0dVR83BU2qLeF8Vr7bwKU+eBV
         fstwxrJh875Y5FRy4sTZcu8o87igjz1yaZH6OuJaoTQqoHtCBP5hEA+kki7MHs6SDWkt
         yIWbTQaFIVsJZH/2V1UzoqZyvkq1RMySoRsUOf9yAk9z+UyVZ9Rh6LmiVSFWUAAjxFd6
         RNhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXc0w70qGf6upZch2HOYvSNoTkfxMYpoGkYhxHQ8vZMmacSOs4YKtKpbJbU9cfvgpFW5YVaPr7zoQp@vger.kernel.org
X-Gm-Message-State: AOJu0YyTmhsQhbacxO7OEn/mJirUX2oQHpkWp9ZFPyIPPG3MrsxTWyCq
	bCAvnX3AxGsRFR0uwxaeo64bkppDW9ce6WsB4gWWwl9rAck8V0JL09s5ZX7un9cDo78=
X-Gm-Gg: AeBDiesclQgq9TYWb/LNKxW0PIYru6hm6lURfFF2S1GQO75yiaWoz7Fw0OXUg4IIF3q
	B0EzWsmGpYTvs9Lc2TiBemLQ0AST2X6xzhKC6CTR+CSZ02dy3SYs6oz5b4CELd+OaxlE9Q2zNU1
	uH+Wja0YsuYqx42drBJMNcpKoyBTIwTN3ii5vh67wx1RlNCCZA8+Pdz7mq357EMiiR6ZRFX1r+L
	UIKDctJ3JS9GMypz2xFH+bGqkX3p19xAfyqXGpYvd5DguygMGPY7z3tEXJ9IQykEd/KJM+6gkPK
	8zZZCAFj3QABwg62mw2m6wlIIBAqEpLowXi8e+Yec6ei+w92ghIi0IrPd7rd8tGbtHPgDoOk5cK
	YumdiZ3HlLCeAH35rlSe7LNBsEHTgM+2Q3H7FscB2QiUIauqbfM5kWio3lTMwHlY6gXXfN/Ih4b
	P3ghxheYTrFl8Q2RTBpN9eIKkT+goCQWQ2GTGLDq2XRSLK+zGFfmj19CEK/IB6/rfQX8tBSw==
X-Received: by 2002:a05:620a:3707:b0:8ca:4545:aeee with SMTP id af79cd13be357-8ddcf5b3415mr694224985a.37.1775857604893;
        Fri, 10 Apr 2026 14:46:44 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb5f8886csm293491485a.6.2026.04.10.14.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 14:46:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wBJgZ-0000000GLim-2xxN;
	Fri, 10 Apr 2026 18:46:43 -0300
Date: Fri, 10 Apr 2026 18:46:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: leon@kernel.org, Nick Child <nchild@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/umem: Initialize iova for dmabuf umem
Message-ID: <20260410214643.GA3694781@ziepe.ca>
References: <177584750586.341184.13583748105422169656.stgit@awdrv-04.cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177584750586.341184.13583748105422169656.stgit@awdrv-04.cornelisnetworks.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-19218-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 58CDC3DD0A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 02:58:25PM -0400, Dennis Dalessandro wrote:
> As of commit 4fbc3a52cd4d ("RDMA/core: Fix umem iterator when PAGE_SIZE is
> greater then HCA pgsz") rdma_umem_for_each_dma_block() iterates at most
> ib_umem_num_dma_blocks() times. ib_umem_num_dma_blocks() calculates the
> number of blocks by extending iova + length to page boundaries.
> Previously, a call to ib_umem_dmabuf_get_pinned_with_dma_device() followed
> by rdma_umem_for_each_dma_block() would leave iova uninitialized and
> iteration would only cover a subset of blocks if the memory did not
> begin on a boundary.

Well that's illegal. Drivers must always call ib_umem_find_best_pgsz()
which always sets iova properly. Fix the driver that isn't doing this
sequence right.

Jason

