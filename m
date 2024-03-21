Return-Path: <linux-rdma+bounces-1496-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3238856D1
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Mar 2024 10:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111591F21F99
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Mar 2024 09:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D85F54BF7;
	Thu, 21 Mar 2024 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="miYXrVXS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD072C86A
	for <linux-rdma@vger.kernel.org>; Thu, 21 Mar 2024 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014550; cv=none; b=OQbZxsMb7Om0FUdfE2ZdFLoJ2lvLmiRMSH2gVom7K1vA8lvcjG+ReGytFD8WxH7+Zul0Zu0UkIlgtELmYA08LYqlA9oyqpgYMJqFV8JcE7+aUikwXatqRlC47rjbmVu5azJPTCJqQi1DmX49rlYH+KG7vK0u2nZTQxCybPXZ+fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014550; c=relaxed/simple;
	bh=9931IsrYWQDSu/eFeWuyYjb66xLzNhuPeYdZAtOIOoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBnCFeLFIckkhLdNULyOG/TKV5/Flsb6QngQCpJ34pV/192SYvhxnVwQ0tqf/HVo1bNowcC9n6HiaNfzsmNIdcYk3Q9EYlAmv2Un9PICcI4iMk6nnF5e29dPRhTb5elQbaBl2dw+a7xpkfnGa4+9RaajVhKeaXr3czPoUSgvmKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=unknown smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=miYXrVXS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41477452178so490095e9.3
        for <linux-rdma@vger.kernel.org>; Thu, 21 Mar 2024 02:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711014485; x=1711619285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9931IsrYWQDSu/eFeWuyYjb66xLzNhuPeYdZAtOIOoM=;
        b=miYXrVXSlEfx5qibJ7Sc2sNWoY6AlFS0/eu4vqafFoZu/rI9Xq5wBsELMsrFhTFhbd
         j0A5oWF9BJ0SALTXZEhadHvL2oJuuGC2oouvKy2/IKSO9cVqdnne6Ti0E6jh6n+gVHCK
         W8QSLpoAh7bituULcgafsvCcoJjDOHiB9F86ivs0g89L6mFOv9mdbdTaFgkmpUQacxBE
         Fch7MTg2sjck2sKCawohRDqODxnumgW0B9A761VOnmGWj3voIQSOFsrdHZ+alV6Ivl6m
         AI/yugHz0DyEZuI/aOMrVTzvFrPfBE5j3pUt01mk6+y+SltmLTLaK485eWmVWp4cVf8D
         TEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711014485; x=1711619285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9931IsrYWQDSu/eFeWuyYjb66xLzNhuPeYdZAtOIOoM=;
        b=hLDpwBeFNbkB76TENTxAjdhq1pJtAL7R58S7oiZtb2DB8kqpeGOjGXl9FXNEn2EhJj
         9o52OGA8JxuqwA1rR5BhVtmj+lJWYq+RGkz4JDlk9W83bR+2pn+dRnIM5X8tDFG5Iigd
         /Eci3uhOvTlG1ERUR1RUaGNKnX0DRxh4MCfEqbEfOMezcPtxqkkqIzPHfLraTQLh5t/p
         C+0/t4zaVQZeqpQApbZD0aUye7ZHB4+bkCB0g/fl3dGpGgxfweZzGQawOi4gy7QW010P
         kvfdJdf1HVg/ZUQI8ENEnErZXT/KBHXCC2oskJ5UvM2xXaPC1EuxWmLkw5ZIGeDdvbQi
         xFcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmHWVrXukCc1TjP1aD3U21LmylfuijfrZRiygoeoi0QoykKjH6apW9dh1BFL2/A9DvgPArFDoK/QLgbhe2aBRDJUsw3YTQU/qYwg==
X-Gm-Message-State: AOJu0YzimXRJVmu2VMFgfPf13ZdxgjFpZZ2rtRT0u/w7Ut+HrIJwHB37
	iXa7B7RWDvL4pMdRWYp9L8kdGdKewy7mkfT6QkNBjq7af2VcvDu2zdD3aPCyf3Q=
X-Google-Smtp-Source: AGHT+IEn5hYdjsCtQC65m/BjBIh/ND0BhYzUdLoyJ6ghkDCvpjzUTuQBbg+fUfWtBghy6AQsDI/IEA==
X-Received: by 2002:a05:600c:63d0:b0:412:d149:254c with SMTP id dx16-20020a05600c63d000b00412d149254cmr1189143wmb.17.1711014484620;
        Thu, 21 Mar 2024 02:48:04 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c451100b004146dd6bfe2sm4276212wmo.47.2024.03.21.02.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 02:48:03 -0700 (PDT)
Date: Thu, 21 Mar 2024 10:48:01 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Alex Vesker <valex@nvidia.com>, Erez Shitrit <erezsh@nvidia.com>,
	Hamdan Igbaria <hamdani@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v3] net/mlx5: fix possible stack overflows
Message-ID: <ZfwCURACC48Injgk@nanopsycho>
References: <20240320180831.185128-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320180831.185128-1-arnd@kernel.org>

Wed, Mar 20, 2024 at 07:08:09PM CET, arnd@kernel.org wrote:
>From: Arnd Bergmann <arnd@arndb.de>
>
>A couple of debug functions use a 512 byte temporary buffer and call another
>function that has another buffer of the same size, which in turn exceeds the
>usual warning limit for excessive stack usage:
>
>drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c:1073:1: error: stack frame size (1448) exceeds limit (1024) in 'dr_dump_start' [-Werror,-Wframe-larger-than]
>dr_dump_start(struct seq_file *file, loff_t *pos)
>drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c:1009:1: error: stack frame size (1120) exceeds limit (1024) in 'dr_dump_domain' [-Werror,-Wframe-larger-than]
>dr_dump_domain(struct seq_file *file, struct mlx5dr_domain *dmn)
>drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c:705:1: error: stack frame size (1104) exceeds limit (1024) in 'dr_dump_matcher_rx_tx' [-Werror,-Wframe-larger-than]
>dr_dump_matcher_rx_tx(struct seq_file *file, bool is_rx,
>
>Rework these so that each of the various code paths only ever has one of
>these buffers in it, and exactly the functions that declare one have
>the 'noinline_for_stack' annotation that prevents them from all being
>inlined into the same caller.
>
>Fixes: 917d1e799ddf ("net/mlx5: DR, Change SWS usage to debug fs seq_file interface")
>Reviewed-by: Simon Horman <horms@kernel.org>
>Link: https://lore.kernel.org/all/20240219100506.648089-1-arnd@kernel.org/
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

