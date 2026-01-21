Return-Path: <linux-rdma+bounces-15795-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GK6aEj2NcGkEYQAAu9opvQ
	(envelope-from <linux-rdma+bounces-15795-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 09:24:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE73E53757
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 09:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB3AF7C1D34
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 08:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7097A4779A7;
	Wed, 21 Jan 2026 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqWCvrLo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D813ACEF4
	for <linux-rdma@vger.kernel.org>; Wed, 21 Jan 2026 08:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983503; cv=none; b=BaYPD332RWTa02nlzbncjbhyNxFqkhGBT2x34gn4mOJAfY1DSmAU82hJYT6t3qH5AsUGd7OoJopju+IFIgFuzfqhsR6ofBSmBNhqTC/7jMw2XspunZauCK48EnMNpl1ek3m2wV5ZiRWNqmeYu9CVXy27ct6Bt4tW2dcwdLszCcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983503; c=relaxed/simple;
	bh=U343qNv7qbWMJcdsCcBtAL2GBFHc2bv4QbKCqd3eQqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b03tEdBstMxN8hLl7uksU2WzuNMoClrhPowgSwCyPB7Rt8QMva8K8fKYKGJ4ZjMo0BV9OLGihjPhPxi33UO1HxSsv/mgLyLKKp/YLAf6Gwb8eeLPpkdouX2isyHMnWI5c91qzgo+kYy2wufCZoLFWAs/ftZpgmpIxxypV4/QCkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SqWCvrLo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768983500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLjuYxOngZSy7JCsu6Pfdx7HjhY/QhYRMKePJQYZ+kE=;
	b=SqWCvrLoFy5uwjN9vj2nFJQzqIa+4P8tXYB6qLu35xmVskSqNJSeNeCOLL+6ZdNrIrxppi
	/iPWmcuxsngzPKwJT7gpxjkW1uwucqvHfrN6MoHNrDzolgYkTj/QerAXzmfYhOgaQLmJzO
	EKFnuTRsnmxtmn3YThqryRF7qfuJKNg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-218-VjNYMlmT1VsvIqeGiQ-1; Wed,
 21 Jan 2026 03:18:16 -0500
X-MC-Unique: 218-VjNYMlmT1VsvIqeGiQ-1
X-Mimecast-MFC-AGG-ID: 218-VjNYMlmT1VsvIqeGiQ_1768983493
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6F8E19560A5;
	Wed, 21 Jan 2026 08:18:12 +0000 (UTC)
Received: from [10.44.32.187] (unknown [10.44.32.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E467F19560A2;
	Wed, 21 Jan 2026 08:18:03 +0000 (UTC)
Message-ID: <f676c151-e871-4b2e-83f6-6d62bc146337@redhat.com>
Date: Wed, 21 Jan 2026 09:18:02 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v2,08/12] dpll: Enhance and consolidate reference
 counting logic
To: Jakub Kicinski <kuba@kernel.org>
Cc: conor+dt@kernel.org, poros@redhat.com, anthony.l.nguyen@intel.com,
 linux-rdma@vger.kernel.org, tariqt@nvidia.com, robh@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260121001650.1904392-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,intel.com,vger.kernel.org,nvidia.com,resnulli.us,microchip.com,davemloft.net,gmail.com,google.com,linux.dev,lists.osuosl.org,lunn.ch];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15795-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,dt,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: EE73E53757
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/21/26 1:16 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch.
> 
> Dunno if there's a reason for having this fixed by a later patch,
> if not let's fix. I'm sending the review mostly because of the
> comments on patch 12.
Will reorder these patches... Maybe it would be better to send patch 9
separately to net as this is the fix for the bug we found during
development of this series.

Ivan


