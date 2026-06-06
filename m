Return-Path: <linux-rdma+bounces-21904-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7gZNIxRqJGp96AEAu9opvQ
	(envelope-from <linux-rdma+bounces-21904-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 20:42:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E5364E0C0
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 20:42:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jvB8Gu8o;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21904-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21904-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D75C30137A5
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Jun 2026 18:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63583B4E84;
	Sat,  6 Jun 2026 18:42:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5320A30D3E5
	for <linux-rdma@vger.kernel.org>; Sat,  6 Jun 2026 18:42:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780771344; cv=pass; b=Y8NWQKPxFYhJvhGolUVaT+aCik7FLcw8QxsezlRR9CrrDjVX1IFLZiECcnok98LFhj+zlz5N/ckFPHLAGeHP3tdQTEY4fmqXoQK0NsAGzoRyE4ILUdq7UW6c8Jx2+F3SjWAs4z5BqmjoDCrh4on0XFLwZXy+Fwsu5goo5ETsw10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780771344; c=relaxed/simple;
	bh=RBlU1eXgTTD9jJN1iDXVJqzQoWToOFMDJo8xJji+O3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GW94KG71FrGvWgvk3LP1YvP3dA0Nga7DT8Ot5RO/CDpcWON2zke9Em+GLKRfY7L+KUCi7qEXcnQAYJG0LRRD659Y1k2KclmtDX+/3QsyFDyb63stJI9zkj11KOf5pz6bFDPZTT9lEtF+AlW1nyHxJ1stvcdLKGks+qL8WTPBHHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvB8Gu8o; arc=pass smtp.client-ip=74.125.224.47
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66062a414fcso3392324d50.1
        for <linux-rdma@vger.kernel.org>; Sat, 06 Jun 2026 11:42:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780771342; cv=none;
        d=google.com; s=arc-20240605;
        b=dPmKpmf93ZzlG2p22tXJLAk2CG8pSHVN6leCMDsUV/wTLd6y6fyhQH8XHNC3KmgmHW
         GRDLoFiwhpLdBvzgBGvyhBVUzzEpzNBAb0C5SjW6OKmYX4uy94y8qtLDzeBCNcQzbgmT
         8qGGEIFuQKy8Q4ad32pXkc2xlAo1lHMWVZt8I1sOwrTJcteqntOyqxBru1yT3Jp1+ffm
         jhT13ohUNQJ9K2e5i7gw7BY/ZyE+Ibs3w31mo/Mggt0woH9kGEHYMBm339ru/FoS1iLy
         nSZRw+80U/773bgG7EVznRDU2fjYI7rG1Be9Rt3EeC0SY+46ECWw4Avns0xgN9AAAO/E
         e58Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yLaXl5eiO3mLmCxHqPHP8XMTqDdRd4OBcfkKscy7we8=;
        fh=Wxw+euk3JJQc4AL3bhFpAZdJpkXkn08fyO+CEuvgurc=;
        b=U6AsJecssUSDXpSZQhC+9VB3xGi9XRqzgcAt/T87eHy+oZI61tExgvpXoxqLm3/FMS
         DzjBtgrggaEO6OFkeeSrUxNIohw3BpydHTZd32CDPqYE1Ww3YooB2FaqEMrtF1H0Cbgk
         +E39HQV3BBNZUhwogr4FoePIEqz5WEDcsS/L1gU2RrP/vj2flXiQJOR+yFlJ2Ynu81Q4
         xudbU4iKjXPjmYcqfZ7rGL3DMhSjJF30BD88TbRahAb1m/5efUyUAROun7G+vdtnNnz2
         FUIMotEYPM4ryzEILqc0Y/MbwwbrvR4Cexy+cSV/C3y2eGUZLU3UH2thI3567/Y0SVZP
         QVEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780771342; x=1781376142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLaXl5eiO3mLmCxHqPHP8XMTqDdRd4OBcfkKscy7we8=;
        b=jvB8Gu8oQsuI/EiLGgnS7vgAOFgna6wJsTRraJpz8Kb0wBeZaBqRjY4KRgmKr6/XNe
         HOugEw9Adkab5dIbl+unyV9kksCAxk7tm3aESsYhiyarTr8Xc3rTikcIOipynLt7VXgy
         AFpohb4AkeZKIIKTI/Iz8xAWPzNXMciVlbxTDzkVfFOaxV+oJwVQQqG1z9GHEQ4jss2t
         wfDR/2yDU4JFPJqSdEjee+q5Z4vxGBDeDtZ9N6P4PJOr5Kh9VUtKoRVErIbEXnpS2xsw
         NfOdAB0HBwaY2obIp83jOKRUKEAagnZkYH7VM1WRnECWVlKTbDZbCr9b9b8UfwFThXOE
         kr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780771342; x=1781376142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yLaXl5eiO3mLmCxHqPHP8XMTqDdRd4OBcfkKscy7we8=;
        b=fYDxz3roLBUc8ZL6l2fhYLxkUL7CgNyFFvzzGud80w3F/MHBKIpcAp1lEbkEQgTmej
         A2AyHv0VNjEIghU+I9+dxgQAIvLRvSOA2WVHPif1Lcr7BeAEwEfnsaFx4nvBehR78XpE
         MDVakT8/2dJZbuoM+j7oUoRbyCIT+Wk/TFOJ3xGbIbzn5+MXG7ZCyrVfd1kqw+DBkj3J
         1g1MCW5jxyOYCzMzAhIRCzBRDG3/EgJ2LinOYEYrCs+EdUiiNxuc1H5LhVGeSh9q0z/i
         cgb9VTKC+PaOksFWqU/WQt+dB2oCsz4VVwM3+TxtnnMO4f9P3FfEOKm3530K1/yHeCra
         LJLQ==
X-Forwarded-Encrypted: i=1; AFNElJ84bB5nvxMA3obvqDPILkv/W9jm5THS+njuJlIBmXMWS3HNh2+XxuB8YggVidOBzqWnRG/cyrDKoeU1@vger.kernel.org
X-Gm-Message-State: AOJu0YzjCfuIAwxmI2ZoquzDWWSeaVq9EnoKLFTaqFhmksajXpNmIezm
	G4jBqJPF5oIDLTCmbUndFR0Ddnn0DgkdAwHmhMkwYOjr525dvNnBCMiw6LS9gMiGScU521a4dcA
	9iGoJ3xsv+pbNikyMWSFvvGjKCebW9wc=
X-Gm-Gg: Acq92OEhV7vyXpf7NHVpHncXiZ9t6VAEpfUwinPyKuQEj7VYWb9X/diUTHXkpEQGTRI
	vyeKxTM+nIyc4MvabbOg5q3p9HYaLJNTIfaGnoLAue2HvD3aIjulrul/slmCQzBPG47Ecw1kuvF
	6/FRuHi+EgH5DPENkvdUMqRbwfEBDv3AUUvxtZnw2rlKrXbBw23H/W10gV/pzDAV4W+p0cbzMgR
	RQicTqBDydzxxOBQ9C6EasfqaJgwztU4iC2lmsm8x0v3YlVYFHF0h5Vc/eAQ6/GgsV5BtHSSNtW
	Xo8FJxgR/Ybn1rRMgVR0am8LyudDZ4oPMDkjSuKcWNpRbQY=
X-Received: by 2002:a05:690e:4090:b0:65c:6f05:adf5 with SMTP id
 956f58d0204a3-66106fbd515mr7756629d50.60.1780771342372; Sat, 06 Jun 2026
 11:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602194700.2273758-1-michael.bommarito@gmail.com> <20260605170741.GA2768320@nvidia.com>
In-Reply-To: <20260605170741.GA2768320@nvidia.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sat, 6 Jun 2026 14:42:10 -0400
X-Gm-Features: AVVi8CdtG-6pY5tjKGyddk1_ky3H6_YPKyZ6dgZtitoIboHRVgo2qeN1REWA9RE
Message-ID: <CAJJ9bXyAMe6Wm1cvOqOGBZG0sjL6p2py1yW4eu9RuKbjciWZmw@mail.gmail.com>
Subject: Re: [PATCH] RDMA/siw: bound Read Response placement to the RREAD length
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Bernard Metzler <bernard.metzler@linux.dev>, Leon Romanovsky <leon@kernel.org>, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:bernard.metzler@linux.dev,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21904-lists,linux-rdma=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5E5364E0C0

On Fri, Jun 5, 2026 at 1:07=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
> I made the changes Bernard asked for and applied it to for-next

Thanks for finishing this and SRP_RSP.  I know you're still waiting on
my v2 for IB/mad, which I'll be sending soon too.

Thanks,
Mike

