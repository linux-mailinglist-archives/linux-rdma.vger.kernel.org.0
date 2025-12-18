Return-Path: <linux-rdma+bounces-15064-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1519CCB452
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 10:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D453D300F1A5
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 09:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCD832E698;
	Thu, 18 Dec 2025 09:54:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C6532AAC1
	for <linux-rdma@vger.kernel.org>; Thu, 18 Dec 2025 09:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766051652; cv=none; b=sQ4JYMnsP0Y1WZq3PfTUk+s+jp2QNeeZh6c9JhFM0TGYFmVwDEEAV7ZPY3kHrfE/TQt/8gJCWmovGYhCthknDxJp7m2ZaoECQZl68Xm668NQPwty+Nb3mrxBLIR5PmWk5dKhbCwTxL8McM9h/YT1D2WxR3dwTNkPmGgrerQ35IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766051652; c=relaxed/simple;
	bh=Y1zYvtM1CJh3dRA3GwjlMQkT2SDcc9ItRFo4Rht4O3Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Nx5f7QCwEzfMHnkxBDzqARALVzl8KrrEcyhXlh/juw2lfWvygdtacBbXhP5HHB+wsltjhfa5miSTwYuHNb51nW/74YmMedCnjYJTkVFvdSkEWQl3r9yc+Yxw9nifTMDZz0100IDCGJsyFk85/ACU3Q3muc+rChAqb9oJRu3Nd0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5BI9rBEo092692;
	Thu, 18 Dec 2025 18:53:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5BI9rBEt092688
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 18 Dec 2025 18:53:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b4457da3-be2e-4de3-ae16-5580e1fb625c@I-love.SAKURA.ne.jp>
Date: Thu, 18 Dec 2025 18:53:08 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/core: flush gid_cache_wq WQ from disable_device()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Majd Dibbiny <majd@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, Yuval Shaia <yshaia@marvell.com>,
        Bernard Metzler <bernard.metzler@linux.dev>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
References: <30ec01df-6c32-490c-aa26-c41653f5a257@I-love.SAKURA.ne.jp>
 <8f90fba8-60b9-46e2-8990-45311c7b1540@I-love.SAKURA.ne.jp>
 <1722eff3-14c1-408b-999b-1be3e8fbfe5a@I-love.SAKURA.ne.jp>
 <9b4ce0df-1fbf-4052-9eb9-1f3d6ad6a685@I-love.SAKURA.ne.jp>
 <13f54775-7a36-48f2-b9cd-62ab9f15a82b@I-love.SAKURA.ne.jp>
 <ace1ebe4-4fdb-49f4-a3fa-bbf11e1b40ed@I-love.SAKURA.ne.jp>
 <20251216140512.GC6079@nvidia.com>
 <10caea5b-9ad1-44ce-9eaf-a0f4023f2017@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <10caea5b-9ad1-44ce-9eaf-a0f4023f2017@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav303.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/12/16 23:38, Tetsuo Handa wrote:
> I haven't confirmed that netdevice_event_work_handler() is called for
> releasing GID entry.
> But I'd like to try this patch in linux-next tree via my tree for testing.

I tried this patch in linux-next, but unfortunately this patch did not help.
I guess that we need to _explicitly_ invoke operations for deleting GIDs
rather than counting on WQ context.

Can somebody contact Matan Barak (the author of "IB/core: Add RoCE GID table
management" commit) for how default GID is supposed to be deleted, for
mellanox.com address is no longer reachable? 


