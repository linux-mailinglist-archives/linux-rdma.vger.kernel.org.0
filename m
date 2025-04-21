Return-Path: <linux-rdma+bounces-9633-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD76A95078
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 13:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A3E1887562
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 11:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F56263C9B;
	Mon, 21 Apr 2025 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6+QA/7B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D554C212FAD;
	Mon, 21 Apr 2025 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745236394; cv=none; b=SjTVwJGBAQcSEXXG43kv+aaRRux4pdnGL95ivWykOWvdqBP0M+WxxSa+Ml9hnerZVhb7g28340qke/MhYsGkLT+76wQpPzJf1WmLk4502VtId51HKl2RuCKnMCkFasD0X8kvHNUjhCHP2ltvOguFjXKSCqJTb6eAN/pzEa1cayw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745236394; c=relaxed/simple;
	bh=TylbfHQw9P8PyoJO5WNWZaHGlrwRpzkWbdxjNY7Acfk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IqtIDnHJ76/5FpwkHVs3ocbWGiVNzvF9yf7y0oM1mtVz77ZS3g9ePRQOE9b4OzbLs0d6+it6rgRJVQ5yZOQ4WK/QNTfxCiQIAZ4kbIZdVEm0bId5yLc/uV6owR5wHAv/i6iGdJlW4SjODovWDcB6rrVLNqAb2xxrUAMLzCR8HAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6+QA/7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3AFC4CEE4;
	Mon, 21 Apr 2025 11:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745236394;
	bh=TylbfHQw9P8PyoJO5WNWZaHGlrwRpzkWbdxjNY7Acfk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=I6+QA/7BlQzGTIqfZe4thO5ajqGx74CGGQvGTQt6DjvOPwKZh/taEw6ftEi5bnDo/
	 2hqY/UnV9QLiwiXMKopdKQSG7E2OB1im4iRURN4zjCAbzlfYygj6Oixbl98RGDVGFI
	 00zOgkfS9IObhd3kqt9v7U3ySxY15sRtQWwCbRx2UZKoOZoaYR3DUMNcu19N1MwXzA
	 LuAf6A6hRVZmZfL6SEkZZHmH98t0sKKPEfteCjBwYjEdvR/KBVIzhvqiQiXsImVWSl
	 /eN5apxreS051IxQQ3O03GTiQlJBJw/E9i5vL01Dvy6n4vDVB8HSLOkSRGMqZMupZK
	 6LCs655cTO4cw==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, jgg@ziepe.ca, 
 Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250418051345.1022339-2-matsuda-daisuke@fujitsu.com>
References: <20250418051345.1022339-1-matsuda-daisuke@fujitsu.com>
 <20250418051345.1022339-2-matsuda-daisuke@fujitsu.com>
Subject: Re: [PATCH for-next 1/1] RDMA/core: Move ODP capability
 definitions to uapi
Message-Id: <174523638985.74512.12582679682707303482.b4-ty@kernel.org>
Date: Mon, 21 Apr 2025 07:53:09 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 18 Apr 2025 14:13:45 +0900, Daisuke Matsuda wrote:
> The bits are used from both kernel space and userland, so they should be
> placed in UAPI.
> 
> 

Applied, thanks!

[1/1] RDMA/core: Move ODP capability definitions to uapi
      https://git.kernel.org/rdma/rdma/c/685f9537a72877

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


