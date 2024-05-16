Return-Path: <linux-rdma+bounces-2507-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594618C780E
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2024 15:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB7D28558F
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2024 13:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCC0147C6E;
	Thu, 16 May 2024 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=balaenaquant-com.20230601.gappssmtp.com header.i=@balaenaquant-com.20230601.gappssmtp.com header.b="chxD4Bb7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD8B4206C
	for <linux-rdma@vger.kernel.org>; Thu, 16 May 2024 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715867908; cv=none; b=R01ZiXQM0+mQQL2TGnyPc90M4pADI/CoBg2Z/l5QFO+w4u7WPXYMvhbaMcl8ywibCfyyoLdO0gGpnfzUxrEtcx58xrhcHXtgjlu+G7Krs9cpHaict33qJ12yI+JeEAeL/iIl5hJmJM9xNiL36tEarUOsT88j6aUHIUkp9h3Mgno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715867908; c=relaxed/simple;
	bh=dWZkC0616qE5MGvKvZDk9G6GUk4sZhOaqaXcwgs5qwg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=AJ24rIYAaf1ptA44knRKvk6K7h4IgdCs7e2XCiatGtQfxH9w07qswrF2kgSp/UbsjoNmxkpdLFLHtSY0RlekejPXxi4eMXVQMY9Yajb9t7WYpN7USa22XPU9tW6ETkvA+QADuXldWYjCX+ICDd9EYOXNNcCc9bx6RvwR/u33yiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=balaenaquant.com; spf=none smtp.mailfrom=balaenaquant.com; dkim=pass (2048-bit key) header.d=balaenaquant-com.20230601.gappssmtp.com header.i=@balaenaquant-com.20230601.gappssmtp.com header.b=chxD4Bb7; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=balaenaquant.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=balaenaquant.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a5a5cce2ce6so289260266b.3
        for <linux-rdma@vger.kernel.org>; Thu, 16 May 2024 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=balaenaquant-com.20230601.gappssmtp.com; s=20230601; t=1715867905; x=1716472705; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3qzOEmqGQdHW4Xnex6xUjWLN4B62tXV61U3GGentrGU=;
        b=chxD4Bb7aji3sDHTf0I41ed1Uq8Ed/etKUbCmT57QS6JZCvHwwRTeWzsZpy+bE4aOi
         jQWtRxQc+4I/Ol1FaWEf3VHRdbBLb6cEKlePN1IEoErPTjfVY6XbjUSzH9BHWVr7igft
         tgsh8DFwKR4ixTQbQHtwmfF0TsTu5uvrSgwxnPHk+p/IaRtP8ZMX1eur/fXumGn0NrfF
         +sO97XN23/f/zr4wZ4RHbTVkunbA2s7CDpaEKRLLFlltWKpzKKhTUMLtiuf06oJmw05h
         Ks3JZyJ4dBE7H8mGHTkPCgienLC15buksOZCmDiBhtV/DIDXZciN/F9bvQ+gB5RbYtFp
         SVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715867905; x=1716472705;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qzOEmqGQdHW4Xnex6xUjWLN4B62tXV61U3GGentrGU=;
        b=nN3WUGAjyDmmEywFz/4ovoNbs/bLHRD2ISNrfzFqY/xTmI0i5TUzIVvg093dm8sBaa
         b+zke0+FCV+pK6X33h/KDM5nPGZQ2/tfRzKV/71guNsPcRqujsnribACHdlu+EQ1671K
         H6SMNFA7obBnCp13845EwD7iThnhTVrQm9uYUbIDziJZ+9ji7Z+WnIJKztkRkJvFA2t6
         pbNXYM+qV1QoaiKlbc8cfnIHxBowSwaKWW/PGOK6T2eTlHs3F3J8RERg3yyXSCYz2fND
         02JXR6VsY47viVzK4G4SzcjoC5KksvZMhjTCf3s4xZOSVcrmJmRrFgUK15lQoGGqeUwr
         djtg==
X-Gm-Message-State: AOJu0Yw5A4d/lGjCBjokAALoWNlWsn8FJyBGRrdNasloOyOCxxs72MXK
	rWy2XpbW4bSqNOo/2+gYnBbxkmIkIWaTnEs1LZtqr93f0yP8PYnFDvobCrHr8/QB0y0Lbi3A1qY
	WAbvuxJbpLFtitd1ij328qS4++S5UHRT1mEWrwqMtNMek4pk9G/R/IQ==
X-Google-Smtp-Source: AGHT+IG8NkAjZdOw7BDZqcPGG5ojq+6P3AP+IFqp6zqbgBtBFZM4kC7/ONOaUOy/erIyHjIEU9fhfYnQ33zITPLFTQ4=
X-Received: by 2002:a17:907:7daa:b0:a59:ddec:b339 with SMTP id
 a640c23a62f3a-a5a2d66b530mr1492643166b.50.1715867904630; Thu, 16 May 2024
 06:58:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jun Han Ng <junhan@balaenaquant.com>
Date: Thu, 16 May 2024 21:58:13 +0800
Message-ID: <CAJTiWe+M-gwPb-GvCvcNrhtrqj96NA34YTRLAQsLS0ffucK+Cg@mail.gmail.com>
Subject: ENODEV in rdma_create_ep with loopback as address
To: linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When attempting to call rdma_create_ep in active mode with the
loopback address obtained by rdma_getaddrinfo, -1 is returned with
ENODEV errno(). This is reproducable by running the rdma_client.c
example in librdmacm/examples. The error is not appearing when the
host provided is a remote host from a different machine with a
different IP address.

Looks like the exact point of the errno being set is at the write
function in rdma_resolve_route inside librdmacm/cma.c. I am not able
to go deeper due to that write function being preloaded.


My operating system is Ubuntu 22.04.1 and my kernel is version 6.5.0.


Below is the output of my ibv_devinfo command locally; I appreciate your help.

hca_id:    rx0
    transport:            InfiniBand (0)
    fw_ver:                0.0.0
    node_guid:            2a6b:35ff:fe76:0e8a
    sys_image_guid:            2a6b:35ff:fe76:0e8a
    vendor_id:            0xffffff
    vendor_part_id:            0
    hw_ver:                0x0
    phys_port_cnt:            1
        port:    1
            state:            PORT_ACTIVE (4)
            max_mtu:        4096 (5)
            active_mtu:        1024 (3)
            sm_lid:            0
            port_lid:        0
            port_lmc:        0x00
            link_layer:        Ethernet


Thanks,

Jun

