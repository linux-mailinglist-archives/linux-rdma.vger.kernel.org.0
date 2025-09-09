Return-Path: <linux-rdma+bounces-13189-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77064B4A8E1
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 11:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0085B18986C5
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 09:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956082D6E69;
	Tue,  9 Sep 2025 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSTQaWCP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344512D6409;
	Tue,  9 Sep 2025 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411373; cv=none; b=LI6ah92UQA3QokMaXgBFup3otQrFNjo0h7JJvzaMbWN4/w9c7o9HSa5rpesa0v52cYGWiDRn3KrBaha4Nztm0S0Kbu73RfI8sMeyUzerRFgTmf4PbMitOKYA0aZsY7691cjxPL3KH1RpUqAeJKa4EAji7aNKo4K2A7EVFzRw9AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411373; c=relaxed/simple;
	bh=P5GF1pyVZK4wsqoSxde4fu2q2Ft5nwqqJBAqZM/UmRg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DH1cp+Q3FcJvNXzxRoCQKhaGeit7CTOdd+VtYOZTHwfNMbMhzKAP6AyjNi+aI55IPEMfuHOBOfgCIdPmvWYyM0qTAot6thgF05xecx0+U9kWOq92bVviOY9nw4Td29+m5Cd9J2i4zN2ZZqGuie+g+Hah/sX5ZO8UruKCuKPOjNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSTQaWCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6F2C4CEF4;
	Tue,  9 Sep 2025 09:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757411371;
	bh=P5GF1pyVZK4wsqoSxde4fu2q2Ft5nwqqJBAqZM/UmRg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cSTQaWCPed+j2D2/LPxso21eoNUhGrHiPofIhqeh0++gsbluQ7RDA8lm6TQsNVKIs
	 ecZqytYEfbiUf7htOAtQkPbXWWYCBntqrZblAjV3TyL7V0fQHitiwnfdX693AZPJoJ
	 z16sANsP0/Wac8OmmLMV5Am/F8tY8MZNJb5g6HjHZbKzjdGBa+mcy0CKHWRmmCEam0
	 hpc1du9hUw4Mzklemt4EziMlrgsONd7NfB692A7cSd7leQejqn/+efPypie67/4msY
	 IwH5A1Tkfv481Z++H53ANdHIKK1u88IxK0frl+Hd4EyKi2K3evwpvw6V+dZInSq9oQ
	 M1EF7amzk6ArQ==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Xichao Zhao <zhao.xichao@vivo.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250827120007.489496-1-zhao.xichao@vivo.com>
References: <20250827120007.489496-1-zhao.xichao@vivo.com>
Subject: Re: [PATCH] RDMA/core: fix "truely"->"truly"
Message-Id: <175741136890.672925.14503194976378968166.b4-ty@kernel.org>
Date: Tue, 09 Sep 2025 05:49:28 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 27 Aug 2025 20:00:07 +0800, Xichao Zhao wrote:
> Trivial fix to spelling mistake in comment text.
> 
> 

Applied, thanks!

[1/1] RDMA/core: fix "truely"->"truly"
      https://git.kernel.org/rdma/rdma/c/8024355cfc1e77

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


