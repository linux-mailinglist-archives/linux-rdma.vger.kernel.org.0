Return-Path: <linux-rdma+bounces-18035-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE65MmwDsmmHHwAAu9opvQ
	(envelope-from <linux-rdma+bounces-18035-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 01:06:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDA526B885
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 01:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A35F1305D1ED
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 00:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54CC286A7;
	Thu, 12 Mar 2026 00:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IglxRtFg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A668C14A8B;
	Thu, 12 Mar 2026 00:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773273959; cv=none; b=VbXrNLP9IurQDvYYP8lhgjs8GiBmjeQzhfDQ19AaZ+IQyCWtScvAZnnGxhdio0qQirEeUoRlg+VUI+qg2DoDDSMCTggkCICg/yuzj1nU/c2KtYrUDkhnzi3zKQ9vH4Zb213LzrYNDPENZddqkRV2UYp+UkA/uL7pZ/wYA7UEVlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773273959; c=relaxed/simple;
	bh=RMp54iFlPjc+rBAtTxro7vOG3ZmcGMXyOZqY6D9G+Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tt9pqoFiwNKSOBpfWrXBkoDQ0PTpdQLBddWW04+viNSRL7sckg0sG+YvMLOMrGbClJKxaYW1KmXTbhVcL+Tmts8e266m5pwEPxCVOiiGaaggHx0qEdWY7ZyUO66pCrkl1fI5pLpJc43UfsRL84ETofuQUj93unOFC0XhyNocBVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IglxRtFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE41C4CEF7;
	Thu, 12 Mar 2026 00:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773273959;
	bh=RMp54iFlPjc+rBAtTxro7vOG3ZmcGMXyOZqY6D9G+Jc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IglxRtFgSPg0hdDlGjkXj/fku8porpUpgTXKnxmRERC8SjySREnwVbHLVZmNDdzkD
	 mpJDivvaXeKKE0tYLkHhgBEio64Mc3ZYKwPNPCFtvsEHLmo8052YEkY5S/atslkYIF
	 itScyvk2gKtx2D1BoSQk37jw7ormeic+uAeQwLPz9zQBV6jZD946nbvz7EQ3EwgBiQ
	 5L2w9sUyXPQzgjKsS1i55NEK3Ou8GmIsZlRgaQ2xQei9z0RQBkhgZxIaUapiXgaIPq
	 Qy20CyZoDF0l0LMkyYQ7i9AnGKym1HQlMKB582ahLI/COkKZLn+Boun7vRlOv1mriA
	 Ly5zHf04gSOYQ==
Date: Wed, 11 Mar 2026 17:05:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Allison Henderson <allison.henderson@oracle.com>
Cc: "achender@kernel.org" <achender@kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>, "horms@kernel.org"
 <horms@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 0/3] selftests: rds: ksft cleanups
Message-ID: <20260311170557.7155dab1@kernel.org>
In-Reply-To: <7bc8d62f5f7e8e4a79ab5aa486d660854455a493.camel@oracle.com>
References: <20260308055835.1338257-1-achender@kernel.org>
	<20260310185305.017976e4@kernel.org>
	<7bc8d62f5f7e8e4a79ab5aa486d660854455a493.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-18035-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FDA526B885
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 04:56:59 +0000 Allison Henderson wrote:
> On Tue, 2026-03-10 at 18:53 -0700, Jakub Kicinski wrote:
> > On Sat,  7 Mar 2026 22:58:32 -0700 Allison Henderson wrote:  
> > > This set addresses a few rds selftests clean ups and bugs encountered
> > > when running in the ksft framework.  The first patch is a clean up
> > > patch that addresses pylint warnings, but otherwise no functional
> > > changes.  The next patch moves the test time out to a ksft settings
> > > file so that the time out is set appropriately.  And lastly we fix a
> > > tcpdump segfault caused by deprecated a os.fork() call.  
> > 
> > Looks good! So this is enough to make ksft work? Or just the first
> > batch of obvious fixes? :)  
> 
> Those were all the ksft bugs I encountered on my end.  Let me know if
> you run into any trouble with it.

SG! I'll retry over the weekend

