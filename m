Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77F456567E
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Jul 2022 15:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbiGDNGb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Jul 2022 09:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbiGDNGa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Jul 2022 09:06:30 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DD6CE32
        for <linux-rdma@vger.kernel.org>; Mon,  4 Jul 2022 06:06:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbR5MMMnGVgA/OYbNhyj06gLhEhwybq0OMOXnL0lkojK8YZE/QoykTej+RdJApo+iL7MJPsPWW/5x7xLFe0IWTCMQPaT5NREfYviCP70J1OCwX/gZ/Vjtnx8J0Z6J1LYSR2gGm9pxrHMl3YbIJgxG8C74asCTAaQkJLGEK67+P2U4p3nwWbuoJnYwWIvJJYVKln4mcnOVFbpgiJw+/fJiiWSBW/4nsjAibAo0b2zvZSD/xD15fiTnaVtKG7tKS8qG4w/CN3O8OV2CeQ7z23xjQBFgPoWRGio9QdPhCGq4BWSgKorkuTsZKYSy942EyNfINvARRkmZaGPFbZMyYbSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7xZ65uusV/u3d54qw8h5Zw1sFpGn2PLAP+to8M86Hc=;
 b=MElGzeNV/Roq/ujp2WL+VVILFHDtI4QkBl/Fj9YcLQ/2j/ZnA29cZ6dag1ctxNFaRzOwsq/1YaWIksRf+f/YqWQZPblBZqCfnqsoSooLKjPyijMzVl5MXJ6ffpqy46E+8nPRl5e6cHpAhB/p692FA6mkhCUMGIWaBQLQ373EaGhY70Iic+uTFzwR9La4FVMB0EToF/2FKc3/CvzQmDN9OwMfRPL19Zlbyib+0yGH/an4FvRmlaOx6ZVCQX5mAnE6qv/+DOIWP+cDZ4+FoEXTJCE6dGSna2Hrt/x9pVE4gFne9GydCoeWAnlfqBkz+RHzlJ6Zdkg1RweEz389Xuiing==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7xZ65uusV/u3d54qw8h5Zw1sFpGn2PLAP+to8M86Hc=;
 b=TArj4/G6Wam583QBUVx25sTskzBk0D13qkoN/gZnI4lIGFEPTCSIWGHhfqU8sze5i544M0qTXrsdkzWEYkGcop53FYZ00sLU+lJ+WXr+t3eT8r4NSpZNalDVrRjzxDE6McQbg7TdhU4Ji0eRnOe/Zpgu9kES9pYg2zrTa9X+lK/+R+PfhJR7LCdhXGpWXPOXj1zD7vdCPaOVdWyGc0dKhvpPimgPeKU+jl2SW/EMETccQQscgMi9pVuplye2uQGVzHM5n57kUus0q0JQQsD9E4pWnXmUEh82whI3pKBD+gOof6dK3XnekSM+tqIarLk4bBJt+E3lIDYC744W3JU7kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 13:06:25 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 13:06:24 +0000
Date:   Mon, 4 Jul 2022 10:06:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     yanjun.zhu@linux.dev, zyjzyj2000@gmail.com, leon@kernel.org,
        linux-rdma@vger.kernel.org,
        syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix qp error handler
Message-ID: <20220704130623.GA1410451@nvidia.com>
References: <20220526025438.572870-1-yanjun.zhu@linux.dev>
 <CAJpMwyhLuygVe3dsg=QkOWwmDSFxpRRjCWNAPr_YknPjub9WNg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJpMwyhLuygVe3dsg=QkOWwmDSFxpRRjCWNAPr_YknPjub9WNg@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0369.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::14) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59d43bdb-6f6d-4339-e06f-08da5dbdffbd
X-MS-TrafficTypeDiagnostic: MN0PR12MB6200:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hSzLj+Q0P3IYd/HkS8mqvXzBD7jDhbC0FJIwVeP1Yh9rb++LKuus8RXAduWbriTe9M05GhzeydpJP8ZSzN21OTZhWxYJ+zUSFHvhilXZmo9CDw+mhuSXZiYqUCjaCP2BXkHkuxugYudFNJEUQ/zpwDLkeF0DQEssB4u2Jq31FnwGuoqoufZg8En6frtDXfcFHcIe9hufZGxa0ufEZJG3uB6QRfvJ3LV0TjZ4cesMU3kGlSTBcm59KE6/kBnoCKRgReVGWFPCzyHsHE9vCuIqE32ZtIW/rZKhGJla+D6VKQ0/HzxIv5XaZF2apE8m70fhELd7n+76+JZC0QstPxyfiHxUHwCKYB3HW3JWnUjBAI4CuENwOs/MH49XIa0w+iU10P7y74NLTz0dIrXPTnnj/LJaSzow+OUddRAtzcvtMVjKEPQAXDxr5BlyyAeovpCyietMlXXubybm9ED1wvdnmtQ7iGwB8oX0d5qU46QMjPrA5mBfnILYOc3bUiyOILiXUTAHzGJEr9moHdQkdbmBZe4YCEKdlA8D67XwUvt+t960xXqdNpOWAcDjLDWzo8WYFZQTChw6xj+Y+RR/u1E7nVmIufRJX17cp54vV66GIwNpvGRGo99RpVMkYnjnRVH/Px9TCNO88uzjwszRcBOwNJPARQ0L4jMikg6lnF1yFNY2uZBOYib/EienkYsUfhu4BZLVL5c+AybpE6Ax6hfCWvY6OUZ5Dc0sRLISg8c2f/hd/1DbgZlUXo9bNre5Y8Vpq7jpkz8QY4YtH1XC1LbvYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(8676002)(4326008)(5660300002)(316002)(6916009)(36756003)(66476007)(33656002)(478600001)(6486002)(66946007)(4744005)(66556008)(8936002)(2906002)(6506007)(6512007)(1076003)(2616005)(41300700001)(186003)(26005)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hpfnvKtZu7zZRzTUo6BgnSMsHbBhMtxLe8cYbMHmzKddH9NDbIO6I6Wu/4QZ?=
 =?us-ascii?Q?ar44dG5zkck70Yha9YahaLbiohy304qcte2UCBnTMn6Tl5k+QZcoqphBiUzr?=
 =?us-ascii?Q?zcmrrk5teyo8fVt/6BZ4TuXN/sGjhNy82Er/y7GFk01Uc5ESw51dsb6OjgBT?=
 =?us-ascii?Q?wfxmhhG3WGM+DBZDd9r+KLbm14nlJ62TEe/G7KxVpmVYOO5Q96VyNX1I8xo/?=
 =?us-ascii?Q?2Wvh8o3ztrwpoApyMVbcTxaw6fAWqK7l88+SCJSwvpxLr5t+JOExMSwv4IK1?=
 =?us-ascii?Q?c4LRQujhK3sfwhaurXWQip3ZRfTyiYqYDDdNVA/bmMQozvDbO6E6lsF1Ga4Z?=
 =?us-ascii?Q?5c6VGzmGCNm5ESOZFYymE+AZhK/EHGy8XXaC907B0dxxW/NlIB7rSspnXaiE?=
 =?us-ascii?Q?WjzdW5LRmZE3WkCGBNedgNk81RhOcgF9Kg/9sA0ptMEy6AelstR+ic1jcb9T?=
 =?us-ascii?Q?xkQAppot+a6spCmJt+VdsRssJCbxMB9o1YJDcgdpAy/dZdYPRMnXOkq/Rry2?=
 =?us-ascii?Q?M0138xrVo1Mp97OWtGo6oL5cpL6XXcba4cX4hXKTZL3J/zA1pZ5UhodoQGrn?=
 =?us-ascii?Q?Z0a64HC8tnug3l8hw80oKXF83rTR9ODPrf2s5/zHi7wCaMl3wFK4P+d3eT/r?=
 =?us-ascii?Q?jGHi9RKKjWY/J8S7Ghu+jzd6L360pc/6JO78lPKpeDQyyAIFF0Hg7TSsER3V?=
 =?us-ascii?Q?QreEr6Vczw0suPGRbPvwzh3cm5EFusZ2Rr+/WsTk9YJlKKqK9N6rUl+wDVgj?=
 =?us-ascii?Q?24tgOJz0oeQw2VXMg/BT037vsvq2l0lSB6N00VNuslFkxU85xY3aq3MCg/rF?=
 =?us-ascii?Q?BBRnt9ESvxwyD6ISEsutOSnIqNUD4Ehi4S/kk/WEgyScHDmLPl1o3fqOKPCW?=
 =?us-ascii?Q?Gb0UikQHTNIzmkuH5e/zPWZlSMRKWjUhJH7xRL7zUAx+/km4E96e7Rrp+gTS?=
 =?us-ascii?Q?yeaPhxV2qsAhyfrKnBRUYU3HeoQKm5MGeZGVmvihIWYJrfduntdeKNM46o7N?=
 =?us-ascii?Q?8jgAM33yvUiFZmGqZLjq4kOWdIy9rd0AHQ4hEuyB+1iymIPDqUXdlmqHiTr2?=
 =?us-ascii?Q?ZiKYCf0rLgUzbLeHYPOR8rG2b9p3AJTj+dawzwMJkOWY2rQzyusrzGamzwRh?=
 =?us-ascii?Q?vZzDGlOamdIBu3+rzYOwZQg646o5t1/Gqq9qimWF5cfJOug0J52b5u0vHMUF?=
 =?us-ascii?Q?xumkAAAtO0wBvXwIuBtiC60W23P47c/r9ei6XZM1pw0Li+sP+o3meu7xM+5J?=
 =?us-ascii?Q?2cKtcFiW+GJYVz5EZ+GoOIG31iN1szCoTFjUe3lZe2OwqOgqRLhPM0xaReVY?=
 =?us-ascii?Q?lCMw/o520+GfQINrxOCusNKurRZzL1N7y+BEaxaUyLc3kInj10q6xzk0NN46?=
 =?us-ascii?Q?d12F/SI50p3AjYwup1HHZqBuiF+qj5bdQ2mP3eqgk5GsZv8XD+f9J228QQdL?=
 =?us-ascii?Q?UDGAbm5LcGY4pP1AQAgs7ZOxKF6Pw9IyPTfbgbYaFi24PR+PxHn+E1Db2lGK?=
 =?us-ascii?Q?sWu4jAcaAsRYJCBdvCrubRDGPc0kTudUsynrYScfP14sKEdEkiJnO6Lz2+Ao?=
 =?us-ascii?Q?TprxGLnkS3rgd8x7GGBnDA0LyM/czHN7Lmyif+a0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d43bdb-6f6d-4339-e06f-08da5dbdffbd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 13:06:24.9380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VrUXuYB0hfz/JXa2qFt2T+KVF6ei8PRBX4B7qT7n7dgQzT3Xc+KGWbZT036j+Af
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 25, 2022 at 02:29:06PM +0200, Haris Iqbal wrote:
> > diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> > index 9d995854a174..d0bc195b572f 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> > @@ -432,7 +432,6 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
> >         return 0;
> >
> >  qp_init:
> > -       rxe_put(qp);
> 
> Does this mean that in case rxe_qp_init_resp fails (rxe_qp_init_req
> had succeeded), we will NOT end up calling rxe_qp_do_cleanup? If so,
> would we miss shutting down and releasing qp->sk?

Zhu??

Jason
