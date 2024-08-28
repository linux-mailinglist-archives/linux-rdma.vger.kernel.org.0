Return-Path: <linux-rdma+bounces-4613-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2351E962569
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 13:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31E2285AED
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 11:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6DA15C123;
	Wed, 28 Aug 2024 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="fDu+KDJ/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83A615A86D
	for <linux-rdma@vger.kernel.org>; Wed, 28 Aug 2024 11:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724842849; cv=none; b=t58X3FVRwAr+aOTtBLUN3pzkasrUB+V9kpdqVwLEZbWpj5oc7VXn2cFTgF7+PYFXi1/J9D+Ocpq41ypHk7wH/zuIstdL8ldNHcB+L2m/E1g1qlslVe1BLqyn1Pnsaw0F/J8DC+J3qWE2dTFgs19HDtIJnoHV/RmE2PiTqXycJjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724842849; c=relaxed/simple;
	bh=XqcUFoES6RxJ8lkvvsf71CqTICAtCWqu6BC65JiNSgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLknVHwTRHk8Hp2Sf7FsQ56p5P93vusX4Kxn0PyecrvsnOMh7FJ8yH5hhcsWfAah5iwSyRA3j0Bsmt86P/VTHrFMGjfV8f5OghxYYDlN+oImFv/PTgqZS/JdgSqhPYGOOtaVnmmzOhxZ+xsf+w2GWDk8kS4OmduNX74fBpDXJ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=fDu+KDJ/; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso66084931fa.2
        for <linux-rdma@vger.kernel.org>; Wed, 28 Aug 2024 04:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1724842845; x=1725447645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6Y3K7E5kkapBh+BKl3OgUST9P2GNR791zXfDbctIko=;
        b=fDu+KDJ/CJh7zu8YxBDYAN2tyfHeABpqfatQ3Iqbf/9ubsnnZMTKyR9djeIIvQhfI3
         t583mz30Ccu23dEUPPi7rzIpQHLuiy3CKZnTfgqriC1A4GK/nJDzCqyd8hAhry0LiNwC
         U15UQPU8Ieudgt73AKkBh6D1ZqgGh+ebkmWvinr/N98GUsRiHe9LcndewdLByXoLV/Yk
         z/tGVWuk08iEZN+w2B6IXLemUlM3i37UWCdjudu2M4G9+oEeMuPmvOqg22Y3UArz7EJx
         92Wl0dTJwSFv+Rqr/HlOsfRy05agjeKQ6+Hl80GGsZ8r0iAXALGymd2CQDYYDLknSxcB
         j7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724842845; x=1725447645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6Y3K7E5kkapBh+BKl3OgUST9P2GNR791zXfDbctIko=;
        b=h8Ntvj649e2FN+aTxShGB2H42BfwlCN8kNGzUKKnfOwkOWSkYN6iSm2PWz+U66oiQQ
         VlCcMdnYtKcgpxEy7xrUBM73ein7jzZQOe3Z5Adv0UFtm3xPtrE/HKqxttc49xXylQk1
         fn7VmnGi29g7Mq3EP/thKy82z4u0ZGeP15oHhxg6BWlXdIOyP1FTbfCPT8ymy6qLMK1e
         FIgfdivuvuI5/qjWTY9dLhUwQEndbyKakA6kFXSRzkE4w5auBqXbLgwsDc76oNy3IqWX
         Th+tgBNKa5FnjbMADo49uq4kQw4/MiiYkkva3XHqbECh7HfiCqqLQaCbzNJfTNjb8gRo
         JgpQ==
X-Gm-Message-State: AOJu0YyrcsYi0bdpleptZT82HxWT7WVZFALTx76WrEGmHrLWUDvmoGPR
	TvGwtPiFnufKXtdupGzltT9qLDAirdwhjNWXBE4fu1evc5Yu+1n0aJ8t9lWvvOkhAH9ZsmmCLKP
	TxsiCCA4t6G3/He4YDKTkLBIl+eHRjNUA+XWMJ62h69NMvDnUock=
X-Google-Smtp-Source: AGHT+IE2HuKH6EWU+uHv/8EgU4m541eKFU3pj4gxXt2w/zdgRq82niIhm6XE7orLJnh/1Z1ps1X8cmkA5tdQfu4HxAw=
X-Received: by 2002:a05:651c:211c:b0:2f0:1f06:2b43 with SMTP id
 38308e7fff4ca-2f561831e8emr12491071fa.41.1724842844104; Wed, 28 Aug 2024
 04:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821112217.41827-1-haris.iqbal@ionos.com>
In-Reply-To: <20240821112217.41827-1-haris.iqbal@ionos.com>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Wed, 28 Aug 2024 13:00:32 +0200
Message-ID: <CAJpMwyiqd765cSOe91BZw8KGVKprLc0bmJZJQHMPz4RkBSD+tA@mail.gmail.com>
Subject: Re: [PATCH v2 for-next 00/11] Misc patches for RTRS
To: linux-rdma@vger.kernel.org
Cc: leon@kernel.org, jgg@ziepe.ca, jinpu.wang@ionos.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 1:23=E2=80=AFPM Md Haris Iqbal <haris.iqbal@ionos.c=
om> wrote:
>
> Hi Jason, hi Leon,
>
> Please consider to include following changes to the next merge window.

Gentle ping.

>
> Changes in v2:
>         Dropped 2 patches as discussed.
>
> Grzegorz Prajsner (1):
>   RDMA/rtrs: register ib event handler
>
> Jack Wang (7):
>   RDMA/rtrs-clt: Fix need_inv setting in error case
>   RDMA/rtrs-clt: Rate limit errors in IO path
>   RDMA/rtrs: Reset hb_missed_cnt after receiving other traffic from peer
>   RDMA/rtrs-clt: Reuse need_inval from mr
>   RDMA/rtrs-clt: Print request type for errors
>   RDMA/rtrs-clt: Do local invalidate after write io completion
>   RDMA/rtrs-clt: Remove an extra space
>
> Md Haris Iqbal (3):
>   RDMA/rtrs: For HB error add additional clt/srv specific logging
>   RDMA/rtrs-clt: Reset cid to con_num - 1 to stay in bounds
>   RDMA/rtrs-srv: Avoid null pointer deref during path establishment
>
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 92 ++++++++++++++++----------
>  drivers/infiniband/ulp/rtrs/rtrs-clt.h |  3 +-
>  drivers/infiniband/ulp/rtrs/rtrs-pri.h |  2 +
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 51 +++++++++++++-
>  drivers/infiniband/ulp/rtrs/rtrs-srv.h |  2 +
>  5 files changed, 111 insertions(+), 39 deletions(-)
>
> --
> 2.25.1
>

