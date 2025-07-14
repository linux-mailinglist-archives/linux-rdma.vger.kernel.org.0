Return-Path: <linux-rdma+bounces-12148-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AD8B045F3
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 18:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3DFA1A61EB5
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 16:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B26025DB12;
	Mon, 14 Jul 2025 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="D8boCOhv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6D01D54EE
	for <linux-rdma@vger.kernel.org>; Mon, 14 Jul 2025 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752512104; cv=none; b=qfE7uqLOZ5wxN21LnZrwkNBzJow6/Z7JNntIz/vPGvHQ05Kt3VnScTbY8OHY9on2PPyc8KLIJlCZWj3d3IpbjcB7qQYgGG8rTni1UCJCXFC4ndVYU0xsEnyRBTEc0/SrSxo1k89PZprU6+DIPBprM5As6UAYt4q+u1NZKk4ELqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752512104; c=relaxed/simple;
	bh=t9VlKP6vaBo0y1egs/Tf015vXPI2S/h/yinozXbhTas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZPdx4kCn+RFiNu+OCUi5YkQRAsHLIc4ArsOkw/VkwuPAJOVyc09M4x05jeqKQ/99ma6b41lQBunbRRJX6nPTus88owvBgMSB2UO7NoXGoToZvdQzMW7QPDLm+hJ95eKomGUj7+wIuZuwybtf4wcZMfTD/92eNoSlch45h3DdFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=D8boCOhv; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55a10c74f31so1550456e87.1
        for <linux-rdma@vger.kernel.org>; Mon, 14 Jul 2025 09:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1752512100; x=1753116900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9VlKP6vaBo0y1egs/Tf015vXPI2S/h/yinozXbhTas=;
        b=D8boCOhv95KgMn9F/T1WYvEOEoyr7gi37GYUlt3wpoIbOTlHWBjHOx6YtRA/r4DYVt
         cQES6qBQHewAVoIvQ6JLZILiPVPYnghi5F53lD0VpIyWfArhB7ITMVaXzBfvldfsBmB3
         km+ssLhg74/DglLGSrf2zzeCyaPupPIIt1GVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752512100; x=1753116900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9VlKP6vaBo0y1egs/Tf015vXPI2S/h/yinozXbhTas=;
        b=ap9pozCpE1j3Lh0UKdwxCNWF+hk8r2q2D/3beWp+xBxyAMM2rvpN8vRAlaW02su0N9
         0AZFrFbgokH59uvUIUomPLUJGPjJFotiQjqVZBZ+eBAtiwv57aejFG6dxtsPGEkzMpke
         UmX4g+JOtCzHS1iCP2bQ9kZnbb3W7ReS/q//mGTRGIx66TUm9WlLX2De3O123UdsmpLQ
         02x51Z6aAbqKEDTmy6w3EKk5BNCK1lIStf0gQoFiYonXEpHFlBrUl8fWK4Ri/FaWKBNE
         uDV4i3XNRgoeAW5ouwc+VLhYAlXsF1IRJZLvmuIvEg6L9mZg+352G/mxA8yxC90eaWJf
         Wsdw==
X-Forwarded-Encrypted: i=1; AJvYcCWgWBRDMreqbO+7t/PCz7VvqmBNOXysVVz+UQUS7bCpMEDbsaYM06i0DUklhE+XH/r+nOQmkve7TnJs@vger.kernel.org
X-Gm-Message-State: AOJu0YwkHF4idAE2/HyL6xmHUN95FEzeE78vseMWFp6u7SCe/FwcUSwH
	lFzA9tgSJdTmXnyQMpzYlk7jCscYqYlKvY9/GTmvDxgznYvQOjNI/DlzuuG77NXKKARD3+1AeWp
	A5a5/mnkDRS4hBcBMkhjlhdb0cnQizUZTvUSFVUQqHA==
X-Gm-Gg: ASbGncsZa8JOERU2/dN+mwaAhAzFoGzN22rJkxmgE/HJ/MNRiDPAXhhcSxLx0Jiu3Yr
	RUm3XKzoawEt3MxN00bb/l972pW6jl6GTXTnNcYdhDXWAM/2bEw6j/+epG/GfedIrgwOT3LfoiX
	eojejRkk/icbroD/x3VBiJCoL6x3f1ejO6q8w/G70Owz/F5BTychA92r6GEtoiDJIzlOTz0rpEC
	WeIpzHN
X-Google-Smtp-Source: AGHT+IETjaot0zn+ejmnfEaKpFQd11lM9ObDjgu2PVwkZ/8t3mJZJV1fZN2j2dHgp/jFEKQCDiyYynjyhCYdahfLAK8=
X-Received: by 2002:a05:6512:33d6:b0:554:f74b:78ae with SMTP id
 2adb3069b0e04-55a0462c4c8mr4068938e87.31.1752512100405; Mon, 14 Jul 2025
 09:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710182629.78456-2-cpaasch@openai.com> <3661dbe1-2a17-413b-8353-af12f4f37038@nvidia.com>
In-Reply-To: <3661dbe1-2a17-413b-8353-af12f4f37038@nvidia.com>
From: Christoph Paasch <cpaasch@openai.com>
Date: Mon, 14 Jul 2025 09:54:47 -0700
X-Gm-Features: Ac12FXz9Xi2hfuigMg1upII8txMl-tEKqa8Fjx9T3rGgpncQ_8ik_cwMT1iHsmw
Message-ID: <CADg4-L9EWE2ch5j5KqJk+hwC5X6yPxAERbjiPuLN+ApADHD6qg@mail.gmail.com>
Subject: Re: [PATCH net] net/mlx5: Correctly set gso_size when LRO is used
To: Gal Pressman <gal@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Amir Vadai <amirv@mellanox.com>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 1:24=E2=80=AFAM Gal Pressman <gal@nvidia.com> wrote=
:
>
> Hi Christoph,
>
> On 10/07/2025 21:26, christoph.paasch@gmail.com wrote:
> > From: Christoph Paasch <cpaasch@openai.com>
> >
> > gso_size is expected by the networking stack to be the size of the
> > payload (thus, not including ethernet/IP/TCP-headers). However, cqe_bcn=
t
> > is the full sized frame (including the headers). Dividing cqe_bcnt by
> > lro_num_seg will then give incorrect results.
> >
> > For example, running a bpftrace higher up in the TCP-stack
> > (tcp_event_data_recv), we commonly have gso_size set to 1450 or 1451 ev=
en
> > though in reality the payload was only 1448 bytes.
> Other than introspecting the wrong gso_size value, is there a functional
> breakage that can be observed?

I wouldn't call it "functional breakage", but definitely unintended
consequences / lower perf :
- In tcp_measure_rcv_mss() len will be for example 1450, but. rcv_mss
will be 1448 (because tp->advmss is 1448). Thus, we will always
recompute scaling_ratio each time an LRO-packet is received.
- In tcp_gro_receive, it will interfere with the decision whether or
not to flush and thus potentially result in less gro'ed packets.


Christoph

