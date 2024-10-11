Return-Path: <linux-rdma+bounces-5390-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0923699AF8C
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Oct 2024 01:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6347FB21FD2
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Oct 2024 23:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01731E2019;
	Fri, 11 Oct 2024 23:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EWavmzUz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8141D12F0
	for <linux-rdma@vger.kernel.org>; Fri, 11 Oct 2024 23:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728690676; cv=fail; b=ijkBjyAestmuOiQSWqvLqdYsf2GUZE4DDHXpwkmeS/LuZZ92QxxlyTfJjsIyYWlJp8HV/Wf9nphsOJgd3rCw5dECvc5u+/S9qBOnR1ny4kZDMUv3DUNxgn39WA2JHzkhYaZoCBqCyZOpF03BFte6JLCyDqvKINwN3ZKI9HKoouk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728690676; c=relaxed/simple;
	bh=fWSbaqcJDJUKtSYkuHMTl958i28mRSC4qXI0Mjn0MIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NcpAG8K/GXKl28Q1FyMdiUAQKKckHRZNuEOFXhYyDyEZUiOlKfN8+aa5eF+vQgeI84bRoGYEKCSbj9pE6dkSwRdF+xdQtsqEZUGRHm36H9q/dSQMsgUKiSn755vBiEUpY75eopSvC36NJRwIqbvDuGSSR6WcPiqCMMcilttNcm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EWavmzUz; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZANsogJALeCv6q1/Z5ZL+6klCaWjz9MF7BqnRl9RWh6m2P5SOjXogX3jhdzfNaovXuL6En6lXq/enDfDIRsyBGyOkbib8EQr/dtY0iXzacMTr7D6bZPBs6DXnhbQO/2S1Opt5mAxDSjRUVyrWfgaLjqnJCep/HYSEy+ukMKICsJJxJzqYAY5/hgYN3edY3KjNnb4QxaOwBG4xLSDjVs7AOql/u4imspDHNuohV23t6leXM3qSkJrll2KzFUJ8YemSamCyKXPJb3w5wFwKs90PWXoKBMeTGP7kdF30GJJ/6ZPuzVSlhK0jHo/kfjbb19tSyUTCyCxFZp1CTa7vbJLwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzEghYpP/Q7AWpoYIBHubSy67AKn2amY3QUjQELayf4=;
 b=byYENyFxhAj7Dpctw0WHO+k7Qeh1fkV632gxvaYllCXF4cD0+UdI5EuboXmfvgTTyTbTk730UXM80TqAismgPGdq78TKTUCE+zrOrOmkmAVmFUovFN5N1LjUT9SgGCaE/q2ckIy8NmV5TLCAzuQFUgHLcwO0PJZZl0JiWHw5YqEMO6o5c0L2dkwSp13iHqz+NxCORd0cAgHHVxzq/hVvzTa8+764CUv62RfEFnoSgINJIiAJchS06DXtcivR47yfd/5mhjcW0YpFKP3WAPH6HPP4WC/dL9wz/ar29K41LaWvN+zaHuY2K0px4RgAK7E6o9MFsNTYlx5jGmbjvHwbYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzEghYpP/Q7AWpoYIBHubSy67AKn2amY3QUjQELayf4=;
 b=EWavmzUzc2uJHtS5QHQxLDM4jG3PRAhBIgTv5XvFpmXS9mPjatByvWUD46lfGJG2uxhAEYMw3ddYNHAGrK53SRY7mSJW4Ggn38c5vuTOj7Dk7Dhf9wez89cs+2+5cqfDlC6eOIC3Hl7E4yDlQS7l3W4xkeb9hh2NgF2sDT5+I22EN1KwnF3Hr33Zlt9c6sj5Fj1LaSLWDydwybTCX5J2heMbtMHfxeADZBP0lv7DTTAkov3ps57qfr2zkS5CXNZ9WBcrGm/B41rR0CfcCx0z/wwQ+FxbsG9QRWhubx08BvRLdsG5xe1Ov+jh/nUjowlr3/d4exf0Pwlvm8XcMrpkXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 23:51:12 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.020; Fri, 11 Oct 2024
 23:51:11 +0000
Date: Fri, 11 Oct 2024 20:51:11 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH for-rc 00/10] RDMA/bnxt_re: Bug fixes
Message-ID: <20241011235111.GA2282891@nvidia.com>
References: <1728373302-19530-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1728373302-19530-1-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: IA1P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL1PR12MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: d8dff405-92a7-4488-aa87-08dcea4f95e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gcZ4LIMmZK4g23j/aUn+6sthASQa76bYgLC22NJlYIWCsHeClngmJ0CbKb2r?=
 =?us-ascii?Q?G5Sj3bYWOI44jOpqqHQgaumdXJXpUQYyhgp1hZb6Bhv+ILRuxcQdRLaXSesg?=
 =?us-ascii?Q?EU3UAwMId9XJkY4Y+48JSgAl8g0n7iKJ3imWpx64nMx74OkQm83qMLrJfYb0?=
 =?us-ascii?Q?VUz0zLKTarTVFDfMwzAi4M5NknCg0GdSzL4xRYTHWi0lIKkhOT8uu+EJEVB6?=
 =?us-ascii?Q?wpcNSaYxMFy6kZEWKPKubcXaH/eNdD6WCDir5Dv7gXK0mmD7JAHDQiyVN/VR?=
 =?us-ascii?Q?QZN80wTLYsE5SocIF/M+ndUpcsUdDjlwCni9zjnvpcpIYOjEcTcZ/O39DDjq?=
 =?us-ascii?Q?OVAhbASfMLyq2xCEiENLm/J8+ovxV5d7dfakgAJC3sOsv3+/SQY40bxo+wut?=
 =?us-ascii?Q?7hpUbcTUJnqi0VJCYBinnuP1h8YY621dP6KEEtxKdaYIbvkTdXkZ1z/YpWIo?=
 =?us-ascii?Q?0oztEBcm5NOEL8xWZQtW7pc8Xjp9tAUT5xal4kbBmSO5urnfBeQGhwWaEXN5?=
 =?us-ascii?Q?lH6df8N4FsFodOdhnR/Cf/33BH/zLL1vT1Rvn2gbFDXFTpdW91O3u64t+cWv?=
 =?us-ascii?Q?OBPZMX11KYkdUwl3OXNuJDgOcgd6BYqjiqjiPdh911xJvyg52N6KTa9n7Spd?=
 =?us-ascii?Q?ZjrdsgQ6T/ooj+PE/H0tu427rfhShnbCXDYIEHDQ8rhUft8wJusdfxBJsSjR?=
 =?us-ascii?Q?yYKcZ3HqcDGwwn4mrCy2pHlp/I1D4mz1QL11ULrPUY1kK6tiXGiONMfM5ZjQ?=
 =?us-ascii?Q?Xkhwj8rOJnLwY3hI5gf4OGkBBtQ3ocamjDIegOCh2rio64Y2RTc5EzxQu7BF?=
 =?us-ascii?Q?yGcdZALJuEFTqsOqYOh+LNss9bTVvkvf66jKZYc3+qr8b/WBC2xhzaD0C/KC?=
 =?us-ascii?Q?HDWf5BNqjAJtmUVWf2Vd5f+2Zo4GUZjLpWIr1zdecdI80F5QaxQAosRPl0Aq?=
 =?us-ascii?Q?/keLuOeDQGPAUVhMj0vGYtHaeaRShz69s/5Miap7n7hmgo/BpziPFVnDeQCR?=
 =?us-ascii?Q?zDXuciEi0iDSApIrKudMbkqXFtXBQ3vLcf3RpvyyejhLui7YRC/9g2AjVcwI?=
 =?us-ascii?Q?2KXVak4lQy3DU4QzxjNmjfoPF+0HeTKQUMPfoYMx3YlTs81MOtBBNtr+aA9i?=
 =?us-ascii?Q?HWpqQGs6WduZnPBNg8/1sUk9BWvkDPh8cGbbJ7BhsFlZFGiCDDwPuVISM76m?=
 =?us-ascii?Q?20BqW26mHjgcLfywJfiYjNjF7Z/oyuPI/046/lEmFkN32/85EtuI84V9t+KB?=
 =?us-ascii?Q?TSb7pQmQf9cv5L2iQCIIcOJ8AM0/ykz25YQJ9GUHLA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Js7ewr63pIlWL4w+G3P0Oz0il72kSdArzCYcd1RixHDQZ2umADe/CLYSGTWL?=
 =?us-ascii?Q?EYRsodw9gxhbt+Mld9xsnTGXuC0kPLjaM6TcQwfouFQwcj5JLzConNfYlmuJ?=
 =?us-ascii?Q?ru8LGSfAFRPq0+/3ZGhxxKR0oBE9cBrx+KERXvhbB0TzQyJ2o7XFvTsQxADP?=
 =?us-ascii?Q?X7IMecStCcwwyp7VjLdBbJUoN8jCisbRQK2yMObizerjI1t8H3pQPIKZDcJm?=
 =?us-ascii?Q?lM1H/elg+awTJ+1xjqHaZ1MbY+2dK/MT1TferDbkdq6YNUEgeAshg/AjB15P?=
 =?us-ascii?Q?rVPC0GhLKRankAl54kNmq0lgjn9ALzoeuyfr9L6+s99ivQF3Ns6yhjuTm5oM?=
 =?us-ascii?Q?Q0133Havy1PZZ2m12a25JIohE1WHzOtQCyR6oUx9IuccunB1DiY+AYsas+o/?=
 =?us-ascii?Q?1KHNLzNRsmzIYwEP8jw2bYAT1cHdshkyCvIKVmznh8vIPrQBrRRTQVeqzqa3?=
 =?us-ascii?Q?oNKqqqaNSbKYT/Kz1cHysXWLpXdNNtMBafO7J9r8Q06qE6Gt2+gV0NCIUapc?=
 =?us-ascii?Q?O5F9vaf6cScA1hUIBH9P4nhPiprG1my04+z5uYwBqZeKWEwN1KiLobaHwaD4?=
 =?us-ascii?Q?iVYHVFo2D2JO/tW9tGXyqtpyaEp5Z1WEG3Yir91+qqO9h+U3DIR88JAos/ob?=
 =?us-ascii?Q?nM8y6udpjTef/xZwXJizKhMwR1FgM1smUDSjT6tkMd04nuGxZ/XA1pTCleDz?=
 =?us-ascii?Q?Dg7Z/b8WwnOwFHcrm9U0Rp1RCb3tJhF+NdtZJkhBPns6y74Cc6jSyF5RaHZy?=
 =?us-ascii?Q?nXFHhfE6iNs7NU6nIKpem4Sz7B9x1Qz7lim1pwrZJHnOO8PSyPM+QeeA6mCv?=
 =?us-ascii?Q?pejIifK32BMQT3fnX5xQOi2v2oaZIx1OPoLb6IClfsnmZQ/GsNE46zZbYFVF?=
 =?us-ascii?Q?M6jRbMn2AOd676xmL+/OAFPrJLoTQoSOmJYmqX+DqXLxtLEbbLIvu+3nz1ci?=
 =?us-ascii?Q?ARaC2fZxbThtzP2Sh8EythWVZ8MckYujV7X7v829LzyG3XMIAiKIa8nr9jXl?=
 =?us-ascii?Q?NSKLJgJ77wlIdixz5jHKkLOJF8PDOLAtWtHou4ZOHmZl3rjSoWKu4TIC5Y4f?=
 =?us-ascii?Q?zodWKYeYzV2ElQy1pJVu4AaulhKoQ4h0D/Pd0gT9Ny+o+hBJJtvLSV9IrvDC?=
 =?us-ascii?Q?+CV0UbcdWBYm/vJJ/IQJ6M1RgA7myFtkb1NnFjtD7Q8Gos6BAnqIjg/Gyfjk?=
 =?us-ascii?Q?NmlLfAOzoE7hf45JAz74ZkR6SxfAtg3/l9C1det6QjNvweU10lfILe3pkE8Y?=
 =?us-ascii?Q?lUMBXxWqzS3LL4D1/6bQM5oplho+ht7Iv5QxK2Fd8y8o+zJ+hjeblIEazVin?=
 =?us-ascii?Q?3PFOXD7539CEsCj3GuxcsdTdI4Sa1hS0ewafMvv9VV9xs6nLfqBNyTcLc57J?=
 =?us-ascii?Q?hDTBIHKPN2KaSs5r0UAKQFxNqHuUq4D+9PT1Qbtwm2fgnxVWCVCMCG1wjYxq?=
 =?us-ascii?Q?AtH/BHXQhqTz5+QpWH3Chm5FZR4pTIVdFTqXs3BfGowqtFsvptXJFvXbAwqz?=
 =?us-ascii?Q?vdr32ApkUWnHOGcqOCrzRzoNKGelRWpcra51lwzSM1hJKL3Ld49Z92vDlrzX?=
 =?us-ascii?Q?Centr2Z+bnrQn6Gi1qg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8dff405-92a7-4488-aa87-08dcea4f95e6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 23:51:11.9448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsbf5/lv7slkAoLLsiVDO/1SVUMl+x23wmB2baxO+R3p0yR5KalPGGJBXzJ9OvhE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732

On Tue, Oct 08, 2024 at 12:41:32AM -0700, Selvin Xavier wrote:
> Few bugfixes for bnxt_re driver. Please review and apply.
> 
> Thanks,
> Selvin Xavier
> 
> Abhishek Mohapatra (1):
>   RDMA/bnxt_re: Fix the max CQ WQEs for older adapters
> 
> Bhargava Chenna Marreddy (1):
>   RDMA/bnxt_re: Fix a bug while setting up Level-2 PBL pages
> 
> Chandramohan Akula (1):
>   RDMA/bnxt_re: Change the sequence of updating the CQ toggle value
> 
> Kalesh AP (5):
>   RDMA/bnxt_re: Fix out of bound check
>   RDMA/ bnxt_re: Return more meaningful error
>   RDMA/bnxt_re: Fix a possible NULL pointer dereference
>   RDMA/bnxt_re: Fix an error path in bnxt_re_add_device
>   RDMA/bnxt_re: Fix the GID table length
> 
> Kashyap Desai (1):
>   RDMA/bnxt_re: Fix incorrect dereference of srq in async event
> 
> Selvin Xavier (1):
>   RDMA/bnxt_re: Avoid CPU lockups due fifo occupancy check loop

Applied to for-rc, thanks

Jason

