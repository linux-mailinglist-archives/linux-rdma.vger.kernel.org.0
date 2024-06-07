Return-Path: <linux-rdma+bounces-3006-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4846A900D05
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 22:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6DCF288D41
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 20:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6AD154BE4;
	Fri,  7 Jun 2024 20:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JczuZEET"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8CA143864;
	Fri,  7 Jun 2024 20:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717792371; cv=none; b=P1lmhmltIUCRjSMl0kFq9GNhIkwVSzUIhkRNRCIAqe7UGzRl5We4FS+6aGGkB7q5IEk9djtgXF1Q1Iz/x1D2Cmvx0MexlGH2ogpoXZZQ1ChT0Y5daCNtjQTuzOJ+vBzDZZ0Xc3uXsVncdAwyrMc1jy8snbPTJjnMZtgdDmCt2hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717792371; c=relaxed/simple;
	bh=cQS3SD3BPxuj8SuRnqpzvh5wVyukzx93gck4SNGGdYE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pji5xthcKDyxRWfIXQkRZpvTUl26p6hyHRHYCWLyC5UIrPLbEQX9BSuVYp53a0oFOnAzFE8m13w/d7/fomF43CSpvwqBZc1EVy46VVVLbuC7rV3ae6tBcygB9JnJPPzDYEAOhPc+mS0mjC9vCdbraTU0QoP/egPrAH+zuLld0yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JczuZEET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F0FC2BBFC;
	Fri,  7 Jun 2024 20:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717792371;
	bh=cQS3SD3BPxuj8SuRnqpzvh5wVyukzx93gck4SNGGdYE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=JczuZEETSt8ZKgu0sh6D9aTbTcq+mqMZlw8pQFQOHG+T5xSafn6vY9Lc7owldFs0x
	 sEbsmYEAz2182B8LwxmUtWbAm6vj2z2nE8yILXdGmlyVAHV8clBgMvooXTY27NTad4
	 We8vD99+OB0JTgivP9CO1fb95Lj23ZVuZk0nxWIkZGGAtt1t5Vze/QU0NXKsMhbg3g
	 50C3hwxCyuM7FflN8XMcpQvlk3q2uQRsclZJOZphzUEGHBRW+DAubWWvswmuoMQpQ/
	 7gpONk1qu5NsSwDtydhxvmrSbZBTjEC0WI10ggc9FMkBGjzC+Luo2s7ywhSbDeNXu5
	 Bmh94AkOMSvlA==
Date: Fri, 7 Jun 2024 13:32:50 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "D. Wythe" <alibuda@linux.alibaba.com>
cc: Matthieu Baerts <matttbe@kernel.org>, kgraul@linux.ibm.com, 
    wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com, 
    guwen@linux.alibaba.com, kuba@kernel.org, davem@davemloft.net, 
    netdev@vger.kernel.org, linux-s390@vger.kernel.org, 
    linux-rdma@vger.kernel.org, tonylu@linux.alibaba.com, 
    Paolo Abeni <pabeni@redhat.com>, edumazet@google.com
Subject: Re: [PATCH net-next v6 3/3] net/smc: Introduce IPPROTO_SMC
In-Reply-To: <e6b66001-f3cb-4367-aeaf-600fbc5f77b2@linux.alibaba.com>
Message-ID: <ae0e195a-28d2-039f-6f3e-65161ada47d7@kernel.org>
References: <1717592180-66181-1-git-send-email-alibuda@linux.alibaba.com> <1717592180-66181-4-git-send-email-alibuda@linux.alibaba.com> <6e0f1c4a-4911-51c3-02fa-a449f2434ef1@kernel.org> <ffe06909-6152-4349-9b60-5697a038ac19@linux.alibaba.com>
 <ed6bde75-2783-446e-b667-204ed55071b5@kernel.org> <61b94bf6-a383-afff-db62-261cac7360c7@kernel.org> <e6b66001-f3cb-4367-aeaf-600fbc5f77b2@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2041299453-1717792371=:89802"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-2041299453-1717792371=:89802
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 8 Jun 2024, D. Wythe wrote:

> Hi Mat and Matthieu,
>
> Thanks very much for your feedback!  The reasons you all have provided are 
> already quite convincing.
> In fact, as I mentioned earlier, I actually don't have sufficient grounds to 
> insist on 263.  It seems it's time for a change. 😉
>

Ok, sounds like a good plan.

> Regarding the new value of IPPROTO_SMC, do you have any recommendations?
> Which one might be better, 256 or 261?

Not sure there's a clear winner. If you use 256 that could be a hint for 
the next developer to use 257 for a future IPPROTO, so I slightly prefer 
256.


- Mat

--0-2041299453-1717792371=:89802--

