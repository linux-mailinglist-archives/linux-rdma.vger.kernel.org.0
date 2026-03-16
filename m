Return-Path: <linux-rdma+bounces-18189-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ0gKL0xuGmvaAEAu9opvQ
	(envelope-from <linux-rdma+bounces-18189-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 17:37:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FC229D7DA
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 17:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15F6330ED1AD
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 16:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F84E3B893C;
	Mon, 16 Mar 2026 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="I0gsVnV8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43082C11CD
	for <linux-rdma@vger.kernel.org>; Mon, 16 Mar 2026 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773678698; cv=none; b=igPmrQW3rISle2CSWm4PzREr8SBBG1QOCvJbz3+PrMaEK8BcjD7GoOfbN7Zf09Z3rB8ImpWfZTHPkv3maQun0DWWIEHXM7jKg+Hb9eITZHFIUtoy7MzcTgT2/jzoM82i+jU96oUuu+Bgbm9Gq7rBmpwAC0+3LBTTmWH7Yh+EXS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773678698; c=relaxed/simple;
	bh=weUvuiugfWiI0Sg/ND1RsnpboRhIU5iRpS1NkIweLQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Usscu4hh/qnzONmCvwkvL1lMNW/HtnRFiWDtj6u0NkkBBYSGE5U15SdhU33HHmecUw4UeLDwjgBPnWSG6WgpzH3OlJE2jmVEi/I64I1Us1MIcjUFq7u68nSUOLLRtN+mvKdtyVdUeaSUwq41BU5SzeIJN63AvetpiJIFQ+1oa6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=I0gsVnV8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b0586d5bb8so8627485ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 16 Mar 2026 09:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773678697; x=1774283497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYHkrP1b0p79WeAJVelEfbeQEyFeubJRPvMAd91XCok=;
        b=I0gsVnV8rgg7XDdBRr2scbCmFbB86Q1l/+aMhZLeX+ovVsAzo6DKGjMFKliHcGUldh
         6o4jE61/Q4apP/AvP7dezSS4nN8ZcVzGYBLxcpkA0R83I70tQQpEe1t35Ol5u3FxgvwG
         JMLmL2DiRjHxUjipqF/+HPP3tMdku4MFTXwgB/sJTJxgk2DkdB4ttlWxAysLt1tVh6T8
         H3yBZWD4GOGtoAeCZgSsW2D1aA8d/8exrPvHqVTdl+of4lKuWft1LgKIKDMQmcUuGnY2
         mVwe4saU9kfWyLajcvqDwNVwKjQUs/plMyixjuWtxkcdPZ2OFl8VYA4QAdGoVhnfM1ju
         jXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773678697; x=1774283497;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYHkrP1b0p79WeAJVelEfbeQEyFeubJRPvMAd91XCok=;
        b=Pl81lLVYNZEaQHZDfSKfuMXBUlvT9L/JTO32qmDux10epVlFbFrC+J1jO4Zqj4iIWv
         dcYsjil07icRlPXFoWTD+cnzR8ETVFIn4pXupBs3zAwW3+mnwCTEcv/gwwmyPwbi26OI
         1kQtp7GdYeqPPrisAqiKy8iSKFwN4v5H5Q2yJcR9l2M2NospStWXzVPiaT4KJmuoNwn6
         aEesAh5abiYdsiZa3SCD0lcq6iMg2A3H+K/b5GPXoFE0hsolk7iJhUsUw6jfpRuaYPwf
         AcKv/2tyUjp22P5Jz7TX7Gcca9JAHGIvqtlgw1WKqqF381m2AUvjLbx7Mi1Pq8y+GNaS
         mBzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi2qqXKNvXenvJTo32OzMxaY5g0vUH36ykA3yZUVjUcHPV+aOI2K6QuNCIHMwvUQBFNyVR+LJpc4zX@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzg7Y20y0fKnC+MKp6Xwa0pPqxxmBBESD27eOyhqRUd019TCGi
	yNTDVeeymwVLbdKMrlhTh4pdDELTWSThbkbnVf8Ke5/QIJtR07nIRsoW7g4NHc19pxI=
X-Gm-Gg: ATEYQzxDXYI8VzqlqwQF6814qd+ac32+OEv2kezpM5WfQta2WdivwqS2+GGwrAlCvSW
	DIWHeG4yj/7VTkOS78Tx42PE7JsvvVRwl0JBBlxuX6oae9bCp8lAvvzKz2XYTLAV3TMyDEft6Ts
	ycln3DoItOcN6pQ9+kaktTaunYaAYJ+/WWG1wE0rm7vOXCp0ooxA14kddBeAO4MW9e2R9NQf4Gj
	crwucQCkp/yI1sFfG+y56q05mue+I/tWrbdITrKwdCNZB5tuIZJfa+SyRBwPOKFYLbxTM4LXnJu
	hL3vTntPyBA/NIk0cA2tF4u0JSeWSH2PdlSUk2vZRhu0aUHf9qRkFOAJm7aNHPuF56B2GdigLaa
	xLI/tiwscKHR0zx3gL33825bYFVOyi2jDcJXjs3VJ01PPoPDr+dW7jcxC7sbj3537aFLZTZb+Jy
	iWrCUa
X-Received: by 2002:a17:903:41ce:b0:2b0:5968:a6d5 with SMTP id d9443c01a7336-2b05968aa46mr35648275ad.18.1773678697057;
        Mon, 16 Mar 2026 09:31:37 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece8453cdsm107729715ad.84.2026.03.16.09.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:31:36 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:31:35 -0700
From: Joe Damato <joe@dama.to>
To: Ryohei Kinugawa <ryohei.kinugawa@gmail.com>
Cc: rrameshbabu@nvidia.com, saeedm@nvidia.com, leon@kernel.org,
	tariqt@nvidia.com, mbloch@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] docs/mlx5: Fix typo subfuction
Message-ID: <abgwZ0ye440CPdVw@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Ryohei Kinugawa <ryohei.kinugawa@gmail.com>, rrameshbabu@nvidia.com,
	saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
	mbloch@nvidia.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, skhan@linuxfoundation.org, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260316015621.41630-1-ryohei.kinugawa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316015621.41630-1-ryohei.kinugawa@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	TAGGED_FROM(0.00)[bounces-18189-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim,devvm20253.cco0.facebook.com:mid,dama.to:email]
X-Rspamd-Queue-Id: 04FC229D7DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 10:56:14AM +0900, Ryohei Kinugawa wrote:
> 'subfuction' should be 'subfunction'
> 
> Signed-off-by: Ryohei Kinugawa <ryohei.kinugawa@gmail.com>
> ---
>  .../device_drivers/ethernet/mellanox/mlx5/kconfig.rst           | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
> index 34e911480108..d549b43e00fa 100644
> --- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
> +++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
> @@ -120,7 +120,7 @@ Enabling the driver and kconfig options
>  
>  **CONFIG_MLX5_SF_MANAGER=(y/n)**
>  
> -|    Build support for subfuction port in the NIC. A Mellanox subfunction
> +|    Build support for subfunction port in the NIC. A Mellanox subfunction
>  |    port is managed through devlink.  A subfunction supports RDMA, netdevice
>  |    and vdpa device. It is similar to a SRIOV VF but it doesn't require
>  |    SRIOV support.

It looks like "subfunction" is mispelled in the section directly above:

  "Subfunctons are more light weight than PCI SRIOV VFs."

Maybe fix that one too and resubmit the patch? If you do that, you can feel
free to add my tag:

Reviewed-by: Joe Damato <joe@dama.to>

