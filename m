Return-Path: <linux-rdma+bounces-5995-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B7C9CD6BF
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 06:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1959B2832B2
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 05:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74258181334;
	Fri, 15 Nov 2024 05:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CE2n7euX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD0217C7CB;
	Fri, 15 Nov 2024 05:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731649884; cv=none; b=p0G72DaTJ1E0oqDDuoMl7tHSNadbOA4JuAbNEHXW+FZk9kMxw3EQTMukjE6SzOPbBpGIY1zGXFWl/fq3QclHQqZl5fe/ydSPhIBX4PSGliIqt2etRMewVAjWMkpjJbvMnxgkOthjyb0R0sKYCvLpGxr8fjiCDWK+qkLLJTlT838=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731649884; c=relaxed/simple;
	bh=1VWsBgWFv/U76HFHVe1R2CdATfvlynSPlywEauHpQ+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N68u6MX/g5H6K2As3n5qMYoZY0mxCxv+HM3KIrRFw4EQEUI2JeyeKBMkXz8Qj8h6dOJxDcpPbBBN87+aTQDI6tRBlXQ7Qfv9/IFkRDXOr4u1uDP/bwjeeR3naB1OQJCpSuEROhbC6ops/21h1xre4Q5YfrP+UuGLQYUAQHBGUcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CE2n7euX; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cd7a2ed34bso7889706d6.2;
        Thu, 14 Nov 2024 21:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731649881; x=1732254681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/JVk5SuroGnHuens+zYRaJYVAvVeyQaRlHh71ViQEY=;
        b=CE2n7euXk2XTfXX9OTSWE+/drMGJQ9vlCMTvsqPooQpTll00t/Mp1l/Vdh+sZIuQwY
         e7xMjgmCedrdAeaS/4OU1j5AGZqV+SXpWtrbkACPPsuDtomZBAAtiBzmZC3ht+a0qpuU
         KXtl+ZPlELPESOdyDc/j64Fl8/oTjffBmC4XzhBMRNCDCwSpEB1dAbfei1EveqqjQuuh
         IrZF82A3ZByGNGPh9IulsgOpeK8kSC2FPorCq2wsN4SrzKYwAeTcQhLa5SP3X2Z7+dpP
         ZBNqfYoLZf/ZOCtXOoXykX9IYY/rtpFirWuUAA3z0cdIckIZH/rL2SsTmyZjWLDQr7Es
         Qcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731649881; x=1732254681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/JVk5SuroGnHuens+zYRaJYVAvVeyQaRlHh71ViQEY=;
        b=ocjBX4lcSeHGSxB5D4u9MSPwbpIcM7Ehrvx102SSUZJZ475y7vRcHYAvKkMglrJcbk
         Wg3xubWWoG2cnoarDsWPewC23yXtRNB1a9W8ZQCOkN41bNI8KE+OQsfaAdGPCx+x+m1Y
         qEs/VNYQzqiCEOdn20IzjYzbMEQvkPOWxlNwB5XlJBi6tErVttDkLQLp4oPk5b7t/pKK
         yxkqGA1fcZz2oDxzmpdiTpAM3hP4b7/f+P5E6mxqAnk3ta47EWCFzO1nEvPplV+CeRFN
         Hk7r65qyLvfkaYZlPGLhuA9ANllYNWIFC18doWO7fH2oA1Stvg4Us9iRLe4j8s6aU846
         TBng==
X-Forwarded-Encrypted: i=1; AJvYcCWPahnJwQiVG1IQsMkWkTWjJhw3mWj5atkntKCFNUJPrKauqh0IHYtwmBl50mK3PeNILd5kYUEg@vger.kernel.org, AJvYcCWUfH8JmTarLZc7tIlHft4rh4JBoY9PQoUGl15hAMZxdqDn/2YAs7FZpex0OB9LDVw6zZMEsr4qMPEf@vger.kernel.org
X-Gm-Message-State: AOJu0YyDQIKkVyB3AzF0IsozBZUyBvVyPOS6UT+U0icCL/6v5+O+Wzc+
	zo5wAyhEZL9SBdEjhC1Z5utXz7z8SgHR6Oz2jD0s8eL4vyp7/Gb037B/RTf28MDu47zMApBGRba
	z0CpvtuhIzmXLNgk9T59o3bKEv2o=
X-Google-Smtp-Source: AGHT+IEKzucYFoI0BE/BI8mi0WFPgltPkJAjMFA2FhjJP2DUWLlEoEdFeS4UqG2hy2+LPUuqf05VjSeX5Zlg+5ajSqE=
X-Received: by 2002:a05:6214:5541:b0:6d3:80a9:fcad with SMTP id
 6a1803df08f44-6d3fb780b6dmr18167946d6.19.1731649881600; Thu, 14 Nov 2024
 21:51:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114021711.5691-1-laoar.shao@gmail.com> <20241114182750.0678f9ed@kernel.org>
 <CALOAHbCQeoPfQnXK-Zt6+Fc-UuNAn12UwgT_y11gzrmtnWWpUQ@mail.gmail.com> <20241114203256.3f0f2de2@kernel.org>
In-Reply-To: <20241114203256.3f0f2de2@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 15 Nov 2024 13:50:45 +0800
Message-ID: <CALOAHbBJ2xWKZ5frzR5wKq1D7-mzS62QkWpxB5Q-A7dR-Djhnw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] net/mlx5e: Report rx_discards_phy via rx_fifo_errors
To: Jakub Kicinski <kuba@kernel.org>
Cc: ttoukan.linux@gmail.com, gal@nvidia.com, saeedm@nvidia.com, 
	tariqt@nvidia.com, leon@kernel.org, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 12:32=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 15 Nov 2024 11:56:38 +0800 Yafang Shao wrote:
> > > On Thu, 14 Nov 2024 10:17:11 +0800 Yafang Shao wrote:
> > > > - *   Not recommended for use in drivers for high speed interfaces.
> > >
> > > I thought I suggested we provide clear guidance on this counter being
> > > related to processing pipeline being to slow, vs host backpressure.
> > > Just deleting the line that says "don't use" is not going to cut it :=
|
> >
> > Hello Jakub,
> >
> > After investigating other network drivers, I found that they all
> > report this metric to rx_missed_errors:
> >
> > - i40e
> >   The corresponding ethtool metric is port.rx_discards, which was
> > mapped to rx_missed_errors in commit 5337d2949733 ("i40e: Add
> > rx_missed_errors for buffer exhaustion").
> >
> > - broadcom
> >   The equivalent metric is rx_total_discard_pkts, reported as
> > rx_missed_errors in commit c0c050c58d84 ("bnxt_en: New Broadcom
> > ethernet driver")
> >
> > Given this, it seems we should align with the standard practice and
> > report this metric to rx_missed_errors.
> >
> > Tariq, what are your thoughts?
>
> mlx5 already reports rx_missed_errors and AFAIU rx_discards_phy are very
> different kind of drops than the drops reported as 'missed'.
> The distinction is useful in production in my experience working with
> mlx5 devices.

From the manual [0], it says :

The number of received packets dropped due to lack of buffers on a
physical port. If this counter is increasing, it implies that the
adapter is congested and cannot absorb the traffic coming from the
network.

Would it be possible to add this description to if_link.h?

Frankly, it doesn=E2=80=99t make much difference to end users like me wheth=
er
this is reported to rx_missed_errors or rx_fifo_errors; the main goal
is simply to monitor this metric to flag any issues...

[0]. https://enterprise-support.nvidia.com/s/article/understanding-mlx5-eth=
tool-counters


--
Regards
Yafang

