Return-Path: <linux-rdma+bounces-15874-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL8eLl6ecWmgKQAAu9opvQ
	(envelope-from <linux-rdma+bounces-15874-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 04:49:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 651F061789
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 04:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 685F0507AD6
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 03:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8EC3502A0;
	Thu, 22 Jan 2026 03:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZt6Tbha"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCDB34CFD6;
	Thu, 22 Jan 2026 03:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769053298; cv=none; b=QwQTIPo961QCVjm0vY5Uc5XUAvMw/CGOWssVDJgjKX1Bx0Ha7DfkmDuO5irGxqN8nfk8Mwed1ePyR1+AmBblyke5243cVtc8y/pZ0FtwE0ha1SGMfJ9aslb1bjxOgqv+t01Rllbv9LqGX1ORY0kG7mZ/X+ycLE6o68sKKZplZjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769053298; c=relaxed/simple;
	bh=fQn73AMtLykAtIbLfz754K7IjrqMh6xwHuQUkv3q07Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nRobrXiLTEGJH+eGN4OjtiseFBz6ExApFzX6AYcE6ad25f4XvgD9RuVA4dFSjD0/O6dNgQkRO6fE5TkknnQyrTli3q+lYOetpxt4mP1eBN7eJoXqUHOQAeodD1yQSNkhV5slDRf2cansqliFKoEeW/VAUf0Yed6DVzRmDKd6VLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZt6Tbha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E56C116C6;
	Thu, 22 Jan 2026 03:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769053297;
	bh=fQn73AMtLykAtIbLfz754K7IjrqMh6xwHuQUkv3q07Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VZt6TbhaNMFnQUPH6VMQSSy4AY3T3m0yjxWcvzn/VJSjG/ekyR2N5WuJ1I77RoIeV
	 UFxPvfj7KmKeZUvhEf2U+MSJbybnri/tGUIEKRvVLJRFjsT/5PK+T/USLsIiEI3Ubp
	 rTV3QsEI1Z8DxpsYVh2htQANMvCMKPUwtAXmcIcguZG0Ju+IUfwGD0Rf2A6TPIq7T/
	 GG42s5OMkxFqZ2apTXC+5L1RIJrMKr7o7I3+j7jhyFPJRANYFxkRBe9Hk4sfdYBwG/
	 CDdIVQ9yDsg+jDNuWTQQ7qfteH+h0nw26S0Qreo6yZx3FryiiVGWkwWVML8KpayD/I
	 7ubVMGLwPk1hg==
Date: Wed, 21 Jan 2026 19:41:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: tariqt@nvidia.com
Cc: cratiu@nvidia.com, saeedm@nvidia.com, cjubran@nvidia.com,
 davem@davemloft.net, horms@kernel.org, linux-doc@vger.kernel.org,
 mbloch@nvidia.com, moshe@nvidia.com, jiri@nvidia.com, edumazet@google.com,
 gal@nvidia.com, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 jiri@resnulli.us, krzk@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, rdunlap@infradead.org, leon@kernel.org,
 corbet@lwn.net
Subject: Re: [net-next,V5,10/15] net/mlx5: Add a shared devlink instance for
 PFs on same chip
Message-ID: <20260121194135.6737b36f@kernel.org>
In-Reply-To: <20260122033959.2579113-1-kuba@kernel.org>
References: <1768895878-1637182-11-git-send-email-tariqt@nvidia.com>
	<20260122033959.2579113-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,davemloft.net,kernel.org,vger.kernel.org,google.com,lunn.ch,gmail.com,resnulli.us,redhat.com,infradead.org,lwn.net];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15874-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23]
X-Rspamd-Queue-Id: 651F061789
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 19:39:59 -0800 Jakub Kicinski wrote:
> > +int mlx5_shd_init(struct mlx5_core_dev *dev)
> > +{
> > +	u8 *vpd_data __free(kfree) = NULL;  
> 
> The __free(kfree) annotation here combined with the early return below
> looks problematic.

__free() should be considered banned for netdev.
Please.
It clearly adds more bugs than it fixes.

