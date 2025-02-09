Return-Path: <linux-rdma+bounces-7591-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B75A2DBEE
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Feb 2025 10:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3873A59B8
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Feb 2025 09:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DE51537C6;
	Sun,  9 Feb 2025 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZoESAJC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51EB3FD4
	for <linux-rdma@vger.kernel.org>; Sun,  9 Feb 2025 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739095154; cv=none; b=pWchNSLaXO2062gLT3fU66dD++yAGIPckt+0K8KMvRXauvqQO33tdJM5LqvMDJv19FEMb9+tfdNlYRhAI0nWv6iaogcRJ6yPi/yfqhW6udb/R0HO0LDIU5jVg1vmcJ9rhNSoDiZGMjV1SwUr+l4uVoiWK7sMDFEJsZccs3axjeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739095154; c=relaxed/simple;
	bh=+OL0yenIfpDqS0IWq0Ok3QWCaq3sT/vtS1rzsTpAs1M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iqHpV7QDKRUusVibesUoF6O7aqZxsD1QoY/gO+GVIuf0AKn1ExeGnV8C+SHGmYrhTwh3suaAeNjjpl5NcimPPgu51cJn4jUtqErZ/THi3axDEgkeX3ci9p5zWhuihQT+IVivyg0AiUUowPlz9vKLF71hMPerYpvn8xPD9o2OU50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZoESAJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49707C4CEDD;
	Sun,  9 Feb 2025 09:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739095153;
	bh=+OL0yenIfpDqS0IWq0Ok3QWCaq3sT/vtS1rzsTpAs1M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nZoESAJC0oT3NubRTVsO9YfpDDFideGNSq4wNuXbrAjnbnw+XxQNDO3sS8PqLoldq
	 kPdjuXWYQy41PehySi+/yvBwh9wyskZm+OzLVUqmFU5CGkz07fDIqOrStduF+2OLko
	 b/7FMeGr2QSNb8JTdNjgVvFYB4yTvmlSQVJoeRoaOA4ODeVZIzTfxl9JSFXQ/5g5EZ
	 gvBLVNSoQJMXRgXlmRrqR0ZbBicSeUSiJm/zi+Dx9Ad3CnhQGFT95gLeMPn+yNlQ/z
	 skPm4Itwt4Vyy+aKeZtmGiDpjF06xTrpmZyuZ5zkXB1wJplisDFgAmWfpkCtPUJl9b
	 T3caJ21A5u2rg==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 kalesh-anakkur.purayil@broadcom.com
In-Reply-To: <1739022506-8937-1-git-send-email-selvin.xavier@broadcom.com>
References: <1739022506-8937-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH rdma-next] RDMA/bnxt_re: Fix the condition check while
 programming congestion control
Message-Id: <173909515046.39870.7582022333251380344.b4-ty@kernel.org>
Date: Sun, 09 Feb 2025 04:59:10 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sat, 08 Feb 2025 05:48:26 -0800, Selvin Xavier wrote:
> Program the Congestion control values when the CC gen matches.
> Fix the condition check for the same.
> 
> 

Applied, thanks!

[1/1] RDMA/bnxt_re: Fix the condition check while programming congestion control
      https://git.kernel.org/rdma/rdma/c/f26e648a978ae7

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


