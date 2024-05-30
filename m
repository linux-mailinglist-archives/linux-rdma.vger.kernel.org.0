Return-Path: <linux-rdma+bounces-2692-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 990328D4DEA
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 16:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C632A1C23ACF
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 14:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2008C176257;
	Thu, 30 May 2024 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2Qy68H1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F3217D894
	for <linux-rdma@vger.kernel.org>; Thu, 30 May 2024 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079153; cv=none; b=Dki7iUFL7qIOvTb82VObF5FIfImwcTld17lUWbrX3Fshue6P6rI789WyJRET7t5X6sPdX7F2xeJoFqZ+ipphLUzCqSUnWj1nTSFL11TYGVI61oQZfmN+0fZ2TWIkNNryHoEnKaL8NDynj8vfGNj9Qjgt7Ea2Iuz1WUTi/e/WhRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079153; c=relaxed/simple;
	bh=gPx51mpOJeZT6UPMF10o5qFL+wo5SnqDkJJQwZdJ/ic=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OMI4jIFdBEUjZqfoAO404Y6WXIR2Py1aiNGXqgcmDfM4mPLOnQOTe6ch+y7k7T3w2TuJ7lZQGvKFMhscY0M3p2fL46znjhgvfFZpMfs6D6yRqO3bkyWM7KMCCMsm82kviVJ4T001cCj6V0sQLCmIVkhqBIRXSbq/wanVURd5iUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2Qy68H1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA78AC2BBFC;
	Thu, 30 May 2024 14:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717079153;
	bh=gPx51mpOJeZT6UPMF10o5qFL+wo5SnqDkJJQwZdJ/ic=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=q2Qy68H1GC5vZu5TNwXAI7q4gK3Z9GsZntEt03FZnlMciFYDFT3kdYjCbg5gfgv8w
	 ElSQI5AD4AFnndxt2Th7B/mcf40+Y0OrG/VvdQWijAO4tvIFSV/6/s1YcWM89IYqti
	 TFgAUdM5K6G0qpPWuNgzMJ8mOtPTqwYLxOxeawfQUpUnEiyNU+skJ6SPXZvtOy9Er3
	 1erfYRw2R+rCsHKZ8bAM8ndQOT3d9fSZwyXBzifjQfcyqMVhj5lzmt+K2qwYvrv83m
	 LyxNuZ/RLDNiAmottcunyxW2KrFTt/9Hd1uZOHpnbdIBwK2412IxPr7YbZ6frM0oVV
	 Q+p1RSPbbCLyg==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com
In-Reply-To: <1716876697-25970-1-git-send-email-selvin.xavier@broadcom.com>
References: <1716876697-25970-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH v4 for-next 0/2] RDMA/bnxt_re: MSN table capability
 check for latest adapters
Message-Id: <171706492548.10228.13408949042296249639.b4-ty@kernel.org>
Date: Thu, 30 May 2024 13:28:45 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Mon, 27 May 2024 23:11:35 -0700, Selvin Xavier wrote:
> Add MSN table capbility check for newer adapters. Expose
> this capability to user library.
> 
> Please review and apply.
> 
> Thanks,
> Selvin Xavier
> 
> [...]

Applied, thanks!

[1/2] RDMA/bnxt_re: Allow MSN table capability check
      https://git.kernel.org/rdma/rdma/c/8d310ba845827a
[2/2] RDMA/bnxt_re: Expose the MSN table capability for user library
      https://git.kernel.org/rdma/rdma/c/6f6bfbc595fbae

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


