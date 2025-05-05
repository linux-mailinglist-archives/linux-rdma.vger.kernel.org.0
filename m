Return-Path: <linux-rdma+bounces-9972-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 741A1AA97BE
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 17:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54313BC231
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 15:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D549D25FA05;
	Mon,  5 May 2025 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGGK4p4s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938D325F98C
	for <linux-rdma@vger.kernel.org>; Mon,  5 May 2025 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746459897; cv=none; b=ADzAlXOHPfEts1YASX03zLogk7jzs8b1I7P5IGgfHydGV2WAj0q6Xfm5DD3+TWDlAs6kcNu/rBXLKdiqgzyU7iLOmnA77jcF7WJ/Gf2Rf83nIP8GZzFF0E9+sNOt3hR/zuNQ6v6JoxJFo+4bOnBi+XOs+AQAtcfP72nxgF2DRyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746459897; c=relaxed/simple;
	bh=k5ExoXXAHMxZxwwr0a7VbJmjYIP9L8rOJyP2dzx7F80=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LK0DK2L/M+rFVx0PPRM2TUCGPZOouPypYIQOlSr6Y8b7p6sc9nybKnfTmY7FPpJeUEm+aUwcL6Su4kgalUnm/M8cxYavYOZVdum4YWIoc7TD9wi5238UjkscGuP2lTcD/3sGfaAsXnleM5+zLrJh5oKn3m7gTicl+JN+gnsa5KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGGK4p4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71869C4CEEF;
	Mon,  5 May 2025 15:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746459897;
	bh=k5ExoXXAHMxZxwwr0a7VbJmjYIP9L8rOJyP2dzx7F80=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WGGK4p4sTJtYtduNwHjKEco8bbc+m5vrmI8EvT1KzQN/OXPnomRFJeq1f+6wdMEpO
	 vC4JiaV6tfuVEgaF5p+wtUGaR3lE+deOZ52v96ATSEyCK/sIX6023E6YszJHzIq7qM
	 fGJ/z4c31aZhVL2TbNWXjwtfx9+bG3c+x5KkIMHu/BBIbSKNvZ1JwF2If+p9mACr4l
	 kYdl5ruMwpY5inFB2c1nNpOmiuP4RiD1sbDneDmlQKAanpjWVMk0pT2R5NgTK4+ySw
	 SwXuFVjaNKEkSugHSmh3lvclnZtIBp7oQLSFemr6Ey/sz0pMTIaWmWYUhvX8AgGOuC
	 8dlxSMN8O7cgA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Vlad Dumitrescu <vdumitrescu@nvidia.com>, linux-rdma@vger.kernel.org, 
 Or Har-Toov <ohartoov@nvidia.com>, Sean Hefty <shefty@nvidia.com>
In-Reply-To: <0c364c29142f72b7875fdeba51f3c9bd6ca863ee.1745839788.git.leon@kernel.org>
References: <0c364c29142f72b7875fdeba51f3c9bd6ca863ee.1745839788.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] IB/cm: Drop lockdep assert and WARN when
 freeing old msg
Message-Id: <174645989327.411350.5956053873131947731.b4-ty@kernel.org>
Date: Mon, 05 May 2025 11:44:53 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 28 Apr 2025 14:30:18 +0300, Leon Romanovsky wrote:
> The send completion handler can run after cm_id has advanced to another
> message.  The cm_id lock is not needed in this case, but a recent change
> re-used cm_free_priv_msg(), which asserts that the lock is held and
> WARNs if the cm_id's currently outstanding msg is different than the one
> being freed.
> 
> 
> [...]

Applied, thanks!

[1/1] IB/cm: Drop lockdep assert and WARN when freeing old msg
      https://git.kernel.org/rdma/rdma/c/7590649ee7af38

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


