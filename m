Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967892B994A
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Nov 2020 18:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgKSR1Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Nov 2020 12:27:25 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9239 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgKSR1Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Nov 2020 12:27:24 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb6ab070000>; Thu, 19 Nov 2020 09:27:35 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Nov
 2020 17:27:16 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 19 Nov 2020 17:27:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOOa3kMbYig8+2UkAjrw7Sme3EqQZWB6U6V/8FNJSOIuxnZHqn979GBu4uJje9JRdqpUlaw8Sv31YlETMwwMVES9enckB6MIkfVt1H16M/8077Ts1omlHuA/fSPj3vgP0/F2x+vXY/4dPe05Zew2LYC7IunsgmKBzraDgJuSfFMjOzCYEmlXArsholMWOCzVnIf1dxA3U4pZtXO8CL1KxX/1Sf1hL9O1cywHD/+ZDwl7glSaGfCMBKmBGJz6Pc2rUJybeWQWk/cxh8IiH62g0UkYNbsXNahjMOIviE2Yn4e0JdlQCXxc6KAiwPzD+nAVa0w+mCf86NGEAgL1zL0Osw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nq4AIvHY7eyNRcC3f6CPmmhGKdTrKA8KLwSfMOxyn5A=;
 b=Z2nS3Tbdg8wUZxFDsVEcJCxsQVhySpyjDLQklcNccDtfEpnrhtGicw5sBeknwXWzfxcBy3++v85f6kApIMSdfadKfyTyonWKsUGScBlR/dosK+i4Tsrme7BqsGFPriO9/bXkLnRyKVBpUd461tk8OW5TeA05xSvEJ7a8G25JQlOG0yjAAJgezmZ8KUSMe3+oLUg4R3dI2ohc/MiiDa9lzBsxdePEnVqHXdRPipGP1djGNAnEOz9QkFb76Uf0c8yUjQNJDD737+u47GCJBXUV2vC+FSubwAdRx5AsJ3PpexXxvSWQj0oregoLQ2hFOxYytrJbaaes5+wYYnsyq1HUGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1148.namprd12.prod.outlook.com (2603:10b6:3:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Thu, 19 Nov
 2020 17:27:15 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3589.022; Thu, 19 Nov 2020
 17:27:15 +0000
Date:   Thu, 19 Nov 2020 13:27:12 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     zhudi <zhudi21@huawei.com>, <shiraz.saleem@intel.com>
CC:     <faisal.latif@intel.com>, <linux-rdma@vger.kernel.org>,
        <rose.chen@huawei.com>
Subject: Re: [PATCH] RDMA/i40iw: Fix a mmap handler exploitation
Message-ID: <20201119172712.GA1973356@nvidia.com>
References: <20201119093523.7588-1-zhudi21@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201119093523.7588-1-zhudi21@huawei.com>
X-ClientProxiedBy: MN2PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:208:160::41) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR13CA0028.namprd13.prod.outlook.com (2603:10b6:208:160::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.13 via Frontend Transport; Thu, 19 Nov 2020 17:27:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kfniC-008IHv-Ve; Thu, 19 Nov 2020 13:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605806855; bh=yWodHp6AjxVOVb1Y7JJPLS9zPtpba8BVsfdYsQ0slMc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=naFnVRmAXnh3naQP+8NnkvJVASSJwUwvthGYNX0/EDyOF2OTjAd/PbHTl9JcU7+PC
         CANhBMQp+Uj/zUGXabHFkppXz1UOPjZcP41dhQXLXuemdmtEoiIaA/lSK6zX4ix/xg
         2mruPNtfuAtbNcYDBFCWiVvNyjpX0novZH63Nc3R+7AJqafSku34jrTdsm2z/MPGLM
         8pVg9UVER2iRvzO18b2Qol2ZGOIBFipOB8gji5AhUTEaOvEwuDyQ4qc244mtXzsofm
         NhXCc8kOjqz1NnQNsygI2elQ8Wyw9tQg+8VP3mrGj4IlK1oU3nF4y+KGOcO8wSAo/5
         8eoe/wrf9Lnyw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 19, 2020 at 05:35:23PM +0800, zhudi wrote:
> From: Di Zhu <zhudi21@huawei.com>
>=20
> Notice that i40iw_mmap() is used as mmap for file
> /dev/infiniband/uverbs%d and these files have access mode
> with 0666 specified by uverbs_devnode() and vma->vm_pgoff
> is directly used to calculate pfn which is passed in
> remap_pfn_range function without any valid validation.
>=20
> This would result in a malicious process being able to pass an arbitrary
> physical address to =E2=80=98mmap=E2=80=99 which would allow for access t=
o all of
> kernel memory from user space and eventually gain root privileges.
>=20
> So, we should check whether final calculated value of vm_pgoff is
> in range of specified pci resource before we use it to calculate
> pfn which is passed in remap_pfn_range
>=20
> Signed-off-by: Di Zhu <zhudi21@huawei.com>

needs a  fixes line
and cc stable

> ---
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c | 4 ++++
>  1 file changed, 4 insertions(+)

Wow. Yes, you are completely right, and this is a huge security flaw.

Shiraz, I think your company has some process for handling security
bugs of this magnitude, I suggest you get started.

I see the same bug exists in the irdma out of tree driver too.

> diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniba=
nd/hw/i40iw/i40iw_verbs.c
> index 5ad381800f4d..7ec8f221eadb 100644
> --- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> +++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> @@ -185,6 +185,10 @@ static int i40iw_mmap(struct ib_ucontext *context, s=
truct vm_area_struct *vma)
> =20
>  	vma->vm_pgoff +=3D db_addr_offset >> PAGE_SHIFT;
> =20
> +	if (vma->vm_pgoff >
> +		pci_resource_len(ucontext->iwdev->ldev->pcidev, 0) >> PAGE_SHIFT)
> +		return -EINVAL;

I am willing to apply this if Shiraz confirms it is OK

However, it is not the right fix. Shiraz you need to send me a patch
to make proper use of the new mmap cookie framework.

I see in the userspace there are only 3 acceptable values for offset:

- 0
- i40iw_ucreate_qp_resp->push_idx + I40IW_BASE_PUSH_PAGE
- i40iw_ucreate_qp_resp->push_idx + I40IW_BASE_PUSH_PAGE + 1

So create mmap cookies for only those values and derive the pfn only
from entry after extracting it from the cookie. This should also be
blocking access to parts of the BAR the process is not allowed to
access.

EFA has a pretty easy to follow example for the API in __efa_mmap:

	rdma_entry =3D rdma_user_mmap_entry_get(&ucontext->ibucontext, vma);
[..]
	pfn =3D entry->address >> PAGE_SHIFT;
[..]
		err =3D rdma_user_mmap_io(&ucontext->ibucontext, vma, pfn,
					entry->rdma_entry.npages * PAGE_SIZE,
					pgprot_noncached(vma->vm_page_prot),
					rdma_entry);

efa_user_mmap_entry_insert() shows how to get the cookie you'd return
in push_idx, for compatability you'd have to make some adjustments
here, but there are APIs for that too, mlx5 has examples.

Jason
