Return-Path: <linux-rdma+bounces-14176-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 872E3C28E7E
	for <lists+linux-rdma@lfdr.de>; Sun, 02 Nov 2025 12:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438823AC444
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Nov 2025 11:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9FB2741C9;
	Sun,  2 Nov 2025 11:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4ahsLJq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3D634D3A6
	for <linux-rdma@vger.kernel.org>; Sun,  2 Nov 2025 11:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762084422; cv=none; b=WSdCOvfgg4jRqDVU91QZK6+pT3RC05N/RGqDdVqm4WOGEnGiOdh9JG7c7tJE1Nbz8NZ+hzq45bX/pFRZPuiL/HUVodLFXU+wbRvEXL9xJq6xaf8+dUtApZ2BJsR5p6QNGYU9rjQtl9VDcCicq4HYxpI8iLDx34VWqUAJuumwcbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762084422; c=relaxed/simple;
	bh=7H39P7Fsx5W/Cl4oE7WTfhDzhvvTDsUzcwO3CQw4bws=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HM8G53DV7BBawtOnwlyUVqODns2EXM9MN6gz8FIbUlfzV9FuaTpfEGNGvSTUISL3Yk3tyzpvfW1wLt2c0abxQmHkRb9YJyuJ+bE1SCtoewB5pUIeNba0yNoDoYGmioxEHTdtxC/x+hzAMu8KAXhQ+jsQos2t+J7KVkTfjiAWLV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4ahsLJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345F0C4CEF7;
	Sun,  2 Nov 2025 11:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762084421;
	bh=7H39P7Fsx5W/Cl4oE7WTfhDzhvvTDsUzcwO3CQw4bws=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=a4ahsLJqX++Nitit/rkBDMm9Zlr1caKB1unbPvWN5O5dyw8ki9foEZvZziHMdt9PL
	 AcpQvZ0yTdUmxAYZ5sEyMSR/r4XFtLlLb0HrRnGhnWTLpG2zF6+rrq3Jd3YyPxQOjX
	 kbIwnqvq/odQChEwIZn/jUSOfoI27iEegiaDk2EEfkVkdwEXarynLeFgFH4cXcJRvH
	 0ShIZuokQWWyzdrx4tjGNoCvSa8caIZMyA5bx57p+wY/cMosKUW3ZOmY8jeZFae2XD
	 qV1vCwVQG/+qKaBeDfRuADi/EElb7e+H/24QFxZBbJihVK9Etlqx54w0JLqrX+zzHG
	 PujMky2MDtlMA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: linux-rdma@vger.kernel.org, krzysztof.czurylo@intel.com, 
 Jay Bhat <jay.bhat@intel.com>
In-Reply-To: <20251031021726.1003-5-tatyana.e.nikolova@intel.com>
References: <20251031021726.1003-5-tatyana.e.nikolova@intel.com>
Subject: Re: [PATCH] RDMA/irdma: Silently consume unsignaled completions
Message-Id: <176208441877.10923.5925012546926343023.b4-ty@kernel.org>
Date: Sun, 02 Nov 2025 06:53:38 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-3ae27


On Thu, 30 Oct 2025 21:17:24 -0500, Tatyana Nikolova wrote:
> In case we get an unsignaled error completion, we silently consume the CQE by
> pretending the QP does not exist. Without this, bookkeeping for signaled
> completions does not work correctly.
> 
> 

Applied, thanks!

[1/1] RDMA/irdma: Silently consume unsignaled completions
      https://git.kernel.org/rdma/rdma/c/cd84d8001e5446

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


