Return-Path: <linux-rdma+bounces-13025-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D824B3F35F
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 06:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F3420378C
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 04:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59B12DF3FD;
	Tue,  2 Sep 2025 04:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pwVaqz8a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F2121C17D;
	Tue,  2 Sep 2025 04:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756786107; cv=none; b=GsM8R8yTlV5kilUSGXPD22mGLSSHoQD842nUcHcYWOmH40x7136LgEEqwKPUKdo9WmG6myKWKYbQt+Kaq219fM3581Nm5g++TlYg/pAPHiLQW8E0/ALXWAT0L4OrWjPm16cW3bFv20SeDew3Z/qniUW8xlix2F8mnReN2InKZWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756786107; c=relaxed/simple;
	bh=jTI556Eooi1/vXJTugUObsZl+P+sOBU/fSgyZoB4Wec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFI1wtlYOOZ7bGYAzxhkfSUTJI4DavFsHYPTKb6Jjz2wZnTfZH9bmt5DqpnjRs8/AfBYeMLyNqRHZYsSxe+2cjajN45q/7AEGTgPw3HA/gOVncGoWG83PrlAeIi50XIyGhVzZ/sASCgz8cj2pH3E8V0TeQRe056Dg9BpNUWZCSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pwVaqz8a; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756786095; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=2woiSeoT7iI3yiE5TVB69UAKIiB6QW53ddfa85a7Joo=;
	b=pwVaqz8a7AcEmO2Muu9mRyVEbKYwMEDgFibgh5BDGnOy7KDpOMRRCVbXiCY0c/IcBn3ndf+MkmyfKOaYhBZ7bzgdnhUIPKtw68+tloz2wFLAk8OA1W7GTm1X4E7itipOv7vfpPIJMSNwo5qJh5Mr/AXlixLhag7tPhh2jw2nHmk=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0Wn69K76_1756786093 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Sep 2025 12:08:14 +0800
Date: Tue, 2 Sep 2025 12:08:13 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Mahanta Jambigi <mjambigi@linux.ibm.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alibuda@linux.alibaba.com, sidraya@linux.ibm.com,
	wenjia@linux.ibm.com
Cc: pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH net] net/smc: Remove validation of reserved bits in CLC
 Decline message
Message-ID: <aLZtraICmwOQAtsO@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250829102626.3271637-1-mjambigi@linux.ibm.com>
 <aLHAAy-S_1_Ud7l-@linux.alibaba.com>
 <57c2976e-8b6c-4cee-803f-ca5b0636f30b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57c2976e-8b6c-4cee-803f-ca5b0636f30b@linux.ibm.com>

On 2025-09-01 11:42:38, Mahanta Jambigi wrote:
>
>
>On 29/08/25 8:28 pm, Dust Li wrote:
>> > 
>> > Fixes: 8ade200(net/smc: add v2 format of CLC decline message)
>> > 
>> > Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
>> > Reference-ID: LTC214332
>> 
>> I think this is your internal ID ? It's better not to leave that
>> in the upstream patches.
>
>Oops, I missed to remove it. Sure, I'll remove it.
>
>> 
>> > Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
>> > Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
>> > 
>> > ---
>> > net/smc/smc_clc.c | 2 --
>> > 1 file changed, 2 deletions(-)
>> > 
>> > diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
>> > index 5a4db151fe95..08be56dfb3f2 100644
>> > --- a/net/smc/smc_clc.c
>> > +++ b/net/smc/smc_clc.c
>> > @@ -426,8 +426,6 @@ smc_clc_msg_decl_valid(struct smc_clc_msg_decline *dclc)
>> > {
>> > 	struct smc_clc_msg_hdr *hdr = &dclc->hdr;
>> > 
>> > -	if (hdr->typev1 != SMC_TYPE_R && hdr->typev1 != SMC_TYPE_D)
>> > -		return false;
>> 
>> Here it's checking the typev1 in smc_clc_msg_hdr, but your commit message
>> says it's validating the reserved bits:
>> 
>>    Currently SMC code is validating the reserved bits while parsing the incoming
>>    CLC decline message & when this validation fails, its treated as a protocol
>>    error.
>> 
>> Did I miss something ?
>
>If you refer to struct *smc_clc_msg_hdr* in smc_clc.h file, typev1 member
>represents bits 4 & 5 at offset 7. If we compare it with the CLC Decline
>message header, it represents one of the reserved(5-7 bits) at offset 7. You
>can refer to below link for reserved bits.
>
>https://datatracker.ietf.org/doc/html/rfc7609#page-105

Oh, I see, thanks! The patch looks good to me.


BTW, I checked the rfc7609 and SMCv2.1 spec:
https://www.ibm.com/support/pages/system/files/inline-files/IBM%20Shared%20Memory%20Communications%20Version%202.1_0.pdf

I think the name type1/type2 in smc_clc_msg_hdr is confusing, as it doesn't sync
with the spec for decline message.

Best regards,
Dust



