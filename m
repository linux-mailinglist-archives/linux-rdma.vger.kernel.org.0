Return-Path: <linux-rdma+bounces-13068-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D63FB4270B
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 18:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B832468406E
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 16:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749F6302761;
	Wed,  3 Sep 2025 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XLM1yyr4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95D72BCF6A;
	Wed,  3 Sep 2025 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756917487; cv=none; b=DUklgh9FMN4078iRsjJmecCdJB67cizOEffu1sNmvqI+qOYtqLv3iLFeLgQQam1EOnofTgUmoN7ZJsmHecQXDb0/ZD3Ww9uNvNdtGN5GJyKp9+5GgSl+WcqRb4kSi4d5H4xyp4lmT6gmtuZUncLwU2X2kP50Cm7N+Eiff42BhsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756917487; c=relaxed/simple;
	bh=Yquc3KVHRLklhexhuLuC/+JucDeDU9QiXHPxulI9nfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAuZQPwM5/z1zX8topNNvEcOHw2og1CWr46dHjYVrLa5I+VUOj/k55ajwveMGwdFVD43LaTzBLZRjRTQgMCPYYiZjkKoyb/HT+zPKQ6eP92AcBH+D8ODe7ZZaEzkPp9o7bY1/nbKDvNr3I+Rlxy7vQdp/BPTNRwXTSrURs7O67M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XLM1yyr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAA9C4CEE7;
	Wed,  3 Sep 2025 16:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756917486;
	bh=Yquc3KVHRLklhexhuLuC/+JucDeDU9QiXHPxulI9nfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XLM1yyr4A6S086tC52nRdRcU9pFN659GrXfAHVKVmEbcFNJCRio/gGbt+tCTLLYFV
	 IKgfsvGh6kAu221D3jiXh84RynBK7EhGB8C6PVYm/LpcT61firLmkJh/pOGqGIsdCM
	 86hRHA8eKnynLpc6uB6aKke7u/aMHh+8SSBc0vLI=
Date: Wed, 3 Sep 2025 18:38:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc: Allison Henderson <allison.henderson@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] rds: ib: Remove unused extern definition
Message-ID: <2025090340-rejoicing-kleenex-c29d@gregkh>
References: <20250903163140.3864215-1-haakon.bugge@oracle.com>
 <20250903163140.3864215-2-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903163140.3864215-2-haakon.bugge@oracle.com>

On Wed, Sep 03, 2025 at 06:31:37PM +0200, Håkon Bugge wrote:
> Fixes: 2cb2912d6563 ("RDS: IB: add Fastreg MR (FRMR) detection support")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
>  net/rds/ib_mr.h | 1 -
>  1 file changed, 1 deletion(-)

I know I can't take patches without any changelog text, but maybe other
maintainer are more lax :)

good luck!

greg k-h

