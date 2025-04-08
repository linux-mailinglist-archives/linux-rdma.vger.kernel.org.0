Return-Path: <linux-rdma+bounces-9264-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E902A80FE4
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 17:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B053BCF90
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 15:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305162253B2;
	Tue,  8 Apr 2025 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnC1cqAX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B07722A81E;
	Tue,  8 Apr 2025 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125639; cv=none; b=bsAmYkouLgwTS4lXIpokYSaloolz2eQvzGBrEhrafEs6jsWjDMmkRQDSmdZ1BrMjIeqntfzRwvuRVMl/NHdjs32neOW28hj6/EV3DHorFcWtlDLCCvxrapsyDU5SojtUJtVsp2PjMtL0EuMf/dA3XlgLlNnCbOihGxBen8/bpz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125639; c=relaxed/simple;
	bh=lWDCNzuL6roEztDLgYUdG/MTuRiCDj0W1qC73mLUGTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M03okUuBBJX2nzcYaMjobCaCTQ35WYeI33lCoDsXv00MchlBAvwOj1Kq/QPQWARqtCyP+h6Sbv/sXabFJ60wssKi5kjt1EaCGjOiePN9uT92s+6xxT8t64oS5C2WSbEYPewxZaLg3SJWNfso5t/5PovAVGRzOzlzZxtYp2V0pSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnC1cqAX; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-30613802a59so60231341fa.0;
        Tue, 08 Apr 2025 08:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744125635; x=1744730435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N80BCRcNznFNYH6Bzalal9pt2w01iU/nV5tXe3JU1QI=;
        b=jnC1cqAXyGwm1YBzGVpYzkR3DiIbh98s0iFTmMw5nODGWcaNO3pfmv0X5L+7pq9Ys3
         sFohUQc/eh01vk//XO9rz17vXnC9L7x4Bak8LPn3lVxfECAFSdZZ5oM4czR9mgQPWN+T
         5xwdxX23HI/oRsYzdcPVqhsIgaercGx24B0hdJfUF76G5qQCIenumeAFygNM4RUX3wWy
         fwLJ4F9wxuQTrx+CzlnJwFY+U09CkTm9Aq55LjNqgcMw3LswQxLLuweG3360/vsI8SCM
         IaKMnkMidnPXSStYnSxWWSnCiF0fjc8FtOiTWX3sAkIK9yop8NnEnzv0odTLp/K1Y9U1
         /I6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744125635; x=1744730435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N80BCRcNznFNYH6Bzalal9pt2w01iU/nV5tXe3JU1QI=;
        b=oyR0aqcngToG+gqd8yu1gx4No3W727IYxOTGPQyXk1l6RnYoq/zPv+T5vI29PdhacM
         SxAPESfMbgrKMs7vai4RbtR5REgZrv8Ic0IIez9kV5WfzD1RmoE+tIuN44eDslI49osR
         g8URvHqpinqcI/k1bw8mt7F/TBsJjXpK+eSH2OvX3PU6iu4x44RLc1eA1gI5BbAZaC7F
         PsU5yqid1zpCF066nLcbwhYNDBUAzkjNBe7baQM90TkZ4GoYgzti+ub5S3sB6l98rsX1
         r0fBYlrd83nmnnJeHBI5XeLKs5SPeESVqAew0kmzj+zzQAT8c7U50ujj2y1nvDpqTDO+
         SPfA==
X-Forwarded-Encrypted: i=1; AJvYcCUHG09JannYT/eNQY+5I7ZEak6xLkpDQ4Xa9oZx8Es2iOc8nJzcIbtcLLU8xdtUNOinhd1B5Ql2ijIP/A==@vger.kernel.org, AJvYcCUsMw8garjcSyXkLJioINvYPTUyVdScFRixmn+9HR1gTt7aZwuFVWmC5vb0SIcCfsU5glA0VLnf@vger.kernel.org, AJvYcCXYpgsIizN3ho/nMNPqdTsH77SX3hPyjyh9mhozNqukSdrKMnMS42ujT4y8dC9C5LknmQtF7XwyRJ5kD3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4p80qHki+YO3m9pkK2Xh9WpMwCCWkkKdgn3/lu99NpNffRDQM
	eptmewEYNRcdOfJLqSmS19Ito/d2vaxJhx72AKSlf74QOzxVSIAhV3pXoH53+MADvYz95I32uey
	c3RD/5Jen9RGXHKvZuTx6crJnXiU=
X-Gm-Gg: ASbGncufmu47MPJrSdEXCE3XeAfxSxGtU/Bk9ZaDEj7APEwR9YVgI4cez94mArKF0zQ
	ZvAJh3B2nM/sZ8FASIqa9qbTNaaT8ty0vmza63hLoqt6d/ngt9osH2N0SZhG8WpyUHeGCggAsK2
	n2Sj8khQe5p3s3FFsp/nRU55w=
X-Google-Smtp-Source: AGHT+IGdNk5UR87B8PpEmRJSVi6PRbL/kORbpEKUVSpHO19MK5472PPPwgwfqUCDAfAYarf01/5fOrDCr77YnHOIQfk=
X-Received: by 2002:a2e:bccc:0:b0:30b:b956:53c2 with SMTP id
 38308e7fff4ca-30f0bf1ead4mr52687101fa.11.1744125634762; Tue, 08 Apr 2025
 08:20:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <81d6c67d-4324-41ad-8d8d-dee239e1b24c@redhat.com>
 <5ddf49e1-eea3-4a20-b6f2-fc365b821dea@web.de> <7aa5ceb8-6cf7-4f60-90bf-5a8ace49ecc6@nvidia.com>
In-Reply-To: <7aa5ceb8-6cf7-4f60-90bf-5a8ace49ecc6@nvidia.com>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Tue, 8 Apr 2025 23:20:24 +0800
X-Gm-Features: ATxdqUHfRdfOzRWCV21Nr06J0vTVTCtxhC1HWL_HtWvHHFAg5ZnZBbL2V3-eZbs
Message-ID: <CAEnQdOpKmQSH+CZFgqpfXBDpcntgjusw3-GEGrnLmgmUG9Fhmw@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5: Fix null-ptr-deref in mlx5_create_inner_ttc_table()
To: Mark Bloch <mbloch@nvidia.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, Paolo Abeni <pabeni@redhat.com>, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Amir Tzin <amirtz@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Aya Levin <ayal@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the review. This check will be kept, and I'll follow Paolo's
suggestion about adding a blank line before the return statements in the v2=
.


Mark Bloch <mbloch@nvidia.com> =E4=BA=8E2025=E5=B9=B44=E6=9C=888=E6=97=A5=
=E5=91=A8=E4=BA=8C 23:01=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 08/04/2025 15:25, Markus Elfring wrote:
> > =E2=80=A6
> >>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
> >>> @@ -655,6 +655,8 @@ struct mlx5_ttc_table *mlx5_create_inner_ttc_tabl=
e(struct mlx5_core_dev *dev,
> >>>     }
> >>>
> >>>     ns =3D mlx5_get_flow_namespace(dev, params->ns_type);
> >>> +   if (!ns)
> >>> +           return ERR_PTR(-EOPNOTSUPP);
> >>
> >> I suspect the ns_type the caller always sets a valid 'ns_type', so the
> >> NULL ptr is not really possible here.
> >
> > Is there a need to mark such a check result as =E2=80=9Cunlikely=E2=80=
=9D?
> >
>
> Please don't. I'm fine with simply adding the check, as
> Paolo suggested. When TTC was originally introduced, its
> functionality was more limited, and reaching this point in the driver
> meant we could be certain the namespace existed. Now that TTC has
> become more advanced, adding this check makes sense and I'm okay with
> it.
>
> Mark
>
> > Regards,
> > Markus
> >
>

