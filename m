Return-Path: <linux-rdma+bounces-2975-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19C88FFB77
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 07:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 955D41C245EE
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 05:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D89A14E2F7;
	Fri,  7 Jun 2024 05:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Ly2o4RkV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FFB18049
	for <linux-rdma@vger.kernel.org>; Fri,  7 Jun 2024 05:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717739629; cv=none; b=syKOY53v2cX94UzqpuIX1YYzOiwei6CYy3hHqsBZxehkZw4mNJL/se9EKfDSceFBcw7Yro49BgByh8WVTtFwj15cCYPDFwfyCvhTuaFBd9s/ptDnraJIW/5oX+OguLBc4W2G0sdEyZ/i+nPkyJoEfI3AwL7q7gglqaWd1w+Q4zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717739629; c=relaxed/simple;
	bh=3RE0k44VcoWfSKU0DB/1K5mON6tvxgTfw3pCuTl7SD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nw5wt4dMl+ah5K+m6Nfn7XEooW25U+Lqc0AzAOFfh/UNhv0cEV/Td+UUnpiNqYi2aFBQ5eZ23Dw0465kTF+C9Nb+SJZxoiQHw9U7QE8uBfcDsR1KEe7qByuLFNraJi15V3lqiF4joqSBCgEHu7UATwonRnpjn4iLiLPaGXZDQCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Ly2o4RkV; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a31d63b6bso2379508a12.0
        for <linux-rdma@vger.kernel.org>; Thu, 06 Jun 2024 22:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1717739625; x=1718344425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRzi2U/aGEWVOu13r3wPYJj/enOLXzMocY1cfz2tIJw=;
        b=Ly2o4RkVlR2NufGAsXEyeQ/7b1yorUksKXZUsH+808E+EKmGSn2QhxXXXY8W7/Ww98
         42TBZgSCx+qroZdiNysY+4+/7DTR9frGP4dZnr2uJxVk+4q2NYmRaTBHNO86RT0CPtnP
         lwJxX0L+MVVKhwi6m0VXvgL3EHDAJiNbexIYU8JF0eOuLTcm+q1Jr7njYK1ZaKo7pdY5
         Kz/MqFxna2xCoZMPAkoAVYmByyFd12DLVEn1+Hl+Y4lpsF5fOS2dlW9/NrMZIxjB4GcT
         mx1ra+h0Rk7ocPwWqQGYPPtdMaMnyow+xj0eEG6g6hP8cZXbKPa8FfXJID9SKlYJpBrQ
         VGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717739625; x=1718344425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRzi2U/aGEWVOu13r3wPYJj/enOLXzMocY1cfz2tIJw=;
        b=fnsnuhcd2JCCco2lqyyNF27wP0DaZsXw9yJrYW6jsRs5gLj1Xv47v1JJPQol8WBcnU
         DZz+YH8fAljffmQ3hrkc5eZ1bp6diaRtaScbkgUifa/x+FeqXB1hp3mE8iTT8KUIMOR+
         2L8XaptnvKlQ5szzLsn1Jdvi6qE/jySipsYgzMa8TH+myG8Z+Z7GiJ8orHpCXRuD9b6s
         EZWy5SY7zglmjh7ATTSK4V/fV2GM0oXZSj9nE1igS3S46+XChIpJrRjinJ0K2EsmzLdn
         7ql6Y+qj27Rh/0nH+yPIrxwwMdjbYx16TmtjRWcrbCA7c/yJVj60efaVZlOafdzTvT2d
         grrg==
X-Forwarded-Encrypted: i=1; AJvYcCVPO5ZP3v/49Pas8bcO6LOXdxpUcyQdY13YcLM/IG13DmJQ9wASPIgogY4uumt35VTqFXng4A+ZmwRMOE74iUueRU/+sxmb9767sA==
X-Gm-Message-State: AOJu0YyGgV9GDRf43TZ4J4+XBWhc1Wkp2XyRPAIhIBXb+zK1f4rnbPwk
	G2/u7Lg7gPOwWx46mAEH1qoOpzHsvwJeKuXVNWoM3tTVmvpYhVo+FX2MBiuDfBvgVjwX6Hw7HQg
	JzZwJj2Yk2yuPBYNf0esJyo3sddax7dBoyFCY6w==
X-Google-Smtp-Source: AGHT+IELw58JibX99xmkcVEIIyx5rwz/M9lBuMjWpNn/fhzqVwwVM822hkEfekIqEgdaEN35EH9XLbQsv9Y6Ex/K9j4=
X-Received: by 2002:a50:d791:0:b0:57a:33a5:9b78 with SMTP id
 4fb4d7f45d1cf-57c50999129mr723574a12.34.1717739625569; Thu, 06 Jun 2024
 22:53:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Fri, 7 Jun 2024 07:53:34 +0200
Message-ID: <CAMGffEkUd2EOS3+PQ9Yfp=8V1pZB_emo7gcmxmvOX=iWVG6Axg@mail.gmail.com>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
To: Gonglei <arei.gonglei@huawei.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, yu.zhang@ionos.com, 
	mgalaxy@akamai.com, elmar.gerdes@ionos.com, zhengchuan@huawei.com, 
	berrange@redhat.com, armbru@redhat.com, lizhijian@fujitsu.com, 
	pbonzini@redhat.com, mst@redhat.com, xiexiangyou@huawei.com, 
	linux-rdma@vger.kernel.org, lixiao91@huawei.com, 
	Jialin Wang <wangjialin23@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gonglei, hi folks on the list,

On Tue, Jun 4, 2024 at 2:14=E2=80=AFPM Gonglei <arei.gonglei@huawei.com> wr=
ote:
>
> From: Jialin Wang <wangjialin23@huawei.com>
>
> Hi,
>
> This patch series attempts to refactor RDMA live migration by
> introducing a new QIOChannelRDMA class based on the rsocket API.
>
> The /usr/include/rdma/rsocket.h provides a higher level rsocket API
> that is a 1-1 match of the normal kernel 'sockets' API, which hides the
> detail of rdma protocol into rsocket and allows us to add support for
> some modern features like multifd more easily.
>
> Here is the previous discussion on refactoring RDMA live migration using
> the rsocket API:
>
> https://lore.kernel.org/qemu-devel/20240328130255.52257-1-philmd@linaro.o=
rg/
>
> We have encountered some bugs when using rsocket and plan to submit them =
to
> the rdma-core community.
>
> In addition, the use of rsocket makes our programming more convenient,
> but it must be noted that this method introduces multiple memory copies,
> which can be imagined that there will be a certain performance degradatio=
n,
> hoping that friends with RDMA network cards can help verify, thank you!
First thx for the effort, we are running migration tests on our IB
fabric, different generation of HCA from mellanox, the migration works
ok,
there are a few failures,  Yu will share the result later separately.

The one blocker for the change is the old implementation and the new
rsocket implementation;
they don't talk to each other due to the effect of different wire
protocol during connection establishment.
eg the old RDMA migration has special control message during the
migration flow, which rsocket use a different control message, so
there lead to no way
to migrate VM using rdma transport pre to the rsocket patchset to a
new version with rsocket implementation.

Probably we should keep both implementation for a while, mark the old
implementation as deprecated, and promote the new implementation, and
high light in doc,
they are not compatible.

Regards!
Jinpu



>
> Jialin Wang (6):
>   migration: remove RDMA live migration temporarily
>   io: add QIOChannelRDMA class
>   io/channel-rdma: support working in coroutine
>   tests/unit: add test-io-channel-rdma.c
>   migration: introduce new RDMA live migration
>   migration/rdma: support multifd for RDMA migration
>
>  docs/rdma.txt                     |  420 ---
>  include/io/channel-rdma.h         |  165 ++
>  io/channel-rdma.c                 |  798 ++++++
>  io/meson.build                    |    1 +
>  io/trace-events                   |   14 +
>  meson.build                       |    6 -
>  migration/meson.build             |    3 +-
>  migration/migration-stats.c       |    5 +-
>  migration/migration-stats.h       |    4 -
>  migration/migration.c             |   13 +-
>  migration/migration.h             |    9 -
>  migration/multifd.c               |   10 +
>  migration/options.c               |   16 -
>  migration/options.h               |    2 -
>  migration/qemu-file.c             |    1 -
>  migration/ram.c                   |   90 +-
>  migration/rdma.c                  | 4205 +----------------------------
>  migration/rdma.h                  |   67 +-
>  migration/savevm.c                |    2 +-
>  migration/trace-events            |   68 +-
>  qapi/migration.json               |   13 +-
>  scripts/analyze-migration.py      |    3 -
>  tests/unit/meson.build            |    1 +
>  tests/unit/test-io-channel-rdma.c |  276 ++
>  24 files changed, 1360 insertions(+), 4832 deletions(-)
>  delete mode 100644 docs/rdma.txt
>  create mode 100644 include/io/channel-rdma.h
>  create mode 100644 io/channel-rdma.c
>  create mode 100644 tests/unit/test-io-channel-rdma.c
>
> --
> 2.43.0
>

