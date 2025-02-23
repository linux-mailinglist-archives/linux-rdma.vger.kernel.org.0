Return-Path: <linux-rdma+bounces-8022-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA3FA40E44
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Feb 2025 12:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 637513BC108
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Feb 2025 11:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E2E2045B7;
	Sun, 23 Feb 2025 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPUcydkF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F336E1FC0F2;
	Sun, 23 Feb 2025 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740310118; cv=none; b=TajMVHz1s4SBmrqlTryL0sfNBwcn8mcqgDDMQbad9Z0kj08g0CziTXP7lppx+3nwcR9TfCxVCxgdi9xytl4aj1VLzbIEiooTAbOL+WlY8EHV9swSFkhpwMrE7tQGV8Qa2J1YJc1FNoXYJqrWgrzOod/sY9kod1BiQILSWppLF1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740310118; c=relaxed/simple;
	bh=UbnXxFWImRYnXtGHKiRFJXe4ICldASpy7rXJUl/U2P0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M5rquydWKrnfeMVk+wUPvjwoB4X5ILuQsiU6reL764cu8zbcgMnaX8Ml4EmjhySP/JhFGwGc+ByWh5FlXBaXDpG53Q686Y85CUQtl5QB1J+zIn3CKxZ4y7obg+qEILty9qsCE0v7bt1RvXuQD6EjKVvXK/rHZ2MO+hRfViopKek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPUcydkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD0CC4CEDD;
	Sun, 23 Feb 2025 11:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740310117;
	bh=UbnXxFWImRYnXtGHKiRFJXe4ICldASpy7rXJUl/U2P0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GPUcydkFKMhftwpbjrT5hRFABq4Ds4UwZNJ20inNan6dwPJY3CDsOzWTs2abD0aHS
	 5cezAMzWksGlL5S8E3YdDNa9NKfzKs/fL4G5nyAU5ppfvg8UPr4sJHGWnkYDTLHXLE
	 WS9tG7YUnWC3h6r/03HD9ws/IoFHvaS6eEuf0LVia95I78ivI8EpJB97cqloIUMyr3
	 O5kKJsBtcN+46SJqSc9VQUSvbj8DzQZZPd6dEpZp2lvM5cFFPuaNwTW+UmeTPNWNe7
	 cWBm6/DoDtxqoTBXJblK3uDos8AAuq8rbBy88ueC8BHW7uOludCn37p8aZe0Nbn3D7
	 QbAZLQCrVhrnA==
From: Leon Romanovsky <leon@kernel.org>
To: Long Li <longli@microsoft.com>, 
 Konstantin Taranov <kotaranov@microsoft.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Kees Bakker <kees@ijzerbout.nl>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250221195833.7516C16290A@bout3.ijzerbout.nl>
References: <20250221195833.7516C16290A@bout3.ijzerbout.nl>
Subject: Re: [PATCH] RDMA/mana_ib: Ensure variable err is initialized
Message-Id: <174031011362.499177.17646129788769059467.b4-ty@kernel.org>
Date: Sun, 23 Feb 2025 06:28:33 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 21 Feb 2025 20:39:03 +0100, Kees Bakker wrote:
> In the function mana_ib_gd_create_dma_region if there are no dma blocks
> to process the variable `err` remains uninitialized.
> 
> 

Applied, thanks!

[1/1] RDMA/mana_ib: Ensure variable err is initialized
      https://git.kernel.org/rdma/rdma/c/be35a3127d6096

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


