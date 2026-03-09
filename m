Return-Path: <linux-rdma+bounces-17806-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOWoNFwSr2nJNQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17806-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 19:33:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D766923E9F3
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 19:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC464300C55A
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 18:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E3534752F;
	Mon,  9 Mar 2026 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OKmBdzXM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0444E32BF42
	for <linux-rdma@vger.kernel.org>; Mon,  9 Mar 2026 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773081173; cv=pass; b=Btwx/sUjE9Cz7a40K1RidKZUuvYdEsArN6zGOLyVVMY0DYtO0JPf8fmZPEcOCDDIsnnP4f5Ye546kdNEqgdY/lOXoannat2nqBwt0WkkFHIYqqiKmi1MKZ7Pwn4JeTMak1zS5Fg6skmk8RhM+7Zk2ohgHhi2IYo8P1YLaTZemLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773081173; c=relaxed/simple;
	bh=5pfbX7IgfKNQp2WRG7sxyMmlo2J+X5YrF7BKB81kNxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpPCw/dj3AfwuuRxEup4FMSxTFkTv1mBbdDnO2Y0m0HYGJqXLR7O6YCaC7LD60HeGpAWTuKb7fUrOt0P9xVQ4Re11o+BEDyE005y3lGQbNge9wFr7R/rhRAmZfFzzh5avqPpbWOaf1JezHwKjAsEv1/oH2nnQeVCPeIy+XEF+pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OKmBdzXM; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3599126be32so5008729a91.1
        for <linux-rdma@vger.kernel.org>; Mon, 09 Mar 2026 11:32:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773081171; cv=none;
        d=google.com; s=arc-20240605;
        b=e5yGNAGD1m6XOty3XoCHPBOtM0sCfvRoVg9mef+H3rCammqOIU2OUds46rI35PoKXn
         01e9QA1RKKq1NMeT/G358qAuskU4gNXN4nLY3vTSCiMbxZoVg28nf7FGB3XBPNNq6Lh+
         p4xxqvRw4XTJ+VunxMM01Kb+ayeN3H1vfdziwFnHuy8Nr6svx1IVt3tYiRelCfmaLs/G
         VuogiA4OqZBh7V7tIXiXt0C/ifLm6n0PSTxY2uASGGTiFkoLEAPGRM3T9E2BMjIydVUE
         xDz8OnVGh/iqXXVvbvmtZcra9P6ueO66pliMGyIKCkOtzxtL4WG2FL7jR9iQ1BKaAQT6
         5D4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5pfbX7IgfKNQp2WRG7sxyMmlo2J+X5YrF7BKB81kNxE=;
        fh=nT81rSwlpmSE8vKq3dBGGMEC+s1jaL/zGXucJ4L/XlA=;
        b=bFslJsvAIc9BpHAHuL0BDopyWUzQD1u8qEWZw/HsU0gDB7aoV0e54Xkdnh9slP0BF6
         rXKSvxu5BalIHMUiQQRuVdlgbTvOnsE9xzgzUWgKBI2dz3n6DOBdGM+1/Zc56req7Ej1
         lPFI2lxzt1iYVyF0cE8d16hDYECgh7NhswMCuSpRdM/3vYT497yB8xAgorunnrc8M1nV
         M5goOlqv3ObDggpYi40tuj+jfTJ40bMBYmEvEMGm8zcQC8tfS5+vpnPaskQFWvPlAlT2
         fNVM1L5ksPQDHKGTgUnaN44x3S876luiEjGgFasGnNBC1Pq845L+EVn5LY3SVPQA9AlB
         X2ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773081171; x=1773685971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pfbX7IgfKNQp2WRG7sxyMmlo2J+X5YrF7BKB81kNxE=;
        b=OKmBdzXMZs6SZgPLUjsPOaiO+XmfmTXOFzyKs1YgdM4mgLEF4F+FrC/D/erbDUCir+
         O4L16W2VSgn3XDXFaqnhZAcWQvxI1L3Sy5VnkTi4zVFx2eDN0GfuHDUq4qe8KwcKoJRC
         RObbgArgN6CuQ9LKBsw2x+GQ2mZH9HRMjMHiRYfp7vexmkytgvmMNvnaanWPssC4Ihei
         +LWD/aa6uLA15eFEqMJUKF9CLMsJPydHdahIGPWyq56vsbsXUzcx2EfIDYtCKyt2QD7P
         /aiF/DPKcisdax9mxmZ/iANKtESmGm9u7VjDopZxWaQM7gpsN1kYK2dheUeKb7A9JBLq
         /V0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773081171; x=1773685971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5pfbX7IgfKNQp2WRG7sxyMmlo2J+X5YrF7BKB81kNxE=;
        b=Nc9ujZCHeq0B5bu4JJwXi1A9FaCXnIl3n8YlyitT/DbZ4xGez+v5cyl+5kTJnvxK5l
         q7jl2WrFzOnUBFYDJvpZzRDs7WLtM5CIF5RWy9444VqI/HxCqixbfk/E2HQcIRtk4+hP
         sWlzRM7Ve+JstKo0qYAWVJCS0V3cKhYrsiIGV7oAk2qp/9biW5/IlPYmlu8iAsRUNzlN
         mrrycjNFN+V6/rvDVeamRscqJQdeT6lyMzB/bMQ13xYaM+p2VrznvuCdLi86kVCnNnt4
         EPXSPhKtEGcKgsCOADrZAhv0062KzDQ3/J4SEdtVfV8+kV7L3h9GpCBr7SPymN/zT9pl
         P9/g==
X-Forwarded-Encrypted: i=1; AJvYcCXs5bQuliPi+9YVXz3L52vBh68A5kt+eBqLshGzHI7Ic0Pwfb/yEahnCCO1elZn9t1MNiKEIw9QRhj4@vger.kernel.org
X-Gm-Message-State: AOJu0YyWPi84EL67sPUS+TGR5hYS4EkfcE60SzjdtE86zVLd3FXRzmMH
	oIxZ+t1L00e06ZvNBAYvtbL0ow5yhuw0FXuZtPf81yRHFmf4WFUAhU5LxYxUoN/R0q7gEBidDMe
	XVG6A0ZUF1eJvAXC4btk2omxizqKp+mX7QoR1OI70
X-Gm-Gg: ATEYQzyoBk4/dlXVZZBDbM8Wn/IoRWVLeNDPI+HQW27YYcDor+aUuSRQKLj8X2NnRm8
	yBDxbgIKeRzQkZH9k3ktQF5vLv2GEZq79svQ9X/C51HbIJqqKQVkUuXlkbjJWR5hFbGDpCuebFU
	OBsQQQaKcIIuGyu4iqG8GCmLNbDUhuhbNLrhEL4T5iH97PJAXaeUI0sFYmQMuG+P9MKywAikKtY
	q55k63/wot9hDmOJyLLK2HTHwGYVW2p/mAIm1NZg2JBF2g395zFLqckEx65QZSKc+fkiRCenHVO
	ajJhhoM=
X-Received: by 2002:a17:903:1988:b0:2ae:5ec4:2f78 with SMTP id
 d9443c01a7336-2ae8242cf9emr130948555ad.33.1773081171206; Mon, 09 Mar 2026
 11:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
In-Reply-To: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Mar 2026 14:32:39 -0400
X-Gm-Features: AaiRm51Nyf3eubsZF_AS8QuxcFS2-w70i5MYcT-OKhQqne3jHp6zEq8Kbc0-IAo
Message-ID: <CAHC9VhTR9CsBgxRCAHXm5T2NZ5tr+XfmA--zkt=udmk9hPRuZQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Firmware LSM hook
To: Leon Romanovsky <leon@kernel.org>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Saeed Mahameed <saeedm@nvidia.com>, Itay Avraham <itayavr@nvidia.com>, 
	Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>, 
	Maher Sanalla <msanalla@nvidia.com>, Edward Srouji <edwards@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D766923E9F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17806-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,paul-moore.com:dkim,paul-moore.com:url]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 7:15=E2=80=AFAM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> From Chiara:
>
> This patch set introduces a new LSM hook to validate firmware commands
> triggered by userspace before they are submitted to the device. The hook
> runs after the command buffer is constructed, right before it is sent
> to firmware.
>
> The goal is to allow a security module to allow or deny a given command
> before it is submitted to firmware. BPF LSM can attach to this hook
> to implement such policies. This allows fine-grained policies for differe=
nt
> firmware commands.
>
> In this series, the new hook is called from RDMA uverbs and from the fwct=
l
> subsystem. Both the uverbs and fwctl interfaces use ioctl, so an obvious
> candidate would seem to be the file_ioctl hook. However, the userspace
> attributes used to build the firmware command buffer are copied from
> userspace (copy_from_user()) deep in the driver, depending on various
> conditions. As a result, file_ioctl does not have the information require=
d
> to make a policy decision.
>
> This newly introduced hook provides the command buffer together with rele=
vant
> metadata (device, command class, and a class-specific device identifier),=
 so
> security modules can distinguish between different command classes and de=
vices.
>
> The hook can be used by other drivers that submit firmware commands via a=
 command
> buffer.

Hi Leon,

At the link below, you'll find guidance on submitting new LSM hooks.
Please take a look and let me know if you have any questions.

https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm-h=
ooks

(If you lose the link, or simply for future reference, you can find it
in the "SECURITY SUBSYSTEM" MAINTAINERS entry.)

--=20
paul-moore.com

