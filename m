Return-Path: <linux-rdma+bounces-3142-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DAE907E9E
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2024 00:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7631C21B2E
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 22:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBC614B94D;
	Thu, 13 Jun 2024 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="t1ItnqDt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2569C1411C3
	for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2024 22:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718316726; cv=none; b=YJhTaih+gGOnwf+kNDZBDQGBKuqO1OxAvDb7NTyQP+9wIxvFYb7EQIKRi6eQP5Q2SpCDrvAmQbpotcp7LqTJPoVmVPSZW83NP0PpTAj0VgEdJqfOHq4WrqPDQx5Xk5+rPEe5Gjn9tyQkHOqEHCn/nXKPIXCZRaK0wcZHhOL8lf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718316726; c=relaxed/simple;
	bh=ZbeYYg9Yb+PWLgJcPoeqspm3fTvQiE0OL7WdGxjUaeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKciBr8i7I/AfAusG34QfJtgivmojJ9sqv2hFRpB07Ti3N7jaDx83ob1S5aGR1tSf8SSkTQ/bjU+eBGG37fLR6fAZyFo89IC8BYbLdeslw2QObD2Zd9TFf1/7ZMyPkO/MiMFXv3q92QO3SC18PKa4ZAQVvfj2U9LbsduJQJN9sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=t1ItnqDt; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b97b5822d8so746941eaf.3
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2024 15:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1718316724; x=1718921524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8aaukLJIwFlsN0imklBHYYukOSpHGK2753nAdx6l5c=;
        b=t1ItnqDtX3GKBE588Bh+j+YNqPMHtjKEkCJh9RHs118IRuc/5Co+Wse6+GylERj+4G
         BPkVUYX6C8MRFZoY6eRTjNgwecQYGzXJJ+OZKcI38yygOARQXLum+FEbRojDX1H2Be8z
         OPyOVFfKAx4jwcUyRn68hPvxhorqf9nmw/SuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718316724; x=1718921524;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8aaukLJIwFlsN0imklBHYYukOSpHGK2753nAdx6l5c=;
        b=aVDQ2OIp/Znrp9Yeg03th1LChA4qN92fwT5mmE76CySiGAHeRSn7d8lyUm0T2xY+8j
         tvewvUQSTxIwFU4DeTTuYW9Qx6qkKBT1DfLrMrKVt2rZL9tOBil4BW0h+JKsEsOzj7j/
         3IRt8gj4r/rwOwUoCtKuyeCUeQTV9ACw+0w/dh8j7uVGeDEXDTNh6lc6FJJEI+OW6akH
         hqfjWb8GTHgdYGVhWZTiDR4wIqJwcPa8/pzumXoIEi67p9ytq+nFYm+5Zqm7VFjKH+Co
         XB6+h6y3ztXkS7nJFTC1zfaTvguKoNUP7cHtvlyKAnMhQ5zzXtXsY8ZTX+zGRmZj/VI1
         ImgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF55xdEjDRmnchgzUl38NlqHVippWLFl7ZxlEciv5GVhlgzt5QgH9Bdx3oDnjR7p9e3M55daCjb9uK4oGj0GgAUy4rBiel44U//Q==
X-Gm-Message-State: AOJu0Ywg/KqrkRqKisMAhEVkMpFE0XvX2hxKkDAXgV9J9WCN/pn+DhAF
	Z791wtshNOQEI7cXPTN7gN4LFYV/pqdZKLTvLu1TB8nWN4nnhQYDPYot+Gdff2E=
X-Google-Smtp-Source: AGHT+IGxwqv5ZLM3BKYkdZcKNyZQfMc0l1HwDn/+qM3n2LPEalG1dk/xF9XaxIPEESTy/A2IjbKb2A==
X-Received: by 2002:a05:6358:5918:b0:19f:3ee1:d1c1 with SMTP id e5c5f4694b2df-19fc46e0187mr104458255d.31.1718316723942;
        Thu, 13 Jun 2024 15:12:03 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fede16a598sm1562424a12.24.2024.06.13.15.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 15:12:03 -0700 (PDT)
Date: Thu, 13 Jun 2024 15:12:00 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, nalramli@fastly.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [net-next v5 2/2] net/mlx5e: Add per queue netdev-genl stats
Message-ID: <ZmtusKxkPzSTkMxo@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Tariq Toukan <ttoukan.linux@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, nalramli@fastly.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
References: <20240612200900.246492-1-jdamato@fastly.com>
 <20240612200900.246492-3-jdamato@fastly.com>
 <0a38f58a-2b1e-4d78-90e1-eb8539f65306@gmail.com>
 <20240613145817.32992753@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613145817.32992753@kernel.org>

On Thu, Jun 13, 2024 at 02:58:17PM -0700, Jakub Kicinski wrote:
> On Thu, 13 Jun 2024 23:25:12 +0300 Tariq Toukan wrote:
> > > +		for (i = priv->channels.params.num_channels; i < priv->stats_nch; i++) {  
> > 
> > IIUC, per the current kernel implementation, the lower parts won't be 
> > completed in a loop over [0..real_num_rx_queues-1], as that loop is 
> > conditional, happening only if the queues are active.
> 
> Could you rephrase this? Is priv->channels.params.num_channels
> non-zero also when device is closed? I'm just guessing from 
> the code, TBH, I can't parse your reply :(

I don't mean to speak for Tariq (so my apologies Tariq), but I
suspect it may not be clear in which cases IFF_UP is checked and in
which cases get_base is called.

I tried to clear it up in my longer response with examples from
code.

If you have a moment could you take a look and let me know if I've
gotten it wrong in my explanation/walk through?

