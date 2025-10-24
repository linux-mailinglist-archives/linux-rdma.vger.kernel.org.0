Return-Path: <linux-rdma+bounces-14035-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3D6C0504D
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Oct 2025 10:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DEED501B3F
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Oct 2025 08:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90652FF171;
	Fri, 24 Oct 2025 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="V9KvNY0k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9510B2EA735
	for <linux-rdma@vger.kernel.org>; Fri, 24 Oct 2025 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293803; cv=none; b=TYUZvv0cnkvQdrQGHSLSJkbpaFVoaK0VyLwS/eS8ThZCRGBnJxz3HhVdEzWz71ASrO/CXQKcwYiSPkVPwAq0rOl3h+0gLmy0KUM4BJl4GcRX6Esajx6Y3xBji79Dpns41/t2YvFRs5ujaY7lftE6Y8cXYmB9kHGyUKRShhc0nww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293803; c=relaxed/simple;
	bh=RWdGPNS1iDQpL3AYAMrng6/fsuBkytsPx/WEa5J21x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXKX7WdnFBVbYXs8rrV+0tRqxby+6Hx2DbEOwIHXk0fdAK2GrcRKiHO0UzopKqmQwyOdl3A4NCdh3DQHnoqvgb8/5THfUwK6T62lVXlqujnjWi7zwett+uD2p6DDkHDYoHQWefR8ZcTVzCvOr5zvmwUpSk31hhVz81FwUQHw70Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=V9KvNY0k; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ece1102998so1161130f8f.2
        for <linux-rdma@vger.kernel.org>; Fri, 24 Oct 2025 01:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1761293800; x=1761898600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i5cjUqGbM0RrW05do79zm+nugfOI5OuKl18rgtRfqvY=;
        b=V9KvNY0kI67U/PdaJYXieop8BZiy4MZiedSzwXjemnFqsCbENvl/lA7gCz6OcHQIzL
         eiJWHzZxk7urBdwxlCv2X5tYbJD7YsYQ5zYjkdYOEmi6YSf+hQWxb/rcX2AwZb3LpzR1
         nkQmvDmsq0WaQZ7Ffc1NFdMOQwNW19vXZXIh5yNE1CxGKjBgy3rhCCbKLpfwTvDW4xDO
         6N0M2i/BaAT8lGP58ZNoDGGIinx6LvhTr1kaOKWif3GriTPFo99fcKHMmRJ0pQwsStc6
         cJRUvn3fOj2g+6FujJ6mOHKhfWTmLnTdJ86cisoxKz2rpTdtjHhqQFBvtbRLSiM0+FXr
         kXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761293800; x=1761898600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5cjUqGbM0RrW05do79zm+nugfOI5OuKl18rgtRfqvY=;
        b=BOXaosCSUVQx8X3CHD82OpkGVnkIunDYnLm1tLUXrRCa11fdVlaXX/XWkjLxJomcnq
         55z1/t/Krbq+yucqFCoNQs3fCGrK/pXxruWiG+T2ec8L3kuUCQiwgdn+aDYNTqFQUKN/
         QH2dq/pu2sAir9RuSD+0HUZf8D7ktl/a9FPgr5LmNuCK78h+LjwB4tJj+rzs57Z1snMI
         IwCaDc/gIJ+LciFykjUs/vMUCBCegTv0G9Tw2qM4Llh1P1MmKXuDvAB4BGs95L0N2GxF
         +d8RGF0Xil2wOnyxcQGNDwEHWZlWLyAUPz8LJK+TdtLSCM+B8he54G82/lM7CV1FkRL1
         qQxg==
X-Forwarded-Encrypted: i=1; AJvYcCWwaqR/oWMAI/+TaHgBJ7s2xX2hju8H+cB8IYIKQEQsKpLLh1rzJeRERxraxp4xo/Y7JcOmvw9vWLhg@vger.kernel.org
X-Gm-Message-State: AOJu0YxgeMemx9HE8ZOKCmjU4lHt+wsROuB7scr/e+u1YtXvnmcO9mX7
	MUMJaJkNQ0vRakqSqEuYsxkM12CKF0uRXMkwH7zXuLoTTXVoQUdS7X1/HE4HQNddtJs=
X-Gm-Gg: ASbGncu/5w1Lfy6mmI+j0lCT3ug6DfhDTP6C/dnnXAEBVLOoCDKE9ga3KWk8mRKU9xe
	FkU/xyDgH1v2KmMyvWOtvPjMl+/cko2QoJKO+lSFDs4y1uW3Tjp+wzKzcYVm2Nt3Rs5IqzZgzKX
	Ghdv0f3Fgc9fmlEaYZmZVRH6xnDsd/68r+TQeTM3X3QL/LZ50COHgSWB3MQZlboNXUhMgmBwBZk
	e7ar2pXBuwY3XYkwHbew/iAOC68UexNT2Li9iqDiJjFWh7f1Ma08sviUMTnQGyrUvDuvySFNis1
	SNbbRSXkaeeGafzhiHQGaQtNATA7BxgB4J3x9bIdw0tHaj5Ty8cgJbQ4lX7JHphQROGdEYOl7lJ
	cfWSyxWBSBP+jqO5TGBgci7FWZ+8wlyyiGClCx5MJDgHHi3PoyTsT/3zuDEP6o+YsQuIs8asx4b
	NFMzfBFQznLEmysYPeJNIGtbOIOi7HvODakyHqGQ==
X-Google-Smtp-Source: AGHT+IEjgDbqn3z5tjHECw3913ThgDrQE5n6C5KutSqEORLETt+ny0gQGMO4mUMda0NT2ai8gi8/9Q==
X-Received: by 2002:a05:6000:2203:b0:428:5659:81d6 with SMTP id ffacd0b85a97d-4298a0a9200mr3119153f8f.37.1761293799579;
        Fri, 24 Oct 2025 01:16:39 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4298d4a49ffsm4043496f8f.13.2025.10.24.01.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 01:16:39 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:16:36 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Leon Romanovsky <leon@kernel.org>, 
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Vlad Dumitrescu <vdumitrescu@nvidia.com>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx5: Implement swp_l4_csum_mode via
 devlink params
Message-ID: <uez74rl75ner76kl3i5ps4huyxmzerrhananjw4vyo74tvev64@nk2lwjivr6ho>
References: <20251022190932.1073898-1-daniel.zahka@gmail.com>
 <uqbng3vzz2ybmrrhdcocsfjtfxitck2rs76hcrsk7aiddjssp2@haqcnmzrljws>
 <20251023063805.5635e50e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023063805.5635e50e@kernel.org>

Thu, Oct 23, 2025 at 03:38:05PM +0200, kuba@kernel.org wrote:
>On Thu, 23 Oct 2025 14:18:20 +0200 Jiri Pirko wrote:
>> >+	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_SWP_L4_CSUM_MODE,  
>> 
>> Why this is driver specific? Isn't this something other drivers might
>> eventually implement as well?
>
>Seems highly unlikely, TBH.

Well even unlikely, looks like a generic param, not something
driver-specific. That is my point.

