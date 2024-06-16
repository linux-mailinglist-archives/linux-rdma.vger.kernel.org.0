Return-Path: <linux-rdma+bounces-3164-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67584909AF8
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 03:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A0028268F
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 01:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFCC525D;
	Sun, 16 Jun 2024 01:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tQK2n0q6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9743D6B;
	Sun, 16 Jun 2024 01:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718500139; cv=none; b=SfsiFbVI4o2pfVOBBiGC3EXjzLwP4Rv96WZDygcZAQ2A3K2KrhCV9SVAwPJbd7VWSY9deaxFXkfY2Gsocf360Dj/NWIQ+Z678VjdJ+aPjlVNYdxYg7Ev0LE9qxfDT2yR5id1NEwj4S7LXPGDIBEUmrVLpW/Z3rpRSBYbIHGJFPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718500139; c=relaxed/simple;
	bh=f/6jXAA5bkn2tTbm2isTLSDP0zxxYC5Prpj3EhO1iAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJBx8z4IwhSAyqSkSAA2pRCKf3CntqoyQ3C1tIT3yQyfFekt0MrO7xvwrq8s1tLqxD+HWmC+ROcHbxXrZGPWAF7dwsNBNE4s9D7kMzXnx8+mzi5lm4IyFj+c+VI5kiSLHFxVbVeUJq0JyeBIMHPyIB5zyzQCqyHELb+vGQu7d74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tQK2n0q6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VMgOaKbDyzjHCgUb9Jf5r6hZWkNjR/kmgzL4IDgUn4I=; b=tQK2n0q6YxQ1MOpicvrGXzAe5z
	hkkOiwDLzavAsBQEQsj5IJYut7t6wgSt4/KZx3rGh6A0B+8IWeFUB+91gJREvJ9bwRnN0TNjqgyld
	bE1JPQw/QKCIvaag4Gcl/Ihe6+z+kCePrXwNDSbyKWPsnhFxnN2otsc5d6XA4t/M30is=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sIeO7-0009sQ-Of; Sun, 16 Jun 2024 03:08:55 +0200
Date: Sun, 16 Jun 2024 03:08:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Omer Shpigelman <oshpigelman@habana.ai>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, ogabbay@kernel.org,
	zyehudai@habana.ai
Subject: Re: [PATCH 09/15] net: hbl_en: add habanalabs Ethernet driver
Message-ID: <61476e92-aba4-4726-984c-d845e5fc4dd3@lunn.ch>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
 <20240613082208.1439968-10-oshpigelman@habana.ai>
 <38b9797e-d213-422e-8b2b-7a31f5924b55@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38b9797e-d213-422e-8b2b-7a31f5924b55@linux.dev>

> > +static void hbl_en_reset_stats(struct hbl_aux_dev *aux_dev, u32 port_idx)
> > +{
> > +	struct hbl_en_port *port = HBL_EN_PORT(aux_dev, port_idx);
> > +
> > +	port->net_stats.rx_packets = 0;
> > +	port->net_stats.tx_packets = 0;
> > +	port->net_stats.rx_bytes = 0;
> > +	port->net_stats.tx_bytes = 0;
> > +	port->net_stats.tx_errors = 0;
> > +	atomic64_set(&port->net_stats.rx_dropped, 0);
> > +	atomic64_set(&port->net_stats.tx_dropped, 0);
> 
> per-cpu variable is better?

Please trim replies to just the needed context. Is this the only
comment in this 2300 line email? Do i need to keep searching for more
comments?

	Andrew

