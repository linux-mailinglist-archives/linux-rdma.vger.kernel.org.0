Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65438250563
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 19:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHXRPQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 13:15:16 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10994 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbgHXROx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 13:14:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f43f57e0003>; Mon, 24 Aug 2020 10:14:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 24 Aug 2020 10:14:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 24 Aug 2020 10:14:52 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Aug
 2020 17:14:52 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 24 Aug 2020 17:14:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyGNmW1YVK0Dd//HEmax42Svj2Ju0Td1E4qSHbsptgEpWC/U6fdE34Vsvq2D0232c7yofrGpIGe/GbCFqAVyKU0xYRtwxiYx2N1QWSIYM/FNSc2D0YcnwpRcsAvgxSVI8X5wr16PYlmvD7iQIOCncMdMKyDUg/ICDt2d03vwQAEkdardlNc0uqRzEK7eK1w5/VnNhi2V4mU16aM8ByAChmktusWxfrK2LXzqvdlDeWCluMbKLDGAKNftswSgiai1QqPciZ+GO0Bp9tfxOLno4j43ecWgEG8b4epywFfaoedHKTs+qIBb6UmdQ5PWuX68Rxu2OSBZxxLbMvKQa0mNYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hujj+Ehobt//Hl8/SzXkbn1dJOYnGEQUnYyLCHfGBBs=;
 b=HV4TjlbItGSyPY8RmEYryicon82PBG165RT+53BAAc0scrHj82UmcGISti6KBOyy2CwHE4e5npvQV3cnXjcTh1FjMkE67KKF/46pN89KsrtTxGKtQ4pROBvr9TrpKHCaaiRnTgJDX0KuO7bJ19q51oq4LgYJVPBFq90YNE67b+Y+CiuV39v2FyLzKZxunnuzHiCJ4/kNluDLiSbwpbDlh6zERiOoiPUO0y0VuHbcM4FgdbVIplJVizYdlDdmMooMFdBewa4GLhXPoJUFV9rD7XLjYIZmaim6uMzoRKPH0LR3QoW8mDxZPRSf3QsJ9QtUpBDP2B/t7HzFrsZP/cm+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Mon, 24 Aug
 2020 17:14:44 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 17:14:44 +0000
Date:   Mon, 24 Aug 2020 14:14:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mohammad Heib <goody698@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, <yanjunz@mellanox.com>,
        <dledford@redhat.com>, <kamalheib1@gmail.com>, <leon@kernel.org>
Subject: Re: [PATCH] RDMA/rxe: prevent rxe creation on top of vlan interface
Message-ID: <20200824171442.GA3213679@nvidia.com>
References: <20200811150415.3693-1-goody698@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200811150415.3693-1-goody698@gmail.com>
X-ClientProxiedBy: BL0PR01CA0013.prod.exchangelabs.com (2603:10b6:208:71::26)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR01CA0013.prod.exchangelabs.com (2603:10b6:208:71::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 17:14:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kAG3O-00DU5y-HM; Mon, 24 Aug 2020 14:14:42 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb8bbf63-f622-4e95-162e-08d8485131d5
X-MS-TrafficTypeDiagnostic: DM6PR12MB2939:
X-Microsoft-Antispam-PRVS: <DM6PR12MB29395B64F379E1F3C6AC2314C2560@DM6PR12MB2939.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GBakNY481A2j4gTfoNmWo91bYD8rY9wvsrEhwbe78llax6GBOL1P4FrMQLC1E4fMgJrjk8WHG1Lumhl82HWbZxT68NAC4hdMg5e1S4yTr9hW4OLw/d6chCzB2WxCAsUZW4aBPnN863Lcub/kIw32QNox96i/cskBmsuNqHOYIV3kvg6QTiwyYnbLZKAp4YeQSLXnfm0hCA+UsCUNzGZ7ncFFFBKfq7fdbAo+7EgtdBGlpQBxwlNz4U9JQlLlCSe2O5ZN8K4E1ciB82Hl4XpiuNs1r30RBX0jF68ofdPLby2RURmPDKIVwrYfijqBvIZ9UMID9NgOeP4Gzd5evaMmdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(33656002)(2906002)(83380400001)(8936002)(5660300002)(26005)(2616005)(8676002)(426003)(186003)(66946007)(66556008)(66476007)(36756003)(4326008)(9746002)(478600001)(86362001)(316002)(9786002)(1076003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: xeHXgf+G/vPfs2r0ulcGA6Ca2zt+c8KhWBx6jQw+ZbTcSyDTUQ4O/WIC3hlw7coJP3BFDTsv2zRmEeeuTRcnN3RAp9U9Z7sgtV2YsTgA2CKFmteVoeOJqozrFrsIh3+DgDGXGkibrysmAyyuEKdTDpewmkC6cDqPian7a4PQBorjNBBG/0Ua+L6NMX7YbjUbEX6guOrBHQjnvE7+YJT8ePJTC04k/dMNK8qmq8c/GE9vALPaVkoJbpbJYPeEP37qMiDY/kJqJ+c4kgtbwkHaW3atqD184lDXV/UuLGcKmtmlD1PYbweFoR1FqATYCJSu3gSWsKruScK+bB8vMIiWtaJ8NV9Q5U/Uwk8CXcwm1EZaZswNHbgjBpnu4LIbFe7+ALJ+X2hDW0nFVUvP3tlz8FmpuCZFiBrEjXfjC0HVJhnx7ZSCJg+GryByxiM1te4mxpNFBbf3Hz/QAzq680e7Pu6lQ3KrcyKwomLHYj71F9pFX0DG5iqxpDJgqQRSofLvRETms/iY/XoL9J1ub4JwBWU6epsRdAPwJYbMA23JRcS8MhoTwAT680S/owQibzg7Ci1gmPx7bgSA3sGu8Z9fesPq+rZpn7n0tdTUXf1PEKLFTIpDuv3Hbc+ZWBxmeuRCgDAVzo65/0LAiJ3bS/nIzg==
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8bbf63-f622-4e95-162e-08d8485131d5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 17:14:44.1312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TrbJxdJqT285ChHsfPOEJjAJmPiReOKhcHyE+C2sObu2vhfEzqVuTQ092cGYTTK7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2939
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598289278; bh=hujj+Ehobt//Hl8/SzXkbn1dJOYnGEQUnYyLCHfGBBs=;
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
        b=nzU89bfhdo5hkXYgOyIo+xqA6n3Y1xSMnInkpCrOzKpdzkLSW7HgYjRs0PZ36FYHV
         uwjiJ9wi68f/iN9588g/MrHSI/WUeSm4HGIpj5pvIzoHGsOHcidQRwWQMaKCJGAIf8
         moIJIuM3G2oPPACmvo5KzMtxXt+vb233OdXdTlWKo9CD0Nkv/bsnF6nb2qhZH+JBa6
         SrCwAyyp8GRiqKecttuXTDn/nuDecLslSYAmoY5F7yU/zu76Hxbz162jzQjRDMPZXF
         vVh7HM/AAHPPL7kWAaJ9JfvYf6Dbopse9TfZq2bB47yYYu6prClKC7E4VlTfCCM34P
         K4FiYk1tGsCHQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 11, 2020 at 06:04:15PM +0300, Mohammad Heib wrote:
> Creating rxe device on top of vlan interface will create a non-functional device
> that has an empty gids table and can't be used for rdma cm communication.
> 
> This is caused by the logic in enum_all_gids_of_dev_cb()/is_eth_port_of_netdev(),
> which only considers networks connected to "upper devices" of the configured
> network device, resulting in an empty set of gids for a vlan interface,
> and attempts to connect via this rdma device fail in cm_init_av_for_response
> because no gids can be resolved.
> 
> apparently, this behavior was implemented to fit the HW-RoCE devices that create
> RoCE device per port, therefore RXE must behave the same like HW-RoCE devices
> and create rxe device per real device only.
> 
> In order to communicate via a vlan interface, the user must use the gid index of
> the vlan address instead of creating rxe over vlan.
> 
> Signed-off-by: Mohammad Heib <goody698@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.c       | 6 ++++++
>  drivers/infiniband/sw/rxe/rxe_sysfs.c | 6 ++++++
>  2 files changed, 12 insertions(+)

It would be better to somehow fix things so the gid table was properly
populated, but until that is done, blocking it is a reasonable thing
to do.

Applied to for-next, thanks

Jason
