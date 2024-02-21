Return-Path: <linux-rdma+bounces-1088-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5573485DC59
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Feb 2024 14:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14C81F225F1
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Feb 2024 13:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8026E78B53;
	Wed, 21 Feb 2024 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="HQ47eX+c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30847CF1D
	for <linux-rdma@vger.kernel.org>; Wed, 21 Feb 2024 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523533; cv=none; b=vEVYuASScHyW0pFDP78LCDNheS1skhvCZecOw4iV3wYXX3MM3cGP62JztKjwd24Ptp/mNImk3N+yTJ7SkEmPNDpxCsmVgrQQGmLVy/QDUhsHzlWcKGvCz+o+YXlGApgx6/eCMz6sovqAdJAQnddADxcLWaXPLo4CInh8dYi8dho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523533; c=relaxed/simple;
	bh=guO1Rqgw33ZVsCH4CgJEiEJ2lrVKpqBVnCo7NLAmnqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WixR6VGnoNrCT6rX3NdUhBQzX7c5/UPUNNd+15GOShK2OWLfUbiVzwkJLqqllsusaoxIof0pwxmJnzAXKM+KZWCoiOzBfoh2UcJGh21nSfV3/76hu8oAP1VTkt4WwhuoQGH+K1GCSUBmZryPXuogBV+Xbec2TTwbq0+BTKA7uJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=HQ47eX+c; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55f50cf2021so993235a12.1
        for <linux-rdma@vger.kernel.org>; Wed, 21 Feb 2024 05:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708523519; x=1709128319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6qohZ42zELlmbBzoFDQ8TzWorWzEWad6oKVa/2rXMo=;
        b=HQ47eX+c7HllHPIBUB31lJaObe58p6uc79p+szXToF7K1e+Fry9gCa9O2JwFsZLSVV
         4mPNBm8P81SsqGOvMJpPKvfvY3Nda6pSZ8F4AwNDlzLoP0q19UdHs/bqbPSBbXBw7qKD
         yJXoyf+L6BtXarfhvftnJvTAOH4EuyXRpaJQhuOUi5WeuaVi7e/goHL3rquYx8QpX27S
         bvq3cPZxCeC5YSwLd+VztvM1URBUvQidIMFt5HPyHtpZVsqV9x3ZOz4XA5H3xwjktuWK
         lqd2Onpzx4pUNU6+sz3W9ETtNt/WjXJ58cHw/aVSYf/65ObKSVG2ATbzNnIADZPCa01L
         7CuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708523519; x=1709128319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6qohZ42zELlmbBzoFDQ8TzWorWzEWad6oKVa/2rXMo=;
        b=o9QNpneXvwa6sk5nPPyS9twpRkKclb8gBGfYcefTbmqylnDLRREKWglmH1V0h+hw1Q
         9HrJsTUD+xEJf/Lzi9VfpckMw+D+13kiiLUgSh5CtsjQErDaMwYP373Pb1c1mZgNbsxL
         m3XwKEOMcBH1DLXUB2G37Fvmdt6hassjzg80NmffeAJl81yHO19oBcRugrOHbN723o8W
         VnzkC59gzNrM76xH64YEAM85XJchgPSOv+hvHItgLHpLRV5obh3KuVZ+FA/ZkNqGUJXJ
         1q4F03th8SNNEuV9WSvFCN1zX2aiR/jjgiYh3GPgQ+Vi+aMfVgDW/gyhWL4hc8U1rjSX
         0UDw==
X-Gm-Message-State: AOJu0Yw4fyaYZMgrt8pqhFuLPIAkDq+AtaDx93ZNVnIHxCdKDRZhztkK
	XkPwvhthjn7oaDL5JB8YW/JCbdhZwaC4VfMeRwmDPeZIuYzXpMALEIGHtjCkO++9VYI7C3ah21a
	gsK9Yhz+uL6OEov72Bb6v9V82W0GAzZAUQi1vD7PDeI4EDbCD
X-Google-Smtp-Source: AGHT+IF4E5iRX8R3ZueBHVJSDuCc5L+3m1jEvjUi5As7LyfnSPO8Cdg6PkC9ghQATevbEiLBTytU5RHxx+a6YH5MgUg=
X-Received: by 2002:aa7:d695:0:b0:564:10f2:8c74 with SMTP id
 d21-20020aa7d695000000b0056410f28c74mr8558087edr.11.1708523519338; Wed, 21
 Feb 2024 05:51:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221113204.147478-1-aleksei.kodanev@bell-sw.com>
In-Reply-To: <20240221113204.147478-1-aleksei.kodanev@bell-sw.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 21 Feb 2024 14:51:48 +0100
Message-ID: <CAMGffEk_am8+D9-8jdu5TBpSFmgF8OqE-Zdm_3BW=xfOBrP76w@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs-clt: check strnlen return len in sysfs mpath_policy_store()
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Cc: linux-rdma@vger.kernel.org, Haris Iqbal <haris.iqbal@ionos.com>, 
	Gioh Kim <gi-oh.kim@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 12:33=E2=80=AFPM Alexey Kodanev
<aleksei.kodanev@bell-sw.com> wrote:
>
> strnlen() may return 0 (e.g. for "\0\n" string), it's better to
> check the result of strnlen() before using 'len - 1' expression
> for the 'buf' array index.
>
> Detected using the static analysis tool - Svace.
>
> Fixes: dc3b66a0ce70 ("RDMA/rtrs-clt: Add a minimum latency multipath poli=
cy")
> Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
lgtm, thx
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infin=
iband/ulp/rtrs/rtrs-clt-sysfs.c
> index d3c436ead694..4aa80c9388f0 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> @@ -133,7 +133,7 @@ static ssize_t mpath_policy_store(struct device *dev,
>
>         /* distinguish "mi" and "min-latency" with length */
>         len =3D strnlen(buf, NAME_MAX);
> -       if (buf[len - 1] =3D=3D '\n')
> +       if (len && buf[len - 1] =3D=3D '\n')
>                 len--;
>
>         if (!strncasecmp(buf, "round-robin", 11) ||
> --
> 2.25.1
>

