Return-Path: <linux-rdma+bounces-20555-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFmFKTUnBGqDEwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20555-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 09:24:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5474C52E976
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 09:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B2D230041C4
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 07:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921903D5C1E;
	Wed, 13 May 2026 07:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvLNBXfw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5526938B130;
	Wed, 13 May 2026 07:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778656878; cv=none; b=NuWv3xcAynVEZAESL/Aqyfca++fsId3dKa9Ld0kkRRBlNnDRMHJ+XrwP7HNcLsG5urNR8tQwvs0Ff7vsihKlP2swMR647FxkfOCglmQNliWkImBX9id9fTYdWV+mJCyulZC8MpKEutxy4KaEQnStIfK7mTM9tRplHSXmkLClJZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778656878; c=relaxed/simple;
	bh=Ro/6Yan4wzkoz45rJvdI0ZqKjoE6IvDotb3bzyFTqzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzjiLLH5VtUCLfVCKfBU2/KpoNqLHjpkOSptJkjTI9DZPHaC6zqu2zVoHX2ngjtErevYwWfMlZsz7fO7UeUAMxHoZpmCnyE8ch4JCzy5OrJ+e1eb9zTuxlPkxQGNbRhCzlkb/HhOzeySUdYrMqh3ntekuZPBYmgjfqQ1LaaauTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvLNBXfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F63C2BCB7;
	Wed, 13 May 2026 07:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778656878;
	bh=Ro/6Yan4wzkoz45rJvdI0ZqKjoE6IvDotb3bzyFTqzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DvLNBXfwOBhVOqd9Qry9LHxy2y8gmsfFQi7xLcW9o0ZIySpHvWIy/wfP7Z2ycUg0z
	 7DSdewBaKcG/Ex5Z6vqfdBe8xxsX+X/7hc8JJ8Oz3iuXin6jck7787m0TKUW88S/+I
	 NTwAqUo2/qGaZ3k8uZoJouzOxFuil+supCWUzQktV5xhLjopr37zQIwySA+FN+N6Of
	 bJD8qWnDc61CRWIWFLFS+jltOONpI9ak+sL2HlIfBWMoGCJhNN2oRPQ9erRSoujvwC
	 AeJ5lrCh05BEZUXjf/cHO0KyzZCxRoxesv4+MgRoU7whXEryqNis6rDxoa3LxAaVwK
	 oh4rUjwhchGtQ==
Date: Wed, 13 May 2026 10:21:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH net-next 3/4] RDMA/ionic: Add debugfs support
Message-ID: <20260513072113.GE15586@unreal>
References: <20260506041935.1061-1-eric.joyner@amd.com>
 <20260506041935.1061-4-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506041935.1061-4-eric.joyner@amd.com>
X-Rspamd-Queue-Id: 5474C52E976
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20555-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Action: no action

On Tue, May 05, 2026 at 09:19:34PM -0700, Eric Joyner wrote:
> From: Allen Hubbe <allen.hubbe@amd.com>
> 
> Adds a per-RDMA device debugfs folder under the parent ionic ethernet
> device's folder for the LIF. Exports RDMA-specific debug information and
> various queue information.
> 
> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
> Co-developed-by: Eric Joyner <eric.joyner@amd.com>
> Signed-off-by: Eric Joyner <eric.joyner@amd.com>
> ---
>  drivers/infiniband/hw/ionic/Makefile          |   2 +-
>  drivers/infiniband/hw/ionic/ionic_admin.c     |   4 +
>  .../infiniband/hw/ionic/ionic_controlpath.c   |  14 +
>  drivers/infiniband/hw/ionic/ionic_debugfs.c   | 750 ++++++++++++++++++
>  drivers/infiniband/hw/ionic/ionic_ibdev.c     |   3 +
>  drivers/infiniband/hw/ionic/ionic_ibdev.h     |  29 +
>  drivers/infiniband/hw/ionic/ionic_lif_cfg.c   |   3 +
>  drivers/infiniband/hw/ionic/ionic_lif_cfg.h   |   2 +
>  8 files changed, 806 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/infiniband/hw/ionic/ionic_debugfs.c

I'll comment on this patch only, but the same issues apply to the whole
series.

1. This series should target rdma-next, not net-next.
2. Jakub's feedback is valid and should be addressed.
3. The patch is too large and exposes too many details that should be
   gathered through the FW (fwctl).
4. It exposes a large number of fields from general RDMA structures,
   which suggests that this dump is placed in the wrong layer.

Thanks

