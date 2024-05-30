Return-Path: <linux-rdma+bounces-2700-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6488D4DF4
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 16:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFEBE282881
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 14:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F302417CA0A;
	Thu, 30 May 2024 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9X3zqcR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4649186E57
	for <linux-rdma@vger.kernel.org>; Thu, 30 May 2024 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079188; cv=none; b=LuPMNQuVw1lAwqkcNvuP6j82AFaarqOehrB6/MwQOWPJHK/ej3+DtYM9zwzQPnSTTSICG7sYVpakFFAR6ETCTj24gWJ1jS5lL/xbLJ/syQ5OyWiCRd0M78wq9LPx3mqXhBxKPBGSXrJBU3ZMmZDfbELGbvEzAJH6QgLHW20stPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079188; c=relaxed/simple;
	bh=TObWewB/oraAcRI3q4K1+WzbqAXCABz+YNSQ2zIrA6U=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MT+P2mfsEbhaJ6SHT2XXVOcdc+orKxuDXLMz4aK/W7WCsFglwgNTdpN2X7RVUq32Ptuja7Is5Y3NgBAIz85FHdrzV/zHcUq2nrDpCL3yfDBfkx0hly5zChjO4M6W6woZixHqSyl7+Oq1int/zeMqfKFOeQgv86virKx7FPQY9jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9X3zqcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0929CC32782;
	Thu, 30 May 2024 14:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717079188;
	bh=TObWewB/oraAcRI3q4K1+WzbqAXCABz+YNSQ2zIrA6U=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=V9X3zqcReU1qUDxxex1eN6/+c5NgEgevdFs7Dh4dz7RJEsHnhlt3JUHgPqQoL2kdt
	 VJ1DicXLdM9yFgSn3RaxJQwH/6uvhz2sLU/ZmIUBeg7pMBoLXtj6/oELAimGZQaNAN
	 z5xYeMNaJAjpV/NmRBbq2REL41pPE2qbLgAIQLA2IXGUF3ppaRQX66dTQOM3ghUf0R
	 nO/0RZCq74mtyk6SOpKtANfBz6kW7Rh882E9vld5I7Ds66dDCYBZOELJcDAmWQ1HyE
	 SSyIDC+IH7omaSlL/ANm3Wr+UniJIFzylmiTtHGa8mz8R3iP0GfN7mxWyzTo2RoOtg
	 ZCHbHRXcXzr2A==
From: Leon Romanovsky <leon@kernel.org>
To: zyjzyj2000@gmail.com, jgg@ziepe.ca, rpearsonhpe@gmail.com, 
 matsuda-daisuke@fujitsu.com, linux-rdma@vger.kernel.org, 
 Honggang LI <honggangli@163.com>
In-Reply-To: <20240523094617.141148-1-honggangli@163.com>
References: <20240523094617.141148-1-honggangli@163.com>
Subject: Re: [PATCH] RDMA/rxe: Fix responder length checking for UD request
 packets
Message-Id: <171707866514.136408.14977812016177496326.b4-ty@kernel.org>
Date: Thu, 30 May 2024 17:17:45 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Thu, 23 May 2024 17:46:17 +0800, Honggang LI wrote:
> According to the IBA specification:
> If a UD request packet is detected with an invalid length, the request
> shall be an invalid request and it shall be silently dropped by
> the responder. The responder then waits for a new request packet.
> 
> commit 689c5421bfe0 ("RDMA/rxe: Fix incorrect responder length checking")
> defers responder length check for UD QPs in function `copy_data`.
> But it introduces a regression issue for UD QPs.
> 
> [...]

Applied, thanks!

[1/1] RDMA/rxe: Fix responder length checking for UD request packets
      https://git.kernel.org/rdma/rdma/c/05301cb42a5567

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


