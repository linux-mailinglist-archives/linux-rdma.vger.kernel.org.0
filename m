Return-Path: <linux-rdma+bounces-3370-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D59DA9111F4
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2024 21:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DAB01F22E01
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2024 19:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC08D1B4C5A;
	Thu, 20 Jun 2024 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GTRU5+to"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C131B47C1;
	Thu, 20 Jun 2024 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718910880; cv=none; b=F4sV91iHVpdUXepuEzUFY0rErnFQGsif7fXV3NNtdWj2ifJmnAVolGHfoOEeWe9glbhm0vS0aQyFhzVVBZlIEgE2JOLdmtTbMB/GiAmhWIyfcYTVbcIXpIrqq0UB2xw0y4NuHOXowRdozV2en6A9jTGVpsMbeaXxIh0428hsO6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718910880; c=relaxed/simple;
	bh=JqKuhxuOfiKP/ZmD0E10286le4lRBg5B2jJTJETya8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGTE7MECjjS87OJuVAITcJfnaa8uMayg9CZMi8mkuCtszUnhU6of1VTGIWUvistSJl/5htqsKbyihdk7O+N+wN55557eyV7Lou7pTikVTiETVip+BZvTW+LaT8C+4+GE+jQoficSWkJaPimdoKTuHCC4awwA/akNsHzZVFPyjps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GTRU5+to; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GtUiKMS+JogD7d3VokqpWsqamEr3QnRsE46YsJrX/0o=; b=GTRU5+to0kKy1NAX4h4nyUFaZ6
	jHdJh1WGaW6/adsVToEIo0B3tkHPVcSm1Dk+NLBYCa+QwOQqCEHobDiYS2pEgMbvbB7wJly6vlod+
	sHB79KMKRc9abEw6vVPCyQedSikAivG/UC00Pnvy/Hdr0/nTDai8TwiLOgRnLWvcMq58=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sKNEu-000bKe-I4; Thu, 20 Jun 2024 21:14:32 +0200
Date: Thu, 20 Jun 2024 21:14:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Omer Shpigelman <oshpigelman@habana.ai>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"ogabbay@kernel.org" <ogabbay@kernel.org>,
	Zvika Yehudai <zyehudai@habana.ai>
Subject: Re: [PATCH 09/15] net: hbl_en: add habanalabs Ethernet driver
Message-ID: <9d459e01-6171-4a1a-855c-f56813ea9e0f@lunn.ch>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
 <20240613082208.1439968-10-oshpigelman@habana.ai>
 <10902044-fb02-4328-bf88-0b386ee51c78@lunn.ch>
 <bddb69c3-511b-4385-a67d-903e910a8b51@habana.ai>
 <621d4891-36d7-48c6-bdd8-2f3ca06a23f6@lunn.ch>
 <45e35940-c8fc-4f6c-8429-e6681a48b889@habana.ai>
 <20240619082104.2dcdcd86@kernel.org>
 <5cb11774-a710-4edc-a55c-c529b0114ca4@habana.ai>
 <20240620065135.116d8edf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620065135.116d8edf@kernel.org>

On Thu, Jun 20, 2024 at 06:51:35AM -0700, Jakub Kicinski wrote:
> On Thu, 20 Jun 2024 08:43:34 +0000 Omer Shpigelman wrote:
> > > You support 400G, you really need to give the user the ability
> > > to access higher pages.  
> > 
> > Actually the 200G and 400G modes in the ethtool code should be removed
> > from this patch set. They are not relevant for Gaudi2. I'll fix it in the
> > next version.
> 
> How do your customers / users check SFP diagnostics?
 
And perform firmware upgrade of the SFPs?

https://lore.kernel.org/netdev/20240619121727.3643161-7-danieller@nvidia.com/T/

	Andrew


