Return-Path: <linux-rdma+bounces-20577-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Np2CGSRBGoVLgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20577-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 16:57:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 831AE53593F
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 16:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55FC53363A9D
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 13:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC893280018;
	Wed, 13 May 2026 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNVhnO78"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D85282F34
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680314; cv=none; b=GS8AAV6wSr1+08bOP81R7v0bDznVpMiOqS8nwql9BmGc7dLwDkgDe7ezXpz2odOYfLxIaofwJ6VrquDMvc804rwlrE4YTc/unSA+jEpGUyAJbxw5vUo9UxRClhAEpf9l6Nxk0vJ3uQyo/Q9jDSEWidzROREDzOo2zvLme0JS7I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680314; c=relaxed/simple;
	bh=qcKfecleHTduUs0ntp/uc1xBPVuXFPWClPwpCFdXRbo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f1v2RNFF8XBlbeR3C6/w+QIHNCFE3dX71L9KhXzlXQGQPwgfiDB+jzm9w8+s9TH4ZuIusWp7DcF9n8DvFmPidy02zXC9kqjEewwo8pk3hO5JOMmDJpxirFkMqsGnUXpTof5j2jBtEJHc0hD6ROKIWiPUAauIUOtV584qrMk8qvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNVhnO78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03BDC2BCB3;
	Wed, 13 May 2026 13:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778680314;
	bh=qcKfecleHTduUs0ntp/uc1xBPVuXFPWClPwpCFdXRbo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CNVhnO78cPxzV70YI2YoY/NIQxSQNwRFw7fSdQcDgm9U4F7UhkpMArhtcQhwLmUUB
	 VCwJkhT4/yyYJjTgSWtaC1f3naE/oSs7xtKwuOyJHbbxrtI5bqhHTaXTEaWloHSVFm
	 RPArPpzIb/93/b1EWdFv9dMfmJoV4Wv917/irEtiUJkHTW7YfCsp4K00Ce+rcjrNDl
	 w32F5qopXnSu/6D2nWDEeuOSdYIR+n02qXO9we0ajohpVsgZGt3vdy1yrejuTfshls
	 rP5IV5GTXu+nfPX0N4qL+Ijut7LFAVGDhjbCgmuZFChA0KI52NootssNApjAuNrLtM
	 ZgM35/721o6ig==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 tangchengchang@huawei.com
In-Reply-To: <20260507012148.1079712-1-huangjunxian6@hisilicon.com>
References: <20260507012148.1079712-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH v2 for-next 0/3] RDMA/hns: Support congestion control
 algorithm parameter configuration by debugfs
Message-Id: <177868031111.2312230.3184039384666355404.b4-ty@kernel.org>
Date: Wed, 13 May 2026 09:51:51 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Queue-Id: 831AE53593F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20577-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On Thu, 07 May 2026 09:21:45 +0800, Junxian Huang wrote:
> This series adds support for congestion control algorithm parameter
> configuration by debugfs.
> 
> v2:
> * Inline init_debugfs_seqfile()
> * Remove delayed_work and related logic
> * Add usage example to the commit log of patch 3
> v1: https://lore.kernel.org/linux-rdma/20260206103110.3414311-1-huangjunxian6@hisilicon.com/
> 
> [...]

Applied, thanks!

[1/3] RDMA/hns: Initialize seqfile before creating file
      https://git.kernel.org/rdma/rdma/c/06e00315ca7392
[2/3] RDMA/hns: Add write support to debugfs
      https://git.kernel.org/rdma/rdma/c/ac1c5387287939
[3/3] RDMA/hns: Support congestion control algorithm parameter configuration
      https://git.kernel.org/rdma/rdma/c/d0c4051a6830d9

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


