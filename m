Return-Path: <linux-rdma+bounces-9381-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7265A864FC
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 19:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D873E1895D10
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 17:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF4723E35D;
	Fri, 11 Apr 2025 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceRa2mQn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB8E23E350
	for <linux-rdma@vger.kernel.org>; Fri, 11 Apr 2025 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744393490; cv=none; b=pPNKZu5wuwaJ2P3wbgti8LKiy4alzvH6ywKQXbgmxv1mZkxCM2dCu0BS9KWOsbMYrdHvTAbrACeIAIXYvBLxzd/+pstfKTh6wK0yLDC5cJwlCRB1qnaVSIdQQ/QH8mf5J8Fa1HMc8HXD1U6IL/CqgtbpQCtGbNKbb2jMwotmAYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744393490; c=relaxed/simple;
	bh=+tz7nYh83j8WAzoKOf0jvFhZuJsaWDhOQUkrW+1lgco=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S5gMV+LSBlE5hu34hs4Gsk6Aisvy22mJ8kLpllQ2aVe7+BZrUyqX9OFTxIcPcTFKNBlKZpv3mcaIgPUzMzxgjgrGsGGsqhL/jPoT4JV4It/Y/dWNi2zfpk+TIeanTQ1PtyzkLd9zAJLBnrNoUomNGpv94t/P4rVn4H4D3g6LUsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceRa2mQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E787C4CEE2;
	Fri, 11 Apr 2025 17:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744393489;
	bh=+tz7nYh83j8WAzoKOf0jvFhZuJsaWDhOQUkrW+1lgco=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=ceRa2mQnb8HNwdrYGVpW2Jg5pPnQsu+eN+W4YmmSyzzRgQm5pCzTjg3tFjC9qlFtj
	 RiEXKYz5RHL9GWwA8w4mKQrPqYgmPZnOw58LJSMzzRM4Ep8KTYZlCEOoajJAlbEyM9
	 7MboFZ+gWoeirSbzGayNZmu6MsUmaFfnbY2DN9kW1VW+on302r+ijdfdbIA3bs9e8J
	 XZNwhooy0T6MQioHCa0k8U3omlM0qAWj4Ro2G8zPQLsyVnv8mQst3Jhucfm4jwK0Du
	 hzz6ycnUsq1P302KQeEClVFyEERE3zjj0S2dUR7Qn84BI8qOt8f7ehWcsfMeLelhYL
	 L6JaLweOnIaGg==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, jgg@ziepe.ca, zyjzyj2000@gmail.com, 
 Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
In-Reply-To: <20250409102701.1275265-1-matsuda-daisuke@fujitsu.com>
References: <20250409102701.1275265-1-matsuda-daisuke@fujitsu.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix mismatched type declarations
Message-Id: <174439348620.485070.1863436025199557603.b4-ty@kernel.org>
Date: Fri, 11 Apr 2025 13:44:46 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 09 Apr 2025 19:27:01 +0900, Daisuke Matsuda wrote:
> Some functions return int values while they are defined as enum resp_states
> variables. This patch resolve the mismatches in rxe.
> 
> 

Applied, thanks!

[1/1] RDMA/rxe: Fix mismatched type declarations
      https://git.kernel.org/rdma/rdma/c/81f4e032b86050

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


