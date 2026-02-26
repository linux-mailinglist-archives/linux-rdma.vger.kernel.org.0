Return-Path: <linux-rdma+bounces-17212-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APrbGs0aoGmzfgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17212-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 11:05:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A231A3F02
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 11:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C78DD3024A59
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 10:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AFD283FD4;
	Thu, 26 Feb 2026 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/euXLw2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4C83168F8;
	Thu, 26 Feb 2026 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772100024; cv=none; b=flhTTqj8mHg0nq59bd1Fn2clg0aaVwKv85nkyRXfsJ0OfGBJXzHAiCY9Dkj+KgnomWaG0cflhfgGhAP5iOVlIov5IDVbUWaOtd2hW2HsUZoKVgiclBC7nd63UK6sHCqfMd2XDekeSSBvtqJlZU1xaYg5llrR5/81czxqScT59aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772100024; c=relaxed/simple;
	bh=/ImB/zyuc6oJqa60gC1TJKr6BgCxDL12UndUp5+Ml3g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fRa6RGo0ergX9fOK738xVarN7UpZ+k+y89HxtYHCng4UMAWY6Gj5PJpli9blWlWtnWBl4bL3UpiUewqqLlVIDm0oGZUNjIU8E2YPUR2gLDKaBl9L7Rv/S9Xe1ZbbyKCelqcOh2usDerRaLVP2Ux7Xa5AT2U4pBiMawcGstpQU2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/euXLw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B123C19422;
	Thu, 26 Feb 2026 10:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772100024;
	bh=/ImB/zyuc6oJqa60gC1TJKr6BgCxDL12UndUp5+Ml3g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=N/euXLw2cGsQlL1RIY/d5ZSCI9fV5PWD3lmCpveWydrmYyGw8yNYmrOfo9uG0Wp7i
	 yExJWaJkusbNtKGUYJyrv6vTwqx32nN1Q5ILkK0yhjEwywd4YEkphvr3cImMQAlbmp
	 1VngtQdDtyhbavtmetFMeXHAskel7xh/5UZtj4Lvy1Qy4Bqdc9GUptAYotfJTZsI9l
	 gE9/GB+GeuZLhzLKlC60SLYSD2ZVUg9fz7BxQM31HhqIHZD9swTH3l37nDpxuLz9i5
	 LKw1BG1JDfuVEjE0/QFCGaLAYpVpTBBXNFrDbtaNhRVg44HLsCSy3qqwA2+WMQ6OpI
	 D4nXjhVz66CRg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Edward Srouji <edwards@nvidia.com>, 
 Yishai Hadas <yishaih@nvidia.com>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260225-fix-uverbs-compilation-v1-1-acf7b3d0f9fa@nvidia.com>
References: <20260225-fix-uverbs-compilation-v1-1-acf7b3d0f9fa@nvidia.com>
Subject: Re: [PATCH rdma-rc] RDMA/uverbs: Import DMA-BUF module in
 uverbs_std_types_dmabuf file
Message-Id: <177210001519.180298.3476648221337967387.b4-ty@kernel.org>
Date: Thu, 26 Feb 2026 05:00:15 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17212-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5A231A3F02
X-Rspamd-Action: no action


On Wed, 25 Feb 2026 15:48:59 +0200, Leon Romanovsky wrote:
> Fix the following compilation error:
> 
> ERROR: modpost: module ib_uverbs uses symbol dma_buf_move_notify
> 	from namespace DMA_BUF, but does not import it.
> 
> 

Applied, thanks!

[1/1] RDMA/uverbs: Import DMA-BUF module in uverbs_std_types_dmabuf file
      https://git.kernel.org/rdma/rdma/c/7c2889af823340

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


