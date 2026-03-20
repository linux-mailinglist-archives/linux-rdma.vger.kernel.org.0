Return-Path: <linux-rdma+bounces-18436-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MloDGcFvWkO5gIAu9opvQ
	(envelope-from <linux-rdma+bounces-18436-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 09:29:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C51492D73BA
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 09:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E595230602D6
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 08:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859AE372B36;
	Fri, 20 Mar 2026 08:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egw1jvQl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4786736EA89;
	Fri, 20 Mar 2026 08:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773995173; cv=none; b=OE/z0u++wgccTm+jPGpQjNWmUCXRTcKoJ+w+AGqi7YqDikyppxWziJOe/nCmfKK3lLduZTxqDEYnxzIc/Da6UtEYl+bJruJVAaChjT0+NgozEwhRZ1V43bR38uDWcruAsA3XOBzSWXH7dto2T7CB+fzmXwmrx+ubkslZ7FgWAvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773995173; c=relaxed/simple;
	bh=8ornaCijKEKO4JdKdaXYK/dfmy8Tw3eR3/L5gzBWdYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGNTgpRgsrt/mCV7sKmDDhaK8VWLqhaOR/h4MqqICG9bNEIyZjgrv0FxhF27Gza32lT5LSR3Rye0IuP+xPIyNnInOu5sqAcJPI58W4lufTao8whcCaApW9Re9Zi/hEBuRK1pkckADNbj9aXMbb/e4jPFepEsqNTE9odAKGTBiT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egw1jvQl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10249C4CEF7;
	Fri, 20 Mar 2026 08:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773995172;
	bh=8ornaCijKEKO4JdKdaXYK/dfmy8Tw3eR3/L5gzBWdYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=egw1jvQlOItmykIok0j9An448qzsB1EgHVbv2c+dreDfliXMBNWOyQvtnl3YNO7hM
	 HshDSsjdNzpkq/zKUY4XjoG4e65WmF4hBWyKnYNCwpEEKdN0qgk9jhu3qnvzH4OFnF
	 8dLXyAk0SS0Vdyp7PcT0X5Nj/jg6cylfXa6BnKP+92hr2sFQB5wc8reocfWCmmaTyI
	 GvPu+R3N4PKPWV3Cs4xl3IdIlquApIp2ttnceVmBaAzldojedbxdVuOgXcqVxPR/FP
	 9zhnDadJA8kSDr8v5+QvjmRrVvlzWZTDffxBJAlJA4bgqV91TPN9WBKua1niRD20g3
	 5ZHdYYy/3NCdw==
Date: Fri, 20 Mar 2026 08:26:08 +0000
From: Simon Horman <horms@kernel.org>
To: Allison Henderson <allison.henderson@oracle.com>
Cc: "achender@kernel.org" <achender@kernel.org>,
	"rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [net-next,v2,2/2] selftests: rds: Add -c config option to
 rds/config.sh
Message-ID: <20260320082608.GZ1753385@horms.kernel.org>
References: <20260319004618.2577324-3-achender@kernel.org>
 <20260319201329.1059998-1-horms@kernel.org>
 <f0cf57ea9a139ea9af7556442304f8b70d416c16.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0cf57ea9a139ea9af7556442304f8b70d416c16.camel@oracle.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-18436-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: C51492D73BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 03:05:22AM +0000, Allison Henderson wrote:
> On Thu, 2026-03-19 at 20:13 +0000, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> Alrighty, I will update the README.  Thank you!

Thanks.

FWIIW, I do agree the code changes here in v2 are in line with the
discussion around v1.

...

