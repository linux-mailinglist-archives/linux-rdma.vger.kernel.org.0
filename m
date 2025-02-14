Return-Path: <linux-rdma+bounces-7771-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE37A35DF8
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2025 13:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E060188C110
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2025 12:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FB2263C7F;
	Fri, 14 Feb 2025 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="l9RDNYQW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303FB1EA91
	for <linux-rdma@vger.kernel.org>; Fri, 14 Feb 2025 12:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537698; cv=none; b=lEAR5prC6ArrRK1qoJyndCmHV0ZTLHhaFLjJHqG6IIYNCEn28tffVX6plsbT2dhkfbTIyolrpQjhyf8YebZDw42G9hYUN8Jh56DNHR4QCd3gohSacHdt4BouEXqO2q+qrz0woQLfT2sb3SxtPa4AEbuJWf8bZ1c+ASoKjChTmOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537698; c=relaxed/simple;
	bh=0mYcHvTTq+lgf1qomm4p1Qr7bp8yKjlUDa+0QhmoQaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvf3T/WpAjb8cmkiL4Uc1qAv4T5E9f2CSwPh/5Dms3Ghtyyx7RVRjdfpYj3b4M19t9YBJXswP4QzID5AnbHHAf/r4snHo6C5UInX3ctF6Z9SZ0NNIL+WKDbHTMRk0sV3wpekuFlnurRnk9Jp3kvTjwA4bJzZc61V6YYWlGLltJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=l9RDNYQW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4395a917f33so17933265e9.1
        for <linux-rdma@vger.kernel.org>; Fri, 14 Feb 2025 04:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1739537694; x=1740142494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1+lEmaDHN5QnNQZg6dCs36v4GP8d4TTbF6P3QQiuPAQ=;
        b=l9RDNYQWjNIhbSF1bOL77lG+Xu/R8rt0bhOvuqx4U191NKle1j+tUzwvg8Z0WygHaO
         1ZPGcUbiW4hi9bMdI3WjDbUdu5zhUw0/KL+dg54bxTSrSWi354QS/iYdEIUe/1kLFD/i
         c71vhWDbAClalxsTyUAI3YpHv2Mo+9a1KO0Lx/yaQiov6KzW3VN9wi5LSAp8wVF39Q7y
         vmhvbc4n6ADdW8392GcwMVt1UWQiTCev1M9lWy9q0D8ycszm3NXai2SqxTikMnTm19U4
         GH0ZX3ctFLLGtCP5x52gQ4x6kEejF3WrIucOSrxnFjUw3Uu6Wtq9q+ZX/IHyWbNFXkmH
         CzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739537694; x=1740142494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+lEmaDHN5QnNQZg6dCs36v4GP8d4TTbF6P3QQiuPAQ=;
        b=kMeGkIUpq/+B7eJudJ5GlEAwz7+CJDYcvAB1W2oNgoG6p94rI3BZCLfFbeHFPjAgdH
         b0K683t0FjXpyoM7wSv4mLwDsSbLCr5UIikHG5AGyQ/d6TZPMoInGspxYCjQQwJq6w+9
         jmuKDoqDreiKyqHTfz7iAW3dMlJr1PqY6VGjgLOzaKt82zKpO5Rx9sMeqCItag21Xx3h
         uVTG6kSxZ3ohjGDXrlzk6QMPM8y4T24DLXtA081/eizjNQctOm/t0jc3o3pmNMAS3nDt
         AjerRwCGxdebUcKohXzWe8qfCQ4Xp7f4Pc3ZLmP9xzeAmK4/j0J9WZh8bX090B1S8RPU
         Rlvw==
X-Forwarded-Encrypted: i=1; AJvYcCWhopShaIwU6iQwdRB9i9AIh+RIKdq6RoW8Zm/QUyATJBQjt49z2IbUe2U9kfiRD/5OG3OsOgr2MQ0l@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0rSljjAgzCBlRGIpFndXs4PRK0pkLvZ0HmJk3QWXYAP3tHhpY
	skrc2lM111qHR2/pZ7SmKdTB8BmeCPYc2+2kc9SRpizfUFLqR3TKPuLn5wE6RI8=
X-Gm-Gg: ASbGncu5SalF87CTEnhC8bZAe+pWaDvWwvfDqkcCTzHh3ZgCGXB4XRYrJFvZHTv0lA7
	QPsMm8bpzIGroAJFj8rkZnMZMATZ9G7MDlbtLSft8dB0KvC2wC5Z5mMbYsOZv87A6m3kcJ8+jAm
	jcSdp+ux/7wHNPMRr1qrIigemL8OOXQzSqA7piVUaq+/KUUkxRYPatc708F5rOFap50kDcWNVnA
	ZZODHKNWbbeQtpoc07ckrRRkK6FlTCaS8/3MjJwv8lr1inSdCx/0P15A7LgAMw4mic9cBGWg9xf
	G6U8cJFMT8m00jCY2Xj2jSE=
X-Google-Smtp-Source: AGHT+IEk52uqZohTXf0fCVa4pieNwKGseiJ6YLDBEGNj11Ir7TJrVFFZcb2vaITJ1n0RtedVoY/5lA==
X-Received: by 2002:a5d:6d09:0:b0:38d:b349:2db2 with SMTP id ffacd0b85a97d-38f24f948bbmr9416003f8f.22.1739537694226;
        Fri, 14 Feb 2025 04:54:54 -0800 (PST)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5ef9sm4545091f8f.76.2025.02.14.04.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:54:53 -0800 (PST)
Date: Fri, 14 Feb 2025 13:54:43 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jiri Pirko <jiri@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 03/10] devlink: Serialize access to rate domains
Message-ID: <ieeem2dc5mifpj2t45wnruzxmo4cp35mbvrnsgkebsqpmxj5ib@hn7gphf6io7x>
References: <20250213180134.323929-1-tariqt@nvidia.com>
 <20250213180134.323929-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213180134.323929-4-tariqt@nvidia.com>

Thu, Feb 13, 2025 at 07:01:27PM +0100, tariqt@nvidia.com wrote:
>From: Cosmin Ratiu <cratiu@nvidia.com>
>
>Access to rates in a rate domain should be serialized.
>
>This commit introduces two new functions, devl_rate_domain_lock and
>devl_rate_domain_unlock, and uses them whenever serial access to a rate
>domain is needed. For now, they are no-ops since access to a rate domain
>is protected by the devlink lock.
>
>Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
>Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>---
> net/devlink/devl_internal.h |   4 ++
> net/devlink/rate.c          | 114 +++++++++++++++++++++++++++---------
> 2 files changed, 89 insertions(+), 29 deletions(-)
>
>diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
>index 209b4a4c7070..fae81dd6953f 100644
>--- a/net/devlink/devl_internal.h
>+++ b/net/devlink/devl_internal.h
>@@ -121,6 +121,10 @@ static inline void devl_dev_unlock(struct devlink *devlink, bool dev_lock)
> 		device_unlock(devlink->dev);
> }
> 
>+static inline void devl_rate_domain_lock(struct devlink *devlink) { }
>+
>+static inline void devl_rate_domain_unlock(struct devlink *devlink) { }


For the record, I'm still not convinced that introducing this kind of
shared inter-devlink lock is good idea. We spent quite a bit of painful
times getting rid of global devlink_mutex and making devlink locking
scheme nice and simple as it currently is.

But at the same time I admit I can't think of any other nicer solution
to the problem this patchset is trying to solve.

Jakub, any thoughts?

