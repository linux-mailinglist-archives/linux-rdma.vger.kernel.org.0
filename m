Return-Path: <linux-rdma+bounces-2313-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C64E78BDF65
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 12:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 284FEB250CE
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 10:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5DC14EC4A;
	Tue,  7 May 2024 10:07:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C865314E2FA;
	Tue,  7 May 2024 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715076432; cv=none; b=EiQDLBUXDi9iaxtNmqdk0oHBnfeha8vJ4tSyEEogJOu0QhsgS0Lj4DRBk0GQZPizf++Yl9YUBvQ9OVStIPMqZm5KBYY8cyF9wNJWoIhkWGE3RBMvoOaqvciorA2kqtqQomk8RgJGP4yI9bxbAEnoYXSL5V6omBOz3oTc1i0ccMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715076432; c=relaxed/simple;
	bh=S7omKV9kOMCmdCuTu6dz7wlUE+c8m51RsRDdwQ2VgNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdpHuA547MVk+Axufaad0Y/vR4SMO+uLZoYGNBB2bL+kFWoNpXyY+psnuqbxKJhmKyAEgC2ifFuBJLNsNlXNQbr6Akr7efP6fGjB/zpes/4iC12/BHdVv0qnVw6VzW8REgYXTQGDBs4Z45S33xhyQv1K2+W7sNNy9X8arV1ZvhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59ece5e18bso129326466b.2;
        Tue, 07 May 2024 03:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715076428; x=1715681228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXoVtGhI6zkYKaNS7ndbrEmy/g3ybw+z//AryJkqLgM=;
        b=I6duP6x4yt09LDQk75jgUtfbmqW4QiBMszAGr0GLtK5G6gHGyi64xi9fNZW7EfN6iQ
         vcOSGbeqknms6l4auUdvmx+uHLeeHglvARF6K8YtEZG6dbBpR/xtO1YLtZ6dpqf1/B90
         c45E5PZ42UDCw3eq6dmqvFiXph+EltciGzfqE7/LQ1p8PPNQjqsDPn1MvCXW9Zx2d4Kb
         ae9T70Ig7t8v9Ihqa3kKDtjki6K0t82Bv5q/o8vZCQ0lPZYsrIyhVxPs6Gl1KPBzEX1B
         t7GmOyaDzamz3f1anRbHVy7LEpSmX72JDQ9sMcUGyQ2QgRGnijheRUK8T4h13t/0vC9v
         sr2w==
X-Forwarded-Encrypted: i=1; AJvYcCVYQZyViu8SS2F8ZdqK21w4Re0t3GiATWo1w20vqzw+itR78WzBLkXwkUXnNHyM2iZ+rjbxLzwYUdKYNWTKaNhovlE7Ee2HByHQ1lg1rkrMlhnlyN6ylwlDamqNXTXwT41BVkaTXCfnk8pIDjNBztXOUBQgBjoych7k4FGBvP1Gbw==
X-Gm-Message-State: AOJu0YywBEBLqoBhaN73bsl2Lv+/UB+cNxw6vtSn57MMbpuLp5ZlZJPs
	ePmYgiSSUEczM+t8aylRPgoS2uMzUgPlFd5CRO8bpiMKyygGrvkJpj3JOg==
X-Google-Smtp-Source: AGHT+IEEbaozK4NAuVJcdD+Du1WTr36eoSupIvJ1svJ8Z+Vst9GF+gREZCyMJdd56oz0ver9O/hNQw==
X-Received: by 2002:a17:906:b149:b0:a59:c3a5:4df0 with SMTP id bt9-20020a170906b14900b00a59c3a54df0mr7105921ejb.4.1715076427836;
        Tue, 07 May 2024 03:07:07 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id p12-20020a1709060e8c00b00a59a8f595ebsm4007272ejf.192.2024.05.07.03.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 03:07:07 -0700 (PDT)
Date: Tue, 7 May 2024 03:07:05 -0700
From: Breno Leitao <leitao@debian.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, netdev@vger.kernel.org,
	"open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] IB/hfi1: Do not use custom stat allocator
Message-ID: <Zjn9ScolCtJV+ZCp@gmail.com>
References: <20240503111333.552360-1-leitao@debian.org>
 <20240505141032.GE68202@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505141032.GE68202@unreal>

Hello Leon,

On Sun, May 05, 2024 at 05:10:32PM +0300, Leon Romanovsky wrote:
> On Fri, May 03, 2024 at 04:13:31AM -0700, Breno Leitao wrote:
> > With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> > convert veth & vrf"), stats allocation could be done on net core
> > instead of in this driver.
> > 
> > With this new approach, the driver doesn't have to bother with error
> > handling (allocation failure checking, making sure free happens in the
> > right spot, etc). This is core responsibility now.
> > 
> > Remove the allocation in the hfi1 driver and leverage the network
> > core allocation instead.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/infiniband/hw/hfi1/ipoib_main.c | 19 +++----------------
> >  1 file changed, 3 insertions(+), 16 deletions(-)
> 
> Please use rdma-next in the PATCH subject line, when sending patches for RDMA.

Thanks for the heads-up. I will make sure I use rdma-next in the next RDMA patches.

