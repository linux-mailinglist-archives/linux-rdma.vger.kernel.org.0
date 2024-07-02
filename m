Return-Path: <linux-rdma+bounces-3617-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FA9923B97
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jul 2024 12:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF29A285443
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jul 2024 10:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E1B158DBA;
	Tue,  2 Jul 2024 10:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cR/pcpsN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F835157465
	for <linux-rdma@vger.kernel.org>; Tue,  2 Jul 2024 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719916781; cv=none; b=Zjk2cVsHbiWnKlVlSdLDHZDdDZx0nZJ0+Lx7N4noChT2g2BW5ljnsrTuxThbIy1xBuDc6qaucupiVqhOR9e6XIMkupR/cvVtk7eY6mmtFIMHqi7++oCPXXeuI0BThO/XIRYC4c0tZCBfYTE2WHaoGbKjQ8C1IeYUAhf5ps7Xt8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719916781; c=relaxed/simple;
	bh=Xl2rctPpHhdwq8YlqLbrFCmVIv2OS82jg+Ix6qyt8/g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZZQlTFt02IxOkcThY/ghDaY60gf68Mx9b3pnvW4B0UqiXT7VdkurdZ60ibuLAyYCNHvkzCs7sEz19qQ1ydrNzKi5GDt2sfwfuRj6pCKbcwr756qs3M6Cv+NeQd0TTY+TU3euL8wDL/VS5s7IPzM3y1CXmtVMHfyTEtIJnwPJc64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cR/pcpsN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719916778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3YLXB9MkeKYTYYeIwamS+YJvjnpnJTWmR20C/0Yyas0=;
	b=cR/pcpsNCCHjetd3f/HJyiOVLHTZ3TikkUFedbsVj3SSdFVZ4jrQ/nOa+wvBaXQk6w/0Ku
	99RzVa0MQJqjyEquq3Btft1xDzlXEd+3iw1n0H4tsJiBwqx8tYWgW/xqdD0kljalQ3S6tC
	m6adC6qr7R57fNWlFcHZXXTCIQGTz1k=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-sygaRRnaNrm_zz9oAEeOfw-1; Tue, 02 Jul 2024 06:39:37 -0400
X-MC-Unique: sygaRRnaNrm_zz9oAEeOfw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ee688d60cbso4544091fa.3
        for <linux-rdma@vger.kernel.org>; Tue, 02 Jul 2024 03:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719916775; x=1720521575;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YLXB9MkeKYTYYeIwamS+YJvjnpnJTWmR20C/0Yyas0=;
        b=RyQjUYLVhRzEjjh1nncW1IJbS3hT2PO/TyOTrpJy9C5QJgXU7E5IdC9bJqqWIA9ZMe
         czG9QKFvGWzoIP96V1BWi8aMVANCFkbMJOzKzAQLD6JIOYLlgAaDK3WDfP4A2+fzJ+NE
         C8MeXxipo5PAjFzS9wgCBsT29jFOJtP1HzQdr9EQyPTooYiLpVu8Az+203B5pImwdHwI
         6eDDA8MST/wnmxm/Yc9QW6Vyyv0lsEB0h8BNkoNTQYgjw1NZNs/AC7XfnNGzjx53pb/d
         T+/T56621axywP1jHDbsxn8OiwPsM96p+fboCp1Wnb8JO4OKY+ZGyxIEXFkj2crCeUrB
         Evog==
X-Forwarded-Encrypted: i=1; AJvYcCU64koAVQGigmRGgyq0uSwzg7thzdokkbLYKvmr75NDE7mhNM/uBmAooWXAdk8L+6ZrLlbH7VI0FfLMJeQsb5qVcW2JAX7C8QVv4g==
X-Gm-Message-State: AOJu0YwVHkelTJhLQjVuPDZx7VTfVnCrb1XA9z+KXVxlcBN/XRdTS7wB
	yI/ghE0x94XB0sw/1cqfHCENAxxSn+MAGT+x4O3IhAoeks7z94PdULTfgIuLjg6rdyN42Qm8fLo
	fDPhiyVSYgqrvY2ytd/lXfhJ1RMZCuPhWmEh7MShfTcf/v4b+nBecrunnmkY=
X-Received: by 2002:a05:651c:210d:b0:2eb:e6fe:3092 with SMTP id 38308e7fff4ca-2ee5e6cd8ebmr61377521fa.4.1719916775604;
        Tue, 02 Jul 2024 03:39:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXORtM5rpI1wqu3MKxPNslyUfWlXaYdHnq5S8XxKWzFOQ27JKwXU/lNz1N8vkXPLvtBrgLtw==
X-Received: by 2002:a05:651c:210d:b0:2eb:e6fe:3092 with SMTP id 38308e7fff4ca-2ee5e6cd8ebmr61377191fa.4.1719916775133;
        Tue, 02 Jul 2024 03:39:35 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0a6:6710:872d:b0f7:af0b:a62f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b09aa32sm192704885e9.34.2024.07.02.03.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 03:39:34 -0700 (PDT)
Message-ID: <3cf2178e917fc345bc4cafee5af4a81f555725ec.camel@redhat.com>
Subject: Re: [PATCH net-next v8 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
From: Paolo Abeni <pabeni@redhat.com>
To: Shay Drory <shayd@nvidia.com>, netdev@vger.kernel.org,
 davem@davemloft.net,  kuba@kernel.org, edumazet@google.com,
 gregkh@linuxfoundation.org,  david.m.ertman@intel.com
Cc: rafael@kernel.org, ira.weiny@intel.com, linux-rdma@vger.kernel.org, 
 leon@kernel.org, tariqt@nvidia.com, Simon Horman <horms@kernel.org>, Parav
 Pandit <parav@nvidia.com>
Date: Tue, 02 Jul 2024 12:39:33 +0200
In-Reply-To: <20240627143810.805224-2-shayd@nvidia.com>
References: <20240627143810.805224-1-shayd@nvidia.com>
	 <20240627143810.805224-2-shayd@nvidia.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-27 at 17:38 +0300, Shay Drory wrote:
> PCI subfunctions (SF) are anchored on the auxiliary bus. PCI physical
> and virtual functions are anchored on the PCI bus. The irq information
> of each such function is visible to users via sysfs directory "msi_irqs"
> containing files for each irq entry. However, for PCI SFs such
> information is unavailable. Due to this users have no visibility on IRQs
> used by the SFs.
> Secondly, an SF can be multi function device supporting rdma, netdevice
> and more. Without irq information at the bus level, the user is unable
> to view or use the affinity of the SF IRQs.
>=20
> Hence to match to the equivalent PCI PFs and VFs, add "irqs" directory,
> for supporting auxiliary devices, containing file for each irq entry.
>=20
> For example:
> $ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
> 50  51  52  53  54  55  56  57  58
>=20
> Cc: Simon Horman <horms@kernel.org>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Shay Drory <shayd@nvidia.com>
>=20
> ---
> v7-v8:
> - use cleanup.h for info and name fields (Greg)

AFAICT Greg (also) asked about using guards for the lock.

Thanks,

Paolo


