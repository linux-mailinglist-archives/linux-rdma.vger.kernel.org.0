Return-Path: <linux-rdma+bounces-10321-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C06AB5379
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 13:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69253BF36A
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 11:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E9628CF47;
	Tue, 13 May 2025 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaN2VNrk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F4F28CF42
	for <linux-rdma@vger.kernel.org>; Tue, 13 May 2025 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747134533; cv=none; b=Zea1KtkcVjkGFZHui87XbVncUg2xRrQfHDh0Nml5TdVhg2Ltp7dHmjbt0Y1U2gqS0kd4ImGamfeN1mfYAXPrQ3YhZ1HUB4MX9mCzYU+MOTwl56IXPE+sJHvEcvvmVMH3eg6FAPZMQ1aL1G8XyO+tXaPHLNFcArs1D67RBrmiqj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747134533; c=relaxed/simple;
	bh=m8HhBnye1vbZHLBCUiUdoVFp8LkZYbtlciaFZZbEh9w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J0pU3l7xodSBe1W6PW5rVmhM//KcgU7TNHmnv5oHvYwE2uIOebfaVdmxdVdW64MlAaoCESO7zCTcoypo5lr28x4hH8kSZwWa83c3jP5vPbwe7S2OxY6sZMtJAgj3qvcLqBJbU8yRacBL5GH66j7iaymRKvUJokGZ0pc36E2JK9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaN2VNrk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE485C4CEEB;
	Tue, 13 May 2025 11:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747134533;
	bh=m8HhBnye1vbZHLBCUiUdoVFp8LkZYbtlciaFZZbEh9w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KaN2VNrkO1UoVR2ggjCPIYyTvPD1DtMAvjoduvkt+qtlgHzV5mRjYyNDqKF+0BjB/
	 GsLm2BUpZJ2D/rQh9cZKiNQNNi7v3tAO0zKvmh+7IMAauNtpgyqFWSkS95TuvU69jU
	 ej5md9x3Viz8efR71nWg/pLDiDwKfXC0nlSTtLPwDFA9N3uYaVhzH6uJGZTJwJcWnc
	 M4Q3YTkNbqodZ71+F1zF/YV0/Vn4Yc5KIaZ33DuuF54GjddPhEZvy0W0uxpLCzdH5W
	 GrePauciFOOlIus3NNrhbguJb7LR+SPxqh+SciEtbm/eCwn7A2lekq8Z1D2dMO4Y2a
	 CKluOULrUUWjQ==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Bernard Metzler <BMT@zurich.ibm.com>, 
 Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Bart Van Assche <bvanassche@acm.org>, 
 Steve Wise <larrystevenwise@gmail.com>, Doug Ledford <dledford@redhat.com>
In-Reply-To: <20250510101036.1756439-1-shinichiro.kawasaki@wdc.com>
References: <20250510101036.1756439-1-shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] RDMA/iwcm: Fix use-after-free of work objects after
 cm_id destruction
Message-Id: <174713452976.700658.14495256764204686518.b4-ty@kernel.org>
Date: Tue, 13 May 2025 07:08:49 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sat, 10 May 2025 19:10:36 +0900, Shin'ichiro Kawasaki wrote:
> The commit 59c68ac31e15 ("iw_cm: free cm_id resources on the last
> deref") simplified cm_id resource management by freeing cm_id once all
> references to the cm_id were removed. The references are removed either
> upon completion of iw_cm event handlers or when the application destroys
> the cm_id. This commit introduced the use-after-free condition where
> cm_id_private object could still be in use by event handler works during
> the destruction of cm_id. The commit aee2424246f9 ("RDMA/iwcm: Fix a
> use-after-free related to destroying CM IDs") addressed this use-after-
> free by flushing all pending works at the cm_id destruction.
> 
> [...]

Applied, thanks!

[1/1] RDMA/iwcm: Fix use-after-free of work objects after cm_id destruction
      https://git.kernel.org/rdma/rdma/c/6883b680e703c6

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


