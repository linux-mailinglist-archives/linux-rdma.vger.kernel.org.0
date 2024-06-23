Return-Path: <linux-rdma+bounces-3412-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C279C913BD7
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jun 2024 16:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D316282BAF
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jun 2024 14:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CA7181BBE;
	Sun, 23 Jun 2024 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JAE5omCx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342B81EA6E;
	Sun, 23 Jun 2024 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719153972; cv=none; b=sB1qdib8rMq/4ztSBNNgZeypSQowomeEsyoTW+A7hkXRAeAVA2NrpReLacZtZjh3rrg1wBE2qTp/CeWS8quzQYx0FkszT37MZQ+GMjXajr7bWLgo8095n7a//iP3d4m8wsiTeM1ZeY9UVXZ+TlrwjVpi/qOuJV7UIQ6DyDHV9bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719153972; c=relaxed/simple;
	bh=sSSAApEr//cHzy5xlGIXpABWrJVeEvyJw+2d6f8qIvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUeOEkFyx88W7WrpIZ+Rqry4fkA+qUpAClQ7hg9L5YFOdnOtJFTCFmEp65WR7qFl40+SLGTYrurZYd0FqSYY8Y7+RfpvdWEVBe8fLmQveK8tsErCyK0hDuMJ1nwn00sCQgRPRgQi7CDRlUba749QK1aj3XOd3zxDFY0B3VhYiNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JAE5omCx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hY35+1Y/0rNSqds3ityzK536HUhtPgnfxWmgWJYkndg=; b=JAE5omCxkdN1nqIHskPoNR398b
	LPaggnarB+j9AWJLL4oJjC+r2inCjkun9kVK6P4ytxBsa7byMa6MePBQehscJB6X2kjZDXLdV9Qk+
	OxF7v/K90XQ29x51evD7aOjEPOG7WUWAdyiaXaolKQc/2u1nVwl7cLN2iQT/xdNOcCo8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sLOTg-000mjj-5e; Sun, 23 Jun 2024 16:46:00 +0200
Date: Sun, 23 Jun 2024 16:46:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"ogabbay@kernel.org" <ogabbay@kernel.org>,
	Zvika Yehudai <zyehudai@habana.ai>
Subject: Re: [PATCH 09/15] net: hbl_en: add habanalabs Ethernet driver
Message-ID: <f45a71f9-640e-473a-9b80-90a50b087474@lunn.ch>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
 <20240613082208.1439968-10-oshpigelman@habana.ai>
 <10902044-fb02-4328-bf88-0b386ee51c78@lunn.ch>
 <bddb69c3-511b-4385-a67d-903e910a8b51@habana.ai>
 <621d4891-36d7-48c6-bdd8-2f3ca06a23f6@lunn.ch>
 <45e35940-c8fc-4f6c-8429-e6681a48b889@habana.ai>
 <2c66dc75-b321-4980-955f-7fdcd902b578@lunn.ch>
 <8a534044-ab84-4722-b4e9-4390c2cc6471@habana.ai>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a534044-ab84-4722-b4e9-4390c2cc6471@habana.ai>

> > But what about when the system is under memory pressure? You say it
> > allocates memory. What happens if those allocations fail. Does
> > changing the MTU take me from a working system to a dead system? It is
> > good practice to not kill a working system under situations like
> > memory pressure. You try to first allocate the memory you need to
> > handle the new MTU, and only if successful do you free existing memory
> > you no longer need. That means if you cannot allocate the needed
> > memory, you still have the old memory, you can keep the old MTU and
> > return -ENOMEM, and the system keeps running.
> > 
> 
> That's a good optimization for these kind of on-the-fly configurations but
> as you wrote before, changing an MTU value is not a hot path so out of
> cost-benefit considerations we didn't find it mandatory to optimize this
> flow.

I would not call this an optimization. And it is not just about
changing the MTU. ethtool set_ringparam() is also likely to run into
this problem, and any other configuration which requires reallocating
the rings.

This is something else which comes up every few months on the list,
and drivers writers who monitor the list will write their drivers that
why, not 'optimise' it later.

> I get your point but still it will be good if it would be documented
> somewhere IMHO.

Kernel documentation is poor, agreed. But kernel policy is also
somewhat fluid, best practices change, and any developers can
influence that policy, different subsystems can and do have
contradictory policy, etc. The mailing list is the best place to learn
and to take part in this community. You need to be on the list for
other reasons as well.

> I'm familiar with this logic but I don't understand your point. The point
> you are making is that setting this Autoneg bit in lp_advertising is
> pointless? I see other vendors setting it too in case that autoneg was
> completed.
> Is that redundant also in their case? because it looks to me that in this
> case we followed the same logic and conventions other vendors followed.

Please show us the output from ethtool. Does it look like the example
i showed? I must admit, i'm more from the embedded world and don't
have access to high speed interfaces. But the basic concept of
auto-neg should not change that much.

	 Andrew

