Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F93441B7B
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Nov 2021 14:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbhKANIT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Nov 2021 09:08:19 -0400
Received: from mail-mw2nam08on2068.outbound.protection.outlook.com ([40.107.101.68]:22200
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231665AbhKANIS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 1 Nov 2021 09:08:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JArXbdCAteojCJ4Z7DWvtpBJVi7+QASCfhgabaOCdwdWFQLBJSS4B9wwztIHzjV7vfaG1YQV3NOQF45hBiGKofQ8WOpKpT5f2loca4SB0HPbshzQG4jMxR9NK2BjL9+DIj0URO19L6pjgSl7UJvOy3j70faVrZTkUfEFNqjHWUnkSywLMkdiahlT3yfpTD/T9V8qR/0EZG8X6Y82zLT7e39Ohl2O7MrDMPSU3PFS6TZWPOq/78LPXq2fL47ZFAe6IkNvxyZGpyHJCBetnYssHN1OEDOxqBVg1UM6g288uLD9u/tVjcZH58y1MvOS2+04RSjPnAwU+r3lw2Mn/8ZCmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCRu5WJbcU13xaMEvkRu50pPgFE8NpVb/waTPfYMgKw=;
 b=HquuvxKMDi6dJzyzEoRsKTU9G2hLjzOtY2aX2YjCQ01LfZQnuLKx1UqGVcCSlb3dam6qgaquhcDtzEFna82NwgnKjNfbOi3oWX6h2aTZLeLQjtijaYTm7VwMixf3wwv+EPOVUSG+WPw4pxVTH0dilB0yHo/bOp3fS39RtYEULew877+oDu+mD60KCqngDXttp/hckaqe667sCwtD6YwD/mPIvpz4F4eEAymbu5Ebuu5l983m2dfYTcPU19t+ylqpYrtSU3yDFjhBXGsDVuplXB+OIfDG/Mkzfy3gulScaGTkQMFzIfaPGSF8STb/DKbkV291EFnsIccC6KwVHvO2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCRu5WJbcU13xaMEvkRu50pPgFE8NpVb/waTPfYMgKw=;
 b=F1YcPbh4vd3NTpFPGFVroDLAzeGTYSG43ERsMvvMnQzZM6mzwy0yGKNPlJakRwMy2ww6Zz1tZ5D9oO9/Z9mYUAnYhm9krnbuWcJIARKxUypqi0vdN1rMUjWlvIPd6HUwh40jRG2Mqbf1fMrPA6tu2S1Zj6UmJoyDLmRUdqE+IuezDpC7V8E9ezMgKBn0D+aNftV2K/08K01X2q5CawOepr84aKSKnnxfLYFPV3R+/cCJXE5v1ueZlAc9qShNqkkRVyg2lARy1adoWE0rFmco48GWc0D3a68a30siEyNL1gMdm/yD5SP3aLBSqIA7qKLtYr2UPAqqTXJTUjZe+ZTHkw==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5287.namprd12.prod.outlook.com (2603:10b6:208:317::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Mon, 1 Nov
 2021 13:05:43 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 13:05:43 +0000
Date:   Mon, 1 Nov 2021 10:05:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/qed: Use helper function to set GUIDs
Message-ID: <20211101130542.GA1070492@nvidia.com>
References: <20211031170743.81755-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211031170743.81755-1-kamalheib1@gmail.com>
X-ClientProxiedBy: MN2PR12CA0021.namprd12.prod.outlook.com
 (2603:10b6:208:a8::34) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR12CA0021.namprd12.prod.outlook.com (2603:10b6:208:a8::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Mon, 1 Nov 2021 13:05:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mhX0Q-004UUs-7z; Mon, 01 Nov 2021 10:05:42 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60b03189-8c58-4549-548c-08d99d384fec
X-MS-TrafficTypeDiagnostic: BL1PR12MB5287:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5287356C9789F8E911D277CDC28A9@BL1PR12MB5287.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2KDOa/GYkm523PAJpzliJfUJ00cZeU10gIDOZxScwbAow1af57Ohqd1mjbaMdWjGITGA55PsTzMzPe3AA2lW14w8pZqnLaUkyzIfwebNrcVIL+GAjeomz8T4TYkYLkrNlSRy7UWYkvGXx5G4KADl/DLojel8NWdcNroATD7acY7by1U4wBFvqoPMxXiXyXIW8R3VuEiEyanunOPXGZ8ScB1S5DNHLteCAKkhr6JhB8+LvpZQi8lgk2FU1rahUDvtgtyCMezjjB5+EKBMfOECMRPzUuHGqPXftAX2AhTl6+lsFoQzcPEuVtMHL9u8oC3cUjwo9WRuTgujmHwY7t8CukQcQp2SX1oUQgf91HFDAEYHFWoeCTxuX7UVtdAVtOCScJdv6uLlZ8hssojEltqtvhwpc7tusPs+StSHOtGolo+sSLQxChLFxKPJfD6AfZVbcrw4pfahc1jMacdCTfcD19pU8x+HoIVmrTRjo320GgehEB0TK2h4rs7lWdt759pbCN+s455sFausjakvl7qK7KU7dBqHE7+tCHo1b9CNtTN4fwO7c6ANK+aIob9J3orrmb4cQ5SUtsfBtdi0o6p5BYyFh/3XNgJQYSnQtIWE2kWteOz0jIdWNOf2wb2vs+rKpuSTqEPqks9CzaeZ0533rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(8936002)(2906002)(36756003)(9786002)(316002)(8676002)(38100700002)(54906003)(9746002)(6916009)(26005)(66946007)(426003)(33656002)(83380400001)(2616005)(4744005)(1076003)(66556008)(66476007)(508600001)(186003)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yDcuS8UMlo6Zr1moWMz4Mx8uSngQ9AYJi84oeAE3Wi34e+0UNqWfH1EExTtt?=
 =?us-ascii?Q?9VwNbTB1H4QYbShDn+u4GP8CSYPO4tEjLnBE3iyG0Tkz9ZpNIHqH416JPGWW?=
 =?us-ascii?Q?MiEb9uisLSgyxNO5aQGvbCQrY17GourOWvsG9PiMs27al0FzgBQWVRo/3Dia?=
 =?us-ascii?Q?tbCyp9lovnq+m2AGHN0JmI0BPgYivW/NDpAHCuD42U9PHY/tGuIaIakmsrAW?=
 =?us-ascii?Q?h1ZsyNrrgqHg90lQFXx2+paCpoZpz9FL6LBFQdGtNmDsw6Zuy9apwilfIOzE?=
 =?us-ascii?Q?06COA04lD9QA2RsuLoHmyX1MHfjDw5X/fa0s0jQadnUdl9pfbVm1c8Glud5h?=
 =?us-ascii?Q?CDpmGX5jLKGaq3+HEArOhce7hhbiTxJu/sxxVkgsv5yxlBDbJxb0xrrpe6Eh?=
 =?us-ascii?Q?iZgkhzkIxpli9Nx53J/HMAYk51wefZBGXeJG221bFrtHXEBaOBqO0q8WKYfW?=
 =?us-ascii?Q?xTz+udtl6WXZEIjByNYO5TrbAhY9jBuRTbgMyQTeX4nzaZ2KMOZN/NfMyF0V?=
 =?us-ascii?Q?sX71D7UEIel3OxwyslQDqFYJuqwLYuY6GwODW4LG19jh1hJOTxRVDyuZO2KP?=
 =?us-ascii?Q?hgr2uNgDrIcJEBjFl0LGFJxXU3N7eYixBG+TGpRuEBYsujqyhNFqZefBuI05?=
 =?us-ascii?Q?XSd34vh/hzy/4L70pzttA8sBiS7lPkssiLfEHMRjdqbYg9r071qnqui2g52M?=
 =?us-ascii?Q?lvzERpNSY4PmKiDiORJMtrL+wWiwbwRBoWSY7Pp2QGswn8pnC2ywCBXgZDd1?=
 =?us-ascii?Q?nVzFtxdyWWZjExjVEjGxhzDyJKeSPzgjus3fHT842atGmK+XJlL23FGdOGfl?=
 =?us-ascii?Q?Koe9NNQYe5zb4xYbz92vR1DrIptqeRPwgfQRdCLnXbR/ivrqUUhtN7ulNg9I?=
 =?us-ascii?Q?1+VxohLSBkpCRdUqlrRtgb7LkPQEUOZ2kBxBiJLuoRSxD2xcNs69R3deBCNW?=
 =?us-ascii?Q?o+A1Sp30m2NY8kvJiOmCcc82aYOvl1eCcDXxKrujqEKUSckv0ezp2hEp6pC9?=
 =?us-ascii?Q?9r+ZrCCndOe0MbzovkwMEAV79t81C35lUIdTsc5oZsSfnAhsosE+j9oD+3PW?=
 =?us-ascii?Q?TtcUKgVrkZ8dw5XN1yWtZyuxh1KwtMOabH5R1UXhw/NfX7jx2HG4Lqj2aA2K?=
 =?us-ascii?Q?Wu5SzXRD2Sd8ybbbtYyNgSujcK1ztXoh2e3+9BLtr8KArL22hl7nH2JurxPC?=
 =?us-ascii?Q?wWdHJHJ+Y9hhOzYXYlDdRoXUjXoX26hKwXTU0Ba49DAoz93g3nLA85Rqa6qU?=
 =?us-ascii?Q?SHg5N2XOKD9OXraCOUSXUT8KlnXSI4ikisbxbNZJMajIPuQt3pwskbT2svPf?=
 =?us-ascii?Q?JjWkWa7syYhUeKrIez07VeVlXn6KCp0z2bHYYP3cfNtaDIOMSmIK7M40pJMP?=
 =?us-ascii?Q?GKxEWupS8FQ3zJyhQtKdTLusNKTmP6YDP8pI3RObafgDEz7zql8I2Q0mLWg1?=
 =?us-ascii?Q?SM2wfl+L722zBMlYRfEGrLbE09dmeoLvt3D8LZQroVobiAsALNpy80/T028h?=
 =?us-ascii?Q?7whwgrKI2A9l1MPpf36ZK0KoYwytQ2aRVS65fUhYBSrPtkGd+p0HFcExg1Qi?=
 =?us-ascii?Q?pf0dNU9SXq9nEJtUMBY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b03189-8c58-4549-548c-08d99d384fec
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 13:05:43.6931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8vY4+X2xbxKsB62y/2LVwubS6pMfKYjN1nAK+OWnWnrfwmf2bwUHKQQiwkj4zpO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5287
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 31, 2021 at 07:07:43PM +0200, Kamal Heib wrote:
> Use addrconf_addr_eui48() helper function to set the GUIDs and remove
> the driver specific version.
> 
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/net/ethernet/qlogic/qed/qed_rdma.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)

Applied to for-next, thanks

Jason
