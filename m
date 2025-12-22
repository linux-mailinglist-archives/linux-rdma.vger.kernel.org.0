Return-Path: <linux-rdma+bounces-15143-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7892CD539D
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 10:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CD73303A09F
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 08:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E5B30BF6A;
	Mon, 22 Dec 2025 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idU1gQl1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32931F3BA4;
	Mon, 22 Dec 2025 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766393920; cv=none; b=XgrxrZsJozgznackHVtMZGfu07i88gUWiREIuSSs/m3jH/3h2zmS5johpO9NAmf22dOhmtN3usUUIS7dyiHgt9HVkPeKcE/BCCIHyyuDScb5OO2VfAG0RDL/phBx5euzLDhT8UaP3XGNXQfaOMAUD7BntGO1i84O2oZTVGXpHQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766393920; c=relaxed/simple;
	bh=vV3U8TRb1+bpf4EKXWi1+Sj6p+Wedrxxe8bAhv7WhoY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sHZxjJFYvQcfIS3RUj8k3iRGTcIfMw3jzhsTrSnE22jGvSj9QHxSic501kGXvCTb1pryavq1jzYzQTE90mGx289saCh6JrfGusuiDVIR1FjokxFEiTlycLldiqYXpEmZLrQNIeFY5tQvccBYJHo1TBfM7RuN+xX76rSK7KiK9Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idU1gQl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18C4C4CEF1;
	Mon, 22 Dec 2025 08:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766393920;
	bh=vV3U8TRb1+bpf4EKXWi1+Sj6p+Wedrxxe8bAhv7WhoY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=idU1gQl11FdrKJdei9FmYZxojaj5GY59XIlVchaIVdM4hbRQv/b5tyuSuUcpuaUUO
	 ymv3ehb5mUSTf4xLBTpdZNIjA3Efapjzh0Sz+dn0bXS8xljnp1d3MxwrLqzHwGCAi+
	 rsbHCZQyH9WE6RbfBlXzunCWDTtIfeKheg92W1Se7vXP/aX3jDkqIltuJYnQ3ItKR3
	 iFhjG1Q7XpeR9UfovRfGUrLzCtANtCZI/MihQLCm+v4gMStULLktcb5FhhO/LqD7aY
	 UMTybYsNnRBaqnJxb/iSzNNdnpHBfzTRP6CIpe0KW+cFpl9ns9ALLOK6r4/Ve9O2vD
	 xc8s3AKx/i/bg==
From: Leon Romanovsky <leon@kernel.org>
To: selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com, 
 jgg@ziepe.ca, saravanan.vajravel@broadcom.com, 
 vasuthevan.maheswaran@broadcom.com, Ding Hui <dinghui@sangfor.com.cn>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 zhengyingying@sangfor.com.cn
In-Reply-To: <20251208072110.28874-1-dinghui@sangfor.com.cn>
References: <20251208072110.28874-1-dinghui@sangfor.com.cn>
Subject: Re: [RFC PATCH] RDMA/bnxt_re: Fix OOB write in
 bnxt_re_copy_err_stats()
Message-Id: <176639391713.5064.888930023466388507.b4-ty@kernel.org>
Date: Mon, 22 Dec 2025 03:58:37 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Mon, 08 Dec 2025 15:21:10 +0800, Ding Hui wrote:
> Recently we encountered an OOB write issue on BCM957414A4142CC with outbox
> NetXtreme-E-235.1.160.0 driver from broadcom. After a litte research,
> we found the inbox driver from upstream maybe have the same issue.
> 
> The commit ef56081d1864 ("RDMA/bnxt_re: RoCE related hardware counters
> update") introduced 3 counters, and appended after BNXT_RE_OUT_OF_SEQ_ERR.
> 
> [...]

Applied, thanks!

[1/1] RDMA/bnxt_re: Fix OOB write in bnxt_re_copy_err_stats()
      https://git.kernel.org/rdma/rdma/c/9b68a1cc966bc9

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


