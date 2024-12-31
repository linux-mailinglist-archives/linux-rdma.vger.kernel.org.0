Return-Path: <linux-rdma+bounces-6774-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B809FEFC2
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Dec 2024 14:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7346E1882FBA
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Dec 2024 13:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F2919D071;
	Tue, 31 Dec 2024 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNrM9qNw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C9A196D90
	for <linux-rdma@vger.kernel.org>; Tue, 31 Dec 2024 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735651731; cv=none; b=RlSxM4m6/rUVHGc6iLkywNWiFV1YAtIA4ElxEd0ungxR13eDHWEyhw/Geclsk0xrL+XTpnaaszYwiHYVq+KkZMXvvMHVtYYAM6bjAAkitAGbDSym7XNecnsIgvv37RgaDHByl11/K8i6GHYD16kIpN31rnpMexaHUi2MyhsNeoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735651731; c=relaxed/simple;
	bh=MirL1oP2jbp1+49gDZYZ51V49MYd2dWpmlaSf6E2WrY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F/2O9vfgxA9XqPPkzKOZkdI0C8h57uwuOgoMi5NEp5dQGCB18rw9doWSXeRQvP0RWOImelKdmehvS3h4dg0uJ9PaKCrtOv4/z+974sIL6UWBVFjxlJu9MDVnzu1YDEcYqx7ckWP9kfm3K4A5zotmyILcR5v7f0fhwsy9dN90GbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNrM9qNw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A243C4CED2;
	Tue, 31 Dec 2024 13:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735651731;
	bh=MirL1oP2jbp1+49gDZYZ51V49MYd2dWpmlaSf6E2WrY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MNrM9qNwNT1tDO7k29UUhe8du5H/gF4yLzdiBD9RAO3/LIvV3MIiedf5a0vRc11a0
	 R2N8MOSMxkxuMx/ub6Y/j32L3tuMotUG0UfEC+Ji7t5biSpujIPrdqSPDh1h5SehVC
	 4fu1jTZXr5TkkxKcZUvOoIVLwIMvrkzt4ohk3dxpwMrjuprxVNHqKG5KHYZEd8Ta4E
	 C2PJp1aiOMfhLnWUYuXWr7O7Pnf/yCAW97xJ6eELyTMqBonz2a2Xxh/oIHqY7LQAr4
	 wi9jcbegjvBaWQCZ5YpS7DvFLl8wZproDEeTq3X8XvxHCFxlKXx4mV4v5mS+7Vl+T7
	 cewcQHMbS2bGQ==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 selvin.xavier@broadcom.com, Kashyap Desai <kashyap.desai@broadcom.com>
In-Reply-To: <20241231025008.2267162-1-kalesh-anakkur.purayil@broadcom.com>
References: <20241231025008.2267162-1-kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH for-rc v3] RDMA/bnxt_re: Fix error recovery sequence
Message-Id: <173565172785.104170.14248448142279130600.b4-ty@kernel.org>
Date: Tue, 31 Dec 2024 08:28:47 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 31 Dec 2024 08:20:08 +0530, Kalesh AP wrote:
> Fixed to return ENXIO from __send_message_basic_sanity()
> to indicate that device is in error state. In the case of
> ERR_DEVICE_DETACHED state, the driver should not post the
> commands to the firmware as it will time out eventually.
> 
> Removed bnxt_re_modify_qp() call from bnxt_re_dev_stop()
> as it is a no-op.
> 
> [...]

Applied, thanks!

[1/1] RDMA/bnxt_re: Fix error recovery sequence
      https://git.kernel.org/rdma/rdma/c/e6178bf78d0378

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


