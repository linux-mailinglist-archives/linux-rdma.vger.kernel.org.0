Return-Path: <linux-rdma+bounces-9499-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB69A9117C
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 04:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291491906ED0
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 02:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864FD1D5142;
	Thu, 17 Apr 2025 02:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFMPt/kB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3051BBBD4;
	Thu, 17 Apr 2025 02:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744855763; cv=none; b=ADsXJxq3T1dZJncYV885TgQ8Zo/f6/myI0OvK+IqbQNSsMBsh/ff3uFvFOti5w1Mn67ii2n1n+9aOvMqjXTl7/kWO2zvN5HrxllhxYtuQ7flUBsLBiPcX1PYxCxPl/oTi8c1fFRhVWU+6owE/wWOCxHmt0xs5sfPu3LmRdpa1pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744855763; c=relaxed/simple;
	bh=v0j0T5Wcrf9Gx1tBLBUdRLrzr+SLUjSSw73EKC3/EJY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSgjICu9XygWRSFQEOH0MJEzNsJBVIRdHKBcLah4p3qCS9eMRM/RQ+83PXZSs/TePTM9RLZNC5rEbCXF4fGVZQc9NpG+VGh5IFljhIzlrYiTSwyWWm6utWab9cBjbBxM5HxQhdCXKyAo6PFZ5KusnnsBI+OJlfdYdbIvKlhnGXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFMPt/kB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B754C4CEEA;
	Thu, 17 Apr 2025 02:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744855762;
	bh=v0j0T5Wcrf9Gx1tBLBUdRLrzr+SLUjSSw73EKC3/EJY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kFMPt/kBIQJMKPoOpqZkInVTpPszcv+egMTMGs//lSDmewfmqo1f4KkVetZr4Jkaq
	 6rtyMk2jWpRtyh3JIE97kg/7nb+KkAJRsspcGZ3CWSnWp45KMs8ins8/u0ZSITh2Tr
	 mFI7mSaKiGN9t6fAKYHPdYrCW3Hhd4c5dYzBuV2ONSGRjHfw5a0ESVsfOd91N3Khtj
	 Kev3hHqm4cOOR4HAdotIndOEjJYjVHcZOwiZ7GOpoSm84BDm7s5LYoXQoItdzGizmf
	 89qDIVSnsCXFKa7HTwOHS+GYKcNoDGtuNtHmUqWvOMZr+hYoUM0ZvQWGhBVaifTCp/
	 A5AqUVaOg3ewA==
Date: Wed, 16 Apr 2025 19:09:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev,
 jiri@resnulli.us, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, jonathan.lemon@gmail.com, richardcochran@gmail.com,
 aleksandr.loktionov@intel.com, milena.olech@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/4] dpll: use struct dpll_device_info for
 dpll registration
Message-ID: <20250416190921.3cfd6326@kernel.org>
In-Reply-To: <20250415181543.1072342-2-arkadiusz.kubalewski@intel.com>
References: <20250415181543.1072342-1-arkadiusz.kubalewski@intel.com>
	<20250415181543.1072342-2-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 20:15:40 +0200 Arkadiusz Kubalewski wrote:
> @@ -408,14 +408,14 @@ EXPORT_SYMBOL_GPL(dpll_device_register);
>   * Context: Acquires a lock (dpll_lock)
>   */
>  void dpll_device_unregister(struct dpll_device *dpll,
> -			    const struct dpll_device_ops *ops, void *priv)
> +			    const struct dpll_device_info *info, void *priv)

Some kdoc unhappiness here, W=1 build should lead you to it.

