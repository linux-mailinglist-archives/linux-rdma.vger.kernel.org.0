Return-Path: <linux-rdma+bounces-13086-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E812DB43DD6
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 15:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A303A975F
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 13:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF403009C7;
	Thu,  4 Sep 2025 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raofDJx4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3400272E41;
	Thu,  4 Sep 2025 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756994104; cv=none; b=f6F+m+gli/fzRamu1p1Q5O/VSLoFtHMJFVw0y2NtuJ/ZE47W07syaU3DInFBztLY7tIxnfaK8Yi134RR1kqblNGZVfGXj59UYbKFwNUOa9PnrqLz7iFgn6u5M8D9EOx29KITvVPOzKw9Ar+t8Mvyk+UDxD9GTte5nJDH7Saq13I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756994104; c=relaxed/simple;
	bh=+QvdVKuZ1UJIh5p0AukHsOB3iUeVn7vH8QoZZ97knls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHNzPfRnPtrZn6YVwbPli2KCjiHVdFlzlP1AKKDKgY9cTj/RLhj2BPAmkw3Qu5tSDkTpuRYbWdWr+ZVdmtPNtVCr1eAgOd36lmAEFholsGyY1DkF3OM515od8G25KNJ2axIvBtDu1zfgkiI1Uo+P/DctBpNo+xz/XxtKyVML8jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raofDJx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7F6C4CEF0;
	Thu,  4 Sep 2025 13:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756994103;
	bh=+QvdVKuZ1UJIh5p0AukHsOB3iUeVn7vH8QoZZ97knls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=raofDJx4j85kocdr8x8xo7cdSMGKUcq0nUF7szy/ZwhB9uu5CCl4ILhq77HakJ8+W
	 bh2I3rHkxfZ/pS16OVfF2zTXGSs1c61+9neDFdQHFFC4IxplYJ4jN3JgYU5pBnpGDT
	 tzN+CsxDaMNSNu4moFpRfNXqMcnVt273Eiv5Jq7gzkqxS5N8oDASEVc8pqvhhN1S9a
	 nsLSzXRZKtORUOcIJW+tY3gVoBjFPRVEPqacTqEwrkfm/+1/hU2G9KApWxUE1smMT+
	 VVGWYuFNxxs1AT30PDbzWgFZx1z49q6fvDgYhDqHUbQdjE6799yoEPELdBhjDbtpcL
	 m/xMVr1vr6PDg==
Date: Thu, 4 Sep 2025 06:55:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc: Allison Henderson <allison.henderson@oracle.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Santosh Shilimkar
 <ssantosh@kernel.org>, stable@vger.kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] rds: ib: Remove unused extern definition
Message-ID: <20250904065502.13d94569@kernel.org>
In-Reply-To: <20250904115345.3940851-1-haakon.bugge@oracle.com>
References: <20250904115345.3940851-1-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  4 Sep 2025 13:53:43 +0200 H=C3=A5kon Bugge wrote:
> Fixes: 2cb2912d6563 ("RDS: IB: add Fastreg MR (FRMR) detection support")
> Cc: stable@vger.kernel.org

Fixes: and cc: stable is for bug fixes which we care about so deeply we
want them backported ASAP. Why do you think removing an unused
declaration qualifies as such :\
--=20
pw-bot: cr

