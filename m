Return-Path: <linux-rdma+bounces-6796-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50007A00D27
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2025 18:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290813A2D66
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2025 17:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679E31FAC53;
	Fri,  3 Jan 2025 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="eubpLLm3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7141FC11D
	for <linux-rdma@vger.kernel.org>; Fri,  3 Jan 2025 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735926398; cv=none; b=vFAhvTfmgNsYLDICrY6CQXRKlJmsGfNq6iIpK1cY6oM5hPySkFTsQuzpBTxYRcK9rWUTZ5/R1oRjS2t4gYJUvF7X2TzylbgKRVFHdfJef80YEzD9gYw1HrgZCmLT8pv0ZfbpndIpBRrOViB1/bSm0BiJt2eioGZRf0JquC2FLdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735926398; c=relaxed/simple;
	bh=VDCJKGEZMluRCZrFOpRMQLzESzYMId03i4HdukxCE64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkmQQNIt84fPhD6dNasL0UVq1MHgqdlF76ogJelHMwDVCbUxBneftkk9VW7sMJbIrUiQj3BF91T6xRNe786kATr4OIXm5wMK/tHjBYYjqoYQmvgqJ9TYuNH0MSQz6/2AP/mVpETphESwlb7+A09zCsIXLWT05auldoKTYb+xfFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=eubpLLm3; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3da226a2aso2308064a12.0
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2025 09:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1735926392; x=1736531192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TJJ18KTh0ifU+lPbN1+aU29vENTzq2+LdHig1jQDZA=;
        b=eubpLLm3gCrobmAyYLuRlt5N3AjDu+kAX3fAwsMmxbI/LrJvO/3anVOTWDHFAAaHnD
         xVoYTnKqu17ZcBiy9ihC4MCjE+XA4UAygDiQZ4eSOAcqyGwL7swiC3T/RwvF5gQPdmoZ
         XGxekci9FjGmxENS3WSzJYWZWkubmLdgErR6zx5VQUdMt/KQXrcwaXFQfCgMJU9Qxrd4
         8Re/Wj8IwgU9fAd4PxcRI/kQWUVrFSErP8OnGokhK2CgF/7+Nqqx50lyCJxJcDOFC42f
         LhzSLDghiEQtNiCwwDCBl14eUcQc86KHVzuy3a7I7GfdWKJEM1yNS5TPsG+8OQ7Hgrdy
         PO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735926392; x=1736531192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TJJ18KTh0ifU+lPbN1+aU29vENTzq2+LdHig1jQDZA=;
        b=u7xsUGQjXuVk1oJtZiVosioSeWjtaZAbyxFrZ4qnTTpAOACFJlF9CQSmeLWV40xHa9
         ObbjKLIkhzKLRT0R156LSnZbX95a1+DCcpZpC9fMRwz+01w+ZFA5MaPHEyREj74MxwA1
         Rbn3QdSYjXT/qlkLRl85+pEv3HS4iaAkDAcBNDd/vlR5dH358SPqeqO7Dc2CFkQwxXUI
         sQH4f8eAbflXbEHFO6jBpiLBUVKb2z6XMx9dnqFQNkKVQ2M7P+xKbuvrXQbKj8Y0UDl1
         N/FSG6yizZP9zk3KY9Iq5j5lV+Ik+oGbpjdYYVCjLbAO+3zSFiVCx0nRt8mhVWyUP++H
         e+Dw==
X-Gm-Message-State: AOJu0YydcX32vcxFS5/lhIHBBKJzLzPqsZnC0L2rl5SuWrZ8MzHqpm5F
	kLGXXgCAGOm60uM0uasBcHFyhnwHKYHP7tCrKvSIlo4sPGGsjPFaXohS9bcqLMNKsKa9MZGrb6j
	sgAyD9fKsB/14wiNeJF5+VLsqwvdYjpP7SRqWvg==
X-Gm-Gg: ASbGncuoElCFQFR59gEad8fO4HGl4GsSGc2XtdrPWtpQmoXjQOpixZzBRO3jN7Wa9/u
	vufpHeRJEXZlzrFo96ctRT0Jxw2uJ24dLfswkVyt9dyDD1ALkB7bNRtvkxQZQzvZOBeSE0lk=
X-Google-Smtp-Source: AGHT+IFzQ/XVPfIOzkIUSTg7tt7oiRx+qUsT5adYgtD7Xcd/v9iyv4nNQsfRWoLuBXh6+6DScalBU6gzVWznDYiM2nw=
X-Received: by 2002:a05:6402:540b:b0:5d3:e843:fcfd with SMTP id
 4fb4d7f45d1cf-5d81de35cadmr16660639a12.11.1735926391946; Fri, 03 Jan 2025
 09:46:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103030839.2636-1-lizhijian@fujitsu.com>
In-Reply-To: <20250103030839.2636-1-lizhijian@fujitsu.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Fri, 3 Jan 2025 18:46:20 +0100
Message-ID: <CAMGffEnWkf7TzBS6=HtqO98b0oh4uRKYDHMghnt=aeJdY+36Xw@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/rtrs: Add missing deinit() call
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-rdma@vger.kernel.org, haris.iqbal@ionos.com, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zhijian,

On Fri, Jan 3, 2025 at 4:08=E2=80=AFAM Li Zhijian <lizhijian@fujitsu.com> w=
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
> Fixes: 667db86bcbe8 ("RDMA/rtrs: Register ib event handler")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> V2: update the subject 'RDMA/ulp' -> 'RDMA/rtrs'
>     update commit log
> ---
>  drivers/infiniband/ulp/rtrs/rtrs.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/=
rtrs/rtrs.c
> index 4e17d546d4cc..3b3efecd0817 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
> @@ -580,6 +580,9 @@ static void dev_free(struct kref *ref)
>         dev =3D container_of(ref, typeof(*dev), ref);
>         pool =3D dev->pool;
>
> +       if (pool->ops && pool->ops->deinit)
> +               pool->ops->deinit(dev);
> +
>         mutex_lock(&pool->mutex);
>         list_del(&dev->entry);
>         mutex_unlock(&pool->mutex);

Thx for the fix, I would suggest to move the change after list_del
block, keep the opposite order from rtrs_ib_dev_find_or_add which do
list_add as the last step, and then  if (pool->ops && pool->ops->init
&& pool->ops->init(dev)).

Regards!

> --
> 2.47.0
>

