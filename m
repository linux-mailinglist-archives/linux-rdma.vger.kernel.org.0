Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64BA66CC1D
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jan 2023 18:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjAPRWa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Jan 2023 12:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbjAPRVG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Jan 2023 12:21:06 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7B12CFC5
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 08:59:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgqnyNnHGyqOpoCf/cyl0dtiNx0kN1rngMp2KD/D4Q66UN+IsheAIsN99Z5qpYG3y+B93YQR1r25zq6TK/CUDwXEV120HC/JPLrsT9Ekp5tZxyJ6ogiURGx5pD2tlUscwAE0U6r5VAaVJ77QObwluNwY0rjchl/QKxO+ZHHHIeioCICkeboxRtDc8K02++gv8bmgKpTX2w2Pyz8cjw7AWLStZvBsi/41LeD3yYMVJ95bcUIWqcGN26Ry5uHCMMKH9uFWPC6K792sQItbuGOZKkIvTwWLDeZ8UjHKXZQJrGOeQZZzG9BsA5Tj+vm8qCiB1EZjbl6cFg+1xK3FXYgIGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m69GSQNdhfTKhQOOooKie4eTPZ6x8HSu6L2ao3nGhXE=;
 b=hb6gSp9x/VMxbfEle0eVTo817eND/bfzeLrUNtMlLDVIm/vFKseUldepiKN/5ACRq+eqwSh83OI1sgwmtt1PIlhYFZjdWHXCwlRbWPsgoECNiiPNY9P4uUGIrnosFVqdUrKeLDg5BoVw4Qzb/JH3hqLw5YWsaOcEGRY5v47Dd2/kkosjqzcGtLeY/lHruqn59umlgO/y94lwmSmUnPEHhwykxSBx7zXz0+LT4zjIhZyqVWVM4FGMgIVSLIHXjKv/aNF2phjxH0l8LZPuElbY7tPBK9oAMYvgqeJMAelQj6iUsab04oKJQxXVs47ilhXeklMzyi4ibebAPZWmzkUSYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m69GSQNdhfTKhQOOooKie4eTPZ6x8HSu6L2ao3nGhXE=;
 b=HYWqVH5naGZMqKhlvAsHMzXc7RrGX2nk78P0pMX0b2ZJoHJRoFL8HdfPidast0FFkMvMO5mXWbDLUaclg04IqCFJ7HhUn2/ZyNnXAUuGOmg3uLXZ6MaSuPCKrKKzArvN0oSrshSy9efEURxD2DsoigDEkgl95cmppDbD/rd/kvpDqoC+7ZE/HG3kz6nX7vlm2xONANh7D/a9HEs3K1QoCDCtfHG9ASeG9qxBv0NYCenettZTKYEv2JuBjEmHH/RZ2A5C1+dDVO58BgqZKcHHW43byPMDtfCJ8TXAzGmL8lNW64iFD1my8zRc3gfDyJc3w4aAfQWtBUvq2fKTm7bGJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6599.namprd12.prod.outlook.com (2603:10b6:930:41::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Mon, 16 Jan
 2023 16:59:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 16:59:40 +0000
Date:   Mon, 16 Jan 2023 12:59:38 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Guralnik <michaelgur@nvidia.com>
Cc:     leonro@nvidia.com, linux-rdma@vger.kernel.org, maorg@nvidia.com,
        aharonl@nvidia.com
Subject: Re: [PATCH v4 rdma-next 2/6] RDMA/mlx5: Remove explicit ODP cache
 entry
Message-ID: <Y8WCetXDkjH3Au1W@nvidia.com>
References: <20230115133454.29000-1-michaelgur@nvidia.com>
 <20230115133454.29000-3-michaelgur@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230115133454.29000-3-michaelgur@nvidia.com>
X-ClientProxiedBy: MN2PR14CA0012.namprd14.prod.outlook.com
 (2603:10b6:208:23e::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c39532-aa4c-488a-31b3-08daf7e30e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8n43Dv5y2C9ApswKjg0Ds0mkEABJ0Pg2S5/s/Zru/nwh3kXXlpVSksM14V/0OFWPhwnp8W7B14H49vWNfChlFK0foBeGs8aqCVx1R3LFtmM0ADNqzsrC061jj/qYQjLRwe9JKa9V9zCR2SWSdvjYye3gO/cwaYts9DMtHZtfSqwr9lbJW1I7dZ/hVNSob9LnH+15Zvc2sTMZr5HauKnZqGdcQqBtIkhzs01YouzMFdknoK3BYEVkBGQLisQPLZN/LpL4iIZhFtRJALSZfPrGxf8YHz40hLsE754uScuWp6UxvtuOFLYMVemzYPW0p4NCyPQNopTjiCXC2d32iCP+QUUqlLFrmCIWh+SZD9GCbcE7hEjfVfF4wnUHaMYPt4pTgZcAYEoPyuvBV0FL3LltBk/VOK3pP/V8/iYuj3AOvf9llyyvwTeXwWbnqSXXKTqu1qghpNUcRgnKp5Z7LLyF5Yrv8O0kCFVp0Yow5GjgQ22/0iT6JARThHQrLVmTAA6AlYp672WsJvavKKBzpMuJCfkUd7u6cEgdUSGzCyaGCTkr2CkmtJVPbqthcmtkXmzr7RhxTTlcCI435u2ADVfsb2cVTys8zlaROZvaHkZn0AtrgwK/vIdgf7lb4NwFtjMRTeM/r4/VZvrlo9LeVkFTCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199015)(41300700001)(36756003)(6512007)(5660300002)(8936002)(6862004)(186003)(26005)(6486002)(478600001)(66946007)(2616005)(6636002)(107886003)(6506007)(83380400001)(37006003)(316002)(66476007)(4326008)(66556008)(86362001)(8676002)(38100700002)(66899015)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7nzK3j5nOjDZERGabtVbuA+enWOYEb40+NKqCo9mN1cc9Hn2Tr6airw8Q8dc?=
 =?us-ascii?Q?aPiX9C51tu86U0jAY/2wK+R0vU9XhLst94DFTps5I+DtQ+l/gaYh+e7cF9Ty?=
 =?us-ascii?Q?YkLLzboN11VDDZMuO1lkInNE5x2eQ99ftIsMybZ1tCnCNXv9I5nw43/3BOXg?=
 =?us-ascii?Q?oddFW6B4hK1+FLXQWXWBf8Tq440BlIkIQ3y8/rb1Eq1q93O2CtHiY6MNQ8I6?=
 =?us-ascii?Q?jnUXsxndOrwC5475cNMp3ON4pFGVKPfIUrdHuhslMWhKncbt+QwD9ONiTWQL?=
 =?us-ascii?Q?nFDn88xcPL1OWD8/K8ds19w48YGG2z8W2ruPVEwsy2bOHTEsz+4CizGeVhJh?=
 =?us-ascii?Q?YvvE96sGUPMoY9xOnlTFev+WQ/zY2sgnl1H3jZdb9yk6gM5ctz6rmM1XZqiR?=
 =?us-ascii?Q?eTluye6V896bi0uyByKf9WN7806p4o895Hw69sI02xXMAJXJn66h1Rn4Earv?=
 =?us-ascii?Q?5NuxEPkgqAdqIdIrGYbPsroWnNF844VY8y1N6XcnybYYu6U0HeJil81W6/+S?=
 =?us-ascii?Q?e8nVEx+r+VD3u8cbCF41IvuKXS48Aioq5IRhZh4RP62RWohJcXLl7qf0lXbH?=
 =?us-ascii?Q?5YgplZdjDmDYtHhMLtYCEQnywr+vHHd7ApefIfcHdo97T2emv3mb+JH41TYo?=
 =?us-ascii?Q?SM22fXyx8W6RkwlVRd5dKcv3IEBswXXXEew817TWTHli/oqmQJZevBT5vUfM?=
 =?us-ascii?Q?Er4UvySN/aLy6ZKlnJYCTrmDtE7te42eGNRVB2VF3o4LncAReltklHGMl61q?=
 =?us-ascii?Q?zfrcGXDVfmH+5E8ndz9eTmNvyE/44lsl7PLaPJTewph1bHT0vEH6SRWMQaKn?=
 =?us-ascii?Q?xrcnAcfgCYbg2GuM2U7H9l0R4DoK5spCXG5KtQjximemVYBZnKffz8MdPUop?=
 =?us-ascii?Q?sIGcJ0At1VwUq/Kw2/f1xfaFlJozyfGkXNksoQLRnc2yorf9QgDdiBaQ3tzq?=
 =?us-ascii?Q?QBRjoTBG5cqP3jKSknyPoRwbPzHdqWwkduASnGDHKbppN7TG5+JgbVYBth0l?=
 =?us-ascii?Q?pwiHoGxK9Eqo9lNjwh4v1ylWNwie1D5OZgvXA8xwhuNin9arh0VM4+3A8N15?=
 =?us-ascii?Q?zSXa0C6udRU0RiOxDmDfYtJwKFjLPf7vJP6N0CAC7QKYQGsQj5sRNUkeqbNi?=
 =?us-ascii?Q?2fj1KQAOx3boTsK7LDH0/UUSpOJyeqzElPv4X9GuonKSPAq13NHbIRzQ/QjD?=
 =?us-ascii?Q?l9nMp6BwwNBfeLCfdbH4hsWqJHr0Tx0HwaJhz+QrVzpf0vO0CxiMdpaxjwLG?=
 =?us-ascii?Q?R6sNiI0rodQYnvRtmlJgSzvM+ml477C+41pcKDdV0rmXZkanb7sB6snn9bos?=
 =?us-ascii?Q?Q9QxJf4oGyh1GrCZzTukHHVjJ674oHCe/FN34gg1Ya/bG+lnNOTGD1/VE30+?=
 =?us-ascii?Q?kHbE5fofBycHKFdTG7gY3MbR5ShMplTdE5C0+BKunOxquzaW7mhmX9+Oq4eS?=
 =?us-ascii?Q?kNCEO6ePODlA5oCa98lCdEPSyIzh1D1upjoTblvzqiCch5v9nGwbKmDyKaHO?=
 =?us-ascii?Q?ebmF/wCY3+cn4ehxS0XKk63rQoMfBebVRHiS8TXNfYfv8iCXY/n4ddsBveMB?=
 =?us-ascii?Q?PQwFfQWOFuLqr2KVYHZKfqzuv9vFpCZaTo7oRbOx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c39532-aa4c-488a-31b3-08daf7e30e8a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 16:59:40.1014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6FMkk9ZM9HJgrd2+cu4MUx25Tji6UYilz4h1fXtlmSIrhi8pm7ANaHk7pnhGvQj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6599
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 15, 2023 at 03:34:50PM +0200, Michael Guralnik wrote:
> From: Aharon Landau <aharonl@nvidia.com>
> 
> Explicit ODP mkey doesn't have unique properties. It shares the same
> properties as the order 18 cache entry. There is no need to devote a special
> entry for that.

IMR is "implicit mr" for implicit ODP, the commit message is wrong

> @@ -1591,20 +1593,8 @@ void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent)
>  {
>  	if (!(ent->dev->odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
>  		return;
> -
> -	switch (ent->order - 2) {
> -	case MLX5_IMR_MTT_CACHE_ENTRY:
> -		ent->ndescs = MLX5_IMR_MTT_ENTRIES;
> -		ent->access_mode = MLX5_MKC_ACCESS_MODE_MTT;
> -		ent->limit = 0;
> -		break;
> -
> -	case MLX5_IMR_KSM_CACHE_ENTRY:
> -		ent->ndescs = mlx5_imr_ksm_entries;
> -		ent->access_mode = MLX5_MKC_ACCESS_MODE_KSM;
> -		ent->limit = 0;
> -		break;
> -	}
> +	ent->ndescs = mlx5_imr_ksm_entries;
> +	ent->access_mode = MLX5_MKC_ACCESS_MODE_KSM;

And you didn't answer my question, is this URMable?

Because I don't quite understand how this can work at this point, for
lower orders the access_mode is assumed to be MTT, a KLM cannot be put
in a low order entry at this point.

Ideally you'd teach UMR to switch between MTT/KSM and then the cache
is fine, size the amount of space required based on the number of
bytes in the memory.

Jason
