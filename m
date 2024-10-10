Return-Path: <linux-rdma+bounces-5348-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEA4997BCE
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 06:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53FA0281E87
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 04:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FDB19D8B4;
	Thu, 10 Oct 2024 04:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IlYkh6oO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA291922D5
	for <linux-rdma@vger.kernel.org>; Thu, 10 Oct 2024 04:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728534555; cv=none; b=DiL5hQH6qoViN1dPkS+KJmEvH/HNIdOQCE5rVqKYjFciliQ+Pi64HxMuR0D2tSlxgqL7TAZ0EziZG6w3rYrWLq5EFD80l3M+J/htk/0kBxz6sgjISczZQam9/knFYzCvqbMq0t7+onRo6RFrifY0fPSzKHlUJztQUWBR211VVmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728534555; c=relaxed/simple;
	bh=odgOio4giR3EY7zg7Wmr9RINTnp5bPztcZmC7W2NupA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4pJncPpXTTKNiQp5TKo1If6unHdk8eqSTmfHto/3yBolSPJ2hmIGWDdsex/RMrOd4ACfrMsgPK/Nvpld+CTDDzqiC+J/ab87uacS1LBhqz3PeX6nGtTekdjSr6tDwhwDVGXpNaNbLzmttnFwpMBqFVS2x5nCyNskmdNorl/qAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IlYkh6oO; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c918c067a1so485225a12.3
        for <linux-rdma@vger.kernel.org>; Wed, 09 Oct 2024 21:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728534552; x=1729139352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odgOio4giR3EY7zg7Wmr9RINTnp5bPztcZmC7W2NupA=;
        b=IlYkh6oOJawcEov4UK7OfrO/996Zpyf1C8f5uyC3up/wPtW9iE+Y0h4Zm1l3E6SPWW
         ql9VCtnDbVY1qlMzRlo3OJxyqvhx0zArb0kCwNpOQyfLFQLetMTbjXAOXrZOWtE3guZw
         GDB/m/HL8zaQcPPZp9kaWldbTk3DtPbDnyMkmxg6w2YViPqQ8mi4+ZoN1m6MUti9j1dM
         xt9U31mWjV5I+LO/0ppZ7sLVDg5Om3t46Q73uKZgTeLU/bC2l2C762ZHC5+PVOozysEe
         Z1d8OcIKFst+teivN/LqlURw63k8956a5COQY05mFb3BzGh59Miut1Jhj8HY56vsZgWd
         wmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728534552; x=1729139352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odgOio4giR3EY7zg7Wmr9RINTnp5bPztcZmC7W2NupA=;
        b=s8c73hxcmGwZn5i82ZcoQYtmj59QfZCi912JXIJakFGktdddrh2bV08i+NrGdLt9pD
         8KFRP3WddvHEkrYS4Kw/EMf67LrLopn62qhJMh3+AJ8dYSZrYYxorKZor+/lRDVd6oib
         sJVfT6fu0lTfU55DJ9N64IZtJb1tEGSbqb27zI0nIVjAsuX1v6SzL9xRw0HO5NlLx66d
         KlJfKNyqHSIHawymPmNbEC1iCkIgm6H2A5ZW8OJbroXuG4nvtHVjNNcClsuQ0N2QPdzK
         nbCndYDb7twcIeJ/RoTzOjo3qDSEHRbFEIk0hgabtE9OD2DsCwg+f4BME8LZbrjN6l2W
         UjTw==
X-Forwarded-Encrypted: i=1; AJvYcCV7mDxOkJgbRrlSBMQhyKH8EPn1YtT/zPsYknEs1SvMh3e0FjxUXjPn75xqzcuYwEyx0JFjpSRRjRls@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8LROUylvQhjBHEQGIM/13ykgz1BOZLcvII92exr0e0KgH1cPN
	64thgfqvmJgTdlyzDryDEjzsEjrw69uRNLbcXN1G7nAoJRVV9L/qb6GDMgk/Bmhttu5Zu9jgg6X
	+TqGws7obrQXyXE6A8RkPWCgHCIj87emEnCwf
X-Google-Smtp-Source: AGHT+IFHyMvsNEd/Vl9KXbFL9gbkKLFmwJsleqsVpThERipnXbNoTRKd9J7elFWVniswaR8hxHZc4V8Knk2hwIpqE3s=
X-Received: by 2002:a05:6402:50d4:b0:5c8:7c58:6588 with SMTP id
 4fb4d7f45d1cf-5c91d685530mr2921952a12.32.1728534551523; Wed, 09 Oct 2024
 21:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009005525.13651-1-jdamato@fastly.com> <20241009005525.13651-10-jdamato@fastly.com>
In-Reply-To: <20241009005525.13651-10-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 06:28:59 +0200
Message-ID: <CANn89i+187Yht9K-Vkg6j_qj9sFiK0jaGSxMDdYCAUZUtBgMOw@mail.gmail.com>
Subject: Re: [net-next v5 9/9] mlx4: Add support for persistent NAPI config to
 RX CQs
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com, 
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com, 
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com, 
	Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 2:56=E2=80=AFAM Joe Damato <jdamato@fastly.com> wrot=
e:
>
> Use netif_napi_add_config to assign persistent per-NAPI config when
> initializing RX CQ NAPIs.
>
> Presently, struct napi_config only has support for two fields used for
> RX, so there is no need to support them with TX CQs, yet.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---

nit: technically, the napi_defer_hard_irqs could benefit TX completions as =
well.

Reviewed-by: Eric Dumazet <edumazet@google.com>

