Return-Path: <linux-rdma+bounces-745-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5385C83BE51
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 11:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864511C23400
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 10:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146891CA84;
	Thu, 25 Jan 2024 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4Djh/a+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2261CA80
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jan 2024 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177263; cv=none; b=CsTI+gcTiGyZLS1i4OUyTvbXVD7vt/c8PNYnX1lv2ws6Q9Pq+2XocI0DIA/qwwFQL+nVsBnA3N/VyvebBxgfq4v7JvSWd5f00setWPda99CRdBL8ByIngJPHWP2avrF+fkX+bORHcB8iTuJAFV3f4MyHhRgwYaPuaMbdL3Udi6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177263; c=relaxed/simple;
	bh=qYgbgWElK6JeVyuJ6gXI+HhouLShYSuZK4KbFqaEuXo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Pn6ZJXCPJQq2yz1TIFFQ0NOYAg8UzueXuL51NFluCXYmeNB84QQcQ6t+PV1E+QhEnt6Feb4bUjTirHNIhYLNDSOMuvzg7n5Oq4nJkcr5Q1o5mYmuJraO4vESFIN7wdTxEFCCS4hORuHREeCAim6/iWPOJNYyoN3d43/tFivVwv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4Djh/a+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C1FC433C7;
	Thu, 25 Jan 2024 10:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706177263;
	bh=qYgbgWElK6JeVyuJ6gXI+HhouLShYSuZK4KbFqaEuXo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Z4Djh/a+hMt8RNVio9UmPphk4fXj2Uf4Yl3fnSGJReEe6hXgNCBUuzEKrkET/vQkk
	 qGYoaOOXffi+enLwDdSBucaf3goKvHUy0+YU12AkmH7s+A4cdVlaqtn6B33SDmHRGN
	 +vrzKNJaReV2nee25NSuvFSQ6KDF+QNrrHxnmlQWqnYadUlfQo3A2PyZudm7xYBiMK
	 ZXtiF6D90d8DKKdBAxbsQeHLBq9z3+D/ZznaNy01YXtlz1hJYiMft3v9FhAR6Qw+hl
	 k15dOJ+ExCsvoJW3VE3exuE/yLgHYPlL061NC3N0fQbD1sXZBoe9cGQbiVUufaGvyg
	 V2fVAE8VBn2pw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-rdma@vger.kernel.org
In-Reply-To: <a2cb861e-d11e-4567-8a73-73763d1dc199@p183>
References: <a2cb861e-d11e-4567-8a73-73763d1dc199@p183>
Subject: Re: [PATCH] mlx5: delete unused prototype
Message-Id: <170617725917.635461.11919457989334877619.b4-ty@kernel.org>
Date: Thu, 25 Jan 2024 12:07:39 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Tue, 23 Jan 2024 13:35:38 +0300, Alexey Dobriyan wrote:
> mlx5_ib_copy_pas() doesn't exist anymore (and g++ doesn't like it
> because "new" is reserved keyword in C++).
> 
> 

Applied, thanks!

[1/1] mlx5: delete unused prototype
      https://git.kernel.org/rdma/rdma/c/a400073ce3dd3d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

