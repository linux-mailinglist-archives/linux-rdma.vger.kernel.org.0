Return-Path: <linux-rdma+bounces-3530-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A877918700
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 18:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9528B1F2321C
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 16:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2365418EFF6;
	Wed, 26 Jun 2024 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="COXWvncz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387AE18EFE4
	for <linux-rdma@vger.kernel.org>; Wed, 26 Jun 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719418232; cv=none; b=jYek7Rf1BXu99B0eJ/gItkG+A9WkBlnHIwf1/8rS0K8k+GW9zPxdd++z07TfdMjPE9fTN3XxC0jxVWPXWa3AmNla5n2zTOplqUngRaMHCo5gZJAniG0PH5n9mpkX0ABPUBKgYrzsBQgXezt6Z2S1wHeg/vEJZv0sfzP+z2bdvWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719418232; c=relaxed/simple;
	bh=akRn6d8jvAi6S+sjA2AvP4fyQ1pOHaRbAQHrzLBOGwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=naFC4lYzSQ1kYbSN3dt95OmlFP5KE6ipBNRU54oQNbKY4uYD/6rHB0snisejix3LwBnzQ6vFfH0taw/9Z65feVPfclpoybeky4XF2a/qytIPGXUtPU1bwfOfvktTqWTQV1puDtke+ztgcQ6w6oKlhe9zenY3quH7uHQW7/wLsnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=COXWvncz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f9aeb96b93so47415505ad.3
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jun 2024 09:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1719418230; x=1720023030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+yHv7NBW7oyR5/Pl36V4fmIwxGxwzyDxHzUanHXUwQ=;
        b=COXWvnczCfOUhj2ajJlVjHaunfsodPK7G4gALXXCFqZGJZ3JzjYGA6iEt3qdr8T7L9
         p0lb3qG3XC1z7STYGkjjgYlFuzlDvZnlQEKeL0hbf+5+Dlbv64a/Z6KegqWGOblEo4sc
         eAFzyrvoMS60g6Yj7QsANtUrIoI3vQD4wuaQbfmnTDUKEzWob6ic/3gVRoQPnCv3ihfT
         N4Z1v+g3hrNaCKPcL6+KuwDnT9v53BekYUQcjkBcr1TFoZ9QKYsz/9A60Xu0VgGsXDoD
         Q0CfIauRDVNbDIMqx/YZR4VtLhDP30LNzUbvuQw8uqNAcq9CX7Aa0rFuaO7ipw0ROxiQ
         uVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719418230; x=1720023030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+yHv7NBW7oyR5/Pl36V4fmIwxGxwzyDxHzUanHXUwQ=;
        b=XFW9risDEGSxojDlSHEQVezzgfvQ4qmlpu53Le8SAMpyKTJdUY9c4RNh+Fqv7P6O5K
         xHYoF/vht/X/8q5SkEsjkYOg2bID2iSr+vYiKoR+uepQGCb6cjoxn3/2IQgRF/LyCRAV
         h2lo3dUKAkjvgJ49SDfNYPfLmCtNi9q8yBuEA9XJlp4btzFj1ba6/mmdJXGQ+BzMUOq1
         mjXxSm+fM+3LVde33gZcDSmtFSo+vkZrUMkRBCBQc0Uq/7HfwzWHK3KTbW2PcXmqYFBu
         y6VvwMoU4JE/5FVhztUTodWX4LfKzogbRhOkamM9OxQGsvGX2SsPXEigmaCWykCTo0W+
         LCAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUci98D+xTNUnukSJYN+vxRRoYzYGRmC6E+DtKPwB/jBcR158RDfwpjQMYQuJ/3bIoZRYUDzT5CEJEU6im8EdEOQ90Ywtb8sIiQeQ==
X-Gm-Message-State: AOJu0YzzZ8RHuql6HBZDdric4apihozZ/rcqZj61c1p8hxxJ+HFDdtmg
	kaR57Y2UnEZhqySypsUiWoO3xTQFevrf+Zs6tTPmPBhwGlKnmulVhxbRXnkyFYI=
X-Google-Smtp-Source: AGHT+IFfsbEVdvCNCbcIimbmFIq3pNiZ+Go682fp12VuGvUAJvJpsYTOKQn51BeXcBgplalkpsaOEQ==
X-Received: by 2002:a17:902:ccce:b0:1f7:19b4:c7f5 with SMTP id d9443c01a7336-1fa238e44f8mr134434345ad.12.1719418230452;
        Wed, 26 Jun 2024 09:10:30 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d43f6sm101285735ad.182.2024.06.26.09.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 09:10:30 -0700 (PDT)
Date: Wed, 26 Jun 2024 09:10:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Konstantin Taranov <kotaranov@microsoft.com>, Konstantin Taranov
 <kotaranov@linux.microsoft.com>, Wei Hu <weh@microsoft.com>,
 "sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, Long Li
 <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, linux-netdev
 <netdev@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct device into ib
Message-ID: <20240626091028.1948b223@hermes.local>
In-Reply-To: <20240626153354.GQ29266@unreal>
References: <1719311307-7920-1-git-send-email-kotaranov@linux.microsoft.com>
	<20240626054748.GN29266@unreal>
	<PAXPR83MB0559F4678E73B0091A8ADFBBB4D62@PAXPR83MB0559.EURPRD83.prod.outlook.com>
	<20240626121118.GP29266@unreal>
	<20240626082731.70d064bb@hermes.local>
	<20240626153354.GQ29266@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 18:33:54 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> On Wed, Jun 26, 2024 at 08:27:31AM -0700, Stephen Hemminger wrote:
> > On Wed, 26 Jun 2024 15:11:18 +0300
> > Leon Romanovsky <leon@kernel.org> wrote:
> >   
> > > On Wed, Jun 26, 2024 at 09:05:05AM +0000, Konstantin Taranov wrote:  
> > > > > > When mc->ports[0] is not slave, use it in the set_netdev.
> > > > > > When mana is used in netvsc, the stored net devices in mana are slaves
> > > > > > and GIDs should be taken from their master devices.
> > > > > > In the baremetal case, the mc->ports devices will not be slaves.    
> > > > > 
> > > > > I wonder, why do you have "... | IFF_SLAVE" in __netvsc_vf_setup() in a first
> > > > > place? Isn't IFF_SLAVE is supposed to be set by bond driver?
> > > > >     
> > > > 
> > > > I guess it is just a valid use of the IFF_SLAVE bit. In the bond case it is also set
> > > > as a BOND netdev. The IFF_SLAVE helps to show users that another master
> > > > netdev should be used for networking. But I am not an expert in netvsc.    
> > > 
> > > The thing is that netvsc is virtual device like many others, but it is
> > > the only one who uses IFF_SLAVE bit. The comment around that bit says
> > > "slave of a load balancer.", which is not the case according to the
> > > Hyper-V documentation.
> > > https://learn.microsoft.com/en-us/windows-hardware/drivers/network/overview-of-hyper-v
> > > 
> > > You will need to get Ack from netdev maintainers to rely on IFF_SLAVE
> > > bit in the way you are relying on it now.  
> > 
> > This is used to tell userspace tools to not interact directly with the device.
> > For example, it is used when VF is connected to netvsc device.
> > It prevents things like IPv6 local address, and Network Manager won't modify device.  
> 
> You described how hyper-v uses it, but I'm interested to get acknowledgment
> that it is a valid use case for IFF_SLAVE, despite sentence written in the comment.

There is no documented semantics around any of the IF flags, only historical precedent used by
bond, team and bridge drivers. Initially Hyper-V VF used bonding but it was impossibly
difficult to make this work across all versions of Linux, so transparent VF support
was added instead. Ideally, the VF device could be hidden from userspace but that
required more kernel modifications than would be accepted.


