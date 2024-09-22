Return-Path: <linux-rdma+bounces-5038-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB65497E1E9
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Sep 2024 15:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D179F281389
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Sep 2024 13:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73C023C9;
	Sun, 22 Sep 2024 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okAgfVmJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634AAA23;
	Sun, 22 Sep 2024 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727013253; cv=none; b=c9vN1hcutw/Q+G3zngYPDFqeynPNYFsACopgSo7s9oKSGiCdUH7pAlmx4B9qVYysLk/vF5Es2dEOreh2GjcKiSbQlplRJPce2739NcIyjfpRED4/iNeyJ+rBtNL5UuHw0EdAGcnsYUuFouVM1YuC31qiOXf7GgVSYWv8/gClbzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727013253; c=relaxed/simple;
	bh=9tiguhcolhFfbHHe2ekeCKKjhQrJ/qQIKIaigZf1OXo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iIlBZCP/zIToSoFg1dx6Uq7SDfNadjPcETNBfVkoZnsYOiIe9JcXRlrtgbhYWlBEsjyRuzsefSH0ax5ko4fiPYzyv2gNWjqBCk7keHblAyWaSUfWCSfAuR0/3lcAETExMusXAXxTvUnnB2G621oFuLxTTT239zNrXTctrQOEytQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okAgfVmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EE1C4CEC3;
	Sun, 22 Sep 2024 13:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727013252;
	bh=9tiguhcolhFfbHHe2ekeCKKjhQrJ/qQIKIaigZf1OXo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=okAgfVmJqK67gT1cvV1gtt9SMpo/R8v0tqFeYNqF40wDdQb6b10jc0dDxyDLSWIyE
	 jh6EVc4M5A5+bRtqt0EqC2EtSwrw+Xsby0CmU1fB3cg/gldQ9+zDmErYt3mjTf78r4
	 t+BpZ2h+FmmHtiLKZd1U6QGF1zz12PdLorsgpopvniNowIaaHPuxqQyWgydXo2sLWb
	 qwMLgE/rTvDZJKoqquwGEcp2Lnhnh7HuEm1TvG0f806XDokouNtG0+R27gnxb5XZhw
	 uMZHUZ5pJ4rrfAEzBvE1DNIcLYhmMcDHNnFAZDh54+jIyg4jn7A29bOH6A/3/Egwyx
	 ZLj8BIseD/RHQ==
From: Leon Romanovsky <leon@kernel.org>
To: selvin.xavier@broadcom.com, 
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20240918021632.36091-1-jiapeng.chong@linux.alibaba.com>
References: <20240918021632.36091-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH -next] RDMA/bnxt_re: Remove the unused variable en_dev
Message-Id: <172701324435.35916.2289341977063910735.b4-ty@kernel.org>
Date: Sun, 22 Sep 2024 16:54:04 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-37811


On Wed, 18 Sep 2024 10:16:32 +0800, Jiapeng Chong wrote:
> Variable en_dev is not effectively used, so delete it.
> 
> drivers/infiniband/hw/bnxt_re/main.c:1980:22: warning: variable ‘en_dev’ set but not used.
> 
> 

Applied, thanks!

[1/1] RDMA/bnxt_re: Remove the unused variable en_dev
      https://git.kernel.org/rdma/rdma/c/70920941923316

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


