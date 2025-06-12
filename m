Return-Path: <linux-rdma+bounces-11229-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02525AD66F3
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 06:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73C41BC00D9
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 04:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DAA1624EA;
	Thu, 12 Jun 2025 04:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dxKpNa9H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B500B125B2
	for <linux-rdma@vger.kernel.org>; Thu, 12 Jun 2025 04:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749703983; cv=none; b=qFquzNa4ZoqZzVjOY2Sb6Owwq2+0DQHWZ4FQ0AP9ZgzVb39jjcy4pED30SZSXcYc4orR68/A4fYTXEW42fhLZCVDSdNSRnwTT1WnINC0uIpnXTOUlyidLiDT18phVsXKhYjWlw5BY1UzhkMNQLNzzBTwHHE0vx00FU4RNzN7EJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749703983; c=relaxed/simple;
	bh=JN7PESSUpb2dkcTr3UklwuIC/3db+uAVTehxCFYg+YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWDZfyndQ+uId0GtH/ilKfIDVP9qiXt2AnbSmadAqkKlsRSRtKhUKaF52vfW7z3gPgqnHhvvNQC8nq9VTzwTtSH/p2v+6AAIcX0o5zR3HGulbdgdsKP2DMwi9qmMiNaxrbLMqbNvFbXjvoD2D7aBgjMurJ3HyLuVeYcuLrb+5rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dxKpNa9H; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-235ca5eba8cso96335ad.0
        for <linux-rdma@vger.kernel.org>; Wed, 11 Jun 2025 21:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749703981; x=1750308781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JN7PESSUpb2dkcTr3UklwuIC/3db+uAVTehxCFYg+YA=;
        b=dxKpNa9H18qiZ6tvNSAz0QyFo/O0CYgjxzrbWCG8vcNHgpxje6TEUVMylZtMEbpuJN
         Q27VPEthzqWLeaVKfUbWmmffwHaTYNfHI9gtXgHdr6VxxSnOAhbTEq/rB70k9gITnHmH
         ktWZ6oRiYsJwCW/MMRGTreFeKDe7sYFBYgvTaEldOOOiM2DlTP7P5sWrkTMl6wVRx8Mr
         0oW2IvVNshJ90bBbGvsI5VgIEtmO7LmMsWiqA2W+RorZB2+0CMj8WnNjRX8wzFAKj5sS
         Bs7shYT7j9uzQ8dl/flyPtrkdwPuv74pDUMObzgOEclhbPRfdsP0Td4bJwNEZk+l7Z0S
         mIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749703981; x=1750308781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JN7PESSUpb2dkcTr3UklwuIC/3db+uAVTehxCFYg+YA=;
        b=OMI/fGhP4W5Ds9UOqf1PxzBx7yPKafZXKN4rhb8nWyoArBcBBHrL4EXvUI/kIQO7zS
         g5ikcn0b66PmJXZH7rmlk+kPrN/+W8GukOCI18JatAj2cTR+Fx/NelcCkGxQaN+LDFhB
         xbEt8wFVxXT5VVxs6ykxqcoryJyHYMh7yN/vd3VVJ/Mn/m/eIlQDcIsO8VuxMGFhWhjC
         TBe7f3mXEK/e34zIH0S44eQl1KNTUD/S2Wx9YKQFIyxXyOrYChS0Xyq9buRKcWYS6jsD
         sQ4hFj5ZjYaHZhpdDIiFkdTyAbMqxzs+XgHZ1KD4n/8nenxR3na0rCtlO7EK092IDCpO
         SOLA==
X-Forwarded-Encrypted: i=1; AJvYcCVFYjSn8xmHepZkO0D/c6tqdxzu9nNx0djG8MBhroPxJjndSlM3LKNgsmt/A7xeSShjACR3feKfxPCd@vger.kernel.org
X-Gm-Message-State: AOJu0YzPaZ3K+Lmsayj4NBOuIjDeiusvdnb9K1R5ME3nUYKRK6RLj1iH
	sB1WCqq7DQmJYrAoKFXkD1QDRCwWab0tXO9P0Tf9Q3nH/rz+wjh+eHcQ8eLk/n2b+pxBHKUrH8G
	ZjToZAh4VaSzoveEgccSe2nKEJZ7YHx2groUtQYUH
X-Gm-Gg: ASbGncu8FpyeofRqb7J0mCn13IPx44vMylyQ+FMLVdMETl3qoh4u4v3wnnOZLJ4j1wj
	ZvFKpCcKBs2t1aE45f8n08DC72++Gmy8Cr/DsBx6//yZBseHp3SWdE/a6stom+MH9/zaxOyy7ZN
	kALmx82hVDicjsqtCNs1v8fyWLmQiCKIzNC/LzdZErJ1f+
X-Google-Smtp-Source: AGHT+IF9sI2+TSVjeDsyCsMhNK2tYq652eey2qbdj9oGkvAU4h9hMqqw9fQg0pUIUw6GrHibgaGuCKYfworr/47Spj4=
X-Received: by 2002:a17:902:f54b:b0:231:ddc9:7b82 with SMTP id
 d9443c01a7336-2364eb2b4ebmr978315ad.13.1749703980736; Wed, 11 Jun 2025
 21:53:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610150950.1094376-1-mbloch@nvidia.com> <20250610150950.1094376-2-mbloch@nvidia.com>
In-Reply-To: <20250610150950.1094376-2-mbloch@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 11 Jun 2025 21:52:47 -0700
X-Gm-Features: AX0GCFvzBtcSK4oFAp7AxIqQXQSZWU21N-dciM4Bw9ZhMgTYOZ3S9uS4MIxcR6Y
Message-ID: <CAHS8izOzZnNRbBvMohGzB2rxhuLun8ZcPKg38Z1TbXo3stqZew@mail.gmail.com>
Subject: Re: [PATCH net-next v4 01/11] net: Allow const args for of page_to_netmem()
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com, gal@nvidia.com, 
	leonro@nvidia.com, tariqt@nvidia.com, Leon Romanovsky <leon@kernel.org>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 8:15=E2=80=AFAM Mark Bloch <mbloch@nvidia.com> wrot=
e:
>
> From: Dragos Tatulea <dtatulea@nvidia.com>
>
> This allows calling page_to_netmem() with a const page * argument.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>

This is slightly better, it returns a const netmem_ref if const struct page=
:

https://lore.kernel.org/netdev/20250609043225.77229-6-byungchul@sk.com/

It's probably too much of a hassle to block your series until
Byungchul's change to this helper goes in for you, so this seems fine
to me in the interim.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

