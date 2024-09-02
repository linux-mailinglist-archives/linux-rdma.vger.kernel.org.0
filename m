Return-Path: <linux-rdma+bounces-4689-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA4396803B
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 09:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E762819CF
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 07:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D260616C444;
	Mon,  2 Sep 2024 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4wv4yqs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F26E155A2F
	for <linux-rdma@vger.kernel.org>; Mon,  2 Sep 2024 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261221; cv=none; b=hWO3zl+JooVWTQ2qIZ6zo25h/b49ZS8ti2iGYinn28wPRW9nUtO31opzz+nnZjYAob7bKlUxm/j/vpqSkLeC2O0D4ykbVzI4/eSilkpDop0Nu94SqwpxU3dNZ6dDA52vapWkj2NWWcguWZbztENZAEAIqqp2MzXzNS6DOouzP2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261221; c=relaxed/simple;
	bh=IuwnYuk+yi7lQcfA3yYuh1kYvCnIS6b2eemKxqYMNCM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Bol7ve2FRM4/4HngPYx/wkAU6a4cCWyMmbCothQh1sCsNLRCHKHaq0KRFDl4yvIYapYa4o695p9K/7CZR3uzkYN6IFjhqh0qTjJ/T2roomaHt9svRNUimlmoW719dHI3AE5iy6ITJQeI6pcrTKCgjsPSKLzNlWPvNZKQpgLHW6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4wv4yqs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A717C4CEC2;
	Mon,  2 Sep 2024 07:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261221;
	bh=IuwnYuk+yi7lQcfA3yYuh1kYvCnIS6b2eemKxqYMNCM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=J4wv4yqsMmAvc1bJmiI7lcYM8KYFTUhuACDVseRRrh1k9YFIFFgPT8URehXojMzch
	 SQPhAelYN2R+RePQpaAtJd4CcXzZE8d8ISj7JzDVdY5Hke315LBqCTuMX1Y9qJAOjp
	 uukQ1MwGwNONyMUca3T2u+AJt5xBpCXqE3ewO0LbeJ3x9H/qutQ3ctUGA79rtJ4NjZ
	 M9CfyxFB+yyDin5z76D15RwdcLxMkH3FI06g3qtFwyGfWg12dtv5a1qBqbua27etZ1
	 +1RN3TC3OiqhE7cvoZGFgr3X/A/HE4rupbQmKocWeyxIWMMP3jnq0tRkdOmvhD6eLj
	 HuOpsLyyKRk8A==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 chandramohan.akula@broadcom.com
In-Reply-To: <1724945645-14989-1-git-send-email-selvin.xavier@broadcom.com>
References: <1724945645-14989-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next v2 0/3] RDMA/bnxt_re: Toggle bit support for
 SRQ events
Message-Id: <172526121651.224461.8807719437667676179.b4-ty@kernel.org>
Date: Mon, 02 Sep 2024 10:13:36 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 29 Aug 2024 08:34:02 -0700, Selvin Xavier wrote:
> SRQ events from HW gives a toggle bit value that needs
> to be used while ringing the SRQ arm doorbells. Adds support
> for this and share the toggle value to user space applications.
> 
> Please review and apply.
> 
> Thanks,
> Selvin Xavier
> 
> [...]

Applied, thanks!

[1/3] RDMA/bnxt_re: Get the toggle bits from SRQ events
      https://git.kernel.org/rdma/rdma/c/640c2cf84e1de6
[2/3] RDMA/bnxt_re: Refactor the BNXT_RE_METHOD_GET_TOGGLE_MEM method
      https://git.kernel.org/rdma/rdma/c/b4207630e0040b
[3/3] RDMA/bnxt_re: Share a page to expose per SRQ info with userspace
      https://git.kernel.org/rdma/rdma/c/181028a0d84cdc

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


