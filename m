Return-Path: <linux-rdma+bounces-5281-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACC79934E2
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 19:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91441F25D4B
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 17:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545CE1DD871;
	Mon,  7 Oct 2024 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BwJqjvRz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782781DD55F
	for <linux-rdma@vger.kernel.org>; Mon,  7 Oct 2024 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321905; cv=none; b=JzMuEviaM2yU4LvXG0mMBlx4rucTxjNDs9VtqhckptJ8RTWaJUjUcIKbxMBtfDTIgXA6+YVffx0t3l3OfrnNt1TjN8z1dKx7satt/vcD4zzMNdRvZnRDE/1ZDM+rD7yH78ZVYz9iSKvg8lsTqPcjUy82tR25uMHbhdLBGDTjpl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321905; c=relaxed/simple;
	bh=1/7sb4L013jDAAikYnXrFI6XHOPJj4cPj8B9qnNztFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YkwLLD/yahPNBSR2hJzEkdt2u7QYsN4nssA0BnP4mfffBBJt24er1brCfNVVkDi3gfhCBtN9oFhoh/qRm7JfMjsQ5gISZRtMjhbXj5Bkdji1HZdohWNaCikPm84FSP+H5XPQtO2ahcYY10UAxFZFX0Ulyl181hkCUbW4LXj+LaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BwJqjvRz; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-82d24e18dfcso189384939f.3
        for <linux-rdma@vger.kernel.org>; Mon, 07 Oct 2024 10:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728321902; x=1728926702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cDdjFXnqmzo2D0DMdD34d22tTx1BzoX1VwMsigXz9oA=;
        b=BwJqjvRzFR1laLjjVMwjjOphH10LIdrPsOfmNvXCPsnJjfG2mWBc/n5zw1Ljb9JFqz
         UziNOhml7Dig1yB88LEFrx7WitHV1Gc1V8E6AQqq3qw7Ce90cYWbbPEc7eXscdutEn6H
         +Fq3dKEPLwQ3Ss3EPyFKNpm2uwlZiOQrlZCuOIXRrbgYxGLFLPt8AXmMAJuKkTGGfkuK
         83muVKMGkDKNl7Y6+CAWX30giOTTMZEP3s1BBk0aaSShjOUv6dCeL95+834dmdJ+UAK1
         V5Ih2aZE+o6Pq91CdRfd0Rvx63xrX9EghM1es8b15fiuh8aQRds47VVvuQqDddoPKUr1
         IUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728321902; x=1728926702;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDdjFXnqmzo2D0DMdD34d22tTx1BzoX1VwMsigXz9oA=;
        b=Bv7Ezr5QCoY+PUgM2SuJeTmmEb5oj53tZUwBOLf9EmVWCwQ0LAsgT8IP9O2XK0gb94
         e938oh86xhQZgh4+HoP1KqLh9K0Z0cxQ66/SNc/fj+m+dENyt6UJXE3nlAL0g/5Ea8gT
         fh127tI6kIZEVdYDf+OOV94htkZ43cClGJbpQnFxkPqgGCYd91PvJ+RpnIibYVf7Rz4o
         40A+HrpbjWoWj6fSk7bJ5XceP6OnhikvsY/E62Ls61NEadp5c0BBymy1QqxkNKpX4IRn
         vhWyot5cjxcjynwOUHTEVH1L1xPAQcLCHOSDoEUwCtcJanit3L4LBFZ0iX3wS5s6niki
         89Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWvs6itDUb8ksbxK0zDlZVCCRWpQvGn21NT/OzFwV32caI/nSdM2DKJusFB5PKAvjeq2AybmiRdKQRm@vger.kernel.org
X-Gm-Message-State: AOJu0YxsEnoFefNXdrin1YlfLACFwpPklRqymz+eTWeFxMOOJF+frfmG
	tVevKLO6R8HEfwM/5rsoN9VwYyng8f7I6JYnzOpt95Z1SZ/UFd+MfYr42oQSrOs=
X-Google-Smtp-Source: AGHT+IGWfL6HTIq4hx4Xl9HY/v7hmc4gwRkJVnaJ9iEtS1GjCpScQx9VZE12aSSpuwRj5pyXh82SWw==
X-Received: by 2002:a05:6602:48c:b0:82d:2a45:79f6 with SMTP id ca18e2360f4ac-834f7d65548mr1332217339f.11.1728321902609;
        Mon, 07 Oct 2024 10:25:02 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83503b2fc8csm132792039f.48.2024.10.07.10.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 10:25:02 -0700 (PDT)
Message-ID: <5878e794-a5b3-4a76-ba1e-5ab678dac86b@kernel.dk>
Date: Mon, 7 Oct 2024 11:25:01 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/srpt: Make slab cache names unique
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Zhu Yanjun <yanjun.zhu@linux.dev>,
 Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20241004173730.1932859-1-bvanassche@acm.org>
 <3108a1da-3eb3-4b9d-8063-eab25c7c2f29@linux.dev>
 <e9778971-9041-4383-8633-c3c8b137e92e@kernel.dk>
 <09ffcd22-8853-4bb3-8471-ef620303174b@acm.org>
 <09aa620c-b44b-41d2-a207-d2cc477fdad2@kernel.dk>
 <04daaf4c-9c62-404e-8c5e-1fffb3f2ecbd@acm.org>
 <d6df2c28-467d-458e-9b53-4cb7abcf682f@kernel.dk>
 <20241007172253.GB1365916@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241007172253.GB1365916@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/24 11:22 AM, Jason Gunthorpe wrote:
> On Mon, Oct 07, 2024 at 11:20:56AM -0600, Jens Axboe wrote:
> 
>> stand by my comment that using ida for this is overengineering. And that
>> yes there are 3 slab caches, but having 3 per whatever instance is silly
>> and you should share those 3 across instances. 
> 
> Store the slab cache in an xarray indexed by the variable size and
> name them according to their size?

That's a way better idea.

-- 
Jens Axboe


