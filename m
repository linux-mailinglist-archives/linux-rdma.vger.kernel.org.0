Return-Path: <linux-rdma+bounces-19725-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHx0LmXR8WlrkgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19725-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 11:37:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A26849212B
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 11:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B099308BF33
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 09:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDCF37B03F;
	Wed, 29 Apr 2026 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="VtuDeCLp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B0D1EEA54
	for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2026 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455076; cv=pass; b=KQLkWrm1veYdsl4+nq5PKgCaANYE8GrUXu9/2XFZ/kC3oxQwiaBzwV6jo/mso2LMCGK3BYg2q6PrfLTu8ayjkjM8S06jCnq/TR1/6VPpdIideoXhe6A0OIeuG6Oy5GxakVjvjvpohskvs7I2aoOt/PvkL50woaVum2FfNS6BXac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455076; c=relaxed/simple;
	bh=EX4+j2RAawutJ0df+wVMw0dXLSOhhqOZle5qZkAhHAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EISCFmd/l/uF+ZQxH0wbiKvA4iBlVo6zuDY9Y7qeT5l0aswa+VFiNeYITnWUwl1EHYm1OxPHvQn43RDcUCXuWpUZ++BnosFfXKNHN0MUOdZilcjsc06Ynx1ziglLcJrELKFB/yYnx8uO9jHIQfd3A4ZXivCeaDJluS0hTBFKq+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=VtuDeCLp; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38a01c80c34so121418981fa.0
        for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2026 02:31:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777455073; cv=none;
        d=google.com; s=arc-20240605;
        b=Dj4HwNrIWKSZANqpIi0wxhCHbalaC1aCNmPD/6obGb9913pjShYa770Vv3cLRuU/WR
         OTg/vGF3TCSTHDdabHf2UWEkizSCH0JPcOPFL8zL/jsyzaHTgey94eWPs7t77yeeFDck
         StqVweZyLTw69yJc+cm+iwaj4JSmFC2+XfubdWjFAKexnkIbkJYCeG4+i1Q+t7XeIDwh
         3l2jt6D3ZsAg4L07m/u+g6emKTefzUYSOtunenfjKPrU5joq0jxYaY+gI53OLSUj2QUK
         pGIqnV51hRew6Y/SLviOcd2EMK16jj0kkSfPUHUAFRiI0BRUuzvTt0wxBgV57enWyw6x
         2pQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1tC+Y+2YvBZ8EcZ8ouxzZ5xDiR/j/Q24A+LE2bcZhJc=;
        fh=Eq1Iz3hd9sV8tEnlL/livruNcc0oH6+XQQHWvGIYNV4=;
        b=DE8eGZopbHfuoihdaYynQcnMn4j+ivd/7JG43p8+eX1p9gT0LQYNxb1fUan45tLJtE
         QcUEcgWGNyVMHAhLKmQpvEynDiAz+b2mnopS6yMlLhE9uGxwird9TEL1cnZLpPi4hUJF
         IoSA7mNcsvFjVNZcUPuj/z8tmtzTjbe4t9ph/fVzB4+BThCzAStOV4iQwOMVQRBkbUG/
         SCzXjxDi0KxFcDx0nS66H7GZEjy9wilCDaBaRLov7+khHZUwK2WjWwYZYuBSgnPXolDM
         UnJIbJILdvox0azA5ghs6KCMCxTM+nx2an+hLjSZA965k4//4gKjP/1ToY4p14MjBRKu
         5RTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1777455073; x=1778059873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tC+Y+2YvBZ8EcZ8ouxzZ5xDiR/j/Q24A+LE2bcZhJc=;
        b=VtuDeCLpYNwzt0X5pbts8NfjevXsqFN+RtGedS3yvOiVZ7zStlv0lLWkc0nbEL4bhQ
         vKo+y+PgFXg20oN0rFlqBhX6+fNaoyHQxEJY4xT85YFMXiz1uVcIfFoL45QG2Pr3r1DP
         10ptaVTrH4hvmZeamFEJB9276j5QBuc4J2jbI2t8/FV+9ij6Wmfhbf3gKM9QyMNXjLz8
         9v7prZDOZoDW84fCCiLacvRyu3I4nn7ND+1o/BIxoOsS7xpZuATBaIe18GlT9xNdeS/p
         qMlTYiYq4ZWdxIfGeNvwaYjq2yVCcARQ8vdt8AobSMLUm7Vf1Pt6Bcimxas7yG1Bhc0E
         NNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777455073; x=1778059873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1tC+Y+2YvBZ8EcZ8ouxzZ5xDiR/j/Q24A+LE2bcZhJc=;
        b=fjJpInDhDoiUu5bo9jyIU3QYFzEff+39sCzWJriVkpOB+YHat4PAPTHJEMOMgdQLNy
         AC2m4PnTEYZU6Um3zl1e03nkTnaZaK2p284plC+n/cClxCjvcB0Bsv2HMpnLzbE8Vw1M
         t2y7e9BnQYlzzetXZG/B9g4BCdKf4ESe/YBOY4/zwzhcJj0IglnwF3nsXeYT+VO802vH
         MY/jV56tG5dVKGFypCofUsgOMdfu5ffN44CJq8pu/+JVrrA3U/1tr6CGyAGQJpgRy+0L
         REwYdOCorXYYaiNN1nJabTYNQ+A7MKvtThR5jpwvDqctUFNQdn8+3XqkhPqw2o0kyKrd
         ilpQ==
X-Forwarded-Encrypted: i=1; AFNElJ/7uLEgALzV6wl3O7mpTLRnlSOelbdfWUT7ShRZAJejZPHzifK0w0wz3m7Klr+UjvxfLKHykaGwm1+q@vger.kernel.org
X-Gm-Message-State: AOJu0YyzGL5noGYvwBAIvlUM249zEUjl4gzYHPnAAPYcctO300QaDyhk
	JmnJXEmf7hD20jNrpNUwNRVwUsRRmoksm/xHUIgQjPl6JZKnK98tr7tuvHiw0VbO8ersUVqXymq
	TqsgXNPHLaNFoOp5LfoM6yAch9FvnAHuZTkWuoR10rg==
X-Gm-Gg: AeBDieu0Qu3/ogWb3thpr2mGLJEXBSOiKkIKadXcqFnRFuNe3ogulif/eRaNv+W2S43
	BNDydb+hc6xPXSz7BM3GrB0z5KPvhqFYEEZTUmiRxIsp8WJsh4jCBlYdZlPkM8wVbnLZfGZUOzK
	/4PaXVlU4+5zmDNnC5MXyv+XRQ0Cw57jKH8xYrP8+uDC5nJMzjKLmSuXgY7Ty78UiFeQOUJBShf
	2cI868KbkAC6uz5jB+oGaMKNDtN7asYaiuFP6GFCaYPbiL+lToTenzdbmXJn8cqh4LkrEWaQzUx
	R43RfLGcierSS/swiBgPb8S6s9fDXiDRqOKhXPicsyqRKYn0DnrQjLtfDoVB8+u1lYkPptQ34l2
	Rrkk=
X-Received: by 2002:a2e:8a95:0:b0:38c:9503:ebfa with SMTP id
 38308e7fff4ca-39240d123e9mr25307831fa.14.1777455072688; Wed, 29 Apr 2026
 02:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428105515.362051-1-lgs201920130244@gmail.com>
In-Reply-To: <20260428105515.362051-1-lgs201920130244@gmail.com>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Wed, 29 Apr 2026 11:31:01 +0200
X-Gm-Features: AVHnY4JwWtcB5LBFdeFpjP6i2sCJU3L36KJ7jGGE1bs-LZuICCyq-nP4qZ4rG14
Message-ID: <CAJpMwygTQ9vfjfiqn1hEPGWoFsUwwzz9Rye3-3XO5+rf-OFpGQ@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs: Fix use-after-free in path files cleanup
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Jack Wang <jinpu.wang@ionos.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Vaishali Thakkar <vaishali.thakkar@ionos.com>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1A26849212B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19725-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ionos.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haris.iqbal@ionos.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ionos.com:dkim,ionos.com:email]

On Tue, Apr 28, 2026 at 12:57=E2=80=AFPM Guangshuo Li <lgs201920130244@gmai=
l.com> wrote:
>
> Once kobject_put() is called on srv_path->kobj, the release callback may
> be triggered and srv_path may be freed. Therefore, srv_path must not be
> dereferenced after kobject_put(&srv_path->kobj).
>
> However, both rtrs_srv_create_path_files() and
> rtrs_srv_destroy_path_files() call
> rtrs_srv_destroy_once_sysfs_root_folders() after
> kobject_put(&srv_path->kobj). The helper dereferences srv_path to get
> srv_path->srv, which can lead to a use-after-free.
>
> Fix this by calling the sysfs root folder cleanup helper before
> kobject_put(&srv_path->kobj), so srv_path is still valid when the helper
> accesses it.
>
> This issue was found by a static analysis tool I am developing.
>
> Fixes: ae4c81644e91 ("RDMA/rtrs-srv: Rename rtrs_srv_sess to rtrs_srv_pat=
h")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>

> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infin=
iband/ulp/rtrs/rtrs-srv-sysfs.c
> index 51727c7d710c..c9ba9d2d0eb3 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> @@ -295,8 +295,8 @@ int rtrs_srv_create_path_files(struct rtrs_srv_path *=
srv_path)
>  put_kobj:
>         kobject_del(&srv_path->kobj);
>  destroy_root:
> -       kobject_put(&srv_path->kobj);
>         rtrs_srv_destroy_once_sysfs_root_folders(srv_path);
> +       kobject_put(&srv_path->kobj);
>
>         return err;
>  }
> @@ -312,8 +312,8 @@ void rtrs_srv_destroy_path_files(struct rtrs_srv_path=
 *srv_path)
>
>         if (srv_path->kobj.state_in_sysfs) {
>                 sysfs_remove_group(&srv_path->kobj, &rtrs_srv_path_attr_g=
roup);
> -               kobject_put(&srv_path->kobj);
>                 rtrs_srv_destroy_once_sysfs_root_folders(srv_path);
> +               kobject_put(&srv_path->kobj);
>         }
>
>  }
> --
> 2.43.0
>

