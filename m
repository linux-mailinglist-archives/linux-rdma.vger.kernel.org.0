Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1496A2729F4
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Sep 2020 17:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgIUP0I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Sep 2020 11:26:08 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:15985 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbgIUP0I (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Sep 2020 11:26:08 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f68c60c0000>; Mon, 21 Sep 2020 23:26:04 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Sep
 2020 15:26:04 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 21 Sep 2020 15:26:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCs8zoHZ9oSHvChHYpquP1mhPhiwRgw5n446lvOOHtBtuOFvqgj1jBgRnGBnYgV7S1qSUyERcjSFsXnOhbkojuyFvm61b5U7s4db9a5Zubc5++xbm9z1qyInzoFC9uX/CCRed3k2OL5po7rmziIAQuLmiw8rb1UVHDYS468WN5IpYtH4LPMS0xV5OZPe++RNXTujwf8CcxE/NASsS2aqA0MjRcH3p00m6uI3jxTR2qESJJaQjk28Bdk3R+jdQxoPrVfZxbTm4mw4R9PiJZDzhHJYASLsABqJoRARhQUumYYfSCxP1Ro2Y/QCBqdSqoka8mL5pMwUKL9wivvIXtZh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xl0iI8FK3mgSnB6nNZ3eLbn9NO3wgPmG2HKWyKaBB9Y=;
 b=ZRaf3YJ3K8xwyeTddxgOnamB4C7TNBGi7gFDM6hne8AsIM8YHM7vu3nPK01W1RP3IbTaGgWSFT5psqqjnM2cPDXgn8wcQXUqns6WKStfE6kBjaJMcIeVgR40xGIvojEycG2iBT568/ZP+hTLMo7v76OdfMsSIVz2OjlltuD14H+8v7ACp8dKDQ+1ktjqkeiUYBwdPnA2JGGKpHsVX7EKaFE12hRFHGNzSANtM+1Cx2gKtj7gqDPaNQO5JTDDEmSLHZMs+44j/+oCMKzFwMrVxsbX0eFI+cl0WW3TPfDxP2mLEeQwoLlouj1prib85eQhykcnGtL6tnqhUYHn6MXwww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 15:26:02 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Mon, 21 Sep 2020
 15:26:01 +0000
Date:   Mon, 21 Sep 2020 12:26:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yishai Hadas <yishaih@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH rdma-next v1 1/4] IB/core: Improve ODP to use
 hmm_range_fault()
Message-ID: <20200921152600.GV3699@nvidia.com>
References: <20200917112152.1075974-1-leon@kernel.org>
 <20200917112152.1075974-2-leon@kernel.org> <20200921142339.GT3699@nvidia.com>
 <4f3e52f3-2534-b109-0845-8d91f620f370@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4f3e52f3-2534-b109-0845-8d91f620f370@nvidia.com>
X-ClientProxiedBy: MN2PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:208:fc::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR02CA0007.namprd02.prod.outlook.com (2603:10b6:208:fc::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend Transport; Mon, 21 Sep 2020 15:26:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kKNhY-002eWw-Ft; Mon, 21 Sep 2020 12:26:00 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97bb6f10-07a2-4586-c9dc-08d85e42a5d4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4500:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4500B0554F3035C9CBB419B6C23A0@DM6PR12MB4500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pIZ0YJWOBQY3pg9n0td8f13ZC/ObPAxg8sjrXSuiyx/q6bkHdaCpOcF8hsmZTartcB/1sENrLXnnGMZcS28gmp/ex8vuLO1iURdO6JfUphprQuhLEpy2u+fbpaeCGyvravu4BJjnK9+F3LN5ecwyZjnXY9BUvVUJnFOq3vwkSCePQUCqKWwBt6yv0oqVj8YX7/C4RFODByYadzwS70x4HmZRCa7gqPqrCflS9vHAsj6lFMoImfCXefMOdnua/QHAxZscRdsul7j1Wl0kioxeAb4Cq4GewmvxT+SOP9V8KtiMECt4ynBNr72mvCZ82oEd8BQGFBAaAnLDYc7NEzoQsT4fG+19NCoO0imE9MaB4f6aKzbxei1nqBGOX0n+KrOf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(8936002)(478600001)(83380400001)(33656002)(4326008)(6862004)(26005)(2616005)(8676002)(2906002)(6636002)(36756003)(4744005)(9746002)(66476007)(66946007)(5660300002)(9786002)(186003)(86362001)(1076003)(37006003)(53546011)(54906003)(426003)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: OoYgzKCOSEeyIdbkEVP2/g76Nxl+ZqNFWyEYKII8o3xxkejTyj8YH5cp0pelasqcIIa+AOGMgPoy8LwccXshrnvFkT+HZ107F8+W0WqJdVMc4KcS7cHMTzO2xcidigCfLcbmHxk5TFQsW+VuQxoMiHAvAW2cl4GNX/zFPbLCzDzOLrPepCGwV4OY9SIO3R9rcGzBZN2gfqEDkwrJXh1gp2ke9ZLJS2PiEhRK7+EFUUnctiYun3IT5IMG1LsowSEx53emWv0Y1ztUJ4oIO1J/vlAaqEeFweikMPc9YXsgOsVr6ufXnlvVjmgo7Q3aWogOzoAYbSImhqWGx8R3NM0zeBar4h8I6Z2RQ+Abv7a5V5s4yk0ut5K5wuMnywXMHtWHuvla/oDnn25x7k7VvN/xO7qNgPGAWCsSI6UpG11obH2jXecBTCBTI0k0o4QdWjx2nrksebUeE5JHq4b5A0kTSlGnddoZ+GIyPKUP2Pgn9Hnn/0Gkyfm616qPiOiBY9vGpVmyioGxn9fj8cb98tjkEFSiRi9LW5+B9HS4syxDGxUEcsjQ5y+MMPt6rwZYX6B4CteoNiNcoz96jkXH1Zechnkuv5i0pKNP3t0eIV4EmVv/zkLoYZfAbpQ2ggJUnpLOEn9JzGzycGWKs5N+H/u8BQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 97bb6f10-07a2-4586-c9dc-08d85e42a5d4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 15:26:01.7972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4pE2mZfF24jlat19LIeQURmc+e51GJjC1yF1MU4aHZJAWFjr+NGnquuBqgYMgFb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4500
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600701964; bh=2Vp5kKcqySVvyXW1O/KFS9mKdWnLYX52QZxXZ2eEI4o=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:
         Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-MS-Exchange-Transport-Forked:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=Z6MicI6AR33df3iIlaB4jHlhgV0dg6lPKaDjQJmnC67tgqQAOcLapR3ju3c5oRx9M
         IZTDHCfgUcg/CT+iUVFW+YGDPIulaHjE0OVub21HfzuezY3xuqCCxWY+Z0nNtBbnuD
         gLtObQ+bY04F10mZjcnZYUakUAEkjt+KzMNHD42/lAHS5JO+HfDpJC8ZJGU3HWM343
         eXybbXgbiGkC6EdmmpsxIC8whMqKlRa8Pr0P1NOTIMM7LH5JFM1djslfaUx+OAPk3+
         AuNJ+YDUiDEmQMq51zvM86Hb89ETRPYPJLVlv8KZpD9VVgwQTa6BsnSJvyImd0T0zh
         Z3hewBFs06q5Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 21, 2020 at 06:17:51PM +0300, Yishai Hadas wrote:
> On 9/21/2020 5:23 PM, Jason Gunthorpe wrote:
> > On Thu, Sep 17, 2020 at 02:21:49PM +0300, Leon Romanovsky wrote:
> >=20
> > > -out:
> > > -	put_page(page);
> > > -	return ret;
> > > +	*dma_addr &=3D ODP_DMA_ADDR_MASK;
> > I thought we agreed to get rid of this because it must be zero?
> >=20
> > Jason
>=20
> At the end we agreed to not rely on as potentially dma_addr may be zero, =
the
> access flags are used=C2=A0 to mark an entry as valid in this case (see a=
lso
> ib_umem_odp_unmap_dma_pages).

I mean the mask, that masking is always a NOP or it is really broken

Jason
