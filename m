Return-Path: <linux-rdma+bounces-1971-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C86AD8A86B3
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Apr 2024 16:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 834DC286346
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Apr 2024 14:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF50E142625;
	Wed, 17 Apr 2024 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GbWvw+2J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137EA13C3EF
	for <linux-rdma@vger.kernel.org>; Wed, 17 Apr 2024 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365471; cv=none; b=joFIlJ09P387ZH+d2q4D9KlQG9lZUnEra7F7khH8FxyQ8nS+HtEL8umbtVJxKu0elkJG9F9ksQNq3VLpVvukBIv/fIaBlGNne/ZO8s1GS8TVmy8axJiIP4aZZ2NfjAFA34e/vrwsuCh1MJRC+QBJn/nvyga1tlqHZrH0Dt1uoaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365471; c=relaxed/simple;
	bh=wMVuMH9LI7UuNCb9GdN4WEGzyOQpVSkGjvVlOi7rgEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlkP7hDJ0YtZ1mW3tG7zo3KUq/GDXzQCqttyTb4SAoprMhWzwLIfD2OA78A+Dr9LVntPlaVxWZ+fBYfoH97F5Sfx3buVKOixI0Aim4IG3LSCorRWtn7M5hNVBwsonaZymgFuWXwwgvsJxIiDfWdN9Qdr5e6jX66LNFy94XHcrnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GbWvw+2J; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5aa4204bacdso4048242eaf.2
        for <linux-rdma@vger.kernel.org>; Wed, 17 Apr 2024 07:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713365468; x=1713970268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sn16XyH2vGWqQiF5vmVfdCLTqM8qaB/bRtbPGNzH6uA=;
        b=GbWvw+2JOhsvQI836BTW4ZxPtAgpMBZJ2acKNSvMV7bU4ePZrK4ZK3I9j8g5VoPfg2
         0a6mvinVh/9kXeVuhoaNhFBgOnO4skOZJvRy0zNUbleZHCT/9uZana30+Y8LAeu9obuj
         yskL0QvSGlLKAA5pq2Vjkz9LZLAWcdQcq4vd1ZreWAigzyZbL6Kmv56nJxnxE/P5d26Y
         bnCZaaKRDcQ86DSZUEvyOoei/FB81GsD4xaxvsmzz+9fX+dUt6v1dUgPKe02DMdK/Cw3
         5v+dOQYcHiEYXpCkxvpmo9Y2N7etRYhEEaEhcE8/PWRoe1XK8byWSec+meacWSHTtUE0
         kjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713365468; x=1713970268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sn16XyH2vGWqQiF5vmVfdCLTqM8qaB/bRtbPGNzH6uA=;
        b=C30kLZ4cSl9K/Oirbu4sKGaVV3Ox3tMjN6LF0ttLY673+M61fl9VSg38WFKqEzlPnB
         MrGNcg9FPkREUONsvCVHI17/DrGVNxDBeM6ZHdnaLuRbJDLJMYclCe2OvZv9Tw2CgJME
         2gSRptzk2Uu7AoGmIKsBA7ESoFkgNsH9eVsF0RoEDqHconVV2eZgnngelfNc2Raus35i
         OyaHLA2H+mlpqyjvGYWvaQMSdmPKvpXevq2UNFdh/VEv1VziU7IVh/lvutHQ05XdbDuG
         pb13x3YG7oAeMbZ3vuw1hvqT+rQHF73xm5//nTByya4FesuLy8tGLwu+Iy2DPp9QZU/9
         ZJHg==
X-Forwarded-Encrypted: i=1; AJvYcCX1TI6weEM07pAUffleHqgxZVz0cg0M74srA57OgunK3nViKR06P5wpzXdvDo7+r1gG1ThpJ4SlbqziPd+5Y+JZ1RpW3UQdlLvgKw==
X-Gm-Message-State: AOJu0YwNRxCoEOys1BV0I1533/3bHqqAkM/TNdTp52sQYCsYMkUFlJb1
	aMqeYABf61D977Wq1i538vQIcBd1DvqXjXHuzJoE+E422+ZwSOk7E2E/J5NHinU=
X-Google-Smtp-Source: AGHT+IF9jKclsfwc/2dOm0UYRDZe4Z7fbW7RD2LFqk2dv7+uXxlXrV0hKypQvQnIeBBazCFKKNl7Yg==
X-Received: by 2002:a4a:8c2a:0:b0:5ac:bdbe:33f5 with SMTP id u39-20020a4a8c2a000000b005acbdbe33f5mr7840118ooj.3.1713365468101;
        Wed, 17 Apr 2024 07:51:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bg41-20020a056820082900b005aa6c0a9b3csm3063951oob.30.2024.04.17.07.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:51:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rx6cs-00CDTX-BT;
	Wed, 17 Apr 2024 11:51:06 -0300
Date: Wed, 17 Apr 2024 11:51:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, sharmaajay@microsoft.com, longli@microsoft.com,
	leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 2/2] RDMA/mana_ib: Implement get_dma_mr
Message-ID: <20240417145106.GV223006@ziepe.ca>
References: <1713363659-30156-1-git-send-email-kotaranov@linux.microsoft.com>
 <1713363659-30156-3-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1713363659-30156-3-git-send-email-kotaranov@linux.microsoft.com>

On Wed, Apr 17, 2024 at 07:20:59AM -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Implement allocation of DMA-mapped memory regions.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/device.c |  1 +
>  drivers/infiniband/hw/mana/mr.c     | 36 +++++++++++++++++++++++++++++
>  include/net/mana/gdma.h             |  5 ++++
>  3 files changed, 42 insertions(+)

What is the point of doing this without supporting enough verbs to
allow a kernel ULP?

Jason

