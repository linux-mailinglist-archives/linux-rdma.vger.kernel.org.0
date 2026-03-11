Return-Path: <linux-rdma+bounces-17979-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ERkJGegsWn4EAAAu9opvQ
	(envelope-from <linux-rdma+bounces-17979-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:03:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA08267AA7
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D1C930234F4
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 17:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE91F3E1231;
	Wed, 11 Mar 2026 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ki9QU2ea"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13A3361DB4;
	Wed, 11 Mar 2026 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773248589; cv=none; b=Mxg2gw1vInKwoIsQCuZPPpMTxQVGCts43hvKtjUZc4hsQeebxb4hzbxTB2oUHZkDa9qlYU6dVhmjz7FNFK2DDLVNJphvASLSHs2CPT/tTvy0CH6yjr16ZDG2wCmlbtJqnGB/OahTba0+DDe84Zgku8wr5WhV5fFAsd33z0FE/BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773248589; c=relaxed/simple;
	bh=wepTkFTeuLMnNmzVcpdcunpdQXpgY/IEnb2YM6QGnjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FijG++bFokusvXlwdX8klS/00X4V/wzVSmK5ebFbpYZihHxz24ZXzntodem6F2wopyvyva7XuHjOOnm6VyUIHDZWRXThPzYs3zCR0nVK++p3qOCfZYSmkUlMx9mHCvAzOzOjVRKeT1wgZjnZb7Cu8bADHJeQ2X00oTAK7jkey9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ki9QU2ea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288DCC2BC9E;
	Wed, 11 Mar 2026 17:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773248589;
	bh=wepTkFTeuLMnNmzVcpdcunpdQXpgY/IEnb2YM6QGnjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ki9QU2ea0tTUxPPvaI7maUimZ3jVr3c+NH545xtI21jvWZrI0LZnprcu/57nd9tBN
	 FKHak8lD/cNkWp+iHz6IQNIfIrcxh3VizaBV6oqP4wyLotHGA9g7cmezOPUm1sOk5L
	 ge6nZIK6gUbAX7vIB3bT0f0W+H4NA4WSEqzZK/SDkR5Zw7sFSTX3O7DonFPfHYIzdj
	 yG44zv25Q4KkP7TfOb4NZtQtqJV3WLBxjIidvQ2/Rx/NvAvWTMwHibPwav3BVMIGXN
	 ljdYTlOBNN09vfDU+M/3HPySWAtin+SLzyhrhm/bAZiV/BRbxxecPj01rkdTpCCCkc
	 j7FtF6i5PcCqA==
Date: Wed, 11 Mar 2026 17:03:03 +0000
From: Simon Horman <horms@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: shirazsaleem@microsoft.com, kotaranov@microsoft.com, pabeni@redhat.com,
	haiyangz@microsoft.com, kys@microsoft.com, edumazet@google.com,
	kuba@kernel.org, davem@davemloft.net, decui@microsoft.com,
	wei.liu@kernel.org, longli@microsoft.com, jgg@ziepe.ca,
	leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net/mana: Fix auxiliary device double-delete race
Message-ID: <20260311170303.GT461701@kernel.org>
References: <20260309172415.688342-1-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309172415.688342-1-kotaranov@linux.microsoft.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17979-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FA08267AA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 09, 2026 at 10:24:15AM -0700, Konstantin Taranov wrote:
> From: Shiraz Saleem <shirazsaleem@microsoft.com>
> 
> Make remove_adev() safe to call concurrently from the service reset
> and PCI eject paths by using xchg() to atomically claim the adev
> pointer. This prevents double auxiliary_device_delete/uninit when
> hv_eject_device_work races with the service reset workqueue.
> 
> Fixes: 505cc26bcae0 ("net: mana: Add support for auxiliary device servicing events")
> Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Unfortunately the CI was not able to apply this net.

Please rebase and repost.

-- 
pw-bot: changes-requested

