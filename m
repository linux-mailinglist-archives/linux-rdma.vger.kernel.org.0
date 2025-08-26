Return-Path: <linux-rdma+bounces-12918-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A57BB352D2
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 06:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5728D2443B0
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 04:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A951D2DF6E3;
	Tue, 26 Aug 2025 04:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="TRNzaXv/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DNSNULL (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523D92D3A74
	for <linux-rdma@vger.kernel.org>; Tue, 26 Aug 2025 04:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756183463; cv=none; b=hs1SE6eK5SfSwFAXsJrTFY57/8bI4f7IlwbSgpSUu4zBH/yITCs5a0+7seDZxNxvAlVrBBs32tZKCDhRDzkYM0YFeliHC2EBAk8CRAUNdBOVHHw2BYuR+CHjJZDuJU/MpEZTdtEK61+W9IsL1HHCBq0n2Tn4em0NvntEkm5HUTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756183463; c=relaxed/simple;
	bh=6fpAxUXqlyE93Q/+JD6IIdh4cHWyrM9VR52auhBYhWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZJ4LHwQUyIFrTeK1Nz1fiJGqRXalFJqRDp024awuEgcclluTAmyG8rv7iQZhtjvClv98+hsfCGmcADtQxCgRbrSCBDtMRQGQu72cQsHHv+KQwD2qHh9t1DTooYGJAPD3wPh2IFuBeuWLI5xgFiL6ksk68WoiqIktQFxi0hHTsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=TRNzaXv/; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id qjAeulmZvSONXqlXaugnPa; Tue, 26 Aug 2025 04:44:14 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id qlXZuJxLbXZDSqlXZuKhvH; Tue, 26 Aug 2025 04:44:13 +0000
X-Authority-Analysis: v=2.4 cv=SdD3duRu c=1 sm=1 tr=0 ts=68ad3b9d
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=DR2cKC/DEnBA9KqqjaPhpA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7T7KSl7uo7wA:10
 a=yNDbeuk1G1CePlwefi4A:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3LEUZooy3cA+r1A+6Q/9oLA+oz/81DPxxeW8Ak9/YpM=; b=TRNzaXv/y0xo5y03+fEnAlaqt2
	KZpexqG6D79IuXlv6yRe+d54dWiO3xDAPcsFF4z9yrugm3egVG+aUBIicmyl61uXJOUyH5hM4LTr4
	YvTomCwxl2ExBNOnkDa1ctlokC7b35/CgdxvgB9MccKfmA9ij7g1lTR1I0jil01d4nwfoUi2L9t0+
	cpnGtj8f1H+++YwZP82wX5XRq8UB3DMP5f4zI9qV03pDgGzf8+11mBlbXI5K2q8o3L0Cu00TYj+g9
	U4724lFmFDwkKlk8ZHl6xzHcRVApv6s0BAaZS28R2/68zD3ka4kuXtJHCtYVN47OeUjGzmW68ExoQ
	UcPk2bMQ==;
Received: from static-243-216-117-93.thenetworkfactory.nl ([93.117.216.243]:36842 helo=[10.94.27.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uqlXY-00000001RSx-0ZQh;
	Mon, 25 Aug 2025 23:44:12 -0500
Message-ID: <aa568cd4-3bfc-4eac-8a49-eb4cf7cf7331@embeddedor.com>
Date: Tue, 26 Aug 2025 06:43:55 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] RDMA/cm: Avoid -Wflex-array-member-not-at-end
 warning
To: Jason Gunthorpe <jgg@nvidia.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aJxnVjItIEW4iYAv@kspp> <20250825172020.GA2077724@nvidia.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250825172020.GA2077724@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 93.117.216.243
X-Source-L: No
X-Exim-ID: 1uqlXY-00000001RSx-0ZQh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: static-243-216-117-93.thenetworkfactory.nl ([10.94.27.44]) [93.117.216.243]:36842
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfK18hwTN1XL2qtvnEIH8gy7UUxHZZQPNzn6Gjk/zsQdz53ASLNPU5DZUYs8xL1ILVVwfQkZcgYqMa/OyLkTu3x6B20Y/lkcsoDE1xP3Z5e7D6DXwJ8ct
 ml7wclFIzloEMoyKa4R99mBh+j9xZv9+tNpow5hJ3EkizPtSGkN2mgvXjI9v/PiBb4j6/CUGVCor1a2em8dpO7aFmKyTUwU/u/7MswVCp1mRZ1DKKoyNuaPC



On 25/08/25 19:20, Jason Gunthorpe wrote:
> On Wed, Aug 13, 2025 at 07:22:14PM +0900, Gustavo A. R. Silva wrote:
> 
>> @@ -1866,7 +1872,7 @@ static void cm_process_work(struct cm_id_private *cm_id_priv,
>>   	int ret;
> 
> I think if you are going to do this restructing then these lower level
> functions that never touch the path member should also have their
> signatures updated to take in the cm_work_hdr not the cm_work struct
> with the path, and we should never cast from a cm_work_hdr to a
> cm_work.
> 
> Basically we should have more type clarity when the path touches are
> to be sure the cm_timewait_info version never gets into there.
> 
> And to do that properly is going to need a preparing patch to untangle
> cm_work_handler() a little bit, it shouldn't be the work function for
> the cm_timewait_handler() which has a different ype.
> 
> Also did you look closely at which members needed to be in the hdr?
> I think with the above it will turn out that some members can be moved
> to cm_work..

I was wondering if we could just move cm_work at the very end of
struct cm_timewait_info, like this:

  struct cm_timewait_info {
-       struct cm_work work;
         struct list_head list;
         struct rb_node remote_qp_node;
         struct rb_node remote_id_node;
@@ -204,6 +203,7 @@ struct cm_timewait_info {
         __be32 remote_qpn;
         u8 inserted_remote_qp;
         u8 inserted_remote_id;
+       struct cm_work work;
  };

and then I found this commit 09fb406a569b ("RDMA/cm: Add a note explaining
how the timewait is eventually freed")

-Gustavo

