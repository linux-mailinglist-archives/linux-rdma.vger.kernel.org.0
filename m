Return-Path: <linux-rdma+bounces-3523-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8289183B9
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 16:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D942528253F
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 14:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430C31849FB;
	Wed, 26 Jun 2024 14:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BJFmmQyQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2047918411D;
	Wed, 26 Jun 2024 14:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719411243; cv=none; b=DpEdOrkSH5qzjuIx0Zpo01yhOUbOS0Wu6QoW1RcY3XdKl5bUYssDai6v6VLkyZec+9TdA2S438zv9kMbzhTBIziiBqD0YmM24XxTVbXrD4giTGywbkF4VRRv0D9JpvkU9vrJpbz25xzsXT7R3/otODC66/nryMEaJXAC9ixvSdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719411243; c=relaxed/simple;
	bh=Jkbyb4fhO6hOpUAa+l/jASV89ZqxVCIKJ/L+aHwLj6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eE5QWTpZ5UxuSx8EYKUV5FOCauTmlJ+dCauDp3AAk0jvpOyHdT0iAJ2mMsoX/ZqotdNP+Jnn+wJsWWSuNkPD1JVgDYgOkMgLr8yyzhBNB8e2evaYv4vZEASF3hkYA9rfJod19ykFaevmKw8GcyMCe76y8cHfMAGkFNDQpF40bxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BJFmmQyQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=e/r3KxX+Z2Dmu1E71CISshUp48TvjeiI0ZOqnh1fVEk=; b=BJFmmQyQeuEmVErk5/QtUZe7Yh
	VUEC0/D9H3JVtFJBThg+eXVMbbm523IfUDOHxbNi4TiM0TlV7a3x+NQOCeXerCOsDd7zLoPswX/Qn
	atH0p7j8kL1fyzvhOSU3E9daj1yDFmc/MUn4ICdytOcinXApdpsLuiY01h94b1mItE6s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sMTPH-0012mx-QE; Wed, 26 Jun 2024 16:13:55 +0200
Date: Wed, 26 Jun 2024 16:13:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"ogabbay@kernel.org" <ogabbay@kernel.org>,
	Zvika Yehudai <zyehudai@habana.ai>
Subject: Re: [PATCH 09/15] net: hbl_en: add habanalabs Ethernet driver
Message-ID: <1baf52ff-d3ce-4d3f-9655-46a1a919119b@lunn.ch>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
 <20240613082208.1439968-10-oshpigelman@habana.ai>
 <10902044-fb02-4328-bf88-0b386ee51c78@lunn.ch>
 <bddb69c3-511b-4385-a67d-903e910a8b51@habana.ai>
 <621d4891-36d7-48c6-bdd8-2f3ca06a23f6@lunn.ch>
 <45e35940-c8fc-4f6c-8429-e6681a48b889@habana.ai>
 <2c66dc75-b321-4980-955f-7fdcd902b578@lunn.ch>
 <8a534044-ab84-4722-b4e9-4390c2cc6471@habana.ai>
 <f45a71f9-640e-473a-9b80-90a50b087474@lunn.ch>
 <96677540-c288-43f6-9a47-1db79a0880eb@habana.ai>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96677540-c288-43f6-9a47-1db79a0880eb@habana.ai>

> Here is the output:
> $ ethtool eth0
> Settings for eth0:
> 	Supported ports: [ FIBRE	 Backplane ]
> 	Supported link modes:   100000baseKR4/Full
> 	                        100000baseSR4/Full
> 	                        100000baseCR4/Full
> 	                        100000baseLR4_ER4/Full
> 	Supported pause frame use: Symmetric
> 	Supports auto-negotiation: Yes
> 	Supported FEC modes: Not reported
> 	Advertised link modes:  100000baseKR4/Full
> 	                        100000baseSR4/Full
> 	                        100000baseCR4/Full
> 	                        100000baseLR4_ER4/Full
> 	Advertised pause frame use: Symmetric
> 	Advertised auto-negotiation: Yes
> 	Advertised FEC modes: Not reported
> 	Link partner advertised link modes:  Not reported
> 	Link partner advertised pause frame use: No
> 	Link partner advertised auto-negotiation: Yes
> 	Link partner advertised FEC modes: Not reported
> 	Speed: 100000Mb/s
> 	Duplex: Full
> 	Auto-negotiation: on
> 
> There are few points to mention:
> 1. We don't allow to modify the advertised link modes so by definition the
>    advertised ones are a copy of the supported ones.

So there is no way to ask it use to use 100000baseCR4/Full, for
example? You would normally change the advertised modes to just that
one link mode, and then it has no choice. It either uses
100000baseCR4/Full, or it does not establish a link.

Also, my experience with slower modules is that one supporting
2500BaseX can also support 1000BaseX. However, there is no auto-neg
defined for speeds, just pause. So if the link peer only supports
1000BaseX, you don't get link. What you typically see is:

$ ethtool eth0
Settings for eth0:
 	Supported ports: [ FIBRE	 Backplane ]
 	Supported link modes:   1000baseX
 	                        2500baseX
 	Supported pause frame use: Symmetric
 	Supports auto-negotiation: Yes
 	Supported FEC modes: Not reported
 	Advertised link modes:  2500baseX
 	Advertised pause frame use: Symmetric

and then you use ethtool to change advertising to 1000baseX and then
you get link. Can these modules support slower speeds?

> 2. Reading the peer advertised link modes is not supported so we don't
>    report them (similarly to some other vendors).

Not supported by your firmware? Or not supported by the modules?

    Andrew

