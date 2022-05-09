Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6495451FC31
	for <lists+linux-rdma@lfdr.de>; Mon,  9 May 2022 14:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbiEIMMz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 May 2022 08:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbiEIMMx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 May 2022 08:12:53 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615071BDDA1
        for <linux-rdma@vger.kernel.org>; Mon,  9 May 2022 05:09:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjK4yBdbif99+W0QJwvx4GExxhUTNSqr4ApcTjyKcvKOBrbtHhbsqgcFtCOI+5vbCAgcav+9oavycTkvvj7kYSBUMg/HRSyXSUd5Lfxxjl0nDxRQhAxkRbMtZuFr4xhoSbeTzagZpeg6uf7p6E1ghReLdxtFld5FxTLMmxBeG9GynG0q00mcvML+X6HM1xd64r9nfDnqLLL5DUNAQJW77I5nR/rB9ai01m3IrAPxpFw3BolGkRXGo/3hTxBRL4sLgeIWxc0HgdhRpKHVYNNFpXptxOnsb0qDyr5flRRwq47hh8xiYfRLcfInzbZ+55IujtbdblYj07u77oRKCofqwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAM4WVzhOHN3SvAtXcuCJpC0Mc2LDKfFEB2R1Pc1eYM=;
 b=Kfh/4n95fDA9DtWgGlWGvQw7b6GF3QqY6JRHXh9dme96W3HaMh+yJVmD8oscVZG7iobDUuLFAJrFeC2oX+2c9krvq2+1wrzhrEgFWaDmFXQLn9Iwf4Axb6uyDfHrGQYRJkLyEyvfJBfIrUtpTASsmUqAVFeRSRDeDrZW78NCAhTgWbfOYd20HrRzARs4vTXAyGx6wJK/DiDVtGAXlQmNnmOlrDsyVfalMJwLp7I5eJcSQU4rWNIgAdQ19q0PQ+NyvXZqNWadS0vbyJksrGfCP9QfWiWHgi27RbZz0N6STcLTC12I3EKDAcuFnbI76BK7Jqu3ez1ZNbgI+Y+GzWnuhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAM4WVzhOHN3SvAtXcuCJpC0Mc2LDKfFEB2R1Pc1eYM=;
 b=WEVihm6rvj6QZ3WvhxWzBzKuBTSSw0c/4iNZ6yOF4vNW111UVkp+SkOMMMMvKa/kiZL5241c7peX/A65iibAr76/ndD5P8I2enNX72st3GFx1+GNsB1cWGK3PB+y8VsCgCM1EuK9w6moMRmtMkMa5eVepMo+gy8DlJPnI0ItxxJRNSsR5+j1EvY1QWsq7bdVNjnGXU7ys9Zqf7LB7jc6Czm25R5osRFTNriTUi4K2fpj3hV5uEb9JSMo8Ep6seNlDsrVHurASk4NN4aG4HxSen9TcuzxpWNtgcBduqn/7eiLLbNggi4wnbhv8g74RGzLUYy9wsMxB71BDXMyRYA/6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB3559.namprd12.prod.outlook.com (2603:10b6:a03:d9::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Mon, 9 May
 2022 12:08:57 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 12:08:57 +0000
Date:   Mon, 9 May 2022 09:08:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v14 06/10] RDMA/rxe: Move mw cleanup code to
 rxe_mw_cleanup()
Message-ID: <20220509120856.GA843067@nvidia.com>
References: <20220421014042.26985-1-rpearsonhpe@gmail.com>
 <20220421014042.26985-7-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421014042.26985-7-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:208:23a::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cff404c-5296-4b45-dd2b-08da31b4b1df
X-MS-TrafficTypeDiagnostic: BYAPR12MB3559:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB35596B8FC0B1BA9BA5DD1B8BC2C69@BYAPR12MB3559.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wbWFxhFHcqPfvF5wrTJmU/yvFm6GHl4tGKfqjc6MtWj56DY4W4YMi/DRcw4c2JZ1rIVMAT/oMCEY7wa3LxRNC4SCeSIaizLKhkZ6FqKXigbCPUOMy+u+ZnjUqE/DzOHP+6oFfVuMyjZEjSgp9tXj45gQ0trG5WCCuQ9d9ZG8ffnI6uaMic968OCLcVerVf29DH8bnQqD6tHWfwLXtNZELK1pO1GyocifeiMuoLABjEISranK3KUcFnTr3kHAZRrBaOOoYu6WwIUm5YBn16C0S0d2YqRVEdQqtgl8yaWXELhXZFqCaLMbnnpYV64JRu1HKLSO50j0R6eHoxAZlKhzbi47EcHMjLfoGEQZW4/V+seBTo0ZFrIKnjj0Ble/QBzIJuLQGSaoo5WH0HoCDQe9Uo2OAGMqUIfjdcWbPidj7Q2zDEEQ1A9sz2yIbd/J0deqMo/SPeWrljDiV5JuhmOyswllw0H2+r5ka+cjYkeU8p+X0SSTBcRDkZPOdNXAw7y/q4uSg0c0PrPqrd93N59NOYnCjYQ4fL9oh6ZRvPtY9E4gguXyxHOB1cV8pV9cdrDbqtOxgl2Sh7Rd56WvGwrWMZ8dXf5AFvKFwaV2roQbp0MpUDrIozOUl+xgkgbOtW6XIteOg47jPQmnWi4TbICr/yEw+CGMbqB/Qodk0grv2wRkFc50JV49rNTziiK7fLVkhYCvrtcVE7QEwu3JfLRbvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(1076003)(2616005)(86362001)(38100700002)(186003)(316002)(6512007)(26005)(4744005)(5660300002)(6486002)(8936002)(36756003)(33656002)(66476007)(66556008)(66946007)(2906002)(83380400001)(6916009)(8676002)(508600001)(4326008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T2GhvCFdSHuhAdsvW67kzOJswDK1/htQYo0z4lc236TXwMzuuLfFHB8fsQQL?=
 =?us-ascii?Q?yiwy8fum4ku/pDqk4q55lhnh5SYvh27ZXwHQjhnS97Co7zLRmK2ZpgFKf5/W?=
 =?us-ascii?Q?pKWyCpTXXqO8DITWrk++/4eOZq3LDplwEI0MyXHqIDNo1WLeqSBjKX9c9Lyj?=
 =?us-ascii?Q?TuQ2DitEZb92wQlKmQeBwn0fmP6DkcW41vKeo1x4uj5sVscs3l5Mn9rh2pgr?=
 =?us-ascii?Q?E3b6Io/l8XevRHYOb4VA5On0W6R+pSD5roq6o7cQbJRgyxERbTkpHQtf/QWp?=
 =?us-ascii?Q?yi5/t3oiBb5g0mp4NWKaC2VXIs7d1hHFXJ4Frgt99KngcCFpILw67zjGB61F?=
 =?us-ascii?Q?Tpbxb7zzHLdPeWKv6guVEO784ZQwTNCbIWweoAr6WHQuB1ba5YxLi0cUMher?=
 =?us-ascii?Q?+Y4L1V5Eb7d54CRpjhGJ9Jqp8S8Zi8u0bG3dNoIeJmwK/ifFyCJyhadoj7fi?=
 =?us-ascii?Q?1ZP2C4HXu0KQB52cu9ECvKPKWcVmVir1ctOIc2lNNd+FlpZdKkPg8SesH82r?=
 =?us-ascii?Q?Uz5PBi3f78no/H/LmfuHSmd6Wa7pbszn1JqMSsz5Vyl8DNYR9xc78oyKlsoh?=
 =?us-ascii?Q?BiRzi/TP0on7SlfVwSip/09tWS6U/BlEEQHI8Xr1fI3TmQUGHR3C37B/+5Ui?=
 =?us-ascii?Q?lVOV6+RxAqRdqr9EX+Tv724gIDZJTbD/PGH4hP9tTgPoqcb4Ej3Vkn1M9Cs1?=
 =?us-ascii?Q?kHDyUJhFiXH0na+F7go6hWkE5DQhA/Mh5Ku3CoetMkf6fsUDe/0HPoX5zqBc?=
 =?us-ascii?Q?vCAFvdGMIH6Dd8Z6x+A3vqAUt/j8D8u+ICl0Vfvq6bZ3+Harl9u1Uv7XrHdG?=
 =?us-ascii?Q?asa9E7ANzfSyPKD8DtnbfJBszT7OojE0PKDT4+s2WAKlSBrHjuskZ4d2rnGt?=
 =?us-ascii?Q?TOzmmzMm9t5H088kQZEe7r75cbF8cIU8CiVxbW+uIw9iZ04cBZsANsvjw4dy?=
 =?us-ascii?Q?KLLRNEgGU9OtajH7uiriLovpp+GV/0NYZDiSq36hcUiUQzrhMY6P9oFB3FxT?=
 =?us-ascii?Q?YqDw8UVIABX5AD3KMratumtMWiheRYc7uNSqRtnFg/HRevuJqRWvKz9fdeAD?=
 =?us-ascii?Q?3ZjWJq57ceWp47kOrhWHygj5Vll28MEHvc2mDkkj+VDCWvACDVumxlRASWzT?=
 =?us-ascii?Q?q4mQYGEoWTe0UTut2yxG6bsNj+GQwZYqG3l0Y2LzHxe5Dw72LD/FeA7DJqCx?=
 =?us-ascii?Q?hOisAP93qdOFIcKbOeNKi/fDfUEf8P3jBImJ/9kyWW//5vYYu8uDgA+jagA2?=
 =?us-ascii?Q?WHT4NcQ+zr921lxrr9m9iz/GuseDQ2RrS2PWZEo56MstSiuWcHBTEGafVULR?=
 =?us-ascii?Q?9h28pCbjALelzXjlUY5+V63+WG2RVLQ+qSuEdBTV4u/6EHho6Ccki+SNkG/r?=
 =?us-ascii?Q?7eiHQ6QQ9SJskvQxasFYV/258Kx0ae6+uYkfWV6b7UBTSI4Kij+X54ZAFZmB?=
 =?us-ascii?Q?WNyuk4u7vrl2YymcuLCPdOXZwMPe25L2QFgM0qoFDPTzxhWvdxON+aNkOJFz?=
 =?us-ascii?Q?OXfVWLuOSJjTRQzSIG4uU89lLJmgqFyanRK9kjji49qCJ+em+kLurRp07cI3?=
 =?us-ascii?Q?EbmGiFAtwnPzSHfoFpvywDAv9mn4UNUXCE33aN8WMZ3HMBCX9vVbvwtYfFyr?=
 =?us-ascii?Q?1S7+gcmP7PPmBNUhOAohnjcmZhKACB0Y+9VjG0myYbYKNoQe+AFuhHKvJ6ge?=
 =?us-ascii?Q?A8J0IMHsn76p0HCO3KqyaRtDpvzKcl0zMVH6CDEcpx0RIL4vbtiK6U+ZjbyH?=
 =?us-ascii?Q?xknHnW+Rww=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cff404c-5296-4b45-dd2b-08da31b4b1df
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 12:08:57.6176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1HFHeRlqMJtrvDsgygbWhtRuRuB9s0HFunxcFN+4B23m4N83CaanaNx5NVOAUcI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3559
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 20, 2022 at 08:40:39PM -0500, Bob Pearson wrote:
> +void rxe_mw_cleanup(struct rxe_pool_elem *elem)
> +{
> +	struct rxe_mw *mw = container_of(elem, typeof(*mw), elem);
> +	struct rxe_pd *pd = to_rpd(mw->ibmw.pd);
> +
> +	rxe_put(pd);
> +
> +	if (mw->mr) {
> +		struct rxe_mr *mr = mw->mr;
> +
> +		mw->mr = NULL;
> +		atomic_dec(&mr->num_mw);
> +		rxe_put(mr);
> +	}
> +
> +	if (mw->qp) {
> +		struct rxe_qp *qp = mw->qp;
> +
> +		mw->qp = NULL;
> +		rxe_put(qp);
> +	}
> +
> +	mw->access = 0;
> +	mw->addr = 0;
> +	mw->length = 0;
> +	mw->state = RXE_MW_STATE_INVALID;
> +}

The cleanup functions are all called directly before kfree while the
ref is zero - why do we need to zero the memory here?

Jason
