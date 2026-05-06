Return-Path: <linux-rdma+bounces-20089-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J17NghS+2n+ZQMAu9opvQ
	(envelope-from <linux-rdma+bounces-20089-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 16:36:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 745914DC515
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 16:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E86723034B1C
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 14:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892304657CC;
	Wed,  6 May 2026 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="WE4ApCiK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45832C21D9
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077955; cv=none; b=YTn5VOgLXQQbmnoNYu9OLNUQYe73hbe+SQwnZy1/e5A/cPgsPoENOk9XiMZQ5Q3Ae21r+YryyX+DhsUdjG0LD3u7O2rOVmbxTleGEB+4MSa9QA0W+AiD/Ypy9UWvZT+wPhJzfAJpggVdTEm3n0OOs4fZzNA84JZgKFGsWBR75r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077955; c=relaxed/simple;
	bh=acpxXy4xZJqrgFFB6+zduf5tuNxkeOl7e1WyZhRbkPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6+K50qXE7DDB7Y5cefntEBQbIHtD+6+g/EC7LDKf9CJUMDLEDYZDIGsdwZ5r72ajGG29isqeBG+N+3QmaNPtRW0SsFzJUgcyiMIFeiMC7CmyXjSFEFJ3ds86b5rJXO33kV+Q4wGlinJ3FoPfXBgQHoAXBG4HN1MVaSxKXA9pq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=WE4ApCiK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso58183555e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2026 07:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778077952; x=1778682752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BauXOWgQwAdyupYUeYpEdkQ1i1e1EvpLEkDyfo36sjY=;
        b=WE4ApCiKjxHcUpQWad7uc04eWaarBdIziv8bNF3TVFti5jkBpmamlCyIVzArcHyx0d
         KprC5dGb1qNwdBhRgFU+6mIrJ6RpCIr/ilmyT3PmDgn5E5t/bbku67luX0o3XDMio30V
         c62fTUdwThE7eHvj9KAla9Tz22f5Rb9/WkKSWUNFE8zQort3wopuliUt5IGJYC45yG3L
         DccQpEIaD96EHOo65/GN6QBkO3l72ed5qOpH0SH/bpYVR5nmuXRC4wCgjBfioxmedAEq
         mTfKbuirZqZtSFeWoxRGemEeAKuR1efs6GSoNrmSAV79h3XCQpwCd9hjrJqDB+n8J/1G
         pqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778077952; x=1778682752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BauXOWgQwAdyupYUeYpEdkQ1i1e1EvpLEkDyfo36sjY=;
        b=TdmDtI1RCkju7sDcvEqbh4S3MxhNmMezIwexC5Q8zEVsD3jb6cGrJkaHIaJsr0UdoS
         UMbo+jo1VskfPgkRdK0NqiXf27Qftt1360zBor7zB0Hd+5szXm5JlZBFCQ3l/FGrOa7W
         4dYrzj9YbFMdgwCxrbIr3mZKiFzucRDlEOuseUsRS9Pdu677XXcTCOdV+mxd0qyaA7Yc
         aTpu0S3Y0tM25K4pivIjHU4z1PJi+UUTmQZ3r3+16aDivnWkVLfiu8osLEKttmnypY3K
         HzpBT5c9uN3H2gHJqd2YVGkSw+og8E+DhF15knPjOGZBJtpobbRvYy7S6pTXTQ/LxxnL
         1FZw==
X-Gm-Message-State: AOJu0YyAKnHmkNcpcUCzIw29dywO4dOsBvLBUG3DK9WLKrX6DIQwJRMO
	djgcJpy5i+HSmC60UOBam6sEvq7eZAwS/WPyN6ucvPFR4n0BZTa6rl6Rp9I7ARbOZws=
X-Gm-Gg: AeBDiesJL555V1ZwpOBP5Hf9kHj5c8huS8jPT7KkAPy79GMQsj+jLHC0LvgNMMNbaNY
	xZqHmuKSG/QlBkr0LBgNiykwtcQlqYThodGhop2Q5Pbf9f0Me+7n7Dpbw9DEm54EWTKj/X2Fp6d
	nVWOlGMzYpJIdF8zUfJJbKWyZYF2VV9jINwdTjrrbVvpPcvd6vL0aiR75EVsSG5OJ/yBlaWWM6j
	qt0SveW9nzbJ6rMhixsGa9MIaxqteTiHQ0+yzeTe1Pi+iqIBDMWFyLGZC3QnUm9c2jqbbclagNX
	hE/epx1vZT9+gEwCWXive2k0TTnT2Ds0/TEix9jcBh4IdOrh5lEo1Fkme7/Nf3kd4J3BkvYbbyc
	el76sBvn5cCLb1XkEbdKzy7pue+NDXS7eF14jpYeXJOa6yrfgszLXdV+dE4UOoYxGOkqeCU4n4V
	082FSHVtSn7edKiTouvK7857rNqy+CCDkpgP1e4Macd+T3WF4g90D6rQ==
X-Received: by 2002:a05:600c:4255:b0:489:1ff1:74df with SMTP id 5b1f17b1804b1-48e51e0c818mr33458725e9.1.1778077952007;
        Wed, 06 May 2026 07:32:32 -0700 (PDT)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:8c0b:afdd:3d9d:e976])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e5389da63sm50973885e9.4.2026.05.06.07.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:32:31 -0700 (PDT)
Date: Wed, 6 May 2026 16:32:29 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com, 
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, mbloch@nvidia.com, 
	yanjun.zhu@linux.dev, marco.crivellari@suse.com, roman.gushchin@linux.dev, 
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v3 08/17] RDMA/efa: Use ib_umem_get_cq_buf()
 for user CQ buffer
Message-ID: <aftP2M52w-9k7ck9@FV6GYCPJ69>
References: <20260504135731.2345383-1-jiri@resnulli.us>
 <20260504135731.2345383-9-jiri@resnulli.us>
 <aftHa2trKKlO2c3v@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aftHa2trKKlO2c3v@ziepe.ca>
X-Rspamd-Queue-Id: 745914DC515
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20089-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ziepe.ca:email,resnulli-us.20251104.gappssmtp.com:dkim]

Wed, May 06, 2026 at 03:51:39PM +0200, jgg@ziepe.ca wrote:
>On Mon, May 04, 2026 at 03:57:22PM +0200, Jiri Pirko wrote:
>
>> @@ -1172,26 +1174,29 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>>  	cq->ucontext = ucontext;
>>  	cq->size = PAGE_ALIGN(cmd.cq_entry_size * entries * cmd.num_sub_cqs);
>>  
>> -	if (ibcq->umem) {
>> -		if (ibcq->umem->length < cq->size) {
>> -			ibdev_dbg(&dev->ibdev, "External memory too small\n");
>> -			err = -EINVAL;
>> -			goto err_out;
>> -		}
>> +	umem = ib_umem_get_cq_buf(ibcq->device, udata, cq->size,
>> +				  IB_ACCESS_LOCAL_WRITE);
>> +	if (IS_ERR(umem)) {
>> +		err = PTR_ERR(umem);
>> +		goto err_out;
>> +	}
>> +
>> +	cq->umem = umem;
>>  
>> -		if (!ib_umem_is_contiguous(ibcq->umem)) {
>> +	if (umem) {
>> +		if (!ib_umem_is_contiguous(umem)) {
>
>This is a little funny, I think umem should not be NULL?

Yes it is null when there are no CQ umem attrs present. That is
perfectly fine flow.


>
>I'd rather the ib_umem_get() not be called if the op is in kernel mode
>(this is user_cq so it is never in kernel mode so it should never be
>null)
>
>Meaning return a valid umem or return ERR_PTR, never null?
>
>The case that is now NULL should be EINVAL (bad system call arguments)

I was thinking about the ib_umem_get() return value scheme and went back
and forth multiple times, I converged to PTR_ERR in case of something
went wrong and null in case of attrs missing, which I believe is the
best option. It is documented in ib_umem_get kdoc.

