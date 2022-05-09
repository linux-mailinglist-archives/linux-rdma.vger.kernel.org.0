Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06F551FBF4
	for <lists+linux-rdma@lfdr.de>; Mon,  9 May 2022 14:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbiEIMGP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 May 2022 08:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbiEIMGO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 May 2022 08:06:14 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B6228994
        for <linux-rdma@vger.kernel.org>; Mon,  9 May 2022 05:02:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gk4H8AIzIhB02VuvjYGqV1oDaaiddEUnlDXMJnVqmNO0abcTBSEa3iP5BxpWVjM29UtgMRAwcS5dl5zw2J91vNdtTGBx/X6mJwOBcvkjFmh8IQ/0ukG38WKjc+04cBhC/DdsIO0X6Weu009Po3o6vgf3PWxBiT76MhiAstg388RRTU2iT0LwnjC7Aw0oBFUcPd+kQ97XcWdPXGk1siChD4eBXxiFAV0Q4G1eL13QCsXp1CUBxGA7gEnF8XKCogK7XfI3+I+Bkuwib10R5EaX5nkylVqyxjshcecJ4RzcSV5bR8Z1/AiL9yPu0HiasxEmdVGJbaGHDY1ZRSRYr907AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5QS1E6UPjGhhS84LmetZkKN6QMGjqt4opyiZKXZilc=;
 b=APeV9fGzDwvOT/2aCsukt8Dq1tewiCaJRcVcsPmqj++gL7h94EFc04UlJ/a8yenl+loQ+llUgooXukWoN13Dj5+l8gglaQSmU3eTM++V8X49Hw9jGPYIwGPlPNJhdXVsAnPyP7Ucy+5RzCLwS3XIMx3ZEBjDKy14i7SU10LRTpNH+Bc2wF9+uNCGycjD107QAxhxdBeoJFGUKXWoRfWR1RgCrlxS1Ni4/nbdIBYD3LC5krLxV/iFvs+wTyBlcwEm7D9DlDPX1ucedir8D2a8HKeK71vfH9uYRXePN0jrqulY6FTbAbC3VamHlJ2SL8rJzW2jYxHxzZIrsf7J3ZBjuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5QS1E6UPjGhhS84LmetZkKN6QMGjqt4opyiZKXZilc=;
 b=r8N/P20VAHKoTuaLnxmsHlpt9cr7BhB6YOX5jUsiMSLt5Wg8fPY4n9AQhRUU3fQxIW5PuzNFPouP2d4/gB/7HNFtwuzHdu1ks+Hqrw9oF/grEEV/J9nk7hi+SMViOozXd6nQDVu+DO2zOq4beV6xVVz02HkBbeghgKEnPGy+cAT/mI9an7q89JBjRADUjrMkwN3tnXay2sYUSTD2CJ90s55X3rJmE087ZR27JKMCYIGAzlx2Oa/HRM+r5dr3plwqJVeTl/DbsKrwBXx/EDl6ljmVEHYEa6VZZATH7K1zxKRYfWKGb+GxNINRYwzrF/XG3EyfHOQPgNhwLgDFo9jLhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Mon, 9 May
 2022 12:02:20 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 12:02:20 +0000
Date:   Mon, 9 May 2022 09:02:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v14 02/10] RDMA/rxe: Add rxe_srq_cleanup()
Message-ID: <20220509120219.GA842171@nvidia.com>
References: <20220421014042.26985-1-rpearsonhpe@gmail.com>
 <20220421014042.26985-3-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421014042.26985-3-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BLAP220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::6) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b401855a-5121-4f0d-f5da-08da31b3c517
X-MS-TrafficTypeDiagnostic: MN2PR12MB4048:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4048143986B8E28551E44BF8C2C69@MN2PR12MB4048.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Y5320cPx7dr+xeWXi0W1c+dwQtqLndbHtFyOjPB48kT0ljGSZWy6MfezGRS0tIzo4HvKlG6fRPTAq1L/fJZyESO33QLx32XtaeO1hHIJSnR6vi7K24zJjLF2xCjGtXypBvZSFtCM/Zw/ieeGItKPEB+cymyMs/2rzr+/aQTDkkcMjXHDSD/vxH8epuCnMNS560LRlrt6OPN2Mh//CLh8l9sYq5yFEBDL7yhR9j1MQGJZiNBffT/B6QRqFnVzgj45wFjxN7zAcGXuTyqFOyZFBel8VF7xvIln0lKj3A60xRkfLVEsTSX8cgD06FNoWAoSnXh3axjXJY3QdCdjRTL95E+QktpIaX1NpGLlODJPBAKiengfJlPF2pc4JwkBiLPHCPNY18Xf+DxvqLrRP9ZSf2wHD08ubW3Y8QfgaMK3fCd165pZb8VSDEKQa+CbPrH9I/hlJpNrNf+LnU1sYaZE9Eq7Tj9wRaERZc+XH+gqg1MoybZnLMNjxI/2HeTjFJ+YWvzGUjhhPWspvltlfcDyBQRuRQ7km2t1pBaB3Fa073aD5qWR3eybKPO3j+O4x32X1F4VVZovhQebO4gpkVSTjkdfqF8Zgunrn1MziehxSjfP7AiyVe2ZRI51hTtasM3Ae87jXF3b5TO6QkP9lEaiZxUgNhJClTp1FicLo3hxUlm5RWY9XWyxG+WUzJtYCGUdItmR2wohqufMKdwCbj4IA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6916009)(5660300002)(316002)(1076003)(33656002)(8936002)(38100700002)(66476007)(66556008)(36756003)(186003)(66946007)(4744005)(2616005)(26005)(6512007)(86362001)(4326008)(8676002)(2906002)(6486002)(6506007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4zSSOniJ7XxiZv6hc/9roBA1AvV6G0ztFOsEwqewywWUi1FPLkqRRynEKGga?=
 =?us-ascii?Q?3wUV4BSC6b/YiiEotIe3ZpDcpeWE9K4KL4ZEyOe5Rsu8doHfoKQ77hyJJE15?=
 =?us-ascii?Q?7vQAlAwDttERSIEWyqN0Q7HxOyIie3U3gHsASa3RfdCYpt89S2/linfL2Sa0?=
 =?us-ascii?Q?fVhK6C2+t0q2iwNmDjoC4sVxTjATRk5E1qQ8Ogn/LffnqeiOBT9C/dcta4WU?=
 =?us-ascii?Q?kTT3a6fVtgJLP0qPnTH8bzbfw2ppIKl4LSK51Kte2q6r6XqTYJUhPOrR2s+7?=
 =?us-ascii?Q?WA//zv7PpVoMlrVnVKGPH82KdMckZOukYBPdH1Dm06mPejvrtliMfDkYiC9/?=
 =?us-ascii?Q?+OIzRaqH93WijRIeMqHN05cshQPbILH69ofHVp6NVTKu9ijeH7ligIrNkXd8?=
 =?us-ascii?Q?cgfLb5KgCpqNi25tVmkwUzAEkkF78jEZP1zwPg6KB2BKDCkINXsV6lsdgB/u?=
 =?us-ascii?Q?dcotDKTK4qN2T8lXb3sMauVPuRT7tL5A0DRmjjLNohRcxMQwdGyUUOi3mL1X?=
 =?us-ascii?Q?xaw37p5bGxv/T/TdSk+DbZCglDCZwgrt42iyZkW0FAI6hrQS5hu0xdAw8jHi?=
 =?us-ascii?Q?hdHpZJkwGUmYCr+rdi2i9aVl0jBCgV68NcAgebu9zcg+h6jNhqeJS3xYSwj0?=
 =?us-ascii?Q?390fvY2o9Nizgkz45kUYk6pFcbKItirR11N4Du24xV/em3oMxA8PAi02Lnyg?=
 =?us-ascii?Q?5LDJZT3Mn0qjOgixVm5assoRcdnTwyEsjU2lswNuX45fwprSsMmoCnKBXJaL?=
 =?us-ascii?Q?O9UCRj5VP6nmHzjaiH2NPBRr57YtRphlUYkgl4UagwG+RS1cpaFoX6iXHiFE?=
 =?us-ascii?Q?7/rCiLO6W1MUxuxeNbc4Or26xFTkIy62m4sqjL3NdQGMzkQzCb/uZ5yT59FT?=
 =?us-ascii?Q?z885dPAwkr8W1/EE/AfLjHSPp96utC694Gft3fqw+jwjSbd7kv++68XpwEp0?=
 =?us-ascii?Q?e3nfZeIReSo7mPJGo0quw4E6VqTPA2ZcYhoJ/XSYaf8NHGXU4hN/Y+p2T3Fi?=
 =?us-ascii?Q?4wEVBZ+9VgJ8oiCfVjQbETNytRr0S50bn2VF07v1xmQr9d1gSNQq3JrHnQY4?=
 =?us-ascii?Q?oWTx3M4OEJFdanj89YX4L7hr201EnBiwXPJdBdQT/CAeAeP/VI+f6Klna9Rt?=
 =?us-ascii?Q?gANKiyBRF5B6DQ6OhcSugy3P5LvGRYhw7KscXvO6N6jlyLyBCyEkqflWF9yu?=
 =?us-ascii?Q?IVgUqr7yiEZUY29rKMn6ZTRtLTkjbIRuzIuEjvT4veDq4rLCuzfM2wpi+DoC?=
 =?us-ascii?Q?QzcIXXtW67rSlfUV1h6ksOSOtot86tMqxPkoEgZGtwlay31+0UY6DYmfi04H?=
 =?us-ascii?Q?X0xd+rCcYMdbOUrCqBy9gdaYxvoSTeiT5UsIg0Dvs+glcB9+ch8Z58XMYlR1?=
 =?us-ascii?Q?u0BoitwukftdFs0aq4ysAdcu72p6GqqrnUoBQQVxMNwHeNAJwg7LbsdYFMQ7?=
 =?us-ascii?Q?vPDm6dO3TGm9edD26kAo1fE+idQqs9u/5o3z7/Unx7SGYhYgYRYWtQArztSG?=
 =?us-ascii?Q?ZwgC86RMNrbSL5MAzPivVGvp++vPdD42hzRswmzrxMguyu58m+SDh6yZuVDo?=
 =?us-ascii?Q?t0BraRd6fOW2ox0QNmjx2noU5Z+9Zpp9CmPWPzL85qQjTMPBV/aCV/P0ZbEx?=
 =?us-ascii?Q?o14O4HcTFsGwupFDNxSdNmBfTGB36Q9ZOf4/XiI563Qfhlv8+kWG2xcfgF+7?=
 =?us-ascii?Q?QUdzwV76IM8hLGPiuGL6BEAR4r5bSDH9xZr/119sT81/UKDHNqA8IhhG2VSL?=
 =?us-ascii?Q?tgO9kMJgJg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b401855a-5121-4f0d-f5da-08da31b3c517
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 12:02:20.3353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QlyUCMerv226eQKfm6zJ3hjk9xfrcfqf489wHFN2eaCkw9uKxNFbNn01uz/+SmDF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 20, 2022 at 08:40:35PM -0500, Bob Pearson wrote:
> index 2ddfd99dd020..30491b976d39 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -286,36 +286,35 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
>  	struct rxe_srq *srq = to_rsrq(ibsrq);
>  	struct rxe_create_srq_resp __user *uresp = NULL;
>  
> -	if (init->srq_type != IB_SRQT_BASIC)
> -		return -EOPNOTSUPP;
> -
>  	if (udata) {
>  		if (udata->outlen < sizeof(*uresp))
>  			return -EINVAL;
>  		uresp = udata->outbuf;
>  	}
>  
> +	if (init->srq_type != IB_SRQT_BASIC)
> +		return -EOPNOTSUPP;
> +
>  	err = rxe_srq_chk_init(rxe, init);
>  	if (err)
> -		goto err1;
> +		goto err_out;

Just write 'return err' in cases like this, no need for a goto return

Jason
