Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980B251FBF8
	for <lists+linux-rdma@lfdr.de>; Mon,  9 May 2022 14:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiEIMB7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 May 2022 08:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbiEIMB6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 May 2022 08:01:58 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4131159
        for <linux-rdma@vger.kernel.org>; Mon,  9 May 2022 04:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eduC5JvpwqTzv9eQxRXsFpFxXCOsttN1jAsltVJo6TIsK8ViCyP4te7U/8FDgMZutHVWj70lxjaDX9ZghNmDvk4zVjxpJ602DgGsf7ljHrw8qY45Ts/p5tPKAhX3Z1tgfcg1AnNq/DzstHxce3V9faN+lmgrE4h9eG4ng2gDyyY4bZoUtCkPVrOipuImQeZ9DQMAoLZEiYDgRHZXngVIzwipJ/KeFpgkinwtxAZzlHRk/vyTwtV7nz3iFHDpvShNbDuBdbh3n9/QH1+9MOqOhlhDbqOmXp2rZ7u2NWOeRuQCb3fW21lv3yeiBofJYiPxi3m7Jo2oarjJ5SZ9EQfHMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQ2yJZYD4tbZF3dHaF3pBpq0jGFRMoeCoEs8h1NjQWA=;
 b=VTs4vf+pHsRrDmF54BBZfVfgfz5JqQ78//jADygiOEr56tjp+hsR61+4GEtywhwO/EP3lYiIdn6dL6hIqBbVnkUS5QtZAE72jxEOHn59Veb979aOrWZgNEu/+YlvxSXr16sgpIgMAqMSrNVnHntHEy800Io3xOj9w14r6RHo+KbCtOdMZi9baK+lu/IgNY+0u+7ZNHs0C+v38cnuUi1chgOFJUM2nuV3JxnTuk5XfRGl6yfe5BfIfDx+IMY/MFNO2Iwsuxs/018JbflsSO6tUfIc2Iz45ETAhjRCYbU/Va0OD+mpZduGq+0qwizXNMqu3pd5ObCItcP50JKbUFKe2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQ2yJZYD4tbZF3dHaF3pBpq0jGFRMoeCoEs8h1NjQWA=;
 b=GfIa622FzntCh5iKAaN6lPvjCT36CEE12E6/NqnQRMtwSgSpUIC5xm9iqw0LdBhvaDwS3eQdDJrZEX9gNApIrXo/geQZlu00326/vpxC568F20ZbB/1Fpvxp+CLQfW3+3zSYK7jnTRsjNkFADpRkaczUdjSmlaO0nE4jXPBwVkApwjssmqAB4efor4pyJQd/nmxhbuTzDMwp5OGSC8cYK/NMvw2xB3OEYAHf5vHdwhQ4O+nq2KWQCDG5y0WWI1VdFVZ3DR1L/+cu98Xh9CclnduwZlFR8ZZH6wpin8U57M25zJ5xhyRns1FY4o6ozEiIRui81bOt5GbdGwrVJS++pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1231.namprd12.prod.outlook.com (2603:10b6:300:e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Mon, 9 May
 2022 11:58:02 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 11:58:02 +0000
Date:   Mon, 9 May 2022 08:58:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v14 09/10] RDMA/rxe: Convert read side locking
 to rcu
Message-ID: <20220509115801.GA841150@nvidia.com>
References: <20220421014042.26985-1-rpearsonhpe@gmail.com>
 <20220421014042.26985-10-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421014042.26985-10-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::35) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3efcded9-4515-49d4-1cf7-08da31b32b70
X-MS-TrafficTypeDiagnostic: MWHPR12MB1231:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB12314D8E4C6AD985CA481238C2C69@MWHPR12MB1231.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Krqr12jhqEnXIZye8lPQ4Sip0cpsiJWVE9o+ADSVo0Gyng7FF/fzGeDRes5b0EcUI8yd11UyYiDE4kimdV+j65pr1El7lvfVygfwbZH/2i81qVH6G8ZFIrn4gDpfQgRZ87IzbHJ9TT2VIVuxaltN5QYHxuVRA8skyE5bjFNZ7IDHADVlMj8Nf7ikwuMdUpp40EFx8GNNLsPcGby9HvWx63KII+EK5K/J62CiQ4SS8TM4zxKFI+ZlX9UKfpivtQ32md8kw4JFEmkjCi9J/E5HtwSG9fCAYu6nojJZOB+fG1H19yxp+oOiwFZwCtboAB45LlrwKDpKfjnc0Y6Ttkx5m52Hx6ZmhQiutjqc/E5JvlPjkvU8g/hW3lR1/rCsBgdXTH2x4heNIOdwM+vAjbJaVyJYiUGUptBYiTSwpdNFigxWt2PNoPmT84IkguHllVN7QJwlOcXgnoJnBMQ+Wyy1V9DEHxb22oqW//sOLH2kxjY+siOXOsjYmXAI3Db8p+qNnN9z7UpdiHkvZ8Q3HEIWsvUDy0P/ebfNfBPX9KTxDTJxJhea37BRjKBawUK8TL4x2Wgz3j3/xrT04519aGxZU2Dsju7WlzOOGImeVl8eHxVzEMuUvPhkmzPDz/KZ4gAlsor+Y7ihU8Yv6c8YnBfjuv1yHfYtc23gm6nG7K68Z3qS882s6VdpvBEi6e+vqMcXHoftL8rbYZdRQwK1d/GdPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(316002)(66476007)(66556008)(8676002)(6506007)(8936002)(4326008)(83380400001)(6486002)(4744005)(2906002)(5660300002)(36756003)(66946007)(26005)(1076003)(6512007)(2616005)(33656002)(186003)(508600001)(86362001)(38100700002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AY8bAvGZNAAFpgGgmyGYkynck6oQTPYFlM1nCrntIg7lhMM8xzG672tovHtk?=
 =?us-ascii?Q?BT1nrkbUTSFZGxojYaGOdmOQyh10pQimgngaGCRxMRvKs8G9jid/vCtgm9yA?=
 =?us-ascii?Q?mbHGdveluBBeEIWXy3QYwdsMqzZgBSlWfEokNK59zOKEssLvWLynyTsCY+le?=
 =?us-ascii?Q?R06l0byPaIJdHR+b6Xcbw74suVk4CdW6b1ihddaZksW8asm4xETv61EAtKHq?=
 =?us-ascii?Q?fU9t5u/Jr5SVMCiQVTYs+vZ5kcNzxvgUho3glCvxKIKOG45+Zwmeuq7FhKV0?=
 =?us-ascii?Q?b5VMWBefWgKgi4AULeWCvPdCMovx9x+Gh5eUC4nNSPaDRiMrCbmTYZpQB+CR?=
 =?us-ascii?Q?ipc/7WvVhKLZASrmKQwi8xK9Zmw86CVbaGO1x6pZzTIaWKTxkZABIp4C8IUc?=
 =?us-ascii?Q?k5ZCeLHfG/z626PsDtjCs5SEZ2M8mBQokdRVctotbVLZ/Zp8UvYpcKArygBj?=
 =?us-ascii?Q?pKkEgxtFXw99JeYqS57ZteStVoHbadKmAe0GOdkAcg5Gm6ZHsDb7PxnS3JXh?=
 =?us-ascii?Q?PsfHa3GjbpDafs4uppz6BS7Nz0FCrgdgUh4zq0gqeK7v21YJR5m9auJ0tP7M?=
 =?us-ascii?Q?4+Q7cpgYmp9GJxPeDk4D5yCKjtekE7n7MUNIY1rBBTkMz6VkVmyMH07VUP9j?=
 =?us-ascii?Q?4xQpO7OPstpA3Ae3ullKm5LWnn0s0PnVAm4xXRgkCVb75vfnY6iWoP+wW5Xx?=
 =?us-ascii?Q?C4eOW7PGP1sdsFKCUAFv1QZbgYh6sbJQ7YRNmTSCmGFH7c5FhNMHy7sRWpcC?=
 =?us-ascii?Q?qVyOsY76Nu1jw+jLqiH4uB2rcwKiwkh7euFuafgEXzwXGxAyCqDhwon3n5qL?=
 =?us-ascii?Q?Y3GPgy9P8Dy5AOQOvVVPTJtXMEa4m7/NocSS1X7UqQKteiBmMb20Iq+iXZif?=
 =?us-ascii?Q?HC+mR/QuYQ2rqdk5BSgqRYkgd15NN/Ppgo/Xkz4qL+sfemDTtpoeTJOr65kT?=
 =?us-ascii?Q?MaaEo348medBGsdbIYEYBdj1744he7ITaa+cB46QOPxmWtUEGqNE9NgsT+94?=
 =?us-ascii?Q?dWW/BJqMDRw8xDBzogJ7JHcCmS+2Ywlbuw5XpWzsm/+0qHPTFAaxkNqo34mc?=
 =?us-ascii?Q?PgcOxFLwfHTAVKMVK1SDaE5pmNFHw7GYmuHCeO0gJpMn4WHJav19QCddlwN9?=
 =?us-ascii?Q?xjo1kFemjDBaRBbV2dqBXhPukeJzxqlFkR89QNOkXPWd8dF8zQIMTPzlushi?=
 =?us-ascii?Q?LGzFx1jzMlPuqB1c1QzPnlBroYidY6gpjBrE4SHIObMBn38F2L6ey8gCODKZ?=
 =?us-ascii?Q?xMxLzhCz64lRJ375UiPbSPGGW9bEPsFhyvalV0JXlcNiAUc5/6VMNA4hdWZf?=
 =?us-ascii?Q?R2OrApMScv1AH92PZBKN+lKDXHLE3ZZnDhRzEbJs9D/sqKiMEybtkhZ35q7a?=
 =?us-ascii?Q?xJjrK+FDETY7vtf2qkNkoPF0eskOvW2YNSaToo6riKW+3xBZGFbaEdaLN4cY?=
 =?us-ascii?Q?O9216BeD+rPcnUY3+m2PTgOMHEbLTytlPHo7yRXUoK3Uskc02FuU1kpRKYPc?=
 =?us-ascii?Q?Y/EIz/K42QuTw6piKAwYNH6h0EQ2rm8oVWf3xnzLS6GnLSVTRR3Lph+kx9qR?=
 =?us-ascii?Q?ruVre/tKXA05I1/uCQ60KUVYkiQ83Gv00FKkXkjz2rox00JGv1iUWeL+VY8h?=
 =?us-ascii?Q?Crm1vV2qKNWo6AWSCmm3Fro06lYNfQ9qjuH9s2844C71ifKRKKLkW8qkPikH?=
 =?us-ascii?Q?0IAQeoo3lxBJVXCpI2IUG/BQlKqCvnXUNrW1ixboyZ/Q8Aq2Hwoi11n4/HNj?=
 =?us-ascii?Q?i1p0XRwUEA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3efcded9-4515-49d4-1cf7-08da31b32b70
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 11:58:02.5583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSXBz1Axlcyyrf7Tf35PUrLMzT0U8SOxkVEE65nL6YOSzh954qu8kcFkHCXvfKAK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1231
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 20, 2022 at 08:40:42PM -0500, Bob Pearson wrote:

> @@ -217,16 +216,15 @@ int __rxe_cleanup(struct rxe_pool_elem *elem)
>  	struct rxe_pool *pool = elem->pool;
>  	struct xarray *xa = &pool->xa;
>  	static int timeout = RXE_POOL_TIMEOUT;
> -	unsigned long flags;
>  	int ret, err = 0;
>  	void *xa_ret;
>  
> +	WARN_ON(!in_task());

This should be might_sleep() which will show up any held spinlock that
Zhu was talking about.

There is definately some possible cases like that in the AH mess,
RDMA_DESTROY_AH_SLEEPABLE for instance is not handled, and the error
unwind during AH ceration, for example.

But that is just more of that AH mess that needs fixing, and isn't
related to RCU. It needs an atomic version of rxe_cleanup() too.

Jason
