Return-Path: <linux-rdma+bounces-4258-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F7D94C893
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 04:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E3FC28512A
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 02:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECE8175AB;
	Fri,  9 Aug 2024 02:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jL+2cNP+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F62717555;
	Fri,  9 Aug 2024 02:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723170731; cv=none; b=ISInflwq+3597maUGvt6Xs4jSGZmB5ci/iwJRZE5V510zQIqVZDTHs6vqnavmvmFKYGybIoXwtqxnLXoEJhhU007XEiKrBCrInyZLtK0lrvhQEAMnpoUx7qqwoGgcec7Lo/EIVvJ/CFYxnoOqWEpkvl9RWCT6AvPBtAKtZnRe+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723170731; c=relaxed/simple;
	bh=IhapfpGzq0jlEDlPaaTbUuZZUGL58XBwh5zYwfHrgpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvBApc0Y9lBG1Wym+tmZMPRFynNJ4fiNClGVA6Q/hS+Tcqp8Bo29E/Slsbrl9tjRDHl4lOx4DFfPpNyoBUR9HnPXG3WyckVqGNYRSDulAdj/9NQx6XmkVAFuVGPegkNqQKDMhDeqx6TTvSJkj2SnxDPqforvi3uW6pQRMc0pV2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jL+2cNP+; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-831a5b7d250so550204241.3;
        Thu, 08 Aug 2024 19:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723170729; x=1723775529; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IhapfpGzq0jlEDlPaaTbUuZZUGL58XBwh5zYwfHrgpk=;
        b=jL+2cNP+Gp6pgFfUj5x5tp+HtnCG4R/SNMhLOLaSVAbOvFQAwSVviLvg3Fjsm8h7dT
         Hc2E3okozzY8RQ/7st4gcoPe6ojggmOhiXblZuafyRzsgwiWvRacCple4jYviahGB0W7
         pitSpOAq+EIMqEsWbHLm80WRO1C9w3covUodpZvt3+KmkNIPiKAfC9V2LsGNhWmoi3Ya
         ElKobY+vP/z0Mzi437ycJmoI6iMyWfLp/E8On7ZeiJQZ4TDafE09TGpxkbgj332NKEnr
         C5c3WrrVHeyfq+hVW6aOckh+j6tY2VFT8k5n40XgirxUCTz1/Btj1pGRf2Dsv5m1U0kq
         Gz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723170729; x=1723775529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IhapfpGzq0jlEDlPaaTbUuZZUGL58XBwh5zYwfHrgpk=;
        b=gzarmUE9S4vnCMQkOpczlHbh1JIt3XBiXN3jzzI7O7l4KJWTVIIf7ld1dgkBqOdm7i
         KmDWFABPKl8Nd4RYBnP1HMTohVMRcFcRQjHyhh2S9MYmYgM4tXJ5PS/QESZZYjIHINzD
         yv/xxAKafRt/idj3dHu9RbVe0frviEi8xdvfLujgj0tA2aodqfg6sy5uTOA991vwN6Fq
         CpkoDI6h1cNrg8+S70wkYW0A23dJaV6wc1JjtHXQb62gYh0FUaYDbFzIGHOAByhaANdk
         Gt246UEUVLvs7qjzi/sMhekZAwbwZd3NNheu+Kb+hZKU5Z6Nh7WUO58+jC+AwhF5avvS
         wljA==
X-Forwarded-Encrypted: i=1; AJvYcCXYlRctq4F5+IpaMIKl7zC8w9X55cGZTTQPTnOmez6FhfYALZQ+CuhVRpo8tCJm/PLl35T2JhJl8Dd5EuAN4eN31+3LKhLYPT8YKQV2pjtlHklXNGwfd+zcZYRTNXxwjgVG47MmB7EZHO7ppGjMOc/QqAZ+DvS1sw8ul9aKRRjkTg==
X-Gm-Message-State: AOJu0YznpbMxtRfnQB3TVLB7f8CWM6ZQSmE+h6R9iNZaBP2EQey0yFvC
	G+DHovdJT+4x8RbbIWIRqDTNjO0UD/eqI5ktRmo86uQWonL2f36BW5eMTFpDI0vbYOOAgj1DZjg
	EVH916LrgXKLMy7+sZ3VVAp7NRp0=
X-Google-Smtp-Source: AGHT+IH3CNXvZk/tZl9cCVHk538ARL3YcVk0YVchod7k94UdfhdVSxGqRlcaoZq2ScWRIeIB6wKVjsE0r1m8fKyEZaw=
X-Received: by 2002:a05:6102:32c6:b0:493:2177:981b with SMTP id
 ada2fe7eead31-495d851473amr156803137.17.1723170728624; Thu, 08 Aug 2024
 19:32:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730183403.4176544-1-allen.lkml@gmail.com>
 <20240730183403.4176544-6-allen.lkml@gmail.com> <20240731190829.50da925d@kernel.org>
 <CAOMdWS+HJfjDpQX1yE+2O3nb1qAkQJC_GSiCjrrAJVrRB5r_rg@mail.gmail.com>
 <20240801175756.71753263@kernel.org> <CAOMdWSKRFXFdi4SF20LH528KcXtxD+OL=HzSh9Gzqy9HCqkUGw@mail.gmail.com>
 <20240805123946.015b383f@kernel.org> <CAOMdWS+=5OVmtez1NPjHTMbYy9br8ciRy8nmsnaFguTKJQiD9g@mail.gmail.com>
 <20240807073752.01bce1d2@kernel.org>
In-Reply-To: <20240807073752.01bce1d2@kernel.org>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 8 Aug 2024 19:31:57 -0700
Message-ID: <CAOMdWSJF3L+bj-f5yz5BULTHR1rsCV-rr_MK0bobpKgRwuM9kA@mail.gmail.com>
Subject: Re: [net-next v3 05/15] net: cavium/liquidio: Convert tasklet API to
 new bottom half workqueue mechanism
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, jes@trained-monkey.org, kda@linux-powerpc.org, 
	cai.huoqing@linux.dev, dougmill@linux.ibm.com, npiggin@gmail.com, 
	christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, 
	naveen.n.rao@linux.ibm.com, nnac123@linux.ibm.com, tlfalcon@linux.ibm.com, 
	cooldavid@cooldavid.org, marcin.s.wojtas@gmail.com, mlindner@marvell.com, 
	stephen@networkplumber.org, nbd@nbd.name, sean.wang@mediatek.com, 
	Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, borisp@nvidia.com, 
	bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com, 
	louis.peens@corigine.com, richardcochran@gmail.com, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acenic@sunsite.dk, linux-net-drivers@amd.com, netdev@vger.kernel.org, 
	Sunil Goutham <sgoutham@marvell.com>
Content-Type: text/plain; charset="UTF-8"

> > In the context of of the driver, the conversion from tasklet_enable()
> > to enable_and_queue_work() is correct because the callback function
> > associated with the work item is designed to be safe even if there
> > is no immediate work to process. The callback function can handle
> > being invoked in such situations without causing errors or undesirable
> > behavior. This makes the workqueue approach a suitable and safe
> > replacement for the current tasklet mechanism, as it provides the
> > necessary flexibility and ensures that the work item is properly
> > scheduled and executed.
>
> Fewer words, clearer indication that you read the code would be better
> for the reviewer. Like actually call out what in the code makes it safe.
>
Okay.
> Just to be clear -- conversions to enable_and_queue_work() will require
> manual inspection in every case.

Attempting again.

The enable_and_queue_work() only schedules work if it is not already
enabled, similar to how tasklet_enable() would only allow a tasklet to run
if it had been previously scheduled.

In the current driver, where we are attempting conversion, enable_work()
checks whether the work is already enabled and only enables it if it
was disabled. If no new work is queued, queue_work() won't be called.
Hence, the callback is safe even if there's no work.

Thanks,
- Allen

