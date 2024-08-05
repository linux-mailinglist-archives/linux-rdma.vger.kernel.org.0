Return-Path: <linux-rdma+bounces-4204-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE6F948031
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Aug 2024 19:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920941F236BB
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Aug 2024 17:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F6D15E5B8;
	Mon,  5 Aug 2024 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yc7/O15p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C032C684;
	Mon,  5 Aug 2024 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722878635; cv=none; b=n1TacUDXH45Bhj1uYdzuuHcQzGRuSUV4LObf5IsOj2W9b40W6o0UFFhJtu9+le3B6+yFSDvrWlr+2LnnnaeYmlmU5axKZF2h7fZgu+F1YcNwpsmng8Kya8eN0aPrTfw9VbLN33mUfhyQ4WNdRNv8IaQ/IlKCFb0dwYaMjjLxMag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722878635; c=relaxed/simple;
	bh=7hNRCBLZkQk3ywBVBEc77QdTfOxU80m/Duk6D3Qhh14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJnSI3nOdRt/g6VHZNbuuuCUzRRh614ZmkL0UwZqCM6S5I4DrIN95dzQClH+1GF9nOZ41/QaaavOEFHSIIk1HEx8Xv+6HgFYwnGEq7HPBNNyo3+mFjzPqWhuXfj+3v304ezm8UvkoiHW4yZZ6SCZI+kUVBYXd5D7JL4ZbNiXVQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yc7/O15p; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-821b8d887b8so2727546241.2;
        Mon, 05 Aug 2024 10:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722878633; x=1723483433; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7hNRCBLZkQk3ywBVBEc77QdTfOxU80m/Duk6D3Qhh14=;
        b=Yc7/O15pUbHsK0DELpDVMkyEcGFbOpPeWXh0HWVj9Q26DT54yxyqOFPDnsGlN8uzPt
         OcbqJHb8fmGVuIeXk0Ww62Vi0ZqnMcESfkyRT+a6pCmiNbIaLY631NInMsp/bXZgaOBV
         NDMbBsdLe6Y/YaHOZzq/ISG/DOJdsK5e4R/xIH99E5YaIIzNGbMQ0O59cdYJRLlmps+c
         0p+dENsoj+GpLgVuQiX7Jx/Al130phWqz9WlhN91BLs3NvLkq79DrQvo1LQXqCNpjGkU
         tvetMk3ZbiF6ye+LbCDm5uus3iBKQoq+prEZ10iGhSq3EIB+yFEqbsNsmrelr6Da4Bk2
         pqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722878633; x=1723483433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hNRCBLZkQk3ywBVBEc77QdTfOxU80m/Duk6D3Qhh14=;
        b=kDzRx9sCRHqbmcjgtHx2efgdrfzb9PgPHFKqb8kN1VUYR/B1Ixue4UP+8Vi05IF4gk
         8dZN7miCTf3SWQ4CgJOVhGi2rra6qPW2K1WDidXIpaBm7DF2xFbep0Q0Zw/d8E0V/imQ
         uVOQ3WgElVETJ0L9L/r8WoYqqGqOcbqeakCnUiuP5VG6pmAl+xz5dpqHSRZNEfGWbR+m
         CtAZZFf5JY/XaviOG62II2Zg3hwCY9+xnyEwIq4PyIGYJYoGZZeCwGw/8B5qyhZDLo6N
         iQmVZmhMPErk01H4KfS+GJmFfqmtlYecXUmnG6D2eoXn5VGptcDVKnnJDTB0y7lcYX04
         UX+g==
X-Forwarded-Encrypted: i=1; AJvYcCW4OCYWPKWu9YgyEjDrSKLGxi4nq+wMVF9ADqcQLP5Lw4yWThi/shQ636uPp9H5vHeC9ClB+4g2259oP7TZOKOlxKctl7t6B/NK2TPsgXXDS1NQ7cUCSvUHe/UxIUm6dvdlH9z7bjOwxdkG2jRuswG2P2Xm0oi+pyBGaTb01FudqA==
X-Gm-Message-State: AOJu0YxCg/TSGoAs6YTM6+te98XSni4tb2rvh1siRFHYehhLypTjlWPx
	vdb2O6wr5EZgq8AbCsS7EhXfOp9FNFioOHbu9upsFxRtj+jFlCc3R8LvlmtX5Cxv+bJtwrbEDrl
	/oMWe0277ajde6iGFi1d3zgl5OcE=
X-Google-Smtp-Source: AGHT+IG97v5P+HaGuI1kZV1qk5BoG6Y1rXq3GRd/+BCg8egfsMOWRyHK8qM2C46BAklCGORmSX2XH7yhxlNvbJsKEd8=
X-Received: by 2002:a05:6122:252a:b0:4f2:f055:b7a0 with SMTP id
 71dfb90a1353d-4f8a0046cbfmr9640483e0c.12.1722878632861; Mon, 05 Aug 2024
 10:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730183403.4176544-1-allen.lkml@gmail.com>
 <20240730183403.4176544-6-allen.lkml@gmail.com> <20240731190829.50da925d@kernel.org>
 <CAOMdWS+HJfjDpQX1yE+2O3nb1qAkQJC_GSiCjrrAJVrRB5r_rg@mail.gmail.com> <20240801175756.71753263@kernel.org>
In-Reply-To: <20240801175756.71753263@kernel.org>
From: Allen <allen.lkml@gmail.com>
Date: Mon, 5 Aug 2024 10:23:41 -0700
Message-ID: <CAOMdWSKRFXFdi4SF20LH528KcXtxD+OL=HzSh9Gzqy9HCqkUGw@mail.gmail.com>
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

> > > Could you shed some light in the cover letter or this patch why
> > > tasklet_enable() is converted to enable_and_queue_work() at
> > > the face of it those two do not appear to do the same thing?
> >
> > With the transition to workqueues, the implementation on the workqueue side is:
> >
> > tasklet_enable() -> enable_work() + queue_work()
> >
> > Ref: https://lore.kernel.org/all/20240227172852.2386358-7-tj@kernel.org/
> >
> > enable_and_queue_work() is a helper which combines the two calls.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=474a549ff4c989427a14fdab851e562c8a63fe24
> >
> > Hope this answers your question.
>
> To an extent. tj says "unconditionally scheduling the work item after
> enable_work() returns %true should work for most users."
> You need to include the explanation of the conversion not being 1:1
> in the commit message, and provide some analysis why it's fine for this
> user.


Sure, please review the explanation below and let me
know if it is clear enough:

tasklet_enable() is used to enable a tasklet, which defers
work to be executed in an interrupt context. It relies on the
tasklet mechanism for deferred execution.

enable_and_queue_work() combines enabling the work with
scheduling it on a workqueue. This approach not only enables
the work but also schedules it for execution by the workqueue
system, which is more flexible and suitable for tasks needing
process context rather than interrupt context.

enable_and_queue_work() internally calls enable_work() to enable
the work item and then uses queue_work() to add it to the workqueue.
This ensures that the work item is both enabled and explicitly
scheduled for execution within the workqueue system's context.

As mentioned, "unconditionally scheduling the work item after
enable_work() returns true should work for most users." This
ensures that the work is consistently scheduled for execution,
aligning with the typical workqueue usage pattern. Most users
expect that enabling a work item implies it will be scheduled for
execution without additional conditional logic.

Thanks,
- Allen

