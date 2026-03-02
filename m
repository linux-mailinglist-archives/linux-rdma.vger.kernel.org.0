Return-Path: <linux-rdma+bounces-17364-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPzoLhZcpWlc+QUAu9opvQ
	(envelope-from <linux-rdma+bounces-17364-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 10:44:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6981D5B53
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 10:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 896C8300B475
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 09:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E1638F63D;
	Mon,  2 Mar 2026 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="g26/D8Jr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F5B32FA2B
	for <linux-rdma@vger.kernel.org>; Mon,  2 Mar 2026 09:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444660; cv=none; b=XZ++pp7DYVdn/I3Nk0zZ7qO9C+9CqnpixHK6N1/F6xQxkcEqNt5BVxrWDXBQ7yzQJB7o7j6P42OjJ+kaoo0UWOJUEweBuOk5KK2suh/fiR1eoM7NQ1T9/jzUMiN5KDQa5/0CVATeXHNZeewTQLxLqrAi5DMj3xn8dGtIyAZQ/UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444660; c=relaxed/simple;
	bh=EdtrS3uxbW5G3jVfOkaPkh4ppghbeIrW97LweZBsfrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZX0hOg0NrzfxrwH8JjFQw49B2YJ9PkCikHcp5uOecztYfG+ro1Et2H2l4tsm2U4dMot0CvTeG+vlvZ0S1jvSzOk/cxV3HDuMkpk1cNM+oJ6l/I368NWCPuwDuzHE8+iC7ydIzuqQ+2eseHUeNkgL5oolVnylPOqvSp1XL38SCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=g26/D8Jr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so48518585e9.2
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2026 01:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772444657; x=1773049457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tdsnQzzh+Lt1pkN+nCw9kSvCEoqVVH6yGcbrKgciEAs=;
        b=g26/D8JrTLqBOq3QvS83H/OXOOvyQ0pD8LUrvootV47cg41Do/SzN3FliMG8nhE4xV
         FlO+RaB/bE07zF9Q/idTt5hcuGHO6xUtiNiQ6mX1vYFKRUXvVLUPnh8BSBkVXVhCZeWY
         I5xYJsTXr8nO62C/nXP6qcONQzThRAZi4+Dp9+8iWDdFEZUSBugdX41qKKqIGFRjEnRo
         HQ3PZRrmtqZdr1x0zSeeQYF0V/stEwfSAv347dxuv8EklNJAB2XnnhtU0SxRMPxtzIpC
         YQwl7nOFmFlAflxkFH97EcparEMqew3GnnN2MvFUKwu09rmZJ5GWCI8e1HtloyXa4Frh
         oEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772444657; x=1773049457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdsnQzzh+Lt1pkN+nCw9kSvCEoqVVH6yGcbrKgciEAs=;
        b=SDfBNs0Wwr/KJh9rMr+OYDSlIUujZYv6/4lUjHtl1beHZf96pI0s0YJsKYz984B0rc
         jt7FENwKn+d1ec/BqH7hvnXlAmamenptim6MycBCRIEno0/Fp/pfjOyRmFtq6KwPm+Vt
         9k6vbj8zxg76/n4Jn2nCr09N2vj9BJkgyRhEyTtEemrx4o1XlwIoC1ohpoqq+ugJs3ww
         0tLvYeEEBr2ddrz2BPyBb4eWMlDV2qxVNVUv+QOh++WcbiDu0SVc4Zvlcg9d71wgQ/2w
         BhYP3rwaJ5J1I2bs7DyJlbLDVTem6va64qxVlejJPmHmLRMI5B4/atk7OzmUpVs9yMgJ
         sltA==
X-Forwarded-Encrypted: i=1; AJvYcCWtvPo0zloVzviRBs7i0X3RJH9w7GsUXVAFSMt+LNPbjV7yCNihcSsnQwX1xltELkte1L7oHBPOcsXl@vger.kernel.org
X-Gm-Message-State: AOJu0YwqjMa1eKoFdEEFCBWC4jJfO7WKQ+uM6iA6dJmSMCtHUnvT3h1T
	6Uz0lCGZrpbKQFPwIaG+iOGE8uoi+w8vMfGojZvKI7DZRy8Ly5eVMXsXqjfUuN4L33g=
X-Gm-Gg: ATEYQzzseDjYbd4A+e+EVcGwOJzSrJGtMooNnLkv1b4zrOywFBFdeTNSWsKfREWCmP7
	vSepyMvgpk6ttwQLhmfAitHzaNEw0xqSTF15xecxYw6sPAIpb7WEwml9CyD5hN2VBwtKf8+Spt+
	Z13K3EBZjVE5Esg2/VkPzGTfKhcdfq6Oa9uRHEHqHj2GBQy8onaW/4JJOGqSb5fr4NOn1jnlsFI
	4ZasxCzcXOhziVDc7JdeqXPggiDNY35mL9Z5udxDWtK9bY3Fq7QzsAuYiKX5aeJO2R4qsEpIlQ4
	skdaQt2E+5ZutZKUdbTnD+LHb7fEoRQzDYZCiR0dRk1Y5vlZ9t/zcBawWoNCnnDuITCbSd3WkAO
	ClrKppZPqJDN9jLzey0XBOMXMUS/1Vt0sQwjIIiPSr5w0EGu+PhCefehWPHEepaT0P6oM28NF5g
	bZ7YRwCMYxEWNqSYv5VhCgunv5Oec8jsY=
X-Received: by 2002:a05:600c:198a:b0:482:ef72:5781 with SMTP id 5b1f17b1804b1-483c9bfa529mr178963245e9.25.1772444657057;
        Mon, 02 Mar 2026 01:44:17 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb85c58sm127994325e9.9.2026.03.02.01.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 01:44:16 -0800 (PST)
Date: Mon, 2 Mar 2026 10:44:14 +0100
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
Subject: Re: [PATCH net-next v2 06/10] devlink: add devlink_dev_driver_name()
 helper and use it in trace events
Message-ID: <u46fbskiokav5y3mgleamlqoohpiyygnhgjyhxyouctwkfp6ig@tn53kspbmgbz>
References: <20260225133422.290965-1-jiri@resnulli.us>
 <20260225133422.290965-7-jiri@resnulli.us>
 <20260228145805.758ff8c0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228145805.758ff8c0@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-17364-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 6B6981D5B53
X-Rspamd-Action: no action

Sat, Feb 28, 2026 at 11:58:05PM +0100, kuba@kernel.org wrote:
>On Wed, 25 Feb 2026 14:34:18 +0100 Jiri Pirko wrote:
>> +const char *devlink_dev_driver_name(const struct devlink *devlink)
>> +{
>> +	struct device *dev = devlink->dev;
>> +
>> +	return dev ? dev->driver->name : NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(devlink_dev_driver_name);
>
>You say we need this in prep for shared instances, which is fair, but
>shared instances should presumably share across the same driver, most
>of the time? So perhaps we should do a similar thing here as you did to
>the bus/dev name? Maybe when shared instance is allocated:
>
>	devlink->driver_name = kasprintf("%s+", dev->driver);
>
>And then:
>
>+const char *devlink_dev_driver_name(const struct devlink *devlink)
>+{
>+	struct device *dev = devlink->dev;
>+
>+	return dev ? dev->driver->name : devlink->driver_name;
>+}
>+EXPORT_SYMBOL_GPL(devlink_dev_driver_name);
>
>?
>

Good idea. Will add is in some form.

