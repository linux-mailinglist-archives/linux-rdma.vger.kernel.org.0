Return-Path: <linux-rdma+bounces-2824-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C07BB8FB142
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 13:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 779911F23702
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 11:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FF514535F;
	Tue,  4 Jun 2024 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrE22qBx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DC038B;
	Tue,  4 Jun 2024 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717501255; cv=none; b=UO8rMU79JhbA7x0P69XZkRFJx0UMTsU8S+RkSrQpreFvlnrKO9QHJnyKRmLB2VZYPxdyYYWxSh+U6QWzSLkZ6s3/GT/5OeLOvSIKfPIxPcFPZRbHIz5xFUiq7KgRIt4xaUjtxWkYAFB79u/5pvsE7hVh/j93WZ8Zvmg2Co3tYRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717501255; c=relaxed/simple;
	bh=4feFP4oIu4D0szM5Et4kmx5W4FXmncMvQ+moy1FK/do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZ8CKz/MOfT46ccT2i5IIHmnQeCaszP3bTtwr7YWdPMSNftD/O0oUQNdKs/0fUFCegh61g8QTc96aWxKlM4yUhNa3o68F5YqIK3sonCKcwARMMCaZU7iRYOlDTNjT2m2nxeS5DIflBOAkZRlBKu5mlvzjXvxnFEEuIG8l92YXRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrE22qBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AF2C2BBFC;
	Tue,  4 Jun 2024 11:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717501254;
	bh=4feFP4oIu4D0szM5Et4kmx5W4FXmncMvQ+moy1FK/do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LrE22qBxO8w9YWROIuXdVpgciovQlvL13X0chPr4M1KZtES74opeqPTDv4ZDvEJLM
	 jj6BSt96TJHhCVGvc+kyFVC+i3VaoG5TdCwijI9FGAsBUHLeFy1//97V+xKjsQbK8o
	 BkS4Cul44PedPQi9yQRCP3s8HP04z2+NgUm4q76+Z7hL+BSDtKE1ZeT/nsjQG/v09m
	 uKzLWuqfz4x8Z97bxUW3RCyDswJySTI7auLk/jS5HJuR+8JmjbctAWT1GA6P8JAhgZ
	 BTj+1a+6tgdNu6avCLFxrE/1rSn+zreDq0IK5fofH+d3le0nZpwdckrG9BRZxKyNJx
	 Ghb+HGjtS6Pfg==
Date: Tue, 4 Jun 2024 14:40:50 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Zqiang <qiang.zhang1211@gmail.com>, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH -rc] workqueue: Reimplement UAF fix to avoid lockdep
 worning
Message-ID: <20240604114050.GP3884@unreal>
References: <4c4f1fb769a609a61010cb6d884ab2841ef716d3.1716885172.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c4f1fb769a609a61010cb6d884ab2841ef716d3.1716885172.git.leon@kernel.org>

On Tue, May 28, 2024 at 11:39:58AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The commit 643445531829 ("workqueue: Fix UAF report by KASAN in
> pwq_release_workfn()") causes to the following lockdep warning.

<...>

> As a solution, let's rewrite the commit mentioned in Fixes line to
> properly unwind error without need to flash anything.

Tejun,

If you decide to take this patch, can you please fix typo in the commit message? "flash" -> "flush"

Thanks

