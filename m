Return-Path: <linux-rdma+bounces-21069-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCZsOTpXDmoZ+AUAu9opvQ
	(envelope-from <linux-rdma+bounces-21069-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 02:52:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA14359D6B7
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 02:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24C63303E6E1
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 00:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C421B282F2E;
	Thu, 21 May 2026 00:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghTK2IBp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D421FBC8E;
	Thu, 21 May 2026 00:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779324724; cv=none; b=U5fie6B42w2+Rgaz8qKbnB044e8jF3KBwT1piQ8/wjg3ao99ts+8SFShvhrvGekqD9xult25udar2MOdE2FJ0coFP6QJuuk31dwhJdXMZbbeDQ6qaaFWe9yFvGhtftthmqXtecLSFNKGGRpxkoBSLhAbjQtLz234LY4+rkSwktc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779324724; c=relaxed/simple;
	bh=0h8wPzuzQpZ8z1x10Rb60RolLFxBTq7HbTJVXVGGVq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pb5b1Z1Jog2JDbvG0m8W+Jr6Jdp6n9h/VptxnoeH8IrbmlNjwVCZtg6vlT1z0c1mtUQqmw/EcEYzk0earzo8q4TtvOl9W9XcWXummvBofc5cV3EdjEXphJvhxWofzJPWbGU1q0qcU/YMR/7Ng0kBS1gGnJVzYqGtRtBwLxZRYw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghTK2IBp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C61E1F000E9;
	Thu, 21 May 2026 00:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779324723;
	bh=0h8wPzuzQpZ8z1x10Rb60RolLFxBTq7HbTJVXVGGVq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ghTK2IBptqISG1fbZS68Q0JjFIdq11dXJk9cP9cHTbk3ZcWY7wZ0knrb913G+R4Q1
	 7mO6e7BljqldnK0pztksV+w0M840TbR7H3hszi6C7J51x+Ncw6uSMBzsjuj4jktEC0
	 XqRycisI/Ms+B2rtJ1Lwl3NmtHNJlNroe108HDUPBGdIWejNWcK6PVDetaKtH314Rb
	 MVKdrWYqOK76xBgSRdOQLzLTp+mVuX7Hg6Lo5N2JbXs/MUuRasXdZEXVYCbH8MDx4g
	 O9wNEtf432pejoyQUPIHpFHeDqzmA5JFP0+V123sk8G+4Vz8Oksi4EtP4rEL6hua0h
	 SCOixD6/7S21g==
Date: Wed, 20 May 2026 17:52:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, larysa.zaremba@intel.com,
 przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
 sridhar.samudrala@intel.com, anjali.singhai@intel.com,
 michal.swiatkowski@linux.intel.com, maciej.fijalkowski@intel.com,
 emil.s.tantilov@intel.com, madhu.chittim@intel.com, joshua.a.hay@intel.com,
 jacob.e.keller@intel.com, jayaprakash.shanmugam@intel.com,
 jiri@resnulli.us, horms@kernel.org, corbet@lwn.net,
 richardcochran@gmail.com, linux-doc@vger.kernel.org,
 tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com, jgg@ziepe.ca,
 leon@kernel.org, linux-rdma@vger.kernel.org, Samuel Salin
 <Samuel.salin@intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v3 01/14] virtchnl: create
 'include/linux/intel' and move necessary header files
Message-ID: <20260520175201.72f83c4a@kernel.org>
In-Reply-To: <20260515224443.2772147-2-anthony.l.nguyen@intel.com>
References: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
	<20260515224443.2772147-2-anthony.l.nguyen@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21069-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,google.com,lunn.ch,vger.kernel.org,intel.com,linux.intel.com,resnulli.us,kernel.org,lwn.net,gmail.com,ziepe.ca];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AA14359D6B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 15 May 2026 15:44:25 -0700 Tony Nguyen wrote:
> include/linux/intel is vacant

I don't see any other vendor directory under include/linux
and TBH I don't want to be the maintainer making a precedent
for this sort of stuff. include/net/intel is a better choice.
Or rather, at least its in "our" section of the tree so nobody
will complain.

