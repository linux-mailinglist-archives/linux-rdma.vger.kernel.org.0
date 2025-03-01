Return-Path: <linux-rdma+bounces-8214-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2A2A4A6F5
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Mar 2025 01:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 737213A87B6
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Mar 2025 00:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BE68F7D;
	Sat,  1 Mar 2025 00:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gpv7V+AI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8382134B0
	for <linux-rdma@vger.kernel.org>; Sat,  1 Mar 2025 00:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740788768; cv=none; b=JZM6MfmCObcjU6BkLU+LBqKeGnIw1l7n9XqHDWUh19WN4MUagAmo/AVnhn9630GIpN5Zd/AxoGeGuRnQALx6fROXMVKl/LUzD3DuLdLH5+9bk3eAtqd4bdEg540+lTDOchHvRTX6bejDYqFfSRGGdn7cozNh8G3VaCx5s2NJ+ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740788768; c=relaxed/simple;
	bh=jt+YgGSiFXOrJ2kMp5YlfSPDZmSqABt1Sm51ooGPve4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2vP2NaWnYGF3FcPU2KwrBuwaYqLHtLtGcHuqLQDl4TYulPK549lEI3zQzauSOAdvmgxOjzhBEHwrawyoqXOS+ECWhomKNG1goqwcHkdpcKun2FRIuA2Cvr3mLK1uyIH5Kl6To+EB06qMTmfCHufU25PIOVKa+NgPRq8m5GlgpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gpv7V+AI; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c0a4b030f2so347897485a.0
        for <linux-rdma@vger.kernel.org>; Fri, 28 Feb 2025 16:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740788766; x=1741393566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0MtjatnVjNgixbPBCXKK66vO3DHibToClD747DlzON4=;
        b=gpv7V+AIvU6HPQK/fWhrX9SypMpDstpd6Ga5Dge/1xDOpsTBmteK6W5UmEiu64Ob03
         qLblIWyexxvbqX9E5t126afmtuaEw3piR7Dlg81JINouWlTB+UsXubzFKIBi7uLDeZ/g
         VE+yTWEYQi+abKsSZJaTARDKtV8MXd4LOMuw/BA1quw07K9luLwUe9UQpANKm6rF0kAL
         26U1JQeLEQIPrlZU2n7U7cSSIlAY1pkz+ZLy/QrVFUID4/qp1czyWJvEztL9KGLZnNgA
         WLHF2RMGC0BD7e+UnvMA+19a63JE1AKnJd/kfEbA3F3M0VdajsmXaw41DpwKHUjglIgW
         6N3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740788766; x=1741393566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MtjatnVjNgixbPBCXKK66vO3DHibToClD747DlzON4=;
        b=AKuqfN1uqYpkUZM8NOnSPqVew7wjabt7lcaoardLBZARZpLYYGjVtdNek907G5szpe
         9KLucJaGrQWx0bJgCGf246t99sPyBO3D0a4MuHFU+ndr6iAtoF1poCyayWHN3zRwFvVg
         lRIPc36ak7wwP++cxo0Bp4zSxLe5FW09RIdfyjupDhnraU8jYyda357O4Jpc7t2gzXtV
         z04mzcHyqQTOsu/gU8dJ2gywaKUBxzPeJTd2SXJ/5KLg4m4fukgo2E0iA0DWdXqiCivo
         zMN3Z+gE3kLoZLIZvINr5ZttmxY+IuFF6O3s+66gFSu3zfObA6UXJzfPVux9Y4DiuRNS
         67oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVss1Dg4HBrhuQKIjsq93xKAhdQCvynhXlH1VMFSbz/lpdjMQxNQca5wDSFGd1LDS3DM3aP7PMmTTZ+@vger.kernel.org
X-Gm-Message-State: AOJu0YycMGwPFJwf8nkktgu6nI38kGuMxYeag+EIYeMK1iCw5Eafg1Z0
	KC69gc8BHj25QVss/74ieaG66lOUPzBGJbPtyyvTwXX1JWKC+uVMB8EiTJgkUNM=
X-Gm-Gg: ASbGncsiGznveNODv/TXlI2p091iqoHWulzK1meoSt2PhfgTYxjMNODP8m+OipnbFBf
	MKOHhkS0PD2QrBMDLE/W14O1qmn9G2DnyqvvIsMPCQJZ953MrALcVjlk83p38//JmWRKVv5fjl1
	Sjx/P3g39a03PZ0kj6mBFVRgjpf/FqGm1Pk3o4ZhGgZF6nWbmpG56GFi+GnkFw1fBVe5c9XIttV
	scYzdRTs6KhqYcyrepI497o1aTj0ZnxOJJIcrjoSPE7y5lok7j9kYvJmseB66MJyPhX1JlHSFw6
	ztIpFtePmvDdASj5PO3vkOwrmhj4F+Z6YyeEgpLrQRAptFhWuOQ8ggVJCT06yhwQkJYwaBI4eqY
	dDsJsS+DA4LsIFB6UAQ==
X-Google-Smtp-Source: AGHT+IEyduZmKmDeBUENZfmGzGgg3DhASjWA/ktGwI0e/xDC6fTyc7s+TOl/wjMJMYfdyHxWvUKlYA==
X-Received: by 2002:a05:620a:394e:b0:7c0:b7ca:7102 with SMTP id af79cd13be357-7c39c64d2cemr801166085a.38.1740788765786;
        Fri, 28 Feb 2025 16:26:05 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e89765377csm27572316d6.45.2025.02.28.16.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 16:26:05 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1toAg8-00000000VLR-0rfV;
	Fri, 28 Feb 2025 20:26:04 -0400
Date: Fri, 28 Feb 2025 20:26:04 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: longli@linuxonhyperv.com
Cc: Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: Re: [Patch rdma-next] RDMA/mana_ib: handle net event for pointing to
 the current netdev
Message-ID: <20250301002604.GN5011@ziepe.ca>
References: <1740782519-13485-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1740782519-13485-1-git-send-email-longli@linuxonhyperv.com>

On Fri, Feb 28, 2025 at 02:41:59PM -0800, longli@linuxonhyperv.com wrote:
> +	struct mana_ib_dev *dev = container_of(this, struct mana_ib_dev, nb);
> +	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
> +	struct gdma_context *gc = dev->gdma_dev->gdma_context;
> +	struct mana_context *mc = gc->mana.driver_data;
> +	struct net_device *ndev;
> +
> +	if (event_dev != mc->ports[0])
> +		return NOTIFY_DONE;
> +
> +	switch (event) {
> +	case NETDEV_CHANGEUPPER:
> +		rcu_read_lock();
> +		ndev = mana_get_primary_netdev_rcu(mc, 0);
> +		rcu_read_unlock();

That locking sure looks weird/wrong.

Jason

