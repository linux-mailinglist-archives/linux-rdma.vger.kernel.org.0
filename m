Return-Path: <linux-rdma+bounces-14218-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4379AC2E3CA
	for <lists+linux-rdma@lfdr.de>; Mon, 03 Nov 2025 23:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02363BE81B
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Nov 2025 22:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E4A2EF65B;
	Mon,  3 Nov 2025 22:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTLqZ0hL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79572DF122;
	Mon,  3 Nov 2025 22:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762208039; cv=none; b=J58EgCYmMRU3f82z+pu3e01imxbx5L8ltxNuqRFsEqIMFFKuLL5j54mC+A6vcypA0Urj0UKbpLz6GbqFYKYdFVV/7oiFe1n+uJ/nmmeNqyWa4IrMHA0ZCrolKaKXF71zAAmgwj12nZin3uEEc6gjDJi2eFHBdkwhopD5nFyX600=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762208039; c=relaxed/simple;
	bh=G5G/nJ6BwUDbjhos8smIO/3KjLQpgzD5ntWtzL13rts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DS0P2BjMSjQokhmuSHQORVqSaE5npmz5x9g1twdhfptkWvDdwf8lcHjDulSjMplLDlAZLV8MDPtKonq/+zFKTL8q57oIdzp9Q0oEksZnk439CSgphQ6yuvqSDm8oU5nyvbqlR8HG7gYbS28sKAX/YlxwNvRtSr1n9t6cPycrAeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTLqZ0hL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CA6C4CEE7;
	Mon,  3 Nov 2025 22:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762208039;
	bh=G5G/nJ6BwUDbjhos8smIO/3KjLQpgzD5ntWtzL13rts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VTLqZ0hL1/6PHxQ6NOhzlLM6gCmDmZLOEBjsopkNlCfT1UDEUzEpPJ9dRNKIC0lpk
	 5IP+NEjFrjtzZVi9MxoejBWIBOkHCXcmGUgODEYUdCpVLHPVh0cAJSOTWB1fhrl1iF
	 z5hTda/0Y1Q5VJjkd598Vr+sNABtNOoGLJsImaT4TxCqGru5AW2vpM+yUdVgTQvw9e
	 /xQrqh0iCogqr918cBXp+vPSsanb+KqgUvy7E+gfIndbbpFuHJomc+J7CSVORGK8ey
	 IER03KXPAHJ9fglF87N61IoFLE7kR2HkjQvV097joGTXbveYEVNBBe/8GgHu9hoePF
	 1hperBfe4REqA==
Date: Mon, 3 Nov 2025 14:13:56 -0800
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
Subject: Re: [PATCH net-next v2 1/2] devlink: pass extack through to
 devlink_param::get()
Message-ID: <20251103141356.3470701b@kernel.org>
In-Reply-To: <20251103194554.3203178-2-daniel.zahka@gmail.com>
References: <20251103194554.3203178-1-daniel.zahka@gmail.com>
	<20251103194554.3203178-2-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Nov 2025 11:45:52 -0800 Daniel Zahka wrote:
> Allow devlink_param::get() handlers to report error messages via
> extack. This function is called in a few different contexts, but not
> all of them will have an valid extack to use.
> 
> When devlink_param::get() is called from param_get_doit or
> param_get_dumpit contexts, pass the extack through so that drivers can
> report errors when retrieving param values. devlink_param::get() is
> called from the context of devlink_param_notify(), pass NULL in for
> the extack.

Warning: drivers/net/ethernet/intel/ice/devlink/devlink.c:618 function parameter 'extack' not described in 'ice_devlink_tx_sched_layers_get'
Warning: drivers/net/ethernet/intel/ice/devlink/devlink.c:1533 function parameter 'extack' not described in 'ice_devlink_local_fwd_get'
-- 
pw-bot: cr

