Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B15376A025
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 20:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjGaSQF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 14:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjGaSQE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 14:16:04 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547B8E4
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:16:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASjMJ5etKtgk79unhSOts742hyCC4pjqVFjEC/3uTlubFytuN2rjlGl30SMMsgXbw+OsSxk7wav0TsIK1sOfMwo7NUq5+leT7ZIf6FI1sxNTtU2GbMFBUxwEGsYH9z3nYEe/NSc/1BsGwNksDvKQ90X9t95bvnogzgSTN8WF9I0RWPVEyNFAeX9L+VaGYVBD/2Nd+pDe8n8fHmLb+agjTYsHE6AdMjeGc2JVPwLZdE63XOd/MbPSJmECErNDGyfIwccZUPXz8ZlliMVbAbBa1XAy4LoWSx5IuLC40tkZ3H9uS0TSorfobjbxde2crMJkcs7Alu6aqS4xpOvOSHy5zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+UdYzy6RlPBtNX1HeT4NzkI+SLpvNPQdsIIKijtuBU=;
 b=IGw+mnEfjdnxEqYZrxXOKWYbQ1hC/zZ1qUeuC9zmLpuZoqQsIY3WMxl6j27NY61u1sjSSFYHl7Uhvye2ufLljgteMPPSeKJvl1Yvla/1H7CjjF50MuniuIPV9N5gpwuAEi2/PEi5zGbWrJ69/8X6cgz87wbVkB+d1JyX/Ini50lA0Xv/Wl0CK9aJSPMwV/l4Y393mqDKvDjox1qxOOei+IELmaQ0qRkbNGRMX9P1LNmCJDLkk+67BoNEyhhDp2X/GGEweKZZt6cfVmeZyVRYlejg9FYFhiG//Ak5FOfy9KYNPFGD0j7APvnvvpBOXRF44KUTmqRtaRzukBiaU25Vgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+UdYzy6RlPBtNX1HeT4NzkI+SLpvNPQdsIIKijtuBU=;
 b=TKuZt78pIqZNBW+kCfbGVkxnNzKCaK8uVif//Mv/eG72i5unl3WS8MZhCXTX2hAP9XqrHrXxwLNzMfyvHUaYz6dr1n0VC3d1tKUZLrsC+57k0Un+7WF7OncGWOUJYv1xDeA6PkFr8y9IWZGn096E6B65qJiyobrPBlI4pYkSLxmk38YdsKgKngYMh2uLdPSpQQgK6EABR0Bw/BKDkbrqtnyMDQedj/3KOWX1BMFOoy6UTHNEMBtYU3DvxZDfH0ECqv4zVie3tqx20vefkyqvaHGU72DJFbdfo2R8hPOva/QIt99x7BQu73gorQ8Hukphh8i9Qn2/PDskx5db9fDjTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB9060.namprd12.prod.outlook.com (2603:10b6:8:c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 18:15:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 18:15:59 +0000
Date:   Mon, 31 Jul 2023 15:15:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 8/9] RDMA/rxe: Report leaked objects
Message-ID: <ZMf6XBIAD0A25csR@nvidia.com>
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
 <20230721205021.5394-9-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721205021.5394-9-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BYAPR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB9060:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ffcad9-5e5a-485e-74f7-08db91f23125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8bjD4rNrd0DP6iAUhJ5o3wQtKJuugRIUC6RxgHefZSeGhudYXWSQ+d731YSi580Xo89lngCQpDOWz6EFRMoBE5ZvIWkqkiB3Vhb14v4iQQTsv4+iUgPlJNBvyN3N58Su07/rfrP4Bab2mayilDB6VrBmVTxskLxGjLU/pGCSBYvcOdpz+l0loS8SO4IX1H9oF7UirdePI5ZUR2HCTn3O3xgacNaF7BgfFEslDzPYBmO/1l1oWyBhOLdxs0oDseCEgdxvashx/avuIBqTfSEwYeMm2Y6oSe3NyfjBkBDN/r1DasLof2mIC5WavxhdMomP2tXvVO/lpYC0bC4VdG5QfZDq10wp/EsLYvqgMbyaOXY4BUj+abRsIO4ZZasdhqduxzFXKGy6hXbof86p4lxQNMcaHltG8zANsS949f+ysU7gKROtZO6zqO0xoSoZbFjxlI9e2pExHB7PAURWcdRCJ0g1zR7IDXsDlrCrXrbRbdHtg6OTZ1GXLpE1O3qIkTC+QxLTN53HbJynDe/B7ZPtVWxPE9OesvH1ZITZ1T8vkVdLYIf6JuEgoNoMpRhArzle
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199021)(86362001)(66476007)(8936002)(8676002)(316002)(4326008)(5660300002)(6916009)(38100700002)(41300700001)(66556008)(66946007)(478600001)(2906002)(6666004)(36756003)(6512007)(6486002)(6506007)(26005)(83380400001)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mAg7wqfTtgSwTyIcpXdgOwSEcG2qU/DwS0LTAoS1WWE2q4dgoqXxh7GYJYC2?=
 =?us-ascii?Q?WdeZ38tlRgBBMYjLLVuPbaYd4HilZfmM2+3entXi1lnb12HtVm1hy8sza9/E?=
 =?us-ascii?Q?mi9Heyzlv4gscyeNFhu0CLJ8XGLX2dXOOJsvLfDTCpXXW8b5ISXv6B4nm44a?=
 =?us-ascii?Q?0PHTZIRw/gfRS8s+rdqQo12E9Dcjd0mZBI91kYmqRfcERnUp1MSpKfdxbKyI?=
 =?us-ascii?Q?Oi8xYJrSq1aWLFAQbnx8tw+6CjxPVtNEsEoWPV9zm0hOdEAcoNeo12WX1vqi?=
 =?us-ascii?Q?hQwwxYLiud2G/GkFxnzbna8IkTaBiS/PcFTGHIw79Lakp4fljH4CF/Xqtriw?=
 =?us-ascii?Q?2UqNSl3EJQCUjGMEsPby5ejPaAIV4/jemQv2hZkjMYs2mVuPYTVc36MxnkGQ?=
 =?us-ascii?Q?Oud4yR+zeiFLmIVzigv3yOe6zOk4KZbNaEofoZoFl0GVYTQlnf3rfUnZD1sU?=
 =?us-ascii?Q?K6+Ww5rnRqB7Z0fuGHdRYBGLki0vQmUxOHAAtaWJ8LaXm2FA+G6bKpvDy8zg?=
 =?us-ascii?Q?G/PTeUPAaCGizrvgwQ9Mu0Mi7bueSbG1tsd1YhEf47a9Fb8fEQB4gwIF25tV?=
 =?us-ascii?Q?IBz2z7cfU4pDIhAeZDZQk1xyN5tGyrvDDTfFDfhU123+0FGrlIzMorJDzLHm?=
 =?us-ascii?Q?BQVFSKDwtDa5UPbYqTrGEa2+t/tTxj49b+NKFp0ptLn2PN3XcfjmOnN+VYsG?=
 =?us-ascii?Q?jP1H4/g5bIiAFo+bSlQiuPQqXPWVH/vFWMSf+t8C7m0IFpQ63vBytVVU35JL?=
 =?us-ascii?Q?Wc9+gheLqUlhiga+/95BhYLsd3F5H7QieXCxCNqXV+eAFv/WBgxqN/uNUgGx?=
 =?us-ascii?Q?FleFByDB32Tx46iHVBBHhCclEOjSAJkUiS2XuN212ipv1Zf9ii99nlwr34sY?=
 =?us-ascii?Q?zbUaAaeZoT5h56haIro4gBeD1B/CG4IjnoRxDdQbUwfeFXXyE/HmRVhWszWu?=
 =?us-ascii?Q?9dHLTCbfzE0gZYwis8VQCxO6JUv6xZswPj+5eBlmX0SA0i0iw7AbLicugEvv?=
 =?us-ascii?Q?wYQkRGWh4HrQQOfAtLeQSgt6YrOvbF9kJRYnQH94vTfWJ09qPlzdGoNSBzaj?=
 =?us-ascii?Q?haFtkSfrK57x6gWYDrVZaW+HGxHkhxFWfI3qiVvUpaRnTPOIbMkucWEF5L3x?=
 =?us-ascii?Q?LsuLN1950gbO9D4PiqAVnWqs60ldR/ltF3C2ldz3zDDOV+jbDJq5SI8XSVOk?=
 =?us-ascii?Q?TmzI72YjnhTEVYjv0aiRkv5LGjfway8277MrRoEsg5lYph0agpV4UjmSlydw?=
 =?us-ascii?Q?I7WR5XspMD7TdLqn2fm1SFMQM1gbP1Jyye4hwz4zPHl99cxqvlLuAFb7QRGy?=
 =?us-ascii?Q?S481rLAsZe55a/SX3v8ylGLVCkaaPrMyZ0iv0LxD2mHXOPlxSHEwueOrI/9S?=
 =?us-ascii?Q?dP/NjAtgsUkV1hxApQ8fZbNUkyyn+pQY/EqI99IiBZnMAKco67IhctTnounP?=
 =?us-ascii?Q?ma/1krvFcioxDhunZ6EiNwpd0GVCG2wUxmHiNmmRx1Bggn3+MLqVabbdIRZO?=
 =?us-ascii?Q?GaBxAnS8dChXx2h+C9h1CynnAgEoXswTXFamSpFBb6pFn6Goq1H2USbOukta?=
 =?us-ascii?Q?sKKF/To2PAQ3n7RYBiFJDW5qfocgXN4DiQxCyA4V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ffcad9-5e5a-485e-74f7-08db91f23125
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:15:59.7053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FztxRImDV1PD3aVLoBnq4ST2heyVeeNfq4z2O6MsQUNUTwMYuwb71u8UEZqMOi6b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9060
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 21, 2023 at 03:50:21PM -0500, Bob Pearson wrote:
> This patch gives a more detailed list of objects that are not
> freed in case of error before the module exits.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_pool.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index cb812bd969c6..3249c2741491 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -113,7 +113,17 @@ void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
>  
>  void rxe_pool_cleanup(struct rxe_pool *pool)
>  {
> -	WARN_ON(!xa_empty(&pool->xa));
> +	unsigned long index;
> +	struct rxe_pool_elem *elem;
> +
> +	xa_lock(&pool->xa);
> +	xa_for_each(&pool->xa, index, elem) {
> +		rxe_err_dev(pool->rxe, "%s#%d: Leaked", pool->name,
> +				elem->index);
> +	}
> +	xa_unlock(&pool->xa);
> +
> +	xa_destroy(&pool->xa);
>  }

Is this why? Just count the number of unfinalized objects and report
if there is difference, don't mess up the xarray.

Jason
