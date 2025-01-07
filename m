Return-Path: <linux-rdma+bounces-6872-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF4EA03A08
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 09:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5C6163C8A
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 08:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD73A1E2610;
	Tue,  7 Jan 2025 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9fDYTfw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1B51E0DE3
	for <linux-rdma@vger.kernel.org>; Tue,  7 Jan 2025 08:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239485; cv=none; b=H5PO6bDRmtPPDG9JHJwmNCaVKur8EM5tuLUSw9MYl/prPTatyZmMtSbsDUAy0EoltaVqPjPlV8A11mq8udvQqMJW8a6etHviwbDF0PSMlfX21yPBG5Rlc9RfIRfNp+AyWlMoi286CAWEg1M4Pgr0z/lWib0LbOPIV/v0OYXx6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239485; c=relaxed/simple;
	bh=9z4E307FEw5yEmX/R4lxvUrMV7D0T547+CC68yqF1tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IRVLpNHIR1ARBNzFvyAPR25lY/d++Y7fAGJnNSJtci6QOeViAkCNJBcra3D0QvVzkPSu1gfOUfjpQZ00B9LHXYO/C9vEYWVmzMWQ51pKgr7Dsx36C3xYC3fddtsCyLCAROlK0YE2gGHBrbPgdDsupLxsf0He8LIDOOTGSA81ko8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S9fDYTfw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736239476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHBnQGum4M7ipVuexTEpYGlSJHQu9KV4nhMGzektAi0=;
	b=S9fDYTfwQok1tTQZDF1UWH8e1gByy9gs2ivLwQKJ6ClBM9GS2B6kiXY//MOV/vUqOopUeo
	UFRZh7kkaCqXAKDUEcCjzIOVgfPJvWr/cLAGjohw09Dzb4HuGctZW4Xm3BhUiiGo7rxmAu
	0Tc2N9Mm+sEwDu0vVszvfBMihEZAeqU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-dB4epT0aO864pqsS1EvkfQ-1; Tue, 07 Jan 2025 03:44:35 -0500
X-MC-Unique: dB4epT0aO864pqsS1EvkfQ-1
X-Mimecast-MFC-AGG-ID: dB4epT0aO864pqsS1EvkfQ
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6f3b93f5cso2944488285a.0
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jan 2025 00:44:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736239475; x=1736844275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHBnQGum4M7ipVuexTEpYGlSJHQu9KV4nhMGzektAi0=;
        b=vsU6SYlrhlbqTkCVM8PLdyCgqIzQhJ9ubeWgrcJ65jBm2SkVKQbFKrzGriXe3q3Hbe
         VACfBFgO/nUpAAWGeRhb6aCYugle0uJ1VOaFIrcTPzFLNqvusGvLXRkOpQgkyVllgzgh
         ZsmoRgaJtGF13BzM6VSaUu9URNFd6l2ovRzxDJkUhP46YoFeAhMftPmuDll/Mg1k/tjj
         +Po9RBI8akxIagmEyHwMFDgvX8pwafrHgXwjlJPSyoRHSzQ2qT2Hi22Y1RRzmXub25KO
         RYqhvPKjgAeDBv7kQxlzI6p40kzcDSMTyXUcX3rSt8vt/dhvmKmNbO8HHFadwEIh1r/5
         ywQQ==
X-Gm-Message-State: AOJu0YwDmbFRylMVpqQ4DK3Zhkv1RJZwsuB8zo+6LXX5Zw57g+i5p6vu
	7ZAfigpTyF7/Z8yBVbJzPIi15PgqSxd8gYd4MsO0RNyz1WF+x4pNlK3nf3BhKT2IxSGaCP3gHCy
	sW3BL+fmIOkBVJAHTASMG5HNbauSPBvCt+OF8njNtM602kHj98Lm4sWPmFNU=
X-Gm-Gg: ASbGncs+3JGL5snk0gSvP7GuJ40w+yyrtIQgEKTmjnICy11LzXd1vAGeLgq5M8bzOti
	vkB6+ml1t95zvgYaZM5bLtilQJUU98QrRhLNMy1Z4fsCNs0a7PbfwmARzU7lpZ3SZff+WGRjryz
	XkTzl2EYF7wDkrr0XKPPTZ7JoMdrUIZXINKtTKk50ukxeIRsTcqHHiUNWB6m42GIC+MlQ/GKm2u
	aqTegjOFw503fKEFt2xjkDt12p0c7I69E26TKhg6InquH84a1tZHfdXXleNAT1cjglLxOvYqMAq
	rbvleA==
X-Received: by 2002:a05:620a:2a03:b0:7b6:eba3:2dfb with SMTP id af79cd13be357-7bb9027dc9cmr357934785a.16.1736239475069;
        Tue, 07 Jan 2025 00:44:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQCMcAkJhmI/CqAK5HFPejGMDCVtbEjbyNYs7SJgbt11nVHwRNfhnAYo5Ac+BtyoR7P+tihQ==
X-Received: by 2002:a05:620a:2a03:b0:7b6:eba3:2dfb with SMTP id af79cd13be357-7bb9027dc9cmr357932985a.16.1736239474732;
        Tue, 07 Jan 2025 00:44:34 -0800 (PST)
Received: from [192.168.88.253] (146-241-73-5.dyn.eolo.it. [146.241.73.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2e6587sm1573880685a.48.2025.01.07.00.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 00:44:34 -0800 (PST)
Message-ID: <1f4a721f-fa23-4f1d-97a9-1b27bdcd1e21@redhat.com>
Date: Tue, 7 Jan 2025 09:44:30 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: use the correct ndev to find pnetid by
 pnetid table
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, PASIC@de.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241227040455.91854-1-guangguan.wang@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241227040455.91854-1-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/27/24 5:04 AM, Guangguan Wang wrote:
> The command 'smc_pnet -a -I <ethx> <pnetid>' will add <pnetid>
> to the pnetid table and will attach the <pnetid> to net device
> whose name is <ethx>. But When do SMCR by <ethx>, in function
> smc_pnet_find_roce_by_pnetid, it will use <ethx>'s base ndev's
> pnetid to match rdma device, not <ethx>'s pnetid. The asymmetric
> use of the pnetid seems weird. Sometimes it is difficult to know
> the hierarchy of net device what may make it difficult to configure
> the pnetid and to use the pnetid. Looking into the history of
> commit, it was the commit 890a2cb4a966 ("net/smc: rework pnet table")
> that changes the ndev from the <ethx> to the <ethx>'s base ndev
> when finding pnetid by pnetid table. It seems a mistake.
> 
> This patch changes the ndev back to the <ethx> when finding pnetid
> by pnetid table.
> 
> Fixes: 890a2cb4a966 ("net/smc: rework pnet table")
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>

If I read correctly, this will break existing applications using the
lookup schema introduced by the blamed commit - which is not very recent.

Perhaps for a net patch would be better to support both lookup schemas i.e.

	(smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid) ||
	 smc_pnet_find_ndev_pnetid_by_table(base_ndev, ndev_pnetid))

?

Thanks,

Paolo


