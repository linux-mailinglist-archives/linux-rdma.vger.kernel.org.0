Return-Path: <linux-rdma+bounces-8657-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AB7A5F4B0
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 13:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1828419C05AF
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 12:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078012673A0;
	Thu, 13 Mar 2025 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WczMsSCY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BE1267399
	for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869590; cv=none; b=HhH0ftU3ATCXg9TFTmLb/jVcInJvUmRE3RC2Y9jK6oDCHupSRSQXwgaaZQkm1VJJ29tan7niKkAmJ/Ws2oC34BJwhgULN5OvcqIbxW3rU+BMEDxOzygMevD7Mw5NxwGdIHNqSF2+r9TnXNnolyESOZEM+6Wf8TW802sPPBlKoqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869590; c=relaxed/simple;
	bh=DkiT6Xt/EjE9rDTt4cI4wtbpByV/wNAOxcPqUAE5i7o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a0l80dZKtkTeDfomO3xGt4lbAvqhcfLhmNO+PNzv8Kco1Mpjfytre0OcazgTmmmmRNf/6g8fuD5yPVeMxbKfMw6w6p+uMqvLxHFSuSqVzyZpuigoug4xTan3QYiiLTWbUg4rBii/iwzcMjyNTF6hzPA8F7LP5pRorZRG7DvoHro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WczMsSCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B78C4CEDD;
	Thu, 13 Mar 2025 12:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741869590;
	bh=DkiT6Xt/EjE9rDTt4cI4wtbpByV/wNAOxcPqUAE5i7o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WczMsSCYKIbvP0jItntsu2ImtLF8J4KESFx5xbBlDhXitIJC0WVWAaoX8ljl2/W9Z
	 ro9qVeo7lT+17RmTLTCJLrChq2Sf1uMY42E9skOIpvNSpq9FadTXphnpVKDbtcAleU
	 MD1dvAxjVe6xYJwShWhMNkZATXygxltaLjDhYTDh2GGg/QHhKmNSGnjlzzXDfhOpXD
	 e/40TVCNdB7YAr4xa0BxewYhGlLhyq2M7xJl9nHRk82BD+VUe2wTes/astdyJuWFm8
	 UbdpNhE7ppCDSPXDmCGc5BqCNl92I7a+BCl+yN/kW6i8lxSkAxy1kWbMADQGpFTXrI
	 SpnbYBMDlX7Aw==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 kalesh-anakkur.purayil@broadcom.com, 
 Preethi G <preethi.gurusiddalingeswaraswamy@broadcom.com>
In-Reply-To: <1741855464-27921-1-git-send-email-selvin.xavier@broadcom.com>
References: <1741855464-27921-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH rdma-next v3] RDMA/bnxt_re: Support Perf management
 counters
Message-Id: <174186958709.624442.8846039482981035049.b4-ty@kernel.org>
Date: Thu, 13 Mar 2025 08:39:47 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 13 Mar 2025 01:44:24 -0700, Selvin Xavier wrote:
> Add support for process_mad hook to retrieve the perf management counters.
> Supports IB_PMA_PORT_COUNTERS and IB_PMA_PORT_COUNTERS_EXT counters.
> Query the data from HW contexts and FW commands.
> 
> 

Applied, thanks!

[1/1] RDMA/bnxt_re: Support Perf management counters
      https://git.kernel.org/rdma/rdma/c/b9aa02931ceef5

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


