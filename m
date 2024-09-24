Return-Path: <linux-rdma+bounces-5057-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B65D7983D68
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2024 08:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E250C1C2283E
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2024 06:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D3F823C3;
	Tue, 24 Sep 2024 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aZojnje2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416996E614;
	Tue, 24 Sep 2024 06:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727160877; cv=none; b=dZz3uJuyMprNEVpZ9QS9np+ZGn5Fgs9UYgCMmhTvvy/dG6Olf+8aRcdGrj2TK7KD0+F5ZNUsuW/qoulO1aQ3jab4Za+DiFxszV11wrXvvcf7dbAxxKy9q/SZoDvZHfjUajL0LONLR1OTAn6oDMlWPI58g+Lz+iJFMeETE2z22vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727160877; c=relaxed/simple;
	bh=EeC7cXplTg/3qKtPs0mpDW07TR8Y7qOGbalWkLlihi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMflCQcQG8Q2rgPelHz3x3uxPlO8B0Jm0F3a2GS5mE/vgp/d6j2n5vZ75hKdyJKj9gsG9Zwf4i8v9hsJLf+wj/EDKt3mjU8JZ60HLm/BpvnkR63WrWvgCAJ6oHtNJaqWta9b7YWwCTR5WOWlD1CTkcPGD3nJ5jq/T0QQwcgDRk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aZojnje2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EeC7cXplTg/3qKtPs0mpDW07TR8Y7qOGbalWkLlihi8=; b=aZojnje2op7H+OOywcj/GuoPmi
	RFj+rTe+HyzlGgHyxvGS6xRKW82pxAzW1lQBWD6AhWDqvhfI5DcndFrTDWlC75Ded8lNFRTi2BRJ/
	NvtYWBn6VrXeDhF+w16MO/yscA2S7R4/lHEWevBCSAdkUy0AEGQKUy60uBhLb/T6YempADzGJee50
	3BbgcPWjIR8HkBD5Kp6UgiG4DEcH6Zj82+Buh6659BbI7QhEXww1gF771bHwhYITvEP2jAH3X03Ee
	8ZbrUox3dPULt9dHG8LOjDFqaZgJgNaeqM7OCi8EDo7+AdYU1ttkxfOdWNnOhUTLXFiUKHlCSkw0l
	cm8IzW6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sszRQ-00000001KIZ-24Tu;
	Tue, 24 Sep 2024 06:54:32 +0000
Date: Mon, 23 Sep 2024 23:54:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Christoph Hellwig <hch@infradead.org>,
	Haakon Bugge <haakon.bugge@oracle.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Allison Henderson <allison.henderson@oracle.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	OFED mailing list <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>
Subject: Re: [MAINLINE 0/2] Enable DIM for legacy ULPs and use it in RDS
Message-ID: <ZvJiKGtuX62jkIwY@infradead.org>
References: <20240918083552.77531-1-haakon.bugge@oracle.com>
 <Zuwyf0N_6E6Alx-H@infradead.org>
 <C00EA178-ED20-4D56-B6F2-200AC72F3A39@oracle.com>
 <Zu191hsvJmvBlJ4J@infradead.org>
 <525e9a31-31ee-4acf-a25c-8bf3a617283f@linux.dev>
 <ZvFY_4mCGq2upmFl@infradead.org>
 <aea6b986-2d25-4ebc-93e8-05da9c6f3ba2@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aea6b986-2d25-4ebc-93e8-05da9c6f3ba2@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Sep 24, 2024 at 09:58:24AM +0800, Zhu Yanjun wrote:
> The users that I mentioned is not in the kernel tree.

And why do you think that would matter the slightest?


