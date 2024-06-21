Return-Path: <linux-rdma+bounces-3402-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71080912A3E
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 17:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17E21C22935
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD5478C84;
	Fri, 21 Jun 2024 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="J8aZzq+O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662CB20DF7;
	Fri, 21 Jun 2024 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718984033; cv=none; b=R6mqW2F15zyS8pfuJLRsxnsM49GyF1m3EwUVAyIoANAWuVf4CcbY2qhNQ5YeY+WsoD/zI7xjNk0yBaGCG0zc2ClYsUAmzzgGcDJ7nUzq3W2lDpB4v9sBlZ7c3LE2hU9BSRooed3YxJOkuMgL16S0p+2zbwEz1e4AFoTwpw3A/mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718984033; c=relaxed/simple;
	bh=7mXAeMzch9AGvRNeWIaKiUA2sxNdQSVqpCwOnMEYjrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXm1RqrP6lyqNW/d3H18940WaKGn7wXzfsgIRCXXvISTRoa/sS3Z8qiiGjN8Vr+D2zpLgcKuc5nG22B/Zda3VQdvOqd9xHhFSuQ81sPe8T/Rk7KRjsLrvvAJHx2+14gcDyF+8vNcOKvrKlGT3zu0WizAiUEcFDYlHGo6IQSysSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=J8aZzq+O; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9Y6negZVZePySlebIwaToYMdqW9+ah2eSR4eJJzPrvo=; b=J8aZzq+OXu0RL24rErzEnS1FDi
	I73XkOMYZGGvEhGnfqi4Mvbeqe0S0Ia3YzVmdG2T5D1neiS31c1dFDbV1lyDrfzUhgpqyNS76cVku
	u8LgtXxd3H+OS0uIzQmCjaWcg90e1HNp3gFeQ/HkndduyMy3GJ4CN518V/zXrFT//OUo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sKgGo-000gLU-Bv; Fri, 21 Jun 2024 17:33:46 +0200
Date: Fri, 21 Jun 2024 17:33:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"ogabbay@kernel.org" <ogabbay@kernel.org>,
	Zvika Yehudai <zyehudai@habana.ai>
Subject: Re: [PATCH 06/15] net: hbl_cn: debugfs support
Message-ID: <060ac3a6-bbac-400c-bfd9-cb1a32c653b4@lunn.ch>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
 <20240613082208.1439968-7-oshpigelman@habana.ai>
 <BY3PR18MB473757A4F450A2F5C115D5A9C6CF2@BY3PR18MB4737.namprd18.prod.outlook.com>
 <ac16e551-b8d6-4ca7-9e3c-f2e8de613947@habana.ai>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac16e551-b8d6-4ca7-9e3c-f2e8de613947@habana.ai>

> I see other vendors have debugfs entries for debug configurations or
> settings, not just for dumping debug info.

Did you see any added in the last few years? This is also something
DaveM pushed back on. We want uniform APIs so that all devices look
alike. Please consider what you are exporting here, how it should
cleanly fit into ethtool, devlink, etc, and expand these APIs to cover
your needs.

> 
> >> +What:           /sys/kernel/debug/habanalabs_cn/hbl_cn<n>/nic_mac_loopback
> > 
> > Why not use ethtool ?
> >
> 
> We have an ethtool option for that, but we have also internal NIC ports
> that are not exposed as netdevices and for them the ethtool path is
> irrelevant. Hence we need this debugfs option as well.

If there is no netdev, what is the point of putting it into loopback?
How do you send packets which are to be looped back? How do you
receive them to see if they were actually looped back?

	Andrew

