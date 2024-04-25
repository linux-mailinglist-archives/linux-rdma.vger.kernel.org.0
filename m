Return-Path: <linux-rdma+bounces-2063-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 696658B1EA1
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Apr 2024 12:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CAF9B269CE
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Apr 2024 10:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503F885646;
	Thu, 25 Apr 2024 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tz3EkMFY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED6984E19
	for <linux-rdma@vger.kernel.org>; Thu, 25 Apr 2024 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039232; cv=none; b=qJyir/TO21BYUpgGwM9pcMQsJn7E62ueBq/sQeXK9+jeob9UHtL3EoZXq4qA15bz8j3GbtNhjrcq1r2JIt6BkU5e+rppp9CrHBFpInxHCDOrKx+CAXJ1KOHBJ/QcX3Xn2/ffZLgT/YRs6gAuwGjciL8NRrAZGaT3UsqeHAyOQ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039232; c=relaxed/simple;
	bh=OtOGh0lD6HzXFqvR+xUJ+1oMEh0ZEGbqZ3PseYac1Js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8NR8WtxlBH+SkM8jonIJtpkPotfFnVF8XCD1yZvr6z7IJT044N/jna+MBcQxz3wpRS7ZVxn+KjGnM6eOwrCKMHGELtwpSsHWyByPSmW/VLx91W2sVauip5bj9fVj3pCgrhk8VpalYq1yVTtTyYOtWp6qv6wnJQBm014qSKm6LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tz3EkMFY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714039229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JyAVOPw/M0vAZFaqHtwR62KvWlgEELOqjIigltdR4YA=;
	b=Tz3EkMFYB1GnzFF7X4WjKQFK1s3J+LwJY422EN424SNBUjo5In43w+WReyXsng9snO1ojE
	sE1myqWCPKNaZ5u9Jt4zeVCv5Y6wBe8K2QQs6/E5ByXYokJSXoZU48IYgwjPVh9sZKBn3e
	g5lvEAUUcGHWAqe7opRPInfX+D0zZHA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-Asu8yuGBOVeHf-Xyg2rPJw-1; Thu, 25 Apr 2024 06:00:27 -0400
X-MC-Unique: Asu8yuGBOVeHf-Xyg2rPJw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-51bc35e78a2so653877e87.2
        for <linux-rdma@vger.kernel.org>; Thu, 25 Apr 2024 03:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714039226; x=1714644026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JyAVOPw/M0vAZFaqHtwR62KvWlgEELOqjIigltdR4YA=;
        b=XfnWHWS0UkBafjnnSgLbYPJ8qzWixwkd1Aja/rtFdIAhCKsvdhoowi+xWi4x2Fbnaf
         tnVA3V29+VOiM79IAZ2G/QBDZzceE8kX+vhzCiVQPWfu3bP7SB9owgi4yYiAzIGSF2MJ
         t4SJ5Qx6WVYGFBqOnED4dWTwf1kWB03MUGEcPplZkxTZSuoDGn4aQMWgSWJIU5fEPbGS
         N4jd8ssBl+eKPS7bwaMpJPgXV3tgK2OifCtaCXA1UvfFpS5eZU7rVJFWq62fUyTnF2Il
         GpOEMNtKto98Ur9Q9m9pPtvZli1qshWz9lI+66tuN0dcvnxF1YHjuox/69+46fCDYqwt
         IFIw==
X-Forwarded-Encrypted: i=1; AJvYcCVvv6qI+tyTeH2MaRYw9NJVO/3Z16fxmNBcTOKfmisbtLBmgGSWY5gXbiD/R8qT/K1K0IhSTGNZybZkDadnwLIJbQZ89L9skJTpOg==
X-Gm-Message-State: AOJu0YzX44iJ570U/khjc4lEZdGMnh70Bul2RLdfv7RMnUMBhI3mnRI+
	CJUB7cQFu7ZEzUaHGOepvqn7BJwTz2CJRe6qbvU8CZwl0RTPGC5/YMzr/5bXoQc5x7XkbR7HKXM
	ClbF3i3azIZ8nhkpbxseit3pbyi7OUGvzUceLezfC39S5oMvaobEmeu3qNKfykZXAO0zWU4Zf4O
	JTsLupj7QL7kQlcjaX/yHCZayo783i7HTXyQ==
X-Received: by 2002:a05:6512:12d2:b0:518:e7ed:3c7c with SMTP id p18-20020a05651212d200b00518e7ed3c7cmr5207239lfg.14.1714039226531;
        Thu, 25 Apr 2024 03:00:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFzTzGT0wBhR3FIJkpt+hX7l+kkBmLEE/8IPCE/H5A07zJ1c7Ph5/HShwlni5/h8N0ygzJLvDqatBF+jPwmgw=
X-Received: by 2002:a05:6512:12d2:b0:518:e7ed:3c7c with SMTP id
 p18-20020a05651212d200b00518e7ed3c7cmr5207219lfg.14.1714039226186; Thu, 25
 Apr 2024 03:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425075143.24683-1-mrgolin@amazon.com>
In-Reply-To: <20240425075143.24683-1-mrgolin@amazon.com>
From: Tao Liu <ltao@redhat.com>
Date: Thu, 25 Apr 2024 17:59:49 +0800
Message-ID: <CAO7dBbU7T7W=T70gPLkbFyMaG9NrfEkVnw_kb4h0FOz9=n-AmA@mail.gmail.com>
Subject: Re: [PATCH for-rc] RDMA/efa: Add shutdown notifier
To: Michael Margolin <mrgolin@amazon.com>
Cc: jgg@nvidia.com, leon@kernel.org, linux-rdma@vger.kernel.org, 
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev, 
	Firas Jahjah <firasj@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

Thanks a lot for the patch.

Thanks,
Tao Liu

On Thu, Apr 25, 2024 at 3:52=E2=80=AFPM Michael Margolin <mrgolin@amazon.co=
m> wrote:
>
> Add driver function to stop the device and release any active IRQs as
> preparation for shutdown. This should fix issues cased by unexpected AQ
> interrupts when booting kernel using kexec and possible data integrity
> issues when the system is being shutdown during traffic.
>
> Reviewed-by: Firas Jahjah <firasj@amazon.com>
> Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_main.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw=
/efa/efa_main.c
> index 5fa3603c80d8..d1a48f988f6c 100644
> --- a/drivers/infiniband/hw/efa/efa_main.c
> +++ b/drivers/infiniband/hw/efa/efa_main.c
> @@ -671,11 +671,22 @@ static void efa_remove(struct pci_dev *pdev)
>         efa_remove_device(pdev);
>  }
>
> +static void efa_shutdown(struct pci_dev *pdev)
> +{
> +       struct efa_dev *dev =3D pci_get_drvdata(pdev);
> +
> +       efa_destroy_eqs(dev);
> +       efa_com_dev_reset(&dev->edev, EFA_REGS_RESET_SHUTDOWN);
> +       efa_free_irq(dev, &dev->admin_irq);
> +       efa_disable_msix(dev);
> +}
> +
>  static struct pci_driver efa_pci_driver =3D {
>         .name           =3D DRV_MODULE_NAME,
>         .id_table       =3D efa_pci_tbl,
>         .probe          =3D efa_probe,
>         .remove         =3D efa_remove,
> +       .shutdown       =3D efa_shutdown,
>  };
>
>  module_pci_driver(efa_pci_driver);
> --
> 2.40.1
>


