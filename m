Return-Path: <linux-rdma+bounces-858-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E89845A91
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Feb 2024 15:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6832A1C2812D
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Feb 2024 14:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3B05F49A;
	Thu,  1 Feb 2024 14:48:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1B85F467;
	Thu,  1 Feb 2024 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798918; cv=none; b=nSDXSR30CpeYFapxcWrihb91mcYk8AbH/NDLVbeBdBRKJgB90o6bY1SlwmiflKmmvmiXh4+/bmQCK/SP3mF5VTXDmelO7nSxD48pgZ/Y3PqltCeYSjT4aBMLMc47ZaVEKULLyxlz0AL1GvIHNUUaR9LTwCLy5236Tvm8ASyfmZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798918; c=relaxed/simple;
	bh=kgzPQEYyZvtgptsyAcimKMFdgkPe5hWQr95Fm9WJLqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VpvZ+Pw8zNJ1bu7FRnze3IkaEt90CcPcEiqTkXbAe3CyHA5xCmzbrmDT0X5KKJ8rNHaAZqbVSI/MOCNHzE9Z4vLvW5JH5SQd0Yru2o91bMTVdl7XUq+HBE0v79HGUgSGBx0bleWMOsrfoab2uBa+Mklm4RutdisZJ2jP1DG/qgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce2aada130so882335a12.1;
        Thu, 01 Feb 2024 06:48:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706798916; x=1707403716;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZLfNNOA3fPwT/lACRUCWcunwYFYKzsJvZnIb6KlJOQ=;
        b=OWWmtzt/3eewEiv0AE8XJRPm5CsMJGwtQikJZ2soMHf3XIN+GGt3kfeFN5593qECnD
         NitNkv7woSFfEPaJuZTkLPfUUUcvjE09719T9K/IsqE6eAhEH96u94TbxOeYtClQvKOt
         fflHMzG/8BOnDK/9yxDDgReLxbiXmRll7J8SoYsIpfwjqgE6SmDObN1/gQLR9jVe01zE
         UV3M57IWkdEx2BD6cU09IooK8e78KCc8eUEKKL2jPebXOofYjukOycrJGQb59L4poQDT
         l19rzsuxObkf5UuuL7HNr8ijWjD4Zdw84mTomSUdb+e4KHx/HiJQireA4SNOYtO1nrC3
         hCYQ==
X-Gm-Message-State: AOJu0Yw8/IUxNoLOxz3Y3ksf4Fo6URzrDRyQXa7FIRL1zy7ShxitjaHY
	6HNILn0ZCoyTGP1AZ2+JVgg4ZgvNmzOoHH76L4IEvdW+xa4z+slo8RUrk3sL
X-Google-Smtp-Source: AGHT+IHoazbl4mQQ5JGphXQxeDJXPZMugdFyz2WvWnZ5ZmUmWofiwtqkgnur7TqmRPt0yDYYM1GTIg==
X-Received: by 2002:a05:6a20:1806:b0:19c:7c49:4e6 with SMTP id bk6-20020a056a20180600b0019c7c4904e6mr4181309pzb.51.1706798916373;
        Thu, 01 Feb 2024 06:48:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX2iMVs77hndj2YXUNkEHyliv8W6tg6f5u+doDL5txl1MIYC567kmm1fHMos076AH97tK/xHMOLaL9kMZ1GYFw96oGD0Zw1Kpi10sRHzlXX5xx71I6jQ8ydpFymPC+Za0ffjJXy6qk9QVXJEVMGFXHdoADnxw0NdGJosImOXYLpjigt9rnr4LUaXBe8tybjBTmBWJaKKWqOEdIjPeVl3lU3b8llhUk=
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id y12-20020aa7854c000000b006ddc7ed6edfsm11914573pfn.51.2024.02.01.06.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 06:48:36 -0800 (PST)
Message-ID: <894db19d-5287-4ed8-a0d9-0211b365eafa@acm.org>
Date: Thu, 1 Feb 2024 06:48:34 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] RDMA/srpt: Do not register event handler until srpt
 device is fully setup
Content-Language: en-US
To: William Kucharski <william.kucharski@oracle.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240131062438.869370-1-william.kucharski@oracle.com>
 <20240131062438.869370-2-william.kucharski@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240131062438.869370-2-william.kucharski@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/24 22:24, William Kucharski wrote:
> Upon rare occasions, KASAN reports a use-after-free Write
> in srpt_refresh_port().
> 
> This seems to be because an event handler is registered before the
> srpt device is fully setup and a race condition upon error may leave a
> partially setup event handler in place.
> 
> Instead, only register the event handler after srpt device initialization
> is complete.

A Fixes: tag is missing. Otherwise this patch looks good to me. Hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

