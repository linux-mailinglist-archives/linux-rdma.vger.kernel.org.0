Return-Path: <linux-rdma+bounces-14368-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1729C49ABC
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Nov 2025 23:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BD8A4EA80C
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Nov 2025 22:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1812FF662;
	Mon, 10 Nov 2025 22:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wv5sTKvK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0842ED16D;
	Mon, 10 Nov 2025 22:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762815515; cv=none; b=L8/dPTI2Mo7BpAQ7zZKdb4m0Ka9L9qPSoQLm3ehhqVEuEVlfvjwZP7m1yYZVHhtsUTB6dbSicVAS3JV2gelcJb955YFJQMqCMRdj9FsywI/7oBoKkqY+1abvwfNg5WdF9V/mClRWgwEsy++LGp4lcNxqiq9xXigjkDv6B49fW/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762815515; c=relaxed/simple;
	bh=gp119oKTnpbHC1P/d+n3Qm9C5OlbMz4VTP9qPySDarM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tdn2vaeK5au5lWUABw2vnSobJVCXgF/RKY2WofWP0EtNpwDTyM9v/m0mJlw6CEg0M/0EQRAf2zq5am2RKSuvVpVzo1lxrOJBAcYoFzfE/Vh8hr4uxA4m+wOf1rOi04K6VCK+2/CFPTG+2nEWAcpVKsGE2TXTlHxwc0V/GuiuPLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wv5sTKvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE8DC16AAE;
	Mon, 10 Nov 2025 22:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762815514;
	bh=gp119oKTnpbHC1P/d+n3Qm9C5OlbMz4VTP9qPySDarM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wv5sTKvK8Fth+8Ulry2nulV4xCEtVBXnwIhWHQPmidsRNLKwkQ3d5V0GD068+lAO9
	 LI3OqSg5CRVEyB//hIYRvUHrLnqzWExmmbDT9Z1UchTDbOP3Ryw9ll2uDjt6HDWyWj
	 6KPxk/pHL763G49ToN0WUTIrt7+ddlaAHxfdQwJIFbCcTTqelmfK6pM2GNLDRQ4vys
	 AfRF6fB43wY/PHKCpH1Uvy2oCOSMxac7NhkYiYrR01l/n/URrTywQFpukP74NlCWWD
	 I99Zqwa+C5Z/WJT4fbNe3yCmM0qcOl3BeAEHvVNQphNd/uswiSxOEDkg692CA0h6BI
	 d9gnLkn/HQN4w==
Date: Mon, 10 Nov 2025 14:58:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Srujana Challa
 <schalla@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Brett Creeley <brett.creeley@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Michael Chan
 <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Sunil Goutham <sgoutham@marvell.com>, Linu
 Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Jerin
 Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, Tariq Toukan <tariqt@nvidia.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
 <petrm@nvidia.com>, Manish Chopra <manishc@marvell.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Loic Poulain
 <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>, Vladimir Oltean
 <olteanv@gmail.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Dave Ertman <david.m.ertman@intel.com>,
 Vlad Dumitrescu <vdumitrescu@nvidia.com>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Alexander Sverdlin
 <alexander.sverdlin@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net/mlx5: implement swp_l4_csum_mode
 via devlink params
Message-ID: <20251110145831.15872b86@kernel.org>
In-Reply-To: <25ebaf18-f009-45de-a3e4-fe440c42ef19@gmail.com>
References: <20251107204347.4060542-1-daniel.zahka@gmail.com>
	<20251107204347.4060542-3-daniel.zahka@gmail.com>
	<mfuluoi4nebyc4avj52gkfs4nqikn6uwhqnkf4o6xfswtpceuq@zhpokcx6bb6l>
	<25ebaf18-f009-45de-a3e4-fe440c42ef19@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 08:05:57 -0500 Daniel Zahka wrote:
> On 11/9/25 5:39 AM, Jiri Pirko wrote:
> > Daniel, I asked twice if this could be a non-driver param. Jakub asked
> > for clearer definition of this know in that context.
> >
> > Not sure why you are ignoring this :/
> >  
> 
> My apologies. I think there was a miscommunication. I assumed Jakub's 
> question was directed towards you. I have no objection to making it a 
> generic param; I will do so in v4. It sounded to me like Jakub was 
> wanting more information on what exactly this setting does beyond what I 
> was able to provide in the commit message and mlx5 devlink 
> documentation. My understanding is that this setting pertains to tx 
> csums and how the device expects the driver to prepare partial csums 
> when doing tx cso. I don't really know more than that. Especially not 
> something like what the FW's role in implementing this is.

Right, per To: field of my email I as asking Jiri for clarifications.

Since we struggle to understand the semantics nack on making this
generic. Chances are whoever reuses the "generic" param will have a
different interpretation of its meaning, so what's the point of making
it generic.

