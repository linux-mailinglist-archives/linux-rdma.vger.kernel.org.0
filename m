Return-Path: <linux-rdma+bounces-2693-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3498D4DEB
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 16:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88EBF1F23B3F
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 14:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397F117D8AA;
	Thu, 30 May 2024 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iavh5RmW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE07C17D894
	for <linux-rdma@vger.kernel.org>; Thu, 30 May 2024 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079158; cv=none; b=eujt1bRntdPzLxeAjY6cP2hWktXSO39SKl+Lc6gI+mHo28dl6QwZB6Z+SFlKPZLMQibF24VhWKEr1XFzxOexxJRuklpTITjYAqEce7piJDwlnBvtrb0Rrh5gD5GDR3AeqqsPEYcJwYIzBXVC3bqxqmcoAy5vL50JCUNnUe71FHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079158; c=relaxed/simple;
	bh=4x96oW8neCrSVYDZlB0WfdT9EZRX63M4vcgciCKB8Gg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UsTDBs8cbdbRKta5wlv4xT2WEpDbvPkPwgCsW0xfgS3p5u48eQ91JDdZ9/vr6n8r8MlvDzRKPqhJwaLAY6xu8CXNa+/NholOqTjh/ZZXloxEK2V2faa+8Fembj+1z8hGGgoOHj+ADi4vNuJ3Phc3hV+0+ID4CKOYmJU0CyfzfUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iavh5RmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33694C2BBFC;
	Thu, 30 May 2024 14:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717079157;
	bh=4x96oW8neCrSVYDZlB0WfdT9EZRX63M4vcgciCKB8Gg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iavh5RmWhnihEAjNsg3AgKVUS4Dncf3lOHjuf3nQxzkAi1zrdyWda0ZOTaQaB4Gx8
	 sCshxCWfwQ+UI+9RE7VjhdRCxn5EmiJJm9HQ3ZM4xhZ+StJwhPltlAmf/V7gN3RYZv
	 ES1/nVW9YndFBxC3fqBk+0mQH0FZNF3l5Pf3752spYh9qqTr3GJPTH8RH8N2SlGMzy
	 5MQkC/jqsHpqDx4x47/x531wca57+cg/GZGLONqgC09XVrdjocpHSvwFZFtcy/h21Z
	 jBO5J4EOOREjhfsz4e4243n/lddxOXyoQpgUc3Ld7/JQXhK9+dhJRJ9qDVMEVQVR1R
	 PMvL56OgCZgPQ==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com
In-Reply-To: <1716195418-11767-1-git-send-email-selvin.xavier@broadcom.com>
References: <1716195418-11767-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-rc] RDMA/bnxt_re: Fix the max msix vectors macro
Message-Id: <171707071433.100891.5924959218098664906.b4-ty@kernel.org>
Date: Thu, 30 May 2024 15:05:14 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Mon, 20 May 2024 01:56:58 -0700, Selvin Xavier wrote:
> bnxt_re no longer decide the number of MSI-x vectors used by itself.
> Its decided by bnxt_en now. So when bnxt_en changes this value, system
> crash is seen.
> 
> Depend on the max value reported by bnxt_en instead of using the its own macros.
> 
> 
> [...]

Applied, thanks!

[1/1] RDMA/bnxt_re: Fix the max msix vectors macro
      https://git.kernel.org/rdma/rdma/c/056620da899527

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


