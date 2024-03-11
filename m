Return-Path: <linux-rdma+bounces-1379-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60352877DA1
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 11:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150AB1F222E4
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 10:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97B324A11;
	Mon, 11 Mar 2024 10:09:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0034929424;
	Mon, 11 Mar 2024 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710151740; cv=none; b=Qq9FsziI2wS+vDcsV/bPvJHomlgyg4hDXjBgTwPQY8NQN4t4fThGYQFE3FEe1yuxYbGl3SGw3j+MaebE3tu4vT9usbqdX52/xeHb1Q+A0mHA9R4IUwWOqQcTdBPqR2CLrTY40M5XRhSg/HnjvadlqnoPciddyyLTQhaxlQQc/K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710151740; c=relaxed/simple;
	bh=R/LFo6fpPzqsm2Yzj85bW4UQWwKnVon7xRV4xVdmeWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZhngm9DX4/des/fAbazssjjGQ30DkKsIQzey0ud8WPrfv/pNulZFqHkWKc7gdtKcY/NhD+8ximB4s4fhuVMJiudQhZzb+9kIanPHAXdIiZkwcjsyt3RBKsBMXVmNJ1ouPOAXEpIf3b9ADqSxGk9sw/9J03L/PSxXS8X7fod4aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a44f2d894b7so522427666b.1;
        Mon, 11 Mar 2024 03:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710151737; x=1710756537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COk9Hgw7UUv/majYTm6xgyl0r4CF+hFW+Xu+o52Rd4c=;
        b=Wb0nEJvlGjJDnUSG4UtFXTqOKBeBEvEAHYbRn7SRF8sheInCrp/qdcErOcW2ozBO1X
         BPVlkfADdimlU9/pGcmNtIDKUEHoAz74vHn0kiENSGpLpBGzKs4zlEgxapKldPZ0Avf8
         4hVpmeacSDG3Gnvd+p0pzpqR6HhXDE19iAx5/59RO/A4zDUZ1Ln8pyAVYFpdpi4akNAp
         7tOuW07kyA1kZ1E6Nc8ngWu02ZBmQ28TWyWiM7qYiEKgP84uCebxjzFgiVKZlC8lTcjp
         HElwsl4lNID8C45ucWmMTJ21hca7KT5I0k55yUxyp5abnpV3cdjAgLm27fdsJc8LS70D
         w3jw==
X-Forwarded-Encrypted: i=1; AJvYcCXG3tkLGK+d0oQQYxOsyZuOKSSXgHWdws8BLNOTtXpV0F/vxS8ElNoqVNW67ZECPW4KbpGGEwByvJimmIDavAOKogUMwswNrFAW6aNVuMzCGj1GdV8bYakkDRs8tiqlL/VCFiAG9iVTBg==
X-Gm-Message-State: AOJu0Ywh4mDiLxnMkIr8GwnJDQw896X2/3F/Bi5Y/FMJSZ88KDM0A95j
	fIy9jQzXuGGipdVth+46vFINsJTAmz9JqU7Hxsba51VO3mTqg6px5GV41AbV
X-Google-Smtp-Source: AGHT+IErBEIFDcA6ioZuZhdFF83b1PJm+Mi5OL4HTyvKM3sZG2i/U8ZqfVvGeT8ekoptLrgSqlx8zg==
X-Received: by 2002:a17:907:2cc6:b0:a45:d17e:202b with SMTP id hg6-20020a1709072cc600b00a45d17e202bmr4781951ejc.41.1710151737246;
        Mon, 11 Mar 2024 03:08:57 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-120.fbsv.net. [2a03:2880:30ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id h16-20020a1709067cd000b00a45f63d2959sm2690693ejp.210.2024.03.11.03.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 03:08:56 -0700 (PDT)
Date: Mon, 11 Mar 2024 03:08:54 -0700
From: Breno Leitao <leitao@debian.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, kuba@kernel.org,
	keescook@chromium.org,
	"open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] IB/hfi1: allocate dummy net_device dynamically
Message-ID: <Ze7YNu5TrzClQcxy@gmail.com>
References: <20240308182951.2137779-1-leitao@debian.org>
 <20240310101451.GD12921@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240310101451.GD12921@unreal>

Hello Leon,

On Sun, Mar 10, 2024 at 12:14:51PM +0200, Leon Romanovsky wrote:
> On Fri, Mar 08, 2024 at 10:29:50AM -0800, Breno Leitao wrote:
> > struct net_device shouldn't be embedded into any structure, instead,
> > the owner should use the priv space to embed their state into net_device.
> 
> Why?

From my experience, you can leverage all the helpers to deal with the
relationship between struct net_device and you private structure. Here
are some examples that comes to my mind:

* alloc_netdev() allocates the private structure for you
* netdev_priv() gets the private structure for you
* dev->priv_destructor sets the destructure to be called when the
  interface goes away or failures.

> > @@ -360,7 +360,11 @@ int hfi1_alloc_rx(struct hfi1_devdata *dd)
> >  	if (!rx)
> >  		return -ENOMEM;
> >  	rx->dd = dd;
> > -	init_dummy_netdev(&rx->rx_napi);
> > +	rx->rx_napi = alloc_netdev(sizeof(struct iwl_trans_pcie *),
> > +				   "dummy", NET_NAME_UNKNOWN,
> 
> Will it create multiple "dummy" netdev in the system? Will all devices
> have the same "dummy" name?

Are these devices visible to userspace?

This allocation are using NET_NAME_UNKNOWN, which implies that the
device is not expose to userspace.

Would you prefer a different name?

> > +				   init_dummy_netdev); +	if
> > (!rx->rx_napi) +		return -ENOMEM;
> 
> You forgot to release previously allocated "rx" here.

Good catch, I will update.

Thanks

