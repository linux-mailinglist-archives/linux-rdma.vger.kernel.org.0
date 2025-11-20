Return-Path: <linux-rdma+bounces-14660-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 60853C752DC
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 16:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 904CC4EE9BB
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 15:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AAE3469FA;
	Thu, 20 Nov 2025 15:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuCtU2TR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176143612D0
	for <linux-rdma@vger.kernel.org>; Thu, 20 Nov 2025 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763652716; cv=none; b=sexnTUlCWzvB3y1GAZpgbegclhW9DmQUqHdz7YQn8vwkkb5W7hhAISV2dWvKiNJux9oaS9qV3FTKbL56PzHbWvXPzGnVbQDY5LhwD9maYFHKssVZq83ZyC6tHTiEXLpoZ0sPXQcTOeWPtT1M4+VscQ6mZEUr/N949OZtyTi7vgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763652716; c=relaxed/simple;
	bh=UBFzMYMFarxiumH/rqqd2Zp+/bqhAT3iGybfq+xXfGA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PalHlivRga1nCtdBUy8FqVacEaq42UwgscGWERdXjJoZMlfKN5enB5J2yzcmp09xkNoQI6LHW50r3fFOr3/hhiNEtK8To68R6t69rHepqgRIFsBmq+pddo5uUg8tdsTqa6/TRBTqPO6z23V235Uee3Dg/lhF/0zpcMFYY1p/5Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuCtU2TR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D620C4CEF1;
	Thu, 20 Nov 2025 15:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763652715;
	bh=UBFzMYMFarxiumH/rqqd2Zp+/bqhAT3iGybfq+xXfGA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RuCtU2TRsOEFnS1jJ5Y0aj8XRwKbPFwiIBxrBjsZC87tlF5sAPBy0eSIqUI6yhhsr
	 JRR5M6Tj9kZBbVT2bdvxSe0xOPSVH9hyXoolXFQ4wBqd3Qh/zkVPfFKmGEnnFTH2H1
	 13uP0utqfLjpYJjN/bDpOYiqlY/xDSPS7pKxWwowiqlvewBWoZPuA/j1atAAe5bSx6
	 ijhn2MWGYi+Pb+CJuvVg1b9qpH9ocV1p8rN3yAcGrrt02iSrextkHCkyEAjCBeQLro
	 DqfqGug7ogBbE5Gzr7k/n3iYaYl7p++gCZBvOSmJhXTG9AYka6sJ4Yn1yaBzMz+Otp
	 Ky1wzWEBug5VA==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 selvin.xavier@broadcom.com
In-Reply-To: <20251117061306.1140588-1-kalesh-anakkur.purayil@broadcom.com>
References: <20251117061306.1140588-1-kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH rdma-next] RDMA/bnxt_re: Fix wrong check for CQ coalesc
 support
Message-Id: <176365271250.1725286.3582030181393285499.b4-ty@kernel.org>
Date: Thu, 20 Nov 2025 10:31:52 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Mon, 17 Nov 2025 11:43:06 +0530, Kalesh AP wrote:
> Driver is not creating the debugfs hooks for CQ coalesc parameters
> because of a wrong check. Fixed the condition check inside
> bnxt_re_init_cq_coal_debugfs().
> 
> 

Applied, thanks!

[1/1] RDMA/bnxt_re: Fix wrong check for CQ coalesc support
      https://git.kernel.org/rdma/rdma/c/fecaa0c74f6664

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


