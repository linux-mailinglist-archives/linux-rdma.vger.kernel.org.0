Return-Path: <linux-rdma+bounces-1662-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B62C8911FC
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 04:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC711C2422E
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 03:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5F438F98;
	Fri, 29 Mar 2024 03:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SFPRvd+L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9092228F8
	for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 03:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711682867; cv=none; b=MHfUpytA6Toc0MSsb8ZE5fJH7aJGCdzFVX43dfqQbNfU7zdpms12ln7VM7p2qDt0+awx+kxSmFNT/lcM5DZsMFnS2snulUp71LaXYlyfK4Y/owmdCpZq/0OjOV7OrZS2n+iCUvYzfCao3uxe9p5Gdj10iEjKHzb43pFSs9s18jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711682867; c=relaxed/simple;
	bh=ABnCHq3JLbAEwiJxGgszG8awJft2mel2ZhhghAM3/dM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=seP2faoOGs5UtWf3seLoFEXwecs//jExt/nVfT9neDHqRuiAaFMGu4eodBaPixLB+3xU+JGDgBn0mjH/+lK7qeOXHwW6n2kXyZNbmJBx2fYWHsZVQoRX+dqnMGuMhsWH7BqsCHvCCxfdSnxaMHBHPoU/gQO4BhS6mwi0pzTDM0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SFPRvd+L; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-515a81928faso1904119e87.1
        for <linux-rdma@vger.kernel.org>; Thu, 28 Mar 2024 20:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711682864; x=1712287664; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qqIyfRJYHjOLESd+HU+z6VdynJkMqLifccTU787TjZE=;
        b=SFPRvd+Lx30XphJS2sRqdSuAVFEH/J1x5OtOnWL01fTrJuTs21XsdSix0Tyd7N/0r+
         rWzNbGUt2h6WIR55hTiqAymeYv8urLRf9ThmI6mLRK82Mece0RZ195AdRjQQKBnz63/J
         YWEY/kujjG5+wLvvnUEGXJwtJiW1n/BluatpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711682864; x=1712287664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qqIyfRJYHjOLESd+HU+z6VdynJkMqLifccTU787TjZE=;
        b=Y22PfZbvurwWO7JYbSLrf8FvLYC0ASdgfanrkdrFPm7WvRdDXfho0GnXbJGzBLKTlg
         l6UWNw6HjVzdT6ghIgBaXzOFT2YK2Y61G9x00ZLJXfX4yDR6dYMgW+bsNPjRxoWk7O4q
         iCrRYK+uubVWdFssTU0ZK3P3RwNtpJS7yLPqhTCsXzirNXIrUMIX22zHniIR9v9u3usu
         2zMAHBjFYBYMpSIbGaovZ1PxR7Pw1joRjsjPkLpSlLZACJy9K66X4G/UpxRINwzzrEm4
         t0zvTcucNT0Rc0IhZ5QVAHJ2WKA8I1SlhASG5r419o9uWucMRN6umCPjQBn6hHJFTMf6
         5aWg==
X-Gm-Message-State: AOJu0Yzc22yIabwe3hZR6gARh/+eFnuPsRktX+eTCAXQ7r3YTJK2OSuR
	fmYM0ZIkVd0e3kbzsV7TpQ2oqtIN2SLA6Cgh6XyhYmvAKg/ghp3rw0IBa+nj88eiTktY5dL8mqZ
	6396bBjzDC9H/paKorB6gZqhue857vTKWazX0
X-Google-Smtp-Source: AGHT+IGsbNXvg4O6N0tTDwjc12h4NNrcST+Ri4lPaAnexzLxQQKo6Rgt7UibKbXkCFW1AUmTrt7tcoXJerpo6h7WqmQ=
X-Received: by 2002:ac2:58fb:0:b0:515:8159:788d with SMTP id
 v27-20020ac258fb000000b005158159788dmr695302lfo.64.1711682863522; Thu, 28 Mar
 2024 20:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs-8vJNVA48BHKQ=cvNB7=aO2_XE2zp_0Fus44ea8wL2Ew@mail.gmail.com>
In-Reply-To: <CAHj4cs-8vJNVA48BHKQ=cvNB7=aO2_XE2zp_0Fus44ea8wL2Ew@mail.gmail.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Fri, 29 Mar 2024 08:57:31 +0530
Message-ID: <CAH-L+nNibfOK2zvUhkygQesr0Ye_mb0a0LeXtoB5_FLtcgGusw@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed on bnxt_re
To: Yi Zhang <yi.zhang@redhat.com>
Cc: RDMA mailing list <linux-rdma@vger.kernel.org>, 
	"Xavier, Selvin" <selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001488d70614c4390d"

--0000000000001488d70614c4390d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yi Zhang,

I tried to recreate the issue locally, but could not reproduce it.

Could you provide us few information:

1. The firmware version on the card. You can check "ethtool -i ethX"
and provide that info.
2. "lspci -s [bdf] -vvv" and "lspci -s [bdf] -xxx" output on the
function where you hit the issue.

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
>


--=20
Regards,
Kalesh A P

--0000000000001488d70614c4390d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEIEBT2ECp/bnS8DLUL4j4sEaiY58BgeT1ylMZAhPcK1o8MBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMyOTAzMjc0NFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAbRJ+Bio6Z
7Q1h2lILsC+hzN2XM6UBVccjzFXOQpb0EuHLiiN7oVkAq/PvieiwB2cSb83MMF4gDlPOFkTobNG3
8PXnt2ZyJIiJ5NJ/6A+fahe8lICkNF/avxdJaLqOHpvJLN0MCJlpIFfjOkw6fIgcEwzY/L+eF2op
zwPo3Q1fOQqEVUfD4oY3A6uP/6QnqxiNIZXdC9Hd/IBtCPphvq2E47rsgYlGgoCVLPaKeIsJ108k
waAAVfkw8WiPnyTY15e2ZWk01oXWsahZkee+JO6drFjAmz5S9msJZ0DaX7qJwhS2VF4wv1yayevx
GMdrPRrdy4eN21aUWMXMIB3KbUEz
--0000000000001488d70614c4390d--

