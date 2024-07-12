Return-Path: <linux-rdma+bounces-3849-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9816D92FAEC
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2024 15:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB431C222D2
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2024 13:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61C416EBF6;
	Fri, 12 Jul 2024 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ewFLER+k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCFD16F27E
	for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2024 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720789850; cv=none; b=avIUAJVCUpeOhNX0srIoO6HOexEM0ZLhEOjpUO1fNx9zllSCbVXAa4ENN6is9IIxBb/gCLH6MdSb57GnHA2entY4Ng4IAYbBxxCYf+NRew8pERp3QPQ6jUJ4AdKHrgIQCEThejJx8XWsnLygacJU46CSola6vNpVwiS0SywPOmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720789850; c=relaxed/simple;
	bh=UtJMHQvWfusPqtpiOfCp1BNuYWWiZXtBctipalg2Qg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BG1WREfAL7VE7gen4Xew8bEncN5BasLCmrmVoojqsOcAAnBXcxaI39yhhbEAyXQO+KNIx4bQTWW2cqZd1Kk0vH48XLU8TNX1hhds8Ln3fc6BV6WtnPLi/z/v6puZj9cPv/Zkq8qjk8UyYusjc1cNRE5t3skPnd7+qsi92om1OoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ewFLER+k; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e03a6c1741eso2043797276.3
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2024 06:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720789848; x=1721394648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HyZTOiBbFCAJKkisLkTJIB1ZsdZKe9/UTDkQ9y6AljY=;
        b=ewFLER+k6qcq5t6mu3thvTZFNtflFNrqYg5Q4utIgzArHA65s6P+m5jg3ASiqlLJIU
         7AWhp5aS1/GYaE9A9pitxI9+yEBZWD7hM1eB0h9E7mT03xcNHbLCJumf9ZGSkCBcHPX/
         yakkWHUezrayiaWHs34p1yIaS+a/Vog/cAFSiLHofuEnIQtPFvQgwzZuNrLLjAh029ra
         cr/8dtXe5qkSV03qH+o6PTv1ruHrQTqkQUDLhc2xqNMzxhmwzxvSay+VXV/wxJfqpw1E
         tskFEUtPqa+ynwNWZ/hVnGOZ3hRyOysI/BcpgWUq1E+4L2hmTTXeYR3k6mZlzoFiU7Fb
         c8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720789848; x=1721394648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyZTOiBbFCAJKkisLkTJIB1ZsdZKe9/UTDkQ9y6AljY=;
        b=ThKvA3iqY39tZlgSydMD7gEyMC9v2CCxtSNbK05aDQSKwcO6O9oLITV0bIbjr7oml7
         hHMM0AHSmkYDZZ/be2mnFETQFT8oh+NMteqJ+OZLswv32D1PfF7PmotC9Dg4fRkyY2v5
         KhFRHqCueBP+vUa6WHHh3k9ANGgQ4TgWAkc+0JTlpb2W29oUR4PxU6Q0fMqVxBP0ABC2
         sbXip/tLUAGLieUTXLOlErqqNoyFQi6KRKX9LfVyc2qtIKqGi2RxvY/B+blfwzuzEpoY
         DmUCM+o5xdCpy6u7exKXTIkntZy80yQoXfMIVTK+xdx7KFIULTLdWl1MOFBJCpafhDu9
         BXjw==
X-Forwarded-Encrypted: i=1; AJvYcCWNSjHMvhvyOKcXf/D7/5hP668Xu3JyOqaDzj8LwwKRHb15sE8VSknj937G1IXFAr2vbdJ+MPOQEbF/4lu1OH+wUq77LQLJLyx4Ow==
X-Gm-Message-State: AOJu0Ywof3gOCMqsLoo/JeX0HaGSfz1NDNJuuu4UNEJ9mKnlQlMZUh60
	81Eg/M0Drf17SWub5MZ7gGfpzLY5PzchXN7uRDb5t5+DvtUzWpMzExFS7Nl4bHQ=
X-Google-Smtp-Source: AGHT+IHSBzK1y3WtWC/D7x6bbdRy29RS/PSjafmO8OR6e8heelqxe+tQuRF8wlhxjn4mdpcSc9UE4A==
X-Received: by 2002:a25:6801:0:b0:e03:3598:2989 with SMTP id 3f1490d57ef6-e041b17859dmr13224328276.45.1720789848320;
        Fri, 12 Jul 2024 06:10:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61b9c4328sm35029046d6.14.2024.07.12.06.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 06:10:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sSG2x-000Kx0-DX;
	Fri, 12 Jul 2024 10:10:47 -0300
Date: Fri, 12 Jul 2024 10:10:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Omer Shpigelman <oshpigelman@habana.ai>,
	"ogabbay@kernel.org" <ogabbay@kernel.org>,
	Zvika Yehudai <zyehudai@habana.ai>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	David Meriin <dmeriin@habana.ai>
Subject: Re: [PATCH 12/15] RDMA/hbl: direct verbs support
Message-ID: <20240712131047.GC14050@ziepe.ca>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
 <20240613082208.1439968-13-oshpigelman@habana.ai>
 <eebde0ac-9da1-4c52-b52f-a775e2c0d358@habana.ai>
 <20240707075742.GA6695@unreal>
 <e27efbb9-fdf5-4447-87ef-71e0fc34bbb4@habana.ai>
 <20240707090044.GF6695@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240707090044.GF6695@unreal>

On Sun, Jul 07, 2024 at 12:00:44PM +0300, Leon Romanovsky wrote:

> > >>
> > >> I'd like to ask if it will be possible to add a DV for dumping a QP. The
> > >> standard way to dump a QP is with rdma resource tool but it might not be
> > >> available for us on all environments. Hence it will be best for us to add
> > >> a direct uAPI for exposing this info, similarly to our query port DV.
> > >> Will that be acceptable? or maybe is there any other way we can achieve
> > >> this ability?
> > > 
> > > I don't know, new rdma-core library with new API will be available,
> > > but stdnalone tool which can be statically linked won't. How is it possible?
> > > 
> > 
> > If iproute2 package was manually removed from some reason.
> 
> If it is user's decision to remove it, it is user's responsibility to
> deal with consequences.

Yes, please don't bring backporting crazyness to upstream. Upstream is
supposed to be a technically clean self contained solution.

If you need software to be deployed in userspace in backport
environments then take care to get that software deployed, don't make
hacks in upstream to avoid deployment work.

Jason

