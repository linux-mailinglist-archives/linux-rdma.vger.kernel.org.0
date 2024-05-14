Return-Path: <linux-rdma+bounces-2479-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00F88C59E5
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2024 18:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3D9282AAC
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2024 16:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E770517F394;
	Tue, 14 May 2024 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAoxat9T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68902F501;
	Tue, 14 May 2024 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715705354; cv=none; b=OyvW2GXrwZ3ou3rixuxF9lcjOZ8YTl74t8EJqFxm0RmAX9MPWeOE/frAgB5kdYQj4wsPq2XoF1shEirzVWnYpalITbLtYCipeCpjTRTqB2Kfbe0R3hTcbboV3iHv1XLDW/2Z/2s31zZgzCqHTj4Onx3Dq/O98yx4EU2v1tqNV40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715705354; c=relaxed/simple;
	bh=1UzW6SAHAIZaMISdFE8jDhrw+M6si+xK73+Z7yrGdRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XG3P2AMfhbGR6xvzGisM5UvCGmySv1OBrCb0jyCtMDNASGIccmfR3HQsypnv8Y046jsOl12adUS/GhCkyrgwIMqh7Yc0ZB7RD7+FlaNYkufOX6HqQuwZs3NfsbDWcl8LMTawR60qnUVCUEnukDAnPWelQ61cdD83SxEr5TJJj88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAoxat9T; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so34034505ad.0;
        Tue, 14 May 2024 09:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715705353; x=1716310153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPJtbRaKeAfkL76CPGzY6JDKoDaI+q9X0/jE6CYg6Ns=;
        b=TAoxat9Txxz2VDS6z/rYUquaiZFFnd8NNLDbCrAhZap5zl8eScsRW7pCK+S1Hmrl+P
         hL2SgtX+i2peC6XeJNRNEJ25eDOmPRM62cBQ7ixTD/wDVnF6t6tks5y1BrKt/NlTbSGI
         KbEL5C/43YXZPFtxgmZ0uAQMOqxpLyH+kxwgmxzfO+iswR3nRemwrGMO67sV904UEiVL
         dfwXQSfzYKGXdew6xjAoQsKsN/TFkx1QC24UIjrfFWhdNyYrdL9ZYWyv5efT0dMOsF3Q
         0ZxS4UCAV/3ihs5R6ywPQ3dHpaSSzN4ltOPSKjrG+9GTRNsQfpQM44FRr2Utmrm6gnNB
         PXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715705353; x=1716310153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPJtbRaKeAfkL76CPGzY6JDKoDaI+q9X0/jE6CYg6Ns=;
        b=mRmtmAE7dipMbDMk3RLhLafmhUWLHTOevuDoaYyLpgo/m67kBn2RvdvftX6uZ/BK2V
         iXfD296wTUFJPySXw99hYE2lHN4/bTjv4xkP3LnpEZfzq1wrOoiQuDpw0l1+hNx6K3ft
         gJpfdUrJhy7fDo2EezUSJBhtl/4fffrTpWLK/nyr4zyxJUuPw9F6rvVuHunAp1XU97di
         8BBqC8Nz+ViINpv+PdDLebvwaL98ilzpX8WASn7oGUW7uymfSDq/K/lzmbDv1+bc9+BX
         NNd32r2eYzUen6pS2dMGvZBxrPXVS20yO4cDfnjv3RhsCH+ARcGAcEatjqzsZawtVTrT
         5P+g==
X-Forwarded-Encrypted: i=1; AJvYcCUP/HDuHKzGEBVbr3zk+ldJojdgvfTNZYcjpYwM8L9AZD+miszxLctOezDxFeS/Eak9pDeTxpgk22Os1z+IVKWrtycLtBDC/Qwpf16cYq+WQzE+EG+xWKxQ6ZdY1Rl28ID5aOjE
X-Gm-Message-State: AOJu0YxmkvcTn/EgS7qQ3bm0OHcMdYTE/LlvWL2OgxmDCRkKzm4zlXlf
	Qb5gTZP0OqN4wHcglXrhhni2BLQyXPiHuJLXadFid6+Dz9KVzwZK
X-Google-Smtp-Source: AGHT+IE/mxZN+16nkw8kUcdVH0wRr3TD8h4HmIsxJ05cszgL4+IoRiW9OJUyvJzOxwglq2/uEnhg0w==
X-Received: by 2002:a17:903:1212:b0:1e2:7734:63dd with SMTP id d9443c01a7336-1eefa58c6e0mr243962865ad.30.1715705352599;
        Tue, 14 May 2024 09:49:12 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340c99b915sm9753594a12.41.2024.05.14.09.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 09:49:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 14 May 2024 06:49:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: OFED mailing list <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	"rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	Manjunath Patil <manjunath.b.patil@oracle.com>,
	Mark Zhang <markzhang@nvidia.com>,
	Chuck Lever III <chuck.lever@oracle.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH 1/6] workqueue: Inherit NOIO and NOFS alloc flags
Message-ID: <ZkOWBjCO2zE14edD@slm.duckdns.org>
References: <20240513125346.764076-1-haakon.bugge@oracle.com>
 <20240513125346.764076-2-haakon.bugge@oracle.com>
 <ZkJEZuNRqIVUGcSn@slm.duckdns.org>
 <6E7B1E61-5BB1-47C0-ACA9-989EC0FD03B9@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6E7B1E61-5BB1-47C0-ACA9-989EC0FD03B9@oracle.com>

Hello,

On Tue, May 14, 2024 at 01:48:24PM +0000, Haakon Bugge wrote:
> > Also, this looks like something that the work function can do on entry and
> > before exit, no?
> 
> It _can_ be done in the work functions, but that will be a code sprawl.
> Only in RDS, we have the following worker functions:
> 
> rds_ib_odp_mr_worker();
> rds_ib_mr_pool_flush_worker()
> rds_ib_odp_mr_worker()
> rds_tcp_accept_worker()
> rds_connect_worker()
> rds_send_worker()
> rds_recv_worker()
> rds_shutdown_worker()
> 
> adding the ones from ib_cm, rdma_cm, mlx5_ib, and mlx5_core, I strongly
> prefer to have it in one place.

I haven't seen the code yet, so can't tell for sure but if you're
automatically inherting these flags from the scheduling site, I don't think
that's gonna work. Note that getting a different, more permissive,
allocation context is one of reasons why one might want to use workqueues,
so it'd have to be explicit whether it's in workqueue or in its users.

Thanks.

-- 
tejun

