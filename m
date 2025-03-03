Return-Path: <linux-rdma+bounces-8270-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2D0A4CBE8
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 20:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 058A77A315C
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 19:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA4E148316;
	Mon,  3 Mar 2025 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5xge0eq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE91E33F6
	for <linux-rdma@vger.kernel.org>; Mon,  3 Mar 2025 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029510; cv=none; b=kd1Fy5wxfAV8pGB0d3Lgaq+Fwr92MXkhTRn9ni2cIJAsXBLuVEQyFjPA7/X72WwASIdPftvw9TIHrvHLUt9hhTQzLDnFHeTcLP8jcryvomqdBrlClw/Bfq9TGspyNt0TXHFgXKbmhxXFxLNTvrxKNvfkt/Xj4KgewoY/fgs38WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029510; c=relaxed/simple;
	bh=pYi7u8DW0nQlCdhhJRJU4NP2X1BCjv/nknhLOql1XPM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Tg83jAtXPg9umsOOPT5wLCh7fBGvjJw3biqiz+BJovRifXAhQ+q/yZ71F3jnUGi9WUVI4Tfq8VtnuOwcyUqItdhOSak2v9IPYC8eNDDxmRIKqZvmFELJ6nv3vuj0yv6s6eNGdDS3ZtKBc6ub/ELH91KBWjDrYYssWnew6/JEH1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5xge0eq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D2AC4CED6;
	Mon,  3 Mar 2025 19:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741029510;
	bh=pYi7u8DW0nQlCdhhJRJU4NP2X1BCjv/nknhLOql1XPM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=c5xge0eqHUfwhwUx9WboFVCR6Qr2mpJ443BBFGIEiIvCZkwobtPBub4maWkTjdQ2r
	 NoscYJz2RIfNLI3n88A0Hka9zbjlJSfduykvSThTsJAXvOfI88qj8ylhY/1+tjKiQy
	 vSS+cWjX8wiDitBVDriSPBkeA01xvbmyeSdrx+nLD+kHlsVy+E0y8h5/vsYYSIwGhI
	 HTHIpYWa86uzg+uIKVGadpdcPRMikgiuu20e3axJB6Bi/D/6JHqoav9V7k0qKaO3rk
	 oYvLAWdgXlLaBYgZeT1QikjcnOwPKufh2wR96PAqTOo6hvVY/oGVTH50DtSy2qKcuU
	 uayrM+lDqUysg==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 kalesh-anakkur.purayil@broadcom.com
In-Reply-To: <1741021178-2569-1-git-send-email-selvin.xavier@broadcom.com>
References: <1741021178-2569-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH rdma-rc 0/3] RDMA/bnxt_re: Bug fixes
Message-Id: <174102950710.42942.6950220751217847963.b4-ty@kernel.org>
Date: Mon, 03 Mar 2025 14:18:27 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 03 Mar 2025 08:59:35 -0800, Selvin Xavier wrote:
> Includes some of the critical fixes found while testing
> with increased resource limits. Please review and apply.
> 
> Thanks,
> Selvin Xavier
> 
> Kashyap Desai (2):
>   RDMA/bnxt_re: Fix allocation of QP table
>   RDMA/bnxt_re: Add missing paranthesis in map_qp_id_to_tbl_indx
> 
> [...]

Applied, thanks!

[1/3] RDMA/bnxt_re: Fix allocation of QP table
      https://git.kernel.org/rdma/rdma/c/82f1f575aa13a6
[2/3] RDMA/bnxt_re: Add missing paranthesis in map_qp_id_to_tbl_indx
      https://git.kernel.org/rdma/rdma/c/67ee8d496511ad
[3/3] RDMA/bnxt_re: Fix reporting maximum SRQs on P7 chips
      https://git.kernel.org/rdma/rdma/c/e8e6087c2f7407

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


