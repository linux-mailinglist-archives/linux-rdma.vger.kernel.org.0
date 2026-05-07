Return-Path: <linux-rdma+bounces-20119-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cG6CHEwt/GkrMgAAu9opvQ
	(envelope-from <linux-rdma+bounces-20119-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 08:12:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1EB4E358D
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 08:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1E5430054C8
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 06:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBE433970F;
	Thu,  7 May 2026 06:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ug8Wk3ED"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12F2334C0D
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 06:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778134340; cv=none; b=tr8dhP+FaZXlTJ7CN9YIBOg2SLizv3FLH6yt+c4FQjcRnjK1ze0MNYtsopc3HbYWTXnT4blfKYWxk9oimpzN/FsKSQu1QMypyCgB2y/S33ZECc+Crzp50ZVywZ1LA7WuMLJF0NCULaijQGV0JqcsOWd7c4WSQtiaQU7LQ7CYgw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778134340; c=relaxed/simple;
	bh=1zyYR98aRtky49y+0ToQ6v4Qbh4/TzygLpF1ZcyWWaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVfucSowIE+gzUmhrZfAfisMvgJWMCbC3byEENn0UarcegDQb631lk7Q8s40c3CaxTeKuin3vdO3Byp04tKmxOf37M+lxWnaiDKrVtKS6YUq/0zdS0CFqC6zqCqvPOL+GGHwEu+HIo97ejihNIxl/4JHgGnftbS4sYyhF4D7eQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ug8Wk3ED; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778134337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+7yZVAPKgBe5zd8mBYO+jhWo6nMd/MCriq7JgRzg1k=;
	b=Ug8Wk3EDqPwuOoyshtLFqLon8SzusP7ReV9Dpy2x2NkYBiOY89mWPISsyySpX4L2TMQTOM
	F5eK/bJmjSFuQgQNqBcgJTb2WMqcYY92rDLmp0Xeybennm4iCh2C//PhkUy8ebPBE2TBoF
	qou15w1bINqsCOCBlYeGn18YfNTSguU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-BtlojZnwMyiT6rXL9Gd5bA-1; Thu,
 07 May 2026 02:12:12 -0400
X-MC-Unique: BtlojZnwMyiT6rXL9Gd5bA-1
X-Mimecast-MFC-AGG-ID: BtlojZnwMyiT6rXL9Gd5bA_1778134330
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D41218002E9;
	Thu,  7 May 2026 06:12:09 +0000 (UTC)
Received: from [10.44.32.223] (unknown [10.44.32.223])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EDA93300019F;
	Thu,  7 May 2026 06:12:02 +0000 (UTC)
Message-ID: <541f767d-222b-4dfa-a95a-19a5ed7a46bf@redhat.com>
Date: Thu, 7 May 2026 08:12:01 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] dpll: add fractional frequency offset to
 pin-parent-device
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Michal Schmidt <mschmidt@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Pasi Vaananen <pvaanane@redhat.com>,
 Petr Oros <poros@redhat.com>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20260504155340.411063-1-ivecera@redhat.com>
 <20260504155340.411063-2-ivecera@redhat.com>
 <20260506183342.767b5fbc@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260506183342.767b5fbc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 1D1EB4E358D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20119-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,intel.com,davemloft.net,gmail.com,google.com,lwn.net,kernel.org,nvidia.com,redhat.com,microchip.com,linuxfoundation.org,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/7/26 3:33 AM, Jakub Kicinski wrote:
> On Mon,  4 May 2026 17:53:39 +0200 Ivan Vecera wrote:
>> +          At top level this represents the RX vs TX symbol rate
>> +          offset on the media associated with the pin.
> 
> Isn't this a hacky hack? I'd think that pin is in or out.
> Having a freq offset between two pins or pin and parent's
> ref lock makes sense. This new interpretation sounds like
> we are trying to shove a difference between two pins into one?

The "RX vs TX symbol rate offset" description is not something I
introduced — it is the original documentation of the
fractional-frequency-offset attribute as defined by Jiri. The -ppt
variant was added later purely for higher precision. This patch just
unifies the documentation of both attributes.

I'm not sure I fully understand what the original "RX vs TX" semantics
were meant to capture. Jiri, could you clarify what you had in mind
and whether we should keep or change that description?

>> @@ -299,6 +299,10 @@ zl3073x_dpll_input_pin_ffo_get(const struct dpll_pin *dpll_pin, void *pin_priv,
>>   {
>>   	struct zl3073x_dpll_pin *pin = pin_priv;
>>   
>> +	/* Only rx vs tx symbol rate FFO is supported */
>> +	if (dpll)
>> +		return -ENODATA;
>> +
>>   	*ffo = pin->freq_offset;
> 
> It's easy for driver authors to forget this sort of validation.
> We should fail close, so it's better to have some "capability"
> bits or something for the driver to opt into getting given format
> of the call.

Regarding the fail-close concern — I agree that relying on drivers
to check dpll==NULL is fragile. A capability bit alone wouldn't help
though, since the driver still needs to distinguish which FFO context
is being requested.

I can think of two approaches:
1. An explicit bool parameter (e.g. `bool per_parent`) instead of
    overloading the dpll pointer for context distinction.
2. Separate callbacks for each FFO context (e.g. ffo_get for the
    top-level and ffo_parent_get for the per-parent).

Do you have a preference, or something else in mind?

Thanks,
Ivan


