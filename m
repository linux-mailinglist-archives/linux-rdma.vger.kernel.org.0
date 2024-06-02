Return-Path: <linux-rdma+bounces-2753-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 610188D744E
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Jun 2024 10:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1BA1F215E7
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Jun 2024 08:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C1222F1E;
	Sun,  2 Jun 2024 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKeMqiEW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E50208A4;
	Sun,  2 Jun 2024 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717318234; cv=none; b=XnruJ2ly0UmXhjJcpSly/aHxPKCx7ohR9v68nkJ+NcBfH0odEUzcJlPGDLhZhp7aQ/fyFLLA7IdlkGWJuN1iLhy4dbGchAxNF/U220gJrDtKAGiGaMIvvjpvXp3K3hEzWRz4z7k/BiijnVPjS+dBMniuexSdsQ7fRYyfQZMWb0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717318234; c=relaxed/simple;
	bh=o/hTs+RxSHCSv9cGNdXL5q1hHmv1hCMRRnu4v7Iy1LU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rlwchcVxx9jIN3HIb5GpeMGo0wRj31Qau34qEmt+DQggk5wU8T2wuTvBPexeBdsCiI+4Iau9xIjvWEUsr3Gc+zUPV6SYX/uK+tLFYaBx9/JaOdVMYnkWq3W6hOjgeoe/ah+gMHA5Q+qTOZyw0enD4NGCDMbdxWn/nRIz8Rm+Q8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKeMqiEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D8AC2BBFC;
	Sun,  2 Jun 2024 08:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717318234;
	bh=o/hTs+RxSHCSv9cGNdXL5q1hHmv1hCMRRnu4v7Iy1LU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hKeMqiEWF/BmHvh3oAOMKOKfHpk4viY5VUM5eN3h5gjSlO8dKWMjOHTkSpQtD77Z7
	 VXR9f/8Msxp/AE0e3EfieD48bHGIaIR/U+a11mzFViT60bjE89jincDFiKeseQjzw9
	 UCzVVMvaVyG2VCPFTXWehHHTgaZ4FmbnrTDKZKx5+35+ZLoZch1POO7toibBrAjoip
	 ekTCtEf5WSFNi7csS1VdkSczdB+8tgr6A5vI+DuvcW8+W396tOBzG9A4cE+zCBp1+K
	 o+ZbqSoJsigRRI2ryiCGzUOmKQ1uZhAqe51m1lKUB4LSXPW8M2RYbl9managLnK8c7
	 wUKxRzaC39V4A==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, sharmaajay@microsoft.com, longli@microsoft.com, 
 jgg@ziepe.ca, Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1717070117-1234-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1717070117-1234-1-git-send-email-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH rdma-next v2 0/2] Fill in capabilities and guid
Message-Id: <171731822942.683551.7384620780314022652.b4-ty@kernel.org>
Date: Sun, 02 Jun 2024 11:50:29 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Thu, 30 May 2024 04:55:15 -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> This patch series fills in GUID and device properties.
> Most of these properties are required for CM.
> 
> v1->v2:
> * Added a comment to the CA delay
> 
> [...]

Applied, thanks!

[1/2] RDMA/mana_ib: set node_guid
      https://git.kernel.org/rdma/rdma/c/65357e2c164a08
[2/2] RDMA/mana_ib: extend query device
      https://git.kernel.org/rdma/rdma/c/c8683b995d8aba

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


