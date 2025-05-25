Return-Path: <linux-rdma+bounces-10676-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D03AC32D1
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 09:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE92177303
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 07:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D736119FA8D;
	Sun, 25 May 2025 07:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0DQCH7a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B232F32
	for <linux-rdma@vger.kernel.org>; Sun, 25 May 2025 07:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748159475; cv=none; b=UnqCNVXfjCTL2nZlL9pIybRSWVaLgvHlz6pXjyXC3BrSudk7hVkW538UqZJQQ1wCTKgnsq055x7RrR72tIO7jw6BXQLKqH9z/GKo6hy89poGGwxOJxUrNvoyKZaKg+vTIALhI42fXMbjimdqT9bzvOUpdtOI2JRgR16DeC3T7Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748159475; c=relaxed/simple;
	bh=KERiaFdIXKMsjaQAhqKfc/StII6klagSaZ3B1XpLD/s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MAsvfsYtdf9XK7GLeSgsBOmgFMvHFZteJYC6LXq5rtDJxEVR/nmmBbuZBNbBAWAc6P7NSvsRbZ1Q6CYELdkE7SA9a4+TYF3NWJh6DNTnZrh2mi4STMyZhO6RsEPrBJxJsGgkZMPjbXt4ozstWUE7pfBkgQqgSJ6yo9XpJ5NpWao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0DQCH7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1323BC4CEEA;
	Sun, 25 May 2025 07:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748159475;
	bh=KERiaFdIXKMsjaQAhqKfc/StII6klagSaZ3B1XpLD/s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=e0DQCH7aZVHlXtAKCIlHy8pVQU4LR3CyjMzCaXUouTA8IwHWXy+MdazutwYQgEPlh
	 b1U2KkGK+0Ckhl1K6YD+XOOLLrgYhsj44jSOQgqX1rp4CquriV+npVTjBdJEJnyZKi
	 4ZLnzHq+ZrmOmG0eaow0MuIPzTBTzwI4E8oas8KXHhd/sTw9KCXH4tFKbaVBn4g1va
	 BGUzwHAtUOekgIOoMS7P51v2GwCyTjUjKgMR4wUnOYFyK/Xvz0tfer/UVsRmPhi/WN
	 l5A51JxMJwfpaCDgmZbR3clESFE0A+31WEtICcbyj4mK1ZfB0bGGGeUjrz6WSYyLq2
	 /0f4EJMXXfTOA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Vlad Dumitrescu <vdumitrescu@nvidia.com>, linux-rdma@vger.kernel.org, 
 Sean Hefty <shefty@nvidia.com>
In-Reply-To: <cdd2a237acf2b495c19ce02e4b1c42c41c6751c2.1747827207.git.leon@kernel.org>
References: <cdd2a237acf2b495c19ce02e4b1c42c41c6751c2.1747827207.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] IB/cm: Remove dead code and adjust naming
Message-Id: <174815947234.1055673.2752177997107285753.b4-ty@kernel.org>
Date: Sun, 25 May 2025 03:51:12 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 21 May 2025 14:34:17 +0300, Leon Romanovsky wrote:
> Drop ib_send_cm_mra parameters which are always constant. Remove branch
> which is never taken. Adjust name to ib_prepare_cm_mra, which better
> reflects its functionality - no MRA is actually sent. Adjust name of
> related tracepoints. Push setting of the constant service timeout to
> cm.c and drop IB_CM_MRA_FLAG_DELAY.
> 
> 
> [...]

Applied, thanks!

[1/1] IB/cm: Remove dead code and adjust naming
      https://git.kernel.org/rdma/rdma/c/a14a188879c80c

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


