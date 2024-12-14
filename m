Return-Path: <linux-rdma+bounces-6519-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899C19F1C16
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Dec 2024 03:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2D716350E
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Dec 2024 02:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6588814293;
	Sat, 14 Dec 2024 02:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NHQ7zNw2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFFB11712
	for <linux-rdma@vger.kernel.org>; Sat, 14 Dec 2024 02:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734143188; cv=none; b=j2DVCXTa8OoAe5T8zYz7+bfdh89dmvXD82ErX8igj3YRxzQytrkkHYXe+6TFzDSDRa0ONJVfbTKQSNXAPekt9Eh2FZfsk6sFlUw0OUoR1zb+z+tfo1+5MXGCJmr/Z4W3kEOcmVPdmfCjHpgnpdEHwf7EhGyAgItn8lUY7IlumZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734143188; c=relaxed/simple;
	bh=zDrbAexkaBrncrJt9BGxBTXbHhjpXhvqISbI1B4xAkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUb6FN+rAEVNbKbdV5yK5pzsHibP5G1F7LO90wvuD8uJ5q3MG+23orFkF+vSLqWHPVlp/geiUBYId1tNEiEskpWB9plfY/+UYWA8nUUOH8Rly9INMoyq0XaP5a/vOw2lKfs5XtPQ1eKDTjRh9mHJH/erHXiOsdj2seMS11YvE/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NHQ7zNw2; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=/OcfktP/vzoA37xkZA5zyJB6tG8UGPc/4htwqiYqx3Y=;
	b=NHQ7zNw2P3d/JOnEvJ1u8rZ+q8m47kLlVyX6Zb1FF8X6YLydbqSixVJhSTlIY9
	9mTozuN4yQNRuzJm5l4itAe0ux4llJFFg8zxXrHoVZ5Nx5xvSwVo5EqHqfWMxhX2
	F59uDZK9p33iWhfiz4IzBkQmZhiCp4Y/8c8OJw1oC/exw=
Received: from localhost (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC35PDC7FxnqUWVAg--.55774S2;
	Sat, 14 Dec 2024 10:26:11 +0800 (CST)
Date: Sat, 14 Dec 2024 10:26:10 +0800
From: Honggang LI <honggangli@163.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org
Subject: Re: workqueue: WQ_MEM_RECLAIM nvmet-wq:nvmet_rdma_release_queue_work
 [nvmet_rdma] is flushing !WQ_MEM_RECLAIM irdma-cleanup-wq:irdma_flush_worker
 [irdma]
Message-ID: <Z1zswha52zdJcEXp@fc39>
References: <Z1wBEgluXUDrDJmN@fc39>
 <d6067519-26ab-4851-ba58-3ebe254e88d1@linux.dev>
 <0d0ee443-a903-406e-9bec-b02b1391b7d0@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d0ee443-a903-406e-9bec-b02b1391b7d0@linux.dev>
X-CM-TRANSID:PSgvCgC35PDC7FxnqUWVAg--.55774S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFy8CrWUWF13urWUKF1kGrg_yoWDGFb_uF
	yqvr9xWw1DuFnFvr4ktr13uFy5Ka1UZw1fury3K343AasIqwn5Zw4kGFWfW34UJay0yFsr
	Jr15Jr4xKrsagjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRCwZ2PUUUUU==
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/1tbiDwi1RWdc6q8xAgAAs6

On Fri, Dec 13, 2024 at 08:30:01PM +0100, Zhu Yanjun wrote:
> I delved into this problem. It seems that it is a known problem.
> Can you apply the following to make tests again?
> 
> diff --git a/drivers/infiniband/hw/irdma/hw.c
> b/drivers/infiniband/hw/irdma/hw.c
> index ad50b77282f8..31501ff9f282 100644
> --- a/drivers/infiniband/hw/irdma/hw.c
> +++ b/drivers/infiniband/hw/irdma/hw.c
> @@ -1872,7 +1872,7 @@ int irdma_rt_init_hw(struct irdma_device *iwdev,
>                  * free cq bufs
>                  */
>                 iwdev->cleanup_wq = alloc_workqueue("irdma-cleanup-wq",
> -                                       WQ_UNBOUND, WQ_UNBOUND_MAX_ACTIVE);
> +                                       WQ_UNBOUND|WQ_MEM_RECLAIM,

After add flag WQ_MEM_RECLAIM, the warning message is gone. However,
it may raise similar issue fixed by commit 2cc7d150550 again.

thanks

commit 2cc7d150550cc981aceedf008f5459193282425c
Author: Sindhu Devale <sindhu.devale@intel.com>
Date:   Tue Apr 23 11:27:17 2024 -0700

    i40e: Do not use WQ_MEM_RECLAIM flag for workqueue


