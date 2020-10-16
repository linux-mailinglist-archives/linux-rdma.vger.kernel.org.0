Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C6B28FC17
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 02:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387691AbgJPAbk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Oct 2020 20:31:40 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:8295 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387608AbgJPAbj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Oct 2020 20:31:39 -0400
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f88e9e90000>; Fri, 16 Oct 2020 08:31:37 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Oct
 2020 00:31:32 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.59) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 16 Oct 2020 00:31:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYzXzM2zmcvJxEndEJ7HUywm5GE5gSPwWAHVMVZOR99gaGt9/ApTZJw9290kjrbYTQp3Q3yFg5jgsR8Mg/M1erWLnC+pehW7KthlWdcta0zg74XQ2h/FtrOnjHoHeDjAjF8ZpJFMsBFWYTvCB8rWXkg1FaS28wkLHj2Nwt0dp1SEbDzim69R1ejuLlW2H8zcLaXzGU+hAdhqOgRhXcHzHrD0xwy6B9Z6r4AtmfOjuAhfsLoQBhWuNH0xnPw5s59tyNSfQfJLkxAmHgRvemQ9W1IEpuvEz3UIKQFDGDhsaZfOvbQYv4r07m8j/HXyNhJiWXeUXnjvXCJC78yIGk9CBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBTQ48n7j9ipiE0LX5p8P4pU8ahzOIqKRTTPDCECQWw=;
 b=biMmCtiR1GQMxM3LEcS3GcojGzVAaC2MGC6p6QV409r9r5X5igZ0tECCCxXDrODClsKEdIelP0O/ewMjoTgN/mE5+YIYbHvNRv/CGxZb+/2wXoWbMorhdRgQBl1Q0wcTolGah7dupepgvJsujf46GEgcJDTsC6wGPxTsykCyzTPiHJQUOqHbyasRkkNpFZOsyZ1qhDIz1Lvt0HJkJhNjFv5LuYXXvPA7flviM0uH6+ceB4zBIBdQ9xTVNVoVDov8zEl34Ono9NN6+IBFCeEJAAamwauxGNkZBeG9Hwom6PribcQn8eX/BdBSomLp5YwvT9B6V84+2proWUCPcXoLyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3019.namprd12.prod.outlook.com (2603:10b6:5:3d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Fri, 16 Oct
 2020 00:31:29 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.020; Fri, 16 Oct 2020
 00:31:29 +0000
Date:   Thu, 15 Oct 2020 21:31:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Maor Gottlieb <maorg@nvidia.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Christoph Hellwig <hch@lst.de>
CC:     Gal Pressman <galpress@amazon.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: dynamic-sg patch has broken rdma_rxe
Message-ID: <20201016003127.GD6219@nvidia.com>
References: <0fdfc60e-ea93-8cf2-b23a-ce5d07d5fe33@gmail.com>
 <20201014225125.GC5316@nvidia.com>
 <e2763434-2f4f-9971-ae9d-62bab62b2e93@nvidia.com>
 <63997d02-827c-5a0d-c6a1-427cbeb4ef27@amazon.com>
 <8cf4796d-4dcb-ef5a-83ac-e11134eac99b@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8cf4796d-4dcb-ef5a-83ac-e11134eac99b@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:208:256::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0016.namprd13.prod.outlook.com (2603:10b6:208:256::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.10 via Frontend Transport; Fri, 16 Oct 2020 00:31:28 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kTDeZ-0009Lh-Kd; Thu, 15 Oct 2020 21:31:27 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602808297; bh=5B60WAGXn+l7PqCDZwGBlIBDv2h99Nc8vg7ic/m/qdI=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=QbxwJA7RLy+Jv3hDEt92o+9cIviInwC8lJqqnnUurjw1miin4ifnYCm+0AdStGdSO
         5BrU90MyFeAh9VoOkuGZigXUtfXPLtXpy0z/VSYS61kO3yD9mNMXTSgLCUaUEEfUQ+
         c721Kt6Gk8KsX5UUU7+ayWeDjcGmSDX2282Ppi6ZP9lDgTFLOYvZOr3g/EUWMLUlGq
         3aRqmd4KcZ+OLGuuH3tvk1hM7TSg5Hr+LczD7W+GQTfBlkv9PbHiypyZv0mw3BxnC+
         SJL/HRMiv9ntUXama5lV7cdBu9GQvv3v+qnkbZoa/7IJ/RwrTstUUR1nncWiz+QG9w
         EXjISos64wp1g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 15, 2020 at 03:21:34PM +0300, Maor Gottlieb wrote:
>=20
> On 10/15/2020 2:23 PM, Gal Pressman wrote:
> > On 15/10/2020 10:44, Maor Gottlieb wrote:
> > > On 10/15/2020 1:51 AM, Jason Gunthorpe wrote:
> > > > On Tue, Oct 13, 2020 at 09:33:14AM -0500, Bob Pearson wrote:
> > > > > Jason,
> > > > >=20
> > > > > Just pulled for-next and now hit the following warning.
> > > > > Register user space memory is not longer working.
> > > > > I am trying to debug this but if you have any idea where to look =
let me know.
> > > > The offset_in_page is wrong, but it is protecting some other logic.=
.
> > > >=20
> > > > Maor? Leon? Can you sort it out tomorrow?
> > > Leon and I investigated it. This check existed before my series to pr=
otect the
> > > alloc_table_from_pages logic. It's still relevant.
> > > This patch that broke it:=C2=A0 54816d3e69d1 ("RDMA: Explicitly pass =
in the
> > > dma_device to ib_register_device"), and according to below link it wa=
s
> > > expected.=C2=A0 The safest approach is to set the max_segment_size ba=
ck the 2GB in
> > > all drivers. What do you think?
> > >=20
> > > https://lore.kernel.org/linux-rdma/20200923072111.GA31828@infradead.o=
rg/
> > FWIW, EFA is broken as well (same call trace) so it's not just software=
 drivers.
>=20
> This is true to all drivers that call to ib_umem_get and set UINT_MAX=C2=
=A0 as
> max_segment_size.
> Jason,=C2=A0 maybe instead of set UINT_MAX as max_segment_size, need to s=
et
> SCATTERLIST_MAX_SEGMENT which does the required alignment.

SCATTERLIST_MAX_SEGMENT is almost never used, however there are lots
of places passing UINT_MAX or similar as the max_segsize for DMA.

The only place that does use it looks goofy to me:

	dma_set_max_seg_size(dev->dev, min_t(unsigned int, U32_MAX & PAGE_MASK,
					     SCATTERLIST_MAX_SEGMENT));

The seg_size should reflect the HW capability, not be mixed in with
knowledge about SGL internals. If the SGL can't build up to the HW
limit then it is fine to internally silently reduce it.

So I think we need to fix the scatterlist code, like below, and
just remove SCATTERLIST_MAX_SEGMENT completely.

It fixes things? Are you OK with this Christoph?

I need to get this fixed for the merge window PR I want to send on
Friday.

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index e102fdfaa75be7..d158033834cdbc 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -435,7 +435,9 @@ struct scatterlist *__sg_alloc_table_from_pages(struct =
sg_table *sgt,
 	unsigned int added_nents =3D 0;
 	struct scatterlist *s =3D prv;
=20
-	if (WARN_ON(!max_segment || offset_in_page(max_segment)))
+	/* Avoid overflow when computing sg_len + PAGE_SIZE */
+	max_segment =3D max_segment & PAGE_MASK;
+	if (WARN_ON(max_segment < PAGE_SIZE))
 		return ERR_PTR(-EINVAL);
=20
 	if (IS_ENABLED(CONFIG_ARCH_NO_SG_CHAIN) && prv)
