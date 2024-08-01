Return-Path: <linux-rdma+bounces-4175-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDFB945462
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 00:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8E81F244EA
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 22:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C973514B956;
	Thu,  1 Aug 2024 22:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVygmp6P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C86514AA9;
	Thu,  1 Aug 2024 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722549637; cv=none; b=mpCmuH0BELqrE1gEfQ/yO6CW37nN2k9Ry3SCzkQ3ZN68J+N3YSlK4079LSOWGNCstnNbGZabZ917Rjc/qgZFSVPzPuqr/Cz4vk/GKtGQPitDRatOPn5WePnYnn1YeLWvsPz/VLLX3+s9kqlVKOlnd9B7PGEJhJWA0tQ6LUXiJhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722549637; c=relaxed/simple;
	bh=gy/0hIaEYlhTd4SsHH7PfHqlKSt6muztx/YGqn+EcXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBSTBQyobw24+2Dcr1JDFFc4Ez+Bd4VbbNE7XSMop2WJPDnzy3BHlq+3ia7+tNC95Dh0es82hl0VzpnmDJHXfVTH7t+36TM6FwQ0eahN4ySeASacs+1nrLbVlVgqoftJIU4nAJ0jgRK1jLIRLS4evfGjHJ/GypJV4crmxhXFe3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVygmp6P; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4f51551695cso2669523e0c.3;
        Thu, 01 Aug 2024 15:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722549635; x=1723154435; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lMQFOBzX0l/sRNFyFYKbSnj7CF43keIwzBut/4zy+Bs=;
        b=gVygmp6Pl81AGoHUUtDh91g+NKOgms14+VvESMMiwrU9nWJZ3LPHCTQIH0xoMTho0Y
         FXR9Ze0b+JBQTDKSzXObd/QGAo+PMgP7A39WzdFtHlg9iLl+b26aoKaetXgJzJRnZvT3
         PSlJvxDIg6DPiAIuVwKW/f4Hz5EuLouqvgK5Hqc+W8XIsZmxpDLSxTCasqxD7IGwlms1
         ODNMDZ5XsiKng22YTiiF8PGeAQiYwKOEvvEsamBvJ8+9SCzI1/6v6284mtT/itVn/nk7
         InZTfR+5C3fsN8Xe4FUO4o9aL1XNjNB+hJSKkl0T4eb+z7K73t6Th1OdkLziWBWOcajN
         6GDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722549635; x=1723154435;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMQFOBzX0l/sRNFyFYKbSnj7CF43keIwzBut/4zy+Bs=;
        b=jSyPkE9ZUTyWRIqhAb7Lf680xYKTrSWm7IKs+zczqb2b2/2xqVuJ5LzhHJ5n4nYAGj
         2Pzkj+3uOF2M/L+A4hwmTEVTWbO7NCpmiDGwJKt4kU+PPzri7VcLHoIJjvqZjPIj/Knx
         f+kEThbmlwnt8sKi0qy3yZG3N8bYMY8Za7PfzSpUN5fwTiixCnt3TQBWJM1AbPNdnRJ7
         wnd4trhk9m1B9rs8I+hz2gp9XVFN1XP3R933xAzGpcNlmqjut0i2E6UySVu3l1bJW9g+
         BlxYiQfBfF2Gkowh9KWT2ITX921FuQH2HXv+MeidddKODh+snXUTM4ShqAeqSW5lbyKb
         95Ug==
X-Forwarded-Encrypted: i=1; AJvYcCV+e2H3oQAt3DzEff+nZj39JggcENMR9Y8iM3cCQyOpjHD5Qv4Hcb4e9urm3EJxxBVsG94KRZWd+QgxcYmJXhbu7LdL1BIoWabllhu4kx87jTkZb/fcOMcPUGmZM//ZIAC7xoFFt2oRRJu3MwMQH35ROxxaF1KeJBQclfUXFxzRMg==
X-Gm-Message-State: AOJu0YxeODaBfb3KIeizRzk2B8epxDO1gU5iN+ZM7VYHeLs1I89uW9f/
	8f8V0H9NxKdcr2//mq5QaHdWk9pLR0RNJaXGsZn2y+F94MjE8bqfQswTvfL1lBdtVLCNIjJkMbs
	PJPZQHv/rydTfZUT1vDSWBaZNE2U=
X-Google-Smtp-Source: AGHT+IEL93DbcefX/c9OxuxETJKmvwmdOhM++UxGZw+iIajCdCSfGAVN7xSJzVrcKPgcYdQJtbmpQrXcyC4MoB3SpsE=
X-Received: by 2002:a05:6122:1e03:b0:4ec:f8b1:a34b with SMTP id
 71dfb90a1353d-4f89ff93371mr2016277e0c.8.1722549634892; Thu, 01 Aug 2024
 15:00:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730183403.4176544-1-allen.lkml@gmail.com>
 <20240730183403.4176544-6-allen.lkml@gmail.com> <20240731190829.50da925d@kernel.org>
In-Reply-To: <20240731190829.50da925d@kernel.org>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 1 Aug 2024 15:00:23 -0700
Message-ID: <CAOMdWS+HJfjDpQX1yE+2O3nb1qAkQJC_GSiCjrrAJVrRB5r_rg@mail.gmail.com>
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

Jakub,

> > -     tasklet_enable(&oct_priv->droq_tasklet);
> > +     enable_and_queue_work(system_bh_wq, &oct_priv->droq_bh_work);
> >
> >       if (atomic_read(&lio->ifstate) & LIO_IFSTATE_REGISTERED)
> >               unregister_netdev(netdev);
>
> >               if (OCTEON_CN23XX_PF(oct))
> >                       oct->droq[0]->ops.poll_mode = 0;
> >
> > -             tasklet_enable(&oct_priv->droq_tasklet);
> > +             enable_and_queue_work(system_bh_wq, &oct_priv->droq_bh_work);
>
> Could you shed some light in the cover letter or this patch why
> tasklet_enable() is converted to enable_and_queue_work() at
> the face of it those two do not appear to do the same thing?

With the transition to workqueues, the implementation on the workqueue side is:

tasklet_enable() -> enable_work() + queue_work()

Ref: https://lore.kernel.org/all/20240227172852.2386358-7-tj@kernel.org/

enable_and_queue_work() is a helper which combines the two calls.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=474a549ff4c989427a14fdab851e562c8a63fe24

Hope this answers your question.

Thanks,
Allen

>
> I'll apply patches 1-4 already.

