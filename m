Return-Path: <linux-rdma+bounces-13526-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA494B8C3EE
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Sep 2025 10:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B117C5EA0
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Sep 2025 08:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BDE21CC4B;
	Sat, 20 Sep 2025 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhNJuWDk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B848A55
	for <linux-rdma@vger.kernel.org>; Sat, 20 Sep 2025 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758357225; cv=none; b=Y5Xi+v27qVUG6h0c2LglqCDfZwLV6CxRCR/E7T1BHAxAm43CZoAmGXsXbBBkflkMGZPaVSCkmrPzCYkrjvXwkh8cE7KfJ5pzFLG9KHIiDvwDsj2Ym+qjEkqFq0ZPR4ejVzvYotkZ5hguWsC+nB2mb2Xu3b0uUiVxtuZ91KNC8Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758357225; c=relaxed/simple;
	bh=mOljKVsNQT85PFtBknYKIYLOgsCWDEf30dbQsNTRluY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DIDzhpcGuxIluVatCoLqJ1Hl7O/f2e4c0wLVJO9lIYArsAim/25tgv/WApB5X4joXb9EMlNVerOsLnZIwNfwuouToicBX0ho4PeUFcYPrWPCXdQO1Q/eOIEaTfjTmCKi1eyMOOUPd1oDrhEbt60XqR6avWd6szaJSIHcW5pFxsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhNJuWDk; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-4240784860bso11159795ab.1
        for <linux-rdma@vger.kernel.org>; Sat, 20 Sep 2025 01:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758357223; x=1758962023; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jAyozsUsf0DIn//nrwo9DBi+OOk6EiYm8dFcKo1KRoI=;
        b=GhNJuWDkoJz1uXhVZYxUCJjy4h80q2yG9tvegAYVz2IYsTgAw4UO/4dZrfMjCs0vnF
         A/PNsUpy8dCC7jPhYNwdvYIdf2S2IzKP1K1TODA9SKh/k/9cTP/S+VVny/E9Sf39r7x/
         WXXC6axkQM06ywWsOCMoPy6eWC1E693LQVY3bNPPxeU1VrCrdvy2YmZQljsWAPDOb7c8
         54trvpUkMyrQJ4s2skccQ7EHrjmXKLbIDCsCF1nvIKM95d6PWHbeddFyG9dkq6GNdcOT
         p6VBrkzEOfsYcpZQ5E3PP8eDy3yUjCZzNdNBurP2U/5lEvsjKmJ7ZHB8TyTg2Zal4/Pa
         D6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758357223; x=1758962023;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jAyozsUsf0DIn//nrwo9DBi+OOk6EiYm8dFcKo1KRoI=;
        b=vMwvS1+0bGiwwsPKOc2Ox6jdvGWmMQl2p05FIa8MtA4H6Hp3iNMK6EnmgtUFHAYbGf
         2Zo5NdSbYcPoWM1pbpRVt8VeAc87WtAcOQtYwwHm7abyN2lhsoD8cnpdUyRiPwlsDa0N
         3KyjMsTLh1ZlhVX4rmIfjzFkw888uaKQ4oodlO3V70UGiXMdzGqvPZIPYxctKNgwbsJT
         S5kZiWU6IH/ROVdTxxRjD16BQWFkT/MBsfU6Qr+ZkTDug0pSB8/CwUIRPwKYuWK4xgwv
         B11GskdSGvO5hXD3P/GWw0XDvzCXzFJLf45WPu/b16PFYriogrHtN1h6EcbLPOAF2IlR
         JvtQ==
X-Gm-Message-State: AOJu0YyI6gSlYrndDkxAfuuubsiAkyv/ViqThub+DDbIYPkWIei27ZXn
	FmRfBq32B0Q6Bo3g/J0uVSY4VGx2v42ahIpyWEv3FZg2WcAWCSyt34oMUgRiTxAvaBBY+9MUUO/
	H70OgnTlmv63MGy5c3hg9GQzqyPgUsXydm9GA
X-Gm-Gg: ASbGncs+E0GtRf0JaJGQ5deEQRSV+RttOnd9pYm9ouIfGc6DMA4kulhJdQsQQf7zfWA
	T0PQrbYIKnsqw7ugUgbW/to9uagrlUaQDcprptWyhiUnamuq2lAJZ1bYJ1RObaERLh4XDZPzvks
	p1bjn+06M10Zkrv5wkUbLo97w8G+/PP17Ohf5PQ2H1rvN4k+zx7hbcZbiNdvvpBgHG+8lfbE8hb
	t0GbKq0COzIDs+ClA==
X-Google-Smtp-Source: AGHT+IGRuGpHgHF2LwUl9mqkw15zxVYIQV5hyLiqL5A7dwGluqKzLOxpBX2aw1Pn3iDIEVBl6WdH4tsHgfZfRB40tx4=
X-Received: by 2002:a05:6e02:12e9:b0:424:bec:4a01 with SMTP id
 e9e14a558f8ab-424819743bbmr81933425ab.16.1758357222945; Sat, 20 Sep 2025
 01:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ilya Andronov <ilyaandronov1983@gmail.com>
Date: Sat, 20 Sep 2025 11:33:32 +0300
X-Gm-Features: AS18NWDoJTe1dB9PQNNDk_iaOfILItGTuj6PigueJscGvE92Iae2fUne43Fq6Tw
Message-ID: <CAA9MXNTgdRCg0te=jzEontuLAdbTnfjr7o3cf6en4a=wYJs-Qg@mail.gmail.com>
Subject: librdmacm infinite loop in rpoll when timeout > 0
To: linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

index 005bd0be8..32fb30aea 100644
--- a/librdmacm/rsocket.c
+++ b/librdmacm/rsocket.c
@@ -3362,9 +3362,6 @@ int rpoll(struct pollfd *fds, nfds_t nfds, int timeout)
                if (ret)
                        break;

-               if (rs_poll_enter())
-                       continue;
-
                if (timeout >= 0) {
                        timeout -= (int) ((rs_time_us() - start_time) / 1000);
                        if (timeout <= 0)
@@ -3374,6 +3371,9 @@ int rpoll(struct pollfd *fds, nfds_t nfds, int timeout)
                        pollsleep = wake_up_interval;
                }

+               if (rs_poll_enter())
+                       continue;
+
                ret = poll(rfds, nfds + 1, pollsleep);
                if (ret < 0) {
                        rs_poll_exit();

