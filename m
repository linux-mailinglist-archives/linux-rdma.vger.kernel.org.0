Return-Path: <linux-rdma+bounces-12572-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEC5B1889C
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Aug 2025 23:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 140007AE46B
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Aug 2025 21:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380CA28E574;
	Fri,  1 Aug 2025 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="D7ROtqjC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-75.smtpout.orange.fr [80.12.242.75])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AF41F9F70;
	Fri,  1 Aug 2025 21:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754083005; cv=none; b=TLIjCb/ZlwFqpEcfGzdGWDBAdIqNpiYGvAEbbaO40fQyWm3lfi/5MvH6kVcGu0jhXLmvWl6PL3Vbva1kEbieS73/9Vv2sgh+Uz5oQLxj0hyJt1UX18+UPykEseeivpF3yZWzrnbIQH8XoOY1z8IHdUvzx29YDoToGlwgroM+Id8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754083005; c=relaxed/simple;
	bh=cB8E+IiK84/sjDNniJugMqXQ0plFEnucL0t11Qs/fJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKecGtutZp9gOHgWC7+hB9YZH3Re20T02lqJtajq2xu51vYdL95DtVvzZO2ExKv8/Ma+sCQz0i60dEhFggp61sR87THGPDuGZ8JQgn3MLsytQ3zWEi+3JxMW+NKHj+rM0BT1JWm+23o+6yGN+9pSXbzf88WzGz0ZtRsqOptT9kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=D7ROtqjC; arc=none smtp.client-ip=80.12.242.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id hx64urnIfWKZshx64udVBe; Fri, 01 Aug 2025 23:15:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1754082928;
	bh=zf9gB3Bkl61hWd65WII9gJiaVB7imIErkHdmeSTRZuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=D7ROtqjCjaehqV0nh9oaauk9Uml9trRFXrv6mKTS9Gfjx8j92DlmWeFG73YoocCpH
	 YUtNz9dfMS6WL3abzCAvbWq8ljin8p06B9/e+v+H3gdgVPkZzDRuOyZOo6jZECKFb1
	 LEfuVzeILvzwvifwX5AsJEWxBEaYyEPMkxQ7+CfhnSTeS4nNkr3aPei3Rnd/u8QH2Y
	 NjuKVWA5R33RgKkgs0/ZQjY14dNXCwUf8b4SvoE7r/ldx1Jykal/1RCTYZ6k6ah/jD
	 DYyD6Y+rX9RXoHmVCd8UFHCyRwfohP29NAp1DRHS6Uiov6iL6hW9SI4NEbwWiVYuQX
	 VZ6y/r77kE/Mw==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 01 Aug 2025 23:15:28 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <7044823e-c263-4789-b83c-ecb1eccde04f@wanadoo.fr>
Date: Fri, 1 Aug 2025 23:15:24 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/14] net: ionic: Create an auxiliary device for rdma
 driver
To: Abhijit Gangurde <abhijit.gangurde@amd.com>, shannon.nelson@amd.com,
 brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, jgg@ziepe.ca,
 leon@kernel.org, andrew+netdev@lunn.ch
Cc: allen.hubbe@amd.com, nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
 <20250723173149.2568776-2-abhijit.gangurde@amd.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <20250723173149.2568776-2-abhijit.gangurde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 23/07/2025 à 19:31, Abhijit Gangurde a écrit :
> To support RDMA capable ethernet device, create an auxiliary device in
> the ionic Ethernet driver. The RDMA device is modeled as an auxiliary
> device to the Ethernet device.

...

> +static DEFINE_IDA(aux_ida);
> +
> +static void ionic_auxbus_release(struct device *dev)
> +{
> +	struct ionic_aux_dev *ionic_adev;
> +
> +	ionic_adev = container_of(dev, struct ionic_aux_dev, adev.dev);
> +	kfree(ionic_adev);
> +}
> +
> +int ionic_auxbus_register(struct ionic_lif *lif)

The 2 places that uses thus function don't check its error code.

> +{
> +	struct ionic_aux_dev *ionic_adev;
> +	struct auxiliary_device *aux_dev;
> +	int err, id;
> +
> +	if (!(le64_to_cpu(lif->ionic->ident.lif.capabilities) & IONIC_LIF_CAP_RDMA))
> +		return 0;
> +
> +	ionic_adev = kzalloc(sizeof(*ionic_adev), GFP_KERNEL);
> +	if (!ionic_adev)
> +		return -ENOMEM;
> +
> +	aux_dev = &ionic_adev->adev;
> +
> +	id = ida_alloc_range(&aux_ida, 0, INT_MAX, GFP_KERNEL);

Nitpick: why not just: ida_alloc(&aux_ida, GFP_KERNEL);

> +	if (id < 0) {
> +		dev_err(lif->ionic->dev, "Failed to allocate aux id: %d\n",
> +			id);
> +		err = id;
> +		goto err_adev_free;
> +	}
> +
> +	aux_dev->id = id;
> +	aux_dev->name = "rdma";
> +	aux_dev->dev.parent = &lif->ionic->pdev->dev;
> +	aux_dev->dev.release = ionic_auxbus_release;
> +	ionic_adev->lif = lif;
> +	err = auxiliary_device_init(aux_dev);
> +	if (err) {
> +		dev_err(lif->ionic->dev, "Failed to initialize %s aux device: %d\n",
> +			aux_dev->name, err);
> +		goto err_ida_free;
> +	}
> +
> +	err = auxiliary_device_add(aux_dev);
> +	if (err) {
> +		dev_err(lif->ionic->dev, "Failed to add %s aux device: %d\n",
> +			aux_dev->name, err);
> +		goto err_aux_uninit;
> +	}
> +
> +	lif->ionic_adev = ionic_adev;
> +
> +	return 0;
> +
> +err_aux_uninit:
> +	auxiliary_device_uninit(aux_dev);

I think a return err; is missing here, because, IMOH, 
auxiliary_device_uninit() will call put_device() that will trigger 
ionic_auxbus_release(). So kfree(ionic_adev) would be called twice.

I also think that ida_free() should also be ionic_auxbus_release() (just 
a guess, not checked in details)

> +err_ida_free:
> +	ida_free(&aux_ida, id);
> +err_adev_free:
> +	kfree(ionic_adev);
> +
> +	return err;
> +}
> +
> +void ionic_auxbus_unregister(struct ionic_lif *lif)
> +{
> +	struct auxiliary_device *aux_dev;
> +	int id;
> +
> +	mutex_lock(&lif->adev_lock);
> +	if (!lif->ionic_adev)
> +		goto out;
> +
> +	aux_dev = &lif->ionic_adev->adev;
> +	id = aux_dev->id;
> +
> +	auxiliary_device_delete(aux_dev);
> +	auxiliary_device_uninit(aux_dev);
> +	ida_free(&aux_ida, id);
> +
> +	lif->ionic_adev = NULL;
> +
> +out:
> +	mutex_unlock(&lif->adev_lock);
> +}

...

CJ

