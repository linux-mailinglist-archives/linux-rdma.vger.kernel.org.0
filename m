Return-Path: <linux-rdma+bounces-8613-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A19A5DE5E
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 14:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 217EB7A9F6A
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 13:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB21B24BBE7;
	Wed, 12 Mar 2025 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Or8qFKYR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7053D24A065
	for <linux-rdma@vger.kernel.org>; Wed, 12 Mar 2025 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741787499; cv=none; b=TyECDiJHrPJTRfDTtae8Dod3saVzout+OXQyBadJCldA7vlbqgxCpoXTa0QCICGpO/OcR3mQLoT9BcP5JPUAGjwtfXH+GzD4bmpNxYdSoDr5hlPzs9TmkZBWvuqxWX/ftrJOhFf99rbmmpdPOdNRz+lNX+v4/6x3j5nfq1TRth4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741787499; c=relaxed/simple;
	bh=zKAudusQNF/N82eHYvC15TFilHw3jwXrdMMLSZL3+dw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iyxtsXrmzEiV9K/pecIfQVT1XUhIg2P5CHoFgoPgScr9+jtqAodiNL6YmG+rSj9ort/JDtYAbyRnjlzsqHJLqZPyf544FkHaVDbMtjQuMSynfhtreZW7luD2TqQVahu+93ks6D1Iw5tfMnFC1HSlfkJCOzh+pzeuSYjf2Rl05AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Or8qFKYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86006C4CEDD;
	Wed, 12 Mar 2025 13:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741787498;
	bh=zKAudusQNF/N82eHYvC15TFilHw3jwXrdMMLSZL3+dw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Or8qFKYRyRPmXd5ffIFEm/jD3kgxpTdCGAysyIWbAk//nrE2E7XSzDy7mixDflhSp
	 7MWPLu1h/1wkne1CSWUxf8pD3luAC+Z+EJir3/0uRhk53QLYZdQpLKcSpe6cjU6gpW
	 Zw9nkhn8ttZAcnpOPTqwtKmsEryftz7HXKHZ6fADyxiu/b9xyK3Gnf35TbPdxkD1bJ
	 2jHBbINBYLuqGQ60u2+35PfJmJrZj2ni5CTBl/YBXtWh9R7jPdylKQoSDzVF+cwDK6
	 edCKo6Wdh6i4aG25kWxqim0Kz+B2uKQKPk2d9zXgKOjDJkEA4bNhH9KQ+c+mFT1GKw
	 4jS7GxQhQbRWA==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 kalesh-anakkur.purayil@broadcom.com, 
 Saravanan Vajravel <saravanan.vajravel@broadcom.com>
In-Reply-To: <1741670196-2919-1-git-send-email-selvin.xavier@broadcom.com>
References: <1741670196-2919-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH rdma-rc] RDMA/bnxt_re: Avoid clearing VLAN_ID mask in
 modify qp path
Message-Id: <174178749547.524290.5404278581702527572.b4-ty@kernel.org>
Date: Wed, 12 Mar 2025 09:51:35 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 10 Mar 2025 22:16:36 -0700, Selvin Xavier wrote:
> Driver is always clearing the mask that sets the VLAN ID/Service Level
> in the adapter. Recent change for supporting multiple traffic class
> exposed this issue.
> 
> Allow setting SL and VLAN_ID while QP is moved from INIT to RTR state.
> 
> 
> [...]

Applied, thanks!

[1/1] RDMA/bnxt_re: Avoid clearing VLAN_ID mask in modify qp path
      https://git.kernel.org/rdma/rdma/c/81c0db302a674f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


