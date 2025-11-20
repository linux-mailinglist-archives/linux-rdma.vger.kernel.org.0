Return-Path: <linux-rdma+bounces-14653-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F62DC74AE0
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 15:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A56E634CBBF
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 14:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860E8334C32;
	Thu, 20 Nov 2025 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1KgjbmiQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1412DA760
	for <linux-rdma@vger.kernel.org>; Thu, 20 Nov 2025 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650361; cv=none; b=B4pl54pC89rmwmDlf8Oc5tq84T/e/ohzs8tWOw9DnN8krJ98xDDD5WUwbYvNbNTfBwu+Qf3W9cs+G2Bn/A8Lz6RPBY81KzKuipiU0TeyFFmrSq1wSf3aLx683WmV+xy8kGtYvGgDEeteM6gWnAp39EkXx85NhEfh2BqjijUOdAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650361; c=relaxed/simple;
	bh=qlVoOV1b0m1EsqTqevKebTa5adC2s2q0Xm1TYQIEY5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXFdBvsLadDgc8e0KqlARcwpTj7dcRV2emPewBvppTCK7rWJY8NZ+QsdXWaoFoGni7ASRFAT3uUqpbcEAhExJ2yxgcaw5Ot5PwvqPYi2kL8oCQv40cTBLVYTiWhGRsdq8A2yTmP4gPgJ2kHgyLz5CWeGnAYlNEaSNq1NEVmRLto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=1KgjbmiQ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so1320303a12.2
        for <linux-rdma@vger.kernel.org>; Thu, 20 Nov 2025 06:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1763650358; x=1764255158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qlVoOV1b0m1EsqTqevKebTa5adC2s2q0Xm1TYQIEY5c=;
        b=1KgjbmiQcA2RVz54IvXXlSdGGsuG++U7UX4hfHSFB4tLAKJpux6kPxygEldzuHAZkq
         wdoXebLApjfbrZ+2yY2brZByqzAdbURTMN5OaBc6uVa9cnhwXNHvXB/6mvg4585jXWdo
         68uGnDjlfRdY2UK8IguwYer+G2pbFtwRfye2PlZ1YIAqq6xWLlt16XlrSBvRrnLMZpNR
         x9tHhhmEBnj8LPysGf/Ct+Hxxl3JThedC7OTgE2wLqEnKL2vLxLEMUi1aOtGqRoNqVS8
         gU8ZAR33ebFCTMg+LTGgZTi1D1aV+l7Knc4MDkGddR8GQ3RuRiPAoRbBd2R1CVEAFBx0
         yNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763650358; x=1764255158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qlVoOV1b0m1EsqTqevKebTa5adC2s2q0Xm1TYQIEY5c=;
        b=f61Q/GHo3iD8/DSKfol8RtmxULb0SVNfJ8GZEaofefBQOkx/JCD6tiYUOVhL96YyQv
         6NlyhOUf1v2An2wrV+KZIn0jsNCYsv1rM5SEWLvIzqO8uDXJNvZ4NQnAHydeQNgURixV
         /gbTsMaHvb8fgjbf55GLhJWD5Zt0/7oU8zBAUlIM1En9f8t6IPS23ACijYmMSHFA/aFV
         xxQzSZlhW4T6vH7Ha6izGE16YLmyLyKtAp6p9pTMdKmbetQVA5t15VWiTcfl1bhdDFOd
         3nTgybalpqYhi2q5P0lkkOBJPGTh4oblSm/ocqk3TLDbgrzJx7cfl6JiaGcTLKN+17Tl
         kvAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg8RUBvluxi8wD11lShFtYqG5hsSQA4WXPfLTfZBOPV1jBMxL+bt506lt0cZszwLY802LNiNU2Uxti@vger.kernel.org
X-Gm-Message-State: AOJu0YzXwdHhya0q9ouiPYOZ5PHB7cPH7l7dMP9H1TyS/zqqx7LUr61V
	hFSgYA934Vnhn8MIOIZfE2gjb/5CGJb75lIXgkcU0WAsH3KCW13Yo2F+IM1oNyoQKL8=
X-Gm-Gg: ASbGncuMVPIO4Bd86ZWDrs5XhQeFk0bQ75zcTLQqFRDftyJEZq6EzWYRhAG3tF0iY+9
	2u8YZCzv4Bl5cDkycwYDwTf0J11p0qlNQK9JSdBhie2YH02ZW4CfptF4amIdz/60SIehtvSHQYG
	j6CdkHS8wxnBQ0HVDTYElIxYSZq2dgYnLpFpWlhGhRSkADzN8Ia3htyT7pOUcbtQsAGOMjJoALR
	07++f5+xNlqDAx0Lmd3w7Zb2nxJOduN2IPEvDzim6+yiIKFb0rCmn5wUgCVhRHj6hiQmSMmfGAN
	Xe1DtrkpSAOwg+VqI1tcmLxdZG85azgz9LPU+37gNHf8XkC/OME8/t1iVb3TrkkeKvM19iRZaR7
	IU7kpohXwVABuODJgwfp5E2lu9kJPu37POkjejHBCJ5cb7BLmY/fBKoBTPiMnAQiiMg8GFXspjM
	X+YPkvk5IOzVSxOKYn6l8=
X-Google-Smtp-Source: AGHT+IHij78wIttXL5qrzeJ5Fr4uMDiSvsvUdH/MMYd2AuxlJUx0L+zs8iuv/NdnITfidNIJsVOY8Q==
X-Received: by 2002:a17:906:478b:b0:b6c:38d9:6935 with SMTP id a640c23a62f3a-b76552b9f32mr307984766b.24.1763650357685;
        Thu, 20 Nov 2025 06:52:37 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645363c56a4sm2255897a12.15.2025.11.20.06.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 06:52:37 -0800 (PST)
Date: Thu, 20 Nov 2025 15:52:33 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 03/14] devlink: Add helpers to lock nested-in
 instances
Message-ID: <hj37vfeodmmjpfrfa6vnwm3rwp7an4fzt7bvi4fwyusjzgbtrm@fc6j4szuodq6>
References: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
 <1763644166-1250608-4-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1763644166-1250608-4-git-send-email-tariqt@nvidia.com>

Thu, Nov 20, 2025 at 02:09:15PM +0100, tariqt@nvidia.com wrote:
>From: Cosmin Ratiu <cratiu@nvidia.com>
>
>Upcoming code will need to obtain a reference to locked nested-in
>devlink instances. Add helpers to lock, obtain an already locked
>reference and unlock/unref the nested-in instance.
>
>Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
>Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

