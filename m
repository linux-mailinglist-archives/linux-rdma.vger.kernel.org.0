Return-Path: <linux-rdma+bounces-19040-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIahFDzL02nomAcAu9opvQ
	(envelope-from <linux-rdma+bounces-19040-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 17:03:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7E33A47EE
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 17:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88FAE3012EA6
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2026 15:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387EE386424;
	Mon,  6 Apr 2026 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xii0MaFj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC00C2DF717;
	Mon,  6 Apr 2026 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775487775; cv=none; b=mJuArrntPDj8o2QtSXVMxZQ7JYXEpZt2CYbykz6yzW8rkZUI9e0t9Opj5PA5qnCNj51nlW01CiVSp1f+rjxQXl1JMbELlX7t5d1qOBcGfQdR1IzNI/y/NAtxD65lv/wEHG1jLfGyItygGKujJ/9VMnyLqa/ujOO4preRzsSXnJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775487775; c=relaxed/simple;
	bh=/zWTTEwu/4ZvHrECK/ZptCOk4mvqjq4tGCDOOrZFik4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/Ion+OGkY33iVkJwYIzP6phmHVWpvhN78YyUftBZklbBJVPSKPIF8xJA+Pf6laZNjsignHfplOlptHbPImVJtgzZOT9pCrg5PZbwqTXveUeEovJ4MD7+phfUoSUW8pHIBkCpAhO8thvMvXEwi48VjJ6DE2FKQuAt5KZWExaojU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xii0MaFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76DFC4CEF7;
	Mon,  6 Apr 2026 15:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775487774;
	bh=/zWTTEwu/4ZvHrECK/ZptCOk4mvqjq4tGCDOOrZFik4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xii0MaFjExvsIQcUvAeczdhUiDvrdopDAvaRxpwdpJZni2L1gqeh/hgnwstwshDRq
	 jxT+YEcaWwqAf15XkxeVfCUWMS7tuIiC7qonC73r1Nmr6mWduiZPur8hJm14TEb++w
	 b6iBvxj84KbE3mgkdVdGyvokgk7rVno5kNkaC5fsCDBFQqsUhk3Jv0HkhXsJchPZw3
	 aQ8iMdh9ZQ9bwJHbRapwIS+Jdg6eNs41pEwlDePE2qYZbcZCJRGmkGwnJR9AwAR9Gm
	 SvbdckSWuL57eqWQaMeKY4/6lmsWd4+4RQfrTsb26UU/T8BlT/UyKEZ7D4oHic0eHl
	 R1ORlDu1Jbs6A==
Date: Mon, 6 Apr 2026 16:02:49 +0100
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
	Michael Guralnik <michaelgur@nvidia.com>, stable@vger.kernel.org,
	Patrisious Haddad <phaddad@nvidia.com>
Subject: Re: [PATCH net-next] net/mlx5: Update the list of the PCI supported
 devices
Message-ID: <20260406150249.GA410024@kernel.org>
References: <20260403091756.139583-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403091756.139583-1-tariqt@nvidia.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19040-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB7E33A47EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 12:17:56PM +0300, Tariq Toukan wrote:
> From: Michael Guralnik <michaelgur@nvidia.com>
> 
> Add the upcoming ConnectX-10 NVLink-C2C device ID to the table of
> supported PCI device IDs.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
> Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


