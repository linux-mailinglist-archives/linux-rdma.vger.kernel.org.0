Return-Path: <linux-rdma+bounces-4771-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F44E96D620
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 12:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A20A5B24CD0
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 10:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEB71990AA;
	Thu,  5 Sep 2024 10:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mduzduho"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F08219882C
	for <linux-rdma@vger.kernel.org>; Thu,  5 Sep 2024 10:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725532301; cv=none; b=ODcDCKzIDvOYUAOcgCjmRIVFP+jNokubjTG9ogm/G3MhG7dKidGOTUXQTYl3lM0sPv33IUpLfBhMNW1/7AZ+djUIeJqMuTDu+MQJdvbczl8A14r8iv/A66RdORcZZmi50lPKXFwOh0RPgNRCkDxutCgaL5Pfqhq7Gn7OgxeZPAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725532301; c=relaxed/simple;
	bh=Y4yCLyrtj0BLi1U4kSgDz0WXhp91jMktLqis6aNdWFE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ahc7/8nO9qnCPbFXoV5kW5+oCqodxp9LnDJbTYDRm6toL7KD752uiy7VsQEn/NMT32Sbd19iFbRmQbRWF3ld0wPy+xb2zZvKNpdGseGcvDQzeljy/comUMSS/BuYYOgZQt6RjGx+n+xd1vVeFjPZT0N/Nav3KBsbWx4ICIeWjUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mduzduho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A021C4CEC3;
	Thu,  5 Sep 2024 10:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725532301;
	bh=Y4yCLyrtj0BLi1U4kSgDz0WXhp91jMktLqis6aNdWFE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mduzduhoqeEpGv/MGHnZxpxU9WbsThlSPI0A7leS8wxgboPmTgiNPhG/DkrlzvUEs
	 t5rBD+Rg+budMzlR6fVH7I1H/vhwhAd4bVcqkY27p/u2htZX7ylF4yTg+gOOaiy9OG
	 FBTeunkSIgKXJ2cG/K3Vpx2T8Q3NgB73xkvxO4rt9nmAjYcTtghjh5uNRxW5B5Xfpz
	 JrdlfhaihdRyFqaH5y9tThxxHkj9jzbErCDD/j5ioFonhygEE8HOpJOCOY4LL/4ZEJ
	 wVQt1ctOI33hOiPUVhtKAK1BgELxoT4KvKuglUnUPGyhTJOp6gzgA2vQ73d/8r/l3f
	 j65Z7WsewHF2A==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com
In-Reply-To: <1725444253-13221-1-git-send-email-selvin.xavier@broadcom.com>
References: <1725444253-13221-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next 0/2] RDMA/bnxt_re: Bug fixes for 6.12
Message-Id: <172553229707.1771917.619925409790578583.b4-ty@kernel.org>
Date: Thu, 05 Sep 2024 13:31:37 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 04 Sep 2024 03:04:11 -0700, Selvin Xavier wrote:
> Fixes couple of compatibility issues seen with older libraries
> with variable size WQE patch series that is merged to 6.12.
> 
> Please review and apply to for-next.
> 
> Thanks,
> Selvin Xavier
> 
> [...]

Applied, thanks!

[1/2] RDMA/bnxt_re: Fix the compatibility flag for variable size WQE
      https://git.kernel.org/rdma/rdma/c/b98993bf7e63b0
[2/2] RDMA/bnxt_re: Fix the max WQE size for static WQE support
      https://git.kernel.org/rdma/rdma/c/fedf7d466d3d67

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


