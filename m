Return-Path: <linux-rdma+bounces-11233-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA635AD6730
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 07:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0568C17559B
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 05:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7407A1DF974;
	Thu, 12 Jun 2025 05:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2+xx4lR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3881EA91
	for <linux-rdma@vger.kernel.org>; Thu, 12 Jun 2025 05:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749705470; cv=none; b=RXoLe3bYAdlD3f4k2bY543qAuQUkuvmLKlHAeTjVv5/XQM4Erq6QKSeOAIAh54eD3K9RK0v/k8hriMK/P4aPdUtK4ZqLUPi/aLBtspMBLSGWVHmQZTixX3+tBQmENGLdkSUTRyzDJrA1GuFbRs7UyDUJvcOhMZHq5IuK6w/KaeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749705470; c=relaxed/simple;
	bh=2SCdJ/+4doAXDA1dugfcerrihJYg32knCvs3SFTaAHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTlO07wFJcLgb3ztSCjFGxAzINaYXJsjvixe8WGuOhRJJ7dqyjSLPrjt7lFZwqMt35J+WAy5bLpIC7HCpGmDzMo41FnBAik/VyOOrlTE/Lz6L7Eyj//wEOD60oIjlr011Zm46u2evChLVY3i1CUOcPaqVyD/sFNdYh8fm/vc6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l2+xx4lR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2357c61cda7so63655ad.1
        for <linux-rdma@vger.kernel.org>; Wed, 11 Jun 2025 22:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749705468; x=1750310268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SCdJ/+4doAXDA1dugfcerrihJYg32knCvs3SFTaAHM=;
        b=l2+xx4lRk9VZdvj+XODaAdpfsmHoNTAQiuoBm+Vxve0ddmNB/2OTz8EJY4erV7FZGD
         6mhjNLpen8OIBrqasVtsOlcrBEVLpT/ZpMhjKJEZrINkvYjiRjvEKFcceRepBXWmUNEB
         kdpnArPcasSr1FwZG+zzD0Dp2hhxE3yzF9Gi4V1dRR9PwBuJRORakl5YBRPHWhPtz5bU
         /XBjGUoIuS+UdyiPkqG+8JolPkK8FQjKplfO1MMVLnJfJx7TtW9yTnBkt9bmFDlaXY/4
         szjqy6+2cZjkGPZ2rMDDgNYm4GVhYXJXKPpnIbPREaHqUiOgxlTy3OOjkd7NxYx9a5Z7
         o8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749705468; x=1750310268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2SCdJ/+4doAXDA1dugfcerrihJYg32knCvs3SFTaAHM=;
        b=T2VRS0C7nyaBDU6NtGWc99H4k3UeIk3wxmM0ONTzdE1UNBjuuBGUeEcFW8ZhCbRas6
         Eh5DIblAzHNEzPyaLKi7y/ENVPPHS1Ta6yP84UkLn2RFVFjMive20iJdVmhJobH67H1I
         wdQJiWBlHpz5aPPOA+oDtQaY7YKfWJOxHyyinc7r1xHyqZu1sUdlofaTt4WBdRqca5lj
         VW4Ks3uP+jmzNjQcR96KXSPej7ZCQm5uwbiduKTFoNUP72mcNkltzJLHTlm/TdvgugaO
         rAnflODZL/wZI63nXkcV7R28/Z0eDbVE91B3UzAjazzm6sIe+Flo4BP8hDzfCtjXtOAV
         wDfA==
X-Forwarded-Encrypted: i=1; AJvYcCVAAickXaGxWoP258k4/Jd4H8tHz/zv1G3Zrf3GNHyXSaRCWY4n54BzaqmIu8OFOcglLpmnCGCyAqnz@vger.kernel.org
X-Gm-Message-State: AOJu0YzsmoI9IMX1StqcC91HcA6f0fsJXU28O1kerbwzV/iaFWdBeL+S
	D400sRwtj88z+9iqp++4M/GPJlrVuhheM2xlUF+ZQCl1fvZq0uUb1pOf8/IqWfi95d50VaubVyH
	ug1ygRvLyDEI9OoSRW29RwxBWwYp7xE8netV3IDn2
X-Gm-Gg: ASbGncvctKTGZsmp3Mm3YF37v+qAny+QXi6+Xtffp7/TzSkMSWpet6uHLlB9PPmdPXS
	ck0va0VJQG83NTW4QH0h84P5hg+tQZn+Js4iaRU2KVXja9vF8ULeSmuODwtMiUrhbwN5sT6WfKK
	pXQ/ObzLjrN4UdZu3Vf1abOjQFYp1nKcPgvSDGNPUsygNK
X-Google-Smtp-Source: AGHT+IGYP9KzkXjDzsA4+41CLW5Waykb3HixIBnHVes8taLU5EpIH0GQEyzbO+4zVc94uZKbBXgXshRqTVavOIadoX8=
X-Received: by 2002:a17:902:d2c6:b0:231:d0ef:e8fb with SMTP id
 d9443c01a7336-2364dc4e3b8mr1774665ad.10.1749705467691; Wed, 11 Jun 2025
 22:17:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610150950.1094376-1-mbloch@nvidia.com> <20250610150950.1094376-12-mbloch@nvidia.com>
In-Reply-To: <20250610150950.1094376-12-mbloch@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 11 Jun 2025 22:17:34 -0700
X-Gm-Features: AX0GCFsQbpdJnxhJgwGMagCQgzHoP4omoeUSZWQdZ5DAkp2-7EHR6n8NXEpEZgY
Message-ID: <CAHS8izMOcAYzcseZqud5xj_3ibaWKBUqEARgJd65S0_Wqs6haw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 11/11] net/mlx5e: Add TX support for netmems
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com, gal@nvidia.com, 
	leonro@nvidia.com, tariqt@nvidia.com, Leon Romanovsky <leon@kernel.org>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 8:21=E2=80=AFAM Mark Bloch <mbloch@nvidia.com> wrot=
e:
>
> From: Dragos Tatulea <dtatulea@nvidia.com>
>
> Declare netmem TX support in netdev.
>
> As required, use the netmem aware dma unmapping APIs
> for unmapping netmems in tx completion path.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

