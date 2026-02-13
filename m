Return-Path: <linux-rdma+bounces-16879-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPEUGV5Nj2nnPgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16879-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 17:12:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C22D4137D88
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 17:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21FB9301B15F
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 16:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D69134CFC3;
	Fri, 13 Feb 2026 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNBoV15r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320583EBF00
	for <linux-rdma@vger.kernel.org>; Fri, 13 Feb 2026 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770999131; cv=none; b=nbPwXUK4E86YJhVdgFG2qbhRFHfabrbcv2vloTNY+MfOusacbfGTiO/afYatGRifv9p7KO95L210psehFTTW29It8Mlo1OESMkGuTcjKEJ29pZX7aqkc82kbpiZlhzQTzXWaQlDLUMwGvBhyJuKLMJQHbf0WyIIcdvnFr2OudLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770999131; c=relaxed/simple;
	bh=bb9Jx7++vTLXepN+gg5rzHmXHfO1kqSqZS7IhkFniSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGPdyum3aGwGCYcnayONY0JIIdAVQCAiG1tumFf4LTn9gnaGYMgLvzDwn4Qh/NyL7QTCQn2K9k+vtpcHMRKnjnb5hXnhxW3xQtelnw7MZgpANlbSPipS43E62Oq1QnloPKZNirU1LZYRWObYzxDSn1nxMeCT4F+Yf1L6fdCwGPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNBoV15r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C36C116C6;
	Fri, 13 Feb 2026 16:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770999130;
	bh=bb9Jx7++vTLXepN+gg5rzHmXHfO1kqSqZS7IhkFniSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dNBoV15rN2jfg49slsWNUXb1blYtJFihpHQ7g2Ja6Hk4IQP5CvBiQVezU3JCHxxrn
	 s9wMmacLLY1AQwNGus4twfUv+ObK1xOrSScS1TOWx6yhVDIaQB1H6QaYzu+DPRwB7h
	 Rjt+0iJYnDo+DZWgdfyC4tpXJ5fiVoLEexaZUpchxUW5OGKiQRg84JENJQzKdVktIc
	 OQOR7VkBqD1uTKWOUg38b++4gKOemH7vUHLawRlunJbn40ZNQqIqAW9GoLQES1Zdlt
	 yCLJ74mT2IBwLdU7rIL98l4ACDY9GBxLohi4//bCwTKx74SpoVkC2MHyaD8diMywDy
	 w8+BPRwNZbCqw==
Date: Fri, 13 Feb 2026 18:12:00 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	tangchengchang@huawei.com
Subject: Re: [PATCH for-next 3/3] RDMA/hns: Support congestion control
 algorithm parameter configuration
Message-ID: <20260213161200.GV12887@unreal>
References: <20260206103110.3414311-1-huangjunxian6@hisilicon.com>
 <20260206103110.3414311-4-huangjunxian6@hisilicon.com>
 <20260212165734.GI12887@unreal>
 <c22f1ad1-b8bd-d719-d0f2-9ab721134549@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c22f1ad1-b8bd-d719-d0f2-9ab721134549@hisilicon.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16879-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hisilicon.com:email,huawei.com:email]
X-Rspamd-Queue-Id: C22D4137D88
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 04:36:44PM +0800, Junxian Huang wrote:
> 
> 
> On 2026/2/13 0:57, Leon Romanovsky wrote:
> > On Fri, Feb 06, 2026 at 06:31:10PM +0800, Junxian Huang wrote:
> >> From: Chengchang Tang <tangchengchang@huawei.com>
> >>
> >> hns RoCE supports 4 congestion control algorithms. Each algorihm
> >> involves multiple parameters. Support configuring these parameters
> >> by debugfs.
> >>
> >> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> >> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> >> ---
> >>  drivers/infiniband/hw/hns/hns_roce_debugfs.c | 278 +++++++++++++++++++
> >>  drivers/infiniband/hw/hns/hns_roce_debugfs.h |  25 ++
> >>  drivers/infiniband/hw/hns/hns_roce_device.h  |  25 ++
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c   |  66 +++++
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h   | 140 ++++++++++
> >>  5 files changed, 534 insertions(+)
> > 
> > Please remove all these complexity, delayed work, 
> 
> Sure. Then we'll update HW immediately each time the user write a new value
> to the param file.
> 
> > multiple configuration options in one file, provide one directory with multiple files> Each file is a key, which can accept multiple values and not like it is implemented now.
> 
> If I understand your comment correctly, our current implementation already
> follows the structure you described. We don't have multiple configuration
> options in one file. We provide one directory with multiple files for each
> algorithm. Each file corresponds to one param.

I probably misread your patch, so let's simplify it and it will be more
clear.

Thanks

