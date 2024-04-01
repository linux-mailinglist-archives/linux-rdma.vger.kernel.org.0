Return-Path: <linux-rdma+bounces-1699-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE311893AB0
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 13:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5FF21C20DDB
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 11:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE90208D6;
	Mon,  1 Apr 2024 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8wyAIUF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302A4EEDC
	for <linux-rdma@vger.kernel.org>; Mon,  1 Apr 2024 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711971906; cv=none; b=tfYynZllU/esOLWf2rRak+JHbw7o9skq20nB7MxQJ4sq0CNCLSQAjtMtArNqHfj/Mwc8qu+gZFeULWA0ej1JrOOWjzTs56LjbP59RiJZnUt2zJQMwkH+LFaNFFN/uT5D57dhTmBLdduuc9yXYDr2KFiUydZS90r5YpWlC+U0DsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711971906; c=relaxed/simple;
	bh=XQnB9hccONF1v23KIyrLo1h/QouqC1CPjBoYqj8aAfM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XV3W6f7qVQQW/075FZ77jjUdStjWIeE8JzR7AvAXbJF1MAzk9rmlXA3SrNto+wIv7mzaG/SuBDTM0Gecg3m6M8AxW31el7aYew7hyvGkx0IaS2YJjEwKcFB6uJ4QIc+xX0cgoiz+TEUVZISABk0ICi4Q9vX71j8a6wWFZHjB2Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8wyAIUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6ADC433F1;
	Mon,  1 Apr 2024 11:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711971905;
	bh=XQnB9hccONF1v23KIyrLo1h/QouqC1CPjBoYqj8aAfM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Y8wyAIUFyadLGYnIQI7Gj10PibcX9s4j2QU8AXQGvoB7An91aZgJjGK7SHkbUpr8Z
	 VnS3scKtrsIsgH9yIVtHQfVkEmwT2xkddyMHkD5qJXsQz2FRbfB5azSEu5fsc46U5s
	 hE1akzH0NwWMEZf2wD/hPb7cVItg4JEIDyZuKNTJ19KkLYXEZL6UsMNyqfLRgGAXn9
	 AyUNGe0+Va/CvlFqgSF2O6VFBMEhuybvlzSAFvxRHClH2SpvUDGa1DW9a4GUutCpu7
	 A40CdaRR0Hq/l8XIRQRypNVyv3XEFHVNIZaGCN3SyZuP26qAIDMmYfOITMIs8cjr8W
	 HXD8p72uNAdgg==
From: Leon Romanovsky <leon@kernel.org>
To: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
 "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20240314065140.27468-1-yanjun.zhu@linux.dev>
References: <20240314065140.27468-1-yanjun.zhu@linux.dev>
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix the problem "mutex_destroy missing"
Message-Id: <171197190207.74960.1054752722907299734.b4-ty@kernel.org>
Date: Mon, 01 Apr 2024 14:45:02 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Thu, 14 Mar 2024 07:51:40 +0100, Yanjun.Zhu wrote:
> When a mutex lock is not used any more, the function mutex_destroy
> should be called to mark the mutex lock uninitialized.
> 
> 

Applied, thanks!

[1/1] RDMA/rxe: Fix the problem "mutex_destroy missing"
      https://git.kernel.org/rdma/rdma/c/481047d7e8391d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


