Return-Path: <linux-rdma+bounces-13510-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88BBB87C6E
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Sep 2025 05:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8850A580EE6
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Sep 2025 03:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B46244671;
	Fri, 19 Sep 2025 03:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQVxOCEb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA3C1DE3AD
	for <linux-rdma@vger.kernel.org>; Fri, 19 Sep 2025 03:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758251767; cv=none; b=uHTAFrOgcUMRRxDHP4jiBOdmwWi+vCoBEW5XcomIUh6PYJNHd3t96iKIrb1Qch6xcBBacFwe5C1mMQ7btU7o8TTL/LNEA178l0L+de4gHdb3Zjuo7JRMi8FBbrey3YjeVwMLuwQLYJWn3DCENvu/M0fKWqEbsmfYSbTK27oH7Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758251767; c=relaxed/simple;
	bh=SKwgfiNki99HQfE+BDZ76jqOzfurZlN2ZbRA0KdOE1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8Cf04SvUGES2oWn3hF9AwXD6CFsXbKGAwJyOZmb9M7gzkovGsjHCfTuSmRk/onvI0cj6bSGcUAhXksYXLjfJZpLzr+ZBwCc7U3Xe9p1IqvvGY3HfilnCmk1tISlCfyvy2LcWk9jwqXgX7sGgJ8zDKXsGEcbbeW3oWCcECwrp18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQVxOCEb; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62fbfeb097eso745195a12.2
        for <linux-rdma@vger.kernel.org>; Thu, 18 Sep 2025 20:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758251764; x=1758856564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SKwgfiNki99HQfE+BDZ76jqOzfurZlN2ZbRA0KdOE1M=;
        b=fQVxOCEbPGqx+dyhkUUZdDEk4b63Zk/s12muZ+R6pMhxdVG86lkIAXMQFVv7314MMj
         bAMQglMPKlwdjtszbOvFLJU+EiK6GjIAxrrZawu2rzJ1cuX2gHE2rNY3YwiRne38pIuj
         90oi2TzIvuU6krD29TnDAuE60mGfJGZ9iFM1hyjFPQ5Csp+CHPa3/mONCLa7xDtxpuXW
         zmz+/da8FrjWBr9LeDtMWNBm84ArE8t8uWF4s5aVq0o1tOpRbwH1wMiXOZaucC6TSZ7L
         A+GhSnfVU98fPnDScZPPyZby28hX/i0gHspmQLSjy7p84RG7Oh7gV1Enhd3JFKKib6TV
         JgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758251764; x=1758856564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKwgfiNki99HQfE+BDZ76jqOzfurZlN2ZbRA0KdOE1M=;
        b=TY9WN7aYeJi9dWKAwV+Gc17ghIITxvt1dTreMXN2xeNvNJtIEYZCR6wqpPHdXgb8g0
         w5Xe8z8JhlxhzsR5qYMShJcQa9EoUE0YHhQAzU+WIFizLcXgodLsrmGLNOn3Da4Mue3s
         W3DFUM1/1GQ9fWJ52uJXXSLc52CwfXCmtNcpRr8rhG4vXUEav7cnGSSH49CqHWAYxwQG
         TF17+X+Be2nHUmqnGIvDFe8wvgGGQQdcZKCXAjijE1lBKb8X7SLHdWLXiy3jb06wfGnM
         NXm+TLFxVpHfBJQJOcGEtxLQFcoBqlDFX8siQ4l5o1s7TlmLCDMyeMJ/KY8k71XAqmu9
         hdcw==
X-Forwarded-Encrypted: i=1; AJvYcCV8IKnD7YW6fDDdGeOhLSZChoeOTpX1XpWXft9Ge1DKrS3Jdz3vdFmsV1Ker8lVKBezh7KPVwnAojTd@vger.kernel.org
X-Gm-Message-State: AOJu0YzTXdK/pJUjcqj2finOxnJUEMgjVnbJKJe8beqUVjAVymkcosDI
	L2dbgDLBOOQtaj6Qq3sylyrGqeOGZsxEc8/JGHXdbcxKHevXvii4QsAk+2MUw993b7MQnsAJdFm
	b9DioeSHLTw7gBj3Bz2GE7xZxmuowvKY=
X-Gm-Gg: ASbGncupp6MXjJo/PctCy9UiJ/8nxoKHKw4mL/kPDTtIUnmypfPHGisl1lxam+KSeAW
	zOpWtE6RHqEbpp0kUcp6zvctx3/C7e0odHDGFH1zlFbISdSLB5hGazhNLXGgxrMB0Zyat9PWK/K
	TxvDKfIXnn+yk0PUbF3BtPeA+E3f9HZNSPoIOaoQ45YzuVpCkUI9fVCFSV43qvYmss7aSsrB130
	dloOUy9
X-Google-Smtp-Source: AGHT+IHpuZQvB5VjDIkqb6EILgkWDUV5pQg8TL4O9i66Ma8EIkoa3WtmJBAeGAlFDqdQk9Kqs1c+lPs2vKiXQxoNaR0=
X-Received: by 2002:a05:6402:51c7:b0:62f:3531:d905 with SMTP id
 4fb4d7f45d1cf-62fbff7b4bbmr1183252a12.0.1758251764087; Thu, 18 Sep 2025
 20:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917100657.1535424-1-hanguidong02@gmail.com>
 <a321729d-f8a1-4901-ae9d-f08339b5093b@linux.dev> <CALbr=LZFZP3ioRmRx1T4Xm=LpPXRsDhkNMxM9dYrfE5nOuknNg@mail.gmail.com>
 <abc0f24a-33dc-4a64-a293-65683f52dd42@linux.dev>
In-Reply-To: <abc0f24a-33dc-4a64-a293-65683f52dd42@linux.dev>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Fri, 19 Sep 2025 11:15:28 +0800
X-Gm-Features: AS18NWBWy3JSGoTuAR7nCC9TldQxYSoxjAO81Iqekfd37aXEUhor2yl6szKD32M
Message-ID: <CAOPYjvb1vEzgRM_m=FsjDTTuyGMWpxgK7UfmS458rbN6orVjtg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Fix race in do_task() when draining
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, stable@vger.kernel.org, rpearsonhpe@gmail.com
Content-Type: text/plain; charset="UTF-8"

> Thanks a lot for your detailed explanations. Could you update the commit
> logs to reflect the points you explained above?

Hi Yanjun,

Fixed in the patch v2.
Thanks!

Regards,
Han

