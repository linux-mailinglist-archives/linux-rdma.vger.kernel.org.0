Return-Path: <linux-rdma+bounces-15933-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDk0J0q4c2n/yAAAu9opvQ
	(envelope-from <linux-rdma+bounces-15933-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 19:04:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A6C7955E
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 19:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6427F300A72C
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 18:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD863156F45;
	Fri, 23 Jan 2026 18:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dw3YL1b4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B26C156C6A;
	Fri, 23 Jan 2026 18:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769191495; cv=none; b=oZQydL6dMprk2sbu7N4MWRBmToTSi3G8xsgEWwkWGty5nhQPdizRq8gh3GvMT2Tcj0VfTD1b90aG5z+kLg+fuiKjxmcFwdt9k+LfyXzQKZcji0oNHU7ku3tqP820lj0Gud1o0/27qA1mxibtoNz2yF4ZUrpfVS3BFMNKPrf6lZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769191495; c=relaxed/simple;
	bh=0DvNaXsBMKsLBkqZft0cqd9Fzf0jP09zTVPIXy7A82Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L13qBUZxwvhRi4uPwo/cUTezGHPhC8HZ1mA32UU7jh/5SmxzGa4rG9YQoNngehZ3Ncd548+QyxTG1X7pKY34/UqmOslBwvytX/FeLci7dC0q0tm0hUuj7fWZnKT0f3Lutf/cnc/gPRS90jKWGgUva5qcrlSMim6/uNDyVU3WWTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dw3YL1b4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72716C4CEF1;
	Fri, 23 Jan 2026 18:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769191495;
	bh=0DvNaXsBMKsLBkqZft0cqd9Fzf0jP09zTVPIXy7A82Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dw3YL1b4wRL0gdmgXTHfy275iYbUQUxqlxtSSSygZ+j2gf0OINHEbN351xA3Ob0mJ
	 XW/2t3eZNrkwIEAWj96KY6Cw9L+EqDtPezRJPJjacGPT69rkq7oO/DzRp7hGf9YFA9
	 JyDnqzyZeTVFa9Q0c/dOfKJC7b/ymlhz7pUZIiNaIdaFCThb3TfCdbEyCJsoIH0lFe
	 dmqO/vRYoqce7mCECBwS/q4p4p1YuaXi/lO8TLtnCe/kW3yorCoTaRqXqejwPWVo1m
	 XJWi1LGt9yI4yVBAULOtYqRoXjcVHoALzN6j+O0KKxsTfDt6RfMsaZfmgtM4bxFddW
	 YaWjnc5CpBkcw==
Date: Fri, 23 Jan 2026 18:04:47 +0000
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
Message-ID: <aXO4PzKrud1h3uYL@horms.kernel.org>
References: <20260116184610.147591-9-ivecera@redhat.com>
 <20260121001650.1904392-2-kuba@kernel.org>
 <f676c151-e871-4b2e-83f6-6d62bc146337@redhat.com>
 <aXOMiAhf-NdQTonz@horms.kernel.org>
 <6da98781-9cf2-4756-a6b1-89cc650c9bce@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6da98781-9cf2-4756-a6b1-89cc650c9bce@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15933-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,intel.com,vger.kernel.org,nvidia.com,resnulli.us,microchip.com,davemloft.net,gmail.com,google.com,linux.dev,lists.osuosl.org,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,dt,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26A6C7955E
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 04:27:21PM +0100, Ivan Vecera wrote:
> On 1/23/26 3:58 PM, Simon Horman wrote:
> > On Wed, Jan 21, 2026 at 09:18:02AM +0100, Ivan Vecera wrote:
> > > On 1/21/26 1:16 AM, Jakub Kicinski wrote:
> > > > This is an AI-generated review of your patch.
> > > > 
> > > > Dunno if there's a reason for having this fixed by a later patch,
> > > > if not let's fix. I'm sending the review mostly because of the
> > > > comments on patch 12.
> > > Will reorder these patches... Maybe it would be better to send patch 9
> > > separately to net as this is the fix for the bug we found during
> > > development of this series.
> > 
> > Hi Ivan,
> > 
> > If it is a but in net, then yes, that sounds like a good idea to me.
> > 
> > Please include a Fixes tag if you take that route.
> > 
> Yes, it was submitted to net with Fixes and recently merged as
> 
> https://git.kernel.org/netdev/net/c/f3ddbaaaaf4d

Thanks, sorry for missing that earlier.

