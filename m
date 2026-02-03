Return-Path: <linux-rdma+bounces-16476-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMmlEwQtgmlFQAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16476-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 18:14:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B18DC963
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 18:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E23C230C271E
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 17:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB92C3D3D14;
	Tue,  3 Feb 2026 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rfchg3Dp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5A1335073
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770138510; cv=none; b=QNVPYcqy9XXPL+DN+4exlF+VP15lanz0d3irkqHnidPajjQicsPiHSfj++du3Iz6vA+Wuoadhr2nw1EtyhlvU8eTcAP2D7d3SSqeNxmsh6ElTw8eE+/aeuXdVvZUBLFijWizb+U/qP6AtZfAPBiw2dkOSxuL6ERXJjjNgl/IlX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770138510; c=relaxed/simple;
	bh=CJw53SBH6XoGayXbPlKjDAs1ctzRcBCG/jxmprupStE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhSioNzWIwvjnl5k12Cgfm7iFTGJzAAHxL8m+xDs4DajfEWxyRCGM94RMJcaEahO5a3z2g1JqqH1y+cH/m6PRX2rJrXpLHGQ8bBBCvWoKQTv1s3wvATG1npOyC/EPJROoL459geCih/c+oYttOSbilwiEdr29LO8nGtvXb07cpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rfchg3Dp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770138507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1RcqX9khIwUR/91ez7NLW9xW23Ib+VX9iSsMAWPU9Og=;
	b=Rfchg3Dp/4tERB0kZPp6QB+4HAmEnoRCBvPqh24ceAIpRuQ8bKa0vo/F/gKvzBuDnoJpve
	0VwwP03A2FjiBo3Lsrh6SQjt98OKszwCrT+FEKO2mo2dL7AES1Dy16N3hf0ieT9/oyN/ie
	Xy5BZxkOtCj6LnH8Bf3SczWJfZvd3DA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-VFWEBYhiOHOgNIjn6uCsUQ-1; Tue,
 03 Feb 2026 12:08:23 -0500
X-MC-Unique: VFWEBYhiOHOgNIjn6uCsUQ-1
X-Mimecast-MFC-AGG-ID: VFWEBYhiOHOgNIjn6uCsUQ_1770138499
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE2491956068;
	Tue,  3 Feb 2026 17:08:18 +0000 (UTC)
Received: from [10.45.224.28] (unknown [10.45.224.28])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0994F1956048;
	Tue,  3 Feb 2026 17:08:11 +0000 (UTC)
Message-ID: <fe7f81a4-281b-473b-8d0b-d04ff042d471@redhat.com>
Date: Tue, 3 Feb 2026 18:08:09 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v4,7/9] dpll: Add reference count tracking support
To: Simon Horman <horms@kernel.org>
Cc: richardcochran@gmail.com, arkadiusz.kubalewski@intel.com,
 przemyslaw.kitszel@intel.com, aleksandr.loktionov@intel.com,
 andrew+netdev@lunn.ch, pabeni@redhat.com, saeedm@nvidia.com,
 kuba@kernel.org, tariqt@nvidia.com, netdev@vger.kernel.org,
 grzegorz.nitka@intel.com, poros@redhat.com, davem@davemloft.net,
 vadim.fedorenko@linux.dev, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, aleksander.lobakin@intel.com,
 jonathan.lemon@gmail.com, jiri@resnulli.us, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, Prathosh.Satish@microchip.com,
 leon@kernel.org, edumazet@google.com, mbloch@nvidia.com
References: <20260202171638.17427-8-ivecera@redhat.com>
 <20260203161102.1894146-1-horms@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260203161102.1894146-1-horms@kernel.org>
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
	FREEMAIL_CC(0.00)[gmail.com,intel.com,lunn.ch,redhat.com,nvidia.com,kernel.org,vger.kernel.org,davemloft.net,linux.dev,resnulli.us,lists.osuosl.org,microchip.com,google.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16476-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A3B18DC963
X-Rspamd-Action: no action



On 2/3/26 5:11 PM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> dpll: Add reference count tracking support
> 
> This commit adds REF_TRACKER infrastructure support to the DPLL subsystem,
> allowing developers to track and debug reference counting leaks for
> dpll_device and dpll_pin objects via debugfs.
> 
>> diff --git a/include/linux/dpll.h b/include/linux/dpll.h
>> --- a/include/linux/dpll.h
>> +++ b/include/linux/dpll.h
> 
> [ ... ]
> 
>> @@ -223,16 +231,17 @@ dpll_netdev_add_pin_handle(struct sk_buff *msg, const struct net_device *dev)
>>   }
>>
>>   static inline struct dpll_pin *
>> -fwnode_dpll_pin_find(struct fwnode_handle *fwnode)
>> +fwnode_dpll_pin_find(struct fwnode_handle *fwnode, dpll_tracker *tracker);
>>   {
>>   	return NULL;
>>   }
> 
> There appears to be a stray semicolon at the end of the function signature
> on the line with the tracker parameter. This would cause a compile error
> when CONFIG_DPLL is disabled since the function body follows what looks
> like a forward declaration.
> 
> Should the semicolon be removed so the stub function compiles correctly?

Definitely. Will fix as I mentioned previously.

Thanks,
Ivan


