Return-Path: <linux-rdma+bounces-4226-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE236949E34
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2024 05:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BF30B23913
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2024 03:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD0915D5BB;
	Wed,  7 Aug 2024 03:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRgQXWx+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB80D2119;
	Wed,  7 Aug 2024 03:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723000569; cv=none; b=ZaldYVkeC/3KuLhbie7R7YJ9FzJRCEuZO9lBXjsD7RvjwC2sIzS00ywMHKi0R50iYqXcn++kmyXd1r5B96TGd3zFueX1jFYiJv3i4xhRhRi+RKXzqqd2XxWwy6ASSEPkCVMG4X+M+WDmoOTa4BcL8noKn448BAi7zNvIeSJRn9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723000569; c=relaxed/simple;
	bh=MVVZFAHyYiH3YNyVOjsU+QFdGF4cWfs7Y+jCi6DEun4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfvilRj+xjUZOf4Uuzyl7JIlXpBuD/lTmQbwvWG/mNLOFwaSz7QvIEVSpH5QwD/eZbKYwzPYEWcmT1bh45AIddZKPusK+kfkJn2ovsn6WbMQbyUpU/bCyeg5+zNXbLzbr21jAkJaxrhg7Nwa9IKm/5yDFDYAEA+CvWZYV40hKO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRgQXWx+; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4f89c9a1610so487827e0c.3;
        Tue, 06 Aug 2024 20:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723000562; x=1723605362; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MVVZFAHyYiH3YNyVOjsU+QFdGF4cWfs7Y+jCi6DEun4=;
        b=LRgQXWx+nvJ6P//CzZEwA2mXyPzidTnIp8aacMb9Djcel4hJEV/Y+MI8GVw1m/QytT
         /0UFx+avUUE2K50Kg28hucgGtHya3weql7+mPhPEB54Er3e6+RTxa4//h54dwZI9Oq9K
         G0yT1HltEQFWw2m6Do9IS+V7s8uBRg/9Htg8BWTYQR6bktSYtfW6d/ofO5xDpLhV/Ou3
         RXPzEopJKj+i3osGfL84p9wapnLB7gtSBtsgqRt4an6/VdNun4C488nOlWlypwj1lQ8p
         lH1h4MQJLUAQr8O0YoK8kWq1ukEayUzOaHMWDenQkORN5nMdBgJkwK6wphJBMhmu2lUr
         mo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723000562; x=1723605362;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVVZFAHyYiH3YNyVOjsU+QFdGF4cWfs7Y+jCi6DEun4=;
        b=GmUcC9RoHZzHHZ+Z7q8ySOFEYnZPRifcWxckxaUiwx4mzgp96H4yZKEFcFQPGY+nD9
         xo8abH/M5ul5sHClzhyWuGIMxKoW8l7PNSOLJTjhEmG4UnIDZhUovuD/NQNKlfNcYrs5
         dwoYivSwg8Txp7Vtyw4b9oWKfTzmghbNpfjRUWdNKzyc3OBILB4TFgeb4fS46PQdxzTw
         d15mBMEiFUvE7zz/J9gM/TxboDiXFnsIEa8bMWeqFzp5QEnPYwit4VYILV10df5UwLZc
         DeDOOq2wJN1+JwJOLYvJ6UHseTWljNBeE762G6ehc9Uv/+EGWGhpamIrXrlrZVMgBhli
         aI4A==
X-Forwarded-Encrypted: i=1; AJvYcCVvjWFqw66szxXfXjX/QeUiWLa8+4Uracq9IQM4R6NQCzWTG4LucrdUgs+K2IOFMCeXs/bk0XU7rnAidympwk5k7B3PZLy12qI2afMdK0LcQ/0X8Rnf7sp9GsfuhB0yEXRzuxY9mg+BL/Tacf7r0LeNjFZY6s9jzc+xQm1y3o1Mbw==
X-Gm-Message-State: AOJu0Yzy9zCkMlx70y79VCxB+ZuuI6i5Yp1y5ghKP3UBmwacPXkCV8jP
	In8bVzfJw8Wq4kh4m9qsZ4Zrkle2+MiDLOuB6Oln4t9Cc433PY4s40swpkA6OJ90dx1jnKJpuDn
	ldHC2A6pNK4I26S+9hrvseJcsf5o=
X-Google-Smtp-Source: AGHT+IG59tVZoDbMVzvzKSAK7l7FJc0CnktNyxiTyYpSu6vNAw//uaeeKNKHAHiW6OEseSSZkrK4J9uetrKiJZNhEyI=
X-Received: by 2002:a05:6122:3120:b0:4f6:a7f7:164d with SMTP id
 71dfb90a1353d-4f89ff4e8c4mr19665545e0c.8.1723000562417; Tue, 06 Aug 2024
 20:16:02 -0700 (PDT)
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
 <20240805123946.015b383f@kernel.org>
In-Reply-To: <20240805123946.015b383f@kernel.org>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 6 Aug 2024 20:15:50 -0700
Message-ID: <CAOMdWS+=5OVmtez1NPjHTMbYy9br8ciRy8nmsnaFguTKJQiD9g@mail.gmail.com>
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

> > Sure, please review the explanation below and let me
> > know if it is clear enough:
> >
> > tasklet_enable() is used to enable a tasklet, which defers
> > work to be executed in an interrupt context. It relies on the
> > tasklet mechanism for deferred execution.
> >
> > enable_and_queue_work() combines enabling the work with
> > scheduling it on a workqueue. This approach not only enables
> > the work but also schedules it for execution by the workqueue
> > system, which is more flexible and suitable for tasks needing
> > process context rather than interrupt context.
> >
> > enable_and_queue_work() internally calls enable_work() to enable
> > the work item and then uses queue_work() to add it to the workqueue.
> > This ensures that the work item is both enabled and explicitly
> > scheduled for execution within the workqueue system's context.
> >
> > As mentioned, "unconditionally scheduling the work item after
> > enable_work() returns true should work for most users." This
> > ensures that the work is consistently scheduled for execution,
> > aligning with the typical workqueue usage pattern. Most users
> > expect that enabling a work item implies it will be scheduled for
> > execution without additional conditional logic.
>
> This looks good for the explanation of the APIs, but you need to
> add another paragraph explaining why the conversion is correct
> for the given user. Basically whether the callback is safe to
> be called even if there's no work.

 Okay.

how about the following:

In the context of of the driver, the conversion from tasklet_enable()
to enable_and_queue_work() is correct because the callback function
associated with the work item is designed to be safe even if there
is no immediate work to process. The callback function can handle
being invoked in such situations without causing errors or undesirable
behavior. This makes the workqueue approach a suitable and safe
replacement for the current tasklet mechanism, as it provides the
necessary flexibility and ensures that the work item is properly
scheduled and executed.

Thanks,
Allen

