Return-Path: <linux-rdma+bounces-738-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A3783BDEA
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 10:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAFD71C210E5
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 09:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5061C6BD;
	Thu, 25 Jan 2024 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lh80SxsW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CA41C6A6;
	Thu, 25 Jan 2024 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176292; cv=none; b=AXIU5kftx/XCWubKcQGg6uFFtccab1FWFYJ5gD4+0S8+FZxeswNzITlf3D8Ejad+1zPTZojEWcaJp/4t8TzexLAl0c2EL9Sg7fZq9/osMFpyOfgvit7ETSpcMktpONsiC+teg/dV3CGx8Ts7ppSwk9qe4Z3c4VZ1Rlvp0oWPNzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176292; c=relaxed/simple;
	bh=hGzPC+Xq5xvy6+xs+vZ48PhfdD49wV5ssqstwwv4No0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Pd4OyR9BGy+l/IV0YFvB6rEmvgMCrW/NFYmsk0J7vWohC7CtqZd2o481SUxRffPyehX0mgF2SgEUMtymvwhKVCtrzVbf693AvwOdXs5wP8UyPAA8BHH6zgHgkNA4P5o9H53/Th0NY1gj6LQPPDVpZrsTkAbysfwRPiKJ3xhG2dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lh80SxsW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFD5C433C7;
	Thu, 25 Jan 2024 09:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706176291;
	bh=hGzPC+Xq5xvy6+xs+vZ48PhfdD49wV5ssqstwwv4No0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lh80SxsWTQmOGpfJIknGv744VRKHLl6xMyzjYE+ZQB+/+pi059FqIqgXfr6zXi9bD
	 s0dJMcGaDkvPMCssMWqS0QZffxjdkcsV4PTJQF3skGD036ekbKqo2jbeXhPe/V+Y+5
	 T0utB48+C7w0vdF5IWEg/J5je1EOr703N0eIS5wvq1aHXIMSHpXuSoXVImbmLzvhQ4
	 nhMWkm1Na2LlAWx3WsWaiBKjrDg7yfG1yQ0NOfz69FFQ/Zi3j/b3hnRNtRaKePXzwP
	 d0jmSz8cXbek5TQGLzkVLixLlJnFB3mn1MWP+GElnXAzPAAoHqs+UQr3bVsjnMf1Yi
	 JCMo9JaCLtnIg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Christian Heusel <christian@heusel.eu>
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20240111141311.987098-1-christian@heusel.eu>
References: <20240111141311.987098-1-christian@heusel.eu>
Subject:
 Re: [PATCH] RDMA/ipoib: print symbolic error name instead of error code
Message-Id: <170617628743.631264.7207470107458007610.b4-ty@kernel.org>
Date: Thu, 25 Jan 2024 11:51:27 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Thu, 11 Jan 2024 15:13:07 +0100, Christian Heusel wrote:
> Utilize the %pe print specifier to get the symbolic error name as a
> string (i.e "-ENOMEM") in the log message instead of the error code to
> increase its readablility.
> 
> This change was suggested in
> https://lore.kernel.org/all/92972476-0b1f-4d0a-9951-af3fc8bc6e65@suswa.mountain/
> 
> [...]

Applied, thanks!

[1/1] RDMA/ipoib: print symbolic error name instead of error code
      https://git.kernel.org/rdma/rdma/c/64854534ff9664

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

