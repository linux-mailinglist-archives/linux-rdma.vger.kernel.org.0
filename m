Return-Path: <linux-rdma+bounces-7722-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DFCA33F88
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 13:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25EF43A8E30
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 12:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9B7221568;
	Thu, 13 Feb 2025 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdUN6iO7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B89421D3FC
	for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2025 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739451228; cv=none; b=uLlwvQlVFzoEbqA1ll2MNNyD0yPc7PCSfXkff5fg7CN65q5KrlTH1TBAmEHddzCjIJeO29xCA+C+xAeOZcpr1ReLNag+G60S0MNrsuvqeoycDNkAWg+T0hf7CHCpa6TfmKtyAd+d/00EHGTfY7oNabGJl0STbspdHXz2IeZOD+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739451228; c=relaxed/simple;
	bh=mVYbnEVcC4WhFAGgqlkT3W/37DVT9Wa56hCF8LlNjxY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=X3LE16u50tNirrzShYkwVjge9sqSvkwg6XziihNUGL1vALda2rbNpwkGq37mndPxpoFTXzpBvLgVeDjTY7hm2JqX7uD+fvpQuKmQAwsxgDFVz6dU7A7YXeiormTUJv5t38yKCCOHazdTXvazSYamrrQgcVr6Dx2fLYb/gexs0YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdUN6iO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F67C4CEE7;
	Thu, 13 Feb 2025 12:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739451227;
	bh=mVYbnEVcC4WhFAGgqlkT3W/37DVT9Wa56hCF8LlNjxY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BdUN6iO7dvb4JaKLji0qUTwu3M7Wh/6YRi2jPm91J+siPlRuVPceM1x5QIVMVbgI+
	 BqYSY2RS8Lq3BQ7Pqvi84Cm6rNYEGxVrLlmd0aVeo0ZA7RWQeGOPBRnswl7vLV3G++
	 Z+mU/sJ4zlK1f+Z8baK8SbPun7zxd2nwXyUffzQP1P7IxneScD2y9P8+aVMOsyaU3W
	 +YYcCnpaA3Ln7Pv1/eGMEdYtHD4EynGXuND/0WOdBHv9BjjBIB55ffoChfSKLUdXJb
	 kr1nAiu5J62w28OheA96TxmNF7m4/g155f52Yz5SbhWSgVDrYC7TYOgXPDrR2aTLze
	 1IRSQdVF8VzoA==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 Michael Margolin <mrgolin@amazon.com>
Cc: sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev, 
 Firas Jahjah <firasj@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
In-Reply-To: <20250209142608.21230-1-mrgolin@amazon.com>
References: <20250209142608.21230-1-mrgolin@amazon.com>
Subject: Re: [PATCH for-next] RDMA/core: Fix best page size finding when it
 can cross SG entries
Message-Id: <173945122413.294504.1292933084740931802.b4-ty@kernel.org>
Date: Thu, 13 Feb 2025 07:53:44 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sun, 09 Feb 2025 14:26:08 +0000, Michael Margolin wrote:
> A single scatter-gather entry is limited by a 32 bits "length" field
> that is practically 4GB - PAGE_SIZE. This means that even when the
> memory is physically contiguous, we might need more than one entry to
> represent it. Additionally when using dmabuf, the sg_table might be
> originated outside the subsystem and optimized for other needs.
> 
> For instance an SGT of 16GB GPU continuous memory might look like this:
> (a real life example)
> 
> [...]

Applied, thanks!

[1/1] RDMA/core: Fix best page size finding when it can cross SG entries
      https://git.kernel.org/rdma/rdma/c/a4b57de5dfef29

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


