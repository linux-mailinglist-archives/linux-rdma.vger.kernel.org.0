Return-Path: <linux-rdma+bounces-18476-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJULMmvSvWm8CQMAu9opvQ
	(envelope-from <linux-rdma+bounces-18476-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Mar 2026 00:04:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D11D2E231E
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Mar 2026 00:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F931303F7C0
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 23:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EA434104E;
	Fri, 20 Mar 2026 23:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="qJ7th6M0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBF33815CE
	for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 23:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774047775; cv=none; b=NsU6kq+B/15o0S6uwe3OwWsjhTMTJjibrUau3z7d/zcdJR8kh7yGfLtdikLeLeas4/+9NNS2kpHeA+LqDNvjsZ+rT5B7Jmxe3WM4lnmrOPnvleYKlm+TvqtXOblNVbK9/aT8dGpnAppZd1pC2Acfh85UAzdMtTgyTvClhiuIjtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774047775; c=relaxed/simple;
	bh=uxsTfuBSWa1Vl1muYsJ8MHd32Ql9tjwtC8tJuO+juZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUp4Sg50v/NUuNfaI7S74tpylAN9/Y7JAE9lrF4fvPj+/+OMS85Rd5UE6RL+bslxk8afbXIX2l4tOXsC3KxawMcYXnyjFwdkk4uz2COumz5jXwsVxk85dJulKF1lAXeI69oGyZmossUQFFucoN1snK5fhmkN1juRuZ36XSwValc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=qJ7th6M0; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso864039a12.3
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 16:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774047774; x=1774652574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfVUvPePCGYdSR1UQEMU0gOzquorWn/jMrt5yfApwXo=;
        b=qJ7th6M079uD1uFRFuwWwNN231TMx0J445mkdPKHk19NLXgB5u0UuMzVZK/1JeRNpc
         DgoFH9YRq2j3VWDSmKHrtQEr0ENGQhz4YHdety35vv0ipuh8yzEouAhjKemFLKS3t9z+
         YEkPVPbwb3tSGVqRtb67kpjK7G0oTBJYXRy/zG6wnGpEHgt8WZk0SAdN0MVcvSDjEoH4
         JsAu2m0Ccnpwb7eTrMZym79wtqR5oEEyOZFXHqc+ON/D+M3tQ0hRo8MEGqzpBsmStkZ4
         JnWJ1F7ftS2VtvWg+ZAkip6Oi9PXdlfrDeC0Fgn8dInys5/abyXmpsMDkAgLe2vTIDnR
         vAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774047774; x=1774652574;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mfVUvPePCGYdSR1UQEMU0gOzquorWn/jMrt5yfApwXo=;
        b=Twjh8v44/Ql1OAROLHV8yHC8PhmNS1FTN0Zb/pmj3eTgVcim845389i5bMQ8hODTIq
         NSLkkicRUzXmhIw+6W/1+Po83e/wzQ8EMHhL60bcgCQ1tyZ0YUumirafJ6/a+C+Zs3I0
         GBobi+TO3+gEdITxCIrmPmNqingY8uu0GG7O5XmvDdbnXQvkzJ6aRNQ37/UNLkMEO7VT
         nOW1IXy2b8Vkui02t/27/tRNtlc+RepNhlXKkFKBXvUcV8KY7s8JGF0WECeAwx3FcF99
         cVSdxuFoysdirTHCGOk+7cYS0ihCWOqVzpPn+pv+zHmfnlzeZins0HOpWEbaX/XwXUpT
         XjHw==
X-Forwarded-Encrypted: i=1; AJvYcCWXWq2CXzZ8FvXxDQZVlsBkxhRn44HUAlTj1T7xVNqLlUKYVbcDeUTTytgzp0HEk8fGk4o8pY1Ey0rs@vger.kernel.org
X-Gm-Message-State: AOJu0YzBz7v4hV2I/SRENt8MRwn4Zqxt0DjAy9jD6Yl62Zr5db9Bg1gp
	5bx7NE5HC9AxgoTYuELfauOmBL/oYZ3ndPewizh/jXC9OIuiz7F4cS1J7p11f/rbArU=
X-Gm-Gg: ATEYQzz6peTGjcLSUhNqFRlx1ITd7tyD13TXqYpE2MPjojwAjI3QsBKL62a1Y+1zOlo
	3xMMp0U7fa68z1Sb+cq1fBLrWkAKQ1S++LJsAg/doaYGYgIvyov4lGSCsNmlmQut0SDsHFHVb7+
	B2MV3qxZfjEEPyNpl74ccSzdW7X2HbdxY3NY3uqGBtoxOLgoIg1ztBuQFNJYOKWUa0rzS88NLBy
	+CU+ZsgNvRtG806FMk98Yqxha9pIEBiftTjqaKOhZieAnc0W+hfltzZ3mebIAqpiH6xsV7Unwhx
	dXKhbnOYFA9J/IsCe9ldnSEGpjKCZlBpe5PL2HxAN1oXITTzau+7Ual2RBwmFlEDllFine22a06
	SAWfuCqtmYcB6LpjYf5l4iV6MIhJByhkzRMZW2bDrOfGLgpTPnW0ZtT56UwXfLhFZBXzcuDQlZE
	1zEkHT
X-Received: by 2002:a17:903:1aa4:b0:2b0:7225:d2c0 with SMTP id d9443c01a7336-2b08277cbedmr47601865ad.30.1774047773841;
        Fri, 20 Mar 2026 16:02:53 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08365a668sm44639105ad.40.2026.03.20.16.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 16:02:53 -0700 (PDT)
Date: Fri, 20 Mar 2026 16:02:52 -0700
From: Joe Damato <joe@dama.to>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 2/3] net/mlx5e: RX, Pre-calculate pad value in
 MPWQE
Message-ID: <ab3SHAtAbfk37dcO@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Tariq Toukan <tariqt@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
References: <20260319074338.24265-1-tariqt@nvidia.com>
 <20260319074338.24265-3-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319074338.24265-3-tariqt@nvidia.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18476-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm20253.cco0.facebook.com:mid,dama-to.20230601.gappssmtp.com:dkim,dama.to:email]
X-Rspamd-Queue-Id: 2D11D2E231E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 09:43:37AM +0200, Tariq Toukan wrote:
> Introduce a dedicated function that calculates the needed entries
> padding in a UMR WQE.
> Use it to pre-calculate the padding value and save it on the RQ struct.
> 
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en.h      |  1 +
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 14 ++++++++++++++
>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c   |  8 ++------
>  3 files changed, 17 insertions(+), 6 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

