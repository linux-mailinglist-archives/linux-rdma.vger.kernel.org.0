Return-Path: <linux-rdma+bounces-6452-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BEA9ED0A5
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 17:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3491282A6C
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 16:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C5E1DAC89;
	Wed, 11 Dec 2024 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="brFS5u1K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A792195FEF
	for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932859; cv=none; b=sNUwoXcHhH9eTg9ztQS2dTjsvDhn5/sGkSNDHPXvU6rmcaoUtU4141pIWtC5Igin71vriUr/pYEEeb8juq/vQJO4Gyv/Fy9iy6YPoEFWbnYyCRvJlpnQLD644cxGtz9YR+lRUS/VkYm08dACh8nobX9JGk1PwFKU2afN6eixpgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932859; c=relaxed/simple;
	bh=YVeA8O3i7Y8Q1EHeW6JgR9d59C4yRq8yEHlcS5ZMdnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/9PqDXnnPBcgRr9h6l+/EiZ6/eu/D7JhgCkZAFVpJ7BgYfCZ9Epjzbu4L5UDsAlA6oB4SDzbBIx/SwV+cof/eEcJJwZZjDH0howqqXl6krIGnXBSyq/DD6IRPMLiq801vyZV3Y/Q0a+dUskjQDcHm6JolYjgwHJq46p76CLkIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=brFS5u1K; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b678da9310so620032185a.2
        for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 08:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1733932856; x=1734537656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HV9Ft1tIX39VZGq6X6Q++chZExuhbKDUHOANQjurrlo=;
        b=brFS5u1KiTmZq/Dy27QjElP0PvGhgkk74zWU/gyyZuWdSnn2JFWPTqYE9d0+uUUSo1
         nWjVVLD20EIHbPAxfV9BMzYxW/8+BSvJAhJEdCAnt3K2ak/X2vLBJCQGrNBUj3P6I3Hl
         yzA3Ruty8NWwCDIbl20zlLOM6oM9jIgrp9USnkfkuJSCLyrE1c1uMoB+ue1CcUR5fMwB
         IrCx8DCus/gaHxUm89T9NqRlFkvbQvDEsPKCYGF+cEh3pVSxT8o3EVHsaKpYIw75X9nY
         qS+Ax8eG50iat8uNXUFS30nsA6IeTAyUaF7D5SFRM0YOEyuHRdbdlGqjCswPyn+Kl+5m
         Oc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733932856; x=1734537656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HV9Ft1tIX39VZGq6X6Q++chZExuhbKDUHOANQjurrlo=;
        b=TDySzob9yTL9L/+T7QzAZZ8jQ2tqRklLNdXzlRn29A005XIwFduRS7YD2JK/h913zd
         5gmmh5HOKAnx+OUJCT8crX5eaITX6ZaWolsP3UNDXu5aK6+C+ozJOJX186HY2cZD+FST
         o3NkUFdeT3ho0ACXTGIU9I89Sx/tZ377m7RAJ79jJM7PKUKFD6CtXzzhMjTNK1lu7bqa
         layAia2uGarl7UiMQcG6+rvWMZ6Db3oQt3BY6vAhKHbeAky+DWFKyUFfVojv5MnIfoJP
         GKQYoF1kVF2tv9aiNFuVep6oJ17/CiltT5F52ufYQiSkSejzvMtEWRhO8KcVNycyo22a
         JDOg==
X-Forwarded-Encrypted: i=1; AJvYcCWHqWUeinnWXjZ+1+383W0UxI2zxuN/XC3ReReP/cFERK3NUy2/NPGf78cczTIZ5wwHT1cMaR0aq8kS@vger.kernel.org
X-Gm-Message-State: AOJu0YzrkzowyZPtO/9+8YaZ86agScyz7fnCuTcD4ZbNOTIPegrhUVSz
	O371mURrZCOLDVkzNrQvnE+/HpZeElox1bLXuBoySep9fCHvAIGDzUq8X/eb1yg=
X-Gm-Gg: ASbGncvXQCNZ/NkLOeU/xIptHCnZmzLEKPCYSBWL5a/2w1ixnXeullpE4ZYkbUd9rbU
	7wsdTNB0apW3OdDov2rxuY/9PsE5C2K+b0l/LHbub0+40jKqxr15+M+uWvM2zbBCCzuUkeUsNSi
	OXHcwCt/Er7sOjpIWG0CEVxUg85qlQeNx40FpVHfrB/Q0O14bWQlzSrDBSL8hzCgz0ffwHAaxnB
	DixpvR3jFy29k7QTGIP3TI3vQQZF++BjLJBlBOmn4fUv3BVZKhfS3+Tjj/MyYcar54IAqNs97wx
	u/H/3XEnEmrP1e5E2EnOzIIbPds=
X-Google-Smtp-Source: AGHT+IF0blHLPw5V1rIaiMGPynlooTCXklunTpSd4ZXC/5lxcxc+hoeJtBja2c6cayFi/JFjdMdhAQ==
X-Received: by 2002:a05:620a:4088:b0:7b6:d8da:90a3 with SMTP id af79cd13be357-7b6eb525549mr660409285a.44.1733932856267;
        Wed, 11 Dec 2024 08:00:56 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6f08580b4sm24160685a.11.2024.12.11.08.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:00:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tLP8x-0000000ADwB-0ccP;
	Wed, 11 Dec 2024 12:00:55 -0400
Date: Wed, 11 Dec 2024 12:00:55 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org,
	leon@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	zyjzyj2000@gmail.com,
	syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com
Subject: Re: [PATCH] RDMA/siw: Remove direct link to net_device
Message-ID: <20241211160055.GM1888283@ziepe.ca>
References: <20241210130351.406603-1-bmt@zurich.ibm.com>
 <20241210145627.GH1888283@ziepe.ca>
 <20241210175237.3342a9eb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210175237.3342a9eb@kernel.org>

On Tue, Dec 10, 2024 at 05:52:37PM -0800, Jakub Kicinski wrote:
> On Tue, 10 Dec 2024 10:56:27 -0400 Jason Gunthorpe wrote:
> > >  struct siw_device {
> > >  	struct ib_device base_dev;
> > > -	struct net_device *netdev;
> > >  	struct siw_dev_cap attrs;
> > >  
> > >  	u32 vendor_part_id;
> > > +	struct {
> > > +		int ifindex;  
> > 
> > ifindex is only stable so long as you are holding a reference on the
> > netdev..
> 
> Does not compute. Can you elaborate what you mean, Jason?

I mean you can't replace a netdev pointer with an ifindex, you can't
reliably get back to the same netdev from ifindex alone.

Jason

