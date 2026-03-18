Return-Path: <linux-rdma+bounces-18362-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPIPN730ummVdQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18362-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 19:53:49 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BBD2C1A5C
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 19:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1428D309ADEE
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 18:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218873D34AC;
	Wed, 18 Mar 2026 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bA+4cOvH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E95281525;
	Wed, 18 Mar 2026 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773858437; cv=none; b=kRgSevmydYzvxc4c6zX/fLwFD6IqEnqnla62VlnvgmaUfPuTpOX+HNqmFofuedMLOEXWuurSbX9PAHIiokFXda63YYpG7lVQgvzKQYNtwsBTXcmLHZgrk1PQRK6sjUfyF2TL6kwMs3eQwdRx+t09HH+SYK+tOt1tBv7YaxXS888=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773858437; c=relaxed/simple;
	bh=ABnNpemdtuhmdFVFsfGtR4doB+ZUJ4gh3YxvbUmyV+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVnzywL1XfLAsuZay5Hg47AR6m/2I4ItSrrcnmxiSd3NBeidB7livL0BTuBzkYLpUoAJjGu0FzfAfnp35xiX0743ajgfBiTZ9VeK7Tjpu8XeoYFsqLbCk896D0OG0hoCximWxTqY0bHFGczGttByfRiKZPCwpSymjhMZCxhnNCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bA+4cOvH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C4AC2BCAF;
	Wed, 18 Mar 2026 18:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773858437;
	bh=ABnNpemdtuhmdFVFsfGtR4doB+ZUJ4gh3YxvbUmyV+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bA+4cOvHFeMOp5V8YyBXeogK8NOrd/Bo2TgSVO4EBSzdlwjrr69w2ZgiCG/f0fS8u
	 brAyGQn8OcEEacZP8fvGeSMbzJiJ7wfVn1Mjdq87vtVLJQrvkP7f/cEahW7Y1oxlA/
	 rChknnJ+SbiZ0LaEmDifZS2ko81QQDMV4jST98Vf6JHMJWPDZbx9zTPeY1bmfnbKck
	 LZCFsgznnCFnbdTNKt7FXgWR5X4p0gh0jj/U77Hfnk/Kh7g9rJ5ArwJm42H+/gRFso
	 V48bqIrDnj+0djkPsdRMYHqR9t9VrpfBMCv8qxK+Q0JSP1SdwS0eJrjdm52whLJk+z
	 EpSD/lrvUE+Zg==
Date: Wed, 18 Mar 2026 20:27:12 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, shirazsaleem@microsoft.com,
	longli@microsoft.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: cleanup the usage of
 mana_gd_send_request()
Message-ID: <20260318182712.GI352386@unreal>
References: <20260318173939.1417856-1-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318173939.1417856-1-kotaranov@linux.microsoft.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18362-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9BBD2C1A5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 10:39:39AM -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Do not check the status of the response header returned by mana_gd_send_request(),
> as the returned error code already indicates the request status.
> 
> The mana_gd_send_request() may return no error code and have the response status
> GDMA_STATUS_MORE_ENTRIES, which is a successful completion. It is used
> for checking the correctness of multi-request operations, such as creation of
> a dma region with mana_ib_gd_create_dma_region().
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/main.c | 105 ++++--------------------------
>  drivers/infiniband/hw/mana/mr.c   |  38 ++---------
>  drivers/infiniband/hw/mana/qp.c   |   9 +--
>  3 files changed, 19 insertions(+), 133 deletions(-)

I fixed coding style errors, removed same debug print from other
mana_gd_send_request() callers, together with netdev prints, which don't
belong to RDMA and applied the patch.

Thanks

