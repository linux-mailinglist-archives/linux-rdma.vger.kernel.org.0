Return-Path: <linux-rdma+bounces-10151-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E98AAF5B6
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 10:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BEFA4C1DA0
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 08:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B1E261596;
	Thu,  8 May 2025 08:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cb8mv6kJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B7F1E766F;
	Thu,  8 May 2025 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746693134; cv=none; b=jv1TwiQYJrP6x1pKZa3PlH7XNbK97eDo56zVdz4IsymDOQoT7imrO+HK2wP2Xvc7qNKvEVdrzfsOmfaBkuy8KKsAa1GJiROXTYpB6ln47BBNpQNPvFLBzX2Gtq55prOA3Jy00WfSyWl6uKkAeTDLSE0qp5l8zAe0mZpNp57F3lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746693134; c=relaxed/simple;
	bh=34Tlq0bR/Itq3ABUj61hRwZ+7jK79J7TsoBbwyTc/6c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Nk2iLwn6IG3KNCBEhScm3O9gHyMLMppHuZDUhC+QDrhxSilcNcLFQet516v7E/P+En1HKD0pNVjuQb7k7II3sHvfQdMI49xCqOIOsDCGjReY9lf5iFDWWUcBvJwhR8JqAzdoGM9E9arz0cVoKhVMUqcv+sMelqBs0Y4nhHshTDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cb8mv6kJ; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-acec5b99052so121957266b.1;
        Thu, 08 May 2025 01:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746693131; x=1747297931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=34Tlq0bR/Itq3ABUj61hRwZ+7jK79J7TsoBbwyTc/6c=;
        b=cb8mv6kJj9zw5YqwG/dj+92DoYqUFXeECviBzZrWSDjrY8B7Zixz4S/zR1ztn9MbjN
         6zRLjjxUEaWT3yekh+iRKJLwrRxz8N6zWhGqzS64DKV2xQRjK7ZA8rzRQgJo7behkhBN
         nihqvffM8QaYmNgErXhySd8ndaMIAnSMXaeDCAyJn5zAO6zvlOkDHcBoKG+FYwiC8HbA
         8qvcVUbQLZASndRCshMXQ/VqDC52HP+e5YWnHsUXRN970kSZR2+ykwz4ljeAxratRiAM
         UMLLYROLH7WtSa8rPai6ZPKiGRifu8LC01upMlHo/zbzD7DyyZyXPZxoxAhABhi7i+NR
         JIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746693131; x=1747297931;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=34Tlq0bR/Itq3ABUj61hRwZ+7jK79J7TsoBbwyTc/6c=;
        b=WtfQgnsOGRJNAh9jiBJZp+BMKIO8daMHxSbsZPElfFiRW/8U2xnMZ8IuX1WCA9rKCQ
         lrS+4OHOzppuoa9a2KP4HjZNY5IzA9R9+atqjGmtQAkhh/qUlv8hNxFXDEmzUmr1ynYp
         3DqsJERQKVJFCyaKEUJggTT7W1pST197WP5sLRSyjarIJyNYbf77Ry9Ho06jDTFwGUgJ
         BhaZ5w5XLYHyjLn28bFveB/IUW/BfxItad1B9EJambQ6+JAjgv/ogd8f64df0MhAaau9
         eCI5a2dbdeeRj62PT73GOzjqHfatibylYjNIBdzyRWTMmP1ufKfTdBazKOwzMTFgItIQ
         vgxA==
X-Forwarded-Encrypted: i=1; AJvYcCWr1tLhEfoj+edqmn+3q21P8Qf+KpJEn2JP6RHDshEYjLWIzAJEKO1MOy01n8t0zM71YNMJjwDkvP07glg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmR2Czt39vpGQfMwC4CbN/hCZu7RjsFEqEuSsZWkBwPvUxPfA6
	PZN97CiVKF6EF7p8BZ2vGqPH38d82aaexJ9g72pahYpoDDGFxoHUA1z2PlTqveL5kio56Enp/v0
	MRxsWBo65wooCtgvAJ/ho5rBbd/Y=
X-Gm-Gg: ASbGncvsx2csUrauuoXiCfuKad3ARQLYJ/WJ8iluVY7PrxjsbkVruat0zjzHY677BG1
	i8ap+55tArmgUunUDvE9Sw9qf8QGtpWZLNYolSSMVeksUb91/fGvRuxIsoWdPxwsF1tkOkpjowd
	hv+zIj1u71BTMYb/gYdDklCQ==
X-Google-Smtp-Source: AGHT+IE0XhAHh8/ZLFi8+8bHBW3aCTYAVe/unFgg4Mfx3n6pSLNjSEMuWxmaD5dSMf22WaWo/NFc18jiUl0XskW0Yj8=
X-Received: by 2002:a17:907:181a:b0:ac2:a50a:51ad with SMTP id
 a640c23a62f3a-ad1fe6be513mr208304566b.14.1746693130537; Thu, 08 May 2025
 01:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Qiu-ji Chen <chenqiuji666@gmail.com>
Date: Thu, 8 May 2025 16:31:56 +0800
X-Gm-Features: ATxdqUHROIREOBTQNhd1V32wCcKcWok8wuIo5sqpaTlOB8IdUEj-gWxM4liGf08
Message-ID: <CANgpojX70kVOFMoJn=Mu93JEqaYoYCM3d1LhWcP-JKN9bm0F0w@mail.gmail.com>
Subject: [BUG] IB/rdmavt: Potential deadlocks in function rvt_ruc_loopback()
To: dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello maintainers,

I would like to report a potential lock ordering issue in
drivers/infiniband/sw/rdmavt/qp.c in the IB/rdmavt driver. This may
lead to deadlocks under certain conditions.

The function rvt_ruc_loopback() acquires locks in a conflicting order:

1. First takes &sqp->s_lock
2. Then takes &sqp->r_lock

This contradicts the established pattern in functions like
rvt_rc_timeout() and rvt_modify_qp(), which typically:

1. Acquire &sqp->r_lock first
2. Then take &sqp->s_lock

This reversed locking order creates potential deadlock scenarios when
these code paths execute concurrently.

The issue was introduced in version 4.20 and persists through current releases.

This issue was identified through static analysis. While I've verified
the locking patterns through code review, I'm not sufficiently
familiar with the driver's internals to propose a safe fix.

Thank you for your attention to this matter.

Best regards,
Qiu-Ji Chen

