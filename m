Return-Path: <linux-rdma+bounces-14339-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A858C43B82
	for <lists+linux-rdma@lfdr.de>; Sun, 09 Nov 2025 11:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E71D4E22AB
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Nov 2025 10:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F722C11EB;
	Sun,  9 Nov 2025 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyrwamGt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCE01482F2
	for <linux-rdma@vger.kernel.org>; Sun,  9 Nov 2025 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762683273; cv=none; b=Q7KPh6sIxIXMPejkeiLtIvZ+HXu++AfxkhUAcY0g7nCmMuL0Y83fZTnbOXs0xzSARiEUSYw5o20Vt3uK41ezuxTIZa/vss4ijhkt5SgbHybr+S41DI0VOTx8TS23tVBx+mUIiy+gmovwVxkT6furwK1WgPR2jxzODUa9gk9XOvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762683273; c=relaxed/simple;
	bh=YdB54LxNmM0HN7nUVDbHOgMI4pPX9xIRSoMSzOK6Bnc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GI6FDFEcqg94nXlvX3qMglMH6K9jSnlqWId6k70AIg8188wV84V6ojWyohdNbRa/9Bh7DTQYlR1fAPHTnZxL3gZU2/yxr38EPZhYK920yBEa//Y+5quCrJ80IqCdblGDCOJ2rkyiyWd5r2zv6mTRLH0NxKwoBaCH0Vbv/FMkuYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyrwamGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11990C4CEF8;
	Sun,  9 Nov 2025 10:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762683272;
	bh=YdB54LxNmM0HN7nUVDbHOgMI4pPX9xIRSoMSzOK6Bnc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RyrwamGt9NEkdDyV8X/9aqJUDJqWo2KRT7scJ4ku0CS7f0d8KJqY1Ju4KO99bYDPQ
	 iduQ5NwPKP95bs/8Ju/rfT17pdMHAjfgDtckOPuq2oVJsjf/QRO7REoKcTqzrNVNoP
	 adbR28P69P39fsgH5SebP8S4oBe9cIpV7UmZ1cMKUJUdMjRsHyIc0CFv0PSXHow8cD
	 19dDfSBHRlJi8auliBprQsFdr6QtZFLzTyjKnf8Wdy3JXP/tWQXdwxDp+aQeJAvoBI
	 9nuozEZqpyC0qltmxnePy8u7+VA86deffZYqBnfv70qyPgT7gMpvlw034F1QWp4AZ1
	 iR/hxPPFmgQPw==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 selvin.xavier@broadcom.com, 
 Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>, 
 Hongguang Gao <hongguang.gao@broadcom.com>
In-Reply-To: <20251103043425.234846-1-kalesh-anakkur.purayil@broadcom.com>
References: <20251103043425.234846-1-kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH rdma-next V2] RDMA/bnxt_re: Add a debugfs entry for CQE
 coalescing tuning
Message-Id: <176268326928.309237.4515361865090660396.b4-ty@kernel.org>
Date: Sun, 09 Nov 2025 05:14:29 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-3ae27


On Mon, 03 Nov 2025 10:04:25 +0530, Kalesh AP wrote:
> This patch adds debugfs interfaces that allows the user to
> enable/disable the RoCE CQ coalescing and fine tune certain
> CQ coalescing parameters which would be helpful during debug.
> 
> 

Applied, thanks!

[1/1] RDMA/bnxt_re: Add a debugfs entry for CQE coalescing tuning
      https://git.kernel.org/rdma/rdma/c/cf274907901115

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


