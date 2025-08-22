Return-Path: <linux-rdma+bounces-12883-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED054B31C26
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 16:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19AEFB26B4A
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 14:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364CE313534;
	Fri, 22 Aug 2025 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="no1IL5lX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78493054CF;
	Fri, 22 Aug 2025 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873104; cv=none; b=HyYHfMZvage5sH+/IZ8RDNsmI7BjoDoQJ7G/WXQUwpkg1ly9CVUIcva+uhC/LFfVgx868sAbcYXyDwDcdtpmCGuuY4H2JwPQUWVMQqOa01jW0LhcuDJZZ2VicKr4yKkT2x/+vmtq/cvR7x2M1yh2pRvtDTFjpCEC5s4cWGFqScY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873104; c=relaxed/simple;
	bh=Ut0GxJ81XVLG/5Ub+K5PIxBrVRK6IhYm+s3WgeIowmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jKCLJIVl1pSaT8o60yCcUui9orqETjKSvCc3Yj7rwFALKJUVCNNuq7kHR2WnZQbGgfnuMX7QLMQ3RN2zRijF4XtU6GSkuh++M4ranhP3q9/IuaoxcHyrm6FwH2Md5QL7GzQYgsxyNQ1/ZNT9ZEw1DzpXP8156O8IbEL+PINa8nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=no1IL5lX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC39C4CEED;
	Fri, 22 Aug 2025 14:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755873104;
	bh=Ut0GxJ81XVLG/5Ub+K5PIxBrVRK6IhYm+s3WgeIowmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=no1IL5lXniagCGOwBXmhPC6D1o8etNuuwEO3DA7zzs2fO6VMa/zlzKZa4AWMqGl+n
	 ctYbqbwph7LrXHi8lFkdJxgVJyJfYxQ89OB9NXFtnuHM+EtRMpVB0nP7joPWiJHKlb
	 y6RzCyf4dcRd0o9mMETR1DKCvP/MNX2zZichhQHZFxhprgJGmfxrNaKtDVAfgowMOY
	 mnUWSJrMzd9rihd+3WS1B0/eAcJEdai9hNEwue8DG5HRkO3D5VuFGKcQJTqrLsl4fh
	 BViGFidk3PZ4XUcJEffc1XJT9o7PJmNmDtbE8xqNRZgTDt9d9Quunyf3F+pNPaqqyY
	 4xb0pJQtuQBMw==
Date: Fri, 22 Aug 2025 07:31:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: leon@kernel.org, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, andrew.gospodarek@broadcom.com,
 selvin.xavier@broadcom.com, michael.chan@broadcom.com, Saravanan Vajravel
 <saravanan.vajravel@broadcom.com>, Somnath Kotur
 <somnath.kotur@broadcom.com>, Kashyap Desai <kashyap.desai@broadcom.com>
Subject: Re: [PATCH rdma-next 01/10] bnxt_en: Enhance stats context
 reservation logic
Message-ID: <20250822073143.271ff5ae@kernel.org>
In-Reply-To: <20250822040801.776196-2-kalesh-anakkur.purayil@broadcom.com>
References: <20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com>
	<20250822040801.776196-2-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 09:37:52 +0530 Kalesh AP wrote:
> From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
> 
> When the firmware advertises that the device is capable of supporting
> port mirroring on RoCE device, reserve one additional stat_ctx.
> To support port mirroring feature, RDMA driver allocates one stat_ctx
> for exclusive use in RawEth QP.

Acked-by: Jakub Kicinski <kuba@kernel.org>
-- 
pw-bot: nap

