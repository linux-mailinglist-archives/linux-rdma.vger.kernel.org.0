Return-Path: <linux-rdma+bounces-4694-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C1596835F
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 11:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1488D2835AD
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 09:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C508B1D27AE;
	Mon,  2 Sep 2024 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3aVSLIy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869FE1D2F4B
	for <linux-rdma@vger.kernel.org>; Mon,  2 Sep 2024 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269649; cv=none; b=bCcngJzGythcSSDMVYx2cwfdobROXCHyi7FUIfou7KyoENbFkAwUysmSH27wkCQX6Yl3vB4xUvBmzobuM6jysImh8sE6Bir6F4LuxxAOyOAA+MWgqVnZmLolgWlY0NxTALN7ji3WiISS9tHLGkFjGAGyAOkNjPGIw3oLCzMxNHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269649; c=relaxed/simple;
	bh=OHSxY5+NmnAHBiEHI4VCZAcN5LlQ7sLMMla3dzQl554=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XHOqeN70IMZbx8I725naBXwE+e5/WJHBAjlPjGteA04D1fWwgYMlD2LsYev45p4+eIviJtcqWxzm4f1WAxUsml3ZYvIKgrUJAHo+OFUnXeVRLyytOH02DSDnluOz1edLm374ZKORv0/lviJzEXhG5WOS8NZXeWiWK3MPEpL+KgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3aVSLIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E799C4CEC6;
	Mon,  2 Sep 2024 09:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725269649;
	bh=OHSxY5+NmnAHBiEHI4VCZAcN5LlQ7sLMMla3dzQl554=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Y3aVSLIy/7OedxSQAMq69DcOpEP2Wn/yqcTTHODRkcD+TtzxnPxPtvT0a/3elDjbQ
	 Y07EvC/CH3RDhETzbLgN+BOoM09szSZSvwwjSWWjXZRf361Ee1yG6VzGtoSHBSOmRn
	 KR8UXRTOCQ7RM4wRkCyss55ZNC8TAtlgQjgAQqDBMj3nOY4Ab4TgjY2sHgZRyokh9M
	 C2tgcaFjwKqRcm+HHINWilAZ78FNPFNA87AleZ+wpggUuO+UnfLhTSTu0zgS9VX6/l
	 dVR9b2QjUN8bkAuqRCcPCpKh7PQ0NPJxllFfEUvunu3bmOBQ0Mwwb3S4PEaxclOAS/
	 P8Uf2uJgOypbA==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 kalesh-anakkur.purayil@broadcom.com
In-Reply-To: <1725256351-12751-1-git-send-email-selvin.xavier@broadcom.com>
References: <1725256351-12751-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next 0/4] RDMA/bnxt_re: Enable PCIe relaxed
 ordering support for MRs
Message-Id: <172526964422.464646.1328889037337771932.b4-ty@kernel.org>
Date: Mon, 02 Sep 2024 12:34:04 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sun, 01 Sep 2024 22:52:27 -0700, Selvin Xavier wrote:
> Latest generation adapters support PCIe relaxed ordering for MRs. Enable
> it for those adapters if the user requests for this support.
> 
> Please review and apply
> 
> Thanks,
> Selvin Xavier
> 
> [...]

Applied, thanks!

[1/4] RDMA/bnxt_re: Update HW interface headers
      https://git.kernel.org/rdma/rdma/c/543b455c6e9cf0
[2/4] RDMA/bnxt_re: Rename a variable
      https://git.kernel.org/rdma/rdma/c/b98d96971908b7
[3/4] RDMA/bnxt_re: Avoid an extra hwrm per MR creation
      https://git.kernel.org/rdma/rdma/c/f786eebbbefa0c
[4/4] RDMA/bnxt_re: Add support for MR Relaxed Ordering
      https://git.kernel.org/rdma/rdma/c/dc116b7fddbdad

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


