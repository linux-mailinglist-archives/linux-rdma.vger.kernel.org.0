Return-Path: <linux-rdma+bounces-21124-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oINhOZYVD2otFAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21124-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 16:24:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FC65A72E2
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 16:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E79A432B3386
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DADD3806C1;
	Thu, 21 May 2026 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6hYDceB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3288C2D9484;
	Thu, 21 May 2026 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371773; cv=none; b=CRYnEFEdcpM3kjDBc9dQta5wb/j3T0UJuvXZmpsjdC8S87t4ukyPDDr1EiL8axRr5lo6Kd9ukOF4Q6CkN8pxIIzWWKi5XosBSOEJJdP6H82nRcgExRfhK/Y14PM/7CHtc41NBx0iX0K6zuufTXb/xa/vmxDtm31V5Lk5KbELgBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371773; c=relaxed/simple;
	bh=LN14S2k/OS6NjFQJ4KHnBrXj5TT2Gib8dmpdoYfpSSg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0T62BIMChNHHbgb1FtvBYaNxLAMf9LMbSuXips+4stZddVjsiNoLJDmOYiT67dob0eo0xUThrxKwdCz7MOvNlHNvblwHrN+hyjufb1UWjCBO0tIDt9QWfg7p77L3fBggD/DDjYvBAhI2PQGX/KtFdRvj9aCBFtegMP4ujOsTWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6hYDceB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF5D1F00A3B;
	Thu, 21 May 2026 13:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779371771;
	bh=vQ43n2ibcfudbPKxR2EO8+7ESqnOuekjz3+Phby1eQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=H6hYDceBVsAsJTuAgGZoULmdaAl/qknRoTbE3PrlMn2THnzEQycJaTMP+7TF8BR8y
	 3BKcDB/bFUcfOBDgpnqUNcS+uz2UfC+P4wsubkc4mtR8zgjHaAM0hiHn0iUC3ajjxE
	 m2mUD9rA2G89hq5xJDbA52qnIUIncu82rScOni3HEtDR//WqsdDFV8d8dy+kIfKGvo
	 Wwli/9gnRppeIP5E4luhJOuqhv/HnKhX3OjIm3sVo1pweTXhkGdGgTNILK0BhW8K1C
	 Su7PEiL4vbT++X6m/UGhyPTcV+fZc7Clc87jWODScG0Be6NB/F33nzICwc/VmlW5HV
	 4+30zyLb6i8rw==
Date: Thu, 21 May 2026 06:56:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
 <netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>,
 <aleksander.lobakin@intel.com>, <sridhar.samudrala@intel.com>,
 <anjali.singhai@intel.com>, <michal.swiatkowski@linux.intel.com>,
 <maciej.fijalkowski@intel.com>, <emil.s.tantilov@intel.com>,
 <madhu.chittim@intel.com>, <joshua.a.hay@intel.com>,
 <jacob.e.keller@intel.com>, <jayaprakash.shanmugam@intel.com>,
 <jiri@resnulli.us>, <horms@kernel.org>, <corbet@lwn.net>,
 <richardcochran@gmail.com>, <linux-doc@vger.kernel.org>,
 <tatyana.e.nikolova@intel.com>, <krzysztof.czurylo@intel.com>,
 <jgg@ziepe.ca>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>, Samuel
 Salin <Samuel.salin@intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v3 01/14] virtchnl: create
 'include/linux/intel' and move necessary header files
Message-ID: <20260521065609.248c7009@kernel.org>
In-Reply-To: <ag7QUgfpM5UAAE2z@soc-5CG4396X81.clients.intel.com>
References: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
	<20260515224443.2772147-2-anthony.l.nguyen@intel.com>
	<20260520175201.72f83c4a@kernel.org>
	<ag7QUgfpM5UAAE2z@soc-5CG4396X81.clients.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21124-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,redhat.com,google.com,lunn.ch,vger.kernel.org,linux.intel.com,resnulli.us,kernel.org,lwn.net,gmail.com,ziepe.ca];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 80FC65A72E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 11:28:50 +0200 Larysa Zaremba wrote:
> On Wed, May 20, 2026 at 05:52:01PM -0700, Jakub Kicinski wrote:
> > On Fri, 15 May 2026 15:44:25 -0700 Tony Nguyen wrote:  
> > > include/linux/intel is vacant  
> > 
> > I don't see any other vendor directory under include/linux  
> 
> There are at least
> 
> include/linux/mlx4, include/linux/mlx5 and include/linux/bnxt.
> 
> Those are per-driver and not per-vendor, but intel ethernet has too many drivers 
> to have separate folders for them.
> 
> I just do not think this creates a precedent neccessarily.

You just said the other ones are for specific drivers.

> Folder structure is for you to decide as a maintainer, but it would be nice to 
> have known about such doubts earlier.

I'd love to know if you any suggestions for improving the process.
Otherwise please keep your venting off list.

