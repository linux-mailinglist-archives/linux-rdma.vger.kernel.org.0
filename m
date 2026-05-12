Return-Path: <linux-rdma+bounces-20504-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHisCSJXA2qh4wEAu9opvQ
	(envelope-from <linux-rdma+bounces-20504-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 18:36:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D075B524D83
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 18:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 165F530A642E
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 16:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEAB3D0BEF;
	Tue, 12 May 2026 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtX4F109"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8583CF94E
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778603470; cv=pass; b=VqcjclI5ST0GjYq+3XL4rp1OSPgpOjiZVlfxqiOT/DBgHqkLDfZUVSOkBBq6LKR9UtswVXnwK3VDF90q3iKlhQhn0DXCT90k7a7bvQwv2EGOdkKPmuJ45lGdluTAbG0IfqSUFQ4rgC+oDRF+RUnACgFR44MtaLb5d8k3VVV6yA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778603470; c=relaxed/simple;
	bh=KxbNz6KofZwplC6xddwMYtDl8wBQ5ksp1r4oiCLjhbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0Raq57ErEfouomlorYCSGm3PYjhm400znpch1kiBCD/fKlOgohPUPxVcL8gWIgCqRJD7sSETY9XdR2qzrhzPvYnX/e4KaX7eByNlQxtRCMCe6mPgwpQi55a1ipGT0tf3kliTTxixkIDD8hqGvL3Ndp7CZe4B1w5r7lr1ZeKOFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtX4F109; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7b4ee3a88e1so58896247b3.1
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 09:31:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778603467; cv=none;
        d=google.com; s=arc-20240605;
        b=F1MfJ7lxy3BjUG/fPUeDgSCCxO0JlxVIaRlisKAUOfydS0Kv5hDra64v9naNm2NRgO
         Z0ueFaNazmd/4vyhaOE21rlrkmlzWdtLfUyrTb/BWMKgXDzfmLSTWEmD5dJOTOpygBVv
         Rgz7ALOBQxTKzSsh3fCxjH2/Zl1vSoMZbbH2xFNpJy1M+FoTfxAZn7excZgDiwYA4g6R
         pg2u+IKCK1vbrTm/BfDU9N4ZkFENrR8zeKIupEyjyAAI7teMRGloilDUClNRzTUdWDyj
         JzM3jkGLz7gGL2Mewe4rGSIvUD1li+ts/8RHDZSnBO6Ram7Fo+4n/NjwV4+QTiHzP19S
         kpOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=C1AfrbvRUgp18Ab7cnHdWQ5A8b69jjesb+Ro7fndglo=;
        fh=m2FoEV9xZX/2zNZ8BidYb3ksl0OcB8+u5Dd79MbuR/M=;
        b=cyVmB/AsuxDLfARlqJil6TcSby9QeWFLk2RALyB4mUXiCny287oqMNnHZujvw99FCM
         g0NrX8XRk7o+bBUrWRC5ZGnuYq5k2WVBgoFRcQuBMOk0x+frhxqUIYOzJ6GWYE0mqegN
         vAiX0Hmy77t617PypDQ1mhAlLmowjyFTYSdFh/XsHadkpvb3y2IIe/9pey3GIp5sUgiZ
         7VOB3jHpxBe0z4xG9K05WYIMjoqg4ZL4kmWQP8x7EUHV6CQZs+7OTB6ZlwiqCYXNrYrL
         g8trXfEntjRXJuQvL3cPXO6YIDSE7mQRNb3+AvybUSdHxaR5fAmAwIFGo64yXkv4bC/C
         MS/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778603467; x=1779208267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C1AfrbvRUgp18Ab7cnHdWQ5A8b69jjesb+Ro7fndglo=;
        b=DtX4F109NAIvtCxbiu+RVbUwe794jH8DEbm28hqsVVUFSJqsh3DUjZ20RRgOmNg+tz
         WZb7rPRZahtLObROKgD107KkE07uR6QVS8sDUrD4uD4dyB8Ywq6EX2RixGSlHI/n+56w
         kQYaa2+L53VZg0YlXlrWxvF2MDUYfSkTpiz6KJlAa0RErIDb9jWxdM3okwPL4pwk6uOR
         budZOwl7Wm+yapwb0+76fW/1Dx5+IHNtOmJDY/3FLvQ04/XlUe9KRXc0G3u7rci3Dql4
         lfZKg/5cOkGviQj8Y9XnbHiW+5t9Q9vHT+Tt77A7V1FUl6aU1JPYjLEct9FXlB8En4iw
         +24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778603467; x=1779208267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1AfrbvRUgp18Ab7cnHdWQ5A8b69jjesb+Ro7fndglo=;
        b=R6KbiJlKYcV7wGIs3W89HeCkUCcH7EBYtRciVZo195uekYzdbsLyNk+BnDyQOpocwJ
         ZX9x30VfB/y4JKXoW/Lb5OMuHocGLn0InKZZ9+E988iSXyinw0N7kp0KXkxunb4iQf0d
         yKOUShVXtzrJ3laSkuCGvHCeDpxxrNLHAxP2H2QtMM/8HV15fsrKUx4++gQAPw2NOV5w
         STSGxAJ9BqhQoq6bKmK8FVRd8Js6QK5w1ur/FYQGtjo397fI2sreEOk9EvpdKj3yEk7Z
         q95vJx9ciOv19Vf8BqMWjMDwr04m/HFvMtHmnmURSSVLhquyGuftuyP9ZZY+5HpvbBp0
         +8Ng==
X-Forwarded-Encrypted: i=1; AFNElJ9O9A3/lFtmtLBsfy4RZWia1tP+ZlGIy0U2cWvUE31UtByFmI5uU86Cznh8IJxEoL8Eixy3/9YSPe3X@vger.kernel.org
X-Gm-Message-State: AOJu0YyMCtAQg9P18UGpgY+id9nuWC4X2TyUJWR8wxh45RQTe89egaE7
	GaO9mQESKC1EKRKYdqjqFutXKF52aClMr0whRfkpMZW/OdVBif1XxUDJzuXcDgH/uyAY3nckYHB
	JDcaUkg9UAGYi/O1Lwm3vzE9wn0KRCcQ=
X-Gm-Gg: Acq92OF6EkraJjhTT5sWjJQIP7DoD0tiRVCzby/7FkooAGDRTmMaO0weiukEdz2inBm
	I8W9u959ZiXnThmt7EjXqkLjxNfGr//SMld7ixXccImqzW9NFpMw7TQtb9UV35VNFq6GRZ6gRAZ
	JdB7ySyAYASEk1pl8YiUrtk455biHlbiL5TeOhstutKLxkyIgcB9+1uKQDNOIWibcDbhxBw+5qQ
	Xi117+HG0T3nq0WHkS4Yn1TRFYffuKtCrytSdFufVs8vyEoIoEJtk/sFoS08BK4JLfCJJimHNGL
	G5gBcIZ8
X-Received: by 2002:a05:690c:c4d3:b0:7bd:6114:4002 with SMTP id
 00721157ae682-7bdf5efc9a4mr317364907b3.40.1778603465678; Tue, 12 May 2026
 09:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507095330.318892-1-tariqt@nvidia.com> <20260507095330.318892-3-tariqt@nvidia.com>
 <CAMB2axOFQN2f=veYgeJs+4tbZmb9PuNHk03TH_bmE8UL_REd7w@mail.gmail.com>
 <b1d3f9bc-a5d7-4236-8bda-49e6327ee533@nvidia.com> <CAMB2axPNhveQaDPs-ttu4uFcpvAfJCdzJ3d05HWQf4+p7uVUsg@mail.gmail.com>
 <70d0b319-178f-4233-b0da-9618489a1dd6@nvidia.com> <CAMB2axPdqBUORn7Qy35Xccqbn+8aArZ-weegZyz=j0STh+iPNA@mail.gmail.com>
 <6b7998e7-b2c1-4650-9564-679d647146cf@nvidia.com> <ef926d49-81d6-4d26-8d74-440d4a6bb8b1@nvidia.com>
 <CAMB2axN6USwsGaUQWkL52G=9V=kSe2La_gE-ppOFLWbPCnaVKQ@mail.gmail.com> <47630ed4-3028-4716-816e-d4f803423b37@nvidia.com>
In-Reply-To: <47630ed4-3028-4716-816e-d4f803423b37@nvidia.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 12 May 2026 18:30:54 +0200
X-Gm-Features: AVHnY4Iek3R7CeWvC2rdxFfQ-Vfu4nQJysvyR2_rH_vMG7nCcg0y19mJ0XmkmAg
Message-ID: <CAMB2axMOWSsYGyuXOnCQUrpCTGJa_Yy5mKOxErX7N2x3BTLKbg@mail.gmail.com>
Subject: Re: [PATCH net-next V6 2/3] net/mlx5e: Avoid copying payload to the
 skb's linear part
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Christoph Paasch <cpaasch@openai.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D075B524D83
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20504-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[nvidia.com,openai.com,google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,vger.kernel.org,iogearbox.net,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Action: no action

> That would work, but maybe with one less conditional:
>
> if (!len)
>         __pskb_pull_tail(skb, min(headlen, skb->data_len);
> else if (len < ETH_HLEN)
>         __pskb_pull_tail(skb, min(ETH_LEN - len, skb->data_len));
>
> Tariq suggested to make sure that we have an xdp selftest for this.
> Will take it as a follow-up after this series.
>

Sounds good. Make sense.

Thanks,
Amery

> Thanks,
> Dragos
>

