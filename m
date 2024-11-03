Return-Path: <linux-rdma+bounces-5704-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CAE9BA628
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Nov 2024 16:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06D13B21631
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Nov 2024 15:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B1317DFE9;
	Sun,  3 Nov 2024 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfzhIWCl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD4217BB16
	for <linux-rdma@vger.kernel.org>; Sun,  3 Nov 2024 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730646071; cv=none; b=c8U30x0Ig2RzCXtpr4CBE6XUrB1uA6z2K8lJ6yP1NCZd3ZhIxDzgJIy55zVd4043Tu/weFWMhQCQPGH7VhPXFrzdKZVl89pjDs5k5zcbtrY6/zTAqvYKfflhXC/zwb1k0kLrOKq3UcFY3tRwoftHqwXeSp1/Kb+ZmZO3txtHVXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730646071; c=relaxed/simple;
	bh=1Qj/w7D8U2QdpEtFUY+Tt5/5pvOZi/Ov04eBfg3XLyY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o5nUvptYziN8DkIT6tBPwMGtt3oNfIG670xvSPeLhnq8kAT82FdAje19F2Ec5SKtCHct78TYCdwMLuyWZo9pR8FWc+75LHD6vigbcFXG3v3icTQXX4V7VJU7AL+SktFxv8hguH+630zG3O0hpqp3JglBe2wTGot5D02b0Yi6KRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfzhIWCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9825AC4CECF;
	Sun,  3 Nov 2024 15:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730646071;
	bh=1Qj/w7D8U2QdpEtFUY+Tt5/5pvOZi/Ov04eBfg3XLyY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bfzhIWClN8T6cGXkuGXPGxOJISPvELvEnSxwRmnVrHK833IOsv+mhlYLm77rmqFvk
	 jr7Cbe/aSAP8JL6tooTVqAHtSsW1r3PFgPmbrJ08m9n5ZwTpfWhHtX9ghOsZR6aih5
	 6MMcXGgUE3GpXRiTwRuIfARf2zhhSlaSK85j5Qem2jA7WVYpN9Y8br+yQA+D+cv3Ya
	 LUu1TdxsT7o0L37172DIHogYQT7gDrejeEs8gNkT9J5SHgkUZGc58C8SEkyVzTd52E
	 jYxxxMgE8QsSqXKJ2xDOZeA2HjMeD4hXm3prqYgpaSP2dBKgzkg/0FiLG07RpWUoNx
	 Q+shz4xLnb5nw==
From: Leon Romanovsky <leon@kernel.org>
To: zyjzyj2000@gmail.com, yanjun.zhu@linux.dev, jgg@ziepe.ca, 
 rpearsonhpe@gmail.com, kamalh@mellanox.com, haggaie@mellanox.com, 
 dledford@redhat.com, monis@mellanox.com, amirv@mellanox.com, 
 Liu Jian <liujian56@huawei.com>
Cc: linux-rdma@vger.kernel.org
In-Reply-To: <20241031092019.2138467-1-liujian56@huawei.com>
References: <20241031092019.2138467-1-liujian56@huawei.com>
Subject: Re: [PATCH rdma v2] RDMA/rxe: Set queue pair cur_qp_state when
 being queried
Message-Id: <173064599658.108118.6878315756302780832.b4-ty@kernel.org>
Date: Sun, 03 Nov 2024 09:59:56 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 31 Oct 2024 17:20:19 +0800, Liu Jian wrote:
> Same with commit e375b9c92985 ("RDMA/cxgb4: Set queue pair state when
>  being queried"). The API for ib_query_qp requires the driver to set
> cur_qp_state on return, add the missing set.
> 
> 

Applied, thanks!

[1/1] RDMA/rxe: Set queue pair cur_qp_state when being queried
      https://git.kernel.org/rdma/rdma/c/28f8c1ef36536a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


