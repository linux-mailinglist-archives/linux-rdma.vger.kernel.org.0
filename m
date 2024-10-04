Return-Path: <linux-rdma+bounces-5210-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 391E199018D
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 12:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37E21F21EE2
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 10:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B648148FF2;
	Fri,  4 Oct 2024 10:47:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A409130ADA;
	Fri,  4 Oct 2024 10:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728038837; cv=none; b=W9MmPuaoIv7MutAEj2uFMKTT4Gt0Eyym6dXQoBeRFJ3M8IVFF32yTNLMyjPUKO6jODbr8ITl8t3CbdZpIYaGwEqn8XIfrgf1UUDuXeuMojOtnX8X8bHEip4j5sEa1M2xfQexfAehdm2nWXZML+lTh7a6ZJeifSUVc3sOnWUZ4gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728038837; c=relaxed/simple;
	bh=Yr92QAqtFQjX24F3Nmar2Xi4Q7kz9A7xdfp3Tev7xLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tz6AeR6UQQKJ2EkmrwzOuffZa9+gJqZL+/lE0iz+SEoREvN+2ZuC9ZonnlYaqRLaVhzHiFibbBhSHGe5M+Qu50qC2cIa/Ou+VYIxXfkXLkKd1iYIeZ8U1exPB8va5KeFUIRGUCrqtNpchRCDfLc8QAe4V7D0JxRhMTt6QIbqThA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a83562f9be9so200385366b.0;
        Fri, 04 Oct 2024 03:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728038834; x=1728643634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCZDomfCahU5hpsWOQxWLSSyRP5Ob2MzW/jgTVQY7PI=;
        b=qC5SXVQuNO/9CNM0RQxicjQcVGUnh2tOF+MQrXE5sbQO8hYUHDhgMC35s6BwMWFcge
         ZCUTERKBNFeEWABRiffA7+vNgU+rXPT5pXkbHOXaeXV6p/0kyeINv7h2q2DFZz5c0NOb
         sEh3QaqA71MPcGmb0nh4CJpYTIDmWsW5ROrrqe3NpUMiLnK3GMhyapvaPv0h28GFsCXJ
         E8xJcmRFe2MeUpEshZc/kNkMCWYnor1Qcdj9uNH0w4cy8cwuLAWjOrso+cjORfAx1eVk
         XxIyDkBolufQ3OZkOaizZtiWU71DeHvYziyWBbBBkx+oR8onPsogtXgZ6HHHDaSD6o1U
         MAVg==
X-Forwarded-Encrypted: i=1; AJvYcCUwCVNry3L0KOkHzmE9FJYtrSRGGywtKg0g2un2w4+GGdkfv/lxjzUdwzJb+YJl8SI/xt6n8QJO6OnR/w==@vger.kernel.org, AJvYcCXoCRhZVq20Do3dl9+5N7MfwPeIQbyoIEbgBQ34q4ydtSAHWVw5GPdOfqhHhCk+qSJzSVVm3l9etGN4P40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZLmChJfp2PR1ECtR91J7AyfmXuPDEX/gWYNuIUOHNzlQ4yl7c
	CaXegTOtlt2XdXfLfdJcQWfXxHPZDBy+felpRPVtudNFK7IYZ28E
X-Google-Smtp-Source: AGHT+IFyNyH5lWzcqbpFIeml22OlNRc7lCoV4L5iTVaw6ATOV2jHG/hZxtWobt8qJfh3eGHe4Oib2w==
X-Received: by 2002:a17:907:ea2:b0:a93:d181:b7fc with SMTP id a640c23a62f3a-a991bfec2f1mr205120566b.51.1728038834141;
        Fri, 04 Oct 2024 03:47:14 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99103b313fsm206372566b.127.2024.10.04.03.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 03:47:13 -0700 (PDT)
Date: Fri, 4 Oct 2024 03:47:10 -0700
From: Breno Leitao <leitao@debian.org>
To: Sebastian Ott <sebott@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH v2] net/mlx5: unique names for per device caches
Message-ID: <20241004-degu-of-fascinating-attraction-136410@leitao>
References: <IA0PR12MB8713EC167DC79275451864BADC6C2@IA0PR12MB8713.namprd12.prod.outlook.com>
 <20240920181129.37156-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920181129.37156-1-sebott@redhat.com>

On Fri, Sep 20, 2024 at 08:11:29PM +0200, Sebastian Ott wrote:
> Add the device name to the per device kmem_cache names to
> ensure their uniqueness. This fixes warnings like this:
> "kmem_cache of name 'mlx5_fs_fgs' already exists".

Thanks for fixing it. I am hitting the same problem on my side as well:

	kmem_cache of name 'mlx5_fs_fgs' already exists
	WARNING: CPU: 0 PID: 10 at mm/slab_common.c:108 __kmem_cache_create_args+0xb8/0x320
> 
> Signed-off-by: Sebastian Ott <sebott@redhat.com>

Reviwed-by: Breno Leitao <leitao@debian.org>

