Return-Path: <linux-rdma+bounces-12689-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA671B23C0F
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 00:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 749707A2FFD
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Aug 2025 22:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846B12D540D;
	Tue, 12 Aug 2025 22:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ysy0M/nG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2831BD9C9;
	Tue, 12 Aug 2025 22:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755039201; cv=none; b=LdzNpSxvSYZ+rXbD96nvADpFkn59Uca0s4lVMmk9JpzoD8NTygrdsMr0FPJX+YjRcjobHEQNtqF7WmfRuW70f9bf2xfktXhhXtLSmgCBRknY+wLatbAFGOL+WW4TzF841Suk9x+8UEMv6/gZm5qIykOY902Uaz821E6PId2W7HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755039201; c=relaxed/simple;
	bh=rl3gq3jrO2l70o6HquUXwI2KyziEeemAsmrPeWEMjKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdWMsfYX31CmRH2tlwezMJfHOy6K2+iH1S9kYWaQxBp8H0IinA9wwunf0DjtOHGZw6uVRoa8EZKixugqaSDNgRd9xaQVmejBNNALzZT3+rme2C/vv1WQqOC7DKXwaH/+J0EKPNsPgo8fDYSJwrTbxgIgvFqIIxLcy0aT5qWB/sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ysy0M/nG; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755039190; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=LTKh61sGMqGDY8iSCdSNPHCu9OosnTv64aq7GuRg+OM=;
	b=ysy0M/nGVom6zEy0pQraS2VSGJQX8IGe3cx1VCTJnhCAKQeELoC+ouq6DTzrLZSJv7fVk29OyZBx5zX2udfSHKAXmyb4U9X58lXrHFstss3aRjXz5D1jTQVbPeDEPRtVLuruyHlb+d+tSwqAscgRMpWRxf9muM/NbdzbYuWRnDc=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WlcqLaa_1755039188 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 13 Aug 2025 06:53:09 +0800
Date: Wed, 13 Aug 2025 06:53:08 +0800
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
Subject: Re: [RFC net-next 03/17] net/smc: Remove error handling of
 unregister_dmb()
Message-ID: <aJvF1PQ6zx53WDBi@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250806154122.3413330-1-wintera@linux.ibm.com>
 <20250806154122.3413330-4-wintera@linux.ibm.com>
 <aJh8d2G9-veAynO1@linux.alibaba.com>
 <a92a4e51-5560-48ec-93f2-6d434b1abbb9@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a92a4e51-5560-48ec-93f2-6d434b1abbb9@linux.ibm.com>

On 2025-08-11 13:28:39, Alexandra Winter wrote:
>
>
>On 10.08.25 13:03, Dust Li wrote:
>> On 2025-08-06 17:41:08, Alexandra Winter wrote:
>>> smcd_buf_free() calls smc_ism_unregister_dmb(lgr->smcd, buf_desc) and
>>> then unconditionally frees buf_desc.
>>>
>>> Remove the cleaning up of fields of buf_desc in
>>> smc_ism_unregister_dmb(), because it is not helpful.
>>>
>>> This removes the only usage of ISM_ERROR from the smc module. So move it
>>> to drivers/s390/net/ism.h.
>>>
>>> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
>>> Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
>>> ---
>>> drivers/s390/net/ism.h |  1 +
>>> include/net/smc.h      |  2 --
>>> net/smc/smc_ism.c      | 14 +++++---------
>>> net/smc/smc_ism.h      |  3 ++-
>>> 4 files changed, 8 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/s390/net/ism.h b/drivers/s390/net/ism.h
>>> index 047fa6101555..b5b03db52fce 100644
>>> --- a/drivers/s390/net/ism.h
>>> +++ b/drivers/s390/net/ism.h
>>> @@ -10,6 +10,7 @@
>>> #include <asm/pci_insn.h>
>>>
>>> #define UTIL_STR_LEN	16
>>> +#define ISM_ERROR	0xFFFF
>>>
>>> /*
>>>  * Do not use the first word of the DMB bits to ensure 8 byte aligned access.
>>> diff --git a/include/net/smc.h b/include/net/smc.h
>>> index db84e4e35080..a9c023dd1380 100644
>>> --- a/include/net/smc.h
>>> +++ b/include/net/smc.h
>>> @@ -44,8 +44,6 @@ struct smcd_dmb {
>>>
>>> #define ISM_RESERVED_VLANID	0x1FFF
>>>
>>> -#define ISM_ERROR	0xFFFF
>>> -
>>> struct smcd_dev;
>>>
>>> struct smcd_gid {
>>> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
>>> index 84f98e18c7db..a94e1450d095 100644
>>> --- a/net/smc/smc_ism.c
>>> +++ b/net/smc/smc_ism.c
>>> @@ -205,13 +205,13 @@ int smc_ism_put_vlan(struct smcd_dev *smcd, unsigned short vlanid)
>>> 	return rc;
>>> }
>>>
>>> -int smc_ism_unregister_dmb(struct smcd_dev *smcd, struct smc_buf_desc *dmb_desc)
>>> +void smc_ism_unregister_dmb(struct smcd_dev *smcd,
>>> +			    struct smc_buf_desc *dmb_desc)
>>> {
>>> 	struct smcd_dmb dmb;
>>> -	int rc = 0;
>>>
>>> 	if (!dmb_desc->dma_addr)
>>> -		return rc;
>>> +		return;
>>>
>>> 	memset(&dmb, 0, sizeof(dmb));
>>> 	dmb.dmb_tok = dmb_desc->token;
>>> @@ -219,13 +219,9 @@ int smc_ism_unregister_dmb(struct smcd_dev *smcd, struct smc_buf_desc *dmb_desc)
>>> 	dmb.cpu_addr = dmb_desc->cpu_addr;
>>> 	dmb.dma_addr = dmb_desc->dma_addr;
>>> 	dmb.dmb_len = dmb_desc->len;
>>> -	rc = smcd->ops->unregister_dmb(smcd, &dmb);
>>> -	if (!rc || rc == ISM_ERROR) {
>>> -		dmb_desc->cpu_addr = NULL;
>>> -		dmb_desc->dma_addr = 0;
>>> -	}
>>> +	smcd->ops->unregister_dmb(smcd, &dmb);
>> 
>> Hmm, I think the old way of handling error here is certainly not good.
>> But completely ignoring error handling here would make bugs harder
>> to detect.
>> 
>> What about adding a WARN_ON_ONCE(rc) ?
>> 
>> Also, I think we can just remove the rc == ISM_ERROR to remove
>> the dependency of ISM_ERROR in smc.
>> 
>> Best regards,
>> Dust
>> 
>
>As I wrote in the commit message, I removed rc, because it is ignored by the caller anyhow today.
>If you want to I can add it back into this function and then you can think about how SMC should
>handle such an error.
>
>My thoughts on this are:
>There is not really much smc can do about a problem in unregister_dmb.
>
>I think it is Linux strategy to report and handle errors at the lowest level possible. I have some
>patches on my harddisk to improve error handling and error reporting of the ism device diver. And
>we are already discussing internally which errors should do a WARN_ON_ONCE in the ism device driver.
>
>So I don't think there is much to do in the smc layer at the moment.
>How does that sound to you?

LGTM.

Best regards,
Dust

