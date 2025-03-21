Return-Path: <linux-rdma+bounces-8892-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69798A6BD0F
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Mar 2025 15:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A5A175EF7
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Mar 2025 14:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AD01C5D5E;
	Fri, 21 Mar 2025 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lnBN/dqm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D557E80C02
	for <linux-rdma@vger.kernel.org>; Fri, 21 Mar 2025 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567642; cv=none; b=YsFO5Cug/QME3Qt2KYEmd20nQ0oLWnwGIb1HM3Cb1gqowYzH9b7eUJetB1YpPU1EhYHyz6PlUjOb2dqGFKTQ9amTZIdufg3odNA5sLjZnWkmnuDCWfgCpYLR9IY0kmvSc2JSEiiB3RklXwMl0aF2qvvXumZZxVw014keElQYvvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567642; c=relaxed/simple;
	bh=W/Choe4F+HesM2Ag6P961vQ3ByStwVx0DvebiOSt3yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFYYXzmi9X+8L445gLwUWnPHPloLBNXveRV2gfmkBA7+1gFoWb5IaDwyngc0CRZxZja0YWfmTB44N4BWHhRGhq+j0zL49oe8+9IzD4ZN9ctsoGHvJdwhXaH05HvhMWrWgxt8BKhDhsnqIXqKHwJZo5vNI6j0CdU0BZRVbJNoQd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lnBN/dqm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d0618746bso14384715e9.2
        for <linux-rdma@vger.kernel.org>; Fri, 21 Mar 2025 07:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567639; x=1743172439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NDFTE8hJf664+Rg33pEXoWr+oi9/NElSsovpV+SufLc=;
        b=lnBN/dqmCG9KLRNN7TjFxXnJ4osjn0+J8HisZMucyrceDREhNgD9JUFntlly8LcoVe
         m2p1FXFtK6rVb18gv+UY37j1orj/lYrA1f8N0iRveW7B0QljT9FndvGlkSyoYcx5Hnae
         ISAIxwV+/1SN/ybvYkqY6K/oTfXa8tgCvGzVUXgWe9PjM09yBURISsmRLCAc1IiugdJy
         uhItJKrwcR1G6bpT2qkCHCjjOL05LNcCYrL43zxTI2ikrlLyt/+VNp6SHpV/AsRBKgtu
         orU7GxSUZy28C1wJipaOmXwpxcMWOTFq4oKRVlYj+MSxka+NUYT5wMEE0l54Rlj9Ak36
         oyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567639; x=1743172439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDFTE8hJf664+Rg33pEXoWr+oi9/NElSsovpV+SufLc=;
        b=jXGXfHyGmsLSWWwXcC3HB0SfOdVmjuacZXhCeY7CEosIjC+82unk5X3RKKb0jfc8h4
         XUHcSyYGc2xtyXpTcHDL7Pmg7qX2yx6cNSAIUA/W2IhS+nsd4+4DPYIBNfBtIX4E+TpK
         zTt5RcwyAkz5q08dHBWV42BSsy07YJpyl0ZC8hMj9OWGZjUefOuxt083euDY23EkweCG
         ct/tLkwaHmAa3BdDkgmZxNLibRORJysQiy+CAOvHaLF+5pCfmcHmrzgMWc/8HdzPdJw8
         IdJHbRp2vKwwYf7Pxs+SRpMxRh1/h3JYi5/kTpSBmACWSl8WZgYId0vmqNEWVFeN9Igm
         rXkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoxckopa38bAQADYbBxBZGmUfPax29Kvino6Ynzwxd9+flOLqOKeiqROfNqpbNM3S5LwqcNHDVVeFv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Qbt97g/KYT6MsrnjXSiV7e+yUNPqOgR6NuFrv5ibLhYek1B7
	O4Z5JssDxue7nIKr7lQpLtFP/Oi2kPnuK9stVmG0R6TqGkPjhegG3Dz1H0RVwBQ=
X-Gm-Gg: ASbGncu9HbScdfpXuPmEh17if6uRr1aD5434rDnkWrtZGzzr/839paxhcCO1Sd+8isM
	kKIOXiZTC0RZIGrbyiJLM32+IeOzKHlUF7e7Ngnius71LZIORIfPtW6MjLdWYyMFMzh7ILzX4Y5
	0CM4vbFK2fs8F/tBFIBRakEfYEO7L7KD5YtlCpbFXUOYqg5PnLHKU2LCEQbUVlwRo5qhErAMaje
	cRYf9Wdc08VCGQoeDWbglFtkO+P+7gj4yshfIHQ6+me+qOefMjMYgPOXARMG1xA0gvvi0V1Osig
	DTxvTtYpB4EmSuoFlVgrNdARq9gynpUB/tlCGpgSjhrauk8dXQ==
X-Google-Smtp-Source: AGHT+IFdpuTjxTrv9Kov/yypsxqXIzm2gi8coNYKu88l+fHfLHxSWJRuscLkjzJoa+yqv+J8xaYecw==
X-Received: by 2002:a7b:c049:0:b0:43c:eeee:b70a with SMTP id 5b1f17b1804b1-43d5100a2camr26453555e9.22.1742567639045;
        Fri, 21 Mar 2025 07:33:59 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d4fd18365sm28619185e9.13.2025.03.21.07.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:33:58 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:33:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: jgg@nvidia.com, andrew.gospodarek@broadcom.com,
	aron.silverton@oracle.com, dan.j.williams@intel.com,
	daniel.vetter@ffwll.ch, dave.jiang@intel.com, dsahern@kernel.org,
	gregkh@linuxfoundation.org, hch@infradead.org, itayavr@nvidia.com,
	jiri@nvidia.com, Jonathan.Cameron@huawei.com, kuba@kernel.org,
	lbloch@nvidia.com, leonro@nvidia.com, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	saeedm@nvidia.com, brett.creeley@amd.com
Subject: Re: [PATCH v4 5/6] pds_fwctl: add rpc and query support
Message-ID: <ac2b001d-68eb-46c4-ac38-5207161ff104@stanley.mountain>
References: <20250319213237.63463-1-shannon.nelson@amd.com>
 <20250319213237.63463-6-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319213237.63463-6-shannon.nelson@amd.com>

On Wed, Mar 19, 2025 at 02:32:36PM -0700, Shannon Nelson wrote:
> +static struct pds_fwctl_query_data *pdsfc_get_endpoints(struct pdsfc_dev *pdsfc,
> +							dma_addr_t *pa)
> +{
> +	struct device *dev = &pdsfc->fwctl.dev;
> +	union pds_core_adminq_comp comp = {0};
> +	struct pds_fwctl_query_data *data;
> +	union pds_core_adminq_cmd cmd;
> +	dma_addr_t data_pa;
> +	int err;
> +
> +	data = dma_alloc_coherent(dev->parent, PAGE_SIZE, &data_pa, GFP_KERNEL);
> +	err = dma_mapping_error(dev, data_pa);
> +	if (err) {
> +		dev_err(dev, "Failed to map endpoint list\n");
> +		return ERR_PTR(err);
> +	}

This doesn't work.  The dma_alloc_coherent() function doesn't necessarily
initialize data_pa.  I don't know very much about DMA but can't we just
check:

	data = dma_alloc_coherent(dev->parent, PAGE_SIZE, &data_pa, GFP_KERNEL);
	if (!data)
		return ERR_PTR(-ENOMEM);

regards,
dan carpenter

> +
> +	cmd = (union pds_core_adminq_cmd) {
> +		.fwctl_query = {
> +			.opcode = PDS_FWCTL_CMD_QUERY,
> +			.entity = PDS_FWCTL_RPC_ROOT,
> +			.version = 0,
> +			.query_data_buf_len = cpu_to_le32(PAGE_SIZE),
> +			.query_data_buf_pa = cpu_to_le64(data_pa),
> +		}
> +	};
> +
> +	err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
> +	if (err) {
> +		dev_err(dev, "Failed to send adminq cmd opcode: %u entity: %u err: %d\n",
> +			cmd.fwctl_query.opcode, cmd.fwctl_query.entity, err);
> +		dma_free_coherent(dev->parent, PAGE_SIZE, data, data_pa);
> +		return ERR_PTR(err);
> +	}
> +
> +	*pa = data_pa;
> +
> +	return data;
> +}


