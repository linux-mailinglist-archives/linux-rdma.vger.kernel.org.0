Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AAC27EC10
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Sep 2020 17:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbgI3POS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Sep 2020 11:14:18 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:24075 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbgI3POP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Sep 2020 11:14:15 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f74a0c40000>; Wed, 30 Sep 2020 23:14:12 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 30 Sep
 2020 15:14:11 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 30 Sep 2020 15:14:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZssfSeVRejFr8QQLFZ8LgbSRmObinCMPlvtEli95uOgaQNGhiHXT4Acd0fBYG8s6qDGILP5isF5zAJGbGZmkrSw6zciDvPWk9Eu9+WhiU00h+VP2s8zpJsb9uhHGBm+zPEsHyJUo145Jru5+W2omvo0nMC0CWii6sipt9ELUAFo4+1t5HwMyGVziyufwrIR9xmDGcAp9xdSRdDx/Jb2qf1avUloc+MikLfQPgyfzBR8A27PqEBd1a2ToNOYYl+5i/ICLUnwUTMb5e9BSYnSRaPGJCRbh+JDfOp04LkrQ20J4v/fJ/O6Ab3y1yNznoPZ57ncM7IiS3IBdaprghj/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s25BWvSSYFaWscZEV8dpG8j2WBhhANw0myZWj3gyy+8=;
 b=oVeSBv9FhYSnFhZ0Z5cjiG+hHzpYWH3sgPE0kFPlR8AtCXqyK6CO+EVDsFMve9bkSXQSIOLwvq337Y7ybkoin47hTEkkqJMFD+j/IfGs/2vc7wPDIWBZBbJnzbcotM1Dt7E66kW2Z6pOXet90d4ypu8znaFZPoRbSiSPahlzO7c5wKo+LWXkkfPQSGdgcE7Gr4AwwMEWDW2/rqFDOMIKyJK3gewg8P1n/8Sfs0lVet2jTriGOA24ngGgPlplFnm7R4osKjSp++utHSfOZa6J5JtCO8BATjfAFr4i0ykv7e3BCAv+pkinJ9B0GtfxFm9SuPFyeivtfZVQy2Ws3J7ROA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3929.namprd12.prod.outlook.com (2603:10b6:5:148::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Wed, 30 Sep
 2020 15:14:08 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 15:14:08 +0000
Date:   Wed, 30 Sep 2020 12:14:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Maor Gottlieb <maorg@nvidia.com>
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
Subject: Re: [PATCH rdma-next v4 4/4] RDMA/umem: Move to allocate SG table
 from pages
Message-ID: <20200930151406.GM816047@nvidia.com>
References: <20200927064647.3106737-1-leon@kernel.org>
 <20200927064647.3106737-5-leon@kernel.org>
 <20200929195929.GA803555@nvidia.com> <20200930095321.GL3094@unreal>
 <20200930114527.GE816047@nvidia.com>
 <80c49ff1-52c7-638f-553f-9de8130b188d@nvidia.com>
 <20200930115837.GF816047@nvidia.com>
 <7e09167f-c57a-cdfe-a842-c920e9421e53@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7e09167f-c57a-cdfe-a842-c920e9421e53@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0038.namprd13.prod.outlook.com
 (2603:10b6:208:257::13) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0038.namprd13.prod.outlook.com (2603:10b6:208:257::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.18 via Frontend Transport; Wed, 30 Sep 2020 15:14:07 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kNdny-0048L3-Hh; Wed, 30 Sep 2020 12:14:06 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601478852; bh=hF+5rGDA7BuDnHsRnPwRle+nLbbEACSot6NWeuDv2dw=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=LXlkWM9QtDp96AciBbt2qrmve0czMpV3ul45q3cTlFlKk6uNa5Z/S1Mqv/qKrR/Le
         i3y5F1fxft1U/RzbfKbojNtTB0X7hMtuUuQ3WsYepRQecx5FHP0Wr4IHaeXF8TNFpq
         9EYOJwwVEx5cnlfoKJAmmsPhsdRv6jK9T87WTXr0+4yh0LQ1E4SkuYP/l9vIP0lBfl
         uavIda64znHsvaAd1VDEhRzTH2exRbVSp0GtNnoiypXJbSeu4WeWp5OrPF9r6FOrbn
         3PiSDM+GSHOO1P2+mkYByeIQKd0G3IvgjXokBFmFZ/v0KtcJfUxTXrmHv1HTt8twHA
         LRjNePO7Sdv5A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 30, 2020 at 06:05:15PM +0300, Maor Gottlieb wrote:
> This is right only for the last iteration. E.g. in the first iteration in
> case that there are more pages (left_pages), then we allocate
> SG_MAX_SINGLE_ALLOC.=C2=A0 We don't know how many pages from the second i=
teration
> will be squashed to the SGE from the first iteration.

Well, it is 0 or 1 SGE's. Check if the first page is mergable and
subtract one from the required length?

I dislike this sg_mark_end() it is something that should be internal,
IMHO.

Jason
