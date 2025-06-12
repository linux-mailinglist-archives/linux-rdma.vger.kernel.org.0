Return-Path: <linux-rdma+bounces-11248-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12588AD6B20
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 10:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C58E188EB49
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 08:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D78223DEC;
	Thu, 12 Jun 2025 08:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFRHiofW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A530722068B;
	Thu, 12 Jun 2025 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717562; cv=none; b=UeqxkVVbJ5oq0whWJt4QnsjTlN9l0X2BjfbsyosO5PEUl71k8wBSq/jpNqf/wjHMqGTXpHsHjMYHivRhm6gAF61THlVL9uVIo/YFL9UaW2gtxqH6+6HXEm4grrzfmLNzJp98J/Wes0rxcy5htElUMoND+dQDvDbKQyF9QN6vNc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717562; c=relaxed/simple;
	bh=EG6MrUIK8bDEZbJtlqA/oFzIvyqQ2bxzxg+Ocg8pvME=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C8mG1pjrkYIAWAqMWxqX8OjTuvlLjEWLBDRIr8O/KV2VoCM0kRsyo6TU35F5IqdQPv316CSpycaub4OW/loncsK+twHBW2cZOJyMCVirziF2Pv+luoUEQWeMvBukE+rgk7TTb7W1OOsozSDGDb4eNFCo4Iheg7PhMQltNN3aFaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFRHiofW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C17C4CEEE;
	Thu, 12 Jun 2025 08:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749717562;
	bh=EG6MrUIK8bDEZbJtlqA/oFzIvyqQ2bxzxg+Ocg8pvME=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XFRHiofWxjXT8XObRCLVnEQXa0Be2I85wb8J9FBQzxpGwxTWjia1+gMtFkfMeleL5
	 G7bL0cZ2R3nofV1AqR3YohX5qRZvuCSuhzYdH/EEvb9wNiKBLh/AiR4OQvoJbl9yKD
	 GUHyice4JT25pioogoykQo8nUCrJmPLXSajOEjoHg2IJsKxVKJHvpR1zY022hpBaRi
	 +okvWuw4qLBT5bKslO5ZAE4Lohfubc2jxjjeZ41lKMHDwx/xOWD7rrnQiE0F7d5OzQ
	 dojZhwhf0EElF4OqO1uTonWo7Bt1SZWWtYYlO11ihLqJttpkiWariX2owxlz37bh8y
	 Ta6+JY99DevXQ==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 Potnuri Bharat Teja <bharat@chelsio.com>, 
 Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
In-Reply-To: <cdc577a5-cebd-404a-b762-cc6fee0870dc@web.de>
References: <cdc577a5-cebd-404a-b762-cc6fee0870dc@web.de>
Subject: Re: [PATCH] RDMA/cxgb4: Delete an unnecessary check before kfree()
 in c4iw_rdev_open()
Message-Id: <174971755850.3783297.3332209818695020969.b4-ty@kernel.org>
Date: Thu, 12 Jun 2025 04:39:18 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-37811


On Tue, 10 Jun 2025 14:20:17 +0200, Markus Elfring wrote:
> It can be known that the function “kfree” performs a null pointer check
> for its input parameter.
> It is therefore not needed to repeat such a check before its call.
> 
> Thus remove a redundant pointer check.
> 
> The source code was transformed by using the Coccinelle software.
> 
> [...]

Applied, thanks!

[1/1] RDMA/cxgb4: Delete an unnecessary check before kfree() in c4iw_rdev_open()
      https://git.kernel.org/rdma/rdma/c/fd383bf8b6954d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


