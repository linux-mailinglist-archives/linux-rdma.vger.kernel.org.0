Return-Path: <linux-rdma+bounces-7616-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD679A2E69B
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 09:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84EC13A608B
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 08:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED6F1B87F1;
	Mon, 10 Feb 2025 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocYKeccJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD9157C93
	for <linux-rdma@vger.kernel.org>; Mon, 10 Feb 2025 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739176833; cv=none; b=H8m30W+Uck+FkWgH/V+41BauJgbrs5aTE6jH1xI1iJU1/jFQ3VdEh/cfJdEAINuKM97rHajiMpaUDhcs187Bt37/GPOfZ6Icu4VoaEddZTzod7VLSv9k4QgtKhGHo9TGfRb1ZUKU2uncz9VP/ev0eMycT4wV2o60bnVvIEQu7rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739176833; c=relaxed/simple;
	bh=NHvju3Nr3qOQr6/uMcpVsAGpqURlEd3jDO8l3IL24Jo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=twrPCmBwxmhGrf8f92B4ToJdJJz7qqY2z7HfW6EBP0REX7XFl7I7sntrUja5W8gKtpVfXI1oNDNA81W+QoyZuKMISLtC3XJgZf+Nk8zw6B5BJv9HxzACC6YpwfnM5GrNGBXXPIZIqXSgmVrGIqP4+1WSuNp3hbRLpQktm9MT+T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocYKeccJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CBBC4CED1;
	Mon, 10 Feb 2025 08:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739176832;
	bh=NHvju3Nr3qOQr6/uMcpVsAGpqURlEd3jDO8l3IL24Jo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ocYKeccJJysDrd9jloAWkh6NZBh/5silRI7PCYZBzf/mZ/JWUoiwNw8wwQaSX/lhz
	 r/yI5lMStNGJWeURMQG8S1BKndApd7VsApSE1KT6y4WDAglgOuVGgVQfAsoec7jK0j
	 uVMCufWRyb2LWDly639LV2UaFpxx7d/TabfsGl4442/YhNHLkRZPBfTMhvVmZew/vl
	 29I5A72bs4PJCsMpdaX1IEC1wRKrwOwCwreYX7JpDI2EoYvgQj1VSFQ/GIGqRa2pju
	 jl/dzqAFl4/1sNYvgB54B0agSVS3s4SNSrSpJzT1kIQsLtk4qwXZ0+jEHkRwRqyeF2
	 J87ZbrE4Ztvkw==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 kalesh-anakkur.purayil@broadcom.com
In-Reply-To: <1738657285-23968-1-git-send-email-selvin.xavier@broadcom.com>
References: <1738657285-23968-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH rdma-rc 0/4] RDMA/bnxt_re: Bug fixes for 6.14
Message-Id: <173917682914.177911.5626008545129675874.b4-ty@kernel.org>
Date: Mon, 10 Feb 2025 03:40:29 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 04 Feb 2025 00:21:21 -0800, Selvin Xavier wrote:
> Includes some of the critical fixes found while testing
> the 6.14 branch. Please review and apply.
> 
> Thanks,
> Selvin
> 
> Kalesh AP (3):
>   RDMA/bnxt_re: Fix an issue in bnxt_re_async_notifier
>   RDMA/bnxt_re: Add sanity checks on rdev validity
>   RDMA/bnxt_re: Fix issue in the unload path
> 
> [...]

Applied, thanks!

[1/4] RDMA/bnxt_re: Fix an issue in bnxt_re_async_notifier
      https://git.kernel.org/rdma/rdma/c/a27c6f46dcec8f
[2/4] RDMA/bnxt_re: Add sanity checks on rdev validity
      https://git.kernel.org/rdma/rdma/c/f0df225d12fcb0
[3/4] RDMA/bnxt_re: Fix issue in the unload path
      https://git.kernel.org/rdma/rdma/c/e2f105277411c4
[4/4] RDMA/bnxt_re: Fix the statistics for Gen P7 VF
      https://git.kernel.org/rdma/rdma/c/8238c7bd84209c

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


