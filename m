Return-Path: <linux-rdma+bounces-15929-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEW8EJ6Tc2ktxQAAu9opvQ
	(envelope-from <linux-rdma+bounces-15929-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 16:28:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D494677CB9
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 16:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C411303264F
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 15:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC573081B0;
	Fri, 23 Jan 2026 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6i6XGfV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFF32BEFF5
	for <linux-rdma@vger.kernel.org>; Fri, 23 Jan 2026 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182066; cv=none; b=VbBEa9wTUoD2FTdSRdLtEd5hKFU+s6jCar0CQr9suV/f6axqy9c2fh686ABbSky4xY2AR7y3PP+K8TYQ6ZcMx35wVwgl68Jt7+EcA8K7SEuOqJFd770tPcOWrhwWSOfpK9RrrfHil/k/X3H0/lMRMkknMX3Pijq/7NuNXEXTwRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182066; c=relaxed/simple;
	bh=qz7AjDgsUSTxiTDTTRiaKom8lk+T8sxwozUMQWGkb9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0Pkt4cMJ3krDIGnPZ6pZBmYNr/QWaHoCVFuObe1c1z6RDI+V/B7Lvj3gEcffSCltO2r/wRh79fHCf2q/aCUOrQnuk9xS5Ax6gKK+KIfetS9AUrw0ZmX2xG1hXF5A0xvZxwMNVA/WmNmlagIpcD4cS2/kMep2xVLAn3qoPoRm3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V6i6XGfV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769182063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+56liWIY6rlDS8EqIYZo8N4mcFKH8UtPhn96TVJ+gk=;
	b=V6i6XGfVqxK1YyzRh0XKLOGJ5545I+wTRr4N6cqHD/WZQKltbaPwUdu2ZcqYIEgeeLGJP+
	6d1aoVWHSbkDfvt46vsf8ZOp/Ff1NHL7Ke609CGf1fR36mavWduV8QzN+ORtAVZwTiXLVX
	/3WD7u4Q3ApVrfL6N6Q0MJoYH2wCUeo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-rNxsUbaiMsWxSlRGkiLwwA-1; Fri,
 23 Jan 2026 10:27:40 -0500
X-MC-Unique: rNxsUbaiMsWxSlRGkiLwwA-1
X-Mimecast-MFC-AGG-ID: rNxsUbaiMsWxSlRGkiLwwA_1769182057
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B3AF1800624;
	Fri, 23 Jan 2026 15:27:31 +0000 (UTC)
Received: from [10.44.34.120] (unknown [10.44.34.120])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 613A71956095;
	Fri, 23 Jan 2026 15:27:22 +0000 (UTC)
Message-ID: <6da98781-9cf2-4756-a6b1-89cc650c9bce@redhat.com>
Date: Fri, 23 Jan 2026 16:27:21 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v2,08/12] dpll: Enhance and consolidate reference
 counting logic
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, conor+dt@kernel.org, poros@redhat.com,
 anthony.l.nguyen@intel.com, linux-rdma@vger.kernel.org, tariqt@nvidia.com,
 robh@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 aleksander.lobakin@intel.com, mbloch@nvidia.com, jiri@resnulli.us,
 Prathosh.Satish@microchip.com, krzk+dt@kernel.org, saeedm@nvidia.com,
 devicetree@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 przemyslaw.kitszel@intel.com, arkadiusz.kubalewski@intel.com,
 jonathan.lemon@gmail.com, saravanak@kernel.org,
 aleksandr.loktionov@intel.com, mschmidt@redhat.com, edumazet@google.com,
 leon@kernel.org, vadim.fedorenko@linux.dev, grzegorz.nitka@intel.com,
 intel-wired-lan@lists.osuosl.org, richardcochran@gmail.com,
 andrew+netdev@lunn.ch
References: <20260116184610.147591-9-ivecera@redhat.com>
 <20260121001650.1904392-2-kuba@kernel.org>
 <f676c151-e871-4b2e-83f6-6d62bc146337@redhat.com>
 <aXOMiAhf-NdQTonz@horms.kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <aXOMiAhf-NdQTonz@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15929-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,intel.com,vger.kernel.org,nvidia.com,resnulli.us,microchip.com,davemloft.net,gmail.com,google.com,linux.dev,lists.osuosl.org,lunn.ch];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-rdma,dt,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D494677CB9
X-Rspamd-Action: no action

On 1/23/26 3:58 PM, Simon Horman wrote:
> On Wed, Jan 21, 2026 at 09:18:02AM +0100, Ivan Vecera wrote:
>> On 1/21/26 1:16 AM, Jakub Kicinski wrote:
>>> This is an AI-generated review of your patch.
>>>
>>> Dunno if there's a reason for having this fixed by a later patch,
>>> if not let's fix. I'm sending the review mostly because of the
>>> comments on patch 12.
>> Will reorder these patches... Maybe it would be better to send patch 9
>> separately to net as this is the fix for the bug we found during
>> development of this series.
> 
> Hi Ivan,
> 
> If it is a but in net, then yes, that sounds like a good idea to me.
> 
> Please include a Fixes tag if you take that route.
> 
Yes, it was submitted to net with Fixes and recently merged as

https://git.kernel.org/netdev/net/c/f3ddbaaaaf4d

Ivan


