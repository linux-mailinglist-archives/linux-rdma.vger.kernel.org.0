Return-Path: <linux-rdma+bounces-7001-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA401A102B4
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 10:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E3A3A69EB
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 09:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC65284A71;
	Tue, 14 Jan 2025 09:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlmesrQb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04B224024E;
	Tue, 14 Jan 2025 09:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736845709; cv=none; b=EGVx7iCE/CH9bgrOImb09pCw1eZemEYfe4SVZQCDyyda/aKEP64Qjs+JlEg+s1w+ug2ll9cBP71TBwks+a5S7kPoeZalc0Eb0k4D4X6Dh0wL/l6b8vXyhZvLVpXwsAHSk6msC6PTELehxIEkYxx9ywsxo98UktZUr9Jq5IiufqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736845709; c=relaxed/simple;
	bh=3RYrVdQPh80KqcMpN7PWq4C8O7+h0KqOKpgNgEAJRNA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NkHi8C/3YxLIi0E4UsDJcvVcJJUgWlU6qryErO+PYdfIancWPpH/F6i8C8SZ9TGRX93/IzWqiYQHGuePAB9Ld0cdBwctdQ290frdszgU52B5CTlJ+jaER6CCBocF9slt1TNoX1pSGRr+h5+pLxP+xL94b7jlrcvMhTTCU8kAb2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlmesrQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA20AC4CEDD;
	Tue, 14 Jan 2025 09:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736845708;
	bh=3RYrVdQPh80KqcMpN7PWq4C8O7+h0KqOKpgNgEAJRNA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DlmesrQborGbRhQ8mwdIWJDLlicQS9pNEMUDwiDS/ZTpWje7NgJEHLdjgeR0d+szh
	 sempqhDBzl/FVLrXy0ZBWBf+FFfHVrPdiVKTKbxtsOWWn4H9FcqGcJJ06YTeOfmlZ8
	 Xr7+Zy6WZlqySdeFi4nmsVu0hyssUzEbxUNZo0ImimS98IwbQPWeJmHHdH9Vk+eBD9
	 8rL5CjS7vyFRip+iwq23Cag2/GrrYweXocUkl9v7VGbC8UNBrRUydV0v8fr8db8VZs
	 WVBjdanb//1aRy5wBxL8ZXipfByCTBAcVxeD2koc4phfG5BW33wcRTUwCu859c1Ci9
	 wEaHMPqAewVzg==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: linux-rdma@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
 andrew+netdev@lunn.ch, andrew.gospodarek@broadcom.com, 
 selvin.xavier@broadcom.com, michael.chan@broadcom.com, 
 pavan.chebbi@broadcom.com
In-Reply-To: <20250107024553.2926983-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250107024553.2926983-1-kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH rdma-next v2 RESEND 0/4] RDMA/bnxt_re: Support for FW
 async event handling
Message-Id: <173684570486.1197412.9859490859113506335.b4-ty@kernel.org>
Date: Tue, 14 Jan 2025 04:08:24 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 07 Jan 2025 08:15:48 +0530, Kalesh AP wrote:
> This patch series adds support for FW async event handling
> in the bnxt_re driver.
> 
> V1->V2:
> 1. Rebased on top of the latest "for-next" tree.
> 2. Split Patch#1 into 2 - one for Ethernet driver changes and
>    another one for RDMA driver changes.
> 3. Addressed Leon's comments on Patch#1 and Patch #3.
> V1: https://lore.kernel.org/linux-rdma/1725363051-19268-1-git-send-email-selvin.xavier@broadcom.com/T/#t
> 
> [...]

Applied, thanks!

[1/4] bnxt_en: Add ULP call to notify async events
      https://git.kernel.org/rdma/rdma/c/184fe6f2382bab
[2/4] RDMA/bnxt_re: Add Async event handling support
      https://git.kernel.org/rdma/rdma/c/7fea327840683e
[3/4] RDMA/bnxt_re: Query firmware defaults of CC params during probe
      https://git.kernel.org/rdma/rdma/c/c0ad30eddc2858
[4/4] RDMA/bnxt_re: Add support to handle DCB_CONFIG_CHANGE event
      https://git.kernel.org/rdma/rdma/c/51dc5312dcd929

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


