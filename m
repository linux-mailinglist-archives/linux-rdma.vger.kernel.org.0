Return-Path: <linux-rdma+bounces-7833-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C69AA3BDE0
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 13:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9654A167116
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 12:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788BC1DFE3D;
	Wed, 19 Feb 2025 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCVSwWev"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360351DF977
	for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2025 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739967300; cv=none; b=Az93Zke5Yhw2s+SyK1tVUb6A+t7CxJje7iqsi/YTvpf0mIlqv7uSEqKlymGQlDSFO/Bt4t8weQebJxL3f/wI7Nmu/6eIEEJcKnhu0uIF1L/yx8Zu66stC8JtnzG6TrnfLaDk7jLI8T2NqgjeB2lFFS0CWk2p4LG8mUiSNT6yKqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739967300; c=relaxed/simple;
	bh=gLvevtPz0Gq/rkOok2GViu4KSjbkGEvyzMhexk51XLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uG8rq2b8FtoncM8vZO5YxPIKcmpr0OtJFPotrpOvJk2812Nxf6oFOnJrMjwubURmHqYWVlFBqnXzbIPTuW3T19z5kv40RKOjSPaJ9kgNk78Um1P68CT30Lk8bqEu6X92uiasbhHJqu+zBebWCoT+F/ANqIPBUfwxthYFzVYBclA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCVSwWev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E4FC4CED1;
	Wed, 19 Feb 2025 12:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739967299;
	bh=gLvevtPz0Gq/rkOok2GViu4KSjbkGEvyzMhexk51XLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fCVSwWev9v0iHaRTL8+TuN6lhEufBjLOg2LUsni2Kg2aaJxx2KFGkc31TXBlQM6nj
	 6ANyE+VThF835bzHeZuN8uZ7vVJksFPH9EbNKmoP1OqW3CTMukUQL/kwu7yhonGnY3
	 0HZxasvZNRMoAk8cHMb9BopXQiH5/3rrGgIzfA1ubCepNJ1yghFn3M5EUz9NXQTtrh
	 DEeckskULY/7sfsVPxgbSYlY+GDQUjXiLprEUq1FVf7KR0X+e5VWmnwnqZ79El/Ssm
	 zpFgx4XZ9RmsJfvu0uQoRfgoLflD03rJjVIOtUBxwqawx5aQiCnQmVXCfkmapTlXyP
	 5tzxl/we6px7A==
Date: Wed, 19 Feb 2025 14:14:54 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	tangchengchang@huawei.com
Subject: Re: [PATCH for-next 0/4] RDMA/hns: Introduce delay-destruction
 mechanism
Message-ID: <20250219121454.GE53094@unreal>
References: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>

On Mon, Feb 17, 2025 at 03:01:19PM +0800, Junxian Huang wrote:
> When mailboxes for resource(QP/CQ/SRQ) destruction fail, it's unable
> to notify HW about the destruction. In this case, driver will still
> free the resources, while HW may still access them, thus leading to
> a UAF.

> This series introduces delay-destruction mechanism to fix such HW UAF,
> including thw HW CTX and doorbells.

And why can't you fix FW instead?

Thanks

