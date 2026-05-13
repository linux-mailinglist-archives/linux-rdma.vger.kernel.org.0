Return-Path: <linux-rdma+bounces-20602-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHoMNMvEBGqbNwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20602-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 20:36:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CE153910C
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 20:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CC0D30EE181
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 18:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D230E3A872B;
	Wed, 13 May 2026 18:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDaFlS71"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933D23A7D60;
	Wed, 13 May 2026 18:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778696964; cv=none; b=SntP5qA8rD1ToFSy/Yx2uLNfur/pjZ6qAjdtoFAAGU9eufDcshS0kh0nzrygNLve7XE9RYDD0TdZSJJpy1WxlPKXj1yyjo6bQb3YpXR4mznilNhzkqAqCTwjo5zyrtwssp7aRDI3nGyk1DE81WgRUsqlJJVxc7DMr4N9Fj/hFqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778696964; c=relaxed/simple;
	bh=dHqFt6o14eM1mEJOp2fdhtJpJ+g7+jLSgyKOQNImFRY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nK7gFSxcPY1CympUPAxx9BNBYomb9xL2CP4A3+gf+qHpY+wOpCbi6QmmI/24/FgVasr0cUvtk2QieptNGOAhUvnM55PjIcHNOYgyu3SbMWY3uf+PsvKQje25prWEAQ86IYfWduRp9neEHmDPIO5LNiyRaLUk2tBYyCCVhuHr7go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDaFlS71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEAFC19425;
	Wed, 13 May 2026 18:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778696964;
	bh=dHqFt6o14eM1mEJOp2fdhtJpJ+g7+jLSgyKOQNImFRY=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=hDaFlS71ZdZ+SURQLN+tkFVmNtesUwZwjZrCRS8vkemtblfzZu9yrltjmccihHqln
	 QJtsnKxF7bhPucdmmCwjulLQYZDNyGIYQx4skt8CgPQPPegGddTciYEj20q40FNgVm
	 w1wfAS781EJaoFLeVbdo+LJqcb57sDyrm5oxg2Cj6yWf/EVwfWfhKX1YFIsR5NQ3lo
	 sO3s6fzaknA6g6cumCl6BfKnU2oIxR2B2JTmlpSGoqiPK+gC1Yrl5Fs0tVHubkSTIG
	 v7rONyZ3CAjxoF+sxrAk9EAvzz7OeT5DRaJw07PZkfvABgdap/nx6NF/vERcK09dmA
	 mt2QGw+3YaS8w==
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Shuah Khan <shuah@kernel.org>, linux-rdma@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yi1.lai@linux.intel.com, Yi Lai <yi1.lai@intel.com>
In-Reply-To: <20260507125106.3114167-1-yi1.lai@intel.com>
References: <20260507125106.3114167-1-yi1.lai@intel.com>
Subject: Re: [PATCH] selftests/rdma: explicitly skip tests when required
 modules are missing
Message-Id: <177869696105.2335855.678607825500935944.b4-ty@kernel.org>
Date: Wed, 13 May 2026 14:29:21 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Queue-Id: 58CE153910C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20602-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org,vger.kernel.org,linux.intel.com,intel.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ktap_helpers.sh:url]
X-Rspamd-Action: no action


On Thu, 07 May 2026 20:51:06 +0800, Yi Lai wrote:
> Currently, the rdma rxe selftests fail with an exit code of 1 when
> required kernel modules are not present. This causes spurious failures
> in environments where these modules might not be compiled or available.
> 
> Include the standard kselftest 'ktap_helpers.sh' and replace the
> hardcoded error exits with '$KSFT_SKIP'. This ensures the tests are
> properly marked as skipped rather than failed.
> 
> [...]

Applied, thanks!

[1/1] selftests/rdma: explicitly skip tests when required modules are missing
      https://git.kernel.org/rdma/rdma/c/0bf1b4dda2d0c8

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


