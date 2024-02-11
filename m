Return-Path: <linux-rdma+bounces-998-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F4F850B10
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Feb 2024 20:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6786A2834E3
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Feb 2024 19:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1536F5D470;
	Sun, 11 Feb 2024 19:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CG11gg1d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5DE5D498
	for <linux-rdma@vger.kernel.org>; Sun, 11 Feb 2024 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707679472; cv=none; b=SqU2RFvIwQ7nPS7lHHIPegUgi01AxVGlcTEr0jlfL9QyKrDQBJBtWhkhkRsfTRevrXPybWyrnltkW08IcGNBqISYqWRUt1FdE+r5x4VQgiSN9KW+WiB4yUoG+ck9626z3S96dpEtvfpU23kbLit80oUCnEqa6pqsT+7xEry0xPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707679472; c=relaxed/simple;
	bh=x+7IcjqnPfcoAlm9957wnFDBUVRspLwLYZxFvkts0PI=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=Je7ju4JVd9+z2Y1TKBzQpLmMKHhDyPjr1MGYj5+OA41ApNB4zgv6cF0t/PIret0WHe7ozVPPtRtJ+8Qm6bVby3lsI687DeTHt7GBEcxLSuPVBKQuYfhyJZ9CIqKLY4GhYF3+X/m9jZzpX/4fccNoMCbMi0ZV0x4/OTBFSnVBWaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CG11gg1d; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6dc8b280155so1872333a34.0
        for <linux-rdma@vger.kernel.org>; Sun, 11 Feb 2024 11:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707679470; x=1708284270; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ar2bGxcENUlLLVKOD7Lobw3fVzM5463Bgqwl61/9+IA=;
        b=CG11gg1dNUhrmtcAwceoVX8lMOhXcvJ9N852ytqssABCZejPrRig6TH3vySW8HX54h
         xygn71XBi7cBFBh6L6yzxHzxN1AP+Am1RiVr4apiEqXcxAZwcKBXZKbQLiwxXAYuX1vv
         rBmfkGsrjr+SyePEd0QrOF2d+OyfcnFX6VpC3ei+381ozCa5RZxpVP06ofbDF6hKQoct
         LnZPcVu2/QOYS8cLOdKZq05zAvKZj/tirVxgbjIXWsJYEtkTslgZ/AO26Benh6itXAKI
         racROsYvOLeu7Irqop2BBvtyTDq019iY32Hwi0M+wF8CoBSSXdFuyFNnTdE1KLeLUiI6
         pwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707679470; x=1708284270;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ar2bGxcENUlLLVKOD7Lobw3fVzM5463Bgqwl61/9+IA=;
        b=Q/twIu7Zfcb+XchHCC2xgDjG/LfUkJa0QKaX3N08B5OFP+8Qyd7NWGMspwzmd6see9
         iDteo/Ty2fPc5bpNVq0fygziEiXSH3MZpu6MHbubVl/rkykwy0KP6j67zAX8wkVnaYBk
         9Cip/+3mGgzLjzlU1AQAxE3ctXft5UolpL5gQ+JkLkQ2Uz6IrBK1MZsxFXE+iXUbdUa5
         5P6Ca6Dd2h5QxLOprHr75nfof2nMUdyDPtcT0NqZVR7TXHhZnKOMKP9b5XHyxFTTaBdX
         8QQvqZSLqFPkNdXwBmHfE5KE2MNCnrDDGCY44h9DY62kkX6zWyIy4blSuhQwzWyicbyE
         lS9w==
X-Gm-Message-State: AOJu0YynQaUiWdNHkf09Immip/RfUr08+SkCuDDMWgufMiP/xsTyah5s
	Ejk7POvRpJFQcRtSHd1RR9nCWnEK3NlzLBPXH4EHxkDYY0FENBrIxAUAUi9VHwSOwQ==
X-Google-Smtp-Source: AGHT+IEs+nTS+oLPx7UcQrG5mDYinKP0e86EMhxm73qdoE+4SkS8+auu57xQfTqLaDdono0g2BMYaQ==
X-Received: by 2002:a9d:7593:0:b0:6e2:dccd:2cbf with SMTP id s19-20020a9d7593000000b006e2dccd2cbfmr2333154otk.4.1707679470264;
        Sun, 11 Feb 2024 11:24:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJmVcBMurK7BQShl0zeAY2uo1BntkiVPS43QHynr3jopyQ50pyPSkWtfz5lhw68802laJAojEp84dOda2q3c/KO8VNQDqhvjQKSKOEuql45nzcHkTadzxrQSr0jOgYt1vlIlEVjL6L
Received: from smtpclient.apple ([2601:6c1:500:2c60:6d86:8556:54d5:7fa0])
        by smtp.gmail.com with ESMTPSA id x8-20020a9d5888000000b006e2e415401asm198714otg.79.2024.02.11.11.24.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Feb 2024 11:24:29 -0800 (PST)
From: Kevan Rehm <kevanrehm@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: Segfault in mlx5 driver on infiniband after application fork
Message-Id: <3CAF66C4-32E1-4258-9656-D886843D7771@gmail.com>
Date: Sun, 11 Feb 2024 14:24:16 -0500
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Yishai Hadas <yishaih@nvidia.com>,
 kevan.rehm@hpe.com
To: Mark Zhang <markzhang@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>
X-Mailer: Apple Mail (2.3774.300.61.1.2)


>> An application started by pytorch does a fork, then the child process =
attempts to use libfabric to open a new DAOS infiniband endpoint.    The =
original endpoint is owned and still in use by the parent process.
>>
>> When the parent process created the endpoint (fi_fabric, fi_domain, =
fi_endpoint calls), the mlx5 driver allocated memory pages for use in =
SRQ creation, and issued a madvise to say that the pages are DONTFORK.  =
These pages are associated with the domain=E2=80=99sibv_device which is =
cached in the driver.   After the fork when the child process calls =
fi_domain for its new endpoint, it gets the ibv_device that was cached =
at the time it was created by the parent.   The child process =
immediately segfaults when trying to create a SRQ, because the pages =
associated with that ibv_device are not in the child=E2=80=99s memory.  =
There doesn=E2=80=99t appear to be any way for a child process to create =
a fresh endpoint because of the caching being done for ibv_devices.
>>

> For anyone who is interested in this issue, please follow the links =
below:
> https://github.com/ofiwg/libfabric/issues/9792
> https://daosio.atlassian.net/browse/DAOS-15117
>=20
> Regarding the issue, I don't know if mlx5 actively used to run
> libfabric, but the mentioned call to ibv_dontfork_range() existed from
> prehistoric era.

Yes, libfabric has used mlx5 for a long time.

> Do you have any environment variables set related to rdma-core?
>=20
IBV_FORK_SAFE is set to 1

> Is it reated to ibv_fork_init()? It must be called when fork() is =
called.

Calling ibv_fork_init() doesn=E2=80=99t help, because it immediately =
checks mm_root, sees it is non-zero (from the parent process=E2=80=99s =
prior call), and returns doing nothing.
There is now a simplified test case, see =
https://github.com/ofiwg/libfabric/issues/9792 for ongoing analysis.=

