Return-Path: <linux-rdma+bounces-18678-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FU6LsNexGkkywQAu9opvQ
	(envelope-from <linux-rdma+bounces-18678-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 23:16:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D9832CD37
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 23:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6AEAA302B1AE
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 22:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C2B3264CF;
	Wed, 25 Mar 2026 22:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NauPbJ3N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644C7749C
	for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 22:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774476980; cv=pass; b=r9lRUb7vIFy4MCfmzRoU6c/9CBvT8ZB2jdmMoR5AFwdlTHDJZtjtRQpPSPI49px4nQLYnSfMk0J8dx7NCmpXhFAwJfu756AfOfMeaciMzswDkou1BdVRpgqGbCQtYPh14F+uonoPxywYe2fltnh9usN5zjgZJzFONbSIsHtojdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774476980; c=relaxed/simple;
	bh=CKPaPT6pFzg5mW5MbWk4jzTi2tnODuirpxJdAHgBJAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLkd4jNb40nR7naxfmQ3uZKSQyiMsSlfvc1oM2F9VYnoFRDgV635NNcTOfvmnzm+tGDVCg1mNqEgv9shkkBH+pYH9j0KzZSktkfa7mzd0MzitvdOn0kxSuz3kuQZFPKaUyizfJfVxQRNG7Zjsva/h3WzYhfTVPD+sbnvDD5HgpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NauPbJ3N; arc=pass smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d9bba96f7dso173891a34.1
        for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 15:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774476977; cv=none;
        d=google.com; s=arc-20240605;
        b=DyIrDG6wpCX5y5biRvUwzfH2fdfwzHFQECu7mfPNOUnQ/e0DgOGgowe/seNF0ysNOQ
         BqEVtRHnofBaysUCYW8SI0HAANzgQI+ov7xq9ZHW2nqJZDgbqdhMyOJBGr9SrBxw7RVQ
         d+jzZfWKjuaTzLCU9f5qCSH467x61kGk5DKkLCmbjhMehqOzQJZUuLbP9GfsrUeFF05S
         p5MzQKQYOD5qW3/pRPGIb3k2TU+yI2RquWx4zcvwwLv9HF5TMsosP1dyv3pxem+6k26s
         xRjBjVNkphl9RyGh8Mmu5sInDVFM06EAxPz/HjWLZKJBpWn3/cGtFDE6YblH0Lb8ZTc0
         SKzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cQDzQb/gBIw+MDDDjq7X4ZU1Rk6doOJDsa8UP6sNnoE=;
        fh=nYDBAKFXOReB7pHdhsUN6jRXX4WIN9LW8l2fwb4x22w=;
        b=jj/W1vLbOtL6PbH/h6HNlhO1djFyS/YWBovH8QLiEIG6Oa029/x+90jLGeAjvUudiw
         ciAkgli0qITQ+Lxqo68k9hBXQnJ24ljmuXhPiqNU8OdWYUfmMGMDSUf3iPTeQkVFecnI
         IKxTv2YZqglnQFzK3AgFB5J6yo+L3SjuuAUB746AFRCZfyQlumykq26LUJknPkoFrA/w
         I/r+ZuYODX6HwZRQ8X78Ob17vb0KKFP5xBgU5PqnEI1kRlUBbM3WZD0zka+TBMOGzzAq
         PKM9kK7c5jXNu+nOyXznHyVW/7PwvJtBBMSPH9IVOi8Xymfqf1+sQnsyXscY2aZFtrBB
         Gl2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774476977; x=1775081777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQDzQb/gBIw+MDDDjq7X4ZU1Rk6doOJDsa8UP6sNnoE=;
        b=NauPbJ3N1oJh2Q82B04o58jfgVbuG2d1t3SUERHDZlWH0cfa7zN6nSbJcBY0j1+xYW
         0/DcpDk6CPzKnH8CTzdtCYtIRps3cj122vgqeKAFlcb118+W98JjQX4MUAcvTU4QhznU
         wc1x2qNN4NOidhYHC6dQQ3TJrlRN/lAL+9tPEXFkmYBHAvidFNuenXT4VSJYr6Myf97j
         4toRw8WB59f4WoqYbffafRmDeEYh+4AQUwkuOXA1VAN7CExJL8VoYq6vi/6bEz9frm72
         0oD1ZPXm5CLg8IUE4PVtZVeaQJ7WQlHMY7QgLFp4DzSDYLZuWrp+opvpUl+xbvHEfhiO
         h7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774476977; x=1775081777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cQDzQb/gBIw+MDDDjq7X4ZU1Rk6doOJDsa8UP6sNnoE=;
        b=HBNgFPyomDkJb3M9EjNSucn8XMH6o0V/xqiVmNmAS6VxBpZwAtCRkQ6Xd/ZNUQCaKm
         0s5LNeiwO58+csX187SgcVE2JbiKL8ZSKT/4cplGyYuJn6zywffpamptHmogaPxm5MAH
         D5rNB14PoI/jAidp5SZkHQglqD/K2fA/+qSr3mAxfUHLPJms1on4pAXosk7ig/MZC6yd
         M5SzBKG7fuBBLwrUlREF0lMNR3UQOFMB8T1A+GHO5T0IRyWmrT0Jii+muQi2eh0Fj6Pw
         ln0rkQggDge4vqOFAynZu882kkYfs+wtlruqhM7odjB/Wuxe60bBndW2Caf5WXIRMNLW
         z4rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWraKtG0L5uWzJytzi0vlaKCWSb2VFAC46755vl3QoR11lW1cJiPMk5QS9OOfvckPejf468HJPJ5gnJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9tww8fZAhRlTbCVjk9fMqPqQdj0egFkAYo2GoXw7fBqW+9eeL
	HaQ/pCocAMfJytPb1qKb6JVAm/tZbCoYOV03yvp+xxAtn+JuPumjSm0lX6A0ta5DsCXk0NBysIx
	aqO/XBHylSuJWk0x3H5m/U4gKmL/u6nWEzVzOjMa9
X-Gm-Gg: ATEYQzzIquXFLMtfWgSE8Qt5oXEv1A4n2IGjXkirD1uh/oShJNzwJagBkeIgDqTZRrE
	xNWdq1DmaveoT1d40hrxP7ZbCMNaITm7xRO/4yShTSMvIhJHE7eNW6NXlhULvw6m89ocQdW8fdY
	4bP88Rn+6A53D+4xcnro5E6ZgadHKqTzQz2BQGk0DipKffVvMtkcbYft+ETqNdGzNja6MmgKFF2
	papN2WXeR5RmR1k2rWiytK4/GikF6QqrlNBzId5DUlrGaIaSBDuL2u4EQmom2iYZrFE0OoBuWPo
	MiCvvnPARTRPw+cmNJD36Z+nLgQfjIOpPzYcxg==
X-Received: by 2002:a4a:ef81:0:b0:67e:aa1:87fe with SMTP id
 006d021491bc7-67e0aa18de3mr609126eaf.26.1774476976932; Wed, 25 Mar 2026
 15:16:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com> <14-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <14-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
From: Jacob Moroni <jmoroni@google.com>
Date: Wed, 25 Mar 2026 18:16:05 -0400
X-Gm-Features: AQROBzA4qyqKM_YfcGn1wN202YeqdJ-wh9W4v93pqVeHVoUP6HSGLEO470XesXs
Message-ID: <CAHYDg1Rx_o5osDGWX0q_=BES4C-rpbhOXjfWcQV-yAOe38sn3Q@mail.gmail.com>
Subject: Re: [PATCH v2 14/16] RDMA/irdma: Add missing comp_mask check in alloc_ucontext
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>, Allen Hubbe <allen.hubbe@amd.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Bernard Metzler <bernard.metzler@linux.dev>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Cheng Xu <chengyou@linux.alibaba.com>, Gal Pressman <gal.pressman@linux.dev>, 
	Junxian Huang <huangjunxian6@hisilicon.com>, Kai Shen <kaishen@linux.alibaba.com>, 
	Konstantin Taranov <kotaranov@microsoft.com>, Krzysztof Czurylo <krzysztof.czurylo@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Michal Kalderon <mkalderon@marvell.com>, Michael Margolin <mrgolin@amazon.com>, 
	Nelson Escobar <neescoba@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
	Selvin Xavier <selvin.xavier@broadcom.com>, Yossi Leybovich <sleybo@amazon.com>, 
	Chengchang Tang <tangchengchang@huawei.com>, Tatyana Nikolova <tatyana.e.nikolova@intel.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, Yishai Hadas <yishaih@nvidia.com>, 
	Zhu Yanjun <zyjzyj2000@gmail.com>, Long Li <longli@microsoft.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18678-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,broadcom.com,linux.dev,linux.alibaba.com,hisilicon.com,microsoft.com,intel.com,kernel.org,vger.kernel.org,marvell.com,amazon.com,cisco.com,huawei.com,nvidia.com,gmail.com,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 64D9832CD37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reviewed-by: Jacob Moroni <jmoroni@google.com>

On Wed, Mar 25, 2026 at 5:27=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> irdma has a comp_mask field that was never checked for validity, check
> it.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/=
irdma/verbs.c
> index b2978632241900..d695130b187bdd 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -296,7 +296,9 @@ static int irdma_alloc_ucontext(struct ib_ucontext *u=
ctx,
>         if (udata->outlen < IRDMA_ALLOC_UCTX_MIN_RESP_LEN)
>                 return -EINVAL;
>
> -       ret =3D ib_copy_validate_udata_in(udata, req, rsvd8);
> +       ret =3D ib_copy_validate_udata_in_cm(udata, req, rsvd8,
> +                                          IRDMA_ALLOC_UCTX_USE_RAW_ATTR =
|
> +                                                  IRDMA_SUPPORT_WQE_FORM=
AT_V2);
>         if (ret)
>                 return ret;
>
> --
> 2.43.0
>
>

