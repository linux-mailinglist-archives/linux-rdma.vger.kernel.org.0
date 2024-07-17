Return-Path: <linux-rdma+bounces-3897-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 617E39340D0
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2024 18:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1716028213F
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2024 16:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313EE1822CC;
	Wed, 17 Jul 2024 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiOmQdhr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBE91802AC;
	Wed, 17 Jul 2024 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235335; cv=none; b=bzoFOxY2HMKe/iYV+ZLdDwNGdN/rNgcZzO4rSKC7G2s7aAX9APP4TaJCrS//3b5BGoPdYvqv+UV6cNIzB9K+MP04IE4sUeAs8RsYsjZpqRwjxjZ3Gs9agGzu7HfStK+/oqb5zniPoUL2xSVbXADzlSktHGMX65rtdSfcPfGNTUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235335; c=relaxed/simple;
	bh=S3YZm4fFsCz8OBqnREDrrtcn3/DzYpltO81VPMK17m0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWqmyhcQzQKOUNwxZuP3XFcvRwx6joamoa5MV1hUbiQY+Lh5wRjNsxt23xuh8v7G3u9cYePPqMo0oWEwOeKwhnmzf5oz6OEY1U+75dP9u62HkOGIsFfSjsUw0TeblzlTqmuCvQPnqdloF8yDlG2sjLWY2BSU7cPVYdc4fe5Tlts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiOmQdhr; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-81061d00c0eso427863241.1;
        Wed, 17 Jul 2024 09:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721235332; x=1721840132; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5LVB3EhfKNUCqikqYOZ5hoCkrjTUi1n0+ZHXDefMGrk=;
        b=OiOmQdhr5uN7CnnWwwGdAUfNnkKK8R7ip5pbspIpXS+3MQyC8/CTk4ZSQ0QNBcHx3C
         I33N2wUX9zGOWPxHI1GGEb0EwB4EhOpAUGn072ReKvr6fHGle5tFySto6LpOds7fF54M
         4nk7TOD/skD767nOa3S6e7fOIqfnfR5oNVzdObsM6EgQ40OzWSeJ2z4jQCdheWG2und1
         datDCy38Mz5w4+dCoTRdl0LYQ/hzZ3kGgQgzVsDG5yLJDaDpacqJc3PCQ+Lya2HUayb5
         WY8/TPsY1WwtAr6jFG1yNrSPxIZpMB1WNpZPULF6f8WKDO3aOM67TnifwTXGMCpiyPMZ
         P0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721235332; x=1721840132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5LVB3EhfKNUCqikqYOZ5hoCkrjTUi1n0+ZHXDefMGrk=;
        b=ucZ7u7ZKK9VGI4+BzENXVKf7ctb9PRjDIQEIp7cm0rmdyHjnPZCSEiNF0NdC3QsGjm
         6cg/Dz5vg3JfitKANfraL4wFc7U7fguJjygW8Ck5RE8YJdCZfwgpkOMxqTdD6jSJN9e4
         eWPTUXAM9nofRpPz9XEPu1ZVINxKoaYyxQpttJa0ow82/rmt2PsYY8ZT+3Jr2rixdJRp
         f+Ah6qzrk9yEVQBfxG1f//ot3DKtPjGaU41BIMNi1F1lCr+RxJUMoWgZXwkMLbsU6v/p
         75A0XjKoyCkf7j0ex4SPFo8/15fqRi0egHswylweudfwhwwS9smSiHhkLIJp8VpY3Heu
         q1bA==
X-Forwarded-Encrypted: i=1; AJvYcCWi7QPqFoS+su15c6I/egKZuVSYkvS8pfxjn4zl7EqkOQjhD/86JBQSTlSQcbT5yzVeBak3b5rDpoe6fvJ11xamJ9+pzonOuNDDE4DmFibXVGPoNbU1WVIH1ZlHheBVMavH9zdQYzAYhc2fPDg3i6OHkMIo55KZsaIPyIPWcdeRZA==
X-Gm-Message-State: AOJu0YwkH5SifJp1AWOgQkHZL4bTjS7iDEkDJrfttbL+L/lVVwdOt9gr
	Hu0u9CCF1haWl2iqRq4mtlnPOd69VwP/mDqz8VBw7VKZdhi8hj7OYPAV8G8lkCDeeoGVQotIqok
	igfS64kP9Wvnl7uRyw0GdZltUymY=
X-Google-Smtp-Source: AGHT+IFCcnTnuk6QSJu3w6YuGurcmFhl6DCTxzWwNl1KKwaZ5buEX95b/nNoNzZ0WeorT54XRbot2nu/+27yPyecFbs=
X-Received: by 2002:a05:6102:3351:b0:48f:2404:ea7d with SMTP id
 ada2fe7eead31-49159906eeamr2685898137.13.1721235332273; Wed, 17 Jul 2024
 09:55:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621050525.3720069-1-allen.lkml@gmail.com>
 <20240621050525.3720069-14-allen.lkml@gmail.com> <ba3b8f5907c071e40be68758f2a11662008713e8.camel@redhat.com>
 <CAOMdWSKKyqaJB2Psgcy9piUv3LTDBHhbo_g404fSmqQrVSyr7Q@mail.gmail.com>
 <7348f2c9f594dd494732c481c0e35638ae064988.camel@redhat.com>
 <CAOMdWSKU_Ezk-15whDnNQKK_is2UtBOY59_4fPfKZE0-K+cB6w@mail.gmail.com> <489bff95-5b5a-447f-82c0-9d724bc9d1b1@redhat.com>
In-Reply-To: <489bff95-5b5a-447f-82c0-9d724bc9d1b1@redhat.com>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 17 Jul 2024 09:55:21 -0700
Message-ID: <CAOMdWSK2M72g_4O+ofUr3foaEc3ZGCnVFu7jZEA41NXck8Xsxw@mail.gmail.com>
Subject: Re: [PATCH 13/15] net: jme: Convert tasklet API to new bottom half
 workqueue mechanism
To: Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, Guo-Fu Tseng <cooldavid@cooldavid.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, jes@trained-monkey.org, 
	kda@linux-powerpc.org, cai.huoqing@linux.dev, dougmill@linux.ibm.com, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, 
	naveen.n.rao@linux.ibm.com, nnac123@linux.ibm.com, tlfalcon@linux.ibm.com, 
	marcin.s.wojtas@gmail.com, mlindner@marvell.com, stephen@networkplumber.org, 
	nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, 
	lorenzo@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, borisp@nvidia.com, 
	bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com, 
	louis.peens@corigine.com, richardcochran@gmail.com, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acenic@sunsite.dk, linux-net-drivers@amd.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Thank you very much. Will send out v3 later today with these changes.
> > Note, it will be as follows, enable_work() does not have workqueue type.
> >
> > +  if (jme->rxempty_bh_work_queued)
> > +                 enable_and_queue_work(system_bh_wq, &jme->rxempty_bh_work);
> > +         else
> > -                 enable_work(system_bh_wq, &jme->rxempty_bh_work);
> > +                enable_work(&jme->rxempty_bh_work);
>
> Yup, sorry I was very hasty.
>
> More important topic: net-next is currently closed for the merge window,
> You will have to wait to post the new revision of this series until we
> re-open net-next in ~2w.
>

Noted. And Thank you for the heads up.
Meanwhile, I will prepare the second series which can go out for review in
two weeks.

Thanks.


       - Allen

