Return-Path: <linux-rdma+bounces-13358-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B837B572DD
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 10:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA1CA17BA4C
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 08:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA872ECE8D;
	Mon, 15 Sep 2025 08:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDqYsQ2a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F222D5C7A;
	Mon, 15 Sep 2025 08:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757924991; cv=none; b=ZT8gUor9ETyFCDv4vEzdIAUBGz/Ekc1dwlUI25nfsMh4C+lqqO0TIIapAWxmFCZ6jSXIci8zXBT8XczEI3Ids7e02c4FxXL/Y2Al0nOSzqPFdizW0Ry4LSvLneHJQawoQP0N3lb2t7ufxOl3655nc+i+Vx9BINFHNsxu+rjO4Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757924991; c=relaxed/simple;
	bh=gF9/HrmGgjRksh35Qep3asU5BNAyfAANYoWqvE6uqwI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gF4FlV5/A4beZe5F5n46S/zWmhWOHd//nPxr4kertVMyHz9TsrOARR1uPvjvdHT+C+wNsS71KfLvyVeFUVQD0UNxRCiPTckW4Z41wcWZwhZ9kPEiW0lz1ZjDml3GiyygxjFA/Dhm4BLTWPRjeRxGL9Hg9n0yrppMdRfhV/22tnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDqYsQ2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8C4C4CEF1;
	Mon, 15 Sep 2025 08:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757924990;
	bh=gF9/HrmGgjRksh35Qep3asU5BNAyfAANYoWqvE6uqwI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SDqYsQ2af0KYQUjy2BvEdEqsnyz2yCAoaEiNmT7d6UQln4uWJa7Qb++PPPW3mQfYb
	 LqsJjHHF2pniYuqy6b0Laku2b2/HTZnobOinlt5ceHL3+9ILB1Xt8mYwxxiEqdBeZt
	 g5abnnw6C7JGcjImwNhVjRpOzPUX5kljGgL5PE1EqRI3LAN/DrpyvpQUvVdNqkFyMm
	 d+JBnROErgKGzvRmdRPFWZ4dktZ7maoOG/v0qGQUNUwNQ01zck8JgTMXnNXlF9zXZ9
	 Wf6e8et2P3LpO7oLI/oNW82GGfQyOxxN+gOe5ykJGx9mqV8O2sOEq1/+7FjlMd1isi
	 MN3w9FhldF20A==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, shirazsaleem@microsoft.com, 
 longli@microsoft.com, jgg@ziepe.ca, 
 Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1757923172-4475-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1757923172-4475-1-git-send-email-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Extend modify QP
Message-Id: <175792498771.1313128.15175255511534291271.b4-ty@kernel.org>
Date: Mon, 15 Sep 2025 04:29:47 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 15 Sep 2025 00:59:32 -0700, Konstantin Taranov wrote:
> Extend modify QP to support further attributes: local_ack_timeout, UD qkey,
> rate_limit, qp_access_flags, flow_label, max_rd_atomic.
> 
> 

Applied, thanks!

[1/1] RDMA/mana_ib: Extend modify QP
      https://git.kernel.org/rdma/rdma/c/2bd7dd383609f1

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


