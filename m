Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C907BA6AD
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Oct 2023 18:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjJEQke convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 5 Oct 2023 12:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbjJEQjV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Oct 2023 12:39:21 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4044492
        for <linux-rdma@vger.kernel.org>; Wed,  4 Oct 2023 21:45:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXmFqzxnAdhPmpd22q6R+JvYxI38/EtbH2m8bcMfNVxPq7BgkGMomlgO9mNpPyC62Qws6jXTy1fLur+D6A8zkFovYa2FQl5HMF8PLrL6TKHywpkMFTPDYUtm7opg9kIPjDbMeytHf+hTbF6KhA++eJQ6mWpm4fC7gPowcJH0/ay8hGwUW+VQ9UC14kkqU9so1+ClL0NduVpooCFfWAQPtFIO1FJdMUE2estPT1wsxte/0zvpRq6FdQE6QVcGfX3Sp/NsQi2vO6YTB+4i8lAJe7GneLDIKQ3kxj8o5Vw+10GKhOLvWKvCOsO8YHXHPEW2Bh3Z36vnXdWrtilUokzdhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuhxY+hkYAyks91OkLYtNt+FLuUkhBf/Ud5nOSH3j3M=;
 b=Q4mtW1OT+bWac5Eix+wS4RRZszg4CI+Xj5Yd0Nk22FalKfkK52B+wrN57DWh1rXpeFbcKHuipJDEOA4WiL9FDu5cbr/f4Sh/PlPEacXBhUuVISoRryaj16C81nh2Y/yC3DjD5uAKQBQ3seVQqKh+F8i0CQ9LsEWolzSlmTYwOJyvdn2KsplCiIbuirte2OizDlETYa8fxeb1x3FbdghrfXhtt/s0hr0lok0v2h1MTx5boQot17ehJd6zVaTjQoTFNmgYpkp+5fM1F7NQKZxO6hVcqrp1r/fNv9xfeHkuq64BCCCDHffPWLzYrgWGhTybFrDyUgOXolnU7e2GCYhDQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DS7PR12MB8274.namprd12.prod.outlook.com (2603:10b6:8:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Thu, 5 Oct
 2023 04:44:54 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 04:44:54 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leonro@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-rc] RDMA/core: Require admin capabilities to set
 system parameters
Thread-Topic: [PATCH rdma-rc] RDMA/core: Require admin capabilities to set
 system parameters
Thread-Index: AQHZ9u8dauug70g/Ck219+gVfqfff7A6n07g
Date:   Thu, 5 Oct 2023 04:44:53 +0000
Message-ID: <PH0PR12MB548137A0C6B51FE63379D7B4DCCAA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <75d329fdd7381b52cbdf87910bef16c9965abb1f.1696443438.git.leon@kernel.org>
In-Reply-To: <75d329fdd7381b52cbdf87910bef16c9965abb1f.1696443438.git.leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mellanox.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS7PR12MB8274:EE_
x-ms-office365-filtering-correlation-id: 28494747-b3ec-42c9-95f1-08dbc55dd15e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H3aXI14OQ1xrLW8u3zMphXV0y7teGk6sUYMNuvsjK91uUSclOZwEo5UchcHp/P+yKDpER8tG8nEtemfK2MKQOcswd9LQbSHbS/rEGxtj1RSBf4+tghHHc9jMbGnJmEBfE9eJ3rQBXlryUfzEUNIvRf+y7HvqqP77lIiS0WV/drzb8q2f/u6Taf7pf2ScubpvkiruJ86bVIT6EnrgRUek87ur1l3cgWrLs3u4sPP41PrqHKo9E044fhkobtybS7D5GmK6AuMrPN+iBFwCM7GGe0frAUnCe4o+NZ5GuCWvp4b5MAT6/pWy+88rWo6AmwbgdOsWq49m0dmBjZs5rkgNSsvPlcVviBlQMjOG0d6l+xeoM/qhcDulswgii+912AAm/i3GEJpD7jT5hqPkgeSP79uxRAMQF3Vj0ZE4rabsT9LdC8sC/ssRe4JQCYfFKOvp5MXKncDsz9HZJQ3/iTOZoehkjBkGm1pCHxMSsvdvQmajlrEpHx9qPPXeS7CFf6vG8jDmYzLeo2Blu+9erqeEyrmeIb2bqVkQAqlxVW+17YLgREG+WbCmLj/Frpw7FBVkIJJDzBx/D8xO4pZKsxBbwhdeXW//FUzo1fyS4RvOq8A0dcoZ9Fb6blzz7XVp2oUz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(6506007)(86362001)(9686003)(83380400001)(7696005)(38100700002)(38070700005)(33656002)(55016003)(122000001)(66476007)(4744005)(41300700001)(478600001)(71200400001)(52536014)(8936002)(4326008)(54906003)(66556008)(2906002)(8676002)(5660300002)(110136005)(66946007)(316002)(76116006)(66446008)(26005)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wXG/+nWpVVvVnAol6WuhrLqf/l+2Nab/YFgJQ4h27k70gn3MY94+L5JUXaez?=
 =?us-ascii?Q?cwLMaAQD9UYsugm7M875yiskkrlrhvBbDT3SQzLO/QFTgTEuz8YMD4mwGjrK?=
 =?us-ascii?Q?wAVEbdqvsSwJw8ezYfpXYtW2vxq7A4XjlJx7WqjqDe55WMVEt7Xq+o3+1kEz?=
 =?us-ascii?Q?Dg3VHDVOlrVPRtVjJhhJ6ujdsB6j7t3pz01Vz/TlYl6WwAOFkoJLxQ0jG+bb?=
 =?us-ascii?Q?G0+DFVTh59MxQr1XeRxf3TqPxtjh5boW2PXr2McrR+tqJjwJscR4vjUqNjGV?=
 =?us-ascii?Q?bRCp2ru7UNObOCDkNqLkOmM4QLnTwd8IMjUKhzXFisJlPx6E26s/yS6lceYQ?=
 =?us-ascii?Q?lOKEjyQTYAphhv8FGtC24Zm6ea4x69uTkv07IMSwXcHTsiDoCubCkGigk6+S?=
 =?us-ascii?Q?vZhJlJo07JLXj6kXiiFema3kPStW6g1tIP5LvoCSq6VHRmsnrxGOyZBE0fOJ?=
 =?us-ascii?Q?aVEBVXkACgL0xtp9Norga1rG1DIIbiWHoZNMFh58lOhVJy5RVZgl5sjWimsT?=
 =?us-ascii?Q?xS5d/wCBt+7jL8IaAnsJo83WMsgAI/etp+/4NvYDNOe+Mf6xJgIBvk+1YSgM?=
 =?us-ascii?Q?sGyormlLMdvnqiS5czMhaoqr4ACSxC7vykiXC3o/Dc0VpzVgI4k5Dto74iBV?=
 =?us-ascii?Q?4Qr/3sZ+pKARNe89hBQJWeUEyAqVJ+FFVWMqTmxweyusZEgVz6Y/G6hBI8Of?=
 =?us-ascii?Q?JWhkEeTHAlMPXFWs0V5GR2xxhSknyigCi3yGKM39oIfSw/p/TU7cZ/UdhY2r?=
 =?us-ascii?Q?8rJYXKANR059aYwUrjbujiUMf+6KMsGJ1lRNCXfwVvxPUKIA05XNUpBR8Apt?=
 =?us-ascii?Q?8o87peeFIvKOo2bhuAWsT2gT6EuNevKCc3qFRQ2M49bSIEOgP2jwIVJ89fte?=
 =?us-ascii?Q?uPYV3QMXWhpooJ0EHnRfoLBIr3U3a0UJ5LoCNmM4jCyDWrxZTgg5HZ75KCYC?=
 =?us-ascii?Q?GFV+a4lzciJZeTq/CcwSBfji2yMDoUq7j2KsFgwdshlY071CocRFXTL1hyah?=
 =?us-ascii?Q?dWyhFmUglkHUtntBn6dmhOITFwJgjK7TErF8WEirlpVajatmKzwSTJIzXAbG?=
 =?us-ascii?Q?XfqZEKl49ANPK3TGlMTXa+XACZIR6cr0GGAc6rACKUg9TeI65QduFIlv1P53?=
 =?us-ascii?Q?FqBMW4yWjx+bfSXiIPVLydAN9LumHuFXbElrnfniAO+S684m9XQ0jN2EM9DU?=
 =?us-ascii?Q?p+laRg7FoyBQCcRJm/wOkIXyJ63pbVvj6ABK08lceNpI1Ia332BlHXghLoxq?=
 =?us-ascii?Q?dFbsB8LTJm/Z4TubWF9iRxHOSyYxM199AwORK5lmjHVQyuuiF731fgrXGb7o?=
 =?us-ascii?Q?ay3CH4FbIyxqM1nYZfZj+Z4hWf2d2/2PRomdU3FE/1Nbh75idBRfq81/VBD7?=
 =?us-ascii?Q?lN6YNdQCE1WIV7/a6pxLZ0t2sD0xZBlkM5EHz7CND1pjpk5jXNoBSwy75zVW?=
 =?us-ascii?Q?wd18bj1wPY06qyxlQ3GGy5WLv3JKm8cPIrBFPoAexJK/OrSqxk8MGXi+cDpU?=
 =?us-ascii?Q?TgQbuh/ZfUWKGssygtFAWLobAtg4yl3Rgg4WsoYRC5WM+1claHsWiR1SNPez?=
 =?us-ascii?Q?7b/VLkjWhTJZoa207oM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mellanox.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28494747-b3ec-42c9-95f1-08dbc55dd15e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 04:44:53.7969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NH5gCVCW6RX4cPPc2Bwj7wpJV/+zafdx4fRM/VvJeljTZzbkg6c5v4mbOK6A2vBYBL1trxaxTFnUkh6TmDrXVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8274
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> From: Leon Romanovsky <leon@kernel.org>
> Sent: Wednesday, October 4, 2023 11:48 PM
> 
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Like any other set command, require admin permissions to do it.
> 
> Cc: stable@vger.kernel.org
> Fixes: 2b34c5580226 ("RDMA/core: Add command to set ib_core device net
> namspace sharing mode")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/nldev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index 5c805fa6187f..87b8cd657fb3 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -2595,6 +2595,7 @@ static const struct rdma_nl_cbs
> nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
>  	},
>  	[RDMA_NLDEV_CMD_SYS_SET] = {
>  		.doit = nldev_set_sys_set_doit,
> +		.flags = RDMA_NL_ADMIN_PERM,
>  	},
>  	[RDMA_NLDEV_CMD_STAT_SET] = {
>  		.doit = nldev_stat_set_doit,
> --
> 2.41.0

Reviewed-by: Parav Pandit <parav@nvidia.com>

