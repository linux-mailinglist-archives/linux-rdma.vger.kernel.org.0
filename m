Return-Path: <linux-rdma+bounces-12697-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF62AB2475B
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 12:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D441AA1A7A
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 10:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789DC2F530F;
	Wed, 13 Aug 2025 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uk+6PEHh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C592F49F3;
	Wed, 13 Aug 2025 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081239; cv=none; b=pyW+wJLEXrtvTiEpscUGvkCeGZrqJTyusEf6ZhHlISE4bjuZXSig+54G3UoBP53DaCMU8izIx34/N6vBq4bMXCcEtYJKOFVPZR5pw0yAfxLgNk5m16zrgfNYHn0dAkdiT1ra9+zxLtVekAUzNtmAnTIF/aWjnPd401tcGbNS7Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081239; c=relaxed/simple;
	bh=ibSiAKvvLIaj4EmlHJ3kL+FP/7fp1vaX7HbyPQtMYh0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c5AnLw0VHAqEJlCGiUkrlghvp39RBlIxLbxeMvK7Wm2IAJ9VidApc4dVDOOELpg+UsTaU5Y3y5u1Ett7nsJeaGZdnpf2LxfYYeajjhTi6+xoGnM8Sws6iJsoixIA8bGm0jpC/MoeS5t1eehrvr3dN2zS8XIJ2YNInfFKN0nKuFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uk+6PEHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579ECC4CEEB;
	Wed, 13 Aug 2025 10:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755081238;
	bh=ibSiAKvvLIaj4EmlHJ3kL+FP/7fp1vaX7HbyPQtMYh0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uk+6PEHh5n9tFFC+PFsOGJ7ZP7bMqqtdGXtgvf/v45SPZ/38NKrTHrPXUXDxjPYSi
	 6Jz6eFC8GnUL43BIk2BnCYg6gCwUsn8ZCKNjrItUSRvEhyQioYuINor20YMl/dJ9ZS
	 iG46IjmtI57XColv77LPCW48ttKfG88H6WPqMngJpHKi8G1tUVBj2nrt+MpL+qoL7O
	 JDLEjdQ/IpdLJHLCLnwgJlYOp++ZMzKkVSnLUy5KfLalat7nmDsMGlMQw8B+Uw3tqz
	 zZBNcuOxAwiDs/LuxGRIg3H2fkiERqgYhTeraNwwD2QUwhWpcRjX/pu0umFgr4Mmsg
	 4nRXZuMdtVbSA==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, longli@microsoft.com, jgg@ziepe.ca, 
 Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1753779618-23629-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1753779618-23629-1-git-send-email-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: drain send wrs of gsi qp
Message-Id: <175508123598.198881.15976175399276226574.b4-ty@kernel.org>
Date: Wed, 13 Aug 2025 06:33:55 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 29 Jul 2025 02:00:18 -0700, Konstantin Taranov wrote:
> Drain send WRs of the GSI QP on device removal.
> 
> In rare servicing scenarios, the hardware may delete the
> state of the GSI QP, preventing it from generating CQEs
> for pending send WRs. Since WRs submitted to the GSI QP
> hold CM resources, the device cannot be removed until
> those WRs are completed. This patch marks all pending
> send WRs as failed, allowing the GSI QP to release the CM
> resources and enabling safe device removal.
> 
> [...]

Applied, thanks!

[1/1] RDMA/mana_ib: drain send wrs of gsi qp
      https://git.kernel.org/rdma/rdma/c/44d69d3cf2e804

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


