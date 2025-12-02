Return-Path: <linux-rdma+bounces-14863-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19939C9C92E
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Dec 2025 19:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6DB3AB172
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Dec 2025 18:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C292E2D1308;
	Tue,  2 Dec 2025 18:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PVHAcUI2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012033.outbound.protection.outlook.com [40.93.195.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2CA2C21D0;
	Tue,  2 Dec 2025 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764699225; cv=fail; b=ddnF0P6SQJcirzwrkAMbAgVRCv3LFuRUbjQUEnrDlXwpntfMltgQ650AmpC6ft8bslupap1FnotRfmCodPxU08ZEY42xMUfyckmqyy4pcCQXYpo6P/k75woRY8UNGkB/KBFLGSQZ828XZR9y0eioSUOTAJKJTMq9/Cy8yCPi1DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764699225; c=relaxed/simple;
	bh=SIYVhT9OL0DZkv43D5ZnKC4CIhKSvgu8v+rRZDl17CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hIFQogDD0gEXbx4MlRoXujWaO56PgLpegWBOTmYOA1fggwfylpTzS+Arx2+KM05gROmNDE7ThtSqTBATCXJTpycJvWYe7AhhqeMEKXwk+iOVnyx+x/sRLgv/vgdk65mFxe0vCj4qvlwVoR/J5yUU9RG0sxjnh8vyTyKXROXf37w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PVHAcUI2; arc=fail smtp.client-ip=40.93.195.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/BirEIs4m2+FKOujORrZ54hen0ZwSHNkzB4fUpRSFc0KZ3xM+zFeZujrt2vmz5ud7HsvCDQuSBNHBOtq/h9cHtPqpeMpxv1QgjDCreBA06JjN5/oljT8wGg2xr1qDM+ZShdN5BKh7E0MxjGc4Up3f2D/jG1bfd2kcdU8J/GUiw7l7bfWEL2q5ogQqTZIYeNNQXQ4DFrceFXdvashL9Fc4SfdwaxHWNySwNLG/0QL5MN3UwfrG2PRhVevmik3l2NlpxABC9ixRlovo8f/ws74YyUSKcTH4WjeSaO11GAVbi/dStCAr/IzOZuZdg92rQY4D2/fADhzeVJWnUs0LXpaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jM2mLXaWbxGVHF5vCexvuhzWM6LVQt43GL54DqI273Y=;
 b=kwfixUG4dZSqD7LjP3HScIe2g4RWahko0WSPp0p3zC4LWIDxR5rWUF3IBUjqQLpaQIbd+BNA6BhIxbp4Ow/c/ueKBHYQfepvDuMEHs5Bc8866EIq16mti0BDkHeBe89yK6pXmxKmyLK+PuVX2La2mDQT3lL6zh/bIXTqxVnJeP+wUG8UxqaGwQLVbWCUUILlVh/+yqIidC8ciEZdfdk7x47RLIhuZyTzwuwf2p/X7mfS98vssuBssDloTat1+Q6yAaCFLmwr0dSmWPoIwK/RXxJBetsT+jPA8JkhaMm5IxiD6VoUoaC5VhRvcEjIwur5zHrM8j9uSW21PRuBlGOu2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jM2mLXaWbxGVHF5vCexvuhzWM6LVQt43GL54DqI273Y=;
 b=PVHAcUI2Li+S/fp9L33N8WszSjxVQxWLufauZp8KLnHtKd7r7vkEqNqc1bB5hH1oSiTk5j9s+XEAF9Cb+oSsH6r3IahnOgJYZ6AU62NjcilSDDdXnuVlceD6pFf/KstW9+RpXdTH3sBf0O1uPBYim/MtF5DXQzCyQiA7CFQsbi6cpvPQaQcN10t7YVvC8E+TEnbOF3397DYJ/GvRAyh5r+oKsjukC93+YAtYjCCM7xoQKJbSD9tSnWWxsDHcxw15ywjqbFU/1MYEYQwwfGH4Yn50+Nr6AFICb9MtoJtfsPNGqixAsgBYh1qN4RkwqmPrgx1wtmxp2iS9qs+jGqJtaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 18:13:38 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 18:13:38 +0000
Date: Tue, 2 Dec 2025 14:13:34 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <20251202181334.GA1162842@nvidia.com>
References: <aRKu5lNV04Sq82IG@kspp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRKu5lNV04Sq82IG@kspp>
X-ClientProxiedBy: BL1PR13CA0070.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::15) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: 639b9d00-1533-42b8-6858-08de31ce8202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wLmVXvKHB/AnUuIW2k39am+V70ieJtTmuo4JtWK1l88sh5zZSRG9RZ8Lm5Nm?=
 =?us-ascii?Q?Q6RfiJai+2Hxob7uBs3PRBkNfqC1bvUxp5qH758HtM7yL3AumGZdr9wamVNt?=
 =?us-ascii?Q?1hGOnAl4sezKGU9WktjlZ3x3RJLQCtasEUvdgqj0wib5iOt0WpGJYpo61GBe?=
 =?us-ascii?Q?tmYg2yKHXAFk7jZnFIcrbGxslMZMCbfJ89k/j43JCJqdneskVpVRQU/J2tcw?=
 =?us-ascii?Q?YwW+PDqZPfMk6sPH3n2adbraUDUqJxQHVMOrwJebuU0911Y8qsSBBwm5Val7?=
 =?us-ascii?Q?D3DOZ9M6pRjV0tqyZseEuDUkAWMJTKVS1ZD89z8JhM6LgaRAU0D7nbtATN6J?=
 =?us-ascii?Q?hBAFwfkklQeq9yQj3cBynjO2BQcNtXTxvSHbRfrRylaEGbCMxf2ADCbe3PSG?=
 =?us-ascii?Q?lL+lsa9AV6zduKOpcFCTh2FpZRtlxNHV33Gr24GqjnBCxIk8cOcl9o0xXinQ?=
 =?us-ascii?Q?1c7ErSiE7OqawJwviYXk6wzkM61/IEjGGgoKR3c1Suc4GqA8MfukGxVd3A7i?=
 =?us-ascii?Q?XbR631wJ/YXc382CTXHWKh66Ty+a3DcWsZf3wu5WhgkbWoDjnzmxq4Lx4rFE?=
 =?us-ascii?Q?93uj/hcNqI2HMWawICMG1aJvVh1TqdJqYTmpq9eV+XaDzhvNbGtf1D18oufz?=
 =?us-ascii?Q?VFzXUp63AHk+xTM82rTKJejke/zBIT8TmybokvCLoIzm3x1UGBFajY/V47H8?=
 =?us-ascii?Q?+qpP5dL9msLJ/u3zZT4AzFlCv7pCgL+TzlxbNeoSX3RFeGDsmhEXNw9QTd4P?=
 =?us-ascii?Q?t6skSM3ifklsSuRPd8WJoTynBOEgQQ5+NMbyO49E3rQmXvgKvqGF7WwdbC47?=
 =?us-ascii?Q?9VJEt2PuUqVIHe4veTH5GoGaML4+FXcr64PWrF9scYpsS0KTm8+hgvsCva2d?=
 =?us-ascii?Q?pHVzXtN1pzHAVP18Kl07aYGZ5egbBFmuKbUIMOeWTkDhtnEdvVN4/kFGWLvC?=
 =?us-ascii?Q?NJPQ8SNlPuxlVTt3tWyRa47N/Um3RbqXyLcflLrfLTT0t9mH9Yv0oaKJAKJQ?=
 =?us-ascii?Q?2WNoum5rBYE7GvQUGMjh7JymSzu7Z9yd48jm0LkaNup5S0W6v/szOq1F7k5b?=
 =?us-ascii?Q?e2E3bmrBIi+5uQwlNaY/x4vB7qiSRlyiTRQqIxaZRzznhw9AeSQemROYsoCs?=
 =?us-ascii?Q?cTgoYFQqm1Ehj3FYgiGWM2FxGdDjzSwsXP38UFgJ65Hpo9ns6k3B5qVbRrWQ?=
 =?us-ascii?Q?1ueTXHweNCZh+NktTx2JycWXuQfl4fiNaL1/dNhTOO+23Zhxl9/TLi3fnmXj?=
 =?us-ascii?Q?6rG519BIi8od8A4yC+JVIwi3HjExnAkHvAWsg0GiBB5olrtTAFvwDyoP6lVk?=
 =?us-ascii?Q?/WbyH/uRm88HnJuhQXE+k5e1J6D9ts9O8mEwWttELBitOeqvMAzhpupuz6v7?=
 =?us-ascii?Q?WOd55X5s4FjtCub6zNHP2LrSgAtVczCM9GPt6iwrPiLdlSaT2l974HqEPMym?=
 =?us-ascii?Q?4WQWFiU9Y/HroILm362uebE1WsSujCJl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EKWuIiK9jFwEML4KWLaTa3EwjuBcjRO4S1nepzsX27Id3c/iLlTFniBl0sy7?=
 =?us-ascii?Q?pFubHxDbhLFZYD9fpmeyRwDSyPqzrJkf+Gb40xtTxLOxtML3bleBoL36Dli5?=
 =?us-ascii?Q?xT9/wGXFQI7yE/Qm23RMkOn0B+zb799n/2E3DxOGA+ytFeYN4joGSWqTsTzG?=
 =?us-ascii?Q?UbShKtDj3Bo2JRXzRD3Equc0ZStoJ56UZzAz0QbSrLMUqSTIVNMjYlP6JDRE?=
 =?us-ascii?Q?+SmJqnHQWGymomE6w0ukC8wTKeGHstupkGszpZa1+B6Y1IbYPNwr3Mq+8mkX?=
 =?us-ascii?Q?oxVCXDX50HZimI+oDZyXQyYxgTeLAJWxYRUBTlhfx71UTlft+ZZujZAP0hf0?=
 =?us-ascii?Q?SM+wnepcLWVJEWYJmuyW1F15eJEV7JTTu/KRVKlvnUmBSljwpUHUnF+na/Fn?=
 =?us-ascii?Q?J09C5XAEPOnpE/er7qrH9fSa0qSKSCa6XOUxYCAgzJYLu5aiivVG+BFWu0KH?=
 =?us-ascii?Q?jtEV9D7BnA7p73pmzTP06B8ClIeGTYCu0sdj0dL4xejBUwghLhraS3vYx7Ac?=
 =?us-ascii?Q?GixSeFLmGqDblQuoKBFu8Fh/EtztdAc2IV8rXgTx2tuDeDn8CUSZrGFp71w/?=
 =?us-ascii?Q?9BxBGn8uPB/vrKNSSuywGTROW8l3Bqru4rm0DLxHs72Ae3iu1Fj1DNOhWBFk?=
 =?us-ascii?Q?i/RM7ODtOwBrQbmhzO3XYrowUyhcEJEL9gtXF5kJUhEqju3bT1jyE5Hhvl+2?=
 =?us-ascii?Q?yXLmldEqEH073IlNp0C8gWwSVO4k53K0bpA+mjl3oYirvccvv+NVlMWPh/8O?=
 =?us-ascii?Q?vvzTvTdjMfcFhpcgOb8XbXe/V1K2ichoQBx+LsBHX8+uPjy1Wrj9EnkWfNvP?=
 =?us-ascii?Q?bjd4LjXyNscGeMPTQSlpOMHGthd9OHV2/kTdGquw5v3yZrDz4oUOsmCBpx03?=
 =?us-ascii?Q?V3NQJcAjJET3UpHpxu7BfhujVtpYw7hjeEc/N6veWPRIwjoPnjlXyKHjPOvd?=
 =?us-ascii?Q?loUVofy7ZPWA2MBvAfQXjszp+RRmMzu4v3KoC5jgeAc1U4WKRQWaHFaiYFPK?=
 =?us-ascii?Q?UO60Z2UvuNZRupJG8x44d+nEe9T//J5NfxOAnZBQNeZf7WeesHmQ32UEd7EM?=
 =?us-ascii?Q?aIQoXeulz3r4bdooZifBHFv3HlRwcE6FHfONxaQqX3t3fQXlQ6A9AJWZ9Dgm?=
 =?us-ascii?Q?c+ivhyBxuBUJI3rUthVmHdEsdkI1N5l7RINi7ihTs73bpnLbtclAoVomSrbJ?=
 =?us-ascii?Q?B8D6Bgl3mcwh4aYaXnAb0KrzHECyI4tTxzwIUwDFRWlxXvfRgZEO/bxWLIOB?=
 =?us-ascii?Q?S1zPnE7CnA6MFOeVrbIrUlYHjbHCX8avUa79LrW6hd/VdvsGeEeanL7Xr8d1?=
 =?us-ascii?Q?ov10okYdTeDvclQExngP07sC4b/50yY41mTAj4PG8ESLGflGGxJht0plAAlU?=
 =?us-ascii?Q?NORBmwb0fjdO4qvG7I2DNW9fsPzefBiHkJLkcpJ0IhTnMqZRvqJjkZaM5JuK?=
 =?us-ascii?Q?xEJs67dwNZWIy1a2b/MPkgupKlpmLlANZPnroPHrVLteXVIGFWxDflI0DVSw?=
 =?us-ascii?Q?65SbmL9penMpRFYWWteUQDJSgXKUvhBmTIR0iSeqkUNV1nohlRnqXIkUSz9s?=
 =?us-ascii?Q?ePDr0G8GCVgsRaaFIH8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639b9d00-1533-42b8-6858-08de31ce8202
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 18:13:38.4832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODpYLZF1evGvnK4epDeOpywhJ+r9dMsuj5PN4PN2d1aLZ3rgziZbM+JrloyqgDzV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426

On Tue, Nov 11, 2025 at 12:35:02PM +0900, Gustavo A. R. Silva wrote:
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index fd48075810dd..6498d61e8956 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -219,12 +219,6 @@ struct rxe_resp_info {
>  	u32			rkey;
>  	u32			length;
>  
> -	/* SRQ only */
> -	struct {
> -		struct rxe_recv_wqe	wqe;
> -		struct ib_sge		sge[RXE_MAX_SGE];
> -	} srq_wqe;

I think this existing is just a mess, can we fix it properly?

What this code wants to do is to have rxe_resp_info allocate a
rxe_recv_wqe and have a maximum size of its flex array pre-allocated.

Probably like this, though maybe we need a FLEX version of the
INIT_RDMA_OBJ_SIZE macro to make it safer.

Zhu, this seems like a good thing for you to look at?

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 38d8c408320f11..189eaa59a5fb14 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1524,7 +1524,8 @@ static const struct ib_device_ops rxe_dev_ops = {
 	INIT_RDMA_OBJ_SIZE(ib_ah, rxe_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, rxe_cq, ibcq),
 	INIT_RDMA_OBJ_SIZE(ib_pd, rxe_pd, ibpd),
-	INIT_RDMA_OBJ_SIZE(ib_qp, rxe_qp, ibqp),
+	/* For resp.srq_wqe.dma.sge */
+	INIT_RDMA_OBJ_SIZE(ib_qp, rxe_qp, ibqp) + RXE_MAX_SGE*sizeof(struct ib_sge),
 	INIT_RDMA_OBJ_SIZE(ib_srq, rxe_srq, ibsrq),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, rxe_ucontext, ibuc),
 	INIT_RDMA_OBJ_SIZE(ib_mw, rxe_mw, ibmw),
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index fd48075810dd10..dda741ec3ac701 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -219,12 +219,6 @@ struct rxe_resp_info {
 	u32			rkey;
 	u32			length;
 
-	/* SRQ only */
-	struct {
-		struct rxe_recv_wqe	wqe;
-		struct ib_sge		sge[RXE_MAX_SGE];
-	} srq_wqe;
-
 	/* Responder resources. It's a circular list where the oldest
 	 * resource is dropped first.
 	 */
@@ -232,6 +226,9 @@ struct rxe_resp_info {
 	unsigned int		res_head;
 	unsigned int		res_tail;
 	struct resp_res		*res;
+
+	/* SRQ only. srq_wqe.dma.sge is a flex array */
+	struct rxe_recv_wqe srq_wqe;
 };
 
 struct rxe_qp {
@@ -269,7 +266,6 @@ struct rxe_qp {
 
 	struct rxe_req_info	req;
 	struct rxe_comp_info	comp;
-	struct rxe_resp_info	resp;
 
 	atomic_t		ssn;
 	atomic_t		skb_out;
@@ -289,6 +285,7 @@ struct rxe_qp {
 	spinlock_t		state_lock; /* guard requester and completer */
 
 	struct execute_work	cleanup_work;
+	struct rxe_resp_info	resp;
 };
 
 enum {

