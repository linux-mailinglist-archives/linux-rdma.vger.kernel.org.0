Return-Path: <linux-rdma+bounces-14179-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79924C28E87
	for <lists+linux-rdma@lfdr.de>; Sun, 02 Nov 2025 12:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E377F188B6CF
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Nov 2025 11:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0BE27E7EB;
	Sun,  2 Nov 2025 11:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgZNrPwv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29BA27FB3E
	for <linux-rdma@vger.kernel.org>; Sun,  2 Nov 2025 11:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762084431; cv=none; b=r1Qyyc1J/nOToPAZ0oQ0X6jcwF+f6Our08CzNjTLCPEwIomiRY7BNUZOj9i5VwpjcjPF6PbhCnf8LOrX692hyP3TtH2wsplYTKWYWcJtiYM0b4xMH4mrdh8sTPrgbzA/pdE7C0ZSw9IfyvgyYZs8Q+4k+WBTIbYgVYcnAbUoMUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762084431; c=relaxed/simple;
	bh=hGFccg6xI08WKrGgrgE6TzNoLIcDgnKoJFV0EhBP9R0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=brljPbiV1BkpcxIt0HshokZ5bdubc8BrNzmSQrK6Ms+7XZ05cRkpf+sRr7J654RP7+0pRrmOWlhlbK4R1heQ98tfrJf3r1ea0M+2H25epA8HMuOyws5aeZj65zM3O63XchAGZYHlByv4fZ6/LVRlOlDvX1J5as0pv5rwsjRuWHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgZNrPwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308FBC4CEF7;
	Sun,  2 Nov 2025 11:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762084431;
	bh=hGFccg6xI08WKrGgrgE6TzNoLIcDgnKoJFV0EhBP9R0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YgZNrPwvRAGtuI15oTXKQHP0gaGuyOXeJoJ83i00ZFZt1CpjJGaW6coA8qvVD7Iy8
	 f+pgTKAKFbm/Izp/3USA7anYAuNRhNi1r/+N5sS/JKIfYQaLj5aY8152Iu7U8sl17r
	 ZcKZPewcn5AS+guKBdByngxlhsSXxyMXPfywmAhNKz286njO57ip/vZEjqZPSdnCXS
	 aQy4dMBw8i2Bv93Nw2AyUbD4dZqkINAu97rn4MBNh3NG187vqmFAIq8+vd7gwqKPFf
	 PdM/iGFnj2YwhILXLbRUcWX64uYkpLF6kAmo4FUXeHyprGDCTfJx4CuXnGfBLZ130I
	 5eIZW/BzU+u2A==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: linux-rdma@vger.kernel.org, krzysztof.czurylo@intel.com, 
 Jay Bhat <jay.bhat@intel.com>, Jacob Moroni <jmoroni@google.com>
In-Reply-To: <20251031021726.1003-7-tatyana.e.nikolova@intel.com>
References: <20251031021726.1003-7-tatyana.e.nikolova@intel.com>
Subject: Re: [PATCH] RDMA/irdma: Take a lock before moving SRQ tail in
 poll_cq
Message-Id: <176208442867.10923.10713244677806562401.b4-ty@kernel.org>
Date: Sun, 02 Nov 2025 06:53:48 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-3ae27


On Thu, 30 Oct 2025 21:17:26 -0500, Tatyana Nikolova wrote:
> Need to take an SRQ lock in poll_cq before moving SRQ tail.
> 
> 

Applied, thanks!

[1/1] RDMA/irdma: Take a lock before moving SRQ tail in poll_cq
      https://git.kernel.org/rdma/rdma/c/3c2e88f71fc5e5

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


