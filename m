Return-Path: <linux-rdma+bounces-1705-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B56893AD4
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 14:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A5F41C20D82
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 12:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAEB3717D;
	Mon,  1 Apr 2024 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZQLMEJR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E36F37169
	for <linux-rdma@vger.kernel.org>; Mon,  1 Apr 2024 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711973832; cv=none; b=t6DU45AwFy9qQViub8gwuGro1AacL3jmgMrPAKkhu3O0F6f+CQnEfa0m91iFGWFX/F6kG6BbdbY+8XifjVJstkYyIfclh3UrcONbhA/W3McIRDthAed1CXaXeHSDu3mEt6IsHIcv+LwUiAKA4qKj1qGSvgIoSLTPucFM00yx+b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711973832; c=relaxed/simple;
	bh=PcLYAOjWMfHjaVZjsDaiYQm7TDrOolTG/Y1wgpBfwCE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DyBYJJGffrhF6MJmTurwe8S+rpxZPYvOGxVSMSW3T8qLPtxS9FHJE7GW22ezh6QJNW8EZ2eyTEB0bAvsfsnoyzQdmea09hY1dISc7bQPKv8Rd6Q5SNfDCMeZfPd27ouB8otNr9hade7njqDdrhlAIohL0KVjCy7GRkX9C1kKaHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZQLMEJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A67C433C7;
	Mon,  1 Apr 2024 12:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711973832;
	bh=PcLYAOjWMfHjaVZjsDaiYQm7TDrOolTG/Y1wgpBfwCE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EZQLMEJR0SeMDO/ax+UgQaiRLdyQGXg25w03vNS32VoV7ey5Ka0H6NL48B1wQ9qOq
	 dyZws9fzy11xxbJMMiwbWC2YheTH/knAULOKConOdolx6aIuG6QS61N6OivgELU6IN
	 82PkfTWUkCfLBPI3azrU+r56zmx+IbclvEJTJj0cd2yHR3hE09keECZ1Xy7/Q5LgX+
	 DY9p8c59VYL1e/rMFGfU9DyHfyEdRO3Fk4x431UjaPPzzTShWTq/sFhfWVrJuX/ctY
	 CJ08+R3NcaT2EGZ6FyLGejgc2jQCO3ZjxaZfmVAKZLBy8bEnr5LnXscUNCYsRLH3yo
	 K+slMIw8TcFwQ==
From: Leon Romanovsky <leon@kernel.org>
To: manjunath.b.patil@oracle.com, Jason Gunthorpe <jgg@ziepe.ca>, 
 Leon Romanovsky <leon@kernel.org>, Mark Zhang <markzhang@nvidia.com>
Cc: linux-rdma@vger.kernel.org
In-Reply-To: <20240322112049.2022994-1-markzhang@nvidia.com>
References: <20240322112049.2022994-1-markzhang@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/cm: Print the old state when
 cm_destroy_id gets timeout
Message-Id: <171197382870.84337.15242485625077723578.b4-ty@kernel.org>
Date: Mon, 01 Apr 2024 15:17:08 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Fri, 22 Mar 2024 13:20:49 +0200, Mark Zhang wrote:
> The old state is helpful for debugging, as the current state is always
> IB_CM_IDLE when timeout happens.
> 
> 

Applied, thanks!

[1/1] RDMA/cm: Print the old state when cm_destroy_id gets timeout
      https://git.kernel.org/rdma/rdma/c/b68e1acb5834ed

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


