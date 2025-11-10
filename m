Return-Path: <linux-rdma+bounces-14353-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D6FC45B68
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Nov 2025 10:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321AF3B7C9E
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Nov 2025 09:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7875E30149E;
	Mon, 10 Nov 2025 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HYTErRMq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57774301460
	for <linux-rdma@vger.kernel.org>; Mon, 10 Nov 2025 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767975; cv=none; b=mp4HIWZHaRZaWQUgwXVDEtTHpGZOsAdk9EUvYrhWpb+gZ23U6uQyNMIcZ3RQgJS6+dU1Oe4KRQ3FgkaMG8mFtXUzXyYjLkfMStpX+M4SfAQ5saJzoolv04S4WdmOHp2J3sypDE/6oeWimHwA3/d7ZulcNKSIhtnjnCxYcz6RcOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767975; c=relaxed/simple;
	bh=G8FyUb4ahZ5DaUZfNRANTrYRf6oD8kdXRJpCHUd06PA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWGK56sp0rYcxXdvLQkHRD4ZtaogVvlQcfDsr9UmnpAQhS9rsXEzvC/2yFSJe6XDjVwTS+VHIEg+Uhk/AUcmnlQuRhPdME4Z3jmwvl5razWZoZ3yBX+LnG++EtXBx1v+hUDM+kOaPH2f/v9sDKrPey7P4xBoumZWDwScVC80+F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HYTErRMq; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-591ec7af7a1so2361151e87.3
        for <linux-rdma@vger.kernel.org>; Mon, 10 Nov 2025 01:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762767971; x=1763372771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaXS6m3NcTkH+l9Uwp9vlSWhXICs1XAI8l9sEjUIZu0=;
        b=HYTErRMq42J6I7OM51UzHsne0kRDistQ1SShANn/IFd2+HgUL8BxHoeDnF6jTPOs1R
         oXQ1Hkgurq+ud29XGAIWUpVQ7Pos6R2Hf881n75NrfRkEMUwYttipgQ+TtAr2Mif2FwR
         oZ5tJyQyA7CCdFoB9tj05yWMpRz2ihTFTyO8lkEY53ONb53XWZj3Tp6ljEqPA5y3jnKp
         rDsexGTeW3iurEem1PqFIYUZRVBPU/nGEAgSo9T4f8MxJXTpU54uoMqIiud1P5vivVAN
         XYqGdBy1U4YyIJmYDh99ipBpKENBBE3XYxnUSdq5uTI2LqLtIKTh0fJBb752ma4vv4OB
         QViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767971; x=1763372771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GaXS6m3NcTkH+l9Uwp9vlSWhXICs1XAI8l9sEjUIZu0=;
        b=eqyaTTeioeCuXJPJTYw/3ulDUgTpF3q5SAswn4WcNUYRYg/EiB5bVAa/uLqYasJkEG
         e4lmZwOrAqGBCUMrLR1ZB9hcD1TPCMUSFxfwDF7fQLeji/KPgEovIAvbtJ5Dqb3+f+DR
         PQv0CWodpv+e1mZVD3PXtagEhaoAUn1pJvCdFfouSen3eHTq2C+Rp83Lfb2IrZGBgWFn
         hjsYgnVyoBrK93xgwmRjB6ZNnHg/YzsU8Tt2CTZSNH96uiEk8SGanCZu02uB4JRhAL++
         ElXVhOkrBs4/7UNFfMUV+pjDteDLeZedmo8sLJOWJdw0NAz33GTpKu4kpO0+ycUwqvor
         04cQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0zTmfgCXS/N2qlVzoadM/AYl8O0z7ZPfJwbFqnA728b1x8V321PO+u3CD9GwHGOjhwbTYdw75vL9Z@vger.kernel.org
X-Gm-Message-State: AOJu0YyM6+6b6pAsjYKDix2TzGthmjbk6fX2tCbpJ7lVRoe4HL/BvGE+
	5/dGeBXOI5ID+5rEOvSO1pt78fSQQSTPnzrMH2poE3FtrLG0SRVsNIPurcZqHupuvmeTtFS8+YF
	vEHVIEieRQBjNv6fTn6ClxjbOMg6YjaM8u7RM55g27g==
X-Gm-Gg: ASbGncsvDz2TGxL2EWME/f/2bORAc2V4FUNMInL3+uFTidMu1j0jFzm0Rz/KMKbX+F/
	bRQBoB712ntk0TIDpmqi8kMBDNAvr44CdyObCNpLdjSFPDoG1bg6CzUb72cV1YxkxXuEgpF60fI
	7VktS0oBSK7aqMiF58Jvw10qhRCXu0wq7yFBSf/aaixfa0omWa8VKyx/aocOSMmU/NSfvF2khEq
	dT/Ewnn7lzkUdLEcJA+hiWkCu9HwlXCMm45IvSjkSurNcJckAsU86z4LBpCYYhMH0wuYYIXAHA9
	kRU0RoZ1hjHgVeIC7M69sQyY4D1t
X-Google-Smtp-Source: AGHT+IFl1HIzxhu+5+xHMGe9KG/BTowlyYL1X4kciQxoixfdv4RCOTF+DqBRORHhpwcj1OT/9qYIy2M7s4tgYPW892U=
X-Received: by 2002:a05:6512:39d2:b0:594:339d:8b8d with SMTP id
 2adb3069b0e04-5945f1cbc64mr2296242e87.54.1762767971378; Mon, 10 Nov 2025
 01:46:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107133626.190952-1-marco.crivellari@suse.com> <176268787482.581844.7324846885016543491.b4-ty@kernel.org>
In-Reply-To: <176268787482.581844.7324846885016543491.b4-ty@kernel.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 10 Nov 2025 10:46:00 +0100
X-Gm-Features: AWmQ_bnrAuDTTrwaWs2Ag0G5kodCMZnaZYI4o0vDoMUA-msokQy6U766q6ZjZ9Y
Message-ID: <CAAofZF6smnssmFpg9KpLzQH=sxB4bC8Vq0SpgQkrNh8O8n741Q@mail.gmail.com>
Subject: Re: [PATCH] IB/isert: add WQ_PERCPU to alloc_workqueue users
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	target-devel@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 12:31=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
> [...]
> Applied, thanks!
>
> [1/1] IB/isert: add WQ_PERCPU to alloc_workqueue users
>       https://git.kernel.org/rdma/rdma/c/5c467151f6197d
>

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

