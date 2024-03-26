Return-Path: <linux-rdma+bounces-1565-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3504D88BCA5
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 09:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4992E3049
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 08:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC17EEA8;
	Tue, 26 Mar 2024 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GxGJmxkA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D452E1C286
	for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711442441; cv=none; b=NlbxyaLzHG8H4QtOGMEE+Z1FfWZOYGPMJW0In5jU6CT082MeB5XSfPr7WRfUvNkxIc4K8liVppAVg77oBmgLfkdfVTShE0inSMgoAhW/pkLgyiuTeJW3tf/MNefvee+SHnHCUO8iVcs82nhHdOZoCBXJkBNweWl0urJeNz/ZrN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711442441; c=relaxed/simple;
	bh=7BIBYcHhSYAJnLD6ChZjJGt6QTCys8Et5WwoKfBkT44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DoRVb8+Yx0tOKAcR8k2LRNFZpoS88346YhSK23KXINHgtUaMHHOjZs3lx+jPY0ZnqIWIwznJnwXiJpV53inyDMlRUPhh4GmQHxlDPpDE07ZV/glCag6e8K2kz50+31Q68XYg59Z4o0UIeb0Ci8n4bdMmKuQMbYG7xTs8886FUlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GxGJmxkA; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60a0579a931so56715817b3.0
        for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 01:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711442439; x=1712047239; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xe35T6xyIfJtezStBUHIpZxcS8BR79HK5I/+s9ZMfsY=;
        b=GxGJmxkAzYaIYHPxueTXBFUP28eXGUL6fPiY5JG85iGQBsehnxAo8LEjU82LoM3GMp
         DVmNcovTCcMQ+UaTz02c5TTMUZiForxoF6Lj2hKw9xChoQBAlM5ZfDeRE2smN8P/8rc8
         cP+jBIyLDs75a8UkO4O9qzyiTI1GClt5Q2YkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711442439; x=1712047239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xe35T6xyIfJtezStBUHIpZxcS8BR79HK5I/+s9ZMfsY=;
        b=ak1hAS+IMe7qOjGaLzr12e0YVIzOiDaGvpPiWWcVAOqrWuA+Sw22UwMc7WIPRVA7jC
         2O07IVja2y+KQpT8ct26R+nm/C1bwmM7CE1OroxcYl86KCdmJ8kVmvpstDZHvhu7MvZ+
         03poEeoPxRHjjhQczPZGAUbDLW3KcYYlL6VuF4ZZCYj0C3cGvQxXZaJxkFYlzXSj7MpO
         S5e3LC9MEMwMF87+1nYen1ZzCHCZk+23tAqSDrS8dxIkcGtFKujgWBaJAu+x69rXBL9A
         LM0VBnCulV6IATxAmayXLL4oFiNkHlK66EWOGIDKngfGg3iX92Rdie89Kk3YhtKhdDKq
         +HEg==
X-Gm-Message-State: AOJu0YzYaC9IWa2A2K36c0BEMBW/gNIJEX2oLeJU0Jnp4OolxVcbaZ0Q
	dxD/+z3k1OdL6sNCMHWSKm2BwU5IgiraV1/J7OdJ8ati/hy+ti73fJFA0h1lZtt5a61H8Fw/HhS
	QUR+kwT1Ycw15SW6nF3/dKP3bZkoPN5XSerbHdO3gZoAvYNQrdA==
X-Google-Smtp-Source: AGHT+IHLazrTD/UBmdSAcmXUEzrDqrzp37987XfgruOu6BO4QpTl4q4KZE1t456yuLUlkT/9+eE0hVhWnBcAYL0YSAM=
X-Received: by 2002:a25:5f03:0:b0:dcb:e0dc:67ee with SMTP id
 t3-20020a255f03000000b00dcbe0dc67eemr7114247ybb.45.1711442438081; Tue, 26 Mar
 2024 01:40:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs-8vJNVA48BHKQ=cvNB7=aO2_XE2zp_0Fus44ea8wL2Ew@mail.gmail.com>
In-Reply-To: <CAHj4cs-8vJNVA48BHKQ=cvNB7=aO2_XE2zp_0Fus44ea8wL2Ew@mail.gmail.com>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Tue, 26 Mar 2024 14:10:25 +0530
Message-ID: <CA+sbYW0sNPtPFUTDHTA6qJL_D1M_zB0VE6ePjoV8Swc=u6gAPQ@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed on bnxt_re
To: Yi Zhang <yi.zhang@redhat.com>
Cc: RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a1b2cb06148c3e42"

--000000000000a1b2cb06148c3e42
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Yi Zhang for reporting. We will analyze it and get back.

Thanks,
Selvin Xavier

On Tue, Mar 26, 2024 at 12:21=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wro=
te:
>
> Hello
>
> I found this kmemleak issue after system boots up with the latest
> linux tree, please help check it and let me know if you need any info,
> thanks.
>
> (gdb) l *(bnxt_re_alloc_pd+0x3d0)
> 0x22160 is in bnxt_re_alloc_pd (drivers/infiniband/hw/bnxt_re/ib_verbs.c:=
678).
> 673 goto dbfail;
> 674 }
> 675 }
> 676
> 677 if (!udata)
> 678 if (bnxt_re_create_fence_mr(pd))
> 679 ibdev_warn(&rdev->ibdev,
> 680    "Failed to create Fence-MR\n");
> 681 active_pds =3D atomic_inc_return(&rdev->stats.res.pd_count);
> 682 if (active_pds > rdev->stats.res.pd_watermark)
>
>
> unreferenced object 0xffffc90006a41000 (size 4096):
>   comm "systemd-udevd", pid 1233, jiffies 4294779228
>   hex dump (first 32 bytes):
>     00 e0 43 80 81 88 ff ff 2a 3e 03 00 00 00 00 00  ..C.....*>......
>     ea 7b 06 00 00 00 00 00 0a 00 00 00 30 00 00 00  .{..........0...
>   backtrace (crc cd29ebd4):
>     [<ffffffff8a9bf425>] kmemleak_vmalloc+0x95/0x160
>     [<ffffffff88cf35bc>] __vmalloc_node_range+0x3fc/0x540
>     [<ffffffff88cf37c4>] __vmalloc_node+0xb4/0x150
>     [<ffffffffc2152f89>] __alloc_pbl+0x199/0x960 [bnxt_re]
>     [<ffffffffc2154cc9>] bnxt_qplib_alloc_init_hwq+0xec9/0x1c20 [bnxt_re]
>     [<ffffffffc2163d65>] bnxt_qplib_reg_mr+0x245/0x630 [bnxt_re]
>     [<ffffffffc2150509>] bnxt_re_create_fence_mr+0x419/0xc90 [bnxt_re]
>     [<ffffffffc2151160>] bnxt_re_alloc_pd+0x3d0/0x540 [bnxt_re]
>     [<ffffffffc1ec133c>] __ib_alloc_pd+0xfc/0x5b0 [ib_core]
>     [<ffffffffc1f131a5>] ib_mad_port_open+0x685/0xfb0 [ib_core]
>     [<ffffffffc1f13bd1>] ib_mad_init_device+0xf1/0x370 [ib_core]
>     [<ffffffffc1edce6d>] add_client_context+0x2ed/0x440 [ib_core]
>     [<ffffffffc1edd17a>] enable_device_and_get+0x1aa/0x340 [ib_core]
>     [<ffffffffc1ede5c8>] ib_register_device+0x1c8/0x3a0 [ib_core]
>     [<ffffffffc2134f61>] bnxt_re_ib_init+0x401/0x6a0 [bnxt_re]
>     [<ffffffffc2137dbc>] bnxt_re_probe+0x4bc/0x710 [bnxt_re]
> unreferenced object 0xffffc90006a71000 (size 4096):
>   comm "systemd-udevd", pid 1233, jiffies 4294779229
>   hex dump (first 32 bytes):
>     00 e0 43 80 01 00 00 00 00 00 00 00 00 00 00 00  ..C.............
>     01 00 3e 00 01 00 00 00 00 00 00 00 00 00 00 00  ..>.............
>   backtrace (crc f97dda8f):
>     [<ffffffff8a9bf425>] kmemleak_vmalloc+0x95/0x160
>     [<ffffffff88cf35bc>] __vmalloc_node_range+0x3fc/0x540
>     [<ffffffff88cf37c4>] __vmalloc_node+0xb4/0x150
>     [<ffffffffc2152fc7>] __alloc_pbl+0x1d7/0x960 [bnxt_re]
>     [<ffffffffc2154cc9>] bnxt_qplib_alloc_init_hwq+0xec9/0x1c20 [bnxt_re]
>     [<ffffffffc2163d65>] bnxt_qplib_reg_mr+0x245/0x630 [bnxt_re]
>     [<ffffffffc2150509>] bnxt_re_create_fence_mr+0x419/0xc90 [bnxt_re]
>     [<ffffffffc2151160>] bnxt_re_alloc_pd+0x3d0/0x540 [bnxt_re]
>     [<ffffffffc1ec133c>] __ib_alloc_pd+0xfc/0x5b0 [ib_core]
>     [<ffffffffc1f131a5>] ib_mad_port_open+0x685/0xfb0 [ib_core]
>     [<ffffffffc1f13bd1>] ib_mad_init_device+0xf1/0x370 [ib_core]
>     [<ffffffffc1edce6d>] add_client_context+0x2ed/0x440 [ib_core]
>     [<ffffffffc1edd17a>] enable_device_and_get+0x1aa/0x340 [ib_core]
>     [<ffffffffc1ede5c8>] ib_register_device+0x1c8/0x3a0 [ib_core]
>     [<ffffffffc2134f61>] bnxt_re_ib_init+0x401/0x6a0 [bnxt_re]
>     [<ffffffffc2137dbc>] bnxt_re_probe+0x4bc/0x710 [bnxt_re]
> unreferenced object 0xffff8882b5c5bc00 (size 512):
>   comm "systemd-udevd", pid 1233, jiffies 4294779229
>   hex dump (first 32 bytes):
>     00 00 c0 43 82 88 ff ff 00 00 00 00 00 00 00 00  ...C............
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 754e43ab):
>     [<ffffffff88d24b7d>] kmalloc_trace+0x30d/0x3b0
>     [<ffffffffc214f923>] bnxt_re_alloc_mw+0x73/0x280 [bnxt_re]
>     [<ffffffffc215058b>] bnxt_re_create_fence_mr+0x49b/0xc90 [bnxt_re]
>     [<ffffffffc2151160>] bnxt_re_alloc_pd+0x3d0/0x540 [bnxt_re]
>     [<ffffffffc1ec133c>] __ib_alloc_pd+0xfc/0x5b0 [ib_core]
>     [<ffffffffc1f131a5>] ib_mad_port_open+0x685/0xfb0 [ib_core]
>     [<ffffffffc1f13bd1>] ib_mad_init_device+0xf1/0x370 [ib_core]
>     [<ffffffffc1edce6d>] add_client_context+0x2ed/0x440 [ib_core]
>     [<ffffffffc1edd17a>] enable_device_and_get+0x1aa/0x340 [ib_core]
>     [<ffffffffc1ede5c8>] ib_register_device+0x1c8/0x3a0 [ib_core]
>     [<ffffffffc2134f61>] bnxt_re_ib_init+0x401/0x6a0 [bnxt_re]
>     [<ffffffffc2137dbc>] bnxt_re_probe+0x4bc/0x710 [bnxt_re]
>     [<ffffffff89b075e0>] auxiliary_bus_probe+0xa0/0x110
>     [<ffffffff89ae7630>] really_probe+0x1e0/0x920
>     [<ffffffff89ae7f0a>] __driver_probe_device+0x18a/0x3d0
>     [<ffffffff89ae81a9>] driver_probe_device+0x49/0x120
> unreferenced object 0xffffc90006d4e000 (size 4096):
>   comm "systemd-udevd", pid 1233, jiffies 4294822916
>   hex dump (first 32 bytes):
>     00 c0 44 b8 82 88 ff ff 00 00 00 00 00 00 00 00  ..D.............
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 48b8bc5a):
>     [<ffffffff8a9bf425>] kmemleak_vmalloc+0x95/0x160
>     [<ffffffff88cf35bc>] __vmalloc_node_range+0x3fc/0x540
>     [<ffffffff88cf37c4>] __vmalloc_node+0xb4/0x150
>     [<ffffffffc2152f89>] __alloc_pbl+0x199/0x960 [bnxt_re]
>     [<ffffffffc2154cc9>] bnxt_qplib_alloc_init_hwq+0xec9/0x1c20 [bnxt_re]
>     [<ffffffffc2163d65>] bnxt_qplib_reg_mr+0x245/0x630 [bnxt_re]
>     [<ffffffffc2150509>] bnxt_re_create_fence_mr+0x419/0xc90 [bnxt_re]
>     [<ffffffffc2151160>] bnxt_re_alloc_pd+0x3d0/0x540 [bnxt_re]
>     [<ffffffffc1ec133c>] __ib_alloc_pd+0xfc/0x5b0 [ib_core]
>     [<ffffffffc1f131a5>] ib_mad_port_open+0x685/0xfb0 [ib_core]
>     [<ffffffffc1f13bd1>] ib_mad_init_device+0xf1/0x370 [ib_core]
>     [<ffffffffc1edce6d>] add_client_context+0x2ed/0x440 [ib_core]
>     [<ffffffffc1edd17a>] enable_device_and_get+0x1aa/0x340 [ib_core]
>     [<ffffffffc1ede5c8>] ib_register_device+0x1c8/0x3a0 [ib_core]
>     [<ffffffffc2134f61>] bnxt_re_ib_init+0x401/0x6a0 [bnxt_re]
>     [<ffffffffc2137dbc>] bnxt_re_probe+0x4bc/0x710 [bnxt_re]
> unreferenced object 0xffffc90006d59000 (size 4096):
>   comm "systemd-udevd", pid 1233, jiffies 4294822916
>   hex dump (first 32 bytes):
>     00 c0 44 b8 02 00 00 00 00 00 00 00 00 00 00 00  ..D.............
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 1bc211ce):
>     [<ffffffff8a9bf425>] kmemleak_vmalloc+0x95/0x160
>     [<ffffffff88cf35bc>] __vmalloc_node_range+0x3fc/0x540
>     [<ffffffff88cf37c4>] __vmalloc_node+0xb4/0x150
>     [<ffffffffc2152fc7>] __alloc_pbl+0x1d7/0x960 [bnxt_re]
>     [<ffffffffc2154cc9>] bnxt_qplib_alloc_init_hwq+0xec9/0x1c20 [bnxt_re]
>     [<ffffffffc2163d65>] bnxt_qplib_reg_mr+0x245/0x630 [bnxt_re]
>     [<ffffffffc2150509>] bnxt_re_create_fence_mr+0x419/0xc90 [bnxt_re]
>     [<ffffffffc2151160>] bnxt_re_alloc_pd+0x3d0/0x540 [bnxt_re]
>     [<ffffffffc1ec133c>] __ib_alloc_pd+0xfc/0x5b0 [ib_core]
>     [<ffffffffc1f131a5>] ib_mad_port_open+0x685/0xfb0 [ib_core]
>     [<ffffffffc1f13bd1>] ib_mad_init_device+0xf1/0x370 [ib_core]
>     [<ffffffffc1edce6d>] add_client_context+0x2ed/0x440 [ib_core]
>     [<ffffffffc1edd17a>] enable_device_and_get+0x1aa/0x340 [ib_core]
>     [<ffffffffc1ede5c8>] ib_register_device+0x1c8/0x3a0 [ib_core]
>     [<ffffffffc2134f61>] bnxt_re_ib_init+0x401/0x6a0 [bnxt_re]
>     [<ffffffffc2137dbc>] bnxt_re_probe+0x4bc/0x710 [bnxt_re]
> unreferenced object 0xffff888295670400 (size 512):
>   comm "systemd-udevd", pid 1233, jiffies 4294822916
>   hex dump (first 32 bytes):
>     00 00 c0 33 81 88 ff ff 00 00 00 00 00 00 00 00  ...3............
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 5378fcd7):
>     [<ffffffff88d24b7d>] kmalloc_trace+0x30d/0x3b0
>     [<ffffffffc214f923>] bnxt_re_alloc_mw+0x73/0x280 [bnxt_re]
>     [<ffffffffc215058b>] bnxt_re_create_fence_mr+0x49b/0xc90 [bnxt_re]
>     [<ffffffffc2151160>] bnxt_re_alloc_pd+0x3d0/0x540 [bnxt_re]
>     [<ffffffffc1ec133c>] __ib_alloc_pd+0xfc/0x5b0 [ib_core]
>     [<ffffffffc1f131a5>] ib_mad_port_open+0x685/0xfb0 [ib_core]
>     [<ffffffffc1f13bd1>] ib_mad_init_device+0xf1/0x370 [ib_core]
>     [<ffffffffc1edce6d>] add_client_context+0x2ed/0x440 [ib_core]
>     [<ffffffffc1edd17a>] enable_device_and_get+0x1aa/0x340 [ib_core]
>     [<ffffffffc1ede5c8>] ib_register_device+0x1c8/0x3a0 [ib_core]
>     [<ffffffffc2134f61>] bnxt_re_ib_init+0x401/0x6a0 [bnxt_re]
>     [<ffffffffc2137dbc>] bnxt_re_probe+0x4bc/0x710 [bnxt_re]
>     [<ffffffff89b075e0>] auxiliary_bus_probe+0xa0/0x110
>     [<ffffffff89ae7630>] really_probe+0x1e0/0x920
>     [<ffffffff89ae7f0a>] __driver_probe_device+0x18a/0x3d0
>     [<ffffffff89ae81a9>] driver_probe_device+0x49/0x120
>
> --
> Best Regards,
>   Yi Zhang
>

--000000000000a1b2cb06148c3e42
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
FYMZp2DojLAq9f4Oi2OBetbnWxo0WGycXpmq/jC4PUx2u9mazQ79i80VLagGRshWniESXuf+SYG8
+zBimjld9ZZnwm7itHAZdtme4YYFxx+EHa4PUxPV8t+hPHhsiIjirPa1pVXPbQIDAQABo4IB2zCC
AdcwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBA
MD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNybDAlBgNVHREEHjAcgRpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU3TaH
dsgUhTW3LwObmZ20fj+8Xj8wDQYJKoZIhvcNAQELBQADggEBAAbt6Sptp6ZlTnhM2FDhkVXks68/
iqvfL/e8wSPVdBxOuiP+8EXGLV3E72KfTTJXMbkcmFpK2K11poBDQJhz0xyOGTESjXNnN6Eqq+iX
hQtF8xG2lzPq8MijKI4qXk5Vy5DYfwsVfcF0qJw5AhC32nU9uuIPJq8/mQbZfqmoanV/yadootGr
j1Ze9ndr+YDXPpCymOsynmmw0ErHZGGW1OmMpAEt0A+613glWCURLDlP8HONi1wnINV6aDiEf0ad
9NMGxDsp+YWiRXD3txfo2OMQbpIxM90QfhKKacX8t1J1oAAWxDrLVTJBXBNvz5tr+D1sYwuye93r
hImmkM1unboxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDJRFgxB8ZGT
jIM/Dk0MF9dPQR8Py7Vp3OXaB58g6BW5MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI0MDMyNjA4NDAzOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBDIQP7t56uaV/D/1VYpxA/szAHBATD
BW5nw4zuBXCKMucv15STt9HDZa0U1O2Sk6+dVfEVjmgFMOBND5vnzev67W+1+IxE0APebaiR6OV7
XHLETzE8mAtQ00HESHb+ayebN2b4nX871QxMG6JeXQlbqzOcTnN/FfpE1GM2jDWqai9YBUkQ7nTR
TfNB9T7sf91CSQkRDZvAfYCI7B8ZQKKg1hzwp3RZIln4AwFG+L0TXK1QwetezQSvdaGAEwtwbC56
nt5tRGRbFwsSMVWahfgbGeysGNJh7g7U3ROAsMjOUehyRr+zy7lQ8LS3tHzzhTTtVwpZd6oQQkKm
FNiVY2v/
--000000000000a1b2cb06148c3e42--

