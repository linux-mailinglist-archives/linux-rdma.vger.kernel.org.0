Return-Path: <linux-rdma+bounces-14462-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4E8C572EA
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 12:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C2964E2B0D
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 11:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A81A33BBC3;
	Thu, 13 Nov 2025 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIqenZzY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B6633BBB1
	for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033281; cv=none; b=pANBOHMvN1aJhI/iLegxK8i4yoIJH/aFSk7nnORn+BIai5BGZAjEoYggJN1NVqUmYVdKoWCwsiWLokDB4Ma2soBj+LCgJ/LKxNmPyPK3kXSpR4kCu6yh915Y5eyQQhQzYlOyaYemnG9gTHt3nqJ6SqGuFDvUvswiESjh3LVu5pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033281; c=relaxed/simple;
	bh=ED1wf1NZ5ceDruOJQgVye/Ge8uTbiVBhb2D9Dwp6Re8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZtCXfmOXI/46iz3OtOTJJuVRrG/vAsl/MlHSdfyDs2sQYbZW+1213pqhD8EI1vVCNF8D4ch4Zbnxyqcize6DxSrqA/pBgScsUO69Lr8/Hm0mHWNA8BHT/7HCBINOL70wpASEVgNL7/UtlTB4DrO/KSv01rXTIdxL4C9Y39U0DwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIqenZzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FC3C4CEF5;
	Thu, 13 Nov 2025 11:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763033279;
	bh=ED1wf1NZ5ceDruOJQgVye/Ge8uTbiVBhb2D9Dwp6Re8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aIqenZzYyhHc53fx8gh0gOjk3lhWiNO4aEde2ZU0NXDrl1CmR7Prv2yC7Od2xILov
	 w2e0h5nNONrSat4Ct3ViMsVbw0FhkeGtBsAZEmKGg1Y5L4iGv13Pm8BcS8Rv+hqaPI
	 8HRL10A6JggTwD++gHC2j9YIRRp//tTbgYk99UiQ+zs0ov6VMJpnrEdUJAdFj2kqZY
	 S31NgXGwfPhL80Em7cyHbOvEXOqTCzBkaiWCEsWwo4WxV/nkmKMoHloiZzdM7GPhal
	 7D7LGPon2ie4MXPDd0ykf1Ko9dIciTAzrytAPuwrbqd//u5+HCZkss+FBNO2lJ+xw7
	 rXfd/d5fjHfSw==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: linux-rdma@vger.kernel.org
In-Reply-To: <20251113105457.879903-1-kalesh-anakkur.purayil@broadcom.com>
References: <20251113105457.879903-1-kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH rdma-next] RDMA/restrack: Fix typos in the comments
Message-Id: <176303327643.1026984.17080428903499239002.b4-ty@kernel.org>
Date: Thu, 13 Nov 2025 06:27:56 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Thu, 13 Nov 2025 16:24:57 +0530, Kalesh AP wrote:
> Fix couple of occurrences of the misspelled word "reource"
> in the comments with the correct spelling "resource".
> 
> 

Applied, thanks!

[1/1] RDMA/restrack: Fix typos in the comments
      https://git.kernel.org/rdma/rdma/c/d43358cda7c469

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


