Return-Path: <linux-rdma+bounces-2715-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40DF8D54B2
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 23:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0112A1C22A66
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 21:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1371F181D19;
	Thu, 30 May 2024 21:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/k8kniY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77980158DA5;
	Thu, 30 May 2024 21:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717105324; cv=none; b=nuHfUM8uzvWlAOjn6v2GyNFiZNOxvoLzsLu3tMXASUcfwUz04NM/U/9HuiCgxCGAFN20YM9ZbvGBWmafb/xAKKYsiD4Hygb8UTxicyzCZM/4c5+5hzUiPNWd+vbD261XJpJozXHEcGIMAn4SoDD0TAE5W25FOKo7/5I4BRKsBiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717105324; c=relaxed/simple;
	bh=4BlJ1CcqTMVjS1GSoLyDPsCUgH75tB5sHRSWIKqOKGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVbPkLDYpmuLxsmsFmlg4yPM3cu0h2SL1H3iSMIeUPTN9XZIL991g2rVQAM443h3z04Pm1PwItC7jvOI67edcOw7Jkdda3h/8jd5gx8WazpI3gL5nUFCeh/HXyi3s98zA5bckPMTOH5Di/QVsVIM3Ig6vbanALganra+oSZkH5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/k8kniY; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2bfb6668ad5so1093539a91.0;
        Thu, 30 May 2024 14:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717105323; x=1717710123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kcdy87Tr56c/7LWDyYDPWcrmt8uLd5ZVTSc5H3Gmpyo=;
        b=c/k8kniYqGgFW9/eGNCnUA5T6YSuQPnXNHk4KiUAXQ43GaP6K4T7E+gVlFOGPoTgB/
         E8P9oFyP5yTA/O5zZ+Ty7hDCq2DCN84EZ68975O+zqYh1+0XkjQz53fa9iM1I1rL6SFT
         Sdij+qfByXnNB1AC1sRdgqd0gBTpd+M7eDuCsaOcDMHfsVmF6RH4+s8WP8x5301VlKMR
         xsLmZ45p+OIA7Zu8Gmi3cFymaZcRfxBC08W1RgN/0mHlUaPq8z8y6YN3AQPD2UlOtRdG
         0ozRGFWu9et4wPq+2C+XrWFYy1YAlsd2kMd6ovhSzpOYFm/+7LJk+yzngN1XfDnkbSP3
         vPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717105323; x=1717710123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kcdy87Tr56c/7LWDyYDPWcrmt8uLd5ZVTSc5H3Gmpyo=;
        b=W9WppYwTRwz8Pa7IkTAwy9fpkZnkK+XIJX4RVe3BWhBxUZMRvD0NMkGWbcmauJPLMc
         U3H/vFx1MOOPa/yqzYoh1u+3GqjwcuFGraGJx8LvARTww5Y6zKWSBv7/ikUNjvQjmREM
         dpQ+NPqpOAKtiFHVlw6OTz5kJADiE9fLQKZpy7ibtPw7HxM/mlz+r8x4tphhNxCRNUGd
         rza9AqZfYKz1zsPYw0QV0GLevMf12i+yNBUffEWO2vgE3D0daAp8w7r6BC8vs8HN0wRH
         OxKc0PJpSGn00coTIqSKmMqx7pncos3PKnBrghNh/pR5a0Feg5rQsqjlaDt48cpn1Ggh
         P+3g==
X-Forwarded-Encrypted: i=1; AJvYcCUNifpRE1mBY8OBotzcPmloyvQ37zFTlrgCKpCHZDYOUfVYVk8U6MIqO+QzlD89MtHrVNRGsKBYoD67VZffmow0UX6+s8EXnmC5AhKI8LJPqbDa4bW3K5bp3Xr+QYoEA1TCZriT4xCU4A==
X-Gm-Message-State: AOJu0YzfQ+8EFJYyoTGdL+haWXqNX1tntB2NppQjpW4LbswSLh5TmASx
	DxjO8CkARRFoWQvr4aKm0DS+NXZ7dWnPZrCdNjT17Vz192V4F1cesFrXBQ==
X-Google-Smtp-Source: AGHT+IEtovH8ghzqmkQo5Djev6SblWB16GM73mSCJ0gxFHr/C8x0i5acMBO56iQteQz4uJtD+20uzA==
X-Received: by 2002:a17:90a:cf04:b0:2c1:5e90:1ea6 with SMTP id 98e67ed59e1d1-2c1abd71667mr3032626a91.49.1717105322558;
        Thu, 30 May 2024 14:42:02 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c28420e5sm223783a91.47.2024.05.30.14.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 14:42:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 30 May 2024 11:42:00 -1000
From: Tejun Heo <tj@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Zqiang <qiang.zhang1211@gmail.com>, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH -rc] workqueue: Reimplement UAF fix to avoid lockdep
 worning
Message-ID: <ZljyqODpCD0_5-YD@slm.duckdns.org>
References: <4c4f1fb769a609a61010cb6d884ab2841ef716d3.1716885172.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c4f1fb769a609a61010cb6d884ab2841ef716d3.1716885172.git.leon@kernel.org>

Hello, Leon. Sorry about the delay.

On Tue, May 28, 2024 at 11:39:58AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The commit 643445531829 ("workqueue: Fix UAF report by KASAN in
> pwq_release_workfn()") causes to the following lockdep warning.

KASAN warning?

>  [ 1818.839405] ==================================================================
>  [ 1818.840636] BUG: KASAN: slab-use-after-free in lockdep_register_key+0x707/0x810
>  [ 1818.841827] Read of size 8 at addr ffff888156864928 by task systemd-udevd/71399
...
>  [ 1818.846493] Call Trace:
>  [ 1818.846981]  <TASK>
>  [ 1818.847439]  dump_stack_lvl+0x7e/0xc0
>  [ 1818.848089]  print_report+0xc1/0x600
>  [ 1818.850978]  kasan_report+0xb9/0xf0
>  [ 1818.852381]  lockdep_register_key+0x707/0x810
>  [ 1818.855329]  alloc_workqueue+0x466/0x1800

Can you please map this to the source line?

>  [ 1818.857997]  ib_mad_init_device+0x809/0x1760 [ib_core]

...

>  [ 1818.907242] Allocated by task 1:
>  [ 1818.907819]  kasan_save_stack+0x20/0x40
>  [ 1818.908512]  kasan_save_track+0x10/0x30
>  [ 1818.909173]  __kasan_slab_alloc+0x51/0x60
>  [ 1818.909849]  kmem_cache_alloc_noprof+0x139/0x3f0
>  [ 1818.910608]  getname_flags+0x4f/0x3c0
>  [ 1818.911236]  do_sys_openat2+0xd3/0x150
>  [ 1818.911878]  __x64_sys_openat+0x11f/0x1d0
>  [ 1818.912554]  do_syscall_64+0x6d/0x140
>  [ 1818.913189]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
>  [ 1818.913996]
>  [ 1818.914359] Freed by task 1:
>  [ 1818.914897]  kasan_save_stack+0x20/0x40
>  [ 1818.915553]  kasan_save_track+0x10/0x30
>  [ 1818.916210]  kasan_save_free_info+0x37/0x50
>  [ 1818.916911]  poison_slab_object+0x10c/0x190
>  [ 1818.917606]  __kasan_slab_free+0x11/0x30
>  [ 1818.918271]  kmem_cache_free+0x12c/0x460
>  [ 1818.918939]  do_sys_openat2+0x102/0x150
>  [ 1818.919586]  __x64_sys_openat+0x11f/0x1d0
>  [ 1818.920264]  do_syscall_64+0x6d/0x140
>  [ 1818.920899]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
>  [ 1818.921699]
>  [ 1818.922059] The buggy address belongs to the object at ffff888156864400
>  [ 1818.922059]  which belongs to the cache names_cache of size 4096

This is a dcache name. I'm a bit lost on how we're hitting this.

Thanks.

-- 
tejun

