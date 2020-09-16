Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E692226CB94
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 22:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgIPU34 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Sep 2020 16:29:56 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:47744 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgIPRVj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Sep 2020 13:21:39 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6249800002>; Thu, 17 Sep 2020 01:21:04 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 16 Sep 2020 10:21:04 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 16 Sep 2020 10:21:04 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 16 Sep
 2020 17:21:04 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 16 Sep 2020 17:21:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6vdLNrP+fmhp6MqJznai3b6spROhhq5QblHYpA+C8kyxA8Z/NFHGhx/J8Ckp6A7f7gIj8O3woI1eMA+oDmGJebpd3WDh8F3Hi/BE5QM5X4TvttRVShRDL4xYpkMIlp3lMS2/MGxGOcp+8Z1GjN/MpbIQsk4h0iiCzXmvSvgp7D3SkrC7d/O0ua0YvRc6b8/2wzSgnQZQcd3Sfxoi/xr/FHaATXQj7Cr3Wshqdr2ae2Lw3LPnEVQwgL5Z5kY3B7EDSCobUCm0xeN0PfzvPQr+2PMCmGWKCV09o2JJLW6cI8eBdOzuJQG4XVfT1EF5FzPmjBFJww2IlGfMK09Ti2kQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKZjfT+BBBf52lE1vh/mjRFdH+5ptiP28Xn/3mbkuRA=;
 b=MryA/PXhZYOpu26ZIkdDN5JTUy5GuseG4mYRtdcym87mw+VSbfoqXXKb4Yl8OVWP2O0JdbuS0YKWvlCMY8wpnWHUerwbvOix4r5s0Hpcjyva7Zy8p9DNDrS6Atw0mjsErxk0VKXTuQlpC9VmgmMdKztsAXKzC2qQpCwEWsS7u/XnlX/zWK6PT+EOJdEgd/jv9uVr5hnh6iIOudL3Ctd9rJDGGWrhxCOwa2CN52mWLLfIx2JKSSs5b2pWdOzOJ3LsK6cc27gKloVJukvVqhCM3GoSG7dLKoaxBoSdVK9k+D6c3q5DcXCz8lgmsmymJNMySu1lJ9efIYpknnIncJkuJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3596.namprd12.prod.outlook.com (2603:10b6:5:3e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 17:21:02 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Wed, 16 Sep 2020
 17:21:02 +0000
Date:   Wed, 16 Sep 2020 14:21:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/4] IB/core: Improve ODP to use
 hmm_range_fault()
Message-ID: <20200916172100.GE3699@nvidia.com>
References: <20200914113949.346562-1-leon@kernel.org>
 <20200914113949.346562-2-leon@kernel.org>
 <20200916164516.GA11582@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200916164516.GA11582@infradead.org>
X-ClientProxiedBy: BL0PR02CA0109.namprd02.prod.outlook.com
 (2603:10b6:208:35::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0109.namprd02.prod.outlook.com (2603:10b6:208:35::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Wed, 16 Sep 2020 17:21:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kIb76-0005dm-KE; Wed, 16 Sep 2020 14:21:00 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d9e0621-33e5-4fc2-966b-08d85a64e2cb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3596:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3596A7419DCC547D81F9979AC2210@DM6PR12MB3596.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AWhV4MCGWmJDHRkRqiJA47yj8gV6ooJJeciq01az1uDebOTo2R8IVAeRYwXaJuand0RrMfZvy0Gvf6VPxZW/4RkdLtMhgYh6y0P/KbgJUxP5l+Lq1lWy5JbmR9Lrf6TYMBoS9OryQ0x6Nd1oe0Ev9eTgh3B+JmUYA8537yYO0U73+Sj7M9q0+T3eglyeNqFZpj95+gKGFBp/s6va6RB0nOgMQyc165PVWfGrSgGeFFl5nHowEH84Fe+rw7KCB8zys8q1KhoYl9FFo2ovcPvwwFCr/rYliEvB0lCz1SwvZTiwwI2erlvf6ycEj5Dk7h46Ye8awuEmE02Do/acklqFEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(9786002)(316002)(186003)(8676002)(2906002)(6916009)(36756003)(33656002)(4744005)(8936002)(66556008)(66476007)(26005)(9746002)(4326008)(86362001)(66946007)(1076003)(5660300002)(478600001)(426003)(83380400001)(54906003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Dkf/30m9ha+wPF6cVvRJftY3l4MnFMgaDpq5lVht5HP061fLivzF++duAg1o6k0gMT/v5wy1pOTVVx0dzfkzIJrs4eJfgrEfZTGENRMS3GnYPbMFA0U2jJ/iFHkCJdTD0bJTHAKz75YxqOIaZE13k/sfCArvIzOFmyCOqo5ZPEJc2L2MRGHB15oolFgx8EzD9qHdDaFruUO5mwtG4sgsDDehR4LRx9ywVqvk4w4ujf1qxyKK91OtmRDUaO9bMOAowW5Ni+MbvTDZOcw0lSNndzQ6MvaydWFW0+TiHry4/ovUxeZxxzD8ssCbUGblqb7rm4dvS3XpP11nqlu80OVb9erAfoYxC772QC8Ajt7mEwPegfyMYCD53/wxoP0DhCvSgSnzGqCKtdLhI18p+rClM5BJ0rbmjWfLZo/+TmQ2rmrmrEqxRv97qxtkkxWMTBDvnI1EQSob6Bf2Yr7/GfcUtwt4OtM495t06rArOk3aBuGGjUY13PvWnuDWVa4KqaY+Dl6SJXC37wqmIA0TL1skoz5BQ49FXM6MR6+2qSogiBXRVD1xr1ITD9HK9mabXOmlbXRrB9SxRLMXegFkPYdhc4zk0SqX6CTyPWwq7JRuqmv0h6bX84TVy6Huej8WXNzcUhr5RvJupWQd/Qiyb/MSVQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9e0621-33e5-4fc2-966b-08d85a64e2cb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 17:21:02.3046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvnq4b6O4mtJTt0JYPx9BMAiqibfGu73JSN83epP+1JsDt8Hp9DwhUKdZTDIpD+e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3596
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600276864; bh=cKZjfT+BBBf52lE1vh/mjRFdH+5ptiP28Xn/3mbkuRA=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Exchange-Transport-Forked:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=YiFCuMAwDNswL5gU9rEpIz+chwQD2ZI6HiKiYreFrUIHS+Xif14T84YqhpKR8Wj3u
         kFL46Ugf9lxJRYJws8Mf/1Rz0K5dMeVJKR5UG5JQZtmNPJ6U7c+A3XCdpPlF+3JXOH
         kfVyCqSNhE/Atea2OxoczZYVHa0AeXcMgyDwn4UYIPn8CmDOgetQTrrn47YOZLOWpN
         XH+f4IrY+x5w2l5Yy7sK+pViLMyQygsKWCMbn9OI4V0FgxlTMBBH3xlZT6vNvkxAVu
         fT/vofVyyuOR/atDKtEZanjTCbXH/NClLkANXOlZBfUmjcFYumXj+LE4nacZmWuE9g
         K++8B8cngOgrQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 16, 2020 at 05:45:16PM +0100, Christoph Hellwig wrote:
 
> Note that 0 is a valid DMA address.  I think due the access bit this
> works, but it is a little subtle..

It should be checked again carefully.. This looks a bit questionable
if the flags are what makes it work:

+               dma_addr = dma & ODP_DMA_ADDR_MASK;
+               if (dma_addr) {

> But more importantly except for (dma_addr_t)-1 (DMA_MAPPING_ERROR)
> all dma_addr_t values are valid, so taking more than a single bit
> from a dma_addr_t is not strictly speaking correct.

This is the result of dma_map_page(). The HW requires that
dma_map_page(page_size) returns a DMA address that is page_size
aligned, even for huge pages.

So at least the last 12 bits of the DMA address are always 0, they can
be used for flags. This is also the HW representation in the page
table.

Last time you pointed at this code you agreed this alignment was met,
is it still OK?

Jason
