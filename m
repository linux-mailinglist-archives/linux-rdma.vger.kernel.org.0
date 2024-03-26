Return-Path: <linux-rdma+bounces-1561-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 198DD88BAC2
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 07:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9442A8776
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 06:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A552F12C7E3;
	Tue, 26 Mar 2024 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QIkSmUOb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE412AADB
	for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 06:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711435870; cv=none; b=La2zM3zx8pL584Nb/cQzydVxrEAGtOIEQ6ePY29v4PTxBSAIDg0tgy7Neh3Nk50ZTur9oGHZVUN5OPAZ8T5D2YIUlN6GbRTQ0d5/9EucTSda5+t2Sf5w0YnuquVLLRLEBWWPLh1f+DYfCtZ/vUSLQVeCspkNiipYvEu5tzd3gsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711435870; c=relaxed/simple;
	bh=1p8kiYo+UOQEhYq7ocb0a10dOON/OzeZN/GAseCSrPE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=STPhMboBhqTmeUaYajxp+7gJP5II2+pi0uCNhJaA0NeUG5C0TJa4ksVk1fn0DeU0tTytbgodOMSOh8cXO5sUz/SMSc/gobrNffeM8Zside1rAbqOiednwWxmCB+0A6C0dCc1QsAANDp3+A/jg5FRhqtms01AQvEHuLA3fAh9Qz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QIkSmUOb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711435866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=fTkup4hEJ5d8oj5tBHHIrTcn00YXHI1E/2p5k3xjOpo=;
	b=QIkSmUObvW0aTO9OQfG8WanXZx4JqLrBUUzNKp8x/uXj0UgmIi4jcbVJJe8YwteYaNMJiq
	EgZJgji6ogWbRtsIjFnVZW1qaNn8PfvxVbD2Unz74OH6QHYhIcTsQjYxdjorW8O14xak1d
	ZgZSH9fEXfFR9HR8wkQcjBRPWKfixqo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-npxifTzcPjmoZNGifq6WFA-1; Tue, 26 Mar 2024 02:51:03 -0400
X-MC-Unique: npxifTzcPjmoZNGifq6WFA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29df71a709eso4304311a91.1
        for <linux-rdma@vger.kernel.org>; Mon, 25 Mar 2024 23:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711435861; x=1712040661;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fTkup4hEJ5d8oj5tBHHIrTcn00YXHI1E/2p5k3xjOpo=;
        b=iWHViPEI2IaskHg5swMYq7BBsBC7C+ge6Cz2NHbi0TqiGzZRkEQNZrcTdqHzI3ca5r
         mCF/ibsZ5tIZ8fz7TDaoEQFpLJn9wSssr1Rezdw2cPQdPnAZIQ1+xZHlpKRVT3A0XHlY
         AJjr0Y5XmlpP3co32duWXzbaicVNEe+csyCM4+wzNRgbfAf75dUnhrEY5eKI64cH1m+3
         +pBs1Al7yzHOkmyynTUcaGQlwQWKwMMpKr4WSYJx4dO+rz0nqEqd9RaUfjdMLAInXJ8x
         Izjka7fhrrnU2gJl+JAVjKUAkADWteN0aWAGxrGR9obLIDv1ijV4z64MpNgj2106cIDe
         RYRw==
X-Gm-Message-State: AOJu0YzPBtPwGpfCEhzyzTWLxP1PgLqpYmwceNW+8vK4ccoBkMRq81xN
	/EglElY4cuufHCMXx7abk/heu3tpsY247fFqTB+7ekSpdlXlawE3N/0dyFP0KVmt/b63YtPUdH2
	/gZxJW65eAU06eA0NyKBQHuy+Co1v4pb1V0Avpyn0JzMqkqakBRZeWkWU9S29mevlRIRejrzFqy
	63RbCj74qhUpU2ZMu0AfjkaaJhgxTDxyfQ0f+u5liuOvoeXNw=
X-Received: by 2002:a17:90a:df81:b0:2a0:6802:3d97 with SMTP id p1-20020a17090adf8100b002a068023d97mr5247096pjv.25.1711435861023;
        Mon, 25 Mar 2024 23:51:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPpgmVAI/LEqgLnj0nXKswUyERcTQWooc7Ct2dALsVDKz8wAzgAOEdmGyTm+Szad3if1slsrJmSq4udWWn8Ws=
X-Received: by 2002:a17:90a:df81:b0:2a0:6802:3d97 with SMTP id
 p1-20020a17090adf8100b002a068023d97mr5247085pjv.25.1711435860617; Mon, 25 Mar
 2024 23:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 26 Mar 2024 14:50:48 +0800
Message-ID: <CAHj4cs-8vJNVA48BHKQ=cvNB7=aO2_XE2zp_0Fus44ea8wL2Ew@mail.gmail.com>
Subject: [bug report] kmemleak observed on bnxt_re
To: RDMA mailing list <linux-rdma@vger.kernel.org>
Cc: "Xavier, Selvin" <selvin.xavier@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

Hello

I found this kmemleak issue after system boots up with the latest
linux tree, please help check it and let me know if you need any info,
thanks.

(gdb) l *(bnxt_re_alloc_pd+0x3d0)
0x22160 is in bnxt_re_alloc_pd (drivers/infiniband/hw/bnxt_re/ib_verbs.c:678).
673 goto dbfail;
674 }
675 }
676
677 if (!udata)
678 if (bnxt_re_create_fence_mr(pd))
679 ibdev_warn(&rdev->ibdev,
680    "Failed to create Fence-MR\n");
681 active_pds = atomic_inc_return(&rdev->stats.res.pd_count);
682 if (active_pds > rdev->stats.res.pd_watermark)


unreferenced object 0xffffc90006a41000 (size 4096):
  comm "systemd-udevd", pid 1233, jiffies 4294779228
  hex dump (first 32 bytes):
    00 e0 43 80 81 88 ff ff 2a 3e 03 00 00 00 00 00  ..C.....*>......
    ea 7b 06 00 00 00 00 00 0a 00 00 00 30 00 00 00  .{..........0...
  backtrace (crc cd29ebd4):
    [<ffffffff8a9bf425>] kmemleak_vmalloc+0x95/0x160
    [<ffffffff88cf35bc>] __vmalloc_node_range+0x3fc/0x540
    [<ffffffff88cf37c4>] __vmalloc_node+0xb4/0x150
    [<ffffffffc2152f89>] __alloc_pbl+0x199/0x960 [bnxt_re]
    [<ffffffffc2154cc9>] bnxt_qplib_alloc_init_hwq+0xec9/0x1c20 [bnxt_re]
    [<ffffffffc2163d65>] bnxt_qplib_reg_mr+0x245/0x630 [bnxt_re]
    [<ffffffffc2150509>] bnxt_re_create_fence_mr+0x419/0xc90 [bnxt_re]
    [<ffffffffc2151160>] bnxt_re_alloc_pd+0x3d0/0x540 [bnxt_re]
    [<ffffffffc1ec133c>] __ib_alloc_pd+0xfc/0x5b0 [ib_core]
    [<ffffffffc1f131a5>] ib_mad_port_open+0x685/0xfb0 [ib_core]
    [<ffffffffc1f13bd1>] ib_mad_init_device+0xf1/0x370 [ib_core]
    [<ffffffffc1edce6d>] add_client_context+0x2ed/0x440 [ib_core]
    [<ffffffffc1edd17a>] enable_device_and_get+0x1aa/0x340 [ib_core]
    [<ffffffffc1ede5c8>] ib_register_device+0x1c8/0x3a0 [ib_core]
    [<ffffffffc2134f61>] bnxt_re_ib_init+0x401/0x6a0 [bnxt_re]
    [<ffffffffc2137dbc>] bnxt_re_probe+0x4bc/0x710 [bnxt_re]
unreferenced object 0xffffc90006a71000 (size 4096):
  comm "systemd-udevd", pid 1233, jiffies 4294779229
  hex dump (first 32 bytes):
    00 e0 43 80 01 00 00 00 00 00 00 00 00 00 00 00  ..C.............
    01 00 3e 00 01 00 00 00 00 00 00 00 00 00 00 00  ..>.............
  backtrace (crc f97dda8f):
    [<ffffffff8a9bf425>] kmemleak_vmalloc+0x95/0x160
    [<ffffffff88cf35bc>] __vmalloc_node_range+0x3fc/0x540
    [<ffffffff88cf37c4>] __vmalloc_node+0xb4/0x150
    [<ffffffffc2152fc7>] __alloc_pbl+0x1d7/0x960 [bnxt_re]
    [<ffffffffc2154cc9>] bnxt_qplib_alloc_init_hwq+0xec9/0x1c20 [bnxt_re]
    [<ffffffffc2163d65>] bnxt_qplib_reg_mr+0x245/0x630 [bnxt_re]
    [<ffffffffc2150509>] bnxt_re_create_fence_mr+0x419/0xc90 [bnxt_re]
    [<ffffffffc2151160>] bnxt_re_alloc_pd+0x3d0/0x540 [bnxt_re]
    [<ffffffffc1ec133c>] __ib_alloc_pd+0xfc/0x5b0 [ib_core]
    [<ffffffffc1f131a5>] ib_mad_port_open+0x685/0xfb0 [ib_core]
    [<ffffffffc1f13bd1>] ib_mad_init_device+0xf1/0x370 [ib_core]
    [<ffffffffc1edce6d>] add_client_context+0x2ed/0x440 [ib_core]
    [<ffffffffc1edd17a>] enable_device_and_get+0x1aa/0x340 [ib_core]
    [<ffffffffc1ede5c8>] ib_register_device+0x1c8/0x3a0 [ib_core]
    [<ffffffffc2134f61>] bnxt_re_ib_init+0x401/0x6a0 [bnxt_re]
    [<ffffffffc2137dbc>] bnxt_re_probe+0x4bc/0x710 [bnxt_re]
unreferenced object 0xffff8882b5c5bc00 (size 512):
  comm "systemd-udevd", pid 1233, jiffies 4294779229
  hex dump (first 32 bytes):
    00 00 c0 43 82 88 ff ff 00 00 00 00 00 00 00 00  ...C............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 754e43ab):
    [<ffffffff88d24b7d>] kmalloc_trace+0x30d/0x3b0
    [<ffffffffc214f923>] bnxt_re_alloc_mw+0x73/0x280 [bnxt_re]
    [<ffffffffc215058b>] bnxt_re_create_fence_mr+0x49b/0xc90 [bnxt_re]
    [<ffffffffc2151160>] bnxt_re_alloc_pd+0x3d0/0x540 [bnxt_re]
    [<ffffffffc1ec133c>] __ib_alloc_pd+0xfc/0x5b0 [ib_core]
    [<ffffffffc1f131a5>] ib_mad_port_open+0x685/0xfb0 [ib_core]
    [<ffffffffc1f13bd1>] ib_mad_init_device+0xf1/0x370 [ib_core]
    [<ffffffffc1edce6d>] add_client_context+0x2ed/0x440 [ib_core]
    [<ffffffffc1edd17a>] enable_device_and_get+0x1aa/0x340 [ib_core]
    [<ffffffffc1ede5c8>] ib_register_device+0x1c8/0x3a0 [ib_core]
    [<ffffffffc2134f61>] bnxt_re_ib_init+0x401/0x6a0 [bnxt_re]
    [<ffffffffc2137dbc>] bnxt_re_probe+0x4bc/0x710 [bnxt_re]
    [<ffffffff89b075e0>] auxiliary_bus_probe+0xa0/0x110
    [<ffffffff89ae7630>] really_probe+0x1e0/0x920
    [<ffffffff89ae7f0a>] __driver_probe_device+0x18a/0x3d0
    [<ffffffff89ae81a9>] driver_probe_device+0x49/0x120
unreferenced object 0xffffc90006d4e000 (size 4096):
  comm "systemd-udevd", pid 1233, jiffies 4294822916
  hex dump (first 32 bytes):
    00 c0 44 b8 82 88 ff ff 00 00 00 00 00 00 00 00  ..D.............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 48b8bc5a):
    [<ffffffff8a9bf425>] kmemleak_vmalloc+0x95/0x160
    [<ffffffff88cf35bc>] __vmalloc_node_range+0x3fc/0x540
    [<ffffffff88cf37c4>] __vmalloc_node+0xb4/0x150
    [<ffffffffc2152f89>] __alloc_pbl+0x199/0x960 [bnxt_re]
    [<ffffffffc2154cc9>] bnxt_qplib_alloc_init_hwq+0xec9/0x1c20 [bnxt_re]
    [<ffffffffc2163d65>] bnxt_qplib_reg_mr+0x245/0x630 [bnxt_re]
    [<ffffffffc2150509>] bnxt_re_create_fence_mr+0x419/0xc90 [bnxt_re]
    [<ffffffffc2151160>] bnxt_re_alloc_pd+0x3d0/0x540 [bnxt_re]
    [<ffffffffc1ec133c>] __ib_alloc_pd+0xfc/0x5b0 [ib_core]
    [<ffffffffc1f131a5>] ib_mad_port_open+0x685/0xfb0 [ib_core]
    [<ffffffffc1f13bd1>] ib_mad_init_device+0xf1/0x370 [ib_core]
    [<ffffffffc1edce6d>] add_client_context+0x2ed/0x440 [ib_core]
    [<ffffffffc1edd17a>] enable_device_and_get+0x1aa/0x340 [ib_core]
    [<ffffffffc1ede5c8>] ib_register_device+0x1c8/0x3a0 [ib_core]
    [<ffffffffc2134f61>] bnxt_re_ib_init+0x401/0x6a0 [bnxt_re]
    [<ffffffffc2137dbc>] bnxt_re_probe+0x4bc/0x710 [bnxt_re]
unreferenced object 0xffffc90006d59000 (size 4096):
  comm "systemd-udevd", pid 1233, jiffies 4294822916
  hex dump (first 32 bytes):
    00 c0 44 b8 02 00 00 00 00 00 00 00 00 00 00 00  ..D.............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 1bc211ce):
    [<ffffffff8a9bf425>] kmemleak_vmalloc+0x95/0x160
    [<ffffffff88cf35bc>] __vmalloc_node_range+0x3fc/0x540
    [<ffffffff88cf37c4>] __vmalloc_node+0xb4/0x150
    [<ffffffffc2152fc7>] __alloc_pbl+0x1d7/0x960 [bnxt_re]
    [<ffffffffc2154cc9>] bnxt_qplib_alloc_init_hwq+0xec9/0x1c20 [bnxt_re]
    [<ffffffffc2163d65>] bnxt_qplib_reg_mr+0x245/0x630 [bnxt_re]
    [<ffffffffc2150509>] bnxt_re_create_fence_mr+0x419/0xc90 [bnxt_re]
    [<ffffffffc2151160>] bnxt_re_alloc_pd+0x3d0/0x540 [bnxt_re]
    [<ffffffffc1ec133c>] __ib_alloc_pd+0xfc/0x5b0 [ib_core]
    [<ffffffffc1f131a5>] ib_mad_port_open+0x685/0xfb0 [ib_core]
    [<ffffffffc1f13bd1>] ib_mad_init_device+0xf1/0x370 [ib_core]
    [<ffffffffc1edce6d>] add_client_context+0x2ed/0x440 [ib_core]
    [<ffffffffc1edd17a>] enable_device_and_get+0x1aa/0x340 [ib_core]
    [<ffffffffc1ede5c8>] ib_register_device+0x1c8/0x3a0 [ib_core]
    [<ffffffffc2134f61>] bnxt_re_ib_init+0x401/0x6a0 [bnxt_re]
    [<ffffffffc2137dbc>] bnxt_re_probe+0x4bc/0x710 [bnxt_re]
unreferenced object 0xffff888295670400 (size 512):
  comm "systemd-udevd", pid 1233, jiffies 4294822916
  hex dump (first 32 bytes):
    00 00 c0 33 81 88 ff ff 00 00 00 00 00 00 00 00  ...3............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 5378fcd7):
    [<ffffffff88d24b7d>] kmalloc_trace+0x30d/0x3b0
    [<ffffffffc214f923>] bnxt_re_alloc_mw+0x73/0x280 [bnxt_re]
    [<ffffffffc215058b>] bnxt_re_create_fence_mr+0x49b/0xc90 [bnxt_re]
    [<ffffffffc2151160>] bnxt_re_alloc_pd+0x3d0/0x540 [bnxt_re]
    [<ffffffffc1ec133c>] __ib_alloc_pd+0xfc/0x5b0 [ib_core]
    [<ffffffffc1f131a5>] ib_mad_port_open+0x685/0xfb0 [ib_core]
    [<ffffffffc1f13bd1>] ib_mad_init_device+0xf1/0x370 [ib_core]
    [<ffffffffc1edce6d>] add_client_context+0x2ed/0x440 [ib_core]
    [<ffffffffc1edd17a>] enable_device_and_get+0x1aa/0x340 [ib_core]
    [<ffffffffc1ede5c8>] ib_register_device+0x1c8/0x3a0 [ib_core]
    [<ffffffffc2134f61>] bnxt_re_ib_init+0x401/0x6a0 [bnxt_re]
    [<ffffffffc2137dbc>] bnxt_re_probe+0x4bc/0x710 [bnxt_re]
    [<ffffffff89b075e0>] auxiliary_bus_probe+0xa0/0x110
    [<ffffffff89ae7630>] really_probe+0x1e0/0x920
    [<ffffffff89ae7f0a>] __driver_probe_device+0x18a/0x3d0
    [<ffffffff89ae81a9>] driver_probe_device+0x49/0x120

-- 
Best Regards,
  Yi Zhang


