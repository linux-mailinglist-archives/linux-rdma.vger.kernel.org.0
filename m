Return-Path: <linux-rdma+bounces-8427-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C875A54B45
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 13:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0942A7A50C7
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 12:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E89720C02E;
	Thu,  6 Mar 2025 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="puFo5LP1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3178D20C005;
	Thu,  6 Mar 2025 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741265782; cv=none; b=jRnV74NAwrZbpUbM5UOuayf0bkYraM634aXfEOw45V3fdZz97U4EjUWtJnw9mZpiis0dfa8cqi8JS2Hj170URPeW9k0Zeh27+RIRaSEh39NDMtt0/FoenHlBLkQNZd1pu++Tl5nGGg9cm+SVk1ZWGmKHtN8rX4n5+pssXfK06Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741265782; c=relaxed/simple;
	bh=f2QtvPy6r04TsWQAZ7fY9Nfn8lhUfdUSIfPRUOUAA2U=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=LBWfSBQlVx9WxzzLgDySfkErGOuNBnGEk7nKrHvhw8siEz5LcLVZGVesP1ZOwpdi6lDfKIARkwVnq3hrr6oXuHcwUuARZjfH4TOcsh6DY3b7lHMlxjB9GcabFMSQc6W/XNoRPaJhrySzav08VWfAczUO9ji8s64AvakF2tc18oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=puFo5LP1; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741265767; x=1741870567; i=markus.elfring@web.de;
	bh=lEO/H7U6mflERQ8ZtSb9y/xEZwt5K4DW1neaihbZZT4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=puFo5LP1f2bRljUx7EVazQ5Yw8M5e0ZG4ogCQOMPPfyFrmPQjvrJOk4ukdsHFEZq
	 mVA1a3OG9LLt6OX8lWkk7D0YgHbv3V3TK7e+S44VLgowincXqIReR+yR/jiNJ3ZMW
	 q5r6MZLSSSQ8WFHRoNSWTddupeVsWW0kELHG8NZ/5Ip70XoWabvtH8r4fveGwsi1X
	 Sz7t3jnUR44RW1DH9hLG+lUkMtYfiDRmXL1j0exicEV2IxqmRUkeR+q4XhDWUD9ke
	 mK+2j+xca+nHga2HFLwgtY8y16oavECBRAFmmjeyJueW+7tMjOrN7Pb38N0RllhXR
	 ONtsArI2BkiB+rFLyg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.2]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MK574-1tY5O501Lq-00QpQ1; Thu, 06
 Mar 2025 13:56:07 +0100
Message-ID: <ad735fa0-2352-4905-b8a6-a1404db08b9e@web.de>
Date: Thu, 6 Mar 2025 13:56:05 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cheng Xu <chengyou@linux.alibaba.com>, linux-rdma@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Kai Shen <KaiShen@linux.alibaba.com>
References: <20250306120440.72792-1-chengyou@linux.alibaba.com>
Subject: Re: [PATCH for-next] RDMA/erdma: Prevent use-after-free in
 erdma_accept_newconn()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250306120440.72792-1-chengyou@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:IVhrD0F1k4zaNs9E3KnMn5Yc2YYOK5Wse+hGYaaSweIjdFC6pfp
 +stD+fbBdrQmTktuk35mgku5VYzlTOoTcbrMBbaD2ysaHzHWQBaDw8tHPfmURg+BBHVFYBk
 qulXVyu822C+rE1tLBqB/1hcVl3G8ovGXtG02eAD+4HINkXl2ArBiukCv1a7mDrW90tTfOS
 PJ54Ej88FEUwCMpyzzeqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LbNJ6i1pJ0M=;s2tJIblZYmsoXA3jLF2eLxLV5iJ
 zlb4nCov9pw90zwt1AsLNn247qGj177u03eWF81ez1zXzA3haKpJ9Q9MXUuopVGQxFRoDTG49
 1ly9zqTX1fgxiK/Z88ESppFNiR+SDPB5nbNNfs7eScnK88tML2YnncQSsbdF/coUak7XwUSCi
 5HBlGW8r4/ztdhJIv/73Uifo14zjrbee5Duy1kM14TcHf7JpAfExMlkGa+mxhtLtoj/nSFUgE
 G04SydSSzKQmLeKZGdfsB3FEslS6rtOFDYouZF1f+JPTILnxrInqD8yqXznGgQoLel77OwYkG
 nJUZHttVXIMX6sTlCC8giiT0HwrsLUOzUm1rY3iTzSdJ5VOaGBbPunB0FIYGdfV5itoarz0jZ
 VD6TgFYJrH04u9PnHym6BTfJ3OjI80ethjgnWvZqbBvSc0hNJ7CN7xtvpwZdC0qHdQqKUAJVm
 LlUvrGUjXytKuyF7uCO/pvIg68I3kPcMAEBccxB13ZicT3kgp9lUiyP3R1V/91pA0JNuj2vMF
 b0h0pvmli4iRvklx/ikuJ0/AB7EtOfG7wUNPQLpoiuD1s+dFpVvXzMUxejQHj6eNtJMCuPjbv
 xKHfDYOE6bSKoZvt7zOm9chM2rEtr5Z309PEnRB6Jbf4VLQL95enGEPO1rldvx517vIy3bzCg
 6VRiOzOPd4BwWCRIENuyhAXtQ0AQ4k9jZ+9X2X3YGEAZwCmURe5NbbjxkUoUPTv2m+EZ336uS
 kVSzlSrTDctM79ezc1EwliTsMtSdo2+EtmkF5z2f8Gg/nZRxrR1Acr+4tArw9arLXD1ToWJuh
 KtL+qrTCiN1NRFYJg0NPtfrkgARHk87OF16xUVp1AAWNWnPRAQ52rPtOBVTfN/n5c7R/Re1bP
 tG0Lb1AmYkwlI8C/sPn4tp1rOBGk1MncBLih8A7IITrz+rom7GkY933LQ5hmKCWiFDZRIMWJJ
 x56J21PZcip4/8LxuRSeur+z1jYRll5MI7qZk2dyLB1byJWG4IJjnJwy1VaQLiYOiLb+MwdpI
 u3FemPqvvc3lflx654dKrugyZUV/4v5Mbobl/S6K+uYsIpx+i1fllRhNH0o/e1uzWbaKC0P2W
 8SwfB0xQKtz1/0qu8YzvZJiNNky+SwLdDJxx6sCp9esCV3AyCpsakjOu3X0+7hJtZaWDfNkaR
 LAWf+in1Lj8os2oSNdQyl+CfTe2/DgLuzu1kThQkAHK2fE1bOvoUN03s4tsMoTNLGH2upR9EG
 zyH2NcW/aSda07FFmUGSg2/Cjxj2Uk2zNJK6P1rdu6bs+zuabnh4KnEc2jwHQXnQXOvuah08O
 mbXnzqmEOaMJ6npsB7O+4odg4+RFwldCrqh+YnSTcS+fjNJJjUXm3L+fwqsawBia09GBmagXp
 dqQsUsjWs2ti2x89FjZIzS+x1lmZhMGUgC7pBNXeWmB+4ZV5Qsewnhf8oQWNpyxUNZ9f0Xqf0
 LPPP2Ww==

> After the erdma_cep_put(new_cep) being called, new_cep will be freed,
> and the following dereference will cause a UAF problem. Fix this issue.

* Would a change description be nicer without an abbreviation?

* Will any additional tags become helpful?

  + https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.14-rc5#n539

  + See also:
    https://lore.kernel.org/cocci/20a1a47c-8906-44e8-92e6-9b3e698b1491@web.de/
    https://sympa.inria.fr/sympa/arc/cocci/2025-03/msg00075.html
    https://lkml.org/lkml/2025/3/5/1100


Regards,
Markus

