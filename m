Return-Path: <linux-rdma+bounces-20285-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJnRGpMT/2n/1wAAu9opvQ
	(envelope-from <linux-rdma+bounces-20285-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 09 May 2026 12:59:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E8A4FF6F1
	for <lists+linux-rdma@lfdr.de>; Sat, 09 May 2026 12:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB468300EAAB
	for <lists+linux-rdma@lfdr.de>; Sat,  9 May 2026 10:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E56933F8BE;
	Sat,  9 May 2026 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kcvl5v7Z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40A813B58A;
	Sat,  9 May 2026 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778324365; cv=none; b=MQwpg6VIRfbSVtYc8XV1baM1cfzuq3d0hkWmEaXSJ4eqZmW4RmXNJpUClql/iCyhVzP+Y2NHuYkqws+8Kirfch1JmjFKOwLL4w1sLTkSlj0xKRdT2Qh90veYsu4K5XbxTHckGKNWHs2wBte+N9i50OYAnsTzP/wg59tQFQYGW94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778324365; c=relaxed/simple;
	bh=8ukEJN8wrpMap3290gYxFhSwHWz+pf6LwUnVWb/+6rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyzguzfpKZtAZo5Wf4lfIXMtvgdeoL81ibyJRrhRHA+pX+e4/GScgo31ApNzE+oTbSYPdelzFvgGw+dKq1tNRAoBNvBSapXv63YudjXiY/MmnRQYrI+txqpGHsHVQOnmUYszRn2kiDT8xVYTppp6Im2UuvJtLTl3xwjUmocCSLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kcvl5v7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F42C2BCB2;
	Sat,  9 May 2026 10:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778324364;
	bh=8ukEJN8wrpMap3290gYxFhSwHWz+pf6LwUnVWb/+6rE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kcvl5v7ZLApDcDkP+Zy0AbOemS2lpR8Op7rx3Zf10mv5FERakk0Nhc5s0ZGqkUHCH
	 5AxkipOZdkxTAJ3gRwhT3Oh856GV8eior611Mdw01r4MNAU7geCblh96f1NTnfIdC7
	 2l74zIN8TEpyldOmnwRHg1wrF20av0OpB3QId7Int45L7c/3Ws00SRC9MQkcO+/Y37
	 VCsVHI06FSqloGMNaD5lqBV47QrngQuzLI0cqkHVnWBwWV4swDGSsysjAyGibiUw10
	 imc1zENU9qLQaKTEYkU2qlVJ7NZiVDbDeqQBIaQO1OHd95wiNTDtlQH4/cR41zJmoK
	 UuzLq97rIEa3Q==
Date: Sat, 9 May 2026 11:59:20 +0100
From: Simon Horman <horms@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	kuba@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net v1] net/rds: reset op_nents when zerocopy page pin
 fails
Message-ID: <20260509105920.GQ15617@horms.kernel.org>
References: <20260505234336.2132721-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505234336.2132721-1-achender@kernel.org>
X-Rspamd-Queue-Id: 07E8A4FF6F1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20285-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Action: no action

On Tue, May 05, 2026 at 04:43:36PM -0700, Allison Henderson wrote:
> When iov_iter_get_pages2() fails in rds_message_zcopy_from_user(),
> the pinned pages are released with put_page(), and
> rm->data.op_mmp_znotifier is cleared.  But we fail to properly
> clear rm->data.op_nents.
> 
> Later when rds_message_purge() is called from rds_sendmsg() the
> cleanup loop iterates over the incorrectly non zero number of
> op_nents and frees them again.
> 
> Fix this by properly resetting op_nents when it should be in
> rds_message_zcopy_from_user().
> 
> Fixes: 0cebaccef3ac ("rds: zerocopy Tx support.")
> Signed-off-by: Allison Henderson <achender@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


