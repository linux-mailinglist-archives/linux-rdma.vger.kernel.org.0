Return-Path: <linux-rdma+bounces-13395-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44763B59046
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 10:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A4727AC303
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 08:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2563C288505;
	Tue, 16 Sep 2025 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKl8mF+B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F0D284689
	for <linux-rdma@vger.kernel.org>; Tue, 16 Sep 2025 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758010804; cv=none; b=BOy5IvveaaR9LxcX7wswk1o6NZZy2/cwuBZ1a1uBBUvouz1cedTcjO5vOZ4okbtikmFhmRKOxcjqdbjHR2MOVTnB6Kt1Mj2NkFfzj1rOTD0ULjnxKFR2NWyVUwcscZF5+HMbWgN4etAznM5bUtKlji6xWzUonzP0JA0eiSRGujw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758010804; c=relaxed/simple;
	bh=wyzFXdhH71/K6R4ozNwpypG96FdPPhKK1bsIffaUOAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XllRdqRQWjlFqTzMV3CbY0/Gy2TtR4OmdreQFwvph39+7RU+fkgCoqAwpcLvpGdWMU+2Qpm4a9ToP3z22LFzPh+q8+XfhynoCPlTtZVCXAy72VAXLVIcnTW1pqp3JrJyhDdEUFfDFLwuU49Riso9Yri5VbwszRBHxzqT585sjT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cKl8mF+B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758010802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NzL2N1DLwKqBJMwL8CAS9ydZTfmXfd5ccrcFe6t3UgE=;
	b=cKl8mF+B2HrIPufSGUrOV9ztHLqZHbhhCz+Fi+9OTAMuT5ZKdV9zr27FEvhQzDP5KYyaM0
	j+J+ZSg4XbfmvPZ/A/M8k66Cz16KPJwabzPaOYo7uVyZNRWYhAVkYuysFm9T2+/8ofdX0/
	atjWij8Tc1PfdxBwc2vsuz2lhBSEj5A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-g_o9-SmUOpiSB30lmBkeFg-1; Tue, 16 Sep 2025 04:20:00 -0400
X-MC-Unique: g_o9-SmUOpiSB30lmBkeFg-1
X-Mimecast-MFC-AGG-ID: g_o9-SmUOpiSB30lmBkeFg_1758010800
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3df07c967e9so487673f8f.2
        for <linux-rdma@vger.kernel.org>; Tue, 16 Sep 2025 01:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758010799; x=1758615599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NzL2N1DLwKqBJMwL8CAS9ydZTfmXfd5ccrcFe6t3UgE=;
        b=GfXC/4DAG0qgJqOMpU3MZyLBnSE5TyDeLBW8Ep+MddTbsRdYvF3JUJK288EWRENfYm
         mYljp7k1CZYX0HKYfcZUurVLMw/38y7xRvNw7Aob9s0UgUkR0BVPhQ4nkZaDLibVYi8L
         iPwuwXEv0eCkjPwwDtdWPIbez/7TacWgoFcYA5cGlcCuLTIQpTubAPxrzX9kRq1hsKW1
         WADlnrm49LGRztevraR+U5tBfSd1AnNQuD1JN7lnxgmNwt3WDEdg0gCUifF3+ZKUM0Zu
         DfjrKmhUc0fJ2XurkFVoSrOAPjvep+5Xryd7ddY8x4b/faN5+KLNxa/aiBQaRcLqJB2D
         I5ag==
X-Forwarded-Encrypted: i=1; AJvYcCW3DZk/QmLWy2PI+MA/qmNS6t5bvKVeHet1hxX6mKQ/MTDVQgsOV6Y9UkYfz1nkgBD0+t97TBA/nRhp@vger.kernel.org
X-Gm-Message-State: AOJu0YxPgzkFHNmIkkJuHm6yA5YvMpAs6tgWxEjjoi9hvxV4bpaDhpTQ
	JOkJoEh6m6+Yid0cj8bLt2WFqj5doiNWprvYcdMeHTVz1VBEsK9i/QL+JV+m2LDDCT0qnSRM4RM
	bUPP3di8Zgg098/CyCNZ0MUZLMiUoejtUq6gi9tFzGkf4My5G6ujYyjePhMAaf1Y=
X-Gm-Gg: ASbGncsAkQtNAzVeZ0QJfFP9X5ND/9g8TxVCHipIXDe1qhiLG0hM3qJEkIRAdD45ULo
	VJtdr/PRbTj/JM79v6Otfs64000bbfkvuBlbM49De4zuJvch79NjuXwkJJnGQ/rd4LPU1a3L6hd
	JstGtCh2SeVcf+s2tOXTU+SVpJeAUZrDOWCNecTd6xw82/r1cIz+JPLPUG7UMF/C6ShSUDiV/gV
	HcjyGWFiL98t4wTwiVO/rQ4yLbKxlZ9vJ9VeWFN9SdVNPEEWJfRf5RuvZOhTlIS42vI80Gh1SAj
	74IqM0NH3laBvbDqGusYyWYwnojW4TZQT1QoN8MENNrr/p99DSQXbxMlCkVndRjwRaZLkBebvQ3
	bI+wCRTB9po3B
X-Received: by 2002:a05:6000:23ca:b0:3ea:5f76:3f7a with SMTP id ffacd0b85a97d-3ea5f764a5dmr4367642f8f.22.1758010799656;
        Tue, 16 Sep 2025 01:19:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEno2K+NdUW6UjWVLC6LxT9P7Qfem/6TR6gFdG8F5R9GArEc4/f2xtzeLzakkVXchgcRbliwQ==
X-Received: by 2002:a05:6000:23ca:b0:3ea:5f76:3f7a with SMTP id ffacd0b85a97d-3ea5f764a5dmr4367594f8f.22.1758010799204;
        Tue, 16 Sep 2025 01:19:59 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e9a066366fsm10432408f8f.44.2025.09.16.01.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 01:19:58 -0700 (PDT)
Message-ID: <e50be1a2-4e9f-44b4-b524-706be01c97e5@redhat.com>
Date: Tue, 16 Sep 2025 10:19:56 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 13/14] dibs: Move data path to dibs layer
To: Alexandra Winter <wintera@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang
 <wenjia@linux.ibm.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>,
 Aswin Karuvally <aswin@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Harald Freudenberger <freude@linux.ibm.com>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>
References: <20250911194827.844125-1-wintera@linux.ibm.com>
 <20250911194827.844125-14-wintera@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250911194827.844125-14-wintera@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/25 9:48 PM, Alexandra Winter wrote:
> +static void __dibs_lo_unregister_dmb(struct dibs_lo_dev *ldev,
> +				     struct dibs_lo_dmb_node *dmb_node)
> +{
> +	/* remove dmb from hash table */
> +	write_lock_bh(&ldev->dmb_ht_lock);
> +	hash_del(&dmb_node->list);
> +	write_unlock_bh(&ldev->dmb_ht_lock);
> +
> +	clear_bit(dmb_node->sba_idx, ldev->sba_idx_mask);
> +	kvfree(dmb_node->cpu_addr);
> +	kfree(dmb_node);

I see the above comes directly from existing code, but it's not clear to
me where (and if) dmb_node->cpu_addr is vmalloc()ed (as opposed to
kmalloc()ed).

Could you consider switching to kfree() (if possible/applicable) and/or
add a describing comment if not?

Thanks,

Paolo


