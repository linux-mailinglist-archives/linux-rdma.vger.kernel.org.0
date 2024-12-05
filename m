Return-Path: <linux-rdma+bounces-6267-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AD39E50D5
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 10:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 983C728B008
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 09:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D031D5AB9;
	Thu,  5 Dec 2024 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Auwk/ybH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9157817B506
	for <linux-rdma@vger.kernel.org>; Thu,  5 Dec 2024 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389693; cv=none; b=jOHGFvoPr0xL59E05Tqtj+g64Np9CdNn0EkUiJctBofWbMQSGVqQUS6dtA519S+21a2jbtjtS5JKJbRqS9K2V4qK/bRYybLEclF6YPbAxb9g7agH5QHqn+zqcMkmxpds7qGIVSXCoXuXjsgQxy8FS60bhONZZgUYstAyVXvLwVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389693; c=relaxed/simple;
	bh=4JyyYxXZqKEDsBKrffYEbSyg3eedjC7vPzTF9rjGOEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMz+evfDpDb46X9eewhOcey4SAP/kfeQvc4ckkfQynJNMmtk4BCD8JH/+gr2wNUpCYWtluacFLDryDzO0dajvkFQiyaPz2ZbJlbcQm6byPEsNXIa3MuXYi+3kzoi4IyaqOcFdGSxB2i0OJQDVotjDLLbFwHmN7M4NYMOqMvwmjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Auwk/ybH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9949AC4CED1;
	Thu,  5 Dec 2024 09:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733389693;
	bh=4JyyYxXZqKEDsBKrffYEbSyg3eedjC7vPzTF9rjGOEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Auwk/ybH0I39wCJcLkbfdVghfMPeajT2bZelTlknUAdKEwRiSdi2AQf+FqYao5D02
	 k91/8MpUgB+q3fdg7bMZFtzwK2kCr7StBHFt7y3y/d+KZ7H67v2n9Ozzcy+2jOV5Sz
	 YBOJC7Gi66pOzSVah0MI/DLEXU0NWjPYLs422jEzFFib4LN6Uf8aW4HBvI9yIObj5R
	 Q1/PbDWKojugwKIRQZDy3onpgjgLFes1zhmhfEaPODk49n0fi/+wT++wR9otsGCxUd
	 w4hwpYFwesg3hiYEqZEyVUExbW4OPkC6c/Xy/CRqVmHbe5Xq4d46nm9D+jLlCOCr8r
	 VP9mttcqjjy7g==
Date: Thu, 5 Dec 2024 11:08:08 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH for-rc 0/5] RDMA/bnxt_re: Bug fixes
Message-ID: <20241205090808.GV1245331@unreal>
References: <20241204075416.478431-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204075416.478431-1-kalesh-anakkur.purayil@broadcom.com>

On Wed, Dec 04, 2024 at 01:24:11PM +0530, Kalesh AP wrote:
> This series contains some bug fixes for bnxt_re driver.
> Please review and apply.
> 
> Thanks,
> Kalesh AP
> 
> Kalesh AP (2):
>   RDMA/bnxt_re: Fix error recovery sequence

Applied all patches except the patch above.

Thanks

>   RDMA/bnxt_re: Fix bnxt_re_destroy_qp()
> 
> Kashyap Desai (2):
>   RDMA/bnxt_re: Fix max SGEs for the Work Request
>   RDMA/bnxt_re: Avoid sending the modify QP workaround for latest
>     adapters
> 
> Selvin Xavier (1):
>   RDMA/bnxt_re: Avoid initializing the software queue for user queues
> 
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c   | 21 +++++------
>  drivers/infiniband/hw/bnxt_re/main.c       |  8 +----
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 42 ++++++++++++----------
>  drivers/infiniband/hw/bnxt_re/qplib_fp.h   |  3 +-
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  7 ++--
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  3 ++
>  6 files changed, 41 insertions(+), 43 deletions(-)
> 
> -- 
> 2.31.1
> 

