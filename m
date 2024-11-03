Return-Path: <linux-rdma+bounces-5707-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1771D9BA682
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Nov 2024 17:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66FF4B20DC1
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Nov 2024 16:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B955B17C225;
	Sun,  3 Nov 2024 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hknujNQ2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF8C290F;
	Sun,  3 Nov 2024 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730649751; cv=none; b=Qvb0FCTTWrkZSeCAGhDmo833YxpRez3UN6eNYjcvvBgSMX/36byzjzEaFx27hwA/8hoPehBcgOuyt5uPz5TARuqbiQdMFqjATrPz6JfoQ/Qj4mdfbPAAx0+YjPCruaNvkExbgzo0InBmmBjtRHPR6oYkWj6YI6wu+0QhhXWru/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730649751; c=relaxed/simple;
	bh=/+DQmghZcV+OiRej/vlZM6VSNGosB6iFmadUL/BOou4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RiFGCw29hlv6xwaznoTndOc9q5gvJ8w3JVsLL/KGp61fLDvJbvTOML9J9Hku7j+3BjNzZwFQWY/6My4pzuAdoQ/TxFRCZ9MKPt78imnWy3S+jV4XlSWoLRnX5wYrP8U8c8xGMUi4qlEuLkC8gcHcngjsUir3d1Aynd/kEX08ZlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hknujNQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89685C4CECD;
	Sun,  3 Nov 2024 16:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730649751;
	bh=/+DQmghZcV+OiRej/vlZM6VSNGosB6iFmadUL/BOou4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hknujNQ2noe5RZp6KM6GcJJOthjoJ+BrwlrUXOMzCXcOhKNdV/Ulrw+WSVnOudFBE
	 0HXHN4rtk12WD5rNKQlTzbOAKkD0I5AKrlrqIpDhcCmPGiT+iRw3LiDUuI7P8XNzEo
	 I1D9S44jWGE/sb6wAQpV2UAcjyJYqaQCU0iWhMTm0FfIJGRWSEttEi9j+rspkNA9l/
	 yShc1rS/1bOW+5ODRMrKo9/ZFU9WOU34deau4U+jynPGOkmxO7LJb4OnMlutqN2zrv
	 EdgK8qdO1m+cS1yZeXRITahreIdCqda8N1qXTNSAzwxIfR/dpv6ZIojRjolOhETg2G
	 F6Ty4y33Dg81w==
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-rdma@vger.kernel.org
In-Reply-To: <9e48ff955ae55fc39a9eb1eb590d374539eab5ba.1730477345.git.christophe.jaillet@wanadoo.fr>
References: <9e48ff955ae55fc39a9eb1eb590d374539eab5ba.1730477345.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2 1/2] RDMA/bnxt_re: Fix some error handling paths in
 bnxt_re_probe()
Message-Id: <173064974755.148662.8075604022466705654.b4-ty@kernel.org>
Date: Sun, 03 Nov 2024 11:02:27 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 01 Nov 2024 17:10:56 +0100, Christophe JAILLET wrote:
> If bnxt_re_add_device() fails, 'en_info' still needs to be freed, as
> already done in the .remove() function.
> 
> The commit in Fixes incorrectly removed this call, certainly because it
> was expecting the .remove() function was called anyway. But if the probe
> fails, the remove function is not called.
> 
> [...]

Applied, thanks!

[1/2] RDMA/bnxt_re: Fix some error handling paths in bnxt_re_probe()
      https://git.kernel.org/rdma/rdma/c/cf90a4d1b9ff9e
[2/2] RDMA/bnxt_re: Remove some dead code
      https://git.kernel.org/rdma/rdma/c/aceee63a3aba46

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


