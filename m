Return-Path: <linux-rdma+bounces-17381-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oINjDxeOpWmoDgYAu9opvQ
	(envelope-from <linux-rdma+bounces-17381-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 14:18:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 428A81D9A0E
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 14:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8DA2530221F4
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 13:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644ED344D87;
	Mon,  2 Mar 2026 13:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="kP2OkOx1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212763E714E
	for <linux-rdma@vger.kernel.org>; Mon,  2 Mar 2026 13:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457347; cv=none; b=sZHHDfr28YukxJCXo2OpKNo4OtBMFTJ5iMBw6702+rZLqRAWVdRuygG19hvBJPqg/03pwRXXTBLIPhPGUx9omvHZi0LuS6x3AfzF1UyRuzcBRx9oiBKbUct723/oqyaQ98cK3E/GCpW+k1My8zfXGRKJCTFBnTPIBEV3e3kWiHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457347; c=relaxed/simple;
	bh=JV5gSZRhPiMnRwmWCCQiBvuE3NFV3+3iTTS8WPm+N7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mpd5GY+6Nc/o9uLOvwlchgXRmym4R9yPZAyO1BbtgzOoxPoER3mY7D8r04ScLu76OWdCt5EbFAc+IGQEAMaiuxZBsrTSPyREVGmq9AVQTwLpmeK04LTgUAe+YQBtZscH585K4Ymn/cJp7FYxFdeJR66gs6JMoUlgpeu2JbZLhAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=kP2OkOx1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-483703e4b08so39342345e9.1
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2026 05:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772457339; x=1773062139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DHkP/futS2zgWyQTyC5FXIesale6XSmEvAtzel8W+sM=;
        b=kP2OkOx1OGk8QzCJ6cnKlczbiViedPD27Ke1MImKIvKEN29UhPXB6cIS7krZpIPTg7
         UtmjFCmAQS32toy1Kky0VUYQ6nknRRVluwBbwXHw6cWEZNCVAgS5EELzDaqzeBLSo6Hl
         6MBO8HVZMvyD6PlHRN33vJ1DlYOmwGHcGRfuGiwe7PpC+cjWOvs5SOS4yXY3lDq7hvss
         zkaT8t/3Cam4w5r+FQXLTIz1sN4S7eEd1VX5QajWDFRjikohyMIelygNs2O2oH4ZYw0Z
         AUAaYJJMMI4yT+7+5mF04/q4qHGd5KDFQKS/68y4IqW0DIWdfkKgJUsDRnvSUoosIJpM
         kiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772457339; x=1773062139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHkP/futS2zgWyQTyC5FXIesale6XSmEvAtzel8W+sM=;
        b=duKRGFqWQWzfNKlQ0pgr2CSFmPUGUQDarVcQ5jrDD3cp4DJa+TDfPhGRLxLwxGcC/C
         9xwzmupGEC2f82DvKfCFNpxAn4j4Hu8/x8LrXj9Kd8uCKVaVLKkMT64Jz6E708OQ3yvN
         iraYYApA7C/tBlWtc+ojJW7lZlG2I9VTiqBskR6dOL1kTyGHfeEI59NkIx94nyAkThgx
         KJSWQVGHaQibwffU6nfCNFnnjxVe24BB6CbCdycnDC7OTLp7c6yyLlu3tndRWWSAZpU0
         ab1oDv3cxjgwfeEhhkLUMet/kjNvHE5enH0oqRo+2Xxgt1XMWzqO6NoBRCjLVNnFd1du
         c5Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUqEf4Z7nCd0wpr0PbzF9d/M+uWm7KQNt/UYxZEUQ5bSLaYhb+3Q6avoBXogVhuzvf0GFCb8SWVvJ8B@vger.kernel.org
X-Gm-Message-State: AOJu0YwxAInSPuZedkMfa06RKwKtkOQ8mlWifSpSI9P91E7IsbmZzD32
	IXoWb5kwow5/3d+z1KGJI98JiXICAQsKXURO2AwrE9hNJFkH5LJ+05/LNvzcA2k5kCs=
X-Gm-Gg: ATEYQzyAMLgAOkpfa3aLjQtSEayP15i6kgbc1X37Uv1eyC9COO8Qc+ufqMjkNIZShyP
	lXtFpxbA6HxIUEVOH023ct6KpxvLo3MWNzJrHX3Nk50MDPBkLDq/71vbEYLG/tscX7aiWHSKBz5
	WO72NAs9nz6qSRk/ko5Ck1S53vzWeiFfX8qqFcd7V00dXIJsMdff5A/J/WHoSH0ThtgWJ20mJ6i
	nQP4i6o4DPMcGuOknVQf9Y0GT/cfB9aXsjh3QKevI5LN/sZep/NXWIuXzk1uOe5C6enoUIvGlzB
	RY2aleOgZ8TZF6sNQk2ud8EWV7mQeWw+DDAigxCBmddBm+9uEr34xqnqivdCv/pJvW3s2V7FAdq
	+f9C+wnbFH2wNfh53ckfS8KNbSHZr7HUTAB0dfuPFAGyO+cS6o8gnhnNReBW2smd5tYRQ6uCL5b
	QW/fxzRhxXGzRhKe3T0/HdS7V+t3PGQMWtJSxdAAIpH9E=
X-Received: by 2002:a05:600c:a010:b0:480:4a90:1afd with SMTP id 5b1f17b1804b1-483c98dc373mr207220875e9.0.1772457339037;
        Mon, 02 Mar 2026 05:15:39 -0800 (PST)
Received: from FV6GYCPJ69 ([128.77.52.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b3d24dsm245616515e9.5.2026.03.02.05.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 05:15:37 -0800 (PST)
Date: Mon, 2 Mar 2026 14:15:30 +0100
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
Subject: Re: [PATCH net-next v2 07/10] devlink: allow devlink instance
 allocation without a backing device
Message-ID: <lkotihkrjr44jguht3cbj4kozxykqdzqedm7rm4cxuilsy76s5@mtuhatnluxgh>
References: <20260225133422.290965-1-jiri@resnulli.us>
 <20260225133422.290965-8-jiri@resnulli.us>
 <20260228150138.14e35ee7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228150138.14e35ee7@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17381-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 428A81D9A0E
X-Rspamd-Action: no action

Sun, Mar 01, 2026 at 12:01:38AM +0100, kuba@kernel.org wrote:
>On Wed, 25 Feb 2026 14:34:19 +0100 Jiri Pirko wrote:
>> -	dev_warn(port->devlink->dev, "Type was not set for devlink port.");
>> +	if (port->devlink->dev)
>> +		dev_warn(port->devlink->dev,
>> +			 "Type was not set for devlink port.");
>
>since I'm already nit-picking - maybe we should have a helper for this
>case an pr_warn() the message if dev is NULL?

Okay

