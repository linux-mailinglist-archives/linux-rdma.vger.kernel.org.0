Return-Path: <linux-rdma+bounces-8177-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9B7A4718A
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 02:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E423D189618E
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 01:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25797270038;
	Thu, 27 Feb 2025 01:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="T5LDkSA1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DC2145B25
	for <linux-rdma@vger.kernel.org>; Thu, 27 Feb 2025 01:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740620187; cv=none; b=miKr98Qdc1Zax/AzxdjM1J9rIi8igORxw3aeA1BO87zEH5sECxKPWISZFwuJNb0L80aHtyAVCtrnmf1QMDe9/oTHWssOwSJdp27NdDXxosP+Gu2SweqQ0KvHmypT3r5PDZEgEZlGdwxlrYhMrhxCeooPTKAC2dpaVHVBsOeEgOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740620187; c=relaxed/simple;
	bh=k2V7wphUG6wKt5QZ7PREMxbVooD5fqXo1+/9VvP6jDU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=X0rohBzZXMpIi4nqLWBp6kPjSHu08tKRUxeFalsK2yD4EyOS+a92tJ8WetB8la8wN007Hke/phoYPtJFIsPDPPIrOJss7Ytp6Qc0pk2idOuc8J/xCGjqfJ6AM54Ks1NnLT6oD0ucrT4z2WojexucTxtR1Fh45GcVL3kzZ2AVQAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=T5LDkSA1; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id nKUXturpaiuzSnSp1t4uOe; Thu, 27 Feb 2025 01:36:19 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id nSozt4mDZvt5YnSoztxdCd; Thu, 27 Feb 2025 01:36:18 +0000
X-Authority-Analysis: v=2.4 cv=c9JgQg9l c=1 sm=1 tr=0 ts=67bfc192
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=6Vi/Wpy7sgpXGMLew8oZcg==:17
 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=7T7KSl7uo7wA:10
 a=Ni3fNgrDxWfqb646fvIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7j6L+RvzF30uDg3oPgVDVuCmXIOBWIYoqTV2PAWYZFs=; b=T5LDkSA108o7GyBzmBz3/ULjvL
	UWpbH1JZsFyPJXeiuWmh0KLDiHOT8KG4BtBmfzqLhig72b4SrizY8rfyePko9JZHRQvDCb+MbcNSe
	kmHjPp1VtFQo+u0/NClxCNwNZ/zb52aFS2KO6EfOnGFOtUYmciQS6Wwg56UpV2SJXdWkusIQGAv7b
	vSYLizQMEZK26uHsBX9Le0uuH4Z2dqtXSEHtv7aAnv8puiXqkBLqQ+N5frmz9OGjXqHlSfDqN2pWh
	j3wyx4fPnv6Cjp/JVAGwy3Zqmq5E/s/fHC2JBfwj9pTOEnox65eojyhb3bwz/rGA6VpwJeU/pPYEF
	k83KFHvA==;
Received: from [45.124.203.140] (port=53654 helo=[192.168.0.158])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tnSox-00000001mIp-12OT;
	Wed, 26 Feb 2025 19:36:15 -0600
Message-ID: <69815658-68cd-46cf-bca1-81119bbdb49a@embeddedor.com>
Date: Thu, 27 Feb 2025 12:06:03 +1030
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH v3][next] net/mlx5e: Avoid a hundred
 -Wflex-array-member-not-at-end warnings
To: Saeed Mahameed <saeed@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Z76HzPW1dFTLOSSy@kspp> <Z79iP0glNCZOznu4@x130>
Content-Language: en-US
In-Reply-To: <Z79iP0glNCZOznu4@x130>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 45.124.203.140
X-Source-L: No
X-Exim-ID: 1tnSox-00000001mIp-12OT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.158]) [45.124.203.140]:53654
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOasG91i9GmlwfxZlPJVZ+5xnC1eIpBpGI0CKmFHbxxvnMgFx7oxpxJetiHbLxfh+kZAxsrxQIzsjQ9lQ2mHll4zjRXLjjd7X3wiRn6yUZNJiX+xPxP7
 YsauR6S1ree0zWmfhUISdQkuU2mn3aPvwNfvysLwmaHKLByDdFubg1iAQ49HRbnJForbI71xfcmQVrMhcrq1TDNNexUc7CsC5s7ptvSHjzP56xM9NBmUbRRA


>>
>> -struct mlx5e_umr_wqe {
>> +struct mlx5e_umr_wqe_hdr {
>>     struct mlx5_wqe_ctrl_seg       ctrl;
>>     struct mlx5_wqe_umr_ctrl_seg   uctrl;
>>     struct mlx5_mkey_seg           mkc;
>> +};
>> +
>> +struct mlx5e_umr_wqe {
>> +    struct mlx5e_umr_wqe_hdr hdr;
> 
> You missed or ignored my comment on v0, anyway:
> 
> Can we have struct mlx5e_umr_wq_hdr defined anonymously within
> mlx5e_umr_wqe? Let's avoid namespace pollution.

I thought your comment was directed to Jabuk.

I don't see how to avoid that and at the same time changing
the type of the conflicting object and fix the warnings:

-			struct mlx5e_umr_wqe   umr_wqe;
+			struct mlx5e_umr_wqe_hdr umr_wqe;

My first patch avoids the need to introduce a bunch of `hdr.`
changes. However, `hdr` is introduced as an identifier for
the members grouped in the new type `struct mlx5e_umr_wqe_hdr`.

Of course struct_group_tagged() also creates an anonymous struct,
which is why we can avoid all those `hdr.` changes in v1.

--
Gustavo

