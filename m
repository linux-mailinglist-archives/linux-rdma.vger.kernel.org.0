Return-Path: <linux-rdma+bounces-742-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D4983BE41
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 11:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5C31F21585
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 10:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8A71C69E;
	Thu, 25 Jan 2024 10:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akrKuEtk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8A11CA80
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jan 2024 10:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177101; cv=none; b=KWyRTK7qJdykxcWi5RA2+HuP68r/hjbnC515VVZ1bJl9K4XnfSeTUb/wZa+drXrAHFM+yYPHGUd7Yv2w1Vw7K/dQoox1pQVxej0nlNdjV+2w4rJ5OnGEQ3hmSYWosLsP17linQppbjwwB653ZOy/AMc0UtqfUGtR8ToTgBCumaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177101; c=relaxed/simple;
	bh=/ceh06ZCxkIWoX4JrRvNQb+yhvTszG62N+zbYnYK18M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QhF8P0jSS7n2xPhnF+R8w9Hi+wq+xEHoGOeCT1vZgwTVyyXjCov/pX2NYIqe67mSH31xiSjxwkxxopRaw0RyQVwysf9WgDrJdxwDT9fQYXmklk2XzlOMLFEUy9hXXggYgw3bqLgP7/isRXQ9lf1rlZ+DOOoIhmd8/ZAu1nSBOwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akrKuEtk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE57DC433F1;
	Thu, 25 Jan 2024 10:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706177101;
	bh=/ceh06ZCxkIWoX4JrRvNQb+yhvTszG62N+zbYnYK18M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=akrKuEtkZyvKVveaiiCh3QbFRW6XMCOKvxBrem7j4Jts+vLJGoElQ7FQX069dTQMd
	 ysbhNAENPnHvs3RvbRf8Nokwm7X5DttkQPEIqJpgOj5f3RMzlXqNiKQhtrGV0chNdk
	 wZUHUCGK0A7XeuBqoQYinHPGtIKWvWfZCTR6vKwziefs4zglkEXrVKTRlcA5pbm3u1
	 xP/9YCDTxINwjtNSxIFmU7IKKrf3t0HdkX5JjWZACWAQvVxisvieNsDP95eiYOZG7t
	 ggvma7SFof1in6Tvx/tlNTLFBN3OnZLXDxcmcGxDv4prEDP5w/xBtWtYHamI4bQQQz
	 o8lxhaljeizqg==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com
In-Reply-To: <1705985677-15551-1-git-send-email-selvin.xavier@broadcom.com>
References: <1705985677-15551-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-rc 0/5] RDMA/bnxt_re: Bug fixes
Message-Id: <170617709690.634569.744610567376118088.b4-ty@kernel.org>
Date: Thu, 25 Jan 2024 12:04:56 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Mon, 22 Jan 2024 20:54:32 -0800, Selvin Xavier wrote:
> Includes some of the minor bug fixes in bnxt_re. Please
> review and apply.
> 
> Thanks,
> Selvin Xavier
> 
> Kalesh AP (5):
>   RDMA/bnxt_re: Avoid creating fence MR for newer adapters
>   RDMA/bnxt_re: Remove a redundant check inside bnxt_re_vf_res_config
>   RDMA/bnxt_re: Fix unconditional fence for newer adapters
>   RDMA/bnxt_re: Return error for SRQ resize
>   RDMA/bnxt_re: Add a missing check in bnxt_qplib_query_srq
> 
> [...]

Applied, thanks!

[1/5] RDMA/bnxt_re: Avoid creating fence MR for newer adapters
      https://git.kernel.org/rdma/rdma/c/282fd66e2ef6e5
[2/5] RDMA/bnxt_re: Remove a redundant check inside bnxt_re_vf_res_config
      https://git.kernel.org/rdma/rdma/c/8fcbf0a55f71be
[3/5] RDMA/bnxt_re: Fix unconditional fence for newer adapters
      https://git.kernel.org/rdma/rdma/c/8eaca6b5997bd8
[4/5] RDMA/bnxt_re: Return error for SRQ resize
      https://git.kernel.org/rdma/rdma/c/3687b450c5f32e
[5/5] RDMA/bnxt_re: Add a missing check in bnxt_qplib_query_srq
      https://git.kernel.org/rdma/rdma/c/80dde187f734cf

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

