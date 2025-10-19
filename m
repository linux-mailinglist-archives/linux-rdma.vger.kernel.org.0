Return-Path: <linux-rdma+bounces-13934-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 509AFBEE380
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Oct 2025 13:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04BE2349E93
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Oct 2025 11:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467432E336F;
	Sun, 19 Oct 2025 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L16ynee2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056A41E51FA
	for <linux-rdma@vger.kernel.org>; Sun, 19 Oct 2025 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760871845; cv=none; b=k2PR5kt/Gtb7tegmloMsQdYEx0CCPnFl4knDMNfj8B4WhbbgvcJ6AO7oPXmKLRT9fsNpdzV9XSTxF+Zoq4IBZ1AmUq7xQ0m/TolVd9tdH1S5uxRrf1XFg6Nt7L4h67Fs/mTz+RKc1jLbThR3ZAG3QIqE4huLD0iMjgnUR3mtn8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760871845; c=relaxed/simple;
	bh=AZ/nY3Uxl8Uet38RA9BEYPXzNB6kzX7KOEjpfJ4BqFU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aK3/UJxgew77NIGzGc20yo0G9H/LAFGjV5o1MsqR8xXHcBK6vfBcrmCxVuCmBI1ZXaDy4DMxYRJjrlWMArr2ounT8fqZwOwsBEynvgRh6qjcgyWM0S06VUY5QtnwsG41AKayES8atfPrXYJN99ztPtVPO8fAulix20EGt6uj2Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L16ynee2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FE7C4CEE7;
	Sun, 19 Oct 2025 11:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760871843;
	bh=AZ/nY3Uxl8Uet38RA9BEYPXzNB6kzX7KOEjpfJ4BqFU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=L16ynee2AJ3QY5DoqbWhfk/D6VMU+f3OIJWWvGNIoQKLifKlHoOgJf1mMy/8WjZ21
	 +/3qZ8a3mk2tP2echUjKMd80oBxdr7/4fAsEemVGjKoIhxfZBq9mHFMoPcchyni2uN
	 2xyU9U1pYZ3hSlUeHmpNBPoSx/G8uhpIEZghHsoSfiawZIwOmyMRzifmN66cN3bwpv
	 i8nW9BbMe6VGFVZ0um9g01aZBeo4QCK5/OdPNACqTuww4mYJMMTZEPoDNo/Ydz2buD
	 EmbK+eCa2YgrJ/I3yuT+o8juMt2K/Nr4rQiAnk2ctxcUeFkEjjVEbmm0jNeQIhfQZa
	 iRxcqsfT5FJsA==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <20251008165913.444276-1-metze@samba.org>
References: <20251008165913.444276-1-metze@samba.org>
Subject: Re: [PATCH] RDMA/core: let rdma_connect_locked() call
 lockdep_assert_held(&id_priv->handler_mutex)
Message-Id: <176087184055.149370.14915845491483060217.b4-ty@kernel.org>
Date: Sun, 19 Oct 2025 07:04:00 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev


On Wed, 08 Oct 2025 18:59:13 +0200, Stefan Metzmacher wrote:
> rdma_accept() also has this, so this is now more consistent and may
> prevent bugs in future.
> 
> 

Applied, thanks!

[1/1] RDMA/core: let rdma_connect_locked() call lockdep_assert_held(&id_priv->handler_mutex)
      https://git.kernel.org/rdma/rdma/c/879424832d2410

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


