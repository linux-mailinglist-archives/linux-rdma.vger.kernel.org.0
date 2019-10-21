Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D104DDF51F
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 20:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfJUSbv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 14:31:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26558 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726955AbfJUSbv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Oct 2019 14:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571682709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WlG+wz+lkBtRxzyiEF0b2PvSL0je5jeFY5DxP5d4mNY=;
        b=BxoDEIgLHEnu4ihEaZARN9zGTr30xTs7klouN3B3EqkwUz/AML6REqqseTLNvpm2HBobBD
        Q/+e8GDbdJd+Uq7OyCE+WTBMw6X9lvXP0fJdVxsSwK+PQit+R82CKjY/jYCDgxVd5rD57j
        RUW5nt60Ep4M0y1sTTFvmAMz6ST+9OM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-zS_LJt_qP3K6LOvuvx91fA-1; Mon, 21 Oct 2019 14:31:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89D4A800D41;
        Mon, 21 Oct 2019 18:31:44 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 80CE95DA2C;
        Mon, 21 Oct 2019 18:31:43 +0000 (UTC)
Date:   Mon, 21 Oct 2019 14:31:41 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH hmm 04/15] mm/hmm: define the pre-processor related parts
 of hmm.h even if disabled
Message-ID: <20191021183141.GB3177@redhat.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191015181242.8343-5-jgg@ziepe.ca>
MIME-Version: 1.0
In-Reply-To: <20191015181242.8343-5-jgg@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: zS_LJt_qP3K6LOvuvx91fA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 15, 2019 at 03:12:31PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>=20
> Only the function calls are stubbed out with static inlines that always
> fail. This is the standard way to write a header for an optional componen=
t
> and makes it easier for drivers that only optionally need HMM_MIRROR.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Reviewed-by: J=E9r=F4me Glisse <jglisse@redhat.com>

> ---
>  include/linux/hmm.h | 59 ++++++++++++++++++++++++++++++++++++---------
>  kernel/fork.c       |  1 -
>  2 files changed, 47 insertions(+), 13 deletions(-)
>=20
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 8ac1fd6a81af8f..2666eb08a40615 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -62,8 +62,6 @@
>  #include <linux/kconfig.h>
>  #include <asm/pgtable.h>
> =20
> -#ifdef CONFIG_HMM_MIRROR
> -
>  #include <linux/device.h>
>  #include <linux/migrate.h>
>  #include <linux/memremap.h>
> @@ -374,6 +372,15 @@ struct hmm_mirror {
>  =09struct list_head=09=09list;
>  };
> =20
> +/*
> + * Retry fault if non-blocking, drop mmap_sem and return -EAGAIN in that=
 case.
> + */
> +#define HMM_FAULT_ALLOW_RETRY=09=09(1 << 0)
> +
> +/* Don't fault in missing PTEs, just snapshot the current state. */
> +#define HMM_FAULT_SNAPSHOT=09=09(1 << 1)
> +
> +#ifdef CONFIG_HMM_MIRROR
>  int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)=
;
>  void hmm_mirror_unregister(struct hmm_mirror *mirror);
> =20
> @@ -383,14 +390,6 @@ void hmm_mirror_unregister(struct hmm_mirror *mirror=
);
>  int hmm_range_register(struct hmm_range *range, struct hmm_mirror *mirro=
r);
>  void hmm_range_unregister(struct hmm_range *range);
> =20
> -/*
> - * Retry fault if non-blocking, drop mmap_sem and return -EAGAIN in that=
 case.
> - */
> -#define HMM_FAULT_ALLOW_RETRY=09=09(1 << 0)
> -
> -/* Don't fault in missing PTEs, just snapshot the current state. */
> -#define HMM_FAULT_SNAPSHOT=09=09(1 << 1)
> -
>  long hmm_range_fault(struct hmm_range *range, unsigned int flags);
> =20
>  long hmm_range_dma_map(struct hmm_range *range,
> @@ -401,6 +400,44 @@ long hmm_range_dma_unmap(struct hmm_range *range,
>  =09=09=09 struct device *device,
>  =09=09=09 dma_addr_t *daddrs,
>  =09=09=09 bool dirty);
> +#else
> +int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)
> +{
> +=09return -EOPNOTSUPP;
> +}
> +
> +void hmm_mirror_unregister(struct hmm_mirror *mirror)
> +{
> +}
> +
> +int hmm_range_register(struct hmm_range *range, struct hmm_mirror *mirro=
r)
> +{
> +=09return -EOPNOTSUPP;
> +}
> +
> +void hmm_range_unregister(struct hmm_range *range)
> +{
> +}
> +
> +static inline long hmm_range_fault(struct hmm_range *range, unsigned int=
 flags)
> +{
> +=09return -EOPNOTSUPP;
> +}
> +
> +static inline long hmm_range_dma_map(struct hmm_range *range,
> +=09=09=09=09     struct device *device, dma_addr_t *daddrs,
> +=09=09=09=09     unsigned int flags)
> +{
> +=09return -EOPNOTSUPP;
> +}
> +
> +static inline long hmm_range_dma_unmap(struct hmm_range *range,
> +=09=09=09=09       struct device *device,
> +=09=09=09=09       dma_addr_t *daddrs, bool dirty)
> +{
> +=09return -EOPNOTSUPP;
> +}
> +#endif
> =20
>  /*
>   * HMM_RANGE_DEFAULT_TIMEOUT - default timeout (ms) when waiting for a r=
ange
> @@ -411,6 +448,4 @@ long hmm_range_dma_unmap(struct hmm_range *range,
>   */
>  #define HMM_RANGE_DEFAULT_TIMEOUT 1000
> =20
> -#endif /* IS_ENABLED(CONFIG_HMM_MIRROR) */
> -
>  #endif /* LINUX_HMM_H */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index f9572f41612628..4561a65d19db88 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -40,7 +40,6 @@
>  #include <linux/binfmts.h>
>  #include <linux/mman.h>
>  #include <linux/mmu_notifier.h>
> -#include <linux/hmm.h>
>  #include <linux/fs.h>
>  #include <linux/mm.h>
>  #include <linux/vmacache.h>
> --=20
> 2.23.0
>=20

