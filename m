Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC374F1611
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Apr 2022 15:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbiDDNk6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 09:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355357AbiDDNk5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 09:40:57 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C532BF4
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 06:39:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9TxThN8JiR+NPZVtACXCR1Gcfl6H/EAuzOp/phY4X0HGpps/r4Hj/fwsjfD/+z2We0khMqKubWFLLpzJ9l1/Va5OlN9YJdwuicl58zRyuBxJVlDvaRVnOUtWHe5uaR0Nn74wyTBFKAPjJ0HgORuf9lkU3IKe+GCLqiQTFZn3OBn/dUAXZJvCTHqw8FHoJyMKQEtF7qlNJbJLV6Mjd0so7cLazAR1pd5oA+RwO6pBhRYsCUum88rtnbXGSfbUxcGxahFsysmLE7gM79RYLBtO7fosWIDE/b8aH2BXpoVEbt4ndrxShIvARcqv/Bpu97VeNkYJ3Nzn7uABvZ49/da1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkDDMaM+vMXDkwGM11xAjEycH5+vZORAJNEE1EMaM1Q=;
 b=ahXhd39yGNUrFiQLJd6aHYOGEPXP7k1e+PsuE4GX5mMIauhPmyeoWmzc1SWX0xi5pNpvj+XbPUrxN7yaM5SQVsvKA6/fQqKvErRtDDsm5+/dE3SU0791fgq3aGPQb82CaxfIdBl/AGOd8I3LC+eqsDAllp4t4PEJCnmLQNv1GvjN/Hv9B470/9pWeS0L+3Has1WrFcANqkqDA2VUcU6EfvKKSFm8WToYl8oVxbNHkc0aWRw+bVoyQCgG7izCPGRyF8QCGW2KaIr1vpADVpjEEbgsSyrMoVMxVeAzDfVqtRoebC5mryqAJ8oqx/vcXYMEWrTZ3lbEehjWuZPUvRM31g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkDDMaM+vMXDkwGM11xAjEycH5+vZORAJNEE1EMaM1Q=;
 b=haR15fYeyNe6uL84uv8xy/OEWw+0wbvBtEa8Yskca2Ru0L0K6Y1nIKk+Xg18GkSJJ6/u5i1tnk9owkBx7YbvHm9OKlEauKbJy7f+Dtx6/Zh7h6aYkZQmRffXY6rHq27OqBUdX4hP4IV0XBlLMX5cbRwG8mWd64kXeQzO+rU69DS4+/M9oT41FwBGXU1KYkQ4IZkklYQcsBTVYHBC0FRCPtRnaQs79kPsvXdUWTF+iW4woWv5VF6dhXvk9YlyfmUXN2tw+biyhXUdC71KkZuMLaFtrFwUNUxLTrkfaAwLJgTGdVE1mKIxVmNx0emrmdXqwjc0gD/LcybXJr5L4zOi7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1504.namprd12.prod.outlook.com (2603:10b6:301:c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 13:38:59 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%5]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 13:38:59 +0000
Date:   Mon, 4 Apr 2022 10:38:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Leon Romanovsky to RDMA maintainers
Message-ID: <20220404133857.GA2905023@nvidia.com>
References: <0-v1-64175bea3d24+13436-leon_maint_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-64175bea3d24+13436-leon_maint_jgg@nvidia.com>
X-ClientProxiedBy: YT3PR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::26) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af1fdb9a-ffa9-4724-915b-08da1640791b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1504:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1504991C59B2DCCDA7C3991BC2E59@MWHPR12MB1504.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBnAEi2eWW+7zKINvBVuLH3gWLF0+tpDtAzP18wW3jhbSLIcW+tOGBRcPljKJTSfzTkzJpkHFmKPTRXL1fLFgTnS0IaRqzX4N1ej4+mGUAHV2kLI7ZUZh8w7BEgBEnrSpxSYld0EuqpnZgc0zx5WNRsSlJ0mFOJks6zv1IvlE3URNSDxR9d1qcBFaw/UFB2MOTW6F7jmqIxBDHgSOp38kjFfHiotVnetBJJ6dpl9ZeE9J0HpF6glltBNYMX/j/6suC5rQ65aG3mi/LsLWvYW02jJ8BmU3asCatW7IozCnVevSNWFeMnf08StW3+iaphYt899AgtpHDsl7N2xZaOsX1mJpmrdE0qB4ay9aolwyy+mi4YkiqmluW1hqukMr4Px0w4Cn7zav/YOk6+CSH8szWImnzn7s8Eu6wyyddYswQe4lNZXsBzYKaXxK+KjN79mqdmWKxsFhP98eM1I+foj7yGGyPiVcYBVI59BXdROqfb/8Cs5xJDWagnEo+CDNezKKsjpJMWrJ3ltoGl0znk3la1/Vbv7QkVFV7bfW++GZ9dt6Fdk5aQg6wAZKKJKzn3qGZlkcHdowncH9n/PzgywPTtsNmxrvfnNT+sG0DKHW+jAi76DvMQQPqsYbRFoIVzv6oPkfpwG8EfJrEdLJzSNOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6486002)(36756003)(6506007)(2616005)(86362001)(6512007)(1076003)(2906002)(186003)(316002)(26005)(8936002)(66556008)(66946007)(5660300002)(4744005)(8676002)(33656002)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H3yf7xp1HAnVQmESRhmGH/gQvlEO4pQPSZ6NQb5ZyDzz4TciwEca2YQV0uRS?=
 =?us-ascii?Q?EvQLlCg46bsU/pQ7ipTMkImjs+KHOFr+iW5rD2WXi7TMRM/T1mbeM+1EdAno?=
 =?us-ascii?Q?fjbk9+Y+t6PNYG7ZMFz2e5NcCNyWSVl5QmoPoeG0yaM1+E0p2BwiQkTbixRk?=
 =?us-ascii?Q?CRf+PN9O0mQLs+i+hR78iEZSFX4jhXfznmtMSL4lnJmB0+0RKqBPKGiKuMwB?=
 =?us-ascii?Q?ADxnm9/bSBP3gkyjMcDh0X08szOf4SVfqRYAO5r8d3+9WQ8mCeMiJK/m4bt4?=
 =?us-ascii?Q?yqtdLYgwVnSbdV0BWYt5rK15mkA5F7OFwI1oD4eojOUM4PpvJWu+8jbXVRCV?=
 =?us-ascii?Q?X+xWNZKMTxp+1rKCRvQh7D2LKBp2A6z5Gy9/jawO0dT2oQ/tUbaHH2C7xrGk?=
 =?us-ascii?Q?bWg6HZoTsw9C1fpDqzIkqvoz/Px4C0ZTezK644jQ5nR1tN5XzjcKNeQoSuYv?=
 =?us-ascii?Q?fO4qnIRKnS9Xpi1Zi2TWFWwueTYmJlkzrp875JzC/GMWP4nHrWqfDd52BPYg?=
 =?us-ascii?Q?e347Lscdfm3iDJRKnWCE8HnnjQOdtFLJ/uYsbs56YjByaJSDXYoa54cCnQ5L?=
 =?us-ascii?Q?xHg65+zqNI19+9kjAVuUuBFTvVYHeecxD1T2ZsFs91N6fvz5APYDGkSUgte4?=
 =?us-ascii?Q?qoHTKsJpVg6LQ8DAQfCk48bFqIF8jPCERB3WN/x0BlGbtvRXwKzYKfySiWRl?=
 =?us-ascii?Q?SiwXbLlmz8W6Owr+IY3QNQ0bHjF/8XFg01r4BflMRdfHfqXLAGs4ed4v4Qbk?=
 =?us-ascii?Q?DDyayJRnn04p7RTor2WNcm6n+qXTw0RpkdNJEsVklo070jUMfduhA5y6/1Is?=
 =?us-ascii?Q?27CswAY1uwyUdlqyfHEpbDs7UE3GKtHleds2uWzJogCpGQeCejITt/tz9bL+?=
 =?us-ascii?Q?I5/M+WIG+IEtzFI3DvJ/VMufWKs2v/BIGbbXaNZcvu4GY8rwGVg26W+N37pD?=
 =?us-ascii?Q?IZJ3vHPIrK++JkOZNwgCjq3td2T+seVW4VxwrUxzvJNzq3EG0YnHoWWCA2tN?=
 =?us-ascii?Q?sWKwPZqQd+4sZSI79uxKT1r4sG2DBM29GvOy+q4P8rDG4gykSK8DIiLQyDlt?=
 =?us-ascii?Q?2oQquoUyqnS4vDK/xOU+KPUOMEunxhVWKtiWrK4Ip9ZOvp/rvLSwG74pArbc?=
 =?us-ascii?Q?uO7AkXIOcQypO0NcDVhqwumlglACPK+qH94XxhaVICqetvBJ+CU0zCO9YGjH?=
 =?us-ascii?Q?NN8GmPXkG5DwW37KOf8nmHtunyHYZlUyZ3EhP4kfEliTyKmaZTJK0fsWh2Oa?=
 =?us-ascii?Q?xtUm21mix5SfRCum0iGGIESlsuHB7EiiSKZ32hFaGUoY8MbrB/sqBDK/8JnQ?=
 =?us-ascii?Q?Dd7eZuMrBsYP7WV8CbTzaoCiDBkE6OnbeIVcQX2mc649avebwIvErTnJxwl9?=
 =?us-ascii?Q?tW723LkPgsoSn+cXyBsjoSOE2By+NM4NKUBmccnjENNUMzm7f/WLcBeJ0uB4?=
 =?us-ascii?Q?HhwlO7Z5UFXB/LEjwfWhPPFjjPhiW1pz9Qc6IUpLsUktQg1YIrftdjXak6lt?=
 =?us-ascii?Q?tuBPiybCIlXKhbNj9yiUEoCBN8ZyO2FOCYEkZP/A1Gdka5ZgdFAwsSbuKE/e?=
 =?us-ascii?Q?jip84tyJIXPcex63Q080qv/4dVptuLUUHczUV/7mbrv+B0Oazaqm+JIGvQ7C?=
 =?us-ascii?Q?lfExJQ/RvS5pGNaJd+R53r2eVLNvtd7UzGF3CZ/gxfW+cb0MA3AYfRrYqXns?=
 =?us-ascii?Q?dHV49u2+wcxWWVFisWihFm7aFjVF4Z18P/2iSbzFtCf/ZFaWh48U5FKUT+xb?=
 =?us-ascii?Q?24+2s76Zgg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af1fdb9a-ffa9-4724-915b-08da1640791b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 13:38:59.3632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhhRLh7t5lcrAGrg8jEM41+GGliq8ah05VDFapaWHzcYUX+2YoPQZPBR6P0NBkUx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1504
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 24, 2022 at 02:53:19PM -0300, Jason Gunthorpe wrote:
> Welcome Leon to the maintainer list so we continue to have two people on a
> medium sized subsystem.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-rc

Jason
