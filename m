Return-Path: <linux-rdma+bounces-13352-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A928EB570A0
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 08:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3448189AF2C
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 06:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68382C027F;
	Mon, 15 Sep 2025 06:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3FtC1AL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAF82BE7DD
	for <linux-rdma@vger.kernel.org>; Mon, 15 Sep 2025 06:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757918973; cv=none; b=LBDaaCN82u9FYx1LXqQl4Pyzy4ezFqCNeqGJysMqXWx/sR4/eluXxHiFZJHxToliLxUmTdWR5CsdZYYxECdVoHsWkU+jy4gWNWFOEvbCNsvYS+4sNPu1/nkvNGucW0SvDAKVr9S0pH4TnJor2nvW42Ew6pOwy1+6UGCertx1AMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757918973; c=relaxed/simple;
	bh=y+Ts700dyFh7Sbo5E3aMbOkmEk/XXfH/85l7cyAHUPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAJawqtKgui/KyePPGzCT/H7VnLIqzF4poyJxg8SCO6Rnu1sIVv1/DtKXcYQywAlZVO3+Rr6H41NcEJWDU/C3uHRmMy2XiZV0UWk1vdY4jclx5iDdg/xxKnWCyf+PEBBIGw7xvKKnlcmrgsyqqUGQSd1GymOu5WDSBUZaDjA7T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3FtC1AL; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ea3e223ba2so787695f8f.2
        for <linux-rdma@vger.kernel.org>; Sun, 14 Sep 2025 23:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757918970; x=1758523770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dRhn4UI1i6wUE9dvuB3tPiTpnLotqg1U3EdGZvL3C64=;
        b=E3FtC1ALxf7VFGt2+b1k9eKzXtSdqoxlHw1vlpwhV+5rI485BlWzOc6WwePeQCJLP0
         VL5GdG6xsXQd11vlDiacHpvww1KIxjkn9WWdhkvlJBvWYBUnfzQ8fhpeILEQun5W8RRh
         CLmKDVg/5+ZJHnKLxBMMdhO2dL/0Z29+npZy2vT+LGrkuULSdAOB0U1f9OIu297k0h/L
         y4nV9e7th3OlHeeoCMNLIznvtAUhyS96NC2DFprmsOgbbvOWVvr3bk1+RgY5n5QFpN2E
         XyVxINrzqJSfXGeiKtOW9VxCcuH7+uRcFgT44D0Csbu8SJQYb8bKc42lpdfzyQY1sos5
         7YHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757918970; x=1758523770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRhn4UI1i6wUE9dvuB3tPiTpnLotqg1U3EdGZvL3C64=;
        b=jS+t/V+MIfyPsvMd4HPVlzPNYs1oZSNkduvHmJPgH+Ak/bWxjeTiRz79g8Qa2ibLgY
         IkUi1YHnmc4XD2aXGD+qxgHbt+OoSqgKkj9tN1VHKTCxGv5VoApLu1L0OuuVrXW+3UQD
         hkrVehXxoH0vwtxYQkXzIublLxfQEyKuvXqdlB0o+ko1MYZ1eAJZcyRTueSOeBDk2O7Y
         PWCcFtXvPofFDQiIl9qCW/kU5ojT4HkrypmC4CSa2fZ+uvOxIrxcEn0UoXGxdS3Nb22/
         YEtfg5xgno4FfhxcceajF498Qo9PCEZdWFOLSJoEmgQc9AjahlCzj2jlxb3o5v4kLnhB
         yBqQ==
X-Gm-Message-State: AOJu0Ywts1Tu7m9zfzt9lpSzZu6XBV3EurgryZlQA9XnWrz8885OK4KF
	oTKaGuI/YVTR38vECzz5OFwp3wFKqObHfqr+4tmCeFeYdY5/4IFoADus
X-Gm-Gg: ASbGncs05xPuIE/uwQ073mRgmkvqfGUWxTuwx/QL8Cc85+fjGGuFxs5K6Z6g3UfsOT0
	aHwLQukckz08zvyWUjleI5gV7AEOMaAt6142ySFNKQmwAfRiJero4SqW3bECQepkekX6Tzv1skT
	J0jJ/i2szf4mPiivfthPQzVDlvz/hmKDxsXqGNQ2SbPsIJ+YVdLt2QwodAo09nGbvNb22c2mdMN
	4/FJWOAi32XdH3dKKtuo3XMXm5M0exZ2JjNgrsrE5O9moHcb019388acBEYgwhQLVmcb2rNQDu8
	UQUel2qEUe+27MqXixwyeQlF7TckWM4pUfiM9St14UzM/WrJfYA+YXJYB5pgx6/LNce5JfxnIGC
	i+R6I7gbjUp2KM5bBdX+GPeBt+RyibzTTCLX27JYYXrk=
X-Google-Smtp-Source: AGHT+IGp2rgRuB3vs2/XV9q3gFpF1P9760GllJVKtJhrv1TfRfFuwwyt6IjSgk5kzHo5bQ+OFboa+w==
X-Received: by 2002:a05:6000:2dc3:b0:3dc:ca9d:e3d7 with SMTP id ffacd0b85a97d-3e765783063mr7692923f8f.8.1757918969993;
        Sun, 14 Sep 2025 23:49:29 -0700 (PDT)
Received: from [10.80.3.86] ([72.25.96.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7cde81491sm10789594f8f.42.2025.09.14.23.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 23:49:29 -0700 (PDT)
Message-ID: <dd2ba47c-79fa-4bfe-9eb0-c10b978a8260@gmail.com>
Date: Mon, 15 Sep 2025 09:49:28 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: fix typo in pci_irq.c comment
To: Alok Tiwari <alok.a.tiwari@oracle.com>, mbloch@nvidia.com,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Cc: linux-rdma@vger.kernel.org
References: <20250912135050.3921116-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250912135050.3921116-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/09/2025 16:50, Alok Tiwari wrote:
> Fix a typo in a comment in pci_irq.c:
>   "ssigned" → "assigned"
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> index 692ef9c2f729..e18a850c615c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> @@ -54,7 +54,7 @@ static int mlx5_core_func_to_vport(const struct mlx5_core_dev *dev,
>   
>   /**
>    * mlx5_get_default_msix_vec_count - Get the default number of MSI-X vectors
> - *                                   to be ssigned to each VF.
> + *                                   to be assigned to each VF.
>    * @dev: PF to work on
>    * @num_vfs: Number of enabled VFs
>    */

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

