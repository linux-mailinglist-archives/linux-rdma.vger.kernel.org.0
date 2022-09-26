Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5675EB526
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Sep 2022 01:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiIZXLR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Sep 2022 19:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIZXLQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Sep 2022 19:11:16 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BD7A99D0
        for <linux-rdma@vger.kernel.org>; Mon, 26 Sep 2022 16:11:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcfpxrXOKzSAf8YIdCsp50784j8cnR18Ij5h0UQQcceOXllJyr5qUpTZkw4XGpVCViauVbiPNXRFo+5IQJQxji+1XW5N5iZtzNMPiG5WFfUqUS1LNo4QJKOPf3JVhq9t/Sb4ZubmZsD6+Z62c94sWYcMNOoH6g7nefjoTo30fAq3Hdc4K20+4ttua2Ke3QUsluznyyObGzXWaIPIKrb7atTxIt/EnB78b0vTiguseRdtEJYcvnXKaDuCPFQSGxra69K+9d7UJx+3VWKhy5gAAqb/lDVWLgpk5i6Po7UdelfQiUaKjrql4+8cFx2VdnR6PLP5FTx7gvBww+F6kDzgeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8l9nAN+HqwRhq7J7p84YfMz7W/eKra/KtgJ185fIM38=;
 b=caGhVCvW37etYRf44TYl9LEVsuMLCB6Pbxu/MHhkxrrXllU2/cIGk59VF7u7ZbxmEVgrSakHmhofHgu8JAg9r/Bq2hbmzYkhqoiO4iDaL+HDBz3ijTjiTrsCPpaDoYr6ClbC4cFs8vuaWarnR76QVjgocxu9Y7XsL1X4Guz79O0V+5uTEP3H2F5Bsug/TFvRHKp+Sx82NvWIa/nomxOYXoRoW50Z0y+PCrkFM1wj8dZNhmDuvtUHd0cAkAPpa1ZUDaIg88jEJQhX4VBWmoxGcp5fYTN3YJCCwAJMgxxW+w3BRPV+aWL5Q6L3zFwFqjAcpehlM6kYpP9RBsuP6DItdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8l9nAN+HqwRhq7J7p84YfMz7W/eKra/KtgJ185fIM38=;
 b=eups0cY+T1e+/KEfrMVA9RSxFUbykJKppRoXjZnG3tjujzOkwtozD8fne4H7M7eLCj1W3iLVPnInCfA0zOdGGtqoYM0IiJg/PFhIPqfuaMLYkw71m6yf1N5S1/bQUIJQVYCuGSPCORQ9pYbd7hAxfRVrX1lLrodjrvbD0jZlp+cyi4IAGbuAz2P/ouJW8aNExGV1v9xqdZ9AKyRDaMkqqWWbkWjaa83E15b/qz7eTHEbRPHAspREQgDwRtcCWC38SZuMGdEgsEL20fGfQ/jANz29hUur+UVQUee4KFGLynLndKlEkVPkxmriSw93Gs7jdxeFdYXAuvBZM+NCxReWWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 23:11:13 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::f48b:35eb:5d46:7710]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::f48b:35eb:5d46:7710%4]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 23:11:13 +0000
Date:   Mon, 26 Sep 2022 20:11:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 07/13] RDMA/rxe: Extend srq verbs to support xrcd
Message-ID: <YzIxkOeGzkgyACc1@nvidia.com>
References: <20220917031104.21222-1-rpearsonhpe@gmail.com>
 <20220917031104.21222-8-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917031104.21222-8-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR14CA0024.namprd14.prod.outlook.com
 (2603:10b6:208:23e::29) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4181:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb55bb4-0010-4dbc-e8a7-08daa014681c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FeQCfMmJESeX4eifAm6bEtPT3YkXreWVJgECDxGruAEqCQyYb//nGsW8i16aKpFgAgrRpTFVXXkqkAuEUb7Etjb+PS00mnHb2WYMVyR91fnl+6obc1R+ElrghgaqdNMBlGeNvAQaAgLErltJe7Xfq36N/euH0/CGxLnvQSjBW+VHLuzZv6BTAkFzSxg7IMP+tnOaBkb1A+PhKcym9V6lMhryZbVvhTZ9iDMYtTGRGHlk/QkscOZD6GX9RKzlBm4XQqpaXjm6i77dCGqCuQbwplrkCv3z1G0yES/lK5BjN9hiZCcqklGz93Uk8Z7qQa4dqScGJiNng7tar9CxOxsUiDWPogYeDaQ0JfSHGQHVYNIiwe6TEg8b5vn6P/UOIR155qmUs1pGfTXnOAs1Utke7zEt3xjKvwUjMvZ5fNP91j1L9dSsMK8S2khHM7b9jEKSHhvpZ9zt10YRJEsnYhHANpiq+vsQq+Yl82H4CdpAs+nXKWD8sLeZwzRJT3ePjaBG3U5nxJjOTysgUQLrnnya2emU32q+n8ZAsEII0dWCx35SbFH/zeYWQtVj5nge8YpbJlY4m0IJMZlTAJppI7NNRQZJ7/inUcieG7lZpyc6KyQI9LUfRo1y09Hb5epBarrUSKKUKvyFQtZrhSNF2da8TLJB/h+oCjjb469ejBMMl0Z4uJWExRpy0rEYKTD5anZZS9Uu2MmWlvFzIXR4ezDwow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199015)(6506007)(6512007)(26005)(4326008)(186003)(4744005)(2616005)(2906002)(5660300002)(8936002)(6486002)(41300700001)(66556008)(66946007)(8676002)(478600001)(66476007)(6916009)(316002)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zmxQgUWkU02xKTwGcv9G9pq1hibqRXPP2M5n/ic08bXiqJvkFTFH3ZQEQWiU?=
 =?us-ascii?Q?m6HkK+D58sSvIql3j9Lm11H12UyZpl2XlgBotMle18xVabW/ua7XeiRE1Soy?=
 =?us-ascii?Q?yXf/0JeCt30VUeMe7Pjnnt3DvDXs0Sj3b3qgAVtUGr53rtW0J9OuoZcLDd7v?=
 =?us-ascii?Q?4m5UEc6HZsD8snQvLixNo2psDOFCA4ZUP12ULt/D54AEW+FsdWlYd5fjm63b?=
 =?us-ascii?Q?juLbyagflQlPI3vBeo+K8DB9a2OrP8yYZd1sNeE/o8zEa8FG/7fzCvxp4kUP?=
 =?us-ascii?Q?2eOfEI0arrLAyBRnjMhsK8nURHaE05anjdOhFZ6xtU6RVTzM6K5KoYbTte5T?=
 =?us-ascii?Q?4HPOsPkFdPlA5W9pgUOtGsRgdqiLQo02zGSIanHb+52InN60/mA33NpQ0+Hr?=
 =?us-ascii?Q?V3ATCZKGhM/QYbWpb+0BN/jArP8PqlZ+zmhdDKu7xIcubL7TOqhUP9Xx0eVS?=
 =?us-ascii?Q?Lc2vPILgW6PgqNz2uSZL1CSoT9Jp3I7u5OAjeWBRBLKU56QlTGxbcKb4tIUx?=
 =?us-ascii?Q?WVXIqhiOAO+iuf86HhwU50wz+c9SQH+SDG9FEFw/YBXqCcrzgcBXjCz4CSLd?=
 =?us-ascii?Q?0nVC8n1+ZwwrCcnI+Hy2Gdrc/82ih5HybSX+e4frjQmWRCY0+znkxZJUW0Mk?=
 =?us-ascii?Q?X7fuy5tig/pWiMpk884u4N32P5dS9BTIilGh3Kb1uuzg6JKzxjGWfiBZGjB9?=
 =?us-ascii?Q?Se4HNDtO2MSz//Vg2RJvyVE+D0LWbXiduJDXYqGhLNVuPOlUfeWwSO4ckfy+?=
 =?us-ascii?Q?nWSPMvVUeftOc2QJBz0x4ihmBYdGuSedYArGLqb+ZN4wBIHTNL737yW9Qe4z?=
 =?us-ascii?Q?THl5HZOZlylwhoaEYskSZeafwXmUk561FbpECJ+IPM83nzR0SqSvalVVDY8G?=
 =?us-ascii?Q?NucdjJ4FLr+Jq90TMomswtjNhXhJ8je6csUkZmoJdffeCz9wiq92PK1cl7U/?=
 =?us-ascii?Q?XrFZCOVWmnscecK5GrEdcMS52Vd/B/DSWn+2Ms2KbSSIlSiGDsNm/2x+CJh1?=
 =?us-ascii?Q?puAfOl1bn+GXCkoqZpwVgFmP3Y189T/eGrluUTuJ+fb6/KLbqH21PZr05vFm?=
 =?us-ascii?Q?ASo/MjKKTnF1xQdungN3hJV2uqaS83YXye4RGtjlJfmM/2gvCMibyd4MRH1Q?=
 =?us-ascii?Q?R6eQFELf3V+5vPiYKGmeF5wFlbsGBXGGBAlRlZl19YaizE0NSAEsKZSa9j90?=
 =?us-ascii?Q?98NXrMYfkkZlAsx3K7eBHIK/fAEZxSDB8uOgBiMpzGZcWdrRG/YF4fOLdSJs?=
 =?us-ascii?Q?G14Rf/T99DCzN3nkeT119XoJWl27B8zU8jFMDXRnlkCt/Jft3Jd3byk3WC49?=
 =?us-ascii?Q?KWvERTAsRJY8VuZs43n57yfhr3xMDQGdoUkyDSuznuNh9Hr2LAJgG07VV2dS?=
 =?us-ascii?Q?OgeLgNaQRj8Ib6WRJUAX/wyBtG+B+CkV7tKKXkquYe7yqXlY3bA6dqnbDAX0?=
 =?us-ascii?Q?JDmvqQP2qD9f4wSugx9xhlvKuLgb3HXaUWaW6nZsG/nBU/iJQuSCvW8VWB5A?=
 =?us-ascii?Q?IL/XRlOsoLpkblFn0oIt9y/jkwrUGY2OToarQF59yMZuNOMBZPZhNvjYXcXE?=
 =?us-ascii?Q?abgERzYBTd79zX7jNN8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb55bb4-0010-4dbc-e8a7-08daa014681c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 23:11:13.3955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Y6gy48nlDryUENpWza+uvs1A88FHXZ0j+YrieTYb4u8LEiN42sqHNFgAb3Z/W0y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 16, 2022 at 10:10:58PM -0500, Bob Pearson wrote:

> diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
> index f09c5c9e3dd5..514a1b6976fe 100644
> --- a/include/uapi/rdma/rdma_user_rxe.h
> +++ b/include/uapi/rdma/rdma_user_rxe.h
> @@ -74,7 +74,7 @@ struct rxe_av {
>  
>  struct rxe_send_wr {
>  	__aligned_u64		wr_id;
> -	__u32			num_sge;
> +	__u32			srq_num;	/* xrc only */

So this got changed to reserved, and we are making the leap that if
the userspace supports xrc it also isn't going to be writing to the
reserved any more?

> @@ -191,8 +191,6 @@ struct rxe_create_qp_resp {
>  
>  struct rxe_create_srq_resp {
>  	struct mminfo mi;
> -	__u32 srq_num;
> -	__u32 reserved;
>  };

What is this? Why is it OK?

Jason
