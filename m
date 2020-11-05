Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0802A80FF
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 15:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbgKEOeU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 09:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKEOeT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Nov 2020 09:34:19 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21A8C0613CF
        for <linux-rdma@vger.kernel.org>; Thu,  5 Nov 2020 06:34:17 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id p12so1173368qtp.7
        for <linux-rdma@vger.kernel.org>; Thu, 05 Nov 2020 06:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I5rECYk/qu8iCaGcU6CltoiiEiUYjixQTANnN1V5Lm0=;
        b=BpHyF83c8VisTR39W6S5ccfgQByKDmir2lo8vkR5JM3jlQnNqfHGjowVKysk5gpPhK
         n3yULq08kY1GAiqGMRB9cViGD54NkjgicZmuTHbjGHd4p8W3YvAbNV1apoeUoWGJvleo
         iStYaIy2UACtuFhBjWhhB1kBIeW8fP0PWrwozESGAhwPh1ADT0iXE3SBASWtgfJdZeSW
         27x+JBCNX15rSelKQl1Mn2vjkXMLL6LGQcPq6xPi5D3lma2Tb3OUYYatGrDKTE/OILAX
         BQk7LcD1A5qshxOmFxzVxROJjWVpcey/I7oVeqwB+wBWxUTPwukTwcoxwpwYTbu7LC/1
         xixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I5rECYk/qu8iCaGcU6CltoiiEiUYjixQTANnN1V5Lm0=;
        b=kMAlJAYINWhH24mMWTVKpTyZ98D80H39xI7vi6nbhi7YI64tUk6Lt13oQ0VmNdQI5W
         Dek4Eicp1tEOdCS14NFXeYpiB8Re9s3vqHDqsOhdSbPsyfUuweUkYCCnOCADCtQk7B8w
         8cqw6LzpgCH+tEnUcu2boveTuaausGCTC87t8gl8mEY2M9+zYMxj3c3MRKudUcgs12gw
         7JyVFqD51TJ9OKjgLtXS9Ti6jIyWI3dprGGUsyj3vcJNVaTm/Z2TQzOfHzx6jzxL6F4U
         e0l1qhuRJD2TU5axsifQ2SqHK4+WGAxfKGg+jaURqMJrcWZ0nSNKMSBXlsFXwUvBlszN
         Gl4A==
X-Gm-Message-State: AOAM530W1C6qCM0i8/Q7iKNIBtPgxpCNKKrzU8m09fMeg47J6MxsCOG9
        54aqBIEdWPj+0pL973GVxMDg+O0Wqmm9OG9I
X-Google-Smtp-Source: ABdhPJx+gEzteow3B6jBiGbKO3tmtMId5XEoAWNmGBpXJ4b46a6vEg/U6TjnTg7sjzUg2oRcIwG5DQ==
X-Received: by 2002:ac8:6f1c:: with SMTP id g28mr2157920qtv.65.1604586857069;
        Thu, 05 Nov 2020 06:34:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id a128sm1090283qkc.68.2020.11.05.06.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:34:16 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kagL9-00HNlq-O2; Thu, 05 Nov 2020 10:34:15 -0400
Date:   Thu, 5 Nov 2020 10:34:15 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 3/6] RDMA/core: remove use of dma_virt_ops
Message-ID: <20201105143415.GB36674@ziepe.ca>
References: <20201105074205.1690638-1-hch@lst.de>
 <20201105074205.1690638-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105074205.1690638-4-hch@lst.de>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 05, 2020 at 08:42:02AM +0100, Christoph Hellwig wrote:
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 5f8fd7976034e0..661e4a22b3cb81 100644
> +++ b/include/rdma/ib_verbs.h
> @@ -3950,6 +3950,8 @@ static inline int ib_req_ncomp_notif(struct ib_cq *cq, int wc_cnt)
>   */
>  static inline int ib_dma_mapping_error(struct ib_device *dev, u64 dma_addr)
>  {
> +	if (!dev->dma_device)
> +		return 0;

How about:

static inline bool ib_uses_virt_dma(struct ib_device *dev)
{
	return IS_ENABLED(CONFIG_INFINIBAND_VIRT_DMA) && !dev->dma_device;
}

Which is a a little more guidance that driver authors need to set this
config symbol.

Jason
