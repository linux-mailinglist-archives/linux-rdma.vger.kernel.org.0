Return-Path: <linux-rdma+bounces-19212-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IF1fD+Yh2WkqmggAu9opvQ
	(envelope-from <linux-rdma+bounces-19212-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 18:14:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 365E83DA36C
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 18:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C8D23038126
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 15:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15533A3E86;
	Fri, 10 Apr 2026 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VuSfqimM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5833CE48F
	for <linux-rdma@vger.kernel.org>; Fri, 10 Apr 2026 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835810; cv=none; b=gZDSGk9VONHugkn6vKB7LRnxzEcO4GYLm9RQHQcw2RCAlauBbHApsuEH0GXCNcw3J8wgDoOIWf4mTsh1/3WW2VtX/T5WjOrRYSTKVg3mDlhMgW2ZmyZrbOcK7zE4RFexA8IMkh6GDxphKrsZJvNKmdGdn/v/SY5DDIlFul7SOLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835810; c=relaxed/simple;
	bh=15c4ee0axhyY9xh/M09tb/QEQ2DqSdy7iBQH6Onsn94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpsFwjc3XTEBORt/K0j6yhwaY7YDtYzH+HftMYOoVz8OSRMRHaLKgIvVg0X5+prOVWzapVlFbUvZOmlKj1s9ty5akhAoZNxnRBqEIqdl9Q0YEF+fVSHqZ7eXMbuuHusAQA+oUMTxcLfv+Kvv1uG0E+YCRnm7ggnkH7KbzmvJImU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VuSfqimM; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50baafd6c4aso22277141cf.1
        for <linux-rdma@vger.kernel.org>; Fri, 10 Apr 2026 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775835808; x=1776440608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=15c4ee0axhyY9xh/M09tb/QEQ2DqSdy7iBQH6Onsn94=;
        b=VuSfqimMCZK642rs+v4jbhfAalGWZ1ko3jrnQrP0Hmwe3J6KBNE0VMWXPO0R9BCWcR
         djvQbOzYVJ75uzuM8VDI0Xsl+i/rJb60uY/hg/na1X8+aYrVQ9TUOuuIrBHu/U/bsobq
         JDUBckPVm60udk67/AELLoxZwbj/iM7EUsrGa+57s1X12HBJPeSeKPsv3n6MKYALHkLc
         Vl8kt5EamiRkX4LNuMUSbhVV3rT1agQF4e1cmWdyijO3gNtH1Z39QUKWAKQVzZ55cO++
         S8/oBCkWXS0JVqQlMZ8FTlPXePXMudCUD5OxEpMuHRC7328WNNDbBvsMUBu8WQFQIoj7
         dlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775835808; x=1776440608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15c4ee0axhyY9xh/M09tb/QEQ2DqSdy7iBQH6Onsn94=;
        b=Gx75yoQrWAGInK7NIMf2mgXgbIf8gnBswZhL6QSwHbiBP7g9F7W6LRC4gLw5Q8g7UA
         8x9glSEq9/RuHLZU5xNlFs/R7dmcG2cXKgbyrcKGoT5WWqR2z4orURP4mmy3oVSo0zgn
         lCipYjBAhJnDmFweg31+cEiN5KD6/Kw4AUgA/lfkxvumITfLD+UXTo/WAlHB/JyoxqbH
         sznJzbiimydQV6ygK9tFgt68Zr8W72Mh2lGiKHwZlkAGSfh8yZzHk5iwDGJtttxeA15T
         QZeP9sP2RFjRv7jNBg2Y1MSG9x9h6uogvDGA+W483qn88yXxmLDJpDGZy+sR3KfAlJW5
         kvRw==
X-Forwarded-Encrypted: i=1; AJvYcCXzs0J3FZYCdoXMZ2QAlJ++LTpqUG7jdynTekdrxiyudMkLYqikspKYc3KfGnqMfWUeoeDq4D9kOXcV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9QWwjah5j1/ws1uEMwhj3+qq3nuvyufIZ3AneWFGaEWlpfrPW
	96w6KybHQKJNh5uBsoKfTjAkHX+V8PGUDxX3WjHbKabiiFY2yVJCHQufh5vQiFADA30=
X-Gm-Gg: AeBDietqMDiuWsSKW7xaj6Qj51AyTACR0KyCAXkFJn/zQKXVZKqOoH6pmTUsG8XQRe4
	mO9QdpFRyou+ll82QCL9KfwvX6dqLr1bax2f34/P/lCtg29Z5aPH+qYvPafJYPwbd7/SYNterHZ
	+rYSXJgMJbjuoPjwLuiD7rYC63pAUTyZMu4MHvwXPIc1SX/5owXD4D4nFsx4WuUEh0udzf5JXqn
	TV6YQzHWuyAgDHoQJr99BINiIqQ2QBTFwTj7CNQGCXkj353md85MJ+4CTnArxHZ384QrvOAdXnn
	TTf42o5qh7K+F/jCQtGhP+39kI4+fydP8YfKNyxdxk+gvQnga4M5D8qs09Cw2EQKIChUPEemKE+
	0It2BFHD4Yh9aFGDym8bUNUKBwp9Z7CgnEYJKCjsfRfB5ABpvpE0jQ5U3SDrOpEsREOaCuEx/vD
	AXFXsYg3UlYT7wVteHMqxY84t6ogK2v0daVS0VacnQLIWZlTOtvp6f/vNB9xN6SfhOiIOCCw==
X-Received: by 2002:ac8:5a53:0:b0:50d:5a11:1a8 with SMTP id d75a77b69052e-50dd5ba3952mr57073421cf.25.1775835808064;
        Fri, 10 Apr 2026 08:43:28 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd539b49dsm25682421cf.6.2026.04.10.08.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:43:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wBE11-0000000EiT7-077R;
	Fri, 10 Apr 2026 12:43:27 -0300
Date: Fri, 10 Apr 2026 12:43:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Long Li <longli@microsoft.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH rdma-next v2] RDMA/mana_ib: hardening:
 Clamp adapter capability values from MANA_IB_GET_ADAPTER_CAP
Message-ID: <20260410154327.GA2551565@ziepe.ca>
References: <20260312181642.989735-1-ernis@linux.microsoft.com>
 <20260316194929.GI61385@unreal>
 <SA1PR21MB66832D25A93394735624F454CE40A@SA1PR21MB6683.namprd21.prod.outlook.com>
 <20260317094408.GR61385@unreal>
 <SA1PR21MB66833EBAF447BA0B102862FCCE4DA@SA1PR21MB6683.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB66833EBAF447BA0B102862FCCE4DA@SA1PR21MB6683.namprd21.prod.outlook.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-19212-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[ziepe.ca];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:dkim,ziepe.ca:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 365E83DA36C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 12:56:39AM +0000, Long Li wrote:

> How we rephrase this in this way: the driver should not corrupt or
> overflow other parts of the kernel if its device is misbehaving (or
> has a bug).

If we are going to do this CC hardening stuff I think I want to see a
more comphrensive approach, like if we detect an attack then the
kernel instantly crashes or something. Or at least an approach in
general agreed to by the CC and kernel community.

Igoring the issue and continuing seems just wrong.

This sprinkling of random checks in this series doesn't feel
comprehensive or cohesive to me.

Jason

