Return-Path: <linux-rdma+bounces-22429-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ffmwDutNOmq+5gcAu9opvQ
	(envelope-from <linux-rdma+bounces-22429-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2026 11:12:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF326B5A4F
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2026 11:12:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=queasysnail.net header.s=fm2 header.b="b eFqV/F";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=VTsXWTFi;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22429-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22429-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B459303D818
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2026 09:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909A83438B1;
	Tue, 23 Jun 2026 09:10:59 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425072D4B68;
	Tue, 23 Jun 2026 09:10:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205859; cv=none; b=VgIr4OlKwKtKdAoEnJkVgPZmJnVJmRnA3wbduTcZQg0blRUSFSuqfrxxR9FfwV7ngJYJLmZTZfyrW4SFVgb2RgblcM1vUnJfSz7R6efvkcUnPANFZjUOtDgDDDfZH8HstMwZFDlv/VSSxCvE3YjVK357i1LsF+HN3bPxHwLyjoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205859; c=relaxed/simple;
	bh=H0ejhMob9U1Tp7NLyQih5D7xrwz4zP/ui9ghCzP4aqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeX5mXjPAXSY7L4TstosWWwRurolLaliHwGeZGoYYLbgvo0ZEz6EQtmMPJC15IVGTqpJfeCECcqJMMx9NLR/TQHMGlbsjCetRFv1ukgdxofb3v7SdnPVBPSEzG0Nf6okfoYVUatvnln5T5ku/8x6V4y3qk5yYKLdNUiHUo1ZTy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=beFqV/F7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VTsXWTFi; arc=none smtp.client-ip=202.12.124.152
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 165347A015F;
	Tue, 23 Jun 2026 05:10:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 23 Jun 2026 05:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1782205854; x=
	1782292254; bh=8hZD5mizY6mE9lDCe600zLjaG96JwIduRGgsYhIAe9I=; b=b
	eFqV/F7UtNB0TBq0IIZZGfPqfFTBd0IYWOHhLqFmk8Xiqss3EYR90wSwDi/v0GYR
	m/37H3TjWdnOyJcAxnxnG96iiRQVkMg8i8jkuIufAzObUIUuzVRM1SF/LQuQKc0j
	F9JH3wOplE1rNStXLwqwBKJuF4kxnwcgjjxn7J7QIvu/5T/Rca0NciCs4Prz1MfW
	5fdA1BA+V0SIVS9kBrAMQTSaKHnWQ8RvM4ZnJuBXSyZ/Em6eABk3xQxfwhcjYWGu
	UttFFyabF62zRmHXylJCzqho67HRZYtM1tB10/MpGnShn+oBavQzXILUEjRDqkE5
	SgVnyNxS8dQvwKBIJNcOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782205854; x=1782292254; bh=8hZD5mizY6mE9lDCe600zLjaG96JwIduRGg
	sYhIAe9I=; b=VTsXWTFiZo/w2/i5o4DbnDqkLyw2vCn9mAfNRU/UkZGJzrEO+xc
	uy10sWJenOnFD8fP5uBYaweuxOi5Vf54CuxWsAO+8TolYZCJEIkbJE2gZwtzXK88
	yHqKk/TFaKFJJTuYD3/eyYJ/OXXiWgED2j1ADcYIGgfeUOXc45rqPIiId3IfnOoX
	8R2EC5cJXKFC44N5SPLRisj7rE3o+WqKH/5dYUqghycwDVk8pw3aFG/CmfABrAuz
	r3GrFAjH7D/6NJ//ApyWbVdBvwYxbyMJjxyf10n7MGHRwoAaAtpwTvV+28KyAPHF
	36BbpJ1i5tbrSDtXpSDCbBcexI9uKjO7FPg==
X-ME-Sender: <xms:nk06amji6U1cneISU_LV-tNczGrwqX-ojUn0jJeoj6JfrJN_sj99SA>
    <xme:nk06an9UF3JbkItc77S3QWLKnijqXnCmxF50NYCEeugIsg6V3EmYBf8Jq4NdsFMNS
    NObQjIcUXZKtty8luZIs9DRraRauQHzusGR0jtLvxk6cPa-Ak0bKeg>
X-ME-Received: <xmr:nk06auYZmm8xuMPtP-kyMUqJ5A3b4K8urb4KwJgluY63LWRZD3UA7JZMw9uk50HTFPP2AVLPr69Nl--W_OS0ZfA>
X-ME-Proxy-Cause: dmFkZTEZ26e5DWSZZNJ6NO2CAGw1Wd8AuwmZtVtuY9zTCrJXg2jF63KkKQWmSfegBPLJpH
    /0KzGFi5gcfsMWGJefzPH6JR8um+ccoGk2BdPu+9TADe/Z62pgCUNAWsk4s7Gw482gKDd4
    bQtzq1zdT79L0U2SJ9zzIeOPdnhNpVOUR622rzOiPb2ZaVu9y+0V/8T99l705kcGvMbJOG
    YeXzfqG03OCM0ylXMnMIGQBJBIoKH40Z0eZZzJPkRaGH6ehtES+bqyy3/TndlCYUQKXo2Z
    Fn7zf/mTmKENN/1l6gRxCOKf5/bkWMAAu4KpaDkDDsQNbN+NZlVYrwTawrztbL2Z0/KuD2
    m5gttXcaW79O+igZDGeviVmBTlH+7syG/XPCDiMi/nZWEhyIUE92ozYxDykmXJDQyA1Mri
    4ZpELle3+F43/q5Omj4/q7XINXaDiJN3+VnCMLdHGELWHrqkb6HOLz1gZ8R5xl8ivaV5r7
    PIlDcGk3Uk7NeZ9msvaAPxIAkLH1O8vJoOZyT1bnJT3VvVhNIJDppkLffzkTQZQI91wtK+
    Eb8fyyfJnEcHfreRIb0/NCJcSKwSmdTNdK16xxf+Y95EnIqJijmQFXZzdTlqCnIrhg4p4x
    ZCUnGuZN2fboAqajHBVfh19M4dDqrH0PvH6bcL7y2WXZPoFbKIMVTk1H+BBA
X-ME-Proxy: <xmx:nk06att0a_nSnJIFPDJnNru_rFkDVTSynUbbsw5EfcDY1gCZ1G_XiQ>
    <xmx:nk06aqkllxvDWusrpPERAvftnr_f866TmR9-jXI5zobTRLBnNlZ3iw>
    <xmx:nk06atydQRoCSltBS3ZWA_eysLFP1L5VHuIBu9vgxRC8WHbuLUFQlQ>
    <xmx:nk06aux6dTPSo8zJ95JPcuMGG4OspXr-zeP-MHjFNg8u8UO1u5gwRw>
    <xmx:nk06auTwgSbHnaPHkJCblc1hTLvDwHS24lb45GkPJQkL-grtKNttCkY8>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jun 2026 05:10:54 -0400 (EDT)
Date: Tue, 23 Jun 2026 11:10:51 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Raed Salem <raeds@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [net] eth: mlx5: fix macsec dependency
Message-ID: <ajpNm2ULHJ1QgSAy@krikkit>
References: <20260622124229.2444502-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260622124229.2444502-1-arnd@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22429-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER(0.00)[sd@queasysnail.net,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:arnd@kernel.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:arnd@arndb.de,m:daniel.zahka@gmail.com,m:rrameshbabu@nvidia.com,m:raeds@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:danielzahka@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,arndb.de,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,messagingengine.com:dkim,arndb.de:email,krikkit:mid,queasysnail.net:dkim,queasysnail.net:email,queasysnail.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACF326B5A4F

2026-06-22, 14:41:07 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Configurations with mlx5 built-in but macsec=m fail to link:
> 
> x86_64-linux-ld: drivers/infiniband/hw/mlx5/macsec.o: in function `mlx5r_add_gid_macsec_operations':
> macsec.c:(.text+0x77d): undefined reference to `macsec_netdev_is_offloaded'
> x86_64-linux-ld: drivers/infiniband/hw/mlx5/macsec.o: in function `mlx5r_del_gid_macsec_operations':
> macsec.c:(.text+0xe81): undefined reference to `macsec_netdev_is_offloaded'
> 
> Fix the dependency so this configuration cannot happen.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

>  drivers/net/ethernet/mellanox/mlx5/core/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

...
> @@ -144,7 +144,7 @@ config MLX5_CORE_IPOIB
>  config MLX5_MACSEC
>  	bool "Connect-X support for MACSec offload"
>  	depends on MLX5_CORE_EN
> -	depends on MACSEC
> +	depends on MACSEC=y || MACSEC=MLX5_CORE

I'd never seen this 'configA=configB' syntax, cool.

-- 
Sabrina

