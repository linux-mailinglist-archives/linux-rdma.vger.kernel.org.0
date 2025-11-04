Return-Path: <linux-rdma+bounces-14224-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5877C2F735
	for <lists+linux-rdma@lfdr.de>; Tue, 04 Nov 2025 07:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 35EE134D045
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Nov 2025 06:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CF045C0B;
	Tue,  4 Nov 2025 06:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="UJ/02os6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649CF1B7F4
	for <linux-rdma@vger.kernel.org>; Tue,  4 Nov 2025 06:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762238104; cv=none; b=Zy+M9WtrhOQe/ctsSzyJ0C9PWlk69unye74EqHp1F6hfl84C+K4iCUlL94j/aaH5PlPOPkUedujoBysi6Sr7wGuXRg1tcvP1i8Ha/zKWooIxInVPXlnS6vyPr8PUOcOcNO69GzlpdrA/IwXmknpSWJFuitNv3hVM08SnHf/7HFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762238104; c=relaxed/simple;
	bh=s7tSXwvHJ4PEs4y4Dec7uGqloATEs+Wo8gpI0FbMsVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b69zw3AW827XaKdhe6OZ8IiUiBYLsXcTuY5Zy8zLOFTwXw2eKj2kV7foENt27We6Ng296lJIFEFdEHigL7r1ZLuBzNqfXXerV1wWD+fY78NKiBCejYWSK7RRJiTa/3pqTy1W6eonMLA+E7gtUl15InrG5/e79Tr2fO99g+NDG6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=UJ/02os6; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-633b4861b79so1153245a12.1
        for <linux-rdma@vger.kernel.org>; Mon, 03 Nov 2025 22:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1762238100; x=1762842900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQmAzRgv0Utq69TMSo5XIPtDul3xsXRYMQU9Qcm5TFs=;
        b=UJ/02os6zo6tb9bDRTkqMwIS61zY1zWPRNHYWyZ4XtROs4qz91MoYxWQbv1F5e/2Ok
         gcpesx6W+xbR109qRf2mcHQMBpsCfDiL7EQygq7QMT5LtgrvDBrlvYApNOs7jOEI45WI
         TncHRFiMX42iv4wAWs2YCLslQXwyDMJXDK+88PPiVmpmiyjGu0tSd8YNVvwVZ9/GbEqp
         SZ2c1TcRVA64P+5gj6M0dKRk/iEXVkQQsqpaNgCSeGtyqWbKbnYj/z/3VsBptc3UK7jN
         rrHxyqUJzDNhK16dWbby2NtTZQ3H1QoB3glxxyobzlAxDsm2xFi53X3dIitP3gN3v96u
         2LtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762238100; x=1762842900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQmAzRgv0Utq69TMSo5XIPtDul3xsXRYMQU9Qcm5TFs=;
        b=c07IPQBPxqqbihPetvRn0sHIZubb/8M1mu0wQSEL4z4d2WNaZ53zAMakS3zfvNDXjY
         MFiOKaZZcIYHPmDuAO3XuMdx96OYqRteoRWh1USiUOFEUHvZ9vCgd+X/qa05pwZSDszr
         wiRt76/ed/KwTRwj1FKLfsoSaN36IwTcWLBHwaABHybSg3sOOK4JHgw12TD3Y2TDszsS
         A8xnPnEtoz4K+Qk7BrQPv8a77Nuq9aYbvBOIkoPYG6RH22yVB15chImlkHGxsP68V4y5
         EHKGZL2qtvtk5ADagUb53OOlL6n8oPngJSl38BqWBlvUTYanayXkuaQVJhtkUI/LhdAb
         lvyA==
X-Forwarded-Encrypted: i=1; AJvYcCXphnORQ9noXBLHvDMeSyV4g6j5TpXS5xM2K/kwlVtHbktdeeaqOMGAwnX2vRpXvOA5M1nElkV2pW4b@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+GnrLeZPNfqJmOokb/Y4Ds2weLuKGFx8tMiJEying1OPcwmB4
	7p46FVjh7aw+3TNXMhiZYvjVT4W38QQErevFIhi7DBy3TGN+ldQctTASyaGJuop4XKnIBUWM77Q
	iGBl29xqcFP/5UNdeB4zBFe7bBr1Tuclrj1Y5ePmgzw==
X-Gm-Gg: ASbGnctSMHtBMTXJiLJY1yKfpyKAEtcBgCxjsLZrOItR+gbG0tILzhiW8trj0BjU1us
	hDz5Gjgpm7WduqCWzP7TXQAJmC5KM1OwS1Qy6a4A3WXBb2medx7kgrx7EmNafjzqWgAT9vOwHI5
	kl28MGjPPSG0QGIG9UlgoTAwCjanrc+qgBwdRDSVdQ10nLFjUfyl3Q/I2++XVIN8Y/DG/Qg4Ob8
	p7vwzqSkYWDa92u5lcyefxI2922m46DomP6Gr/xONFQ6+7BkmqMaI8V3fT5Op21QVFS2eDKFRWW
	suoLL3NdMRFUdx/AVA==
X-Google-Smtp-Source: AGHT+IFhN63cUrkNgr3auzZxHZID+sIcCpWhSj3aZ/0+3dxL73E0sC1Ila0n0+af/sQcBRu6sYvHwe1uf0SeulBLdKk=
X-Received: by 2002:a05:6402:26c2:b0:640:acc8:eff6 with SMTP id
 4fb4d7f45d1cf-640acc8f300mr4453850a12.0.1762238099728; Mon, 03 Nov 2025
 22:34:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104021900.11896-1-make24@iscas.ac.cn>
In-Reply-To: <20251104021900.11896-1-make24@iscas.ac.cn>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Tue, 4 Nov 2025 07:34:49 +0100
X-Gm-Features: AWmQ_bn1fsvxkVFYJEeS6HPOZ4jil9W2MtbfRXCQLvctJqd1ASYUjnERunBcB1Q
Message-ID: <CAMGffE=0LXyzcg7tew15tV1zgVAaHA2XMHcf5=14k3k0KuzNXQ@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs: server: Fix error handling in get_or_create_srv
To: Ma Ke <make24@iscas.ac.cn>
Cc: haris.iqbal@ionos.com, jgg@ziepe.ca, leon@kernel.org, 
	danil.kipnis@cloud.ionos.com, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 3:19=E2=80=AFAM Ma Ke <make24@iscas.ac.cn> wrote:
>
> get_or_create_srv() fails to call put_device() after
> device_initialize() when memory allocation fails. This could cause
> reference count leaks during error handling, preventing proper device
> cleanup and resulting in memory leaks.
>
> Found by code review.
>
> Cc: stable@vger.kernel.org
> Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
lgtm, thx!
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/=
ulp/rtrs/rtrs-srv.c
> index ef4abdea3c2d..9ecc6343455d 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -1450,7 +1450,7 @@ static struct rtrs_srv_sess *get_or_create_srv(stru=
ct rtrs_srv_ctx *ctx,
>         kfree(srv->chunks);
>
>  err_free_srv:
> -       kfree(srv);
> +       put_device(&srv->dev);
>         return ERR_PTR(-ENOMEM);
>  }
>
> --
> 2.17.1
>

