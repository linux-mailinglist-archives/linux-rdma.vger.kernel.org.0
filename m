Return-Path: <linux-rdma+bounces-14635-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FCEC73A60
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 12:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 47DB3349297
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 11:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B111D32F74F;
	Thu, 20 Nov 2025 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1P4utE2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CScb18ra"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E2232FA0B
	for <linux-rdma@vger.kernel.org>; Thu, 20 Nov 2025 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637090; cv=none; b=B1+zA446ZK36z5EgbRIfnoZORM/pbwCi8iYclGRismf1YKQ8DLn6Sl+ukFb8/9mMAbFgY7nQ5Dk8Dz97RKzh6oFwuJM6UDtlC9VUYr3a4zd7Z16qE19+U8EKdTkInjo5+1noyj+/Acy8v8YMFQeE+BWPg8nllfvAlGIjyWzw7tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637090; c=relaxed/simple;
	bh=4w94fCVl14EEV0Zihb71NNS/ooZ/eDdAuYJP2GMD/70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HOaUMuSa15dlHK29g+DWP65I0/oT4zmd7ILjaDJyaNxY4+x4obkxvCA7gnOadsT6hZJ1oViOr/RbM72DkZM/GY9amdLDz3n+1jORpcOuhgUA+dzLUFIZAaqGZRxuRYjHrtuiiGbvlSe0AwsA1/a1QHmifJxqozUKyFeQR5io7a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g1P4utE2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CScb18ra; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763637087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VMS34UwrZ8S2nle8FVRzl8w579va+uy0VBnhRljJShQ=;
	b=g1P4utE2Rf4IQKEV5SF5hNdWAKgNWyzhPnzE4VXdIM6aBq+mfZp+S7CFGBGJwIJG29EhfV
	GpaHq/QaO6yHGyLOqScXcUymNCbreKijl+09MiFBUm4WakSrXkLq1tGTN/3djwxbNlCHlc
	h66V0MVO1fODIASU9jM1ju6vraogEm4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-78Q3mEXpOha4MtfNdhgS2A-1; Thu, 20 Nov 2025 06:11:25 -0500
X-MC-Unique: 78Q3mEXpOha4MtfNdhgS2A-1
X-Mimecast-MFC-AGG-ID: 78Q3mEXpOha4MtfNdhgS2A_1763637085
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47754e6bddbso5218505e9.3
        for <linux-rdma@vger.kernel.org>; Thu, 20 Nov 2025 03:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763637084; x=1764241884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VMS34UwrZ8S2nle8FVRzl8w579va+uy0VBnhRljJShQ=;
        b=CScb18raWHf2CQJLRDUi+l8B51BmVrX63VFmtLeUAtYlhRak/R/TCDgO+VJp69KXqo
         Y+itwfjb52IW8k7ojUeCy0Aj8yU0lSf7S7RVZ/joHObbAWxw1HRG/5tLAzOzVH1Uf5UD
         484OCGFvuf8vrABUtbgzrk0y7DLCNZX+oRgsukkc3N2OW2TfrbvRYJcnym7ycGwTOcgr
         W5SPH8Q0eHi1RMl3Zt9stGiFjnP2V03ZcFycwGt8GYTPuEU6U4SzlhOx/mbKOpm0z0Lo
         FyALlrXpRTFN7PdDP33mq3Z4p3bWNaDp1ZQD+PYmFGuhoiG1ZjiqfHiRzC+L2ED/ZVgh
         sKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763637084; x=1764241884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMS34UwrZ8S2nle8FVRzl8w579va+uy0VBnhRljJShQ=;
        b=jF/HqOnnjvTWRme+evStDkMSVUydfCvfJ12H8fHbrIA3Ycai7BGjUrpPr/JcxsaSu8
         92SKiK8DTcDb5EPttovt8IxrhRbKqOmxrlpkQI65LCzsZQ2rEpq48q3DVTL24Zp90tAj
         rWLUsm9FC6fLpWhLBFJoXQRqk7SWcIJ9Y3e4q5eceRVQK2R/1trc/KXkk/IJDosBft2A
         rG++XAsrC2Ps9UHNRaZkj/kBeHgahLuabJv+fBfNxTKEX0oW2wt4PjlkTf2fycm01VZe
         zAY2qu5pyKcim5LJcOY0RmriMu+g3EJ8+eqhABiIL37GlAX0Ulq3/SPcVrIvARj7Ffcl
         jAjA==
X-Forwarded-Encrypted: i=1; AJvYcCXe4i46imfahEFVsP1nBvNUK0L0UsH0AUP9tF+Nf9LWQErLng5nZrxX/xjS+JgSbH7zoE9J+tQ1yuwz@vger.kernel.org
X-Gm-Message-State: AOJu0YzWaGZA4ULBr1RFVxAHxr9nOFWuwJARuKCCtEbDdtB7wi6kt3pv
	I9xcF6bSLFAoYPrGmkI02zV+gMcXfhFqkUW4AlZ6FFgLFKF7ssRUpcEkEEWFBR3IrAcHdsmN07k
	7lIzT/myn/tvrdtygeICUEw4G7VOx88dyO09XLYPSmipNZwMzt/rDvwUJ1ibPeRA=
X-Gm-Gg: ASbGncsrihFMHrXN4YsFhV1N3YVCVJ2/i7N6aVJBxTbf0L0ti4Gv/DwBWjx5X1USSu3
	U1ZuyvS7BaLWgpmUSRaMzIbQ3aHz+PJ7+6XhNJXrgEQhjg47zJi3TZy0c01f5usdQS6Jl4q3Coo
	0Ik7rNrzx9FDUfsNOJPGNY2QYMnvyZoeGM4oE+pRYTzExJOIVndpFTGGEOZ/YkK2ZekCItrxAE0
	/JdtB2+Zf3nUg9MneVH3Xo3oq2GD7lfkBW1Uc5uwfap5sFMsl8tvGEuONUYSAJUxOmqzBWYizXW
	2FJsmFFUNaRDuehPUx08O6806DME3+qArzqKc6TV/eSgHqp2N7E76ajE90kDIxZdcWtzHglcWnY
	z47oj8KF4+am/
X-Received: by 2002:a05:600c:21d6:b0:470:fe3c:a3b7 with SMTP id 5b1f17b1804b1-477b9ea4d28mr16744265e9.5.1763637084533;
        Thu, 20 Nov 2025 03:11:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/fUTeDI0WH8NPmq3GHHJh/IHPYx2tPHiKQdM9TuqaRUB2LyRCR8etaEIrIUjerN5jw8l6jg==
X-Received: by 2002:a05:600c:21d6:b0:470:fe3c:a3b7 with SMTP id 5b1f17b1804b1-477b9ea4d28mr16743945e9.5.1763637084152;
        Thu, 20 Nov 2025 03:11:24 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9ddef38sm63385435e9.3.2025.11.20.03.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 03:11:23 -0800 (PST)
Message-ID: <7d835eb1-f111-46e5-8834-a1fafb53bd8f@redhat.com>
Date: Thu, 20 Nov 2025 12:11:21 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next v2] net: mana: Handle hardware recovery events
 when probing the device
To: longli@linux.microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Simon Horman <horms@kernel.org>, Konstantin Taranov
 <kotaranov@microsoft.com>,
 Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
 Erick Archer <erick.archer@outlook.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
References: <1763430724-24719-1-git-send-email-longli@linux.microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1763430724-24719-1-git-send-email-longli@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/25 2:52 AM, longli@linux.microsoft.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> When MANA is being probed, it's possible that hardware is in recovery
> mode and the device may get GDMA_EQE_HWC_RESET_REQUEST over HWC in the
> middle of the probe. Detect such condition and go through the recovery
> service procedure.
> 
> Fixes: fbe346ce9d62 ("net: mana: Handle Reset Request from MANA NIC")
> Signed-off-by: Long Li <longli@microsoft.com>

Does not apply cleanly anymore due to commit
934fa943b53795339486cc0026b3ab7ad39dc600, please rebase and repost.

> +static void mana_recovery_delayed_func(struct work_struct *w)
> +{
> +	struct mana_dev_recovery_work *work;
> +	struct mana_dev_recovery *dev, *tmp;
> +	unsigned long flags;
> +
> +	work = container_of(w, struct mana_dev_recovery_work, work.work);
> +
> +	spin_lock_irqsave(&work->lock, flags);
> +
> +	list_for_each_entry_safe(dev, tmp, &work->dev_list, list) {
> +		list_del(&dev->list);

Minor nit: here and in similar code below I find sligly more readable
something alike:

	while (!list_empty(&work->dev_list)) {
		dev = list_first_entry(&work->dev_list);
		list_del(dev);
		//...

as it's more clear that releasing the lock will not causes races, but no
strong opinion against the current style.

/P

/P


