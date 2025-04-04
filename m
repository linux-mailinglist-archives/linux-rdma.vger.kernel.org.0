Return-Path: <linux-rdma+bounces-9151-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480BDA7BDCC
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Apr 2025 15:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EC4B7A782C
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Apr 2025 13:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CFE1F4CBE;
	Fri,  4 Apr 2025 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZGSxLs+k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A061F4633
	for <linux-rdma@vger.kernel.org>; Fri,  4 Apr 2025 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743773284; cv=fail; b=YFXdyltTZhqEiUbHPTo/Ueb919GC/hZzVUbOSIjuXpFUjwsSrzBCpMCwnIwhQnaO9u1RdjoBa4nDOVkL1TXHQttJfAPc1Pc/BAn8b++ZUiO46l5bW0EZ8SeTzHzczJT6vwT4CNd9/4HpInfo8Kp/OfgXZMmSQpLPKpJHemYlCSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743773284; c=relaxed/simple;
	bh=B005lsqbGTyNRHIL/+Dqy8Uyx2MFZPBVRO0cqwpybWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KUC8GPTpGBrl/Zf/TWCUGc1NsuC2qKlIXX7gkF9repkdPlBIduRvP0q9axqzUj/9gbOPmiQ+FdyA1zI8nphdrvfkrB5tmq3PhCEOaEd2JCmOPLV6IbKKGBvuLRsap+Nwoud+KzlI1beNa/sYOUP+54Mhy9OEF7GkaoVApSEx/jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZGSxLs+k; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buK/lkeGDqOEYWWgJBxBR2JJztqDvmT2v7xumc0/IalbJRHX8/QSkPt0DkucbBjigJhvBixt6Vr+9Q5z7X9VFFYI71gVFvn0V1i7YieM0YnT9x3l1EhScMyWr61/iJBSFy3Cmv9dXL1R4GtAtOUUej8MNnaOsRLTcpOhSeonFOoe2B1BNiejI6pxZThQRUsMtuCWq5rfD4BKYiPPcL64lvKwezS7+bb+xzIBBIDtl8dx1vZTphsYng/LDkigS7TF+2nUBCNTINCGo9R3L7qChETSvaIa1S3NdOeG9H3DMVfHR3zV4Ggu+IAC3Vj3v28wjzkGulNp9RfXmE5olpeGUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHTfC0UKNBWGcPN+Ku6RmWGVs9btG5Dg/YH5RUybvRU=;
 b=iRiXRN3fKgmHgu//R/4cSL+b6E6FuTGMeNxCtQnoESnqMK9HL5GIel08IKmWthljxoixHUi2zewXVtLLsnPHgdYjglFCo+q9H8lMQOvaLV2cb6kyPPUOS7cOOQwZmlqBLtYNOWjkQu0IPa6ftMiJW5Gcs2XF4PovGVSjDC32H50CiRcdMQU91H5B6t4K9GP1hgsSTeR6Dxx+fMMJyIwHIkpTA14uGoKj2oKNaYNnRVeAlDzuKyF2TP6PQXeZAY2X4fGynoAP4HNNOe6TlWRqSt0pAgPGyanbvkIp5pN41yVxJ7IlEhK42fHU874WTYEUkQ5xrPLZHL3u7Ny7R+LL6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHTfC0UKNBWGcPN+Ku6RmWGVs9btG5Dg/YH5RUybvRU=;
 b=ZGSxLs+k72vOKLHUYMs4SVG/PM1m+6r5mco5upIpzX6hipzQvQmAEWOim3tsOlTHmDVRhIq//1zsTEI0pqixtYXgmo1n0B5URlwsje0lgDUxWv0jcmKfqv5pcRbFTQd0KOBbwpkRjmlBKfJV0c5daBzuSQRaPhbmzhAaGffsVOpknen3u1UsjVl5jeSQHTntZ+W3OetUChRfH1gJQ1nb7EtLyn7/QyYMHQK/ZYi8sSQ+sOeI97Kgwvs2Nld/dLYSYGNuOPdweBNXSWli4cIdb4dJmlYLgQ+VbCNK2e39XPfHTH+g+4SPWFC3JAMp/IXs42B5rJLwyOu/hf6f4vjgNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB6417.namprd12.prod.outlook.com (2603:10b6:510:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 4 Apr
 2025 13:27:59 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.043; Fri, 4 Apr 2025
 13:27:58 +0000
Date: Fri, 4 Apr 2025 10:27:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	tangchengchang@huawei.com
Subject: Re: [PATCH for-next 2/2] RDMA/hns: Fix wrong maximum DMA segment size
Message-ID: <20250404132757.GA1336818@nvidia.com>
References: <20250327114724.3454268-1-huangjunxian6@hisilicon.com>
 <20250327114724.3454268-3-huangjunxian6@hisilicon.com>
 <20250401163926.GA325474@nvidia.com>
 <bd0c0fa5-7579-8767-8c18-73fd5459de10@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd0c0fa5-7579-8767-8c18-73fd5459de10@hisilicon.com>
X-ClientProxiedBy: MN2PR15CA0049.namprd15.prod.outlook.com
 (2603:10b6:208:237::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: e447b122-0db6-436a-fd78-08dd737c83f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9kBUnzRWh87OdyqAfipmhyswzpLwITonqctutcCN9Yx2V5grwOVZjAdWYVgf?=
 =?us-ascii?Q?rKGRkIAvl3DNPQmGeAvbvbocrd3aJu6YzMGba64ZBl6ck83PSqfR0qrb+6RN?=
 =?us-ascii?Q?eTRceilWRdWs0C31SALtTewkclnXfmDOxR6sfnqiUGtfMpoNjS+gBV2XaFeM?=
 =?us-ascii?Q?MgOGnYuf4k8Uh/Tc+tyEOdKdvvM/ld5Gj7yBeAID2VfE9kAs//9ukqs5bspG?=
 =?us-ascii?Q?njjroZifL68sGevBoqInGovP+KmX4xfnvkX704uLBJLJDTfHLRd9y52XtAqx?=
 =?us-ascii?Q?+5OO0DtKEx+WRu8UTk7iKL/TGN1PArhuxOIDtpbj7qXe+DRP3lzpFwEdpoVv?=
 =?us-ascii?Q?Y7c93jF1L8rcxyp8MYIl6aR9bHLJTWXasidID3o1V9t7JtxylXzVgHeiQlK9?=
 =?us-ascii?Q?sdiY3D4pbIHSFdh5j+SrWnm9KQmbzK18i9cMK9O1zQ+O+0QGVr331NzEFoWI?=
 =?us-ascii?Q?9Q3jG2yKcLShwhEAJIRTXgInv7ItcgREAA44p0QxXsKDXywSwOJIEnc5N71o?=
 =?us-ascii?Q?KfkcWNFHtMFXqfRerJuXNCBcSYxzcgQ9jBVXWtkcQxJA2heYkvSTTdiBX7YG?=
 =?us-ascii?Q?RrhrOqEhIhudZbgvDy9QeWN3dRdIbjqs1TI8a00jcz5SaPbatU9NlyFCjTlf?=
 =?us-ascii?Q?r5xQwm8f28Zu1ebXqvmIqS9B/QPm5RDSArAZA2+zobWQdgiGso/ezy/h+oeh?=
 =?us-ascii?Q?6nhb1EWCyb7swAL/a+IiV27YOXVRnhCwESkvfjZ8JEj93NtB6CvRdt6H6cQM?=
 =?us-ascii?Q?1ZJRcMMwhZzYFqhmBgRg0lqLazVXsU8Jdbelr1Mk9w4yo1CtJMfN8M2vnm3f?=
 =?us-ascii?Q?kkDn19+NuE0KmClhNZKnJco4E50izz8eDz25B3Q13d+ou7vzCxkJwCNmtQ8A?=
 =?us-ascii?Q?nw5hB0w2qicUXfbvMpafNRFw2JCk7RvSmYmsbvQU/twTKPiCYCWa6uNPq4Rp?=
 =?us-ascii?Q?8MGqe1l6SOkHD5Moi79LEVLfqcMfa7pOcjb2Hfg+EHck07VKH+nhiT9C/WYZ?=
 =?us-ascii?Q?L1U5dm8QFpN/WN2eVDSlgGZkDyyufS11zKr1h6VS9foeYldjBPIgGDZ59cGK?=
 =?us-ascii?Q?u4CuVnYOjinEK7im420WKHAMd/pDGPAnd27yyeObmT5GsZpCCgmz6ye5yidd?=
 =?us-ascii?Q?JwYgRMGf0oHz+DGdEpOgzTOpBDeKRQQt3ZaE0sWdnxxMJlfq2BEive307ADS?=
 =?us-ascii?Q?0jRf8+Z6F2PjbP7zb/VqePP+bgA00w2OEbLdKcVw3GGckH+tWmbDc8fVzJVA?=
 =?us-ascii?Q?Lfruxt5Ij1uWyc46kXbW6rQS6IWcxxVDAPMJqe1rEkKD/TF3zuxJLqt5Xbn7?=
 =?us-ascii?Q?oTcq5GBuq9YVSuOYhRQI1ndpqKP7hBZL61G21gta3xqJX1gheSwizgDInXCC?=
 =?us-ascii?Q?KYF4uRqqXlm7XftAoCndVG54aUvQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FnRj9X0OdvEmEzTnIoFNegwbuxLCrAS90WZ4Sx/cE+fy99fAqvFw4ZI+tVu4?=
 =?us-ascii?Q?2bH9slGqFs7QzHN8wD0BJGd2oh0A9mAKE46qb8z1RYUoBRsUAqwtBwUgeoCg?=
 =?us-ascii?Q?IHYlMZVNtiW3O7uUILBWq6KWHjomr8AqN8XXbCbMRlzekrXW6gUavRliYWs2?=
 =?us-ascii?Q?pz/ivHan8TeoMRS0PE9seA+6ARQ+cruhIgkiwDJULUIZth+wio0SwVsRYIsH?=
 =?us-ascii?Q?CJF1uAd7IXiF+PBpkYa/sgSlKbb9rqfu+99xLXJE38QcAt0Yt63D463OAWga?=
 =?us-ascii?Q?qvnAk76fTHQ43GxypstlNXKf9AXoe28Sa/tc8WtZvQK6+xtjoal3fnfHAXVb?=
 =?us-ascii?Q?kOOo1oR1yAT+pcjLXx+NaDdoJ9lBi05HJP4wsoi/TBsTIYP8KwBdWgNMB2KO?=
 =?us-ascii?Q?rgZQlST0BeDoyAOcEA3xY7/lEnzsknT6NlDbS83n4LuLnLmpZ49GB3OcaL40?=
 =?us-ascii?Q?+QR3EQ2WwdMnDTLpXhGa5OJ+fEJZguK+5bhUASfeg6dqm6kUVcMkiELWsDZT?=
 =?us-ascii?Q?IEj9OMuFPZ102pLHNYDzLx3RlZ1bkR76H5OHXbgGXBNuidakjx5FR6Z6SpCU?=
 =?us-ascii?Q?6LWEPT3PIQR9bTkMwoTO0mWVnHt36RL5cao61DOHUU69M5EZ9OeKOwhRvyzG?=
 =?us-ascii?Q?2E32P/lhZYrF+qIAw5e98lAztbhTFq4MK3jglD/zSLJgtU/GNkY5rZ6nEcpg?=
 =?us-ascii?Q?3bg9YFb1CkqCIBfZs1EOrOqm6DOKf+kpYMX1OCf5WtSrb2p8Is90ot+1fRmx?=
 =?us-ascii?Q?gQR0ymxmzXjofHtAwU4t1gUzCYXWzaMt+FJSNEwGPRbH9G4gIs96m9h0R87z?=
 =?us-ascii?Q?85Ihq1+68+sn6bMC16M+mXWlIPj6yzlzpi32gPmxQ+gVC+eMaD2AVA7iJ3UZ?=
 =?us-ascii?Q?d+lVp+/3Wg3DYdoVAUtjfZe2c64HbT3R02N4WqafGq1z6RetfiwKjyvU5vNI?=
 =?us-ascii?Q?f9HBiZfDfx+AyjSPx1Z4PuUEhHd/s3INORcgPlO2nEdcuYK7NQNm5BlV45Z5?=
 =?us-ascii?Q?09aEYa5ZRiVjRXADDqWIo5JTU/8nIHxTj8GoiUQCRPTQhXI9sDpBru29dmqe?=
 =?us-ascii?Q?IYMc9zqMBj80Z3jXLEqRuaNOHgAaKBW2KgV1eCMzAKKLffqeR7DUpDX8j4pn?=
 =?us-ascii?Q?ZNosi7bbtWKZU6qzrQIkTQVgnAQlKBLAZhcfxF9/JPDhv0oWEcUcDtXbhlps?=
 =?us-ascii?Q?JlrSZhHJTEIrK5uuy9i+GzL9bEZ/YKQ3V3bf38kKnHlF8LUtir6K5N8VGApZ?=
 =?us-ascii?Q?JgQBm9YBZNLacMk/2phi1vQHNfHAHpYJ7Sbnwlw/QK/lUgzxuOD7r4g6X4aC?=
 =?us-ascii?Q?8v8b52ZowneekVvPEGlQoEs9nVzbPq0L0WOHQXY4IBqTveycPkOi7ACwCxmi?=
 =?us-ascii?Q?y8LZ/ISfCHLIDP9IHUQgVTDIQOsRrHQlJ4BCtn5kERdorze/a5uaI1/wlq/0?=
 =?us-ascii?Q?Jddrjcp3HY69/qEBeL3ULlOnUtd0JY+tUVbkYhERa+N4LB92bPDH3YnhlpmJ?=
 =?us-ascii?Q?9wMLJwDMwS42QQsy2rr1+4A72Qf3R8IATSpaPRdoOw2OJEcIw5LZItfphBDE?=
 =?us-ascii?Q?U+o2tY+Z0VORR89nzAWqkBaJUK/9VtVYEJjPU+tw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e447b122-0db6-436a-fd78-08dd737c83f9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 13:27:58.5573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whwrYd5Rwo5EbmIavWNVUKueoeeiNuHsJBqAQlqKscKNRCQ1UszviLOTGa39aDWV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6417

On Wed, Apr 02, 2025 at 12:05:36PM +0800, Junxian Huang wrote:
> 
> 
> On 2025/4/2 0:39, Jason Gunthorpe wrote:
> > On Thu, Mar 27, 2025 at 07:47:24PM +0800, Junxian Huang wrote:
> >> @@ -763,7 +763,7 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
> >>  		if (ret)
> >>  			return ret;
> >>  	}
> >> -	dma_set_max_seg_size(dev, UINT_MAX);
> >> +	dma_set_max_seg_size(dev, SZ_2G);
> > 
> > Are you sure? What do you think this does in the RDMA stack?
> > 
> 
> This is the maximum DMA segment size when mapping ULP's scatter/gather
> list to DMA address, right?

Yes, but only for ib_sge

But I think there are other possible problems if your HW cannot
implement the full ib_sge :\

Jason

