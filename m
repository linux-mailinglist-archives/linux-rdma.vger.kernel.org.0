Return-Path: <linux-rdma+bounces-12691-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF27B23C22
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 00:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF10E6E4388
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Aug 2025 22:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583102D839E;
	Tue, 12 Aug 2025 22:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="o/sb8rdE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B016D2F0687;
	Tue, 12 Aug 2025 22:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755039523; cv=none; b=pCMIwxhLN5WpW9CVIOkzjwEjLmHYczusZAMybc+tEtaIPTSc+vMWXyqd+wu6fVw92JYgLXptIEco3q0M6uMvz2AZVKpWgbSf+6Qwo7BAUfb/Gaajj13MIayO8kX89y8Ro3c40bj+NhSZ+JHrqmspts/BugA/vvR4bzIJ0sNTFm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755039523; c=relaxed/simple;
	bh=c5wIvRsHH6NplQgIz+eG25/anOn9Ayu1UiCTJfbBmUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4vmtnOH2Is4qbzZe9toqEwhWCh554C/KkV3RqIKnXm14ZNaSF7X4s9q9UiqzowNJoOzoiTKP6u/MExVv5dmP5DfkIjPvaPdqbUGyChUWnEysmkYbs3ixJQlro9OZ5Vb22szdxbsoE+kL7gFnGEYul5ncWUY8xQv5UD6Ml7l5Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=o/sb8rdE; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755039516; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=UcolkVCFbOAP21EO5gwx3PoeaTXRI3Dl95PXbJOBeG0=;
	b=o/sb8rdEtGjOoj7n2AWNL9oc7+I5VKPrY9GnLsYptulkevVCyGuz+CFJFWJN3QQLzoVULOfvjnTBJhqK26u1GluRtTfoKdKfTjt01Oh/wkzilLcDEPy+WJzEnHgVcMS/JDnEYcpkZ3yrSNdv38Yg7iylXkRhCpLfeKtbgppDiAw=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0Wlcu5xc_1755039514 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 13 Aug 2025 06:58:35 +0800
Date: Wed, 13 Aug 2025 06:58:34 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, Halil Pasic <pasic@linux.ibm.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [RFC net-next 10/17] net/dibs: Define dibs_client_ops and
 dibs_dev_ops
Message-ID: <aJvHGi9O0ReoDHFo@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250806154122.3413330-1-wintera@linux.ibm.com>
 <20250806154122.3413330-11-wintera@linux.ibm.com>
 <aJiye8W_giWiWWpI@linux.alibaba.com>
 <37bc0a65-247f-4ac3-bb03-b1d2cdcaeccd@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37bc0a65-247f-4ac3-bb03-b1d2cdcaeccd@linux.ibm.com>

On 2025-08-11 17:12:46, Alexandra Winter wrote:
>
>
>On 10.08.25 16:53, Dust Li wrote:
>> Hi Winter,
>> 
>> I feel a bit hard for me to review the code especially with so many
>> intermediate parts. I may need more time to review these.
>> 
>> Seperate such a big refine patch is hard. Maybe put the
>> small parts in the front and the final one in the last to reduce
>> the intermediate part as much as possible ? I'm not sure.
>> 
>> Best regards,
>> Dust
>
>I can understand that very well. I tried hard to split up the dibs layer implementation
>into consumable pieces, while preserving the functionality of smc-d, ism and loopback at
>each intermediate step, so it is always bisectable.
>
>I know this patch  "[RFC net-next 10/17] net/dibs: Define dibs_client_ops and dibs_dev_ops"
>and "[RFC net-next 16/17] net/dibs: Move data path to dibs layer" are rather large, but I
>could not find a way to split them up without temporarily breaking functionality.
>If you have any ideas, please let me know.
>
>You write:
>> Maybe put the small parts in the front and the final one in the last
>I am not sure I understand, what exactly you have in mind here. Are you asking
>for even larger patches?

Yes, that’s what I had in mind. :)
Of course, if it seems to complicate things, please disregard it.

>
>> I may need more time to review these.
>FYI: I will be on vacation the last 2 weeks of August.
>Would you rather have an RFC v2 this week with all the changes, I made so far?
>Or would you prefer that you continue reviewing this RFC and I send a new version
>in the first week of September?

No warries, both OK for me now.

Best regards,
Dust

