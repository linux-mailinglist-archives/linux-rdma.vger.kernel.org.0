Return-Path: <linux-rdma+bounces-21255-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEAIIUu4FGq8PgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21255-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 22:59:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 319FF5CEC92
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 22:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8823C3013A93
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 20:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B5033E35F;
	Mon, 25 May 2026 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1VaOLBF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057DD281532;
	Mon, 25 May 2026 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779742788; cv=none; b=OdakuffmErCqJ2qvAL11UDpGA2qLnzrs6cALUxrAfKjzR3z8z5BaNp5Z2o8CCUse/KvtsqPF6iZ8fuxkuGguhl5SDfspQ+IKbs1PAs3y/mqFkHTfcJ1hzvoAF8Nys2mzuQ4Y25Nk+XpUlovSGQbYONMKqtWgZYHdk7HpUglA7i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779742788; c=relaxed/simple;
	bh=mrWLulCeZBG/eZdd3kuW8W3jBb3wHhtur0/JQyQu52c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGQ2NoPj/HVikZxdv54rzKMb87wj6qQM3p7Oqqo8zKZxDOOIaH9eQmpcqupGFaetwjmO9bNyU2+7E2GYSwJYkChRN8+e/zOent77Xnc15twYsUJab6XWuy6hN89exkYMisZsyE1mdLLu/mRQd7H3A0Q4+EqRPIEKEV3JaXGcmbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1VaOLBF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899281F000E9;
	Mon, 25 May 2026 20:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779742786;
	bh=yUD6UxnK7HW4Boqv2TCaO67dtaloiSS48KysPRLAf9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=j1VaOLBFVGn2NDJ//VY1ZQjV3NXIU2X+5VxxaLOtPGlyPI7VL3M0ixXVCkBlHBzt6
	 4HzQ+Mr8Oe02dt+4M1YCjHckfhKTUZ3O7J3M9BXFN5a9MJHNNl23CS2TO/v0PEyvjp
	 YCYAaIcylZ2OHq6jq1AR0GkPXjtOZAWITC8FAQWdUixnSl4n7LZFfCCeDa28L7kYhm
	 FgtD3BGMAHHbiPs7dX8mYBdY+oBogTJNYD6v9aaUuKjVAglbscxlskGKbyPqCIbEg1
	 DAmMWzRLrnfx9MKOqEHqP2L5hzzAKox+JYyumVI4Sm/KTyor2aTjUkXPOqwh8mfl8o
	 X+IaFpH6LSusA==
Date: Mon, 25 May 2026 13:59:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <netdev@vger.kernel.org>, <oss-drivers@corigine.com>, <akiyano@amazon.com>,
 <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
 <arkadiusz.kubalewski@intel.com>, <brett.creeley@amd.com>,
 <darinzon@amazon.com>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
 <edumazet@google.com>, <horms@kernel.org>, <idosch@nvidia.com>,
 <ivecera@redhat.com>, <jiri@resnulli.us>, <leon@kernel.org>,
 <mbloch@nvidia.com>, <michael.chan@broadcom.com>, <pabeni@redhat.com>,
 <pavan.chebbi@broadcom.com>, <petrm@nvidia.com>,
 <Prathosh.Satish@microchip.com>, <przemyslaw.kitszel@intel.com>,
 <saeedm@nvidia.com>, <sgoutham@marvell.com>, <tariqt@nvidia.com>,
 <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v16 net-next 1/9] octeontx2-af: npc: cn20k: debugfs
 enhancements
Message-ID: <20260525135944.63d57e95@kernel.org>
In-Reply-To: <20260521095303.2395584-2-rkannoth@marvell.com>
References: <20260521095303.2395584-1-rkannoth@marvell.com>
	<20260521095303.2395584-2-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21255-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,corigine.com,amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 319FF5CEC92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 15:22:55 +0530 Ratheesh Kannoth wrote:
> Improve MCAM visibility and field debugging for CN20K NPC.
> 
> - Extend "mcam_layout" to show enabled (+) or disabled state per entry
>   so status can be verified without parsing the full "mcam_entry" dump.
> - Add "dstats" debugfs entry: reports recently hit MCAM indices with
>   packet counts; stats are cleared on read so each read shows deltas.
> - Add "mismatch" debugfs entry: lists MCAM entries that are enabled
>   but not explicitly allocated, helping diagnose allocation/field issues.

debugfs file which clears state seems quite odd.
Does any user need this?
This looks like a crutch for badly written tests TBH.

