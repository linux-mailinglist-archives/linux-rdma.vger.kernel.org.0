Return-Path: <linux-rdma+bounces-6324-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AAB9E83BD
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Dec 2024 07:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72AD5188490A
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Dec 2024 06:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704DC3A1B6;
	Sun,  8 Dec 2024 06:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agbI5ClW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30FD22097;
	Sun,  8 Dec 2024 06:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733637716; cv=none; b=ZY4Ia8LG65QuYvE2QV8jfPBKfBHkkWJfpG0Rwrpj/sgiZxJzkWT3+86b9bv39TloubQvnbTXkVgTI68GI3jBp64R7GuFQZHru1a+sBaOM5D6y4eS4ccTMethxAer5hrWStX6evjCGhqycEmPgGWZHo5QDCvREUsxIgBieLmK2xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733637716; c=relaxed/simple;
	bh=oArNqQjCYhIE6H9hZlL4MTeNNdbP0UX/oKnqFDBeM5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hAYQdmKPcD7hCXCNN1AAUoa6vJwmWUy1NkUg4aCgvYVOujvHd5LCEiCnl8Y0rA2wxIRZfZVNFh8UBapKg5rHrGCy1YZ6HbjIUg1hp/GFwxmHXXAPsFyaZdtLINIFOOmQrMLIAk8166GFCbdFVKUGFiiSYC+PEgTYEjTQtzoJoRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agbI5ClW; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d8edbd1a3bso13813146d6.3;
        Sat, 07 Dec 2024 22:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733637713; x=1734242513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKZLZ56sRa1nZcH20SLwc98Zabb6zi61xg0ECzpB+68=;
        b=agbI5ClWzGF1KIpWcq2Qv+3jz5LC+OLJ5QrFXoNDvyTFHBsNolASIYTGkTX3acaHkx
         G3aVPa0OIxNEuGh6GpzUZ9loljnIOV4tjH8j7/Fi3LhDwgJ8r0HHjYmJ4zfMPgYduyG5
         9ewa+w/4J+zLIb3Hq3PrO7xgfs3TXSv/2PUJ69qakF88Tb6YLlMs0sjwUknk0AbuM/2B
         xeMCEQh3WzyYD7Ku+dCQzIGkZug1w1cjSr3OPNk1dcbojIbzNz5I/oY3sSM88cPYsuiJ
         tmK1fiKBG6KBYMI7pOAXEawKyVdRdoyQ0yG9gkvyzyFgN69stUzDdVFMM+XFez3bMrov
         sSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733637713; x=1734242513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKZLZ56sRa1nZcH20SLwc98Zabb6zi61xg0ECzpB+68=;
        b=SXG6LCff0wSV1Q8bHInLSnuNAWW7O0Ei4Mdba61jT4pWTyd6clCa/fxGnV2dfkvYLH
         VTawIC4Du06+SvWTtEfPxZd4WygeOQHjSWIJv+Eb6jHY6zm/wXjsyQfNXIuPk0QqqNx6
         UOG6YwEkj61m/IfcgrRxSNhZhRYl3xLOMvfeupKroVeckc7kQ03WZL7xzZx2op819Q9P
         syEosg43A6gS734KnSiofRuia7yoAjzBpBtus3nmcDcSQxp8aau++wHugEuUAasBOu42
         UB9eBRzjNfPU/W5TB6XXub0jEIEQH0PiGLofCRyJrGfkAGAsbS3Y/d6K0g3a5CuMDEjy
         TiGg==
X-Forwarded-Encrypted: i=1; AJvYcCUAoQTl8+afDXJLRwcLQDhHnMsvdhmD8Z5SSZAjryH75+gaTBFpYOSVXRQ+NraSB0qdaQtVzAZT@vger.kernel.org, AJvYcCXPgJvXsrvByv68w0dKhl417nJ/qHmnkLt3pMzBrmXIqQcxAzsPG526oQlXezIkRIe9+Kmp8KkNb7R8@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy6b7Nc8z6uoGAjN+DXhoXs7V/wi/3vkUHGIV4zL8WUSp5a72q
	2b3W/yIb5H/30lJbEs5qPo1XK6w/Xrlg7H5t6N02QB3LRXPV6/QPCCCBChjLIQWwePF1p9ML4YD
	I77hzVmv17cJU37A5MBwgf6zZmCfFqVt+/9taINlz344=
X-Gm-Gg: ASbGncvqMztQPiAP2KbJ9FlysQ1X+G7SBWx0fUWZLCVxZyc6/yoqdp2xL11SDGLPTo4
	I95LrHWbZXk2lIszSrOUw9w0B1wGHhrsptw==
X-Google-Smtp-Source: AGHT+IG8mnyA5OsLNcMuCdRZpBooTrSm8QVZb1T8OjclK7vmwuAZmrciw2cP6pdsKKkB3Vj4v9MI8sN5Kl52rAI47j4=
X-Received: by 2002:ad4:5aa9:0:b0:6d8:99cf:77b9 with SMTP id
 6a1803df08f44-6d8e71550ebmr164170616d6.19.1733637713623; Sat, 07 Dec 2024
 22:01:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206090328.4758-1-laoar.shao@gmail.com> <20241207173808.5866b5a6@kernel.org>
In-Reply-To: <20241207173808.5866b5a6@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 8 Dec 2024 14:01:17 +0800
Message-ID: <CALOAHbCFm6aGm2ZpEBKR2j4cCy8fU0STjmYFOm-fhsH7xmwFUw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] net/mlx5e: Report rx_discards_phy via rx_fifo_errors
To: Jakub Kicinski <kuba@kernel.org>
Cc: saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org, gal@nvidia.com, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Tariq Toukan <ttoukan.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 8, 2024 at 9:38=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri,  6 Dec 2024 17:03:28 +0800 Yafang Shao wrote:
> > We observed a high number of rx_discards_phy events on some servers whe=
n
> > running `ethtool -S`. However, this important counter is not currently
> > reflected in the /proc/net/dev statistics file, making it challenging t=
o
> > monitor effectively.
> >
> > Since rx_fifo_errors represents receive FIFO errors on this network
> > deivice, it makes sense to include rx_discards_phy in this counter to
> > enhance monitoring visibility. This change will help administrators tra=
ck
> > these events more effectively through standard interfaces.
>
> It's not a standard if there is no definition applicable across vendors.
> Count it as generic rx_dropped.

Thank you for your suggestion. I'm okay with counting it as generic
rx_dropped as long as we have a metric to track it.
I will send a new version.

--
Regards
Yafang

