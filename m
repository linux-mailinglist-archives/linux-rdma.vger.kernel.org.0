Return-Path: <linux-rdma+bounces-17363-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEXgCttYpWnj9wUAu9opvQ
	(envelope-from <linux-rdma+bounces-17363-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 10:31:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 971301D592A
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 10:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6BA43025A7D
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 09:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C518338F622;
	Mon,  2 Mar 2026 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xxCY8N+f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE17329C5F
	for <linux-rdma@vger.kernel.org>; Mon,  2 Mar 2026 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772443857; cv=none; b=HKtvYeXeUZU1NXxhbYJodmAhGlldpWb31hd/qmLyp5oqqHjuOUppkZVc/aNf+vJOM26GpE0Q8E9mbuziFENYu2bxExIu5waAGSBcfp+HxM0hmLkyNcbrgpEyacSN9y7f1pRYNACkW1bJD1dURXLIjljbN6oK9+jVWzprW+lZR2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772443857; c=relaxed/simple;
	bh=SkQS32P2isxsZzN0Tpf5AFFSNZCHU5H1VsWyGV3O950=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+JxwhkT9/lCa9lSNxOzPiJlh7tE971pRJECVJlkkUWZ1XvSaFCQmnqrMu01Amx0XCS31MqdZRjzfdePZOnZx2UY0s5RE28lsWAjs4DAqToE8MLc2RKSHy5tUfusMTA28RYRM52zf9Gu/7c07z9WpmZebnUaJXrDmXijddzdJYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xxCY8N+f; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439b9b190easo285926f8f.2
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2026 01:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772443855; x=1773048655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9G+3cg9egGGuETeZt9ogez9f+d5U3nrYRpciNbV9ROE=;
        b=xxCY8N+fbsjMfrshhj4gYM+chOalJaRweaJrL2wTpoGwmLZlUbumL7awGab7yxbwRV
         0mUaxq4c7qj1jSTnk3EAuIK6lSDxxdADCvoZL53octj513wTDSnRi4/R5cdaOh0EHvX4
         DGk6gTh2QKF990FGOy3pDqZQXPQ4Eyp2TM2CNZXQXLZShRMd//Y2twlzATk7O5n9oQev
         vkpPyzwkB82N5P/erQPzm165G7oovxqcTaqbSTAprF205+73zG3jdrNDP9/h9iAZcnG6
         GEwT8qqD5tqVlJ8g2KjgdD0phbqxtqX6t2w5BM7ieSuIOuD9fLRS9AwTGY2Sghwz6Dno
         c4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772443855; x=1773048655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9G+3cg9egGGuETeZt9ogez9f+d5U3nrYRpciNbV9ROE=;
        b=Q+zBLSt2+0Ot7JCgyN/66jwQu+XKSCU3kgpFHHQfoaaRUb9O8g+3YFWxo7XAcjaGWp
         AOhbBIB54t/7jL7VH2le2KaRl4CFoSjhacC61av5HkVRL8VFKw2R0Xvj+A18Fco3DP/8
         r14CXAjFCbl3c8e/i1hEczwmYYtioYLNYfVrsA9NulGbn8EfROV8UvjD8iOp6Pb0Cy/H
         Kaej7ibtjqWItJ0i1wfVRiW9VTpehUGt+5rbb/tc5ZjFThYZWWZwXnV6iPtHHn5Y8Ftd
         JrxeJ0LJ4Dv5vQ/4g7RCnAF4GENHN5+ZkNd4U+Q8Y5tS7IRD48aBEC0fd23m/+YioFL5
         thLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxm6XAOALyOtvWPDKXWYR65efrsGn0wqu6MaFkg5NeY+GMhGVNzXxoz3uyN8yCwOFGsng1W9me473w@vger.kernel.org
X-Gm-Message-State: AOJu0YxWwLLURu35TrBbLckocz0lCUTJJhwiIFUE8ATGyK+sipiOY29c
	QpCGj90iKJ1mMsIO5BXTG2079p/pGThpXwTI1/B5lque6Toex0vJUXaB5P4hb51I00E=
X-Gm-Gg: ATEYQzzRGNLjkWvkKQj09llb+Tw57ujB3+wl5LY4sp/2LjDcjtTRuxJJPiw3fsmiYI2
	rToX3b1fF3SWL/q8/yE9OCz0gbm4laEbHmZ2o0ZoGcxV21duRZEOhVD9SPmWvd0uk5OPHQE9Z/2
	YjuW1GN6MwXcnxID6MNPAHsaoABRpi9fY3muVu9RxrJsOSkWp66ZI94k69Wne0nQwOZdsQwYqCg
	DzYzFsCz/32hXZEW2Q4tOaZH/J7u6grUih3LCG1gnoGAgRstUd2pFFlpXr8hMvUyAX0p3R/7N0R
	8oxHKk5x+xO2oPNRQJR5Zjc2kCxu78VID/ApAQCDe2713ZaFmyzq2y2BNYHiCImK35bLX5Tk+WQ
	0du+NOR5IGasclm6UgQFu4aTppZI1UEHhB9z5D2Cab/BbwOOGBi/aYw54kLLZJkk3EX38GGTQAO
	OpmcohD0H+snf7dfbZAZZiQ4wvmhEYfvU=
X-Received: by 2002:a05:6000:601:b0:439:9550:fc57 with SMTP id ffacd0b85a97d-4399dde551dmr19370651f8f.18.1772443854545;
        Mon, 02 Mar 2026 01:30:54 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439abdf5430sm15422817f8f.5.2026.03.02.01.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 01:30:54 -0800 (PST)
Date: Mon, 2 Mar 2026 10:30:51 +0100
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
Subject: Re: [PATCH net-next v2 08/10] devlink: introduce shared devlink
 instance for PFs on same chip
Message-ID: <cic5snbhrc4lvs5iyuddepj66nyttzpajgcjal4etqebjxlgqo@hwwtlbmczhr6>
References: <20260225133422.290965-1-jiri@resnulli.us>
 <20260225133422.290965-9-jiri@resnulli.us>
 <20260228150311.1a1ded74@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228150311.1a1ded74@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17363-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 971301D592A
X-Rspamd-Action: no action

Sun, Mar 01, 2026 at 12:03:11AM +0100, kuba@kernel.org wrote:
>On Wed, 25 Feb 2026 14:34:20 +0100 Jiri Pirko wrote:
>> +struct devlink_shd {
>> +	struct list_head list; /* Node in shd list */
>> +	const char *id; /* Identifier string (e.g., serial number) */
>> +	refcount_t refcount; /* Reference count */
>> +	char priv[] __aligned(NETDEV_ALIGN); /* Driver private data */
>> +};
>
>As pointed out by AI you promised a size member and a __counted_by()
>annotation :)

Yeah, somehow I got false impression this is not needed for priv. My
bad, sorry, adding it.

