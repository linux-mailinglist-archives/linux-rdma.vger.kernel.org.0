Return-Path: <linux-rdma+bounces-478-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB4B81D763
	for <lists+linux-rdma@lfdr.de>; Sun, 24 Dec 2023 01:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2547E1F21D02
	for <lists+linux-rdma@lfdr.de>; Sun, 24 Dec 2023 00:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F6919E;
	Sun, 24 Dec 2023 00:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P/D1q5Lo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EF0360;
	Sun, 24 Dec 2023 00:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2jB0tdGgNghwO38AGgOJ4coTjgge9r6BaRoaYluYKO8tu1snfFgeDKrcwZ0Dh2Rabi+lcuF4zhAGsQ7d3lGwaGzNaxNTralV4CdR2lps7L89ZTKaqZTgqcVPcNmfcgmuo56e6RwaLiBCsDYSPuS0I0t0ohOsurAkGW7y1odQj4mpfAVa79gSbnFPJQriIdNfrG47imrzbsbM++bsUw8ZCWFWEqcGQ9F9KBjmo7n5rP1DnJwjtpcbhlkh/7HCqwpyazinama5IFRhSd2vJ5T0CosWLUB7Gljov9o7HWj0zCk6TTyb15fYN6RxeIyidDIxt0ATdfCbngC31n9H9cWvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7AdD445fCc06UuolmMdcrs9nTjZg1P2TQdiqQK4FQk=;
 b=If7xwf6ruGSp8cvof6gSrauiKVb9bb8u5exyEFN3rTzHzUnyuD4RateFDoWu3MaHafg6GCxhM2QHDMd4xXDm+ntgWeY3SQKS213NbYt6o2tVXDcEMryD31/JqIOhcUknNklFkn3aNI5oR2NsjWMUsA1tiKfsYGuFtbcwrLXjtP8VPYfCbBAn71Q5KJxNpgi5xZ0sgNnLU8DPQQElPuUKkNTetYFeUnMIXpSdXDAiPdp05gU6qvEIpOc8v/y4sX5rhB+Nga6x3RtBWymj85dWRPgq0X1w+y+SqDkTraB2VD2WWxnsgeCrBDZw4uu2rnghJCuTjzAqj1GmslOzv55cCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7AdD445fCc06UuolmMdcrs9nTjZg1P2TQdiqQK4FQk=;
 b=P/D1q5Lo4zyjwv3wKSmgsqQHBpVyCRoNllOxY0kfrhwSNanLIEjcyPWK8+ptutV8oCtg1xH1CdQrqy4+UfUhfK//7m+Uv4/nUb2A5WyDlIYIYql3t3kWhXJxESrKKh8qAHxF/kZW+ejJ1BIFj/0TwBHQIkAoChrewi10ACIWb2kei9FqXHqO2befC+dA8RPhsDPizLHjw4rIJ5AgEBpmq4AGnRI61qMn5f5O//ocEXsCqByM1qR8Qn3qjen/yOBg2s1T4u3sCyK7yz1bF8g6OXhWW4Ud+szbpd+qju7VchzAHfaextIhXEuxvhQAQFUvTAqteqnHAPzw6GFVZOBurw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM6PR12MB5005.namprd12.prod.outlook.com (2603:10b6:5:1be::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.24; Sun, 24 Dec
 2023 00:23:39 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7113.023; Sun, 24 Dec 2023
 00:23:39 +0000
Message-ID: <2e34aa5c-4e50-4492-b3c2-aed9e06e8236@nvidia.com>
Date: Sun, 24 Dec 2023 02:23:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] IB/iser: iscsi_iser.h: fix kernel-doc warning and spellos
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leonro@nvidia.com>,
 linux-rdma@vger.kernel.org
References: <20231222234623.25231-1-rdunlap@infradead.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20231222234623.25231-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0097.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::13) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DM6PR12MB5005:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e4a5a2c-0851-435f-27a9-08dc04169297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wpLZ8bYwTcG35AYqHjmfO8xwtt8NYClREjQaGES3QoiJDOXRSX75N7nqXubw2WE+FQbxlpx5wDQjFsW8D4RzwBZkKmqspyLlXBpKB+7Z4CkQ5BcwF0dbf1dXPIdf5bgCOe7peOdYUw5OyhBCd3iKZ+I8f2RFK6r8+GZoCym1/f1/1DE0TuzFQk/8bW5KCVTh9R3aVQyK4Lft5es1mu1BKxFXsfJ0N3NXYPULzVkZv+QTnC5TBpnr/TYmpQWAN6puUOvCrOF/H/muhk8AT9gxe2n+pK1ZTuYnUL+DxVk0XXz5l6MR5hhBk70VYHRCj1iTQG+ke/YO8DHeQbkdBoQFzfp80gSyIYVDoMxndQGTwDolZd3GxoN9bguakm1De72SIZx32ktzv0QamD6mzg6MNbEDspah5pEttRhf0a/4BEoRyVKYEJ8nZHWgHTJHaDOupsftrOoq0j73VqHX8LNwNQnyqyLz03EgO/fxlBabQicMdS91gWgDEYr5gi48xRKzq2+SwdFL+/yAJbMN8Bjf3FShXDwZFnsI23fjfzK4gvaQSHlxH8CjC5cK5xiZpIU9Es+8+hEgm5e3AjjzXwCXdYprKX2Hvr3m4woE5pIYdz4Ct6eQZkbsfTnQOzKPzZkbcQku8XCTS2FAsC5ksXH8SlAWPEixDMe1AP1a/WX4N1pImVtyQPpiPe40FnDPKvHZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(346002)(366004)(230273577357003)(230173577357003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(54906003)(66476007)(66556008)(8936002)(8676002)(316002)(6636002)(4326008)(66946007)(31686004)(478600001)(6486002)(110136005)(41300700001)(2616005)(38100700002)(26005)(36756003)(6512007)(53546011)(86362001)(31696002)(6506007)(2906002)(6666004)(83380400001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ektXVWx1WVhJWjlOcjFyNnlFZEczY3NEVXAwVTFPaVJxa3hhalp4MERYczBK?=
 =?utf-8?B?VGY1RDViWG5WN1ZJMXNpQytvbUkxZU94bnBiYy9lS2VaakVMZW9JT2VpeEQy?=
 =?utf-8?B?ajdYWHZBd0w1UDQrTEMxREtqNWJRVjJ6aGt6dlRsNkZ2MzhCTStFT3hWalZT?=
 =?utf-8?B?VkVONENBQjA1S3cxWmJ0RFF4RklZTTBJVkVsd2ROcGNOVDE4Qyt5QWVNWGUr?=
 =?utf-8?B?MGpHQ2oxNmpWazE2MllKUmJrR2tIUVFReXlDOFFwczdwNDFGYklJOGY0TEQw?=
 =?utf-8?B?UzJKVHBLUGJjVG5LY29hQTBDQVJMQ1psUmcwNmZ5NEcxQ1NYSGNrRCtZd0ZO?=
 =?utf-8?B?bTJmQTdldWdmM1U1K1NiemV1OTFkWmZEWVhHL3RVYjhsbm5ncER1VmV6N0d0?=
 =?utf-8?B?OUlFUjB2YlAzWDdZUVNqRTZHVE1QY0M1TlN5b3BwdmxrL3hBdDlJSW56dGpY?=
 =?utf-8?B?T0tZYnVvb3FzeGNOK0xyNTVXY1F6YnBZb2ZBUnVZQytzekxTemtzZy9XaGNG?=
 =?utf-8?B?K1FxbHlBSXJJR0toTDNjY09oTGdsaWRkS0pSdzZrYi9YWWJ5MlFEeksweEZ1?=
 =?utf-8?B?TmI5WGRERkw4emtNMjl3cUdFOTJFTUEvZXQ4NXRPNzdya1MySnJBNmV3bU92?=
 =?utf-8?B?cUNtVkQ4N0p4UUxud2dpMTBhR2xVV2VGSGllNDNEN1AvNzEweGdaVzhxVURL?=
 =?utf-8?B?Rnlza0gzRWk3Mk9ycEFxb0ZtNDJEZFh6dHFIS2VBTk94OWh4dSt5cmdLUktK?=
 =?utf-8?B?V0syNHoxN0ErVjI2K3l5Q3dKaWZiQ1I2SW5hSVEzNWlUZGlXS0Vya05LcCtl?=
 =?utf-8?B?dERiTVFQOEpsVEJENzNIbmVLbEUzV0xJeXg2cm9CTnBWU1pFeCttV2daVWkx?=
 =?utf-8?B?aHdObVMraTRjSWZ1U3oyUFFUUkZXMjExaUVUTUdwVnFLdHhTS3VNUkVXU0Jn?=
 =?utf-8?B?SVo0SlhyeExyTEJvK3ZIM0dnRGxhcjY5NXluM3VBUzE2NHByYWxBZFVuMERU?=
 =?utf-8?B?aGNPUTN0dnhVSFBON0hyZGswc1k1dlRhOHhUaFM3UVhIUlZRQW1SRGtkckNo?=
 =?utf-8?B?UDU2SDR2T3ZYcmZ4ckc4bjkvQi92SFlXTWJsR0xLbGk5L1JabXYxN0c4NHNU?=
 =?utf-8?B?dUJxOHhNWWFFWHJqY3Z1MW1IZ2oyYkphYW56V1pwZW1laXlzZVFRT2xid01F?=
 =?utf-8?B?RElCbjIybEpqM0Q4ZDFkbjlBenRBOTNrSGMxY0dVd1lrS3JvR1dERGhEVXRa?=
 =?utf-8?B?cjEzT1RsenBRQzZkcWdMYWU1YVRudmI4V0ZaN3BvaWFUT2ExSTJnTG9Ja0VJ?=
 =?utf-8?B?cm0wY2tWdmFGL3pnVVhSaEJ1bkJNdjEzdUppZUoyNEM1K1BhNE5iZkxDTDBH?=
 =?utf-8?B?N3Z6Ky82ekp3V2JVQm13amJUaFl1N3BBNVJWQ3J2SWswZ3dGcHJSZ0RjaTdo?=
 =?utf-8?B?VVBLdXVRdjZpbStyQU5ZZUwwczhFOWZRdlFMQitqdVFGU25ha0h2amdJUlND?=
 =?utf-8?B?QTB2RmxqQmh2bVVVS0R5Z2U2L3RxLzVyczFGV0t3R29CZTRGVkxJTnExd1VQ?=
 =?utf-8?B?bE5mMXVNY1lzVjlCOUNmc3FOdWdNdU5OVUdlbmViRmhzUEdnUGJUNUNrR1JT?=
 =?utf-8?B?QU5FekZCelZtU1lSQ1BLQXFNaDBSYXRPYWthV3pEdDg0ZHp3TE1Nc0F6WXYy?=
 =?utf-8?B?cHFQc0UvT080Rkh0QkV5UkVxRElkNnNLdEZOcUNURjNKSkpEWGNqRE90QlIw?=
 =?utf-8?B?ZlRKUFFzK2kwZW9QQTF0eFRwVko1UUxJMlVsYTJqT0I1VEZCWi9lSWpaKy9U?=
 =?utf-8?B?bFdSZEkwbXJrYTc4ZitSRHNNUWU2UW1LZnZvR2ZFOUs0VXRlenhSTXp3ZU9P?=
 =?utf-8?B?c2QvQzliQ1c2YU5qYTVUWVFqaDUvQ0JKdUZtdFQrZTFKMm1uMW9mVldCVDZq?=
 =?utf-8?B?alNBVThTTDkxOWhUcHJna2RqaURkcU82QUtrK0JaVWNZWVJWWDNYN1RGVDEr?=
 =?utf-8?B?R1hVcWRIQ1k5MkxieHd1K2l0RTVBZUhIWFl4UmFhTHRtVXh1WFVhOVNvVFdv?=
 =?utf-8?B?MnBtMWdDeG5SdGVIblFLUXZ6NGZ4S2l0OUtnK2Z3bjFueFJoeTRjbVlaWWVQ?=
 =?utf-8?Q?MThQVrgkq0d+adUoyf+s02M01?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4a5a2c-0851-435f-27a9-08dc04169297
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 00:23:38.0924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/mlTU83S/5h6a3Nheav4ZYaPULGhrvqHxgh7RuI9mlz7TLv8IaQu3Nh9QfRlCbUvppHhT2wdjr99P81zNPjkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5005



On 23/12/2023 1:46, Randy Dunlap wrote:
> Drop one kernel-doc comment to prevent a warning:
> 
> iscsi_iser.h:313: warning: Excess struct member 'mr' description in 'iser_device'
> 
> and spell 2 words correctly (buffer and deferred).
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Leon Romanovsky <leonro@nvidia.com>
> Cc: linux-rdma@vger.kernel.org
> ---
>   drivers/infiniband/ulp/iser/iscsi_iser.h |    5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff -- a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
> --- a/drivers/infiniband/ulp/iser/iscsi_iser.h
> +++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
> @@ -182,7 +182,7 @@ enum iser_data_dir {
>    *
>    * @sg:           pointer to the sg list
>    * @size:         num entries of this sg
> - * @data_len:     total beffer byte len
> + * @data_len:     total buffer byte len
>    * @dma_nents:    returned by dma_map_sg
>    */
>   struct iser_data_buf {
> @@ -299,7 +299,6 @@ struct ib_conn;
>    *
>    * @ib_device:     RDMA device
>    * @pd:            Protection Domain for this device
> - * @mr:            Global DMA memory region
>    * @event_handler: IB events handle routine
>    * @ig_list:	   entry in devices list
>    * @refcount:      Reference counter, dominated by open iser connections
> @@ -389,7 +388,7 @@ struct ib_conn {
>    *                    to max number of post recvs
>    * @max_cmds:         maximum cmds allowed for this connection
>    * @name:             connection peer portal
> - * @release_work:     deffered work for release job
> + * @release_work:     deferred work for release job
>    * @state_mutex:      protects iser onnection state
>    * @stop_completion:  conn_stop completion
>    * @ib_completion:    RDMA cleanup completion

Looks good,

Acked-by: Max Gurtovoy <mgurtovoy@nvidia.com>

