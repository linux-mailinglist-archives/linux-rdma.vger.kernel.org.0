Return-Path: <linux-rdma+bounces-20650-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FOXDBtlBWoZWAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20650-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 08:00:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CBC53E2A9
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 08:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FBD23024512
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 06:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC4B38837D;
	Thu, 14 May 2026 06:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aS31gARK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAE43F4117;
	Thu, 14 May 2026 06:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778738453; cv=none; b=d4SqmzxeJ0FKyeXzgggrOHbh4F4YPOLgvvChM5LTdBxSqK65vngvEZ+aiu784q7RMIsg2dJ4aI5UxqkM4d3oXP50zVJ/P+IvBD5O2SR7Yp1DWdazo1jyiL0OYdBVBOTIfe25X4zDNaTBJ8cJeqJbgPy7ybvv7+9xHbf3S2m7UlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778738453; c=relaxed/simple;
	bh=tiMPcAash1cKXoiuSpeyJ1FzfqJBSa59lF7pke0kJx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AySNtzI/W87ILbHrj2lMpVyreLyBlipyIb0GHoSmjNetTc1Fpy53gf+ytOpmlckRc4iYqO7VOrUylubwUZq4vOtzUSdY4LqojwtU+5awnAE4NfuVdEK3EHbJLA6LJ/xpQjb1CQosVYgwaUjHf2P5G13C71VrMJy4B0Z6MtTNMpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aS31gARK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E49FC2BCB7;
	Thu, 14 May 2026 06:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778738453;
	bh=tiMPcAash1cKXoiuSpeyJ1FzfqJBSa59lF7pke0kJx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aS31gARKxZIKNhhXdctTAs5RVMsRE1KDv9h2DxubQAJYM34YBIOz520ylN+hBWFcv
	 IWNLEPh25MMto7ChgZTMSqqfYOdMcTBFDw1U5lc0PR77JPZDb2/sJlnSesiYwFHc66
	 RyiR+a50EnrdUDyIDpBUmlbVwG4XUqRpHPxcR1dJ2Pjw/PTfdhM/j1LUt7cTTrarwz
	 MJh8uFGaVoYRhzPmRMCeh8aF4EUZa7r5pemPTahd2vgaBlvwGGtk2Ugsqsg5hIvphH
	 XjJqAvp/JK9PlvFbBaZz20vB/+8/nqU9hTFAy8gGayz9uK5PSv8EcxNuo4N1gVg9rV
	 Tbl7jPihu0cjg==
Date: Thu, 14 May 2026 09:00:48 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Joyner <eric.joyner@amd.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net-next 3/4] RDMA/ionic: Add debugfs support
Message-ID: <20260514060048.GK15586@unreal>
References: <20260506041935.1061-1-eric.joyner@amd.com>
 <20260506041935.1061-4-eric.joyner@amd.com>
 <20260513072113.GE15586@unreal>
 <20260513172314.35e71e7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513172314.35e71e7b@kernel.org>
X-Rspamd-Queue-Id: 42CBC53E2A9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20650-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 05:23:14PM -0700, Jakub Kicinski wrote:
> On Wed, 13 May 2026 10:21:13 +0300 Leon Romanovsky wrote:
> > 3. The patch is too large and exposes too many details that should be
> >    gathered through the FW (fwctl).
> 
> Why? What's wrong with debugfs? Much easier for people to access.

There is nothing inherently wrong with debugfs. You can see recently
accepted debugfs patches from hns [1].

The issue here is what data is being dumped through debugfs, and in what
quantity. From a quick look, ionic_dev_info_show() appears to print
raw data coming straight from the FW.

In my view, debugfs should expose in‑kernel structures that are shaped
and controlled by the kernel itself. IMHO it is not the right place to
debug FW state. There can always be exceptions, of course, but in this
case the driver is effectively dumping everything from pds_core/FW in
the RDMA layer.

Another point: data that is generated and fully managed by pds_core
should be presented under drivers/ethernet/... where pds_core actually
lives and interfaces with the FW.

It does not belong in RDMA.

Thanks

[1] https://lore.kernel.org/all/177868031111.2312230.3184039384666355404.b4-ty@kernel.org/

