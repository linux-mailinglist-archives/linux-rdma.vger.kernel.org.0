Return-Path: <linux-rdma+bounces-13205-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 804EFB4FC2E
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 15:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41FC63BCB38
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 13:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B27721FF39;
	Tue,  9 Sep 2025 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dv5ZHhoX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7710929408
	for <linux-rdma@vger.kernel.org>; Tue,  9 Sep 2025 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757423775; cv=none; b=Kjuh6rlso0NCBXYFXKBTl18Xs07PhYckZbfZiRDXIs+6YcShBWwesO3LRyweGm1iYiG4ORYVOoxRWzMbqnX+NgAfxRocGMt4maKeCBWW1Q8JVqMgn10j611pR195bptldl8GHwuOEYDqj/YxjhTD3H2v+rJgMa85vJ2mMlSXr4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757423775; c=relaxed/simple;
	bh=FND6/deJIEveDnRf1snEi94vIuWhfUI+SPFIjw5kJMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoNLhGd8oqu2uhU3hJWEXu+Zcx7PG8TsgCt0PcfUBVuqXt6DNf2sdh9uf/kihlx1hsiUoiDAz/K/v9Q4G9DYcF3wbAvRLxv4lN1W/ThCP1C0/x1LUS9CFaGR4z6U9U0kBFbxS14CNBATZImI6AJ3xAr97tEaVthLOcQQz5mFRGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dv5ZHhoX; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f69cf4b77so5766360e87.2
        for <linux-rdma@vger.kernel.org>; Tue, 09 Sep 2025 06:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757423771; x=1758028571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XmesdwQdCm+EdBTfiLYx/y8eCBq+A8zKL34w15rT6A=;
        b=Dv5ZHhoXGVkBVUGdFR6pEUanaudREkfK693EpoIsIIojs64aWWTnw54aWDtD1qgOvH
         2osulDwskx2wgEDrA/n+Ecx3Kn1rqcoY3oYuRc5o8Lbgh1j5ZtaLWYnAUmO4cfEo0a/s
         rEVW/Bgd5UErqqrjMvkerV0fnCsZZ/ZsEf9FmQIF8z1C9uCFHWkz5mcPpSKK1ETGQt+v
         J59Ks8HPrDBxogH+jcBo0hGeogwxbG21qqYp/knWARyKbZyrNrD3AliMrEP1qFvUJe0k
         5SY0abYL2HehK5tip/GbgAfApdKsfzozpWyGaCr3/n7tWzu410hkca37WJv5lsrHH4Uq
         38LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757423771; x=1758028571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XmesdwQdCm+EdBTfiLYx/y8eCBq+A8zKL34w15rT6A=;
        b=Goy0gOdxSnDuPDaWNsObi+XQEhl+QSEHQ5y4lAIBLxnYOD8RrT1btS2bhgOBxNTQM8
         p8JUqQzZM0wCjaROYm3Ef0B0/cByuLQHhdcwBebQTfQ5kibjB/HLwADbUvyuGqTNqy5N
         cibv2q4J6TVFmSwYCmkM9UHKlq0lT8Mbw3cStCT0RJX4RPAlvorS3+PjEqYOS6eLGM2T
         vZSbC2W/K67v6Eke4H1kf0TG+HLplJe/GikFIeJzbz5bCwuzN2Bj1SAbFpDg1dUDsRL7
         2LYwinIr6rWPB9O8gwyaoYqLVHYkaK5yt2oF31S6NxD/qjlJ/OsvlrCgcnRf4s9lMYqB
         +PYw==
X-Forwarded-Encrypted: i=1; AJvYcCXWwyzm/4oHQ48nEK4SncMg4yELV21US7Pya9Rm1mDZVbc0DryGqJhooMrAMSsH+E7oDLh8Vt02uiSY@vger.kernel.org
X-Gm-Message-State: AOJu0YybUtDt/keTKd9uN6DMP0XOW1xE9PeacCLHVy6Vgg73Ah5azigB
	a5amghGhk238o0jyTgEkQ41Ui+AZUu+u/0FW1FfdIGHILBRWA7nTATb5F6EnwjX7WpCx5WCJMP1
	tuHV7lXWoR6pYp19vq03OX2OquQWumvNN3vmUUA6Alfgd/VKG3IpUH64LKQA=
X-Gm-Gg: ASbGncsS0JaTc653QuTqEtWUrm8dnqxaCFIQrzjcRedVtAhJle8fX/0BumIBTneWXA9
	bacf5904IUTpZIP3YV9e4jedp+rll8MeNr0Nhq5hqmDZl0lx/M+j8Go4MIBI7AdJTcpFRX5hmyR
	7qNCXhqnsF0b6Yl0wXfghiVivCqkRcXRDvL+zg/NPYwR6Xw88KI0f3MPgY6CflXq0X6xhGSaieN
	s2m6nCI7LRtYG3r0FGdd9IMqAlvxQHv6fYHNuZNGKL0jCIP
X-Google-Smtp-Source: AGHT+IEitqJGIctnCgKlB7S9LtuSeJNHZ0Dsj+url3pMVjMRzcGaWcJW6CTINB+7CcMP/awK1XDcpRs0anuTvij7XPY=
X-Received: by 2002:a05:6512:1049:b0:55f:6aeb:833c with SMTP id
 2adb3069b0e04-5625f817c51mr3365149e87.7.1757423771299; Tue, 09 Sep 2025
 06:16:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827152545.2056-1-tatyana.e.nikolova@intel.com>
 <CAHYDg1Taj9PBoHRoNjBJsgmpWWYtkD9P5BHLRJ-BSi+4J6kU_w@mail.gmail.com> <20250909113437.GE341237@unreal>
In-Reply-To: <20250909113437.GE341237@unreal>
From: Jacob Moroni <jmoroni@google.com>
Date: Tue, 9 Sep 2025 09:15:32 -0400
X-Gm-Features: Ac12FXyetF0h-OT5tiCVTjXz7U-ciRDK_stZUN_kQAF_7iszx5b-ckCLEQqdT8A
Message-ID: <CAHYDg1QPYK0OJEYWVR2fOfHVyXpkViDebmq4CDs+K2VdYWHJ2g@mail.gmail.com>
Subject: Re: [for-next 00/16] Add RDMA support for Intel IPU E2000 in irdma
To: Leon Romanovsky <leon@kernel.org>
Cc: Tatyana Nikolova <tatyana.e.nikolova@intel.com>, jgg@nvidia.com, 
	linux-rdma@vger.kernel.org, krzysztof.czurylo@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I tested with the following:

Original RFC Github PR from a while ago:
https://github.com/linux-rdma/rdma-core/pull/1486
Latest Github PR from 2 weeks ago:
https://github.com/linux-rdma/rdma-core/pull/1640

Thanks,
Jake


On Tue, Sep 9, 2025 at 7:34=E2=80=AFAM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Wed, Aug 27, 2025 at 03:21:28PM -0400, Jacob Moroni wrote:
> > Tested with rdma-unit-test (https://github.com/google/rdma-unit-test).
> >
> > [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 522 tests from 43 test suites ran. (18=
72510 ms total)
> > [  PASSED  ] 481 tests.
> > [  SKIPPED ] 41 tests, listed below:
> >
> > Tested-by: Jacob Moroni <jmoroni@google.com>
>
> What did you test?
> I don't see any rdma-core changes to support this new driver.
> https://lore.kernel.org/all/20250827152545.2056-8-tatyana.e.nikolova@inte=
l.com/
>
> """
> This change introduces a GEN3 auxiliary vPort driver responsible for
> registering a verbs device for every RDMA-capable vPort. Additionally,
> the UAPI is updated to prevent the binding of GEN3 devices to older
> user-space providers.
> """
>
> Thanks

