Return-Path: <linux-rdma+bounces-4146-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC238944905
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 12:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9FE283722
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 10:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41709183CB6;
	Thu,  1 Aug 2024 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Umyf2JvK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA92D187861
	for <linux-rdma@vger.kernel.org>; Thu,  1 Aug 2024 10:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722506833; cv=none; b=RlBhJkI7f9ZDV94ADhxEL7g/u7uT5Qw1OC5Pw8yX2gDiDUN6ZL1Hu1i8U8e9XlSEhkqfbHSxsaQQJPXZypqU5RV6QVpSA437NLmo8iDqzIWaB81E7+7vI6LX0D6WQCOhyek09f6JvEvDf7zv2iAuInejwYhwkHxYnuM768pgfIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722506833; c=relaxed/simple;
	bh=trsV9Jn80QiRVq4I4tnS9JwvRX+suwV84uFOX4YbHBU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ONUvbu2pN5YSou4ZZHhRiEoepJdZxrPGgv79fJVhsKFKtS8W3CM+rZh9tgOfiGT7bxo/3jPtxQjZ5U6mPlifW5FJudip7cZhDfOvvXSukuiLAivI0NDRFbgIoy79oyVbltMhjG8WAuW0r567dwHsGauH/JV6oCLIw7ifjFxDS6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Umyf2JvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9039C4AF0B;
	Thu,  1 Aug 2024 10:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722506832;
	bh=trsV9Jn80QiRVq4I4tnS9JwvRX+suwV84uFOX4YbHBU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Umyf2JvK6F/3YMhBc5wcHAdpk3X1nVTC6ZMgso4+WK/ejZtRXi1u7yotA4Xa5GXsm
	 EQTBms0TYCntPVcqeycjNlc/asWjkBBJvJMxL0pWcd/NsKG4Xpr67BcsrO10JMWYag
	 VGF47pBirt4mngf/bPBBFaEH8QtsBLtHrcFyT1Z3dQY3drohL1dyI6zvYcdeAfkDeE
	 CkPeuNHW6fwIY4DrTK1jkk95g06C0xn6/LUQpl3mJuyx7C2xvglPkazTViq9SP78Z6
	 uTzonq0itctMRz9EZ5YSocCseqvThy+UGzycoPzqwhVnmtrf68qLv8lrw+HoO4Y4HN
	 FRpF1LrRv9yzQ==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Cc: linux-rdma@vger.kernel.org
In-Reply-To: <20240722110325.195085-1-saravanan.vajravel@broadcom.com>
References: <20240722110325.195085-1-saravanan.vajravel@broadcom.com>
Subject: Re: [PATCH for-rc] rdma-core/mad: Improve handling of timed out
 WRs of mad agent
Message-Id: <172250682730.748167.2872481023674574020.b4-ty@kernel.org>
Date: Thu, 01 Aug 2024 13:07:07 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 22 Jul 2024 16:33:25 +0530, Saravanan Vajravel wrote:
> Current timeout handler of mad agent aquires/releases mad_agent_priv
> lock for every timed out WRs. This causes heavy locking contention
> when higher no. of WRs are to be handled inside timeout handler.
> 
> This leads to softlockup with below trace in some use cases where
> rdma-cm path is used to establish connection between peer nodes
> 
> [...]

Applied, thanks!

[1/1] rdma-core/mad: Improve handling of timed out WRs of mad agent
      https://git.kernel.org/rdma/rdma/c/b1a72f369973f5

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


