Return-Path: <linux-rdma+bounces-16692-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEuIG8Vfimk9JwAAu9opvQ
	(envelope-from <linux-rdma+bounces-16692-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Feb 2026 23:29:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B651150FD
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Feb 2026 23:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 75EC0300C0D5
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Feb 2026 22:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB153219E8D;
	Mon,  9 Feb 2026 22:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="LzMDKqa2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A179A314B77
	for <linux-rdma@vger.kernel.org>; Mon,  9 Feb 2026 22:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770676160; cv=none; b=hLH7cCq5hqS39hL1HxT6K/JAg32GRcS1RxrckP46j008HrGrmM7Ffj7hcv/AlmH+SfKaG7Cs9ycpGo1CD49Nx71n8OJCnNfdUTm8lAZ21bw9uO8C9Pn5A7CYRWN0PiNZB5/HtGFCqd5uj/ZnAypgRSmqf4yP6Vo3Sa7kQvrF8jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770676160; c=relaxed/simple;
	bh=Nr1N0H3pSkP4c8voFYnmLPhyJBsZyqWCpYU6bfP+hJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ey0Q8ZAMBI31ma6Nug7i9LIL8fPx0Ckg4kY2RIbyzuH3RnGs0ZGjJmr6ET4m5IWy2VNpaNY051MzpGmanFr7WptCVDreWiAJm5g5Z7XP1rPn8uLHoNxTrOI0HvJqg+k+LnDuIVRBKzq7CGvTOiVlc0mftjzpOTItAoenheh0w/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=LzMDKqa2; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81f39438187so3489319b3a.2
        for <linux-rdma@vger.kernel.org>; Mon, 09 Feb 2026 14:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1770676159; x=1771280959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNxkziu4XGMl5hWhbE+nivct6z2dxKwIWkkdafKfMBI=;
        b=LzMDKqa2eq80BWDRmLxoQ+kYERd3N3rYbuRi9ihD9v/g9Eg694qJFtHHd7nBreD4h+
         cya0lveDSou1Oc4wxK2bPC3KSN1S/qeld+5hxyWF0RsQKRwEklnl9fnaNwLhytduojrd
         cJ8SqEtKjkR4PixgXYDu5pv1F5oGYx2wVdnbHXYkeMP4q5J8Hd6UazawzbQjwUtrV8xk
         0EP1TviWgdmGdQmnbbBBrrHwaeCpwmy6oGOihNSdqD/yp3ZoyTpGvzWoKTOvbKu1K5nM
         keivAU7BNEcqEVUwIU1SN2ivB9WgmkoVcrY6J+6K8BCcfcNnRvrdAIcbNNqeW1A9teKj
         qFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770676159; x=1771280959;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pNxkziu4XGMl5hWhbE+nivct6z2dxKwIWkkdafKfMBI=;
        b=npWzyP7UvsJ3qEeZsXnTBL/Je7F0peisBpiGWuJO4G/4Dc9Ico4n+h0KD9aEm2OD+F
         SDAD6q34rhng26JJ6xv9JQ7yqPQBHFNJAQ1cjxy15Uj/nRrT3hbmcL3rivplGPDzDfF7
         M+vFXndvhYprXq8GeK8XpW9UP67ICYRf4mvG7ZmWghR0HRSV/eTt1m1OvUb6P3OzUO+u
         dXHwXdxxzOBO/tUQMHJRMaWZsacvzrIopCWCNiD5unESfIoqn0WQ2GqbFyojC22ICo/E
         XqXq5mA0uyEJFnMdL/D1oOHCEGxH3KpPJIs3UW1vLoFWXU+D1uUzNiEGB+w0i2+LUmKi
         BHgg==
X-Forwarded-Encrypted: i=1; AJvYcCWR1Q/lkRLLKGiLF/fBuH2P1eyUqB0N4Q4pLko2yu+DcNikSEOlFcbQazF9LsBTW1I7geq5LSA3anS8@vger.kernel.org
X-Gm-Message-State: AOJu0YxmugDxSZa3516c7g+bdNwz5R2v9jeBPrBhG2DsN8Rk0iIu/CEu
	TKVXTU8ffRvZzeV13H1X96bGqPT0//RFqO3rA4LuPqTVzRl5OCcONcB6RBMsE6mvyhA=
X-Gm-Gg: AZuq6aIBLcjYn19nYsLuIuniL8Sb+d3ZWplnyyfD3+RuVFvEd+W2rpPeJztY5+Vz3Up
	c7jMU690nCcjB0Fpo0XVwqVMhUIqs3Y8097JFTY3wZ7RkbhjPdLSrBTSDWselW6pepr8yvYqPyR
	xCq4kItlAOOfe8sHiTHErfKewPFgT1xNOBotFU/P1SZKyiWd09ciI5KDRGqv4jVzoO7gwhOXFlD
	51k4OPrkc1swKunEm4gGp6BYRtZf9W75v8W0GO8G6B4CuxCerT5bTRiWzzebUHh4gRf5AhDqxzZ
	VLjyroCGXBa98KbXMWpW+acQGbK67uXhUuUG1ZNedZr6P0YFe11dJyAWqkOUNVvvDh6T/y7ZBAy
	Ujcnjq7n42o+lZc+2ls8oARaoV7TpeWTtd9zKLs2FrZIScbdIKDnUBX1IWv/0wodhr9Y=
X-Received: by 2002:a05:6a00:23c4:b0:821:8084:f8c8 with SMTP id d2e1a72fcca58-82487a96405mr192390b3a.37.1770676158936;
        Mon, 09 Feb 2026 14:29:18 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82441690235sm11786287b3a.18.2026.02.09.14.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 14:29:18 -0800 (PST)
Date: Mon, 9 Feb 2026 14:29:17 -0800
From: Joe Damato <joe@dama.to>
To: Simon Horman <horms@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx5e: remove declarations of
 mlx5e_shampo_{fill_umr,dealloc_hd}
Message-ID: <aYpfvUPnuItSadw+@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, Simon Horman <horms@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20260206-shampo-v1-1-75b20c6657e5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206-shampo-v1-1-75b20c6657e5@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16692-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,devvm20253.cco0.facebook.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 12B651150FD
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 11:18:51AM +0000, Simon Horman wrote:
> These functions were recently removed by commit 24cf78c73831
> ("net/mlx5e: SHAMPO, Switch to header memcpy"), however,
> their declarations were left behind.
> 
> This patch removes those declarations.
> 
> Flagged by review-prompts while I was exercising Orc mode locally.
> Compile tested only.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en.h | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>

