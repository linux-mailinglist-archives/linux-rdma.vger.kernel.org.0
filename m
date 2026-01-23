Return-Path: <linux-rdma+bounces-15926-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALmcDpqMc2l0xAAAu9opvQ
	(envelope-from <linux-rdma+bounces-15926-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 15:58:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE46977527
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 15:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57F11301CF8D
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 14:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D48330B06;
	Fri, 23 Jan 2026 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZ+CT3AP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04262E06EA;
	Fri, 23 Jan 2026 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769180304; cv=none; b=FiS6ckL/9llhaimrw+TQuJc7fCpPmkESXfoHtbRT5VVbTLcMPcAXhwsIPfbLd6ej04uj/W34QOSjuiOleoiLrbIB8GK/rjrzh2j+rSWtjcnX3rjrMlVpXRE4I++z7en1m2LIMxL/RWVEmL+zmQgV54hWr9TqQJCwL/0IZ24gB7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769180304; c=relaxed/simple;
	bh=WE1/H+pA0M/3cp7I12EZf75aU5FUoIcUNrJz5plzf+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDVWJZzCOiMsPE1BX7SMgdxGg4Le6WI9m5LprkEPvrR5/2mvY6FgZgciruzQ6+6EUb/NfImPtPEgru/hhE/2nEgXyi7QksexvUGNYs3CaPG6PGkMtnBjGz/S99DHOjW/YiiC/E6WwdQ8RHQ3DgMMv3vEdiSYoi4wahf/bdtatH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZ+CT3AP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1860C4CEF1;
	Fri, 23 Jan 2026 14:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769180304;
	bh=WE1/H+pA0M/3cp7I12EZf75aU5FUoIcUNrJz5plzf+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SZ+CT3APk84zJsU3fPjS/cljFGrh/epaOwqraMXSnLhGxxPPyuUvd8R2nRHnobE0t
	 Axzf8KEbqpXEi06s4Tl1EjVi+gcvQTZI85r4qO33j7R+tMRkhgtXN2+TxQToF8hnnU
	 zvuN90uhpTh5qQjnRUcl0lExnZUhj6iuuKMQJ1L7oL4UXOcxLvu0iC3mPKtdMkVXWZ
	 HGoS/TwBDJtvzBAbwSrMZKHZI+ccvaar2vfPNFCIwTNqsp87EGAaEb7U06uIPieGbf
	 qhMFRq0ktMd4DotsSv3Hyl0OT2SJ0ztfEwAk1w3s/NWkhj2W7yhovKjtnDZLEOK3Vm
	 8ScnkolaB+4nw==
Date: Fri, 23 Jan 2026 14:58:16 +0000
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, conor+dt@kernel.org, poros@redhat.com,
	anthony.l.nguyen@intel.com, linux-rdma@vger.kernel.org,
	tariqt@nvidia.com, robh@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, aleksander.lobakin@intel.com,
	mbloch@nvidia.com, jiri@resnulli.us, Prathosh.Satish@microchip.com,
	krzk+dt@kernel.org, saeedm@nvidia.com, devicetree@vger.kernel.org,
	davem@davemloft.net, pabeni@redhat.com,
	przemyslaw.kitszel@intel.com, arkadiusz.kubalewski@intel.com,
	jonathan.lemon@gmail.com, saravanak@kernel.org,
	aleksandr.loktionov@intel.com, mschmidt@redhat.com,
	edumazet@google.com, leon@kernel.org, vadim.fedorenko@linux.dev,
	grzegorz.nitka@intel.com, intel-wired-lan@lists.osuosl.org,
	richardcochran@gmail.com, andrew+netdev@lunn.ch
Subject: Re: [net-next,v2,08/12] dpll: Enhance and consolidate reference
 counting logic
Message-ID: <aXOMiAhf-NdQTonz@horms.kernel.org>
References: <20260116184610.147591-9-ivecera@redhat.com>
 <20260121001650.1904392-2-kuba@kernel.org>
 <f676c151-e871-4b2e-83f6-6d62bc146337@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f676c151-e871-4b2e-83f6-6d62bc146337@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15926-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,intel.com,vger.kernel.org,nvidia.com,resnulli.us,microchip.com,davemloft.net,gmail.com,google.com,linux.dev,lists.osuosl.org,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,dt,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: CE46977527
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 09:18:02AM +0100, Ivan Vecera wrote:
> On 1/21/26 1:16 AM, Jakub Kicinski wrote:
> > This is an AI-generated review of your patch.
> > 
> > Dunno if there's a reason for having this fixed by a later patch,
> > if not let's fix. I'm sending the review mostly because of the
> > comments on patch 12.
> Will reorder these patches... Maybe it would be better to send patch 9
> separately to net as this is the fix for the bug we found during
> development of this series.

Hi Ivan,

If it is a but in net, then yes, that sounds like a good idea to me.

Please include a Fixes tag if you take that route.

