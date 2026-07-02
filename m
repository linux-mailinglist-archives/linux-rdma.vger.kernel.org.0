Return-Path: <linux-rdma+bounces-22728-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p05vG52nRmpibAsAu9opvQ
	(envelope-from <linux-rdma+bounces-22728-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 20:02:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F0B6FBCCD
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 20:02:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=RNTpvmkY;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22728-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22728-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D75D5302A727
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 18:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109D5381E89;
	Thu,  2 Jul 2026 18:02:03 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDE03655D5
	for <linux-rdma@vger.kernel.org>; Thu,  2 Jul 2026 18:02:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783015322; cv=none; b=UYdjRwI8+FL0V+NQdFEOrpRIqKY/rIm5zRghDZSuLA5bne/TBbRsjcLA0tEUEUE+DxRqf0jMxaF9M2PUwM2y1Uo28Xp1ULDFa0BVVIqeuYvxmTQvZnLsWcE0WR2jrlCovf3ooas07HVxeAhWGorvKgNruGvg8Tr1TUk/3GyLt5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783015322; c=relaxed/simple;
	bh=ryXwfnwmzvilPoFtnriI5o5NOSbeKJGglhDRqGukzNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCgBPzERkQE/bsI0rUKAuhVoEeNvFckoHyja02xSMERePURAmPd62jWAvo2cszKvClr4cpQ+g2TEcFP1/tCMZQlPDruzBVcdYgCOHy+cFQi0cf77Lsbm1ftp/IWAz2PvQIsYnATm09jqAvowtasjrT3MM8t7CZGA7EoLpnnEBIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RNTpvmkY; arc=none smtp.client-ip=209.85.222.178
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e5d6f35c1so173439285a.0
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jul 2026 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783015320; x=1783620120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L1pld1lccJdQzAvIFozrjpppwWB8wlZCZ/Ejvz9P54o=;
        b=RNTpvmkYsmLcAwOhCQfIbhuyNGAV8ugqeJQz5EXHVSdaQTKYqfC7R8S4aPOzPzU7aX
         g/0OQZzcb6/PI6riUQHNil6fQXPBO1yIj+Ei3YVbm6IJ9kCJmwvHj75ZOR8SBXW0V6pv
         8A5b9/J8N15/FR4T06FnSgt5L5oBh/dmqPwqJrvfzB3bSgyBzWj96JrkxP3wpctPxi33
         gf3XbZ3xP//HC5wdis7AY+Fv419A4ybW95eZPvSiCR1R2jvl1lvKEMt/XGv67xMBDCf8
         l6x/c/Rmrsq4VwB2FcJI9cS9LqTRnY4Rpmd/kjet7UmwDylYL5cRY9LQkBFc6MpGDZQc
         qvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783015320; x=1783620120;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L1pld1lccJdQzAvIFozrjpppwWB8wlZCZ/Ejvz9P54o=;
        b=ZSOj7uF+8M3vH7RCLDhXA0NbsizzsF/ToSBLSGAC6k9dfwWCO+LW1jA/0+pfvrd9zC
         zeVQVkljJYx/19n/NtK70GPe7V5hXggTV7iqMGwect0McrvGLA4ogizdVMMwysWsuGJH
         M0tsm8OCOHyIL1seZzj1AIzoq0mbHyNVsSAtSJc+5i+jYaMDMVyF5U8RJwhAkNJ/9fJp
         xgc08Z+a7ZP9UfsfYmh+L856LoI4MhkJNhM2t7rAgmiyXNyW07fl1da8Co+G2+atT+qG
         fktFvZv2wOQOeKyENEVvUIq82VCu8NQI4tiV5lgn+5IeS7PZnDw3KBg2hmWFKNokVELb
         chGA==
X-Forwarded-Encrypted: i=1; AFNElJ/zFR1t04M5soMzWL8NUt8fBjG5eJzP3OyxmxRJg6613yB5jdHa+PtfVw5ghWo1zjG5CI7jAtUXSNp1@vger.kernel.org
X-Gm-Message-State: AOJu0YwhJnc63RxGKpQJUrbG1CyOlr+0lXc+rdqJoI33ddNdCwlbYGUy
	Q9pQ+0wBW4REEdp5aIayKP89UDT9EP8utiTbez2Wd8z7xZDIJrRH4VlZXMcc6UtE7YQ=
X-Gm-Gg: AfdE7clIe/R9WcF15obHzUQHORwcaSBiVbkv+2AlhfiwdZvp/kWpn7syRRFVzJtCSrh
	Egqk8AHxObXMuoIftZ3L93CHM6+7cxHCtw5PqB8DNRSJ7vtmp3ZtvEY7dIta8P2UwKTw9OT8LcV
	D12OjVpJ69UnFUCdDYNoX348HBx0oDhaKAAJRAUFqhPfHROeFHFmI/5lFtFPI/sYDTLr7hRDGyF
	qep5tMlQOgKzUbIpjtVKwDicVrj/np1+ZXI2Deyt33U/Z/tnqmhH5uOGl6Vj6Q/QvbhBpzjnkwM
	5OGZPCIY951QZbnAsejVOE+DP06P4nFcSlij5dRFOGS1aO6XIZcEm60nQQrPy9UnxIz2WZtXLhr
	ngnE+R9/GXo+AeMGVerW5ibQe5Ti3fbJdcFyJGRK+4Al86MCAqXD7U4e9zvTql+QyN1kHBlmsq6
	H57kPx2IytzgXdc4HacZzihYdaq6nNmWsgbggIYmK5tKHm9lauK43a/CBYyYTJSRG74BY=
X-Received: by 2002:a05:620a:2913:b0:92b:6805:91bc with SMTP id af79cd13be357-92e785328f0mr924239785a.68.1783015320354;
        Thu, 02 Jul 2026 11:02:00 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e7ffdfe9bsm270647385a.5.2026.07.02.11.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 11:01:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfLja-00000006Onh-4AvZ;
	Thu, 02 Jul 2026 15:01:59 -0300
Date: Thu, 2 Jul 2026 15:01:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, shirazsaleem@microsoft.com,
	longli@microsoft.com, leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Adopt robust udata
Message-ID: <20260702180158.GU7525@ziepe.ca>
References: <20260623114444.1429042-1-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623114444.1429042-1-kotaranov@linux.microsoft.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-22728-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kotaranov@linux.microsoft.com,m:kotaranov@microsoft.com,m:shirazsaleem@microsoft.com,m:longli@microsoft.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ziepe.ca:dkim,ziepe.ca:mid,ziepe.ca:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0F0B6FBCCD

On Tue, Jun 23, 2026 at 04:44:43AM -0700, Konstantin Taranov wrote:

> +struct mana_ib_uctx_req {
> +	__aligned_u64 client_caps1;
> +	__aligned_u64 client_caps2;
> +	__aligned_u64 client_caps3;
> +	__aligned_u64 client_caps4;
> +	__aligned_u64 comp_mask;
> +};

I think Jacob has it right, This is looking pretty gross.

If you want such a complex protocol then use the new ioctl format and
declare sensible driver specific attributes. Nobody has converted
alloc_ucontext yet, but that is usually not hard to do.

Then you can use the existing mandatory/optional schemes to pass
whatever is appropriate with full easy compat.

So maybe split this part out, the rst of the udata fiddling looks OK

Jason

