Return-Path: <linux-rdma+bounces-5085-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C14698565A
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2024 11:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DFED1F21C57
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2024 09:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB20315B11F;
	Wed, 25 Sep 2024 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UqAplvgs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C1315383F
	for <linux-rdma@vger.kernel.org>; Wed, 25 Sep 2024 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727256611; cv=none; b=aqrGtI8s8jnxvNQqhFYrD0SjA8QqzgXstd8ZSMsKdxPZwRP0VhsH3mwN7SO9EoTmgA1+cNvT4ywRA0o+UcbJnDxdBl2sMPgtDJYNpYIAQn26CviA3L2rdn3dQ/PVMw81ZHuafTJJeShIxaYnpILP1ixllAIeXOhzc4NuXpcPCdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727256611; c=relaxed/simple;
	bh=+M6tCwFRIpIxS54AbEQG7+gROUDT7WVllwKvSyeUHVc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xo2cn/DhPSmBJ5XKuBtJ8r5AeL1KVYFiZqHJKv+e50/VNs6U+m4WifnJU46EGraTs5F2ImfTr3UjjRgItqsWokzweGeKyUtHzrgQ46YjW9YnX9OwIUDIO4/kFSfLEvFsYp2riQxjS9hmYBYuV5obS/HZwdOC1q10Qa6GnKljR/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UqAplvgs; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-378e5d4a80eso4828300f8f.0
        for <linux-rdma@vger.kernel.org>; Wed, 25 Sep 2024 02:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727256608; x=1727861408; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HVEZsHvJCL9xcO2sH5tYsAcXBmQwhx1DvGy8bJiUmf4=;
        b=UqAplvgsTSr/RkK3/79DUKhLxN+fkB7tT40UulSC3zCD9ag2YvseLH5fQIElztBQQE
         sVU9COnga0b3Bf+zcBDSKRrZVtzw42y0YPBttjK+8Ktu26onqFAr8xozFrTxJK0Xx0D7
         B0q/EevMPFmZmlwJFf9z0q/HVVtU3jdUXu9+3vvowZ8GUMLLubDJBWchwe5YOBfg9WBD
         gjnluCUZ18mix0kWyT0Hba2v5BQvjZ3HbQOyaoJ0FVXFbspGZ9HUar5Z2upxvla4XCFC
         9HmxNpGCch8yuubvX2SMiS5koMdjApUdSlYsKn0ZfVg1tK7R7R0qi2nNUNzqRqOf+363
         93lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727256608; x=1727861408;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HVEZsHvJCL9xcO2sH5tYsAcXBmQwhx1DvGy8bJiUmf4=;
        b=OKdm7NiAsucFwKZ0xE5p1FOCkV9aANU8frix6eF+NqIiteOj8EF4lzY7K4+CJS7S7m
         9vBYGE49QH4kiIoQ0aFPg32TAEW0SC6Qve/tp/ONz8Zjq56538eSHOZP/ke6l4jsLed4
         HsU17N+ZiUAlpJhL35AgCu6Yk+gF0NS0VZErBLDJ4ck3aVUJeAMGFikYWT0zRAgpvAxj
         K5zC4GAZ+2aQ83DIjgwL5mD7BoTUhXZNT35I292scO8B1lR2wHxKtx1RxAh71+1YlzEW
         VYzyudBWpS6qb980JvwVXFlDrUarP0zuGjUERHGQ9eRbZIkrb+L1WdK4cEPBJ/OMzonA
         3djw==
X-Gm-Message-State: AOJu0Ywq/mBwECmojMWykAYymysQ9H0GHpenqL//NbuxVNvjkU674ioF
	OmlaIZoNlnpQvcasJ14ZoDaMytLVrmLbYc6fkFZ9dMS6k0uIiQRMu3CVcYrT9Lk=
X-Google-Smtp-Source: AGHT+IEfDBC7uXMYkDcoxI9OFnqdokPGfx+PNHxSvpvL95tlEECmqwqdVYqCG+gVIa+wbaTpiotDhw==
X-Received: by 2002:a5d:5e0b:0:b0:37c:cbd4:ec9 with SMTP id ffacd0b85a97d-37ccbd40fefmr254470f8f.5.1727256608055;
        Wed, 25 Sep 2024 02:30:08 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2a8c02sm3470267f8f.10.2024.09.25.02.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 02:30:07 -0700 (PDT)
Date: Wed, 25 Sep 2024 12:30:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chandramohan Akula <chandramohan.akula@broadcom.com>
Cc: linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/bnxt_re: Change aux driver data to en_info to hold
 more information
Message-ID: <93e73332-d1c4-40f7-a8f3-928600bdd975@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Chandramohan Akula,

Commit dee3da3422d5 ("RDMA/bnxt_re: Change aux driver data to en_info
to hold more information") from Sep 10, 2024 (linux-next), leads to
the following Smatch static checker warning:

    drivers/infiniband/hw/bnxt_re/main.c:1875 bnxt_re_add_device()
    error: NULL dereference inside function 'bnxt_re_update_en_info_rdev((0), en_info, adev)()'

drivers/infiniband/hw/bnxt_re/main.c
    1830 static int bnxt_re_add_device(struct auxiliary_device *adev, u8 op_type)
    1831 {
    1832         struct bnxt_aux_priv *aux_priv =
    1833                 container_of(adev, struct bnxt_aux_priv, aux_dev);
    1834         struct bnxt_re_en_dev_info *en_info;
    1835         struct bnxt_en_dev *en_dev;
    1836         struct bnxt_re_dev *rdev;
    1837         int rc;
    1838 
    1839         en_info = auxiliary_get_drvdata(adev);
    1840         en_dev = en_info->en_dev;
    1841 
    1842 
    1843         rdev = bnxt_re_dev_add(aux_priv, en_dev);
    1844         if (!rdev || !rdev_to_dev(rdev)) {
    1845                 rc = -ENOMEM;
    1846                 goto exit;
    1847         }
    1848 
    1849         bnxt_re_update_en_info_rdev(rdev, en_info, adev);
    1850 
    1851         rc = bnxt_re_dev_init(rdev, op_type);
    1852         if (rc)
    1853                 goto re_dev_dealloc;
    1854 
    1855         rc = bnxt_re_ib_init(rdev);
    1856         if (rc) {
    1857                 pr_err("Failed to register with IB: %s",
    1858                         aux_priv->aux_dev.name);
    1859                 goto re_dev_uninit;
    1860         }
    1861 
    1862         rdev->nb.notifier_call = bnxt_re_netdev_event;
    1863         rc = register_netdevice_notifier(&rdev->nb);
    1864         if (rc) {
    1865                 rdev->nb.notifier_call = NULL;
    1866                 pr_err("%s: Cannot register to netdevice_notifier",
    1867                        ROCE_DRV_MODULE_NAME);
    1868                 return rc;
    1869         }
    1870         bnxt_re_setup_cc(rdev, true);
    1871 
    1872         return 0;
    1873 
    1874 re_dev_uninit:
--> 1875         bnxt_re_update_en_info_rdev(NULL, en_info, adev);
                                             ^^^^
Passing NULL here will lead to a crash.

    1876         bnxt_re_dev_uninit(rdev, BNXT_RE_COMPLETE_REMOVE);
    1877 re_dev_dealloc:
    1878         ib_dealloc_device(&rdev->ibdev);
    1879 exit:
    1880         return rc;
    1881 }

regards,
dan carpenter

