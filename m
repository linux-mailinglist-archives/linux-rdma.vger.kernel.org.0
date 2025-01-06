Return-Path: <linux-rdma+bounces-6827-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDD9A01EC5
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 06:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA113A3786
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 05:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAF5152E0C;
	Mon,  6 Jan 2025 05:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="JGhJ1CTW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD21D171D2
	for <linux-rdma@vger.kernel.org>; Mon,  6 Jan 2025 05:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736140732; cv=none; b=ilcpGzmPrPmuzjQfU/ZWPOSiThWmlDX/1KdGTGQNOhr1mhSXltc6bjAoMjbvU02m2IHkHeASK8ZnBPvNH6z0tT+OPfrsm2SHim0+EYESKJO0KYpVq6zrS9KpGpVbjbU1APKhiedTDSsBthrYRFY6C1yyjAUmL9T0io0QCSkl1Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736140732; c=relaxed/simple;
	bh=6990JYMA3xgqZWlSs/iW3KYDr7XEfmCQOOMJCgChEtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNJOGkqbHHi+J4COqnU9HoanlC9urc0EvZLGeQ8cP4kn5DoNjrBR0Z/ICG7enylhaZvbinC1eONmEQnKzbVcUNLljl3JSW+W6Cd2NAZk+isZLgsOftuD+Nzx/wcVhjoNdK4THcMxxRPn16qGpcvFef4lc75qOAd/ufWchzdtF1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=JGhJ1CTW; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3ea2a5a9fso2096307a12.2
        for <linux-rdma@vger.kernel.org>; Sun, 05 Jan 2025 21:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1736140728; x=1736745528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyMVPT/x/3fxi6e2zK/8Nz4t2kSwYLLfmLbXR0s//lM=;
        b=JGhJ1CTWqvrQpyIgLuvu7lLf4jp+uqIZ/qay8csv6FqfRU4ltK0ZxbnoKjvrGSwCmx
         Mln7u/MKHQavfE/MxdGmVjZtUMNjjBoqX9gKzsDjiV1tV4gjhgJtI9E9cdl4vFwdllFZ
         QnWByO8HAiS2wM5PiUjUbB3ccTlvjJjO34Xg1rxF7piTejH0l26fmONZiZvfKS9mZxeJ
         jeVfNujAHVxDDQ7dIBYevbPIWMSvTwtNies31CAkw+vpJr45cBqWbPVoMRpDZLulDxIa
         J+lnO+pv4Jr9kuU5enWRsejNzHAlgStC/q+heOnV22cUM1F2MHuHvEbHex3lcEerPy6U
         ovbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736140728; x=1736745528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyMVPT/x/3fxi6e2zK/8Nz4t2kSwYLLfmLbXR0s//lM=;
        b=cKI1G2TMss8xbQ/yWxKIwhc8j6McOfWT3bwUVTDUeG1Ny/dheiRKjxF+S3AUybiyrL
         eicMi/84gYtoRW52r76EtKpk/TpgU1yOpkQhDN7qZSU9n23YvO5hU+/oJkfxl17LB2bn
         F4Y+yZhXwPE+1j2GOssAxQCjyE4BvxA6PqVRuU47wiqZXTnRT508uBYI8nI0ZuA7XDKl
         89w/oG7mkoCFcKdGtou5IXtPjfNELP9heFcate4WYQz/p02fndVNgElL/YQc7TEjv1Vh
         LTn9rhK5W7oVYrSXyLuasXtPnA7jd+iuvEBCzAV7NSUwWEznbEaEhKMJ1U1ZQEoHexBO
         zp3A==
X-Gm-Message-State: AOJu0YwSe4Dt8Ekus4kGpIyObUTt7+S20I7uZm33sPy19XsfZWUDMr8D
	nWahZi+/rGtKttPx+HZ8fKsRQW4mqxe2UiR9RvT3dPT7ZD7a4HCYWYSVA8gBLoeXQ/bSk7rzdoq
	rxvt3KVvMNH4dg0HyHN1dg6NdQZL6d1zArDHa9A==
X-Gm-Gg: ASbGncuXp3JMiIXLOD2GKk4B2i+GH0g7rOk/2UH2f5KvNqw5iyJWROT94+zturC94c5
	/fUgKslmoutcBwy3I1XONbHZALz4w3o7O2Oi/GiYoEGG8vdo/7+2sMR86Dgd73R1I4bGBCv4=
X-Google-Smtp-Source: AGHT+IHKQJE0xt4NSlAZTBOlon6bKZ3HewjiplFI0c5vviTGmRAB2lPkkAwnmdQoLT5WcTalfYOjNtTxYxDqKmsac0w=
X-Received: by 2002:a05:6402:13c7:b0:5d3:ba42:e9f8 with SMTP id
 4fb4d7f45d1cf-5d81ddf80bcmr15645769a12.7.1736140728157; Sun, 05 Jan 2025
 21:18:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106004516.16611-1-lizhijian@fujitsu.com>
In-Reply-To: <20250106004516.16611-1-lizhijian@fujitsu.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Mon, 6 Jan 2025 06:18:39 +0100
Message-ID: <CAMGffEmSMpERR_3arNHCqB1qnmzRURUyOiBWkSGmJ3rTH5v5ng@mail.gmail.com>
Subject: Re: [PATCH v3] RDMA/rtrs: Add missing deinit() call
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-rdma@vger.kernel.org, haris.iqbal@ionos.com, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 1:45=E2=80=AFAM Li Zhijian <lizhijian@fujitsu.com> w=
rote:
>
> A warning is triggered when repeatedly connecting and disconnecting the
> rnbd:
>  list_add corruption. prev->next should be next (ffff88800b13e480), but w=
as ffff88801ecd1338. (prev=3Dffff88801ecd1340).
>  WARNING: CPU: 1 PID: 36562 at lib/list_debug.c:32 __list_add_valid_or_re=
port+0x7f/0xa0
>  Workqueue: ib_cm cm_work_handler [ib_cm]
>  RIP: 0010:__list_add_valid_or_report+0x7f/0xa0
>   ? __list_add_valid_or_report+0x7f/0xa0
>   ib_register_event_handler+0x65/0x93 [ib_core]
>   rtrs_srv_ib_dev_init+0x29/0x30 [rtrs_server]
>   rtrs_ib_dev_find_or_add+0x124/0x1d0 [rtrs_core]
>   __alloc_path+0x46c/0x680 [rtrs_server]
>   ? rtrs_rdma_connect+0xa6/0x2d0 [rtrs_server]
>   ? rcu_is_watching+0xd/0x40
>   ? __mutex_lock+0x312/0xcf0
>   ? get_or_create_srv+0xad/0x310 [rtrs_server]
>   ? rtrs_rdma_connect+0xa6/0x2d0 [rtrs_server]
>   rtrs_rdma_connect+0x23c/0x2d0 [rtrs_server]
>   ? __lock_release+0x1b1/0x2d0
>   cma_cm_event_handler+0x4a/0x1a0 [rdma_cm]
>   cma_ib_req_handler+0x3a0/0x7e0 [rdma_cm]
>   cm_process_work+0x28/0x1a0 [ib_cm]
>   ? _raw_spin_unlock_irq+0x2f/0x50
>   cm_req_handler+0x618/0xa60 [ib_cm]
>   cm_work_handler+0x71/0x520 [ib_cm]
>
> Commit 667db86bcbe8 ("RDMA/rtrs: Register ib event handler") introduced a
> new element .deinit but never used it at all. Fix it by invoking the
> `deinit()` to appropriately unregister the IB event handler.
>
> Cc: Jinpu Wang <jinpu.wang@ionos.com>
> Fixes: 667db86bcbe8 ("RDMA/rtrs: Register ib event handler")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Thx!
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
> V3: Move deinit behind list_del # Jinpu Wang <jinpu.wang@ionos.com>
>
> V2: update the subject 'RDMA/ulp' -> 'RDMA/rtrs'
>     update commit log
> ---
>  drivers/infiniband/ulp/rtrs/rtrs.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/=
rtrs/rtrs.c
> index 4e17d546d4cc..bf38ac6f87c4 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
> @@ -584,6 +584,9 @@ static void dev_free(struct kref *ref)
>         list_del(&dev->entry);
>         mutex_unlock(&pool->mutex);
>
> +       if (pool->ops && pool->ops->deinit)
> +               pool->ops->deinit(dev);
> +
>         ib_dealloc_pd(dev->ib_pd);
>         kfree(dev);
>  }
> --
> 2.47.0
>

