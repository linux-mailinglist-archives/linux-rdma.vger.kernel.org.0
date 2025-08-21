Return-Path: <linux-rdma+bounces-12853-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA630B2F28E
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Aug 2025 10:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1878C188892D
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Aug 2025 08:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAFB2BEC4E;
	Thu, 21 Aug 2025 08:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d21+CVNW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AD1296BA4
	for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765453; cv=none; b=KweVj/aeyz/U4c3ru6b2PGTp9pxf0yu/3+FPBCF6wKdUQeKsjFvW2A5SvNPi1CQ0IKquDcLkXBHd0PiQyZitWXhUKNxuICFO1zY2GNiFUgi9lIhncrATkq05WBxY77WkrroPi1ACETbiJalOlKK6Mi46o78g14gUWI5LaKRk+FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765453; c=relaxed/simple;
	bh=JgRgDYpNHETv7narYbvqfLs6QlA4PD1MYCamiDt4VCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBSJlPy7JcS/UHYSHv6Somo0qEee2YzXUZUQ7h33YtH6BnLvGgR834wHsXkjxUVcej86f9jcJgvKxb2wFftDg7tbGS6/nbcU14dWZeOw4iS9a+IFNYGet0fke1zER0HJ5mCkXPtdmtM9XmR314ky1NtMJuUqc8yNlkKq+uYpVl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d21+CVNW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755765451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Z/jl4NhLbXD2Dij5yPc3+gGoxGWFr3ANr1k9GO/WQw=;
	b=d21+CVNWgYj+5Zh738LSyp52Qq9nChRnI7ajhtq7TK+FYoeSL7QAvY5VcYklVTKzNTNNRG
	zXziqiSz/ukHusg5uEYF/LoEZDgHPlEYiLdqoiZSh2ddTGOJBXQWpp1OhURtRdHglnzjun
	6C6+D1zhyIH2HnGKBy6HBXlkpQEXArk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-d0II1DHlOa2WdvkaoGTA8w-1; Thu, 21 Aug 2025 04:37:29 -0400
X-MC-Unique: d0II1DHlOa2WdvkaoGTA8w-1
X-Mimecast-MFC-AGG-ID: d0II1DHlOa2WdvkaoGTA8w_1755765449
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109ab1e1dso33974871cf.1
        for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 01:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755765449; x=1756370249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Z/jl4NhLbXD2Dij5yPc3+gGoxGWFr3ANr1k9GO/WQw=;
        b=WIgffGZihR6abDMOJPB13AHjU8cvBa4G0X25rA3NniTgKG72+445JUVW0XuXDDhwNU
         udjQGlDg50YwTpL27w0wzTyf9eC5oesn5egZqdmWGrpNe0ZGBSF0gEzNKuyV5TvzJYi6
         f11+Ig4VckPG1fxTcP7U0ui5h9csynBGdYaKSfDYzbrTt/E6Azm2C9ad4wYAT/msXnkU
         9M67MWWzEF2zA7SzQe+kE8iAbQY4qFjvr3VRLAsf9ni4qHk1B5d8gheWuM4eNQLzRud7
         KMN9UWldkwhyMD3It08UP67CyYGdJYu4rzYFSlKnmvgM/wOKl0xzRQ1PLMFEy8bwWgZe
         NDAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr6RSu9Jx3UDKK/S8rAnslGDn5df9JcUjAThs1dqiNxME3fRDLEmDd+DNQRuqhhKw4t2U9i1uaCozF@vger.kernel.org
X-Gm-Message-State: AOJu0YwAxyYnZDWpqVFmzHlUell3ijC/hhWUFAdy1lD/0RSWFBv8koIw
	PxhZJDz7bqxrPiy3u5+XayGHeR5XncUINASKDtuzNigT7uF7uhl75CMquqJe1ZUQB0uh1yrEqoH
	0d3HjCE2MX4Bbz+20jbXNu0aJgd2Oezc0LMjSmife4mVmbmk1Sl/nbZWWSgh0MqM=
X-Gm-Gg: ASbGnctAtTzcPTVKfR5yxIzbJ9zQ7TFzCkD99VdjQq9a51svLlygVXfgYDSM/4Y+TIK
	3bwZ8YAuhZEUFsR9ai0pYAKHzdADz2OwFl0HVYO35XqaS/eTBJoYpqS3bnAak+5qhRu+GnA/QEh
	CeYyLYsf+NvPb/XuvN996Lk3PRqxJdeUytU3krMe7MPZCYDZyq6FlH7lMYImjV4KZ2bSo3lkTok
	IZiOJ/v8Vt/jVFbdXdGwyJhZQg/Tg1yIHylLbaDHtk28TbPLvocp0QNbRDX/XzydIJtve7LcaSo
	uDumcUQXdCg9PX6Q1GLIarbAll47DLd9M2q7EpsronwbI2NDNSPNIO3ySR1HWz6eWaBWKeIbndw
	6xIKAOxRtbQw=
X-Received: by 2002:ac8:5f84:0:b0:4b2:8ac4:f079 with SMTP id d75a77b69052e-4b29ffbf332mr15472841cf.75.1755765448947;
        Thu, 21 Aug 2025 01:37:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa7HLEniIEeVkau0Y7KiByuf3qR340mDfBeXhw9Feg3OiLXP4Ua8HjnDawfSR9+z1zBUadDQ==
X-Received: by 2002:ac8:5f84:0:b0:4b2:8ac4:f079 with SMTP id d75a77b69052e-4b29ffbf332mr15472731cf.75.1755765448579;
        Thu, 21 Aug 2025 01:37:28 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc19033sm97984061cf.6.2025.08.21.01.37.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 01:37:28 -0700 (PDT)
Message-ID: <c263ea0a-adb3-4c91-81b8-cb5b283c5806@redhat.com>
Date: Thu, 21 Aug 2025 10:37:25 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL][mlx5-next 0/4] Cached vhca id and adjacent function
 vports
To: Saeed Mahameed <saeed@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Parav Pandit <parav@nvidia.com>
References: <20250815194901.298689-1-saeed@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250815194901.298689-1-saeed@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/25 9:48 PM, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Hi Jakub, Jason,
> 
> This pull request introduces a preparation patchset for caching vhca_id 
> and needed HW bits for the upcoming netdev/eswitch series to support
> adjacent function vports.
> 
> For more information please see tag log below.

This has a conflict vs net-next, could you please double check the
conflict resolution?

Thanks,

Paolo


