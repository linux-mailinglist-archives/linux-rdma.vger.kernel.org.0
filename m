Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B3927ED81
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Sep 2020 17:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbgI3Pk0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Sep 2020 11:40:26 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14186 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgI3Pk0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Sep 2020 11:40:26 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f74a6830001>; Wed, 30 Sep 2020 08:38:43 -0700
Received: from [172.27.13.156] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 30 Sep
 2020 15:40:18 +0000
Subject: Re: [PATCH rdma-next v4 4/4] RDMA/umem: Move to allocate SG table
 from pages
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>,
        <intel-gfx@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Roland Scheidegger <sroland@vmware.com>,
        "Tvrtko Ursulin" <tvrtko.ursulin@intel.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>
References: <20200927064647.3106737-1-leon@kernel.org>
 <20200927064647.3106737-5-leon@kernel.org>
 <20200929195929.GA803555@nvidia.com> <20200930095321.GL3094@unreal>
 <20200930114527.GE816047@nvidia.com>
 <80c49ff1-52c7-638f-553f-9de8130b188d@nvidia.com>
 <20200930115837.GF816047@nvidia.com>
 <7e09167f-c57a-cdfe-a842-c920e9421e53@nvidia.com>
 <20200930151406.GM816047@nvidia.com>
From:   Maor Gottlieb <maorg@nvidia.com>
Message-ID: <086a82d3-fd3a-7160-dba4-c7b223585b88@nvidia.com>
Date:   Wed, 30 Sep 2020 18:40:15 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200930151406.GM816047@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601480324; bh=q/MX2HPw+Rl/oCY6oRvBsm/gn1tjQ5WhgRmOnWsAgQA=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=WaVIxgyVk3b9bgUcy85wupDJhbbDtGuPqHhr8jyeRr1uTOTwPSn80cEQrT2VOHqgO
         V22dizW+QUZgEduNkEJDaPoCQxGyxuLgvEVVDNSShG1qgWKQng8Nm/usd/GFlZRFfx
         CnNMioOZOhW8AYxa+gyh+TiWnPzfJSgsIotUhHtpoxBcs2LEsS/xvvCBS441nIJT+9
         jDa9BufMDv2CW7O5OP72rhLeXweRy1sB/RbvVFOvruWdozkaqS2TG6T5EAs+xAnf/a
         uWEk9j6KrRowRZKFMYqnJXa6UqzUJr/iKZUhLABwhFOi4SxRKt8TxXB7eS2LlK/kWc
         zJqt9g7z1xCJw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 9/30/2020 6:14 PM, Jason Gunthorpe wrote:
> On Wed, Sep 30, 2020 at 06:05:15PM +0300, Maor Gottlieb wrote:
>> This is right only for the last iteration. E.g. in the first iteration i=
n
>> case that there are more pages (left_pages), then we allocate
>> SG_MAX_SINGLE_ALLOC.=C2=A0 We don't know how many pages from the second =
iteration
>> will be squashed to the SGE from the first iteration.
> Well, it is 0 or 1 SGE's. Check if the first page is mergable and
> subtract one from the required length?
>
> I dislike this sg_mark_end() it is something that should be internal,
> IMHO.

I can move it to __sg_alloc_table_from_pages:

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sgt->nents =3D tmp_nents;
+ if (!left_pages)
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sg_mark_end(s);
 =C2=A0out:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return s;

>
> Jason
