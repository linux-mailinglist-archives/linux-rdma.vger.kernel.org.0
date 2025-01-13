Return-Path: <linux-rdma+bounces-6977-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDD2A0B825
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jan 2025 14:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E08E3A8DC1
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jan 2025 13:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898F32E3EB;
	Mon, 13 Jan 2025 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqV7gVVR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88075235BE4
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jan 2025 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736774916; cv=none; b=mntN2apYSuJ1xDxNt6u0sX1Rd8vkAOgUeVbmkWAt2jNJXL2XMCryASdF5s96Ab6/O/s5rbpOqh0eh+H8nNH+9xSs/8n7VIHczl3Ypkc/tFAY0G+QX9OUklVDFMpOvJCbauEtjFCf+M7HvIjru6bLWHwllEqP8nbcGGOia7PJrEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736774916; c=relaxed/simple;
	bh=HIgImMbDhACPRe1mOQl+JeqFaqogIdy30gBFdJ1pIG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QhmDI2RE2xFEniSj0Pn7mn5i6XTAhGxGsTgqqSYA0IHCLk2dP0xOX/AUBBFEBi+jar4zwS1acTwsoZijoIN2rMClhlIkdAaRy00CBZlmvsMF7D9WJq3QHGIlbd45SLy3LOl7TKCvSeYBm8j0O7gk3TineOt30xu4ERpyyKX3Rbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqV7gVVR; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-5401e6efffcso4485435e87.3
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jan 2025 05:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736774913; x=1737379713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArWOI3Sb/lJNbnHcvWGAzVHLDAa+9S2mWdTg+ezLi5o=;
        b=MqV7gVVR1in4dO5+TNleZ9XC9IjljxQnCZbqPWSrNi5YfgwjWxNejYm2yfsT4HAt2a
         23cTxqHeZ+Zc3n4M/zkOakdJrCYVjfCtDQTvLUznDFHyMvVhNE6j3FfRXQ9xQtXbC/s+
         8qPcByDk6RcBMNAzaUUEK1B+JI0Xd2mu08HCkLo8Bist8XbQa9lnliyzixuaOOUfiyRP
         OXaykDVBEjMUQPExgoCT7iZZb7NboiYKTl5rhjufGUkm3lhZoqhHERchsrIYuo+wju0s
         Peds/HwlXFyqG0xQjdCjpNS2piatyrq1XKfbmVxXUKaRZliYDdBvTuq6dSXrpo8HKTv6
         VLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736774913; x=1737379713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArWOI3Sb/lJNbnHcvWGAzVHLDAa+9S2mWdTg+ezLi5o=;
        b=idHVEmXoUEhMCaOhuZnqrI43V/LsIl1mragFEkMvTkqtMPr79Xcja/7Ypwu6qx/CZe
         T/G2iVitFQIi3k1pjsmMHxNUgFfcrE8rC2ZTpHCazaC+tRNeUQQHAGgftWYOUON1wvDC
         pyv4bdBKsY2fm/QRA0TDIYbGlWNzd7IB6DtHGKW/WxRiXenxXIiuLLFmrh0Jw12a7yHg
         1dRe7Nla7znt67g369sF66x1ITkdUveIpkx8MsbpjDytVxss2MvpGJ4U9D+Of4TDzkuE
         Mx0nXkXBfhRbq3vo7ZlcTWI94XWmMNPMnA1zvmt5eyPDa3dimjl+0AVb+Zq1HyJWI6+a
         25zw==
X-Forwarded-Encrypted: i=1; AJvYcCWCqQBhQXoXnmlOKxnQjstPy/XRNA5StCg+ZgyPVBi+d+SpbvgLFkA0oqEYgGcboMC8mJG92jUnCbc2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Hwsm0E2ZexwzgrftSjpvgR4NK3tCAEu/WnlcCp3dtfQwPKWf
	Z6D2Rm4RaYlUoruIneoEmTgmvsJEdJbFbds9PKKZY+g+mvnjjPneoU7c3ZLERpaawjkCOWFJheb
	8uKcub2pBIr5nDCG5CK3tXJt+TmI=
X-Gm-Gg: ASbGnct1w4qtT34loMnhsKfG9sJ7IcC9I8tG1CCSPFhCM761rpBcw2o721XyjzEP3iP
	SU/AUAGccv9B4yhHMSApxDFNQL07Zk69MQ/Z6iQ==
X-Google-Smtp-Source: AGHT+IG7ORWo3o8kmowm+P5aLy00UU5xn/STKdhI1uP0kEF3M9zPnA7l+3UL4hH7KA2IL97Bsect317CvN+V4Tzv7sY=
X-Received: by 2002:a05:6512:a8d:b0:540:3550:b0f1 with SMTP id
 2adb3069b0e04-542845b1a48mr6066374e87.7.1736774912321; Mon, 13 Jan 2025
 05:28:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110160927.55014-1-yanjun.zhu@linux.dev>
In-Reply-To: <20250110160927.55014-1-yanjun.zhu@linux.dev>
From: Joe Klein <joe.klein812@gmail.com>
Date: Mon, 13 Jan 2025 14:28:18 +0100
X-Gm-Features: AbW1kvbn8S7Uap28XqDlvrvizB_oM4cIpCgir6K3m0GWq6O1lxhIPB6r7XP3fmM
Message-ID: <CAHjRaAeCAUw3WGjKxvFqT_5XCTut-LbnrTKgPpLshn1jmH50Pg@mail.gmail.com>
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix the warning "__rxe_cleanup+0x12c/0x170 [rdma_rxe]"
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 5:09=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
>
> The Call Trace is as below:
> "
>   <TASK>
>   ? show_regs.cold+0x1a/0x1f
>   ? __rxe_cleanup+0x12c/0x170 [rdma_rxe]
>   ? __warn+0x84/0xd0
>   ? __rxe_cleanup+0x12c/0x170 [rdma_rxe]
>   ? report_bug+0x105/0x180
>   ? handle_bug+0x46/0x80
>   ? exc_invalid_op+0x19/0x70
>   ? asm_exc_invalid_op+0x1b/0x20
>   ? __rxe_cleanup+0x12c/0x170 [rdma_rxe]
>   ? __rxe_cleanup+0x124/0x170 [rdma_rxe]
>   rxe_destroy_qp.cold+0x24/0x29 [rdma_rxe]
>   ib_destroy_qp_user+0x118/0x190 [ib_core]
>   rdma_destroy_qp.cold+0x43/0x5e [rdma_cm]
>   rtrs_cq_qp_destroy.cold+0x1d/0x2b [rtrs_core]
>   rtrs_srv_close_work.cold+0x1b/0x31 [rtrs_server]
>   process_one_work+0x21d/0x3f0
>   worker_thread+0x4a/0x3c0
>   ? process_one_work+0x3f0/0x3f0
>   kthread+0xf0/0x120
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork+0x22/0x30
>   </TASK>
> "
> When too many rdma resources are allocated, rxe needs more time to
> handle these rdma resources. Sometimes with the current timeout, rxe
> can not release the rdma resources correctly.
>
> Compared with other rdma drivers, a bigger timeout is used.
>
> Fixes: 215d0a755e1b ("RDMA/rxe: Stop lookup of partially built objects")
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>

We tested this patch. All the tests can pass with this patch.

Tested-by: Joe Klein <joe.klein812@gmail.com>

> ---
>  drivers/infiniband/sw/rxe/rxe_pool.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw=
/rxe/rxe_pool.c
> index 67567d62195e..d9cb682fd71f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -178,7 +178,6 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sl=
eepable)
>  {
>         struct rxe_pool *pool =3D elem->pool;
>         struct xarray *xa =3D &pool->xa;
> -       static int timeout =3D RXE_POOL_TIMEOUT;
>         int ret, err =3D 0;
>         void *xa_ret;
>
> @@ -202,19 +201,19 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool =
sleepable)
>          * return to rdma-core
>          */
>         if (sleepable) {
> -               if (!completion_done(&elem->complete) && timeout) {
> +               if (!completion_done(&elem->complete)) {
>                         ret =3D wait_for_completion_timeout(&elem->comple=
te,
> -                                       timeout);
> +                                       msecs_to_jiffies(50000));
>
>                         /* Shouldn't happen. There are still references t=
o
>                          * the object but, rather than deadlock, free the
>                          * object or pass back to rdma-core.
>                          */
>                         if (WARN_ON(!ret))
> -                               err =3D -EINVAL;
> +                               err =3D -ETIMEDOUT;
>                 }
>         } else {
> -               unsigned long until =3D jiffies + timeout;
> +               unsigned long until =3D jiffies + RXE_POOL_TIMEOUT;
>
>                 /* AH objects are unique in that the destroy_ah verb
>                  * can be called in atomic context. This delay
> @@ -226,7 +225,7 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sl=
eepable)
>                         mdelay(1);
>
>                 if (WARN_ON(!completion_done(&elem->complete)))
> -                       err =3D -EINVAL;
> +                       err =3D -ETIMEDOUT;
>         }
>
>         if (pool->cleanup)
> --
> 2.34.1
>
>

