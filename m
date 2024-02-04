Return-Path: <linux-rdma+bounces-884-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C28FF848C98
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Feb 2024 10:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5689B1F2246D
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Feb 2024 09:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEF41947B;
	Sun,  4 Feb 2024 09:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtiEFSzg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1135D1B598;
	Sun,  4 Feb 2024 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707040010; cv=none; b=YatyqrLYCjI+BupYzVqEa0yAV7fUqwILWEOFGyy9OjVbjobgp2uOkNOZXrkNQzX5teaHJDaoN4wz8WKOtJXGCxK7EL4Z6CMlcX4VCakk4kp/Nd/IeM9achJzU2Zpbxx3TZoOaOGPGJcLMNdv6b5I0P5ArR4SQulZ+VDfwa3/rUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707040010; c=relaxed/simple;
	bh=L0FUKnPPslNEOHaAtIO/Hf8LDgPydAO035BdUFkhCnI=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Jem6xACZAhfU4zIOlJLaTJ0maETFffIFzE8jQrr3dayVWhLvSxwdbVIk3HDpSoe9syUj4tzPNDNzAgknc9VSegYehMV2eoYdaaqSAqPIqsO8lHotKsJWRLgKPDsnhpRX62aHZA3be/dR3Fb0mrB3QaZt1qtKfnF/gYnOpgL7CXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtiEFSzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC66C433F1;
	Sun,  4 Feb 2024 09:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707040009;
	bh=L0FUKnPPslNEOHaAtIO/Hf8LDgPydAO035BdUFkhCnI=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=UtiEFSzgww2N/GA4ZUuvzqRF8yhLz17s78w5C12mX7f4Tv8Ycs2rDKHJmSkc81wRC
	 FpTwDNCPKZ9JOsGZoKd3ADJpjxdsRnSpkA4h4tvinFGEt60JR5PHX0SE1ntweQqi9g
	 vihhdbIPCT1F8xcbyBPMj3D1i02e99X7a1fjvasmyvKRQuyNeS9f6eRWV/JT+AoESI
	 st8scVXxQJGmL5daTxJJmOcMwvewS6XqxmQthnXgpTb0cDLJBcwp8q4q93f6mHLM/f
	 ajoMOIC6Z4dA2a7e+IPAFj01+RNtwZq7VPjzx4hdsf844Xn69IDayAqiF8FW2RV0bS
	 ASa1Rv6/hW8hw==
From: Leon Romanovsky <leon@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20240202091549.991784-1-william.kucharski@oracle.com>
References: <20240202091549.991784-1-william.kucharski@oracle.com>
Subject: Re: [PATCH v2 0/1] RDMA/srpt: Do not register event handler until
 srpt device is fully setup
Message-Id: <170704000556.17316.1563669837408742257.b4-ty@kernel.org>
Date: Sun, 04 Feb 2024 11:46:45 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Fri, 02 Feb 2024 02:15:48 -0700, William Kucharski wrote:
> Upon occasion, KASAN testing would report a use-after-free Write in
> srpt_refresh_port().
> 
> In the course of trying to diagnose this, I noticed that the code in
> srpt_add_one() registers an event handler for the srpt device and then
> initializes the ports on the device. If any portion of the
> device port initialization fails, it removes the registration for the
> event handler in the error leg.
> 
> [...]

Applied, thanks!

[1/1] RDMA/srpt: Do not register event handler until srpt device is fully setup
      https://git.kernel.org/rdma/rdma/c/c21a8870c98611

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

