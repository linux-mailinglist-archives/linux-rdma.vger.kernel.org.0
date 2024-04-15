Return-Path: <linux-rdma+bounces-1944-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A588A575D
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Apr 2024 18:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 867DFB23D9D
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Apr 2024 16:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835C780C04;
	Mon, 15 Apr 2024 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZjKwUMqo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AF47FBA6
	for <linux-rdma@vger.kernel.org>; Mon, 15 Apr 2024 16:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197590; cv=none; b=D7KjcL2n9Py5HdK3frHxmUcCK2umcdmTQCs5NuPT3I8eagd2M2TMfK6fKrHUayo3jKnpmfv34OHBVGZakj6zUPtPRzUSWc5fO26tDSIi4+MeOGnhP2rxtcU0Ku2exSFKqQrsbTblfjj4FVDZb8CVxldMrOuJEP98lCP4+2HM7/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197590; c=relaxed/simple;
	bh=3txhU/uOLpNTBRjbxQmBVPq2bA1GUBYvBxcrijzixx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThMvX1X9pKswLA0t1Qnr9/H2NCj0bbOHQTh5mqa53awKemmn3nPUuTlkwFAnRfAiXtfG+MHd3QLhdU/eZnrzQ1WfNrBGasOhGUekP2ljHMKG1MlaRJEYdRNHL7qsy8YWhxoW+hd+L23poyguGD7xoweCoJ8wDuuvD9whRwxSa5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZjKwUMqo; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-434d0f63c31so14577441cf.1
        for <linux-rdma@vger.kernel.org>; Mon, 15 Apr 2024 09:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713197587; x=1713802387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=on+iLChflz05Dr/oXUYjGxNpjkJObC3efkHZq3cR0H4=;
        b=ZjKwUMqoA90oBHmVpe7Xx0DHnZ1fQROR9vxQKYtPJg84Ecb9bm/HjbOlMAZMyhSg1/
         MvUIapL9MB4IEm0uNhhwEo8pAXK77x+AM/RgVUPPRd3BvKHYY05lt1zZoo2d1csm7h/b
         9algl+2CpVYyPX9XM/b4q6MDtBCso6jMDLyMIyzZxlmJMROzJr29Myw9hqfk1xzk7PHb
         Xku0zjkwFejkxprHeybOYuJDd8MEheW6/OAtkn9c2sMjJba+qQStYO71cdRx++2nct2s
         twrfNNyyMCAuqb4dKNhLnd9PIXvXEpKiML+V8pt79S5Qls5XnxilPVE2N/jQGrbt1uzm
         70bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713197587; x=1713802387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=on+iLChflz05Dr/oXUYjGxNpjkJObC3efkHZq3cR0H4=;
        b=YT94N48dq+6k+7Ev4TI3W9oF2gtiOZBR5ajMrdb7axD1FJ3hZs56sS3vWzMF9ZognY
         89demERnz9iN4OOz69ZaEZt2IPuuJbz0UIz9XvPYHcFP15Yjd5ozNlQCk6QQzEVcSPYt
         dGzKwZwHNyCXeqtukd2PRPctogaGoVLVzkB2aWBu7fsUrRNvDq7Ql5Qzfbq4wv4u0Ap/
         iIAYj0/RvPoAaVx5cdOy3mMJRTpIIRnfyhXuze5ECzBl+SgxNz4wyuKPuiUaD9QOFSMo
         p7yrAmEkQU+LyKQVMvjHzF+0FzJL2LBcMnUoAYD8P3m5ilvLggC80UE3I1OFNth7KUAF
         yeuw==
X-Forwarded-Encrypted: i=1; AJvYcCUbS2ZgFNRESIyMacwUojvaI+pKf6hj9SHCq5E2m+1l4gViPf0GgMjYSk58gEQdX/QnXoy9jevA2B4Zu4zxtTSsJ0zm7cdrZzBpvQ==
X-Gm-Message-State: AOJu0YwmQQxzB1ds9QHnQm1YK5STY7Vb9bJ+0NzC6A2bgvCi49NITF/o
	2GQ/pN9wHfRYnY8wEoQzE6Szf98eTGbzOEWEdYDlDH1+IK94i8NlB590TK0ezgU=
X-Google-Smtp-Source: AGHT+IHyzaUorlIitkHhSGZXmR2GMsZtGczdvew6u4b3tEs8jO7YUxIlFj/Hon53gMR9WnKJ7zNFWQ==
X-Received: by 2002:ac8:5747:0:b0:434:9253:da0c with SMTP id 7-20020ac85747000000b004349253da0cmr12619578qtx.7.1713197586903;
        Mon, 15 Apr 2024 09:13:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id fp17-20020a05622a509100b004343d021503sm6144270qtb.67.2024.04.15.09.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:13:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rwOx7-006Br7-Sv;
	Mon, 15 Apr 2024 13:13:05 -0300
Date: Mon, 15 Apr 2024 13:13:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	Yury Norov <yury.norov@gmail.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Subject: Re: [PATCH net-next] net: mana: Add new device attributes for mana
Message-ID: <20240415161305.GO223006@ziepe.ca>
References: <1713174589-29243-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1713174589-29243-1-git-send-email-shradhagupta@linux.microsoft.com>

On Mon, Apr 15, 2024 at 02:49:49AM -0700, Shradha Gupta wrote:
> Add new device attributes to view multiport, msix, and adapter MTU
> setting for MANA device.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 74 +++++++++++++++++++
>  include/net/mana/gdma.h                       |  9 +++
>  2 files changed, 83 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 1332db9a08eb..6674a02cff06 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -1471,6 +1471,65 @@ static bool mana_is_pf(unsigned short dev_id)
>  	return dev_id == MANA_PF_DEVICE_ID;
>  }
>  
> +static ssize_t mana_attr_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct gdma_context *gc = pci_get_drvdata(pdev);
> +	struct mana_context *ac = gc->mana.driver_data;
> +
> +	if (strcmp(attr->attr.name, "mport") == 0)
> +		return snprintf(buf, PAGE_SIZE, "%d\n", ac->num_ports);
> +	else if (strcmp(attr->attr.name, "adapter_mtu") == 0)
> +		return snprintf(buf, PAGE_SIZE, "%d\n", gc->adapter_mtu);
> +	else if (strcmp(attr->attr.name, "msix") == 0)
> +		return snprintf(buf, PAGE_SIZE, "%d\n", gc->max_num_msix);
> +	else
> +		return -EINVAL;
> +

That is not how sysfs should be implemented at all, please find a
good example to copy from. Every attribute should use its own function
with the macros to link it into an attributes group and sysfs_emit
should be used for printing

Jason

