Return-Path: <linux-rdma+bounces-14036-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F473C052E3
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Oct 2025 10:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECA5F580EB6
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Oct 2025 08:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B84E306481;
	Fri, 24 Oct 2025 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0T2yW/9O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECBA305E24
	for <linux-rdma@vger.kernel.org>; Fri, 24 Oct 2025 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295113; cv=none; b=cAVNetbzpzkJCko2G4NuYO1tAWSpz5Fz1qYCyyq9kNx5hUeILAKsJb/Be9ljCRsE+EBwf7REZgpTu328KlWZWGRU+Dgt8HQ9oaMGlw+xInuEzfrD68JRflw8V6XHvCGz9flC94P07rYgARYCKd5R4i6zGPodrLfA77tG4vpTl4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295113; c=relaxed/simple;
	bh=1sYWKH6IC2Atu0efAqlDzjFXOWx4uiUsQvNOsdd4ofA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rL21B3q6pjanESCQMQKiC3dLO/IkaANRZ+k2Wy+53qq2ZvS842WOjp3sFHX4+PqKDpBVENAWmiZUttHDMgG8uRZ9dX8jmoKEX3uHRQ4Gm7hpJtTlyh+gJQT424A5RqHyCCqVAw4WAvfzyoGYqj//uNri++6gP/s16z9qx3f+ld0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=0T2yW/9O; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-475c696ab72so14061685e9.1
        for <linux-rdma@vger.kernel.org>; Fri, 24 Oct 2025 01:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1761295110; x=1761899910; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=80QdPW8xs3jigAZkYOK79HscTaaMenUE7Hqh9AqASfs=;
        b=0T2yW/9O9LdPHrzd7ZPypyJmm6fy4Pw7e7hTWzEUBiDXjA7bYW0Bil26nj5dYG1Ovo
         De8KMSxbMAE1Xmefv5h2ItwcDqQfIoJbvJDM5xF7KOP0i6ktlXHez5Zh0aKyTryVWRI2
         B9sr17FNIh39NwailfrvW4+c++kMNnQz8Y0B/UChJs0uBvTRFFKC1KhIc49d5uLrDitq
         yW/iiwOadW6D6Onq/B2NQoGVtCD6LgzNCWYAJYzMTr1Q2ASHlbIQAIb8TOBaX3zYhlf5
         zP5yHgubffGBFoItkc6iPOSKdP8xyxebPOUULsfbh5aGSavjvKDjfg/bBE2QYXRGB+ww
         jbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761295110; x=1761899910;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=80QdPW8xs3jigAZkYOK79HscTaaMenUE7Hqh9AqASfs=;
        b=nBgL3BxYIfG17xH46pYHpThzaQvbfb2BLYxwd6m1RvCQXUvfmG7mSPVFc5jV5uNDB9
         bqE557UZ2NbCdrPEaCEr5ZTkHJGqKdcdiqomAW6H+m26HUkHm9lnoJuPLVkavVZoJoLk
         410w9sZKI1NNOTNw5oI81rcxnn8snsuJmdY1XWtSLkNpfjCnHLkv9WoqNaKqg4/kaRQ9
         njB+xpmMRBsdvnuXqVf5IVvJmVf2F2O99l+mORH3Ct7NQyRo4uA8iHrxLCqb2vQmYd8b
         /UN7znsCOhkGl/tWF6VEBDDHUDhvAXrEw702pn+Q6nu+7fowsCb3D/lnnyN4xFjDZqBr
         D/6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrpPuYLKxct8dt41AxoCXv/OcbhVACyBOEKyc49zhuY4TvNasqLeR3e135X+TEUX/n8XROb1gMFR6u@vger.kernel.org
X-Gm-Message-State: AOJu0YyjIHpGDpu4qVN7mZLf5pQlyFvNgF25TYd3293w/R3/Ap5IyqQh
	mIBzRs6Pn+2BT3uXdkmcK3DhTtVQgyfQ+Ha4TfZ/CfhskB5r62FDUezFtyUCQ6uQoLQ=
X-Gm-Gg: ASbGnct3/dHyihyMR99v5SbMIrBWXEVzkyMf6NNEM3XGPXBW9WkpWwmzzFhAC62HD4l
	WRWvdKEruNeGc98qkmofQxtp9Ho98Nj3IWpCyILEFKhR1HP9xWhKWcrQy7PSaQU5RxCVHFsVvsD
	Sl+R6YpYBW41UBCsceSlL1UPQtUTMq/6p8hCWVTB/E4hYY20kBTHSnO6FhTGZUhpyxQagFMHZvm
	R9eouQfYd8DiYFzXRhleJ7oc+OLvB5yp1x2OhN5JavwyWP4gJe4poCE/NS0/ne9Y9ZqL4csAxt3
	tDodzuid1MJteSJJe4ipPZqSnoQ3+p/6SdZd6Do038eFfhIMU58XhISnKjBdQo3cEsclDd2f5ic
	4GTIUm82ZDXuWtUt9MBAL5rCjytdHB6xTMclhuS2FTJ787oZIa2DnHGGpZOxuM9cJ4FyXKEjCcg
	eeq6Zn4ihIKYeV2eLVsJW9V9gV1oRgb23JkDOZtA==
X-Google-Smtp-Source: AGHT+IFebyV9pIuNei9GxC51FTBt0x05QRPgJ+uhxLLSTuVNX5j3YbmdoROIxdQ6NS0xF46TN4guIw==
X-Received: by 2002:a05:600c:a00f:b0:46e:330a:1762 with SMTP id 5b1f17b1804b1-475d2ec570bmr12961075e9.22.1761295108775;
        Fri, 24 Oct 2025 01:38:28 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4342946sm138764075e9.10.2025.10.24.01.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 01:38:28 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:38:26 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Leon Romanovsky <leon@kernel.org>, 
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Vlad Dumitrescu <vdumitrescu@nvidia.com>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx5: Implement swp_l4_csum_mode via
 devlink params
Message-ID: <mywwk6443uvf5mluxqzeylgsfblpsgfefdnrrpjfoerfhmdprw@bfjgiz5cvfou>
References: <20251022190932.1073898-1-daniel.zahka@gmail.com>
 <uqbng3vzz2ybmrrhdcocsfjtfxitck2rs76hcrsk7aiddjssp2@haqcnmzrljws>
 <ae217501-b1e0-4f85-a965-a99d1c44a55b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae217501-b1e0-4f85-a965-a99d1c44a55b@gmail.com>

Thu, Oct 23, 2025 at 04:34:15PM +0200, daniel.zahka@gmail.com wrote:
>
>
>On 10/23/25 8:18 AM, Jiri Pirko wrote:
>> Wed, Oct 22, 2025 at 09:09:31PM +0200, daniel.zahka@gmail.com wrote:
>> > swp_l4_csum_mode controls how L4 transmit checksums are computed when
>> > using Software Parser (SWP) hints for header locations.
>> > 
>> > Supported values:
>> >   1. device_default: use device default setting.
>> Is this different between devices/fw_versions?
>
>That is what I presume. I believe the current setting for swp_l4_csum_mode is
>ultimately encoded in the capabilities advertised to the driver during
>initialization. For example, I am mostly interested in mlx5e_psp_init(),
>which depends on:
>
>    if (!MLX5_CAP_ETH(mdev, swp_csum_l4_partial)) {
>        mlx5_core_dbg(mdev, "SWP L4 partial checksum not supported\n");
>        return 0;
>    }
>
>My guess is that "device_default" means that this bit would depend on the
>device/fw_version.

Hmm, I would like to clear the meaning of this before we add it to UAPI.
Asked internally, will let you know. 

