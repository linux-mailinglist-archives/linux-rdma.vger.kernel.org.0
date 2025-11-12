Return-Path: <linux-rdma+bounces-14454-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C018CC53A56
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 18:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC43850076F
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 16:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB09C343D84;
	Wed, 12 Nov 2025 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bU99rDK6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWAWroho"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1063341ADD
	for <linux-rdma@vger.kernel.org>; Wed, 12 Nov 2025 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965249; cv=none; b=KvQcUds9lvM45bOD4QugMYnCZFUfRw46060TntvXLm18aCTpeWv2ENclhw/6RgXUdXQ1ySKajnK4plpJ06WOqueyq4YXd78RkFgTvRLZTZeNY97e9tcrucV1af53JqtgxAowbIzO3K/qVGW31f6mTNKXq4Cf8gL6FSqkT0X3GGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965249; c=relaxed/simple;
	bh=d/E8bVn48ysm7hAvgZ4eePo49+HzJRuHc5TY0GjWRsU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TUbiWiJ91QbpkucyfS+2lkIC3cerKCeQn/KYuCMBOA1jGP3dUuCVAITeOCWybxJeeoe0maPM9RjVV9Oi+PYW0k79wSp5CtxnKrHUt30v8IbVjVMZkwiWnfV16zQ4/12liQk5P78SoE8nhrBJmRupqc4MoGdCvgHYIbssvBL8bzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bU99rDK6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWAWroho; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762965246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/E8bVn48ysm7hAvgZ4eePo49+HzJRuHc5TY0GjWRsU=;
	b=bU99rDK61gcYC25VLLlyFgauEijA2oueYjN1AD+DviVtUSt/vA3l3mHCurF+OAHUJb3jpu
	b6rVEMQQ9m7Opfbe+KjT85orD/vGjXeyc3wdKBmeQhMd9T1CW0NuYNzOrnvFMJiu0xqX6G
	Ier9F5FGs6jxgdtPYqCH69GfhVBwC6o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-uQB9JwP2Pr-FxUUpT3dKBw-1; Wed, 12 Nov 2025 11:34:03 -0500
X-MC-Unique: uQB9JwP2Pr-FxUUpT3dKBw-1
X-Mimecast-MFC-AGG-ID: uQB9JwP2Pr-FxUUpT3dKBw_1762965242
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b732e399c67so94873166b.1
        for <linux-rdma@vger.kernel.org>; Wed, 12 Nov 2025 08:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762965242; x=1763570042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/E8bVn48ysm7hAvgZ4eePo49+HzJRuHc5TY0GjWRsU=;
        b=BWAWrohoJ6sq3Auil0yuGGI+q/2TlOCJaHfC3rmn22h3d/z6UG4ZZ1BU9FHexSLama
         kBSBTW13k11QP6K0jIFaHqIVdBx6xH389RV383rmNs6+4fo4vcawU2JshdAKP50fw7qQ
         X4l+FXDd3D7CM/RH98RxLEP6LB6lvVXNwbvI6Q+ze6xhFxI59Q5X8E8zx3k9rbMoboun
         KYwkGzUXPTdZ191GjeW9IimWNKu24rv401j5/WOvwXL57v3tTXC3YSbr2cB2WYksXi3G
         TgYLMYWIvcYZiB/ALee/DDdvkUpV9ExwGGCxcepYOoayAA/LbNrC7zrTT90tCP/mburA
         QtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762965242; x=1763570042;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d/E8bVn48ysm7hAvgZ4eePo49+HzJRuHc5TY0GjWRsU=;
        b=TJd7tmH+pgsfmLjn+odHxtNGc4q1D88/mMO1/jsaleUwzNQi2j6kfzG9ckub/4mJ5J
         QR2xvwSAK3HdDfJyI7MyPemPZ0mB1M/4dXLOxryHgfn+vRlpu5gOv9trMzJYxS2rLcdI
         mn9CxT+u0fYQjei8SALI/bWj7Pm8/YiTF+YB2RsjY/zdU7u8mQ4KTRhSrhZpZCwI+LFj
         LDE13gSCV5LNv5g2psoXdtLQ/pCrF2bxyB3Lhj8UfEr3PPIGHcwk23IcWeZe4lH9jCOk
         U3QkzEmIhqOsTpGAfpIvpMG2dTujrlSviefWBHtH9bwz6Rt9z6KfvPvDVWD3S+dpMJr4
         VpAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWBynLVpsh1hdIcEq+RUa937jd665xexA3Pj3tiFEFVmsPhYNd7OFFEoyGfqxF4+IVnqQ3GSqEFdKw@vger.kernel.org
X-Gm-Message-State: AOJu0YzG93Z3TkaMoYP/W6g1PE+tZeOdOik7YYQOee1YOCG3XpAAq7iR
	O34H6BLbwbnr6osACIDrLSMLq62PPKRPNOkEt71p+YWxOhIPg9wyCcPlf7rWxc1WYQ/h/2ofRTB
	VEXhAn+0oxCPXFiETwdqaYKVXEyzsyh9ZBes45LNuD1GU38CpjNgjwT4lrY2hcP8=
X-Gm-Gg: ASbGncvNZehGeUByUHQusKC0GHUZIwwT1WHRbjdt8oDmT9oG+grP673sGe6dve/WQVw
	dEEyRWT2PhMGgDD6rBzhMspvRYlQ27vA7h9OtVp4PXsERDeXv1RombnhJtmo70V1Auud1tEd+37
	O5vxpQrCb4Y42lW890oiR2FSvx2PZyz7GwTvqk/N80QbGQWc/TGjepOhyk/Ut19qK1YmcWdCBt0
	eKyKlKlCBHTbG9G/7MavJE+sciug8Qsa84XwOdgeMS38r9QlSvvmOQoBLs7gGe5vl9zBHLoFH7o
	/AQwKpWeuCnl6lXIgcIiKRqoDF4jDLJwtMtfJ4lrdkqA5O1eGOYPOSEcxXhoAKq0qlsmLUvbZWI
	S20Q4aWrJaxM+xcvl7lOwUaKffQ==
X-Received: by 2002:a17:907:9707:b0:b6d:5df7:3490 with SMTP id a640c23a62f3a-b7331958ba2mr346272966b.1.1762965242192;
        Wed, 12 Nov 2025 08:34:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZm9pebiaIBZMLTLeGd2x+5ZnR+JDb8zNhfxlSlwTmdqUrroewBp8Rd3ZxS65aIC+OeC4oTg==
X-Received: by 2002:a17:907:9707:b0:b6d:5df7:3490 with SMTP id a640c23a62f3a-b7331958ba2mr346269066b.1.1762965241655;
        Wed, 12 Nov 2025 08:34:01 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b73456babd8sm13351966b.0.2025.11.12.08.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 08:34:01 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E4F5232974F; Wed, 12 Nov 2025 17:33:59 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>, Tariq Toukan
 <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Moshe Shemesh
 <moshe@nvidia.com>, William Tu <witu@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Alex Lazar
 <alazar@nvidia.com>
Subject: Re: [PATCH net-next 0/6] net/mlx5e: Speedup channel configuration
 operations
In-Reply-To: <89e33ec4-051d-4ca5-8fcd-f500362dee91@gmail.com>
References: <1762939749-1165658-1-git-send-email-tariqt@nvidia.com>
 <874iqzldvq.fsf@toke.dk> <89e33ec4-051d-4ca5-8fcd-f500362dee91@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 12 Nov 2025 17:33:59 +0100
Message-ID: <87ms4rjjm0.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tariq Toukan <ttoukan.linux@gmail.com> writes:

> On 12/11/2025 12:54, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Tariq Toukan <tariqt@nvidia.com> writes:
>>=20
>>> Hi,
>>>
>>> This series significantly improves the latency of channel configuration
>>> operations, like interface up (create channels), interface down (destroy
>>> channels), and channels reconfiguration (create new set, destroy old
>>> one).
>>=20
>> On the topic of improving ifup/ifdown times, I noticed at some point
>> that mlx5 will call synchronize_net() once for every queue when they are
>> deactivated (in mlx5e_deactivate_txqsq()). Have you considered changing
>> that to amortise the sync latency over the full interface bringdown? :)
>>=20
>> -Toke
>>=20
>>=20
>
> Correct!
> This can be improved and I actually have WIP patches for this, as I'm=20
> revisiting this code area recently.

Excellent! We ran into some issues with this a while back, so would be
great to see this improved.

-Toke


