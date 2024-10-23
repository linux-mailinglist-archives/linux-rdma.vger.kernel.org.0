Return-Path: <linux-rdma+bounces-5481-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6499ACB7D
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2024 15:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E9D1C21109
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2024 13:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080151B4F24;
	Wed, 23 Oct 2024 13:43:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4AB83CC1;
	Wed, 23 Oct 2024 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690979; cv=none; b=f3rZFZJqR0xKDWeCT1lMiBNIroHkDA6ETxYGcwABsJ7UO4ViOteGJi62UDalghIAmGdGTec2Je/rPEU6gBgPlt8/NjvK8RWxP1mDGJNgMIcre/BMuNRP/ijsdEO8plVYv5e+lUHTUNUGFGupoZzQo0BBYNZopxj+bI7h16NA6EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690979; c=relaxed/simple;
	bh=n7cLF7zHYqAx+76dI4PF8+q8HbNgcOHOBVGEngQH9KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFlRlONHAkstCEOpe7SnNEEZJzKzKQk8t7vIBObTnf2uiKFDLQGi02a5vfEn9OMIYPyiYCkpHqV18dCExSQnkNXJ6hfxFcDgVwbpxwnnjv0uvuYAZiO1Oog2gvnFXM2KdL2r07WtEfF5yXzzFazzPe3PiYSS/Ro+V4jDcGtH1Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb4ec17f5cso65079421fa.3;
        Wed, 23 Oct 2024 06:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729690976; x=1730295776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lD78OmVjG6F7WkvlccJcCu6C0/3U8zr++1e/ZSoEU4=;
        b=gleBoPeGWQXYPNtIUE/YQa03sXiGe4pvkGGsdwrG1AbmM69nmkeOZ4JMCDMmQ7aghB
         hx2vD9MKJfQhM05FPzw7vQzrQ2sQuUk8kqW252w2Cros/VMRc0MmGpuNQA8Lq4DWSi+5
         IK9oR+8tN6xhWSH6htqHwJ5zTySl5ZDCpXih4Eprjr/1vd9TfUHkvKqOnCQ4vW7GKXXw
         tmaTix7wzqm/O6kwXoh6vehJBCnMR0zl6USXyEVxC4C3W18IndMueEvHmDjkT9YBgmBA
         00c1URcTXrX2uirPI21/5uZXl3nzs+s8ZSBO4nfGPtvVM845uA6+1rfw4G7x0XYSyc+h
         Nzww==
X-Forwarded-Encrypted: i=1; AJvYcCXXfG95ZdHdeAPW+uB4dWQc4rewmrbBql+ZLmKmnX1Aajqz3rsyuKTI2iEUs3GXBgJUU2tHV99IIJKz4CE=@vger.kernel.org, AJvYcCXZea4bJIw/f9YRlJc/wT/OGBCxoHoMRTWxpO8rgZCsCJHpSHVTa4F5+p6NUt1ZPoxlR92neDZzDCbhAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuW0S0ht9jJQdDhzHtHbaQtQkDvslB5HFj/waR0vw/CYcotHgD
	0R0X4uQwZC/57ZdgXUrqRiGu+j4R2Z0YnZ4q5E2Fh9PB+MBpkPTy
X-Google-Smtp-Source: AGHT+IHetgLHGRAyVKfEUkgEUquxnQiZkddJnhW0Wp/4iTVgIfTlOT79mLKZ2PAe8Z++7e/4l23LPw==
X-Received: by 2002:a2e:4c01:0:b0:2fc:9869:2e14 with SMTP id 38308e7fff4ca-2fc9d622b12mr10102061fa.45.1729690975613;
        Wed, 23 Oct 2024 06:42:55 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb6696b561sm4407777a12.20.2024.10.23.06.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 06:42:55 -0700 (PDT)
Date: Wed, 23 Oct 2024 06:42:52 -0700
From: Breno Leitao <leitao@debian.org>
To: Sebastian Ott <sebott@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH v2 RESEND] net/mlx5: unique names for per device caches
Message-ID: <20241023-aquamarine-koala-of-freedom-ff5f77@leitao>
References: <20240920181129.37156-1-sebott@redhat.com>
 <20241023134146.28448-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023134146.28448-1-sebott@redhat.com>

On Wed, Oct 23, 2024 at 03:41:46PM +0200, Sebastian Ott wrote:
> Add the device name to the per device kmem_cache names to
> ensure their uniqueness. This fixes warnings like this:
> "kmem_cache of name 'mlx5_fs_fgs' already exists".
> 
> Reviwed-by: Breno Leitao <leitao@debian.org>
in fact, it should be:

Reviewed-by: Breno Leitao <leitao@debian.org>

