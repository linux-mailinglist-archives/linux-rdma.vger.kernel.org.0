Return-Path: <linux-rdma+bounces-1736-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0BE8952FD
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 14:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12A31F25FE3
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 12:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DECD22067;
	Tue,  2 Apr 2024 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEEG/pg+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10A14A0F
	for <linux-rdma@vger.kernel.org>; Tue,  2 Apr 2024 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061071; cv=none; b=qgEHcG8aoXSJ7YN9/4ZRFyofFxv/QfmMGsXjdB4djPWEMgT9Y7Cn1kUp5dalmJBmKaigIxVX4AUh1KuBbccwFw5vEfD2tDbiBIbttgjofRjoG/dgFcF/Pb5IewwPaKMZcvd3L2Y+8T0gQ3UtivTJTfIcJrZab5rHifmV0GQdPoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061071; c=relaxed/simple;
	bh=PGc+7PctDCHYR7EGtPtKmpx7obJWl6g+GHXhm2/uTCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5AXj+M2kOFb6Gj0PMFjrI/0XZ/MXxLMQo/4uvAdlk5mKKRNl9c8ExWIRPYEzSbN85oXHlT1YzZc/OREs2Sek7/Z4/3WWba7x0rYPumL2viAJhdnOBA8tdlmd/Vd2d3mHBASUKJTNk6umMUQBdANzZt0z9k8Xu4/9sqIUQdtdwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEEG/pg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59391C433C7;
	Tue,  2 Apr 2024 12:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712061071;
	bh=PGc+7PctDCHYR7EGtPtKmpx7obJWl6g+GHXhm2/uTCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uEEG/pg+7lQFau44E0DRSROdVFrqMS2B7eu2wHuEV7/ASnDUnwvyRUi8z31TqGDS1
	 ldkNm619xwfkG5W7pqWLXt/bs4TpvXKeaQKMBnCJ7cL0GQ1CCQ9Fy+W0OA2JflD/x4
	 9TfcRPjnfRCwjlbOGWawWvJsoga5oaDtiBUIrAxY1HmHqqBRXta2jgi+l1UbdQ+aJk
	 aZeXbW8Ic60O+4CUkfROeGKSE/PT8peeNrNea7Z26WIRySIIbt9PQ1izao4Am+qwI2
	 zsOaso5P+xv4j04fh9pSzLSj58uO/pzWLZcWyPYL8wVTqsxjGhhfBwJZKcQNhGkSgs
	 vl/RynB2tLShw==
Date: Tue, 2 Apr 2024 15:31:06 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Bob Pearson <rpearsonhpe@gmail.com>
Cc: yanjun.zhu@linux.dev, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	jhack@hpe.com
Subject: Re: [PATCH for-next 01/11] RDMA/rxe: Fix seg fault in
 rxe_comp_queue_pkt
Message-ID: <20240402123106.GI11187@unreal>
References: <20240326174325.300849-2-rpearsonhpe@gmail.com>
 <20240326174325.300849-3-rpearsonhpe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326174325.300849-3-rpearsonhpe@gmail.com>

On Tue, Mar 26, 2024 at 12:43:16PM -0500, Bob Pearson wrote:
> In rxe_comp_queue_pkt() an incoming response packet skb is enqueued
> to the resp_pkts queue and then a decision is made whether to run the
> completer task inline or schedule it. Finally the skb is dereferenced
> to bump a 'hw' performance counter. This is wrong because if the
> completer task is already running in a separate thread it may have
> already processed the skb and freed it which can cause a seg fault.
> This has been observed infrequently in testing at high scale.
> 
> This patch fixes this by changing the order of enqueuing the packet
> until after the counter is accessed.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> Fixes: 0b1e5b99a48b ("IB/rxe: Add port protocol stats")

Signed-off-by needs to be after Fixes lines
It is applicable to all patches in this series.

Thanks

