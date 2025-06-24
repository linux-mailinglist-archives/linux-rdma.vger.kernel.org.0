Return-Path: <linux-rdma+bounces-11593-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AC8AE6BE4
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 17:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6E3168A7C
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 15:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DBB274B53;
	Tue, 24 Jun 2025 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="XtR/9+va"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4467626CE26;
	Tue, 24 Jun 2025 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750780605; cv=none; b=JcskR7503o55n+KbP1E296LSL8QR8XFAgQBJuWuGnSydvvUxLQb0dG3ypvclWZBixLVi0KO6iKX7yuz0un+1VW6D7e9aqPGU9NI9bUGog+t5BEOtOJzNag68c9kvU62GyFqHt9xNtNkdfKER0TlTz4Bj5c1zhIoODd2RVy11gIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750780605; c=relaxed/simple;
	bh=XVCuen0FG5I4EgaQRLolLJNRLoHVWKVqXdjKzXgQN1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5thDKb7ogDkiG3BJlSGcStQiK5ZUhUhDT3ZrLLjggIDP0xmYuOYcjrT+hCZ6adKU1BBQQEszCN6wncsHiN61REBg3GMxFUop6lgj41ErybjnLthxo867JxlWmwMxcPhxtU3Tz06EbLQP5ZhCFTHrZD3MfdL8YAPXXJFn4HGLiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=XtR/9+va; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bRV1c37VNzlgqVM;
	Tue, 24 Jun 2025 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1750780593; x=1753372594; bh=k87Kt8d17QiHMKRX5//p9JaU
	KqvNFZYbFprgwj/iPQA=; b=XtR/9+vaVgVkNOVs/oOMUMQDURJv1Q0OjcQfh6uJ
	SExDgj+QsT4pYynZIhS9f8i6i5r1oxugvADaqm0hXCCd2JRc4y9RN/bEiqs2r5Nt
	enwTArrUyp9IltBAgVrtZ825dtc9Pc9L2x9PMPNlSz+wkUmYxjf6FHEH4Ts3p39L
	yQTLl//wl+fitmmd+04hHirtrR0Xbgx/OvZoq9hDAySdlF4mQn5u3LgALokAc23a
	9BgMgUgkR4WKQKAfbT+r5oxHlxSj5vQpuyIouOaW/+TJPcC6iFOPBvSrW6IDEbQg
	Yg8tZMhBfc99yPNxPIN0gWjvw+K5ln8EEL8Nt9jEGjFGxQ==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id vVe8oxrQReX3; Tue, 24 Jun 2025 15:56:33 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bRV1P2MkKzlgqTy;
	Tue, 24 Jun 2025 15:56:23 +0000 (UTC)
Message-ID: <c92baafb-baa7-40ba-9b47-9337c78779c4@acm.org>
Date: Tue, 24 Jun 2025 08:56:22 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] scsi: enforce unlimited max_segment_size when
 virt_boundary_mask is set
To: Christoph Hellwig <hch@lst.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 "Ewan D. Milne" <emilne@redhat.com>, Laurence Oberman <loberman@redhat.com>,
 linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
 Hannes Reinecke <hare@suse.de>
References: <20250624125233.219635-1-hch@lst.de>
 <20250624125233.219635-3-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250624125233.219635-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/25 5:52 AM, Christoph Hellwig wrote:
> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> index e021f1106bea..cc5d05dc395c 100644
> --- a/drivers/scsi/hosts.c
> +++ b/drivers/scsi/hosts.c
> @@ -473,10 +473,17 @@ struct Scsi_Host *scsi_host_alloc(const struct scsi_host_template *sht, int priv
>   	else
>   		shost->max_sectors = SCSI_DEFAULT_MAX_SECTORS;
>   
> -	if (sht->max_segment_size)
> -		shost->max_segment_size = sht->max_segment_size;
> -	else
> -		shost->max_segment_size = BLK_MAX_SEGMENT_SIZE;
> +	shost->virt_boundary_mask = sht->virt_boundary_mask;
> +	if (shost->virt_boundary_mask) {
> +		WARN_ON_ONCE(sht->max_segment_size &&
> +			     sht->max_segment_size != UINT_MAX);
> +		shost->max_segment_size = UINT_MAX;
> +	} else {
> +		if (sht->max_segment_size)
> +			shost->max_segment_size = sht->max_segment_size;
> +		else
> +			shost->max_segment_size = BLK_MAX_SEGMENT_SIZE;
> +	}
>   
>   	/* 32-byte (dword) is a common minimum for HBAs. */
>   	if (sht->dma_alignment)
> @@ -492,9 +499,6 @@ struct Scsi_Host *scsi_host_alloc(const struct scsi_host_template *sht, int priv
>   	else
>   		shost->dma_boundary = 0xffffffff;
>   
> -	if (sht->virt_boundary_mask)
> -		shost->virt_boundary_mask = sht->virt_boundary_mask;
> -
>   	device_initialize(&shost->shost_gendev);
>   	dev_set_name(&shost->shost_gendev, "host%d", shost->host_no);
>   	shost->shost_gendev.bus = &scsi_bus_type;

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

