Return-Path: <linux-rdma+bounces-20690-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MlHDzW2BWpZaAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20690-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 13:47:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F33A54131E
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 13:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B675303A25C
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 11:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51063C2777;
	Thu, 14 May 2026 11:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tn6t9NSJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879A7395AEC
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 11:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778759062; cv=none; b=QnavqtFooVJK8XA3opTuIoHA382zd06Ox0alfrmgOIgJZhFU5qHAXQlf9RgYhpp+gEjdVlgaVra7J9f0TjPeh9RXmNC4gcB8T5j8WInzdD57VFOuN3oqYkceHGemorHPUd82KjF9IEYITUecT+W1VHcqGVYcsHqYMY3469BcLm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778759062; c=relaxed/simple;
	bh=FiZMLcrWrpA14uSJvq5MtW34T41AbUwzdQS/OLvrPd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1nhb9m6YglIlZmWJGSD6GBh7TLmhwJ/IC/U0cJwTlebJRq3TKI1mHJpqxxx49qHspMRDjt9sJ74GmGoa/slTd1J1ICU79oRGSmxbSQcGHQFoglhsq2njO8Dc/p7mZpyPCobEE2JKMWSF6Tz8stopUfcPQPntj24TFA9RVbj3pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tn6t9NSJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C757DC2BCB3;
	Thu, 14 May 2026 11:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778759062;
	bh=FiZMLcrWrpA14uSJvq5MtW34T41AbUwzdQS/OLvrPd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tn6t9NSJYzCvTy3BnUR1Uz2umEuTxemt2i3Mj+i3Ecq+3s9lWHXAIL6FWwUgGoHBr
	 AFiwN1l841uV/+WcEGjnx32ADWEOEf8bdUYvaTKb+xBalfkwKu+3r6M2oAG2a+udmB
	 S7KcusT/nvxELc2CbwTjcAfQ1hr3WVFF36CTabeaTWhvuP1ZTaPAjJMdGsWRAc4D7T
	 ry597iiZAoKZ/2WT7P//etGDMwq18HCvO/UjEVWdt5tnHlBOk4J4p0zyjWwuGrruUx
	 YsR3irnh5cXbCgUekN9sbLWoe7wcDWxHyUbAPpTRa3Gh5JND9pNpyrvEvbABnqAQWo
	 tkabB2cXrPtfA==
Date: Thu, 14 May 2026 14:44:17 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tao Cui <cuitao@kylinos.cn>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/2] RDMA/nldev: add resource summary max values for
 usage rate display
Message-ID: <20260514114417.GP15586@unreal>
References: <20260423061352.359749-1-cuitao@kylinos.cn>
 <20260511101258.GF15586@unreal>
 <4ab73129-b690-497c-83b1-d2065f52e7bd@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ab73129-b690-497c-83b1-d2065f52e7bd@kylinos.cn>
X-Rspamd-Queue-Id: 9F33A54131E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20690-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 03:38:59PM +0800, Tao Cui wrote:
> 
> Hi，Leon
> 
> Thanks for the review. You're right that a percentage alone is not
> very helpful to users.
> 
> 在 2026/5/11 18:12, Leon Romanovsky 写道:
> > On Thu, Apr 23, 2026 at 02:13:51PM +0800, Tao Cui wrote:
> >> Add RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX netlink attribute to expose
> >> device resource limits (max_qp, max_cq, max_mr, max_pd, max_srq) in
> >> the resource summary alongside the existing current count. This allows
> >> userspace tools like iproute2's rdma to display resource usage rates.
> > 
> > While I'm fine with the overall idea, I think we should spend more time  
> > determining the proper display format for this information. Once we agree  
> > on how it should be presented, that output should be included in the commit  
> > message.
> > 
> > Presenting utilization as a percentage seems too imprecise, and users would  
> > likely prefer to see the maximum value instead.
> > 
> > Thanks
> 
> I originally chose the percentage format for its intuitiveness.
> The expected output was described in the corresponding iproute2
> patch [1], but I should have included it in this kernel commit
> message as well.
> 
> [1] https://lore.kernel.org/all/20260423064711.360024-1-cuitao@kylinos.cn/
> 
> Here are the display formats I considered:
> 1) qp 123 (0.0%)            -- percentage only, loses the actual max
> 2) qp 123 (max 131072)      -- clear but verbose
> 3) qp 123/131072            -- curr/max, concise and common in Linux tools
> 4) qp 123/131072 (0.0%)     -- all info, but too crowded for one line
> 
> After comparing them, I think format 3 is the best fit. It is concise,
> follows conventions used by other Linux tools (e.g. df, free), and
> users can easily estimate the percentage from the curr/max values.
> 
>   Before: 0: mlx5_0: qp 123  cq 45  mr 200  pd 10
>   After:  0: mlx5_0: qp 123/131072  cq 45/65536  mr 200/1000000  pd 10/32768
> 
> In JSON output, both "curr" and "max" fields will be provided so that
> scripts can compute percentages if needed.
> 
> The kernel side change (exposing the max value) remains the same. I'll
> update the commit messages to include the expected output format and
> resubmit.
> 
> Does this look acceptable?

Yes, I agree that option number 3 appears to be the best choice.

Thanks

