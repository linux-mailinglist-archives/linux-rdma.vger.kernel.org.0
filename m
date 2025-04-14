Return-Path: <linux-rdma+bounces-9427-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A55A88BA6
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 20:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6AE189AA04
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 18:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BA628E5E6;
	Mon, 14 Apr 2025 18:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E12PzeVZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD3228BA9B
	for <linux-rdma@vger.kernel.org>; Mon, 14 Apr 2025 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656271; cv=none; b=FDZgZBoLbAqlZh9W/cvOww4ZwyQCL8a5rUQxOox0FHm/ngWIOJ4guPHTg/FmGu6xM2cOOKzjr9oZZSAbJ1cC3Ig5wW9eJMWHwigc74FXecnI1JKX3AmPjhSQ7gDRYK8988mVLghmvfsOPwxrCVPqBMDsF2yq40SXxvKX8FEPWEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656271; c=relaxed/simple;
	bh=YpSfHpLk4g82/Efaxxr4vcOeA7lwSVP0ZoulsVdeGLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Raed8jaeW6dLObWDGGQEuhWq8AGRTa/fJuFlSToScBnNW7V67HnjrEg0ahvlG+zE9ClXHPlRHGSqr8EjLJNSAhY9Wa4sAnwuvLiO78IHtGuXUcPwOz5Hpe9AGbrf+YQNjs/4iT9DgRLh35KKGpSInkWFEOBrTvvH/qaRnbszwOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E12PzeVZ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b07d607dc83so1349964a12.1
        for <linux-rdma@vger.kernel.org>; Mon, 14 Apr 2025 11:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744656269; x=1745261069; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YpSfHpLk4g82/Efaxxr4vcOeA7lwSVP0ZoulsVdeGLY=;
        b=E12PzeVZu5Exwy8LyxFk9HWgo0LQ+XxMijoqt+C1B+Mp3AYP3HgimWmrf9iOztUsrf
         4UHJRw1rgGT5K2jugGhaZYNqMS6qBc4LSCCwbOjuZ1TPhvHD/SZzcqq2/oTv/wxv6qsY
         hKoy7XFhw7AZeIAB4v0NuPvLvGIFSngF5FTv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744656269; x=1745261069;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpSfHpLk4g82/Efaxxr4vcOeA7lwSVP0ZoulsVdeGLY=;
        b=ajTIKih7j8Kwa8Ici4kkPMzuDz31VwyTqAurhxNwgU5WZORcTWvW1WPqbgcv24URS3
         cll650LNba6+S0hK9QLP1e0oY5aRWNCHHv+h/IQIBP7p091syzltHeQYUETXMkVTqaaQ
         kzA1DQaTqr67SMVXrUVWYCjFq7JNC5otHj6k3I9gWxYFaFefSnBwrTR/Y1mhoHnOQBwL
         ZSEkzIZDg/7ff2pOX7ZtOK7UMt0fcgrkUczf1lxVq7PiNSjQEZunpSUQ+aVk/HxdDWAQ
         SMv568v5vsloU7u0j4ej3XDE5cqbvCy2ub+R0y7ryaxxqHzJYmC7salQdGiFoZXHaARI
         bZ8g==
X-Forwarded-Encrypted: i=1; AJvYcCUXwgEkbya18+CIrLWHgL2WC3ZoXKJ82zCYb5zFjtyYqDoKBfYxeUcL6ZafQWzUtUQsyY1J4pFGz0td@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/gPqAaYiZauUgNONVaVCIQFt44B0FxOovaLQkJ6SI5wWqGcQK
	YxK/wfTCzxXF1cgC7q01uwJk1B61jyoK1v3xUzSJLAMXNQzeo52/shRFWyfJvw==
X-Gm-Gg: ASbGncviQm3cFVQe8Ncgr1nXytnvnb1pg/DtaxittzBGTmvC2YdbAMXKnvfPEFVXgsP
	8Hs6ZAoV3nPHZpwHMn3NGPrFFVDXXA6bfdE5ysiERrbf0fza8LXZphcP4qqTWe1RJK5ynqd4Imv
	OqxDJF51lYBBdSibXGjsf2P1bPEI6b0SH7SbrLpfR8xj+FeRpvQQGxinzCCTaYBgyrC80pFeaHR
	65T3RtUMVas4qrD3eWwkj3dfoT/aVNRXwDwTabgUzd+kzy49a00KGGNY6Y9d/K+J8TM4XB4dk1J
	ay9QKUrpQEejcTcKSOPcOLQ426iAypnuVsJevFcqyLyq88ibTMQ6fHPUXDSKcsiyurhA3k++iib
	5mA==
X-Google-Smtp-Source: AGHT+IHRnGevNVFCEzzLtuARDY+GV3b1ySMboNdXjtt9nCxP859MMeYdEqvd7RpkkuyGR22MEOT6ZQ==
X-Received: by 2002:a17:90b:2752:b0:301:1bce:c255 with SMTP id 98e67ed59e1d1-308237ba788mr18304386a91.27.1744656268888;
        Mon, 14 Apr 2025 11:44:28 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:cfd0:cb73:1c0:728a])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-306df082327sm11386410a91.15.2025.04.14.11.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 11:44:27 -0700 (PDT)
Date: Mon, 14 Apr 2025 11:44:24 -0700
From: Brian Norris <briannorris@chromium.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Jeff Johnson <jjohnson@kernel.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
	ath11k@lists.infradead.org, ath12k@lists.infradead.org,
	wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] net: Don't use %pK through printk
Message-ID: <Z_1XiNY2ujreEo69@google.com>
References: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de>

On Mon, Apr 14, 2025 at 10:26:01AM +0200, Thomas Weißschuh wrote:
> Furthermore, restricted pointers ("%pK") were never meant to be used
> through printk().

Is this really true? Documentation/admin-guide/sysctl/kernel.rst still
has a section on kptr_restrict which talks about dmesg, CAP_SYSLOG, and
%pK, which sounds like it's intended. But I'm not highly familiar with
this space, so maybe I'm misreading something.

(I do see that commit a48849e2358e ("printk: clarify the documentation
for plain pointer printing") updated
Documentation/core-api/printk-formats.rst.)

In any case, even if the advice has changed, it seems (again, to an
outsider) a bit much to say it was "never" meant to be used through
printk().

Brian

