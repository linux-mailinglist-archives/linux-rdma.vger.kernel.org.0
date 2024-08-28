Return-Path: <linux-rdma+bounces-4614-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 775C9962574
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 13:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF0A1B23D25
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 11:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9BF5A79B;
	Wed, 28 Aug 2024 11:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZ4GB+i0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F17A15A86D
	for <linux-rdma@vger.kernel.org>; Wed, 28 Aug 2024 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843143; cv=none; b=nfRUUZXabAreJ4qcMDd7DQnPtzJFu3RU7FQJoejjNjcJWODZu055K/wmXUDu71qFu/d2FJxZT9tWtBL8+e1P0zLcrBNWLt0e+VP14UtTm2YS1KsSYHHBLHcO7kVKVDJkyxsS0X9hwbivWbRUi02p/uYHu5lCGMYFclQvKKvVIEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843143; c=relaxed/simple;
	bh=kj6AXJF+wRtQl9HUpoolXpNNjcbgZsnTaqyiMIuatwQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eGDwaa0yJl+utK7+gkWRf4tC52cUYAKCcFwPPzeG0ob2OWgzaa17+YlrgXfOK14HojBzM5jaLxpCrmTUVSTHfiI4mJfzLOYT7/9JF438CJ20FyZI/m6o7hT1r55QgTrzLu4zlSnDgu+RQdNZMU8rWJs+6f3PzUtV2FDFh3aSbaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZ4GB+i0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC25C515B0;
	Wed, 28 Aug 2024 11:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724843142;
	bh=kj6AXJF+wRtQl9HUpoolXpNNjcbgZsnTaqyiMIuatwQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kZ4GB+i0o3jDO+lwl2kKn5jYgZLIltOHZHhiQFNcFv1ycfdmlFqKKSY6jfdaWDIlm
	 p7jx46POyWhZ2PFN4B9k3TNKsuye69VsV1N5Lq7BhsOl/V8w8UPRoNjQ7ml+nOKrPq
	 D/CLmwWWy7V36m3+Vhp6vBw3hTQc74BPWVMkBbmgeTRwxCdyp2rXhrTldpE4Hkj8xU
	 0VgciFiMnxyLWnfhR3opz0OYTVOppDf3RHJu9EDdmQ3ZpXcSvTQKCNie46Kq56+w6B
	 DhjtQVGnFKNk63C85IMB3GRr0GHyMc50p9hD/zV4GkwSoZM/cUl7VKzbfrwX1AaWQO
	 SvCKvLrazBvHA==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Md Haris Iqbal <haris.iqbal@ionos.com>
Cc: jgg@ziepe.ca, jinpu.wang@ionos.com
In-Reply-To: <20240821112217.41827-1-haris.iqbal@ionos.com>
References: <20240821112217.41827-1-haris.iqbal@ionos.com>
Subject: Re: [PATCH v2 for-next 00/11] Misc patches for RTRS
Message-Id: <172484313894.43726.4533276109280349985.b4-ty@kernel.org>
Date: Wed, 28 Aug 2024 14:05:38 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 21 Aug 2024 13:22:06 +0200, Md Haris Iqbal wrote:
> Please consider to include following changes to the next merge window.
> 
> Changes in v2:
> 	Dropped 2 patches as discussed.
> 
> Grzegorz Prajsner (1):
>   RDMA/rtrs: register ib event handler
> 
> [...]

Applied, thanks!

[01/11] RDMA/rtrs: For HB error add additional clt/srv specific logging
        https://git.kernel.org/rdma/rdma/c/e8e09e95e053b8
[02/11] RDMA/rtrs-clt: Fix need_inv setting in error case
        https://git.kernel.org/rdma/rdma/c/69fd17b33e5f3e
[03/11] RDMA/rtrs-clt: Rate limit errors in IO path
        https://git.kernel.org/rdma/rdma/c/ba03df2c07b8ab
[04/11] RDMA/rtrs: Reset hb_missed_cnt after receiving other traffic from peer
        https://git.kernel.org/rdma/rdma/c/333188fb8459be
[05/11] RDMA/rtrs-clt: Reuse need_inval from mr
        https://git.kernel.org/rdma/rdma/c/a4ae49a5cceed8
[06/11] RDMA/rtrs-clt: Reset cid to con_num - 1 to stay in bounds
        https://git.kernel.org/rdma/rdma/c/a4f1332777729d
[07/11] RDMA/rtrs-clt: Print request type for errors
        https://git.kernel.org/rdma/rdma/c/d48eeb83707b5c
[08/11] RDMA/rtrs-srv: Avoid null pointer deref during path establishment
        https://git.kernel.org/rdma/rdma/c/3a92d941fee13c
[09/11] RDMA/rtrs: register ib event handler
        https://git.kernel.org/rdma/rdma/c/67d225711c30a1
[10/11] RDMA/rtrs-clt: Do local invalidate after write io completion
        https://git.kernel.org/rdma/rdma/c/97e9e0815fc8da
[11/11] RDMA/rtrs-clt: Remove an extra space
        https://git.kernel.org/rdma/rdma/c/20ded2d6dbaaa5

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


