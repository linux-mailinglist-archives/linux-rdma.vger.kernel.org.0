Return-Path: <linux-rdma+bounces-12531-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AB0B150F2
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jul 2025 18:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED95617A517
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jul 2025 16:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFECB298CD9;
	Tue, 29 Jul 2025 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="ZMJwmr8W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EF82222A3
	for <linux-rdma@vger.kernel.org>; Tue, 29 Jul 2025 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805307; cv=none; b=inRjf5zrSXSea9FN6GLG1r0Ck9W+NfVzFl2N6gKJ0V4ownyzohbBSvo/3xwBNXcvX6Ts+6FFD9pxvfmPdYFzM9A1vwo0vNfFh9aKwM5t8VXr3euUWUKfM6ZhFrlJAPOSjfmgq61id/JpJEHQdttF8qW8aznYTuAdpgaPYyePdUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805307; c=relaxed/simple;
	bh=jWhsVhI/kIUcTiaKNB51zhD0HFWoZiB/Z43Nfx7mIFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHXLeIYB/vmZPCtTbVo3pd9ZvUNdyCuvYQPS+TY3wPyTARvyiRi/xtFpXBPzqbdYxI7WYqYZ42T2f7QXfNJwL+AabW+/gS7s1jH1zdCPMrTQ33YgMQselx2kuT8cmNDFG3L4r4EZANrHyrKe73H7topQpNqicldkKGcyqd+mLo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=ZMJwmr8W; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32f1aaf0d60so62402231fa.1
        for <linux-rdma@vger.kernel.org>; Tue, 29 Jul 2025 09:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1753805304; x=1754410104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWhsVhI/kIUcTiaKNB51zhD0HFWoZiB/Z43Nfx7mIFA=;
        b=ZMJwmr8WfuGaAHqd7QbcWLZVBmhPV2k9owTaWeA62BBN/46QDdmpc53VwQDjcOZiZe
         AnAI7lNAyVoOIAQsOK09NvFoO6pSKguqS/NM4BN4yanFpD8nXhODXZcpRAnykDkwwb0x
         HYRVDQjePpkzxsKGHbSuKy2zxQmzZyjhvNs9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753805304; x=1754410104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWhsVhI/kIUcTiaKNB51zhD0HFWoZiB/Z43Nfx7mIFA=;
        b=peOqVG2jtlfv5naI3sepiDYnX8ro9XTbAqSXKCYR3ehee+a8LcTS6qA19rkrTSIewT
         8IOMoJQxZ57jouXM7H89OqknCBOHxmsTIptD5/d6N5IhXqTV1ebMC+k8Q/XpFtNIDofQ
         CnxQ3WRHIu3zElKvgOeqsye6//jC5sVgcvce0p4YlGsQBmfRykcU1hqh/RKho5UIZ0tO
         e51A0d77dhStY0NRhwfJhKqC387T34x99sIi2fCTSUAhTgsFJ+rANkpWFgwcUI5ojxGW
         HeVsTdS3d8lC5p+pQxTpIenXMI3X3tAUbTsPRp+VcmqgOXe9NZSqmEzhzTOnlDhoFCDK
         sQUw==
X-Forwarded-Encrypted: i=1; AJvYcCVjeGNyB+4KCLBkgZxzOYBE3BuWPzRMDAqJxZBmxpBGZeMem2nDbLw3FSqW6rzuuMu/enYv5uKdbQSa@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu3yQpiZy4mIx5N+F59GNG5tgHQZGHUdlx/DxE3AXJAoLTzq3/
	m2O4P1sG9ZPCamrwg+wwzppPR+7IdJCXPo/r1IPjTvaFCckZgRiAzui4c5f13jubs2cYR917F3i
	qp8VYyG0++xS/OGCIeVQF8+5bPVjtx4N+NO2rG+M9quq9SxvxuV2zLaCnGg==
X-Gm-Gg: ASbGncsPaaoeYeGg/6MCjuuk9tJyXKJY0Hrwjtc3EShh+QwFJyr2ezRy/7vV7yPhDB9
	5CiMhla5huAmqaefme4nvj70RzYeqoHHG8cbpyYcGVW1xeJnBYYBQ6BcTB1806uEQCD03vWBdde
	1jqNK9z8w68nDomybjXLTdlPF6NqQz7Gfm0iVNcFWiw01FEq8oGLR7654+8WMEc8fmlmGL+Uoij
	Me0vckc7jEIoI7E+Q==
X-Google-Smtp-Source: AGHT+IHvhEcBhtKVE05nESYn7oyTCfm5DRlyJvc7SFnlN+wRMWImG+RvgCIqXF12EjXml2WEKjc3u4XZxdc0LIb1VSg=
X-Received: by 2002:a05:651c:2226:b0:332:129d:b6e5 with SMTP id
 38308e7fff4ca-332129db89amr20417581fa.23.1753805303872; Tue, 29 Jul 2025
 09:08:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715-cpaasch-pf-925-investigate-incorrect-gso_size-on-cx-7-nic-v2-1-e06c3475f3ac@openai.com>
 <6583783f-f0fb-4fb1-a415-feec8155bc69@nvidia.com> <CADg4-L9osR02Aey319fMVAyAYXxOfaKqWcQ2AsfQCrdFKA5vsQ@mail.gmail.com>
 <CADg4-L_SNAKy3mBn7ssq7uw0_+wZ_=zyqrQ23yVTOo5J7z7Q=g@mail.gmail.com> <6d3fdda2-e0dc-484e-8f29-3010b8b5da78@nvidia.com>
In-Reply-To: <6d3fdda2-e0dc-484e-8f29-3010b8b5da78@nvidia.com>
From: Christoph Paasch <cpaasch@openai.com>
Date: Tue, 29 Jul 2025 09:08:12 -0700
X-Gm-Features: Ac12FXwA7FP_RYGIEZX6HpN20ml0iBBFFWFA0rvyfmeSLfNroEd5q_4LlEoMNPM
Message-ID: <CADg4-L8B0i0Nz0tPyQX3qX4TWJ1rKD7KXvo2qHQKo_yFP-=1Fw@mail.gmail.com>
Subject: Re: [PATCH net v2] net/mlx5: Correctly set gso_size when LRO is used
To: Gal Pressman <gal@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 7:03=E2=80=AFAM Gal Pressman <gal@nvidia.com> wrote=
:
>
> On 29/07/2025 4:01, Christoph Paasch wrote:
> > The below fixes it. The problem is that because gso_segs is not set,
> > NAPI_GRO_CB()->count is 0 when processing the packets.
> > So, if we have a non-LRO'ed packet followed by an LRO'ed packet being
> > processed, the first one will have NAPI_GRO_CB()->count set to 1 the
> > next one to 0 (in dev_gro_receive()).
>
> I was also suspecting something in this area, but LRO packets shouldn't
> really aggregate with other GRO skbs as they use different checksum
> offloads (UNNECESSARY vs. COMPLETE), so tcp_gro_receive() should flush GR=
O.

AFAICS, that's only for when NAPI_GRO_CB(p)->is_flist is set (meaning
for forwarded traffic).
skb_gro_checksum_validate() will make sure the checksum is ok when
entering tcp4_gro_receive().


Christoph

> > This means we end up in gro_complete() with count =3D=3D 1 and thus don=
't
> > call inet_gro_complete().
> >
> > I'm still unclear why this only fails much later then when checking
> > the checksum, but I'm sure the below diff fixes it (and also gets rid
> > of all packet-loss, so throughput goes up)
> >
> > Will submit a proper patch tomorrow.
>
> Thank you for the quick fix!

