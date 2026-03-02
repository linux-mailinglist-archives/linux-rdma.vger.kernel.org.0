Return-Path: <linux-rdma+bounces-17367-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHfPB/JmpWmx+wUAu9opvQ
	(envelope-from <linux-rdma+bounces-17367-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 11:31:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D801D68AD
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 11:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F79730DC9D1
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 10:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084F739E6E6;
	Mon,  2 Mar 2026 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qejSHz/m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA1430BF70
	for <linux-rdma@vger.kernel.org>; Mon,  2 Mar 2026 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447004; cv=none; b=amgMbc5rrscfw80rdzwVio8SWxufnvpEL2kstK2dDbcyGNtdn3AX9dqaioOI6VcEgTSNTeYe+PrF7vUaQA1AVIVFiWrOLqEPiSP4qZh2x4eOjcLh+21k2r/QnEltkyi1Gq8miWUUtGY5L0VnoN4LHdcrSU9MbVj/oSwwoDM/UqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447004; c=relaxed/simple;
	bh=DxIjiuRLSsy1tFjfqwnUtZGdPPrFPa2emHdfIPwLGaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKUq//8CLnOJLqR58SJB46LfXBNAzq9if6Lw/Fe5Ne6wHqiIMfzvxCe7OfZy5VQNPcNePq5tKgbZdp6cRlRzUqtgOw/W2jkfs3biJSjhc/14s3tT5Un8XADf74lsbyjpGuARjNi7TTmAS/Llj2TmDbdpTl2UIOReAc6xS1BYauE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=qejSHz/m; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439aa2f8ebaso998021f8f.2
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2026 02:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772447000; x=1773051800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xyf5aAwmciBE7QFfA+/PpQQaPUYccIgX3fQYsSxVl+U=;
        b=qejSHz/mv7HaqVvybUq9mMdRh91/klcPbrp8m9TDyN6bXhHdCoYkRcI+r0+jbsLuON
         7V780DKi5GhyAkBytjq2KpvODxTn0X03VlsAQQpYS6py12jJWPQrJU7/rm3LBHu7lD7i
         UjCVZcSmmNp9mKBlkHOADSXgpl8s9AyI1yxAK1XFCzUbfbotkL1mOYOqvkD2AjRVQ+RF
         53EouXoHMx31/vSAx9ke/y4E26GeiroFmRLRGzYCSy169dWOQmA9ViMFPosIwtLRY8kX
         1mfWQ4UXY5lnssavO4yvfLH+vmR2Zt/3QzPiKwI8xtJiuEaxHRgMNv+JLyrRZdMDBTru
         SN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772447000; x=1773051800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyf5aAwmciBE7QFfA+/PpQQaPUYccIgX3fQYsSxVl+U=;
        b=uAKNmR2yz8DuwUzYVedqt/byIDiNA9voYfSOSx8OvgAiJaeVmPHZ0EMxeK3cfhis5V
         Xd26Xj7Lk1dZ2yn0ZUPQuLDONHoyZdwptgXHqd4RLFJgTkVM30X/nJO8/+W1xCfQiV27
         twApQxhq/31UATuVCJ24dEt9msK+Bt6ExYLYCE7ufoAgDYH5P+AZ5nEeoucZrMPq5IsR
         gm6HFqZYLSnY7nlmmDAF/MGcJsb1HZC7fukf7BCES0V2PFv/PFdAelocKvGjDw9hoh3A
         OUQ6jMY1ANQcE0m3Mkp9pcqGvh0Fh8jbQE4j0Y2hwhqwg9a7VAXWzLSp5HBhm21T0DEy
         /ocg==
X-Forwarded-Encrypted: i=1; AJvYcCWc9NqInQOQWCly4Lu2PZpJqLbyTIftz0YoSZN7RE8V+YXrpTCs3qD1EDAERIdaCTwCUO/apLeDodbI@vger.kernel.org
X-Gm-Message-State: AOJu0YxAc/SKTy+bLEtrzCG+2FbD943s9QaKXaQ1O2dRKH73ePaECYAp
	Ppnu44vgcjpo6hwAadfHSqNeRd34u88kOMnwqed9oW0i7CZ+266kUEtgkkl/lzhyovM=
X-Gm-Gg: ATEYQzytUb4VZllzYjS3TZCqtBNyV4otOuQ24EvTUUmdo4TbCLCQyBCNZFjY2fVp/3V
	AZ2fyFtxo/sCD0aBolyl+Rg9bbsmM4cy+IWS9tKuK3lHLK7GkbLCMurjfUr22EPVoy2mAI8/uAN
	GGizR0yh1KxLCWQgZu+gF5dh2mipnRYU/7yvFTfjkcPalTIW2z/xLVU0/dUwWLIfCCs/ZaVYgVX
	UUMr2/V2et93MjwVgIzxnJb9orQj5Ph2VORs8Cem8FgSV+7VffR+C7UH5YKdx4xxE8iZ6MJ83kK
	uvkQyH0IhGkQi0GSDEHuFXzkHk+xWBhSGVpg4GBYfayAGs66bDKRDznCGp8TeQ6dE6kHZEtFmb/
	La5+ngsYnmZF0KjzTUycEOXiWw5j/NaldQsutKiidGv4bHrpMBWpH8giolXU5eS2uMWv70BkIgm
	2wsLQBFJwLa8FfrNR+jcC60+yTD7ubP2Y=
X-Received: by 2002:a05:6000:186e:b0:439:b374:c6d3 with SMTP id ffacd0b85a97d-439b374c7b0mr7633629f8f.32.1772447000348;
        Mon, 02 Mar 2026 02:23:20 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b1116698sm12378754f8f.16.2026.03.02.02.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 02:23:19 -0800 (PST)
Date: Mon, 2 Mar 2026 11:23:16 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, donald.hunter@gmail.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, 
	mbloch@nvidia.com, przemyslaw.kitszel@intel.com, mschmidt@redhat.com, 
	andrew+netdev@lunn.ch, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, chuck.lever@oracle.com, matttbe@kernel.org, cjubran@nvidia.com, 
	daniel.zahka@gmail.com, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 04/10] devlink: allow to use devlink index as
 a command handle
Message-ID: <onwmw7ql5g2xqacrqnawcphdlzfu5v5ohgslsbvoeraszm7m4m@2ywv2ql37wu7>
References: <20260225133422.290965-1-jiri@resnulli.us>
 <20260225133422.290965-5-jiri@resnulli.us>
 <20260228144846.40f5dfeb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228144846.40f5dfeb@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17367-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35D801D68AD
X-Rspamd-Action: no action

Sat, Feb 28, 2026 at 11:48:46PM +0100, kuba@kernel.org wrote:
>On Wed, 25 Feb 2026 14:34:16 +0100 Jiri Pirko wrote:
>> +	if (attrs[DEVLINK_ATTR_INDEX]) {
>> +		index = nla_get_uint(attrs[DEVLINK_ATTR_INDEX]);
>> +		devlink = devlinks_xa_lookup_get(net, index);
>> +		if (!devlink)
>> +			return ERR_PTR(-ENODEV);
>> +		goto found;
>> +	}
>> +
>>  	if (!attrs[DEVLINK_ATTR_BUS_NAME] || !attrs[DEVLINK_ATTR_DEV_NAME])
>>  		return ERR_PTR(-EINVAL);
>
>If both INDEX and BUS_NAME + DEV_NAME are provided we should check
>that they point to the same device? Or reject user space passing both?

I implemented reject. I don't see much of value of allowing both. The
code that would do the checking is too much for this hypothetical case.

