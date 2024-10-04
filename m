Return-Path: <linux-rdma+bounces-5236-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB5F9910B5
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 22:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E521B25EDF
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 20:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585FC1DE2A7;
	Fri,  4 Oct 2024 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GQjOSMPr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9931D95A1
	for <linux-rdma@vger.kernel.org>; Fri,  4 Oct 2024 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070059; cv=fail; b=HFyewa5aKi9+j/kvPT8qzD3l2nD7QV7Oz48YqvEIJ4CP9FV+nXdy6b00glYTkjgmOnA4jIUGzNp2/9oD7X3xIoYLr1pbOftfMgy94cyIRK+x0wbR/UhubVd5CE9taF1ywG7xI8V6y6kP+H4S+shjSYLJEhy1L4yTOnOd6BYUJ4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070059; c=relaxed/simple;
	bh=i61vPnGe3KrG4aUPfOF2YmocsyVE8Pcc2NzNlfUo6LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qj8VW3sXBntjAvuuAHSgyBPyh4E/zy/fKL7qxr1YTHAyMxwLiYy9e9ChO09DShgIpJaXPaX2Azy9nzpEcmlJHd8nbyhKY9Iz8HnP3WjDiPOx8Tfflxd5XuQ0INvy/V8hJzJkLfo48vNiF6QDv3Pl/Et03200goO935A7QroZtXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GQjOSMPr; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIj+Fyf6dRAgMDUAWPTr6o9TtJJQBjsdfAlq28q/BVwRZJl309EcL7o9nrJXnw/NPKvTKgERZ97ftFCWBpeICezS4W+WvCzamHqIt0YA3MaYVia491QJBcLggsW2X39wF41webIBNwetrB3fEXtBj/7ZwfHoDUdO9cRSc6jZM8OG/t8ohUkAZi9GatjRB1WlX3X9zREz7cSmv+HQnv5sH+ZxpPS5QRoMtgpjY+Bw9/w/hrTBk1NTB5R5/y2cu+6neIQwr60j1Bg/hQngSxS/E/WDI0dV7ya6xdH6yj9GZnmAQSMAtmp0GBxb+T14xqI/BfgGI/OKjUV6WTyVMAM42Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMK3SanfV4Ru4ldeUyKO3AkJjlkp11XOJaDHr8qdxnk=;
 b=TyRUyKWDY7fbmuEIKOr3LP+DILgaUSO3SyThv2UtrLx1hdiA11O70D/FHxDty8uODSfZ/0lnnEmgFFJI36A1rnqTSvLnYyGp+GBWzizX/wZ5OOh//hrKGqzMLXzR1RW7nIK4fKlb8+SrQCc5O84ZJZEhgAiDjXU6NrGGkWV21sOR/SrXX2Wh0Sq1GFNnCJN9QFERJsWrZxlxix+LhlfArTDHkuDrSD4eDBGfpUyPN/bkMyymFQYCQpb64VaDG8hRbeqiIdb1Ceq/YoiFAf/iEbj5fZlNs7tcZuWUnW/TcqCmg56rQr9kzc6APcZ7sy8o3PwWS/syfWa2sbzag1V4vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMK3SanfV4Ru4ldeUyKO3AkJjlkp11XOJaDHr8qdxnk=;
 b=GQjOSMProSw2Tded7AwgPOHGJsUGfd2JUrHrDJl1RrE7jNdOOSe+EAV+GUJwsA9M+9rI7lD/9fIMNpg9pUGHwtqzosJFJmlq9tXuuC1qHq2SaCdlrMtuZr46dms57rZQLhW4xTBGn53ieJGjAOJlGrTkWHD6ZriQnZ7+/xwYiXksHnyOa+EH7uad0X+d1pM0AiWQbNrpD990w74QWUspEU3erU9JI3A9/y+R/EbFD6Tya7MzoGy+QPgE7MJMOGjYz30AlTYxAN5azYiiIik+Zl3nIsJT5bQcgjCEXVPz6rYuC/UqKzRMd6+c5Ufw8NeXCtup6IxV4qu07tPiUqiQkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB8329.namprd12.prod.outlook.com (2603:10b6:610:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 19:27:31 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 19:27:31 +0000
Date: Fri, 4 Oct 2024 16:27:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH v2 for-rc 5/6] RDMA/bnxt_re: synchronize the qp-handle
 table array
Message-ID: <20241004192730.GA3284463@nvidia.com>
References: <1726715161-18941-1-git-send-email-selvin.xavier@broadcom.com>
 <1726715161-18941-6-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1726715161-18941-6-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: BN9PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:408:fd::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c5e99db-dd29-4315-1b6c-08dce4aa975b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3HbteIiwC0dCjQiK2vnK8tyofRqa4VrioYe84/JfMCYNpu8y8uGl56oOgsSs?=
 =?us-ascii?Q?hEsVvdTN2RY/MtNEA6Tqtb8t1WDRSROxrCsXuHXRiXZ1Wt1ADftIgg/BYtjv?=
 =?us-ascii?Q?A6pDFjYbu8VbRha15hixTQKTGXsKgYzdIic9QXdBiAQtzlI12gGGPjz1PuAo?=
 =?us-ascii?Q?xs0/IOAxaAd2fECEoQWne2wH1HtvRo/DUanh8iBnRjubMAE31dJq6Q4XyZqe?=
 =?us-ascii?Q?TxksoTZsH5lSvZZQbVYnhC4D8582/oPQANgO5UIVCRhVPDLxxKKZVwjtyBYU?=
 =?us-ascii?Q?RX6/C9+r8dSagYCcdJHOiLX0x7TwM0hL8kBTPjheanKljTdqagd0XLxf1+n8?=
 =?us-ascii?Q?4XZpHD9pn0/stT/EyudWxPD3Dklu6QicKeHo3knPihhh3Z55LSgQbsKoa3RT?=
 =?us-ascii?Q?jTYqDnxjHpvbKybMhGL+VOPs7DhGCuyvRukrv6Cq+siuuCpBgA7zwofzmT4+?=
 =?us-ascii?Q?iqJ1PKIcUtVaEoI4Wv3Z1fNGI9kMfech3gy9u31PSl9ga9OmYILI3vkCKjZ2?=
 =?us-ascii?Q?/XsZJDDBRHesY4cUpDJxDO8XOIBop8S5yiGTQPbT+oeo/RWC76UXGUKnMEr4?=
 =?us-ascii?Q?T7udeJKPXeLLHQnfb7r2fOop34IbmqntkKCnbmzOlvXOrdCmDQLQTgeiqEGP?=
 =?us-ascii?Q?SlHGwtuZOl6eakF2s+z1Jn0RZCv7W10PmmjicKFaNWxRIL7wLBy5V5/7CsRR?=
 =?us-ascii?Q?6p8SsAzXyHc+qvMDfgDwYg4BxR+TuBpoZ+/RTpFf/txpOXTFCitCVrkUtSFI?=
 =?us-ascii?Q?RCSHdFWkSXu4vHVfBQar3thxYaIuYF9lAO1FwBsv5jD9fu7XmTU1g3ih1AQw?=
 =?us-ascii?Q?u9dwUxIjl9hBogGmADkKUqC5JvQGmX7aN0G/y7h3veSbbCHXkJDNQffQVzRO?=
 =?us-ascii?Q?gOsVR31i+Mn6hIA67zrnjSmUENXQjMh7kE/wDlJp4PQ4/wfOoAoXGVycIQ7S?=
 =?us-ascii?Q?aWFqFbkLlyYsq1ud6xAIz52LfcLyRnrAS0Lhlr3vwo5G847NfNDRmPWqgchk?=
 =?us-ascii?Q?qSqEoFYxz0qwrG7n2HyUIOzxXAYHtaI66WqnXsDendzNYtxy6Qv5peUHXMKt?=
 =?us-ascii?Q?bh/1O+xB1NBr6SFt0YZDaCTwEf7c2QYG4Maom7X/5ZSKMb+wl2V1FAv3W53Z?=
 =?us-ascii?Q?i4jnLObRrUE+e9SB5hrUC1/Uy8h3KnsxxNBX00iscEbG1iWjbV/ExuNgM45G?=
 =?us-ascii?Q?uOvRtAefa0Mku71HWiB8XmZQ3aq/Wz48kFhFZb8CMr9BQC3jIDY5lYA+9fP4?=
 =?us-ascii?Q?imwPALCE0Z44J4tpCy3XEZqML9EatNaKjHbWx7MeqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j0b0GQxCmde766rjp/pd/scno740RLM/qBHVtpMheAzs3mo0N1r7ndsDeBOz?=
 =?us-ascii?Q?+eIpImgxdGyYFfxZFysbAE9WgPinz9eMvA96O1KX3j1va1Godu8gap7Dfv49?=
 =?us-ascii?Q?TJYnudRKrylmH6vwU7qdE+1Gai+i8TerzfzaR2Ss/4OexAYEtuVv/1xlSmLG?=
 =?us-ascii?Q?K62+6zRipJ/959lCjLTC5041jarJvOjFdonKrvvU91+fOUsoe6uWnaYkk7oQ?=
 =?us-ascii?Q?i4TyQIIElSsZRtNTXbaQSDzO9xsRtojz4s7LnqsjU73A/vPDK7zjvWEzccH1?=
 =?us-ascii?Q?IhnkAKGoN2GxrdFjLV5A64QLYR9yHMTYjKv8kmK4tVwFR6sc9GyaJAZGJkNV?=
 =?us-ascii?Q?dHw5BqhrNzl5dGYgbqYPa8zQuIf6aO3xmqLiXqCxb3sytXTI2pH+65Ti2+mG?=
 =?us-ascii?Q?g3B/2ExIk0oMxModiA0oThnMjaZXoQUos6a0v7qXtZACm6Bf0v0mkDzt5VZ7?=
 =?us-ascii?Q?kqKtxo0N1A6e3+blWCJtInxVYv0mrVPI+2PBhQCbNXnEi5/3t458mvYVVHA7?=
 =?us-ascii?Q?jAXOXqdkqdsywF1jLYRen/KoVJWYH1KLw8Hbdf7vwtg2uRzF7PMzmufp7pp9?=
 =?us-ascii?Q?/dGWfylCDyYqfgt8I5tqc6hBPwm9lXhKrbPBcw7zHDCZLLchxplwyNGA+Uo8?=
 =?us-ascii?Q?3Jb8o6AEdPMwqSxRXLWhpoAAE8f3/sEBXsrBBpmlDk3pFmpqdxkK7J1lGH9T?=
 =?us-ascii?Q?8pf8efmk97SO67gzctd+c59LlXsSVh8a1fL6bKgXJowQ2uLIKscCeUR6XxGD?=
 =?us-ascii?Q?lVeIiTPe9XzUvZ04DHwJnfikwzsXWJsRG2gqijn79pqRHk3IUlEEZ4brya/L?=
 =?us-ascii?Q?lzv9i318S+Aiwnls62GG0ZmzW4o7Zof63v+QIZAL6XncHfwUGK8KAnA38qmj?=
 =?us-ascii?Q?UmpJQyQ7jh1dmpMXm6jtfHLgn+2sEURw3wdAa8cRNAhm+Jv5SzQQktmoP1CF?=
 =?us-ascii?Q?HeIIcPUwxw0uYQdz47O8MR1cpeWMn8quNiMOmtMeDmr794nAGiR1Q/I+klyF?=
 =?us-ascii?Q?0/1J1Yxm+AmLdjdiqqNK6qKtK8DnjYzFzv7khZNHGs8BdjxVfUvsw/6pcRYT?=
 =?us-ascii?Q?kFMa29nkMgjPY21uhER99NfMIicyDelWjGg6K4Sp2UMx+eKZjH0G/7t+xmKJ?=
 =?us-ascii?Q?I5v78vrmtSg3Uet8TirSuzxI2JRfZTMQKS+xmLh8DZI1GisiGUNZHpiGNvLQ?=
 =?us-ascii?Q?4lwjP/Q8SF1Tva/bKC5W2ddDGvLly/JsGXwpVb4T8QCmPrYCWxC/y2/+zvdv?=
 =?us-ascii?Q?HJNVC4UN1wREkMe/ZuVR3hlqp44F9hFfScGFQSqFJkSf0ahldjXAu+EGByQA?=
 =?us-ascii?Q?PYAjU4gSo5KsdsIBkBhwxVlPR1efexpHfFSjohuIfpvclEMg9C+n0eck6SJI?=
 =?us-ascii?Q?9y2KtskaaJb7wCEnOJVfjA9CeP8ap4j7Vv9dKvx2fDL0xXc/EpRzRDzcssWP?=
 =?us-ascii?Q?4zBBaetOpinMwfXRR+jhZkpHRR88Jm146LPDT/nFzQYRxFfS1fzniBAs78Os?=
 =?us-ascii?Q?zpmIDKC5PLyXp9kQsSbiSDWW/8SgvRLJYa/LSq3Tr5XBTkvKqyeqf/WC9/Qr?=
 =?us-ascii?Q?Tj7IKe8+zJtU3qRGwV0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5e99db-dd29-4315-1b6c-08dce4aa975b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 19:27:31.6449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcMuI5zW/iZIQn6j6CZNxFyfKAvWtB5aIndBxP26zJa91zzAIqJFpN5ujn9I6hG4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8329

On Wed, Sep 18, 2024 at 08:06:00PM -0700, Selvin Xavier wrote:

> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> index 5bef9b4..85bfedc 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> @@ -634,17 +634,21 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
>  	case CREQ_QP_EVENT_EVENT_QP_ERROR_NOTIFICATION:
>  		err_event = (struct creq_qp_error_notification *)qp_event;
>  		qp_id = le32_to_cpu(err_event->xid);
> +		spin_lock_nested(&rcfw->tbl_lock, SINGLE_DEPTH_NESTING);

Why would you need this lockdep annotation? tbl_lock doesn't look
nested into itself to me.

Regardless it is a big red flag to see lockdep exception stuff like
this without a clear explanation what it is for..

Jason

