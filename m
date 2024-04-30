Return-Path: <linux-rdma+bounces-2175-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D498B7C54
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 17:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E541C22C41
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 15:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2293D1802CD;
	Tue, 30 Apr 2024 15:53:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443CE174ECF;
	Tue, 30 Apr 2024 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492427; cv=none; b=Me2P8fyJMLAW4gNrpRKQusnKHXEHheeAzKRuYx/xxPF5ivt4Ww4PSE+OMMbu7v3l3PACieysoDNbeN434E0LQYDrYi+vb0qHiReoTItBu0kT0svjnv0ChQHppYKrOoqFlcqgTNNIKSpeA+N6GDmrig77Wqe3ccDCA4R95tPti4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492427; c=relaxed/simple;
	bh=I89NMWOc+oSqQJ4rc1Mq3xhhpu353RBk5ietD8MITtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqQogsnaB8wE/aiJFKnFbyL0rlIKsLgjlB2+jn4gyk6gtAIcCC7Ks/0dXzf3gLET9TbQl0baXlfJPfQulINJpg6MH6Hdh4nb675ABsEoaDfYeIC/K9Ge2+kmtHBBEhvbYT8dCXXO7q4Tea0377MGvkZY4OYHqcqGoWGIuioMag4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a51f9ad7684so402083566b.2;
        Tue, 30 Apr 2024 08:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714492423; x=1715097223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmsdIh35cw7AWH4Zqk6LG7hPdUjW6CSZqbYw7zoyiBY=;
        b=k9MGsC9JKde7RiBqX9Y5/TBGO+rmHy9vL5cU72GBJ6+5Wp0/WSwuIU3e7/Fwl+rI4l
         i42/fgCbdZRmEbMkBSkYmT1x1w90zK7PfdVCz58zSs5OgALTBt1WWcAgNR8YHlZj9a/e
         m6f2i/RS+N4d+5ECdS3on3xionPExB6BinFOTM7hmCA45xGQpHlOKN6a0xZlCzyhWLQI
         jjDrdtYzFB2Q1AvYsjQbVCM94LLcfkajw9NNBfaxQyvgKhm7pL11WZNjE8VsRRNDRNW+
         t8GMd6vT4ZOz4aGn5qct+yShhEwjGqyjd/DTRgl9rTuk3t/GoVcfDLis9d/aepNFkYXX
         z0Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVKQjw3sQ+JEZeIDQ5K5ulu7WlZM1R1YhNQO/wg+l7oRrlhN3ixtCaJcSTOBzdJmNEmaTfoAEiUTYQ8nzB709AbD8KQl/Xg2X9XT+koKEJ6kquLDzTVeL66wHBEempa2k0oDWjP6nT7FONJT2DFE/DGiDZMqhNjXaWz3k7a8/jAEQ==
X-Gm-Message-State: AOJu0Yy5rc+bWSr0pqOCKvHp4QdzFoEVXqeV0Tn85behA+GKJQmGILkt
	UGlx8WijkrwyB/bGahZz1KUtE1Nz6h+Ix0iVlqq6d3HtMnuEcApDBEdBuw==
X-Google-Smtp-Source: AGHT+IHm2Gp5IOd0nOhfzbq7G5ippoA+YneekBG3MuhYCYYd/2pc4Cz2eJlTpzlAmUIpifzIzmCx1g==
X-Received: by 2002:a50:d49e:0:b0:572:67d9:6c3b with SMTP id s30-20020a50d49e000000b0057267d96c3bmr163655edi.26.1714492423279;
        Tue, 30 Apr 2024 08:53:43 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id y23-20020aa7ccd7000000b005727c9aec9csm3018732edt.31.2024.04.30.08.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 08:53:43 -0700 (PDT)
Date: Tue, 30 Apr 2024 08:53:40 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	linux-netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] IB/hfi1: allocate dummy net_device dynamically
Message-ID: <ZjEUBGW7cVUalhNW@gmail.com>
References: <20240426085606.1801741-1-leitao@debian.org>
 <20240430125047.GE100414@unreal>
 <49973089-1e5e-48a2-9616-09cf8b8d5a7f@cornelisnetworks.com>
 <20240430141039.GH100414@unreal>
 <20240430075534.435a686e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430075534.435a686e@kernel.org>

On Tue, Apr 30, 2024 at 07:55:34AM -0700, Jakub Kicinski wrote:
> On Tue, 30 Apr 2024 17:10:39 +0300 Leon Romanovsky wrote:
> > > Nothing right now. Should be safe to sent to net-next.  
> > 
> > Jakub, can you please take this patch?
> 
> We'll need a repost, it wasn't CCed to netdev.

I can repost it and CC netdev.

