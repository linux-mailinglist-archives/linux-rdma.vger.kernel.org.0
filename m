Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E954F518A
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Apr 2022 04:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357709AbiDFCFI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Apr 2022 22:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573718AbiDETwl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Apr 2022 15:52:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8953E1B7AB
        for <linux-rdma@vger.kernel.org>; Tue,  5 Apr 2022 12:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649188240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BMvE598geYS7AsLGKolv801H0ecrutTt3W25tuDKPtk=;
        b=VNcgCIl5LJHJawXZznG2tNgYk2irfqbxlQBZFdqRpFDA0H59shSI7qoj5qlC1RD5j/+uKZ
        D3BlDj7mxDRTH53j23FhvdfUUkBsMgHnia9kco3Uf/i430/R0QzUsUhUSyIbjI+uuSHyip
        uUWkEjX2aqjQcoZTWb5gU9H3Iq11Bho=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440-DHCoCz4WM9mQy33cdrGk6w-1; Tue, 05 Apr 2022 15:50:39 -0400
X-MC-Unique: DHCoCz4WM9mQy33cdrGk6w-1
Received: by mail-io1-f71.google.com with SMTP id y3-20020a056602178300b00645d25c30c1so212768iox.6
        for <linux-rdma@vger.kernel.org>; Tue, 05 Apr 2022 12:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=BMvE598geYS7AsLGKolv801H0ecrutTt3W25tuDKPtk=;
        b=PIFiyruAwhCafcOta8Io6/l4LZNM+iqS2+vKPkn/pWfDqBTR4v0g3vHBl1QSwhaxFB
         bVKFFebz3nBcYW5p7VTDPpFEmQHBfjQSAqoKSRR7RrGgjyvorEtq1ztvD77FuoGi3K+G
         x0MD0S12piNGUaQJjucJ8SD5ILiXlXClBIKYVyj6DbFzwyOvzl+AmEuDnb82OcxiTKTd
         CjdiU20jCFNbOS5JPi+xOlUDD2yzeQFWbmqAurFREz1FsyYHWtiEnxaNGbIceB13ZIpU
         z3dNohjpD+sWWcguZRoGzucLX1WOV8gUP3+lSngOLxG3UbwvDmaYuPt7uitsgXpjz5Fe
         AIpw==
X-Gm-Message-State: AOAM532l6wPleaMGwcpj2/H9RWEQOJy0rR6J0a0zBQLwqKYNZQndxnhX
        209RT+Y5wUiY8ReLxFgkhWH3JzHFVCunPxOTgJjk+et/Pm2UnKzSR1Dl8tuaj2SLs/x1Q6crZpy
        NMj44ZmjPLwjnWWsS2mmwMw==
X-Received: by 2002:a02:29c2:0:b0:323:a234:9df7 with SMTP id p185-20020a0229c2000000b00323a2349df7mr2968420jap.43.1649188238739;
        Tue, 05 Apr 2022 12:50:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCZgg4vIZs3ezp1ecKFvBApBInnRyJCHzNn5JkctUv/g96VC+Jzbb1H1znHS07OnzGhGeLgw==
X-Received: by 2002:a02:29c2:0:b0:323:a234:9df7 with SMTP id p185-20020a0229c2000000b00323a2349df7mr2968392jap.43.1649188238422;
        Tue, 05 Apr 2022 12:50:38 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id 13-20020a056e0211ad00b002ca32cb7a18sm5029165ilj.49.2022.04.05.12.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 12:50:37 -0700 (PDT)
Date:   Tue, 5 Apr 2022 13:50:36 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Christian Benvenuti <benve@cisco.com>,
        Cornelia Huck <cohuck@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        iommu@lists.linux-foundation.org, Jason Wang <jasowang@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nelson Escobar <neescoba@cisco.com>, netdev@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        virtualization@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 3/5] iommu: Introduce the domain op
 enforce_cache_coherency()
Message-ID: <20220405135036.4812c51e.alex.williamson@redhat.com>
In-Reply-To: <3-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com>
References: <0-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com>
        <3-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue,  5 Apr 2022 13:16:02 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> This new mechanism will replace using IOMMU_CAP_CACHE_COHERENCY and
> IOMMU_CACHE to control the no-snoop blocking behavior of the IOMMU.
> 
> Currently only Intel and AMD IOMMUs are known to support this
> feature. They both implement it as an IOPTE bit, that when set, will cause
> PCIe TLPs to that IOVA with the no-snoop bit set to be treated as though
> the no-snoop bit was clear.
> 
> The new API is triggered by calling enforce_cache_coherency() before
> mapping any IOVA to the domain which globally switches on no-snoop
> blocking. This allows other implementations that might block no-snoop
> globally and outside the IOPTE - AMD also documents such an HW capability.
> 
> Leave AMD out of sync with Intel and have it block no-snoop even for
> in-kernel users. This can be trivially resolved in a follow up patch.
> 
> Only VFIO will call this new API.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/amd/iommu.c   |  7 +++++++
>  drivers/iommu/intel/iommu.c | 14 +++++++++++++-
>  include/linux/intel-iommu.h |  1 +
>  include/linux/iommu.h       |  4 ++++
>  4 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index a1ada7bff44e61..e500b487eb3429 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2271,6 +2271,12 @@ static int amd_iommu_def_domain_type(struct device *dev)
>  	return 0;
>  }
>  
> +static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain)
> +{
> +	/* IOMMU_PTE_FC is always set */
> +	return true;
> +}
> +
>  const struct iommu_ops amd_iommu_ops = {
>  	.capable = amd_iommu_capable,
>  	.domain_alloc = amd_iommu_domain_alloc,
> @@ -2293,6 +2299,7 @@ const struct iommu_ops amd_iommu_ops = {
>  		.flush_iotlb_all = amd_iommu_flush_iotlb_all,
>  		.iotlb_sync	= amd_iommu_iotlb_sync,
>  		.free		= amd_iommu_domain_free,
> +		.enforce_cache_coherency = amd_iommu_enforce_cache_coherency,
>  	}
>  };
>  
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index df5c62ecf942b8..f08611a6cc4799 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4422,7 +4422,8 @@ static int intel_iommu_map(struct iommu_domain *domain,
>  		prot |= DMA_PTE_READ;
>  	if (iommu_prot & IOMMU_WRITE)
>  		prot |= DMA_PTE_WRITE;
> -	if ((iommu_prot & IOMMU_CACHE) && dmar_domain->iommu_snooping)
> +	if (((iommu_prot & IOMMU_CACHE) && dmar_domain->iommu_snooping) ||
> +	    dmar_domain->enforce_no_snoop)
>  		prot |= DMA_PTE_SNP;
>  
>  	max_addr = iova + size;
> @@ -4545,6 +4546,16 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
>  	return phys;
>  }
>  
> +static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
> +{
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +
> +	if (!dmar_domain->iommu_snooping)
> +		return false;
> +	dmar_domain->enforce_no_snoop = true;
> +	return true;
> +}

Don't we have issues if we try to set DMA_PTE_SNP on DMARs that don't
support it, ie. reserved register bit set in pte faults?  It seems
really inconsistent here that I could make a domain that supports
iommu_snooping, set enforce_no_snoop = true, then add another DMAR to
the domain that may not support iommu_snooping, I'd get false on the
subsequent enforcement test, but the dmar_domain is still trying to use
DMA_PTE_SNP.

There's also a disconnect, maybe just in the naming or documentation,
but if I call enforce_cache_coherency for a domain, that seems like the
domain should retain those semantics regardless of how it's modified,
ie. "enforced".  For example, if I tried to perform the above operation,
I should get a failure attaching the device that brings in the less
capable DMAR because the domain has been set to enforce this feature.

If the API is that I need to re-enforce_cache_coherency on every
modification of the domain, shouldn't dmar_domain->enforce_no_snoop
also return to a default value on domain changes?

Maybe this should be something like set_no_snoop_squashing with the
above semantics, it needs to be re-applied whenever the domain:device
composition changes?  Thanks,

Alex

> +
>  static bool intel_iommu_capable(enum iommu_cap cap)
>  {
>  	if (cap == IOMMU_CAP_CACHE_COHERENCY)
> @@ -4898,6 +4909,7 @@ const struct iommu_ops intel_iommu_ops = {
>  		.iotlb_sync		= intel_iommu_tlb_sync,
>  		.iova_to_phys		= intel_iommu_iova_to_phys,
>  		.free			= intel_iommu_domain_free,
> +		.enforce_cache_coherency = intel_iommu_enforce_cache_coherency,
>  	}
>  };
>  
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 2f9891cb3d0014..1f930c0c225d94 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -540,6 +540,7 @@ struct dmar_domain {
>  	u8 has_iotlb_device: 1;
>  	u8 iommu_coherency: 1;		/* indicate coherency of iommu access */
>  	u8 iommu_snooping: 1;		/* indicate snooping control feature */
> +	u8 enforce_no_snoop : 1;        /* Create IOPTEs with snoop control */
>  
>  	struct list_head devices;	/* all devices' list */
>  	struct iova_domain iovad;	/* iova's that belong to this domain */
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 9208eca4b0d1ac..fe4f24c469c373 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -272,6 +272,9 @@ struct iommu_ops {
>   * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
>   *            queue
>   * @iova_to_phys: translate iova to physical address
> + * @enforce_cache_coherency: Prevent any kind of DMA from bypassing IOMMU_CACHE,
> + *                           including no-snoop TLPs on PCIe or other platform
> + *                           specific mechanisms.
>   * @enable_nesting: Enable nesting
>   * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
>   * @free: Release the domain after use.
> @@ -300,6 +303,7 @@ struct iommu_domain_ops {
>  	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain,
>  				    dma_addr_t iova);
>  
> +	bool (*enforce_cache_coherency)(struct iommu_domain *domain);
>  	int (*enable_nesting)(struct iommu_domain *domain);
>  	int (*set_pgtable_quirks)(struct iommu_domain *domain,
>  				  unsigned long quirks);

