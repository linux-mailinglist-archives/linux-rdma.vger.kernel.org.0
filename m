Return-Path: <linux-rdma+bounces-16500-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEiwCkzxgmmWfQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16500-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 08:12:12 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC269E28D7
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 08:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24D073022698
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 07:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C840D38945D;
	Wed,  4 Feb 2026 07:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="nrCTIdAB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365292DB79D
	for <linux-rdma@vger.kernel.org>; Wed,  4 Feb 2026 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770189124; cv=none; b=cE9tROhS094x1wOY00QsjNQD2HLF12C6CKEwf5KbsFn19UYVKj8BXYvbN1xqfUqf898JINf9AQ2QAP5rO7hwPmX6dlrarc/yXg6qOJAFubZ1p6Pvi90zndQONqRrmlF0FyZMh0f53qZ15v5EaZGVp5iOtHNfvzb2g19/hMpDVGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770189124; c=relaxed/simple;
	bh=i2gmBapXr7BeRcHIh6yZN89wQPgVWerFuKcVi5666t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZOzKEBxRRCge2sUJYf+4f9gBNWLgBe0FkBfCW+a+G5n/lOSxSdeH4ekAEp/3k/TXOoV02vHLQu6dJnbZNCYeJ9Mr7b4S3fOgCZ20QEwUd4eSmS3P13l8qPXT4CruSjZd/D8xPLnP6FFozTGhT6zd4HcKeTQUjw0egxOVwCWCBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=nrCTIdAB; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4801ea9bafdso2181885e9.3
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 23:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770189122; x=1770793922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sRhtrQ9/jhzrEfyf0zU6+VS4W6Vs4vnnpMJiEJhAMj4=;
        b=nrCTIdABlWzStCVMICGz7awLjOO+9UZnyaadW3I1z2UFc7Qg++Ql4kotKvZ3TU8BLB
         JhrTNOnjdFe++8hMp5uvfUU6H2HT24jRMLT8fPoRch4QdQz8yVe58F0jjIz7i3Wt33oN
         23jPohArNx1cRghEm+UEkz7baPSQ2JEJVn7JFqsUyy1w2XoH0TlaK0gH4wByDSatc/mB
         fUjwaUt+40Lgvdo4a7p2uK51zApMYCs2sRFtKi2PqG5tUInlrIECT/XaA0Zi1qM/J8Ef
         yeqxNSLulBoar3+VgdqMSdDhY2NDpJkQuGyxO3AMESaHfVBRSO+ilwpZqW6eK5p2bmU1
         IuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770189122; x=1770793922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRhtrQ9/jhzrEfyf0zU6+VS4W6Vs4vnnpMJiEJhAMj4=;
        b=v9gIeqBlZAvx5kgHLNqYr9+KEgcc+p1LIPhfM63jp1TfHIvvPmt8KwXYHnFmIqLjSs
         gWz8SS725yMwWEJy7mL9fePNzYwWjOSQ2zfVu/V5FVHbVLsHJr5ivOHkwfCplNvL0H9J
         tbdaThwddRvX/KKMWn/LYjoL52Weij9s03UTPS7SfYVSj2yVIuGjwFbUlx5M0uxKywlO
         Di0Es4v2dJpRDyeH2+FCDDUH+vE/4AkRGq1Zmqz/aFzYUzZW+39Z8JaSaeVmMYB2uzRe
         luNaXRtqEpwBHa3pTyroB9abZ1aw3KKVcESDzHJ6zDHHy6MvAEDOPXw8ErrjKD5lCD2O
         rVIg==
X-Forwarded-Encrypted: i=1; AJvYcCWllyxHFsc3BimOr7YM0ZwVu6lDJSAMLmMS1oniKXtJ9UwezeszOMbvbnhhM3TqNlncLYlEW7mu+rPh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw794MaIY3vitE1TS8d058g9UNeGgEX8CW7/VrAwMni8NIipGQw
	zvPB20S/W7CB5dZg3087rq9MT83kpBgfFG2VdW7pIvnEAUZQFwrjSbIVGqvDrmKbDl4=
X-Gm-Gg: AZuq6aLAoIP9Q3CBF6lf6sEtlB3vCw/0Ujcx+eFvZBXx6gZdqMaKOqDntvcajeQW4CR
	0wRFriYY+U0gKFDwKYYE6QoQEULk+fU8cLRr7GkeVAl3MoM4sovJu0bzQicrO0pjIundtsjMLWR
	/ePYHkBMmd0kICITvUBoRrNzBmzPDDaJ37V8CGbI9wWVJJn1Pf3omBhMSGbOY9N+cn518eZ3sMM
	fGV62MRla/myo8aBuPSERPWKeg/Y+YXI0mVJITXffYyLp4o9aY0R1u3HJbV+umw5ZSIz95/VHGW
	jGncYzQN90MJ/aNvowQzZ2F+fm2pRTUQjIuNAp3gNi/HdW+VTr9xl5c+EOdGWNWt+fbgCOPnW1H
	xWenL4TgMmA//HFb1pCzYVQ4zbH+UoG2NKhD5MjY6VyFJdY2T75qOeQUWAvBYD1HRZRPtURiQOm
	XPIcHzoIpRq38+3hH5argkvON5R6aBdq4=
X-Received: by 2002:a05:600c:8b30:b0:47d:264e:b435 with SMTP id 5b1f17b1804b1-4830e96ada6mr26786065e9.22.1770189122438;
        Tue, 03 Feb 2026 23:12:02 -0800 (PST)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:9519:b02d:f49f:3f52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e38ec5sm4645607f8f.14.2026.02.03.23.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 23:12:02 -0800 (PST)
Date: Wed, 4 Feb 2026 08:12:00 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH net-next V7 01/14] documentation: networking: add shared
 devlink documentation
Message-ID: <3edheaanzxgutuyryorfzlfjvizlorpj4y3ard5js7mp44hfii@4a36de6wazfd>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
 <20260128112544.1661250-2-tariqt@nvidia.com>
 <20260202194023.412bb454@kernel.org>
 <u7uicnxkcirhacpzjimss2pqsuhbngg4ticqrz45iqchkk2ha2@t3eem6w6hhur>
 <20260203190105.2cc28e71@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203190105.2cc28e71@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-16500-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,kernel.org,vger.kernel.org,infradead.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: BC269E28D7
X-Rspamd-Action: no action

Wed, Feb 04, 2026 at 04:01:05AM +0100, kuba@kernel.org wrote:
>On Tue, 3 Feb 2026 10:18:22 +0100 Jiri Pirko wrote:
>> Tue, Feb 03, 2026 at 04:40:23AM +0100, kuba@kernel.org wrote:
>> >There needs to be a note here clearly stating the the use of "shared
>> >devlink instace" is a hack for legacy drivers, and new drivers should
>> >have a single devlink instance for the entire device. The fact that
>> >single instance is always preferred, and *more correct* must be made
>> >very clear to the reader. Ideally the single instance multiple function
>> >implementation would leverage the infra added here for collecting the
>> >functions, however.  
>> 
>> How exactly you can have a single devlink instance for multiple PFs of a
>> same device? I don't really understand how that could work, considering
>> dynamic binds/unbinds of the PFs within single host and/or multiple VMs
>> passing PFs to.
>
>The same way you currently gather up the devlink instances to create
>the shared instance.

What's the backing device / handle (busname/devname)? Best would be to
draw a picture, as always :)


>
>> >> +The implementation uses:
>> >> +
>> >> +* **Faux device**: Virtual device backing the shared devlink instance  
>> >
>> >"backing"? It isn't backing anything, its just another hack because we
>> >made the mistake of tying devlink instances to $bus/$device as an id.
>> >Now we need a fake device to have an identifier.  
>> 
>> Okay. I originally wanted to use an id, similar to what we have in
>> the dpll. However I was forced by community to tie the instance to
>> bus/device. It is how it is, any idea how to relax this bond?
>
>Interesting! I was curious to research how we ended up here, found this:
>https://lore.kernel.org/netdev/20160225225803.GA2191@nanopsycho.orion/
>My reading is that Hannes was arguing against the _NAME attribute but
>both _NAME and _INDEX were deleted? I think there's nothing wrong with
>an index.

He argues for "stable topology indentifiers", which randomly assigned
index is not.


>
>FWIW using devlink day to day, the bus/device is not at all useful as
>an identifier. Most of code touching devlink at Meta either matches
>on devlink dev info or assumes there's one instance on the system.

Okay, what's your suggestion going foreward then?


>
>> >> +Similarly to other nested devlink instance relationships, devlink lock of
>> >> +the shared instance should be always taken after the devlink lock of PF.  
>> >
>> >of an instance, not a PF  
>> 
>> lock of PF devlink instance. I think that is what the text says, no?
>
>Sorry, I was trying to flag that using PF is not necessary great cause
>we may support this on other functions in the future.

You are right, will fix this.

Thanks!


