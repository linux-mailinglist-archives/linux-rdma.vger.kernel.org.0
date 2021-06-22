Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E493B0C0C
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 19:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhFVSB1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 14:01:27 -0400
Received: from mail-dm3nam07on2063.outbound.protection.outlook.com ([40.107.95.63]:23584
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232706AbhFVSBD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 14:01:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUDKoTMv04HzoRkW7NgDNhmfAi76M4ZYT65+8lFhW6DtNyz++OIjVlXRiV89g0tMqSCNW6IHt7pOscNaEhcJPJuysw73IaDB9hBR3ztqjDsK76GRkn+EaUMulTXlrIcSuSMW8oVcckWLvi5v9jtJoX6sx9aWL6/x2IkfBvdrcn1Q0J6p3nG9rPbOcQcpnXnAPwRWDcaqV/XsXiSLqT8sW/gJBn2MBusIcPY/1fDerM/UNGqy6FPutS9Ir1TB2skI1op9KpWNyj0ZHsWLuMF30Z+2twxqb+ZZU0kCoN4FYZRvRJQyVmZLAw3nofCy3Ivbh+yWyZyCDryuuCSiIRb4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WeQcyO5BSxSGP5fEcDCG47bFmDbImgzz+MpzhSzBhFs=;
 b=PVN05kUGUIM9XyZGCGg+5yVtsbz0X2e3hgEFNTMWpmXGr+qvw8UcTM+BK4OPQuDm3iZSig7Zxbw0ThKkUK/ZuFTe21x29ApC0Obuio528+64yGgvztm1McryjgXE56r0lKGnClm580osYHWpybUBayXzdvqI/JTokZllotZAYNrv4w82OyRSbO1FSrGyFlKlSd1eA/fBHhuJjucmpUZ3CN9cwDHwjuAtO0CnyFleZrUDXd98g4ZyRow+RjnCvxN/ECb716rRkSd/zJNagsU/P2DebFTwseXuSflJe2E9wH4HXVkYlKe2rZNjTZpt5YGy0ojOleS+t1GWBlWmgZlVoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WeQcyO5BSxSGP5fEcDCG47bFmDbImgzz+MpzhSzBhFs=;
 b=ZyrkgPeTwHpgW3qYOwAYVHKDvKx2vJNw+yT/4EXPuo+Rlk8sWZmnAzZuvLIckyxDYVM/1cl6f2F4FEPlu7uH1cWGBqQSU/gTNG1JppVM6Erj10BTorma0rfM5b66P3kDjr0SrLOFuUDNmXfxcA4mppkiMuQrcz3doHuM6yr+srOXGa8x+0EbBUiMjkIOVUfki08y40cB5WVgimi4EBbW/VH58Tt9srFm19vl36FyoOjjAN7xq9NsoJWzDQ507yQSXnUGmAluCHHQd4hAoo+dYm/599jmYjhyO2PRNhUBeEIh9WUZ9WA0kCgqeXoSYJS0xplcJJ5kP1/s1eLfogB47g==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Tue, 22 Jun
 2021 17:58:45 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.018; Tue, 22 Jun 2021
 17:58:45 +0000
Date:   Tue, 22 Jun 2021 14:58:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        shiraz.saleem@intel.com, mustafa.ismail@intel.com,
        coverity-bot <keescook+coverity-bot@chromium.org>
Subject: Re: [PATCH rdma-next 1/3] RDMA/irdma: Check contents of user-space
 irdma_mem_reg_req object
Message-ID: <20210622175844.GE2371267@nvidia.com>
References: <20210622175232.439-1-tatyana.e.nikolova@intel.com>
 <20210622175232.439-2-tatyana.e.nikolova@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622175232.439-2-tatyana.e.nikolova@intel.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0361.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::6) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0361.namprd13.prod.outlook.com (2603:10b6:208:2c0::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.9 via Frontend Transport; Tue, 22 Jun 2021 17:58:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvkfc-00AbRu-35; Tue, 22 Jun 2021 14:58:44 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcf9d3b3-8ae4-48ea-c2f3-08d935a760cd
X-MS-TrafficTypeDiagnostic: BL1PR12MB5334:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5334D5C8F52C99C09DD963C2C2099@BL1PR12MB5334.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QryLRmHbIGNv1MJyhflDPfefduyXYVqtzl5Yc9fE0YJWgxajcrMAGo85J3+RckfM3/MgmzL0oVg9XX73VP30lPBuB95BaW4KIKRmPnGJagtKiUrCFjgsHfPmbGL5uKWO9A6YdGpXSBfjx5Jb9k9Tpva+Fgt9z5eYoyq2sOo14bXuQCv7hseZNlkLs2Nb1NC2fpfL+9K5ewetSK00jLilNZ7Gb6HCB38n0Rcj66rvugpwJ9Wh/OLwWNsTL2MEInzDSoOV0KY/0IXyB7+R9EzSMj6R3GWtUmEIl/DgQlyo+1XajRdrK7C5gAU9wegygH9D5IiEGxUnciB/T7WksXuJppT3B87jxeowV0BCq30M+eSFyslOLTrwkJvtN5p3XifNtCZfPNsnhVRD1YtOSVlC/lfHxc0K/0YvqxvgdLAM8ZbGdW6FVWbkJRFUloWpob33gIAs1shCbOrWnQh+tFbnsLAuQvBSF9aPhHepdfbHx6DlIvN/tnFaaVls/N5Ykm3L11pJHTB4zq3kOvUJDi2p8PZgjeQv7o9wqaJdIt2VwdYasKh0dlwFo+PYHTvWNwXdM27yuhM1SsZcNehPBJJ+/OPCOXFoTnw2YVW5wLeBVKc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(2906002)(5660300002)(33656002)(8676002)(36756003)(4326008)(6916009)(26005)(83380400001)(8936002)(9746002)(186003)(86362001)(38100700002)(1076003)(316002)(426003)(9786002)(66476007)(66556008)(478600001)(66946007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0BjRe6Zm74gT5OZ/UQWGviOfNZmU07o8f7yS5N950RQCXfPqEiYOhyAtioMj?=
 =?us-ascii?Q?lWh/1PcCygaXib20HbrybZ64BoMZhgM6QRRj2Oe7jbyurLdjEEXO8iGHeB6H?=
 =?us-ascii?Q?ts7qIBGI37ZKhFOZ/VQr+TZ8MQ0e0zTJf7JN8gdlm4M6/dzMiszYWl18RoFL?=
 =?us-ascii?Q?cRz3jyJLZaihx5/DiMcAufMMlrQUJ0MFT3wRWf/fh1xNTy09+j816eG5JT+L?=
 =?us-ascii?Q?rSkY92nujCDfwT3zEQIL+WosE6CcW9dCWTFHr/FCBiQWb3o1D5BWJVKpcBR6?=
 =?us-ascii?Q?S4z7pcJR03lsW6BuwUzbvS3dkxDSjj9p0klVXZ9pKDEfbcr3abYwjV36ynaf?=
 =?us-ascii?Q?hQi+4pT33XBWGRRpZ8Lply3Tasim4sWk5KUW/pxjSzBUhBcl+bjgol00anWF?=
 =?us-ascii?Q?qn+YBaMiepJagC/nGDIbd2Uv2aNCimrNRcp/kz6M+6p7TajyUyMoLv+Rgct3?=
 =?us-ascii?Q?1iPPYjYM8k24t/XY90UrQwXaq9f6/8SrgDME8fwD7v4OUgy/kCOMdkfrrZS6?=
 =?us-ascii?Q?UTqL1s1n3rZoo4540ueZkacsTr07M4r84KDybghWz8tgifom/PhIHI9mwlJi?=
 =?us-ascii?Q?fJkRL965+FkY251BeKSHnb7nhZvwk3e/pFBuCL/deDhj25eFSC4tUOC/KCz/?=
 =?us-ascii?Q?2P00T8oiLe8W7wdwbys9Bzb1la5w4NgpTbyVGOX3SwDMOBynm8v3AuxXrGoq?=
 =?us-ascii?Q?grswdMnwH2pRBWhsfGusOw7lFRuSnxt0HYcEccWHiXdazZTWQgdX7f0GsOnD?=
 =?us-ascii?Q?0Jpbj01oN1BMHeTkwK8Db61ZHALsZf1AGtsFg7aMiYnkBPRziXkv/yzxyNrS?=
 =?us-ascii?Q?/UjQS1Dwy8CAu6vVH+cEX47pihBccreuwYYDIAsDfEV85TcQV3HXfarzym4T?=
 =?us-ascii?Q?efOLSrZ4P6A5YREDRhCVlkUzWgaK2nlN5aX0U3tv8F+FLkO+ccxZH5gG/0NX?=
 =?us-ascii?Q?MK/CzNr6raYL9FK/TA6PKjmkSnlpQvxsajbGJfBt0LIU1NxkuZFbra2F7UTk?=
 =?us-ascii?Q?vQza8/wdu8Jj/gZtpRDczfPHrUxrwCKfQmj4cEhnK3A6+r3RXkdE1zVTP9h3?=
 =?us-ascii?Q?DlsOTkiTTLnREvEjwYt2rC7a+roqpd6Kzn5nWtlZEfp1mwb5y46UDil6ckJt?=
 =?us-ascii?Q?eMJgJeRLyTk/vbaXDIalkhU/af6yfpGExCoYqWp/xPVeK616QbRIb82WP4m2?=
 =?us-ascii?Q?E5R/NOoCgQK6SeLPXWMtnhxi9SNe73BS3xCE7pHcy0AAa0HnWGvtklmnr3wQ?=
 =?us-ascii?Q?xnoKniQWrvlZhwlNit8cuIH6CS33AXOOkfSYabLXfAKKeooPSlW9pJWMRhMb?=
 =?us-ascii?Q?Sw+7R5aneccnHxKe845QZZ+e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf9d3b3-8ae4-48ea-c2f3-08d935a760cd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 17:58:45.0758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQ5gYYf6DWEkuTIKYR8B4Zo7wh6EOkJQlmankPlO5DcgcWTZOehQ5TW3ye6H48o1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5334
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 22, 2021 at 12:52:30PM -0500, Tatyana Nikolova wrote:
> From: Shiraz Saleem <shiraz.saleem@intel.com>
> 
> The contents of user-space req object is used in array indexing
> in irdma_handle_q_mem without checking for valid values.
> 
> Guard against bad input on each of these req object pages by
> limiting them to number of pages that make up the region.
> 
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1505160 ("TAINTED_SCALAR")
> Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
>  drivers/infiniband/hw/irdma/verbs.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> index e8b170f0d997..8bd31656a83a 100644
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -2360,10 +2360,8 @@ static int irdma_handle_q_mem(struct irdma_device *iwdev,
>  	u64 *arr = iwmr->pgaddrmem;
>  	u32 pg_size;
>  	int err = 0;
> -	int total;
>  	bool ret = true;
>  
> -	total = req->sq_pages + req->rq_pages + req->cq_pages;
>  	pg_size = iwmr->page_size;
>  	err = irdma_setup_pbles(iwdev->rf, iwmr, use_pbles);
>  	if (err)
> @@ -2381,7 +2379,7 @@ static int irdma_handle_q_mem(struct irdma_device *iwdev,
>  	switch (iwmr->type) {
>  	case IRDMA_MEMREG_TYPE_QP:
>  		hmc_p = &qpmr->sq_pbl;
> -		qpmr->shadow = (dma_addr_t)arr[total];
> +		qpmr->shadow = (dma_addr_t)arr[req->sq_pages + req->rq_pages];
>  
>  		if (use_pbles) {
>  			ret = irdma_check_mem_contiguous(arr, req->sq_pages,
> @@ -2406,7 +2404,7 @@ static int irdma_handle_q_mem(struct irdma_device *iwdev,
>  		hmc_p = &cqmr->cq_pbl;
>  
>  		if (!cqmr->split)
> -			cqmr->shadow = (dma_addr_t)arr[total];
> +			cqmr->shadow = (dma_addr_t)arr[req->cq_pages];
>  
>  		if (use_pbles)
>  			ret = irdma_check_mem_contiguous(arr, req->cq_pages,
> @@ -2748,6 +2746,7 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
>  	struct ib_umem *region;
>  	struct irdma_mem_reg_req req;
>  	u32 stag = 0;
> +	u8 shadow_pgcnt = 1;
>  	bool use_pbles = false;
>  	unsigned long flags;
>  	int err = -EINVAL;
> @@ -2795,6 +2794,10 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
>  
>  	switch (req.reg_type) {
>  	case IRDMA_MEMREG_TYPE_QP:
> +		if (req.sq_pages + req.rq_pages + shadow_pgcnt > iwmr->page_cnt) {

Math on values from userspace should use the check overflow helpers or
otherwise be designed to be overflow safe

Jason
