Return-Path: <linux-rdma+bounces-19907-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONMCKfZo+GkSuQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19907-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 11:37:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 452324BB114
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 11:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9EE6300D1C8
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 09:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1C137D133;
	Mon,  4 May 2026 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSuUtn2a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7167F37D113
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777887398; cv=none; b=Q/x+HWLV1jec/LYVp9BCgEWLp0vur1BncgIL4yzBhUAKXzrNRURA+wEqD4ylMAdet1ytQPOflr5e/VLtUj5W+Y+VZMwtI615Mso7rgoE160aF7iu73T+eMl8cbwl/FsTUfShb4v87Eq3ok14JtoLap3096vmqCnl+yjdJhWj39w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777887398; c=relaxed/simple;
	bh=TaiE6VPRhMdw40zBsC2LL5E3LA6Izko2YcBBVpykQjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V1aUcIPgp8BnGz7dEmOO072RprqKb09F2jFqaFGmZvxHQegzsTZCgjCjTHgkDDNd3TrPWGlkMkUxIA47dKI/hVA7gdYZOikGgXWBDLJXOCoAu9Vwz1vv4jgnUIQ5Tm2vErLPxzTNLFAf31nuyhlIjVY0G8RfFEE+ABIO6C7MenY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eSuUtn2a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777887396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nAq+++R2tX36PC5zxXCYWGZvvyeat8gPL+5FluYskoY=;
	b=eSuUtn2ad41pipkMUGKjszmwHCrUfaPsZuaBFtcjFmse0azFfG9nM7DPk3m1k7P4JysZZs
	v7hg5/P/KbZtccct22KCOnBGm2amY2ocuLfN5I9OSSNSVlcX88nOvCmlcntCTE0BP32Pd4
	5srOC60+Cn4FgzXlNuhkOYj+ousFaic=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-XpdB2FISPMCx6GsI_yi-_w-1; Mon,
 04 May 2026 05:36:31 -0400
X-MC-Unique: XpdB2FISPMCx6GsI_yi-_w-1
X-Mimecast-MFC-AGG-ID: XpdB2FISPMCx6GsI_yi-_w_1777887388
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEEF0195609E;
	Mon,  4 May 2026 09:36:27 +0000 (UTC)
Received: from [10.44.48.185] (unknown [10.44.48.185])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1FDE51800357;
	Mon,  4 May 2026 09:36:20 +0000 (UTC)
Message-ID: <290673a1-fb5b-4586-b44a-e109cc1a4629@redhat.com>
Date: Mon, 4 May 2026 11:36:19 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] dpll: move
 fractional-frequency-offset-ppt under pin-parent-device
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Michal Schmidt <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Pasi Vaananen <pvaanane@redhat.com>, Petr Oros <poros@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20260430173611.3312596-1-ivecera@redhat.com>
 <20260430173611.3312596-2-ivecera@redhat.com> <afhdCnT0ns-PgZD8@FV6GYCPJ69>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <afhdCnT0ns-PgZD8@FV6GYCPJ69>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 452324BB114
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19907-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,intel.com,davemloft.net,gmail.com,google.com,kernel.org,lwn.net,nvidia.com,redhat.com,microchip.com,linuxfoundation.org,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hi Jiri,

On 5/4/26 10:48 AM, Jiri Pirko wrote:
> Thu, Apr 30, 2026 at 07:36:10PM +0200, ivecera@redhat.com wrote:
>> Move the fractional-frequency-offset-ppt attribute from the top-level
>> pin attributes into the pin-parent-device nested attribute set. This
>> makes it consistent with phase-offset which is already per-parent and
>> clarifies that FFO PPT represents the frequency difference between
>> a pin and its parent DPLL device.
>>
>> The top-level fractional-frequency-offset attribute (in PPM) remains
>> unchanged for backward compatibility.
> 
> That is odd. The ppt one was added just for higher precision but was
> semantically the same. Now you change it. Could you still treat both the
> same?
> 
WDYM?

Keep fractional-frequency-offset-ppt at the top-level and add both
fractional-frequency-offset and fractional-frequency-offset-ppt into
pin-parent-device nested attribute set?

Thanks,
Ivan


