Return-Path: <linux-rdma+bounces-931-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6B984B7F6
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 15:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8B61F269E5
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 14:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3D7131E44;
	Tue,  6 Feb 2024 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Yqr92IQH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841B222F1C
	for <linux-rdma@vger.kernel.org>; Tue,  6 Feb 2024 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229945; cv=none; b=QdpVT7EAN38WcmXnhRTjEWMB3JtozXZnRFxvADxtC90NHSIqsHJfK0gNgeuSFDN9jFvEvcSNodswu+Ke1FvY8EMpOu3DILSmIrgr9dX1zm9qDoJuEg9yyeL4D+2G85Z2BYPHOOvzBs6ueuf55dI1TJQmQkRjwgntL+Y7HDheAQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229945; c=relaxed/simple;
	bh=qmeIFysAignszZr0l0w5AQCmz0lFvY52xzI4SqVOLoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpUJO1ef0XANAtaOylWFSufaz7IFy3t7BKx5hTvJqrm5TzRXwNGy9WXRK1/9f/l4uLNng1VqWjAF8hh6DB2z6/3UYRgl62aibvQq3jZ5+wBy9mGvHq0EmExv/P1+BKLv97BXNa8ArheTA5srrTTPi2vHkOYX2XMJu/C7I6a7cz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Yqr92IQH; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-783d916d039so386120185a.2
        for <linux-rdma@vger.kernel.org>; Tue, 06 Feb 2024 06:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707229942; x=1707834742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/zHFU5Yqwp5a/UOgLX2f7LwI3WOYEuRTvyafnU2czI=;
        b=Yqr92IQH9wpXbQfvGyn1mgrG2NtAkpJdlYLFngITDFlaI5n86Cec+UOQXnvH0yV+fL
         ilAOq7yMoPjO0yfLEKVY4cgpXpDzDNtPhaY/3jjL1Hzv0FCTyFJm6xpWWCd4jYsqsanq
         SlRguH7taHiIyc7KFZ3hTTiO+Sx1DmkwUtGKKHNUa9WKCwvREWzGRD4FW3RYiqGDzSNx
         lRHhALE15UOX3f0obr9SMIQVpNWXkyms+N8oZhg2lPxQ6KGgLgnQaXJRu9rrUwZmxD/U
         lUYMMmjq617a9684EWnD57II93q+0xA42GbAj5rsDB/jMz6jIWEYiD5KjROnJB1bGnF/
         6JbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707229942; x=1707834742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/zHFU5Yqwp5a/UOgLX2f7LwI3WOYEuRTvyafnU2czI=;
        b=QxRUp8LQCItgpp4mbSpMyT6QOwwRad8H+J2ZnnrszdnhjHQhOynZfJdrcjCFl1SkZJ
         sl5LNy0novFMXPGVMzKnz38vyJ2Sd/uXU6ZwguC5l+1qxHXOcIt0jiZYvhMuI0RXsMsN
         yePLt8p6YAV6YzrnDyJB/PTkqzqIvSVehh5Y0rDE/00O4MxW0Q2t3S1JaHAACvORJJ0e
         gOSgaZ2ZPM8nP/Ax8WlcX6vezpHs2Y9WiB9FevlpQv/R1NgJebEDhQ/L9y5pRX1BNtIY
         PCODQv/5syvscRiBilo0xK0ll90/seMTMpl/sRI12+SH2YaD8O68Eu6zY2UgUo+YMhY8
         fnoQ==
X-Gm-Message-State: AOJu0Ywl+HBtRQOIGeMcYpYrkAW2n/aO0Vbb261s0poknO2sI+52Uz+u
	lU4vIiA+qPPMS7GAEOFvzYDoRxmjbG3OkN5gNRA2hwQDeIrhzWyRPNanP1B0xds=
X-Google-Smtp-Source: AGHT+IE/dsBxzipS25NY8X5EUTvFKS6V+SuhB7oLUzDk327OZ6lj+v+FESY9nSA4Hjy9LOFUrrVJbQ==
X-Received: by 2002:a37:e302:0:b0:783:f7b0:375d with SMTP id y2-20020a37e302000000b00783f7b0375dmr2457777qki.70.1707229942269;
        Tue, 06 Feb 2024 06:32:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXs+jqxi3Om6fACJPExg+eF0Ql+eaj42rVQFXmt1xrrdTye4GGLTL+i81sa2lrgbial3+lIPeYg78dPIvaxHMYIFSMEGAEVMxH5b7JR/yCDbQVNPSTwioC123L4ccLNO6F6gq2dwGlrTVwTSAMWUxYDuyd7wcKmB3BAGzV92OQd90O8QzhXbAHCvMqY3/cKLU2bYxb0pjxDsgNlddiSfGuH8Qu45zi9BTdZ7s3dQYzr0jj7bI0wmvE=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id w24-20020a05620a095800b00783feb25669sm932714qkw.116.2024.02.06.06.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:32:21 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rXMUm-0028hZ-EK;
	Tue, 06 Feb 2024 10:32:20 -0400
Date: Tue, 6 Feb 2024 10:32:20 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@linux.microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 2/5] RDMA/mana_ib: Create and destroy rnic
 adapter
Message-ID: <20240206143220.GF31743@ziepe.ca>
References: <1706886397-16600-1-git-send-email-kotaranov@linux.microsoft.com>
 <1706886397-16600-3-git-send-email-kotaranov@linux.microsoft.com>
 <20240204123013.GE5400@unreal>
 <DU0PR83MB0553DF0BA184971EDD66DB0EB4402@DU0PR83MB0553.EURPRD83.prod.outlook.com>
 <20240204165152.GH5400@unreal>
 <DU0PR83MB05536AACA6D1E980AD91BD8DB4402@DU0PR83MB0553.EURPRD83.prod.outlook.com>
 <20240205075412.GA6294@unreal>
 <DU0PR83MB05531986447918EBD42EE9A8B4472@DU0PR83MB0553.EURPRD83.prod.outlook.com>
 <20240205095727.GC6294@unreal>
 <AS1PR83MB0543AE70836C1DCF1DA42F06B4462@AS1PR83MB0543.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS1PR83MB0543AE70836C1DCF1DA42F06B4462@AS1PR83MB0543.EURPRD83.prod.outlook.com>

On Tue, Feb 06, 2024 at 02:20:35PM +0000, Konstantin Taranov wrote:

> > Unless you have a good explanation why you can add new FW command to
> > configure RNIC, but can't add FW command to query if RNIC is supported. I'm
> > not keen on adopting this approach.
> 
> The main reason was backward compatibility with old firmware that had the
> aforementioned limitation. Anyway, we will try to internally retire the old firmware
> and will send the v3 patches without the "try and fail" approach (in 2-3 weeks).

I think this is the right thing to do for these cloud devices that can
reliably retire old software. It is how Amazon has been running
EFA. Get your deployment in good shape and then get patches comitted
upstream. No reason to suffer with backwards compatability forever in
the software to save a few weeks.

Jason

