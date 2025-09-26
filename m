Return-Path: <linux-rdma+bounces-13667-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CECC0BA25F7
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Sep 2025 06:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BE64C2A40
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Sep 2025 04:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C64826F477;
	Fri, 26 Sep 2025 04:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bdXI1+zA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCC21534EC;
	Fri, 26 Sep 2025 04:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758859978; cv=none; b=TLVShdo+d2zALVv0IZa4f4hKHDyyqOKQzALA6enytIZn69uo2slhoxqbKp9gfs8bYXKzpXYEAl5QbRTokJ2YBsG7nt4R9aAxkbGp4hzKIt2LAzi53luCo5F6cXkPHVpgdQTia31wVRI+su6EKGYjH2fOhKfghbRN3oTmHi++FOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758859978; c=relaxed/simple;
	bh=r71dyMuWzIVRSntQa+6alrEDnNFtmiGyTEBddtv8Hrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxjahtCWzDGmbK25VmpM9tgHCN5MkUAobijZfzi4bAwccugj2l9qumWq0w3KNIoOF3HuXz7UtR9eyO100mjAwdGiqzy20nlvdoAPuuCl4oGbcHU2+0FwzjW36TSdTgdNREvAbyNj8aLHo0OeVireidSjfYFb8bktSyYhJDr4W9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bdXI1+zA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mKbSbSK3BStb89HCck4H2KoXqyWcXPFnuu+PYFF0RzM=; b=bdXI1+zAP8NCRd1wlQCH7LjtpW
	hWefG5vqCCZYmiH4MJMe8zf3hKP1bESPx8vZ2trsF4QHT9yEX2XMYL8kr5LdxMxohJbSVWoPH27ko
	JFk5QfyNZ4ZrWHzyfxE8WmwahEh/Wre6XxlZ/jxTkkQRF7yjYc1kGgRaYqLv8wK2DQzHiY7vN3Uiq
	4ATMkRBBJ66y5G9S7UQeZwjkIqxyDRc78MsCKDVXg4Cr6P00sFlf1bUYdR66FegABFpbIARsoTd6i
	eYQwj4zh2kSsJtpx823ReoJFzqheX+y3jbeyj1EHAC9B3Vu4QQbk1cNvFTqe9hpaj0fae0WsCf1yf
	4To6eClg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1zpF-0000000FdPf-1JZb;
	Fri, 26 Sep 2025 04:12:53 +0000
Date: Thu, 25 Sep 2025 21:12:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] rdma_rxe: call comp_handler without holding
 cq->cq_lock
Message-ID: <aNYSxX7m58_lXfOp@infradead.org>
References: <20250925195640.32594-1-philipp.reisner@linbit.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925195640.32594-1-philipp.reisner@linbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Sep 25, 2025 at 09:56:40PM +0200, Philipp Reisner wrote:
> Allow the comp_handler callback implementation to call ib_poll_cq().

What completion handler is doing this?  And even if someone is doing
folks really should stop calling ib_poll_cq and use the proper CQ
callbacks API anywau.  Please help converting RDS and SMC so that
we can kill the ib_poll_cq export entirely instead of spreading this
brain damage.


