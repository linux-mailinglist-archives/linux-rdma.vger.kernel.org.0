Return-Path: <linux-rdma+bounces-14205-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3A9C2C498
	for <lists+linux-rdma@lfdr.de>; Mon, 03 Nov 2025 14:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D96284EBEEF
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Nov 2025 13:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A030830C610;
	Mon,  3 Nov 2025 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bk2AUTtt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56086291C19;
	Mon,  3 Nov 2025 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178270; cv=none; b=FvEXQg0ki8EUq9DJWtnJVnSYjURF9/B6k8Hp8q6nCKfjzKphrnj/INi6Fsh5K0xNWjPF4Rr+ioIEsLMJ2kZ+I1SuEvwGVjeu5Wao7Ok7kdSVmyPj9GyldWocj3HU+tUcpd4nt6NOC/lGvGAZ2cDmUupcjAs7nK8Wl9SmDLPZY5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178270; c=relaxed/simple;
	bh=z9++M6BLS3/GwKMvunjND69BcrrUGZt+U2207QrSN64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGBMSZP+0UNCjG/phItEBSS4a+Sh4jfQfQZpfVdV2SS1u+YnS10v6VqTylUKkoYZ+8yVKeeCm77JxAA9SggSqVYITbqgO3vnl8q76Er8xtrLP61Fs+zycChJYYzDfHj2YoH5BF0NQDecALtg42XNeSfc+DoNoMgEiN7dE8n/9VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bk2AUTtt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376B2C4CEE7;
	Mon,  3 Nov 2025 13:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762178269;
	bh=z9++M6BLS3/GwKMvunjND69BcrrUGZt+U2207QrSN64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bk2AUTttePeboe9F2ygXVNEAkhOOtMvH1UgTnCby0MW/wk6eMXlAw4T8xP2xG+z7k
	 /FutuG/eQZqmFR1qzsYAKFZc0We44vwpCsl747hod0yKY19WwqlccHI2RFnvxgbcS2
	 +Ej2KfyVv495yvMEqS+oqDUZh5cr/pUUXe4biHvUeFiLHChG7N/NCdHWwHyi6lizXS
	 I+awYKNhWudYOKYlOSr11g1qv9NOW7N2Yy61DGaRHrOfFnhg/bSdBP7Zsc0t12yJvN
	 fCzRGb91RKWK6LIhaK6UI/Bgn89jjchkrXEamAvv+h6TangKx+a5/nONvasOkCnR6M
	 X5ls7ERDvKo9g==
Date: Mon, 3 Nov 2025 13:57:45 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next V2 3/7] net/mlx5e: Allow setting self loopback
 prevention bits on TIR init
Message-ID: <aQi02bAiInz9nXzz@horms.kernel.org>
References: <1761831159-1013140-1-git-send-email-tariqt@nvidia.com>
 <1761831159-1013140-4-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1761831159-1013140-4-git-send-email-tariqt@nvidia.com>

On Thu, Oct 30, 2025 at 03:32:35PM +0200, Tariq Toukan wrote:
> Until now, IPoIB was creating TIRs without setting self loopback
> prevention, then modifying them in activation stage.
> 
> This is a preparation patch, that will be used by IPoIB to init TIRs
> properly without the need for following calls of modify_tir.
> 
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


