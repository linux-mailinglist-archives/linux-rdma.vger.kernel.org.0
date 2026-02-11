Return-Path: <linux-rdma+bounces-16761-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEZGFWR9jGkcpgAAu9opvQ
	(envelope-from <linux-rdma+bounces-16761-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 14:00:20 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC301249F4
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 14:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63DC7300609E
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 13:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9992192F5;
	Wed, 11 Feb 2026 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CP1mqy65"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08D020DD48;
	Wed, 11 Feb 2026 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770814811; cv=none; b=RIOaBc9Q+TIumAytUjguZd2aDb9hh5Uv5yldpjGZMymIFGdGLeYcg6eqycy/mna4a+sFv9x1RHHwmVfysvfzhgHLhZTcZKQpf7g4alwIcW+vifUL13qVIbARfZDjFxBQ6A5kd0U49lw54Z09PuBR1Cc2ssx8Ltd38m/0lGB6tZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770814811; c=relaxed/simple;
	bh=JZl/CznCATR4F0IOpuGbm0/zx4dFVYl6o3m2viLAbog=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pOKJhYYKQOM23IsDnMwkZsDJIFexsTC8FDJP3yLG9TYgqgtURoTuQclirbkKhZYCgXuAS4YijGO7Bq1yolWiXFfwccTgx8jIiBuHDY+eyte9EYBew8BKu2ZBsz40GcGuoMGE7z7URmtVjb00hyfyMuZw5Es8/IAXaBN0igoLauw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CP1mqy65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611A9C4CEF7;
	Wed, 11 Feb 2026 13:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770814810;
	bh=JZl/CznCATR4F0IOpuGbm0/zx4dFVYl6o3m2viLAbog=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CP1mqy65UgHmMzLV7CZE+kowke85NhxxFhPSGYtVfSVGVsyVpcEb+RDJgn4LmrlPg
	 EOEhLSO0tr6Oxcp5tWjih6Eg5H/aqsr42cSh1MlcKMpvAGArGjvB9bGAR9iBVnz2Re
	 fL35gURFtBCajxeLyMZYNInp7oCSBLxmfON1SQpmqm28vmAskRjh00TfC0Wzt91K9O
	 WkEs6dL8sjBk+wMF//+EUqjNgR8sbLlRPy/oCNILtIwbKhBlgGIiJY72evp8wf3rps
	 jYJ2z5JgLeH/aAYQAGQgWozq6nDyktCrPoWzHLxWid3kQYKGCy8RBDaikNHjN9hqzt
	 aGD3lsZBLRIMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 850CB39E961E;
	Wed, 11 Feb 2026 13:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] bnge/bng_re: Add a new HSI
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177081480515.167918.7757048918452864142.git-patchwork-notify@kernel.org>
Date: Wed, 11 Feb 2026 13:00:05 +0000
References: <20260208172925.1861255-1-vikas.gupta@broadcom.com>
In-Reply-To: <20260208172925.1861255-1-vikas.gupta@broadcom.com>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 rajashekar.hudumula@broadcom.com, ajit.khaparde@broadcom.com,
 siva.kallam@broadcom.com, bhargava.marreddy@broadcom.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16761-lists,linux-rdma=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6CC301249F4
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  8 Feb 2026 22:59:25 +0530 you wrote:
> The HSI is shared between the firmware and the driver and is
> automatically generated.
> Add a new HSI for the BNGE driver. The current HSI refers to BNXT,
> which will become incompatible with ThorUltra devices as the
> BNGE driver adds more features. The BNGE driver will not use the HSI
> located in the bnxt folder.
> Also, add an HSI for ThorUltra RoCE driver.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] bnge/bng_re: Add a new HSI
    https://git.kernel.org/netdev/net-next/c/42d1c54d6248

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



