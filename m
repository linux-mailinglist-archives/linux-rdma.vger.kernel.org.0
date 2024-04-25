Return-Path: <linux-rdma+bounces-2065-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D688B1FFD
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Apr 2024 13:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE0B2866C9
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Apr 2024 11:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8B285C46;
	Thu, 25 Apr 2024 11:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6RX1QoO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A46200BF
	for <linux-rdma@vger.kernel.org>; Thu, 25 Apr 2024 11:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714043543; cv=none; b=inUsIb4WLBtV4QMhUl2iGy7jWDuRk/YATNB0bSv87A274n5pNKMMXEDYXYLx0PjLrvPA13AMvDcmdlM9Eap7GMxH9POtOx3k/vxzJGdfgt4SGPKZqxJElUeorBHSk0Jx4e4d8wghCdowZqX7iEHtsFKifNH68eF7BnbCRuBzTXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714043543; c=relaxed/simple;
	bh=fgAAzQeVoG3h8/GjDKO9wMvgvRzUd3+YKLl1s3yUEzU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kjmSmtWs6j7dGn0tJ4vD2g2w+RPchk9g6VPRQDGWYuPnnzzo+23BoumPXyZ9TJB+CB9oNgd56RAgkcS06BcDYLhiFv+jVD2yAWgYbU076mXx1EDcpyOmKEw6jfOrchGI0XG1rb7RQKIMdv4Bp5qLSGpDbQdYDy7UQYGiz2AJ608=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6RX1QoO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41b3692b508so6153815e9.1
        for <linux-rdma@vger.kernel.org>; Thu, 25 Apr 2024 04:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714043540; x=1714648340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nddTBhUWucJHvcGmaZCEgOyzjW888iBdCPF2IxBrmsY=;
        b=U6RX1QoOGbh+Yo+RxvsDKHA7a8FHc7u3z1DXamGIKTgi0XjHUD7XRrrNt+1GkgKyfo
         l0IzBWcyDXbG9v1MkO/yCVVtFU5BlMylKi1WfQovp/cGMUumc0qQBV4eBE9r6oHWvK+P
         o8w4/xIvfZBMnHSC1AmqH0qqsDxdT+ctq+59HbFsKT0AhFEk3Np7Wv3o+xxFJgADF5Qi
         GVbbh5hrA+gstCEGebi4TwpVsqiEjB0b3bmQlanEX+2fTNXTs3V/sn2mW4l1Jt8PMRiK
         3t0tlpIcHa3rgjSMhivbhUKFjp4k/E6JVTPC7QojGl8dQoeDHHbMkt0KE7BiSPeKIsFl
         NPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714043540; x=1714648340;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nddTBhUWucJHvcGmaZCEgOyzjW888iBdCPF2IxBrmsY=;
        b=QkmeQ5282LkWICOcjGcXx0Nbh5OhTYozOFaeRRHExiqs4Y2CuSv7aJaVkLakF9c65s
         EFb/5UpTJattIuWOZBcMixq8JkjAmz9AwZnBKLdz3m6WaqA8svGsZZ0Co0Cqu1ddUch+
         fDEvWvza7+NIpSqJr0rWLNQy2+I1quduTKvseyaNl3aAZ7hjhk2lh1afIuwTAIa+vy8y
         adtSXnwaw6aAt8GtL5STf/efurWHBY6DP0xRbKSfBLnf32g4953+V8WYI65yWza3aJTz
         2L+unGFFFSDziGdekcUSbLequSg4QWYurKDu+uwMALn7DXigMDob8A5iXaYr+4nnrQ49
         bOoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWbvZjupmF/8fOOqrTkx7wgtE/lip5tKA1oGLEOTBo13ATwyrN1u+riH/Lrl++VK+5dWjPVLJHsvHQB7dIfcrUwvhjlx29LwlkXw==
X-Gm-Message-State: AOJu0YwnepsZNj+yEh8xu3kcnaGs99TkxZxidlky/p8ti2tnJFD3PkWf
	c4U93hHE07uMHzCcIABeHmxHbb8ScU1e2T7pV9/aueU0jiq/jXlv
X-Google-Smtp-Source: AGHT+IHwISOlvlib4anWWxyFP8N1ou5Jsi4ED2uryv90YAihoajMEN8PEx1Zx8Ha++64tjzgteAbNA==
X-Received: by 2002:a05:600c:3ca8:b0:41a:a4b1:c098 with SMTP id bg40-20020a05600c3ca800b0041aa4b1c098mr4218131wmb.19.1714043540117;
        Thu, 25 Apr 2024 04:12:20 -0700 (PDT)
Received: from [10.16.124.60] ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id s7-20020a05600c45c700b0041aa570bcd3sm10174997wmo.35.2024.04.25.04.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 04:12:19 -0700 (PDT)
From: Zhu Yanjun <zyjzyj2000@gmail.com>
X-Google-Original-From: Zhu Yanjun <yanjun.zhu@linux.dev>
Message-ID: <6bafebb9-0b2c-42c2-ae9c-851e8499d5d9@linux.dev>
Date: Thu, 25 Apr 2024 13:12:19 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-rc] RDMA/efa: Add shutdown notifier
To: Michael Margolin <mrgolin@amazon.com>, jgg@nvidia.com, leon@kernel.org,
 linux-rdma@vger.kernel.org
Cc: sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
 ltao@redhat.com, Firas Jahjah <firasj@amazon.com>,
 Yonatan Nachum <ynachum@amazon.com>
References: <20240425075143.24683-1-mrgolin@amazon.com>
Content-Language: en-US
In-Reply-To: <20240425075143.24683-1-mrgolin@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.04.24 09:51, Michael Margolin wrote:
> Add driver function to stop the device and release any active IRQs as
> preparation for shutdown. This should fix issues cased by unexpected AQ

s/cased/caused ?

Zhu Yanjun

> interrupts when booting kernel using kexec and possible data integrity
> issues when the system is being shutdown during traffic.
> 
> Reviewed-by: Firas Jahjah <firasj@amazon.com>
> Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> ---
>   drivers/infiniband/hw/efa/efa_main.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
> index 5fa3603c80d8..d1a48f988f6c 100644
> --- a/drivers/infiniband/hw/efa/efa_main.c
> +++ b/drivers/infiniband/hw/efa/efa_main.c
> @@ -671,11 +671,22 @@ static void efa_remove(struct pci_dev *pdev)
>   	efa_remove_device(pdev);
>   }
>   
> +static void efa_shutdown(struct pci_dev *pdev)
> +{
> +	struct efa_dev *dev = pci_get_drvdata(pdev);
> +
> +	efa_destroy_eqs(dev);
> +	efa_com_dev_reset(&dev->edev, EFA_REGS_RESET_SHUTDOWN);
> +	efa_free_irq(dev, &dev->admin_irq);
> +	efa_disable_msix(dev);
> +}
> +
>   static struct pci_driver efa_pci_driver = {
>   	.name           = DRV_MODULE_NAME,
>   	.id_table       = efa_pci_tbl,
>   	.probe          = efa_probe,
>   	.remove         = efa_remove,
> +	.shutdown       = efa_shutdown,
>   };
>   
>   module_pci_driver(efa_pci_driver);


