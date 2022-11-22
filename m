Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891AF633E8E
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Nov 2022 15:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbiKVOKj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Nov 2022 09:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiKVOKM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Nov 2022 09:10:12 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E94068C43
        for <linux-rdma@vger.kernel.org>; Tue, 22 Nov 2022 06:08:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwEWZRuq5Vl2OJXbAxMdC51/8sXIx0MiSmrLfsAP//igacQ+0SuDZkS3iB+/bZZ9a5W+Bw+jqsqaDh7a3LE5NXNs9sW1OjAXHucj8inOzoigmnz+CsnyPjhLV9LqaVqBwJxEBImXke5qcY/R0rcd7ooRwqHPM1e1RctyP+Q4fu5PhJt+6JJRSNpI4JP7doXgwsRldGoCGfP0tmx6fQuCInx+dr0gkyNeHjjo+8U/u+BQdodvFpAPQ+uazqoVZCE1O3vzWSB1xzzX9Ss1hW/pKManLP/ZE8ecbePr2ehyRI1Qe9f/coxKUpp2UW/iywl39uRrw2D5o7Ul4XlXXqU96Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgqVCuo+RXiPgwkm9Gf5CVnlkFIXLPe0nYXL1VJVHKo=;
 b=GGULi3rXxYGUowxZGbpi5w8KX4R2NiT/LvnAWrQa5GvyCKoGtiggTDu3n8H3JYssGGOyOilunNNxlUXDTc/HulEXeTzgtuL+a7VhRw4VXuAMqDCATioHKrK/lzAkoH4Dr4P+O3etgLYRa5QvXFVYB1R5a1Y6vvrExKjtWTX5f2EmSB+K3YdgsD1ySBT4yE2V3XRo4kp4P/J1nxau3HCzVgBv679PduygY4OnvjSTfVTOiKkxEhbWCvcNkEcHA2ncOFwEkON/A56NQsxOS3VBkpCRBo8pFvaQ/Ynt5aFU2HT/LeANYmXzaLAJaEMHfpx5ao4GXa0c2XBNN8MHLvECoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgqVCuo+RXiPgwkm9Gf5CVnlkFIXLPe0nYXL1VJVHKo=;
 b=NmVdPcp61Mhp6sZu/8Im/L2NWh8qigLR1FRYtUZN7vLHphbYl51gdLTh4x/0++jxnYplan3Z0bY5Za7p0enYs/w8ftJviOcwMxCZADbswHGTXLQlbFl03hRvyLkxZT3aP1xVXa9lgvIZw78U3M/48H/ePlEGdyy/1EmUY8N0y2kWTEGiqcsEPoeMINtmFo8e7Qe6cnpWTiZ5cc98TYx5L/lRVEAdGs1wvi4LE4Hfyndnj7PlTmQs4aXDMZbTo9y5BKow71UFZ24BO+OXPbJZY0C0XPNznNTpKB3kCLCtgd+Ca1z+TQCaeBy4HIziT1TC2ovdxzU3i9qiEEyEzvUOvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 14:08:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 14:08:34 +0000
Date:   Tue, 22 Nov 2022 10:08:33 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chao Leng <lengchao@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [for-next PATCH] infiniband:cma: add a parameter for the packet
 lifetime
Message-ID: <Y3zX4RnA5yrZHaqV@nvidia.com>
References: <20221122090206.865-1-lengchao@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122090206.865-1-lengchao@huawei.com>
X-ClientProxiedBy: BL1PR13CA0158.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4500:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cd90eda-5f0e-4b05-dbb3-08dacc930af7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7L9fvbhMC8/nZxkvIRHL10jzrox8ulOrc3Zb5LQKsv3D1y6xXiDO4g0GyhUDTo2bH4Vzahi00FtuBfyt+Z4CrxRwM3cO1s8C+D5SJh3nA8eeeRuYRoorhH3f896HNRZgX2326AtCM1KEC6pC1Bje1kiEEJMO6VKpIBJ8KgDTplHEL4R1naKPzSTcI+P6SAm5NPNg8aQK2WsOiVYHEbVNNgWrDq0tX9DcoPxmjD6sVGgeUIn09S6UN/Qq3Onpi7zbV/9AuZ3GxhpDXBmjVjRHL/3XCHkWl5ihAfAfvu5YXmrnilZM/bEklfcKJlo7E1zgbX2B+SMYOdjqBs6RKpyXEfmA7ECoGNAiLMRKHdUv1p8gXzIjR1sAFG0xIPnX0AQ03xnDFDRXiJf2H329xhBvfpxx6xdE9LZkOlrSkagd5uZuJsicrAOkuNbR7nfabvKQLiehKVn4sXksH3nw6Ehlb8CFUwXGW1j1X3uZY/1CDHQ+bQWAtBqVUml6wvR9JMN0PVOOj18qWecY9sbeQbUAA43+P7Mn69FTTIWLTzjqHfq+QHNd6YJ1us4v35iTkUz4T8OthfFSvafTCg2/vRnmzUK7XynelZ3857PxTuZBFOyK5xKNwFpUZXwQJlYWgXYCVbgNkgimL3bYXFCmlp+WdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199015)(2906002)(66899015)(2616005)(6506007)(66556008)(66946007)(41300700001)(86362001)(36756003)(38100700002)(6916009)(83380400001)(4326008)(66476007)(8936002)(8676002)(186003)(6486002)(6512007)(26005)(478600001)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iaiU2opomB/5f0oIqadeADF0+ORQBQNIqcRioF1mlwW4JrPwo89fgiZYKa00?=
 =?us-ascii?Q?v8OeAnzhzNoWoT8/phvoeLIxQRmBlXCFwjAeZTjZk2J3uvLo+KUVhEQMNEvw?=
 =?us-ascii?Q?scPcyyaSSwuC8nLRro8PfMTJMILWJ+tHfeXTd8yrey+mUzH5wnXQD/7ZXEak?=
 =?us-ascii?Q?MLplDKe8Uoq08r2F4qWTKH6+AM2RS6Eg6hsnFSkaVFtpLsq3KMMhPmwCBSY2?=
 =?us-ascii?Q?8HCSfdyjbs82U2uq9JGrAjzN2kEK7Cebl9JM+SB61YePhrQN9AmWVDDDUJd4?=
 =?us-ascii?Q?waNOcklTQ5JKqsxopWFuwkWITW5co6kC5Ht0Gn+eAUSdAxwnsB0E3A0ZO8YD?=
 =?us-ascii?Q?3Xh5s1hQi11/tpqDY2hP6EJknDWBpdNvj1SUi/uVcj16Gs5Y053LepDu2+Pb?=
 =?us-ascii?Q?0lBGkdc9JWa0NIyWa0WOPKO8xPBqgszGoT/XQ/rSJPdi7hT+7YcKWcsMsAYc?=
 =?us-ascii?Q?2eHfEhjflJ8WJTmqxFyr4mpsP1Ox6Ryl7Sr6KRJ2GvyakZZyZRoTEzNEOWIB?=
 =?us-ascii?Q?Usd6bUl230X9vxtZjqqI+1vcELBV1W/FLbAwVgsJoaYTiQtdzEu9JkR8q/LR?=
 =?us-ascii?Q?CW2FkZCJaWy4tzTua3hJ1Jo82AT4Fmh31SUiW2IC8vgdhJ9471hHGIzLi6/d?=
 =?us-ascii?Q?pb5hbU5Awah9/fgUabCmj4XD1TxmSRpO4RRreAJKY/qtMtvXXiceraYTCh5l?=
 =?us-ascii?Q?KUBuFVudlempjwVu8G6DEKaQ+LkfAqgxPAaCMsh6x6QVIm2zqmNiSOPHJgck?=
 =?us-ascii?Q?5Z03Klf9DihPe2Hl0HgECfGJsZfsZpp6YrTwkGWW9GExv+rc26nhbfPU1Bxk?=
 =?us-ascii?Q?2UWLHaOf9eO8p51VrgIa5c0/9ZvcnDXOduvVrl9Jc5kTFksz8WjDgndknxd8?=
 =?us-ascii?Q?QCZBhb5QI4MBR3b3dt2lCwEJ4VYsfRSZtZIRurjlYZ3usP518aAMUYAvN5E5?=
 =?us-ascii?Q?bn6JjZbz8vbFn4O0EjroP1ZOxe+cX91utO0qSsTHxF7ocIM7034gSr0c971X?=
 =?us-ascii?Q?POaKAIWrPIZFir9yipVOCnAx37YgYSlSJ0R1K1x5QXMoX/H6Fv7HZLLWHANP?=
 =?us-ascii?Q?y00A6Y+CLrIQ3t1a1ViJNXO/VKjLwu2Lgqlw3akVklUfflH+DodGkDcKpRYW?=
 =?us-ascii?Q?J0hmO7QGVKiFj+xd/9e9g1nCzZ/CIEh3XNp2LPo9Hm4mi2kRni/fY4zrG88+?=
 =?us-ascii?Q?Lk1C73scoedRUXWHYwYdXv/OgRRDdJ8eo9aff2Op5/26Nh4Ut7hI60HmTmFP?=
 =?us-ascii?Q?b7xftY46DW83T/Y0usJ7bOeD3p+NpffXOG54gsZpl5L5dr8i9O0yL044ReHN?=
 =?us-ascii?Q?8vy4P6aTvFrWYZqiKNn1gYn8sZUYpgFIMPX11M+mrSKrJ/kD0YLxgxt7B8Mo?=
 =?us-ascii?Q?2/Q74qv893tvcZ3loS8GeKMpPTQoIO067//GluvFLs++wXBganttLd6prjxE?=
 =?us-ascii?Q?98NdbLpkiLcc+kJ4hd82CEf+ZuMCAv9s7/xMK/r5UURJWZAe3WsR6j2INYm1?=
 =?us-ascii?Q?kLy9ru0D8RYAWZTuLXbisTGucvJu4nRyzTeeunDezwXpv0HO6+QIB3MeKMBb?=
 =?us-ascii?Q?tBn882ZZBYAGxg/LaRA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd90eda-5f0e-4b05-dbb3-08dacc930af7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 14:08:34.3870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2TlDfSnH8CENTmjU7zf506tcQF1ojzRiFUvyIzWeV2CK7sE1eIRclQoqIp6cJswV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 22, 2022 at 05:02:06PM +0800, Chao Leng wrote:
> Now the default packet lifetime(CMA_IBOE_PACKET_LIFETIME) is 18.
> That means the minimum ack timeout is 2 seconds(2^(18+1)*4us=2.097seconds).
> The packet lifetime means the maximum transmission time of packets
> on the network, the maximum transmission time of packets is closely
> related to the network. 2 seconds is too long for simple lossless networks.
> The packet lifetime should allow the user to adjust according to the
> network situation.
> So add a parameter for the packet lifetime.
> 
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> ---
>  drivers/infiniband/core/cma.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index cc2222b85c88..8e2ff5d610e3 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -50,6 +50,10 @@ MODULE_LICENSE("Dual BSD/GPL");
>  #define CMA_IBOE_PACKET_LIFETIME 18
>  #define CMA_PREFERRED_ROCE_GID_TYPE IB_GID_TYPE_ROCE_UDP_ENCAP
>  
> +static unsigned char cma_packet_lifetime = CMA_IBOE_PACKET_LIFETIME;
> +module_param_named(packet_lifetime, cma_packet_lifetime, byte, 0644);
> +MODULE_PARM_DESC(packet_lifetime, "max transmission time of the packet");

No new module parameters

Maybe something in netlink would be appropriate, I'm not sure how
best to deal with this.

Really, the entire retransmit strategy in CM is not suitable for
ethernet networks, this is just one symptom.

Jason
