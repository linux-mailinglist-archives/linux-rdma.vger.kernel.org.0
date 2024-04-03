Return-Path: <linux-rdma+bounces-1760-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCE9896ECA
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 14:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B44E1C23FE6
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 12:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987B6145FFE;
	Wed,  3 Apr 2024 12:18:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEFE145FE9;
	Wed,  3 Apr 2024 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712146691; cv=none; b=ZZ/wp6sESSgIqdoHrfq0kb+DJeyTyQSP1wsWOPEB0PIjkXKr7Kg2bi7t/kcJNLXYdhF3tvHNZpEwMxUOtUip9DCwrm+H6R0mPXUMA6LFSEL9jJV4bskkI+s9b2Km0SbExgmaZ2axMu1IfFRWCUyUT8vyJOUIBPkQ9MCdZjarZQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712146691; c=relaxed/simple;
	bh=7aQEolH/bYahKfD2MbBpmzlriV0zGZkS0AmAA/p9AoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImB4PxT1T1rt3dPIuUVaqyUGZCxV5/OiTwTZayiDcuxCp8zvcaVwsdK780YUM/aQ78Ok3JRjc1W7Tz50v6dxVm2fEW2Z5T4jrsm4PMZfK8GdqgfF06tkrGbPWI77AsC3w1ONKs5y6Y9IXZDDF8DQlhmcpzpHhEPf+M/fJR31P2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a51320fc5d6so57123366b.1;
        Wed, 03 Apr 2024 05:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712146688; x=1712751488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Au+qGYcIXnyg9fBfqDiuIqwrBJxSF6u8tnJvbmFQaMM=;
        b=cCjy1j1V3ezly8HNKaCVjDstw+X2sFctkTzpt6ZNHsSaBIL8HxjNaj/flDe1JApqrf
         fqoZYw/wz+xyKyMASCcolqH4KKVIkN5p7TqSQyGaKKwP4wAg8xKZs9hoVmBVonphITHU
         rFaMSazWLrJT/NplP8J9Md0k6nqs2froLVrj5XOebhqiwHy0Ui7VR8921vwLrIscRBs4
         xGQimvTbED3SUZdQqMcNvrKuAjlRgUg0NizhEmswbOGQdd8+erFkqcctzxhy4igH/s6+
         5yYFKC+HI7ie2rTV0U3IfNrqkCzjtqricgJocVyliuBRrmQnFmJI/qesj10WYFGGP54D
         6DiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUii1mz7YB0ZcfX3nExzTmlIS1xzX9KWuMgQzjjez8SUpnMpTvJrgfzW2z8NS58QZFAGsP7X+dJ0g+dFpeKGGqk+VazmecMhYbMEDUnGjspbyvK/BmQjOm/PvHxeqAEjh7f8wz668CQGg==
X-Gm-Message-State: AOJu0YwVt2xJX7nOxPfr1m2+ztaWHwKK+lmWUeW0qXxYVqlhaxQCcmMi
	o4uXPHiwpe2Md6E8i2pUT1L4FawGTzgewliO7WIYIedSampyFAcP
X-Google-Smtp-Source: AGHT+IEOJdetlicCrsCF+SFLYXMhXKQWpZlQDUHPB92I2W6WXeYLGh0AwZ8wL2eGROp9RZzePxnQxQ==
X-Received: by 2002:a17:906:f6c6:b0:a46:cc87:12f3 with SMTP id jo6-20020a170906f6c600b00a46cc8712f3mr9250582ejb.75.1712146687766;
        Wed, 03 Apr 2024 05:18:07 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id la6-20020a170907780600b00a4e2db8ffdcsm6902621ejc.111.2024.04.03.05.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 05:18:07 -0700 (PDT)
Date: Wed, 3 Apr 2024 05:15:10 -0700
From: Breno Leitao <leitao@debian.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, keescook@chromium.org,
	"open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] IB/hfi1: allocate dummy net_device dynamically
Message-ID: <Zg1ITuSCHW/T+QUX@gmail.com>
References: <20240319090944.2021309-1-leitao@debian.org>
 <20240401115331.GB73174@unreal>
 <20240401075306.0ce18627@kernel.org>
 <2453e7d4-fd50-42ae-a322-490e7e691dc6@cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2453e7d4-fd50-42ae-a322-490e7e691dc6@cornelisnetworks.com>

On Mon, Apr 01, 2024 at 11:34:23AM -0400, Dennis Dalessandro wrote:
> On 4/1/24 10:53 AM, Jakub Kicinski wrote:
> > On Mon, 1 Apr 2024 14:53:31 +0300 Leon Romanovsky wrote:
> >> On Tue, Mar 19, 2024 at 02:09:43AM -0700, Breno Leitao wrote:
> >>> Embedding net_device into structures prohibits the usage of flexible
> >>> arrays in the net_device structure. For more details, see the discussion
> >>> at [1].
> >>>
> >>> Un-embed the net_device from struct hfi1_netdev_rx by converting it
> >>> into a pointer. Then use the leverage alloc_netdev() to allocate the
> >>> net_device object at hfi1_alloc_rx().
> >>>
> >>> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> >>>
> >>> Signed-off-by: Breno Leitao <leitao@debian.org>
> >>> Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>  
> >>
> >> Jakub,
> >>
> >> I create shared branch for you, please pull it from:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=remove-dummy-netdev
> > 
> > Did you merge it in already?
> > Turned out that the use of init_dummy_netdev as a setup function
> > is broken, I'm not sure how Dennis tested this :(
> > We should have pinged you, sorry.
> 
> This is what I tested, Linus 6.8 tag + cherry pick + Breno patch. So if
> something went in that broke it I didn't have it in my tree.
> 
> commit 311810a6d7e37d8e7537d50e26197b7f5f02f164 (linus-master)
> Author: Breno Leitao <leitao@debian.org>
> Date:   Wed Mar 13 03:33:10 2024 -0700
> 
>     IB/hfi1: allocate dummy net_device dynamically

This one has a potential bug that causes a kernel panic when the module
is removed.

This is because alloc_netdev() allocates some data structures that are
later overwritten (memset) by init_dummy_netdev(). At the free time,
free_netdev() will dereference those structures and they are zero.

A new upcoming patch is creating a helper (init_dummy_netdev()) that
will allocate the netdev and call a special version of
init_dummy_netdev() without memsetting the structure.

I would drop this patch for now, and I will submit a new version using
the new helper.

