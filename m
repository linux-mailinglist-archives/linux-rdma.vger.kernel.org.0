Return-Path: <linux-rdma+bounces-20539-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKMkLp70A2rKBAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20539-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 05:48:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 052FA52CF79
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 05:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6BC93051EE3
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 03:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454AC399CEF;
	Wed, 13 May 2026 03:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNzv9alJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B4F399348;
	Wed, 13 May 2026 03:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778644000; cv=none; b=Moe+7QO2SPd7+Q/kXFUEtkmDKMctW/Nwt46NYuDELkh/7lmBpNViROl03FOSvFRR4QDLc3kA5BAHlicElo8KLcEhHXECJur6eFrXHEyHjtXze7p29ghP9sfxYynse+JfkXbMEkaDvAv49gG2RpjwhAceARUxrtyWs1GabkeilOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778644000; c=relaxed/simple;
	bh=gyb8pfCwFcLBe2rptRiE3sjarGUMInC36meBQ9ZTM4w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hIsMJjCqlhQSwXLxfD8cpho0P8gUsVEqXkXQihweeCSbHeHnStcsvJfVpj+xU0FD3uF0DxhVIZNWX0Vl49mKx7nNHGD5DfRfFvkgkfluR/eHBVEvdh5MgMInr7rpIsZdgMeMS+nj84jiyGcP+2ib57GcKUDSai97ImsSuPF0lD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNzv9alJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C71C2BCC7;
	Wed, 13 May 2026 03:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643999;
	bh=gyb8pfCwFcLBe2rptRiE3sjarGUMInC36meBQ9ZTM4w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KNzv9alJGXZ6074TaCv2GYS4ngVHJYVPI/dUxnPvzStHLbJcuabjlUFQwP+tzgm8G
	 ZtzCXaJY3VEiR4FI/cux8ct2DnyBo4xgtYUtwtQcfNznThE1vIqPSfiVrvgZlvu/lF
	 t9DNyJVcgYV9JAZr+oPCeTVpkZ9oxEm8piGVBQrgKaVzK1knG75N3GfojN1tzGtGYx
	 e1ZCDggEkcV2wc8nxqqNMwx/PO4W09sGPNEK7eTtjYApF65gQyVfylvCQw5BoOP+wD
	 awa11v0/GBU6+oA7XeqHZFLGUDuYZFtN7/2ADm0bvjMN0xY5JKV8eRoHU0330d2NXf
	 c2snDgAszC5BQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F363822D60;
	Wed, 13 May 2026 03:45:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] Rework pci_device_id initialisation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177864394529.3173643.6436794072017399758.git-patchwork-notify@kernel.org>
Date: Wed, 13 May 2026 03:45:45 +0000
References: <20260511090023.1634387-4-u.kleine-koenig@baylibre.com>
In-Reply-To: <20260511090023.1634387-4-u.kleine-koenig@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29_=3Cu=2Ekleine-koenig?=@codeaurora.org,
	=?utf-8?q?=40baylibre=2Ecom=3E?=@codeaurora.org
Cc: mgr@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mkl@pengutronix.de,
 mailhol@kernel.org, johannes@sipsolutions.net, klassert@kernel.org,
 dave@thedillows.org, ionut@badula.org, mark.einon@gmail.com,
 rmody@marvell.com, GR-Linux-NIC-Dev@marvell.com, manishc@marvell.com,
 bharat@chelsio.com, kirjanov@gmail.com, shaojijie@huawei.com,
 shenjian15@huawei.com, cai.huoqing@linux.dev, gongfan1@huawei.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, tariqt@nvidia.com,
 saeedm@nvidia.com, leon@kernel.org, mbloch@nvidia.com, idosch@nvidia.com,
 petrm@nvidia.com, dong100@mucse.com, hkallweit1@gmail.com,
 nic_swsd@realtek.com, jiri@resnulli.us, romieu@fr.zoreil.com,
 venza@brownhat.org, chessman@tux.org, jiawenwu@trustnetic.com,
 mengyuanlou@net-swift.com, kevin.curtis@farsite.co.uk,
 arend.vanspriel@broadcom.com, stas.yakovlev@gmail.com,
 richardcochran@gmail.com, kees@kernel.org, aleksandr.loktionov@intel.com,
 tglx@kernel.org, jacob.e.keller@intel.com, fourier.thomas@gmail.com,
 mingo@kernel.org, kory.maincent@bootlin.com, zilin@seu.edu.cn,
 vadim.fedorenko@linux.dev, marco.crivellari@suse.com, bhelgaas@google.com,
 darinzon@amazon.com, yyyynoom@gmail.com, benato.denis96@gmail.com,
 liuyonglong@huawei.com, andriy.shevchenko@intel.com, rdunlap@infradead.org,
 yiconghui@gmail.com, danishanwar@ti.com, nathan@kernel.org,
 enelsonmoore@gmail.com, larysa.zaremba@intel.com, ian.lin@infineon.com,
 colin.i.king@gmail.com, double.lo@cypress.com, msp@baylibre.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, linux-parisc@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 oss-drivers@corigine.com, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
X-Rspamd-Queue-Id: 052FA52CF79
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,pengutronix.de,sipsolutions.net,thedillows.org,badula.org,gmail.com,marvell.com,chelsio.com,huawei.com,linux.dev,intel.com,nvidia.com,mucse.com,realtek.com,resnulli.us,fr.zoreil.com,brownhat.org,tux.org,trustnetic.com,net-swift.com,farsite.co.uk,broadcom.com,bootlin.com,seu.edu.cn,suse.com,amazon.com,infradead.org,ti.com,infineon.com,cypress.com,baylibre.com,vger.kernel.org,lists.osuosl.org,corigine.com,lists.linux.dev];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20539-lists,linux-rdma=lfdr.de,netdevbpf];
	NEURAL_SPAM(0.00)[0.791];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_GT_50(0.00)[82];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 May 2026 11:00:22 +0200 you wrote:
> Hello,
> 
> the previous iteration of this series (v2) is available at
> https://lore.kernel.org/netdev/cover.1778149923.git.u.kleine-koenig@baylibre.com
> 
> Changes since v2:
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: nfp: Drop PCI class entries with .class_mask = 0
    https://git.kernel.org/netdev/net-next/c/0f5b8332b0b2
  - [net-next,v3,2/2] net: Consistently define pci_device_ids using named initializers
    https://git.kernel.org/netdev/net-next/c/733334d6bdaf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



