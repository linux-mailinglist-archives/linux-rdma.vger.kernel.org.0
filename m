Return-Path: <linux-rdma+bounces-5790-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A139BE5E5
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 12:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769441C22BC6
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 11:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E36A1DE8B3;
	Wed,  6 Nov 2024 11:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czLTu5ek"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003F01DA61B;
	Wed,  6 Nov 2024 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730893779; cv=none; b=qWtKNf1IiAj1RArZfF3LGkStUjFpBhMwByzUw1wXUUCd/cINukh47D6AthlQ8YJYKXSALY5TBOHMYEt0XykQH/0E60armeL1A0WlcrIGRqu3tTncNtYCM7/yIVgOJS7/Z/2hLLMgQkiBWcuPTSBz8YdOEVDUAGeoFq9y676+qrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730893779; c=relaxed/simple;
	bh=WjqtbDpac/0/LCvJNk6uxCr2/EhL9jwSKroTBn7R87w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shsCHODkZG5o2vlAurMBD6MAJ2fg6/VfLzZ64matOy2WR9MLgkxGXdHW5PK3OVYenRcCG9nDnHGcrh0ec1PtJWKSPc/o89FIHIBvjWbgkAZix/z+UcHK/c51pMYXbBVbIihICxgcj7sinGn+NlJ98VgKbkT7K0g0CU34QZNFnPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czLTu5ek; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b1511697a5so455211485a.2;
        Wed, 06 Nov 2024 03:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730893777; x=1731498577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjqtbDpac/0/LCvJNk6uxCr2/EhL9jwSKroTBn7R87w=;
        b=czLTu5ekI//IiZMwOmJz3AZIkHpQqMHEAWsO1kWvpNsiwj3Hva/thQT6ZUEGZkMDzV
         EjKFGz/gvcGU+wTiFO6xt99S04f2FADrBDEFRCFbCc0DJAT7WudMJBIiulS8t83KHycN
         gC01hLanRSlYvFmJfwuGsRlUz6vvS9cGcS0OEBzWkm9KHi8+nJJIoeGsW5ABfwwF0rSh
         nqe+YWb6fwFOAfo+r6s+5ks4/wJdEgJQdNONpH1EMdCg3tBWwP7+SH57HRGqWqqkGIUR
         6LIO3223JeB9DPCRYnxXitc1awtrTEfeuB0WedcmHsCSPw2E40XGw2JirhtQlhpdv8XN
         AXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730893777; x=1731498577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjqtbDpac/0/LCvJNk6uxCr2/EhL9jwSKroTBn7R87w=;
        b=DRJq9h4cZhj+/Odz5Vo0d9ilJVyzJDbi8DjDlHOrw8SVqe/GTy41m30+Pwff0MQuVv
         z6jwZx4lAVVspj9ognEJzA5bg5OOlutCrkZBGk+ADzpkcGX82qMWIDF1SYVGtFN8BsdK
         KHoZ8mbv80+G+zXD7TS5UZgAcSl80MZVe3SymaoyeRpnL3Y7yoYqT3lWdQtlOnzawDKT
         r3vN5y+OZ45WSekRJd63uXEcHyKbS1kfZRbYMJh2KALuV6P6rBaY3/dkrCNUDytaDYOb
         WX/kFQpGVVODG93Qt5AY/igV3DWYglAezf7RS480xQ6EvrtwHhYm3jzbp+4oO5NQFqeB
         WYdw==
X-Forwarded-Encrypted: i=1; AJvYcCUzquSx910xVzb0JRZiglMhSq8PS7pOi+Ws1mCbUM3rvnwRHZXK0tmCcAGZWNY+zj5UHV1fbxE+mSqI@vger.kernel.org, AJvYcCWyOZml/32JnboW5Rm6wqH9A3VUk6SUluLxcQMBZtpa5dysbwOInEzRTNbFdnkO7duvKOYTb2DS@vger.kernel.org
X-Gm-Message-State: AOJu0YxWjMGiuHpYlI87P5VQiIfqDvllD4kZaDLJY2Kcyq2mOL0t2DWY
	6Lks1eXripUs6D0le272Ts4nNQ1tLMDnDXZKgUq/lnzMGdboMMupfFFKV8ZewFjUkRxyGXhRIo4
	V+D1pyN+PGwDWcuQcdQ+h6cu6yLg=
X-Google-Smtp-Source: AGHT+IG9gcRN7JT83hHx7X7dn1Y6alNyOvua5X/keKaErem4BBIuW76vC3hsuzSVm4dm2QaIbOUCjNNTrapwxTmRaq4=
X-Received: by 2002:a05:6214:2b8f:b0:6d1:726d:c903 with SMTP id
 6a1803df08f44-6d185706e43mr497329776d6.29.1730893776982; Wed, 06 Nov 2024
 03:49:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106064015.4118-1-laoar.shao@gmail.com> <b3c6601b-9108-49cb-a090-247d2d56e64b@gmail.com>
In-Reply-To: <b3c6601b-9108-49cb-a090-247d2d56e64b@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 6 Nov 2024 19:49:00 +0800
Message-ID: <CALOAHbDPbwH7vqV2_NAm=_YnN2KnmVLOe7avWOYG+Rynd295Vg@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5e: Report rx_discards_phy via rx_missed_errors
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 5:56=E2=80=AFPM Tariq Toukan <ttoukan.linux@gmail.co=
m> wrote:
>
>
>
> On 06/11/2024 8:40, Yafang Shao wrote:
> > We observed a high number of rx_discards_phy events on some servers whe=
n
> > running `ethtool -S`. However, this important counter is not currently
> > reflected in the /proc/net/dev statistics file, making it challenging t=
o
> > monitor effectively.
> >
> > Since rx_missed_errors represents packets dropped due to buffer exhaust=
ion,
> > it makes sense to include rx_discards_phy in this counter to enhance
> > monitoring visibility. This change will help administrators track these
> > events more effectively through standard interfaces.
> >
>
> Hi,
>
> Thanks for your patch.
>
> It's a matter of interpretation...
> The documentation in
> Documentation/ABI/testing/sysfs-class-net-statistics refers to the
> driver for the exact meaning.
>
> rx_discards_phy counts packet drops due to exhaustion of the physical
> port memory (not in the host), this happen way before steering the
> packet to any receive queue.
> Today, rx_missed_errors counts SW/host memory buffer exhaustion of the
> receive queues.
> I don't think that rx_missed_errors should mix both.

Thanks for your detailed explanation.

>
> Maybe some other counter can be used for rx_discards_phy, like
> rx_fifo_errors?

It appears that rx_fifo_errors is a more appropriate counter for this purpo=
se.
I will submit a v2. Thanks for your suggestion.

--=20
Regards
Yafang

