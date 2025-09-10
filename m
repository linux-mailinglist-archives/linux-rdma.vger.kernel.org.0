Return-Path: <linux-rdma+bounces-13252-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E58B51D82
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 18:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48AC81B2746A
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 16:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA542335BCB;
	Wed, 10 Sep 2025 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cizFS0WC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69D6334388
	for <linux-rdma@vger.kernel.org>; Wed, 10 Sep 2025 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521395; cv=none; b=aVw5l/NRvdoGqyP4bQDVZH3ybVOTrS4m3xfHFSAefYd3Y6QQrEYtDyBkDoXqz76M8g8IOXOa3VqJdlkcKJ0i1/tcEPAGtI1gCTIA/i8uoeoUfHfjefdSkJ28mGcc6Imw+O6hJZ61Er90slYiUT9mHwrU7frxQzUGONbBMEUcTSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521395; c=relaxed/simple;
	bh=QV4qaVeduj/yREU+BcPgw7XZ6y4Ontzbperd5ZjM2FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maDZQ9FBjF2uQnXXPRFux3JdmU8SiMJRD+J/xTs+nhfaGy4JZ80ybgF4kGPdmGcfBLCFCY4IBmHyUh9piliVrJAj7GWoGI8kguOMwQpYtnDq67l+cBKqon+sFKvKHmU5Gj5yPmnZghw3pgeQnDjSLSUUUnLsXn47DqMISqW7Tdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cizFS0WC; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-726549f81bdso64616326d6.3
        for <linux-rdma@vger.kernel.org>; Wed, 10 Sep 2025 09:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757521392; x=1758126192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6FwkMlW01VIxUYcm4CJlAUCNZh7Z+O+5WtmWOGwJI3A=;
        b=cizFS0WC8vRAcl0sPHOePwmP9NRrSK0I0cSA0sybqtf6Kk+TwyRYi5NoV9j5By68vX
         txqZjDzCNnLLtjUFgNbLZgMm2PIEjb3diY59e9Rv2MxBfEphYCDYW8MJWJd/Yvco04io
         asuKnCZBaDDJmwvrjjT+CLujnF7ef/g7piEI57c/hvpjvo1XIYz/xQ/MhiBFBhthL4JW
         y6OzRvwKT7STEOcg+M1UZj0/9eKXrcws622boCjDTg2QZkviUxWDyaW0lTu4mZU+l/St
         CYe1jb5r7dMSwcwy5Hbp9dF6KWf+TKAlk/WbJ2r7vHd6ks5+t/6u8rbwR1jJMJjRjM+o
         I8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757521392; x=1758126192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FwkMlW01VIxUYcm4CJlAUCNZh7Z+O+5WtmWOGwJI3A=;
        b=iDDmKx9hozX8daTAtQpH0M8zrwa2RmH9Nt9TzPjjwFaZifhudJI3HxE9JJZ2iFoBAN
         cjeKEHiR1tEoisri3D8k4HtOpKup9ee2GnR+zcIpVUMXCQ3ZIMvvFQ50tVVnuDlqRzF7
         LGTKSo8Vl1ynurfdPPcemNyNUOI58y0HLVi+ra17cNUVqIlusRJqZf3VaRanmw2wReqI
         1p+cPYs27RZhy56pzSJuSjGJtzNxK5lTKSEoEAZ6couyC847vzVxDhmgFC/WENK9ZrIU
         TcacDSqM2EVIBHmpbRFlKPYqnRbEW+j794KvbOkZUJ+hGV1EkKdNu1jB/3O3O4gH/AOL
         MqhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ+ICKW42SThfSHRp3QHQOkwOvfF9uChZ+VGmTWHr3qWZWrx5apIIF5CoJssP0hZqz4aXNxPMvxvkw@vger.kernel.org
X-Gm-Message-State: AOJu0YwUs/Mv4jXWMVgPMT1VpR8ndapqpKRjtlrAmti43i1gzcJGQs7t
	fXJ2EkSusB9Bjy2ojy1rnQlIeWjulfcXQ0hGcTdJLg8jaazHf9+pWTNySkpHWOdsXB0=
X-Gm-Gg: ASbGncu4iljVCMoy+43Q7nWpavdN5qgSiPKQfGBn3SCoZepsEr6nPyzlamL6u343sM5
	Z/iqLN3MiymJYYqZk9IsrAWXEDt96t2uVCg1h2cCLfZBZAV4CeziAHaLlAn7zM0FiyT8qwIj2my
	OPy9UhYKi8Utsa3G9OIgfrGkJNLYZcfAjE8Agv0mGn+MDfRwnt51CuT+nr3OOOYEC6BV6iqu2D9
	AVGmUQFbyUD1hTeDkWEturCiD2d9iaGLF7PHTX5ehRChb1Nt7XTR9HxMFCzmzPWlvPfEtyXMpLj
	4jTs7jOYrvo4ovEnRyRwYmRneASzpcWVP5Eng03/n+yspgE9KEaJk2TrG5bzXRG5CUW4VCrkYPT
	7Irym6bJANzcRTft+OBy0NvWDDson2jEapPgCFFqfkTiebe3qqF2CGdNNK6+PtaljKYaX
X-Google-Smtp-Source: AGHT+IHPGap2dCYWlJBOrKoIpqhzx0hg0+yPsTujjfLJBGMgHZWbcQURT6fJPbtpQWPkXIn9zn4B6A==
X-Received: by 2002:a05:6214:ca8:b0:747:b0b8:307 with SMTP id 6a1803df08f44-747b0b805a2mr108386976d6.26.1757521392357;
        Wed, 10 Sep 2025 09:23:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-721cf6d6cffsm150161886d6.54.2025.09.10.09.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 09:23:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uwNbC-00000003tad-1XQm;
	Wed, 10 Sep 2025 13:23:10 -0300
Date: Wed, 10 Sep 2025 13:23:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 10/10] net/mlx5e: Use the 'num_doorbells'
 devlink param
Message-ID: <20250910162310.GF882933@ziepe.ca>
References: <1757499891-596641-1-git-send-email-tariqt@nvidia.com>
 <1757499891-596641-11-git-send-email-tariqt@nvidia.com>
 <aMGkaDoZpmOWUA_L@mini-arch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMGkaDoZpmOWUA_L@mini-arch>

On Wed, Sep 10, 2025 at 09:16:40AM -0700, Stanislav Fomichev wrote:

> > +   * - ``num_doorbells``
> > +     - driverinit
> > +     - This controls the number of channel doorbells used by the netdev. In all
> > +       cases, an additional doorbell is allocated and used for non-channel
> > +       communication (e.g. for PTP, HWS, etc.). Supported values are:
> > +       - 0: No channel-specific doorbells, use the global one for everything.
> > +       - [1, max_num_channels]: Spread netdev channels equally across these
> > +         doorbells.
> 
> Do you have any guidance on this number? Why would the user want
> `num_doorbells < num_doorbells` vs `num_doorbells == num_channels`?

I expect it to be common that most deployment should continue to use
the historical value of num_doorbells = 0.

Certain systems with troubled CPUs will need to increase this, I don't
know if we yet fully understand what values these CPUs will need.

Nor do I think I'm permitted to say what CPUs are troubled :\

> IOW, why not allocate the same number of doorbells as the number of
> channels and do it unconditionally without devlink param? Are extra
> doorbells causing any overhead in the non-contended case?

It has a cost that should be minimized to not harm the current
majority of users.

Jason

