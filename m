Return-Path: <linux-rdma+bounces-1829-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D660989B8FA
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 09:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C17E6B22EA1
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 07:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94C04084D;
	Mon,  8 Apr 2024 07:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JYkJwqH/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2101.outbound.protection.outlook.com [40.107.95.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39443FB81;
	Mon,  8 Apr 2024 07:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562197; cv=fail; b=BsCck9JnV6+E2tlKmJfEE7jEc4ugVlulCuzb9L+e2BmGIRnmiK2fGOO7OPxSixDAYWB6Zime1TrkpghoPuzseTFr0h7a1zkB2qL9+DZDS9WY7apcZr0b1DSmcBz9nArFt4lhCdj5JZkW+Wa+GAWQI0YlkpND4pw/lbYqdSDiBFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562197; c=relaxed/simple;
	bh=zcY9iC6FIOV4DMT3Ce6y0lIUyxBB7ZbZ6lr97OlkZfk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nTzXWpYEO6411tbmqCB9dzn14f01Hr+cbZj2i9PlFZvqQf76GOgbuCkkTYMOD3WIkVk7vKfm9jR9U41s8rsdqE5xGqeeRv9Pce4jwvOyR7bjzCq+Xgmn7na6TRQHFt3gnGpMi0QPVz8vTV71JXKIS9pFiQfjtGtIcdzKBt9rYxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JYkJwqH/; arc=fail smtp.client-ip=40.107.95.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URfR2LPLNpjMMA6wi4usmY0zSS73/YdGMmdhsR0kJtuxHzCrMWdwPsGqODnQX5EfkDNTU8E03ZG5EPpJvu4pKKit2C2p/aRmL48mQb2cenF67wLeT8Z4UDj5ZeSY/DpxO8c6Rx1OHEBaIKyGG5u+Nbb9cTrHqd0B4teBXzkWSnS1NkT9q7vXAyCxM7TAwPxCVQQFEpoTmODbdExXSkiNrQRqPTGfWpvD2pWNuwfwTNVW0x1hBBTFt2aw8NPEstzTTFBuj8etFFh2R2iTsjz3Qni66Dn/EMggFLseQOz731kY3I9biLaoGSsv/1f1bPu4vJ3fLdsTuDDEyKApWlzulg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xn/5nwkSdJG/COV0nNNTWO9E+Yl9Cb1ZYJj0I2Fivtc=;
 b=QM5NpbOoLX/6Lr8Off+TqTHdWXVp2kb4YNMs1fVH3WpRhbozWeFtTlp6MjBBvlHCYY17ZLQBXdyqeFmjJE0v8T8lE8LQ/NASEj3Av5R4hAofBDeblYdZhZL2xaxttDcPl99bNdvy1bVV47WDxq5y+xRfrdE2WKoWzBLw/CW+nUP7o6lAceCkOoaxsCfsVGux55/qiPEJfUqLO07huAVu0kdXQ6lrpTmEnwv3b2W/ym3LvxCFa/yVKAuVctwEXVr0ZenjazduhGLlx7nD8hiQ/jjiUfR+ngqH8UBI1NHZRQ6RFA42Vpffu5O8fsl+7Jd4oKuHLlZaKfTw9o3zaVrRDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xn/5nwkSdJG/COV0nNNTWO9E+Yl9Cb1ZYJj0I2Fivtc=;
 b=JYkJwqH/cxItGyWfmpbyrD+X4gzYgBCsQxDcHnABoEj3LcDxieQtqTYn0Oo1plxprehKSHk7zEe1md8sATfxYDPpVz7gCcpwxQlSwMrALvFxMcxHMELhe6itxMfCTjBI7KNlTcEpe0u0iwZJ49VEvBSFyXqBOy9W12uLgBj1YaaZOcRpI+8yu2tb6jiSNUfGvB0gO/JMhhccz0DE24S0Tk3QI0IxRV853EWt8YJoO9jt83R9ypXVvpwE5hCMIKM4nutxw1BayBVBPBXLdixJE29qIiyjhdr4vkhXFPK75HokMjLt7EzpCEZIE1rRe8uzGxKd13cRWapCP5Dk+IO1LQ==
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB5844.namprd12.prod.outlook.com (2603:10b6:8:67::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 07:43:12 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1%3]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 07:43:12 +0000
Message-ID: <5276915c-77bc-48b5-8c24-18eca2734350@nvidia.com>
Date: Mon, 8 Apr 2024 10:43:07 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] scsi: iser: fix @read_stag kernel-doc warning
To: Randy Dunlap <rdunlap@infradead.org>, linux-scsi@vger.kernel.org
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-rdma@vger.kernel.org,
 target-devel@vger.kernel.org
References: <20240408025425.18778-1-rdunlap@infradead.org>
 <20240408025425.18778-5-rdunlap@infradead.org>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20240408025425.18778-5-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0254.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::18) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DM4PR12MB5844:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wnQBvnBLrZnt6a3M9havtLBAvxewWvV88iehx1HDey9kXtOsBox2Yhs9k1qIdYGNls9/GazaaTHvqQSGQOJzSzyJ9c1ve7798xJSowgJTeyWWaRfGg6+BKeaSEFDVND3YKKl49YKX7H5wvQGRybfIYwc/WOG2FAQsvPZJ4xiDGbyTYPE50zNMHfWUWfKtp0IMCBmg3yvebCdyw0yxv5g/rYp3yhyr8Mid9XR0Nt76RMKX4lCqctHlqdGaM0emJ6BJJmr5T4MM+SXPnbu7Xb9r626TlVgi2lirMNdb/Et26K9VhnwqyOclW5pci78U/Se2eVuzFknTQiEUCOYFOtf8ECBmqWa8NoQLRt2ubHbHKPhEY6rBIb4bsQeHTeoCCg9GTEtFGS6OyuB09eNhkNwIxUByvQainj/7WG8d5QKQHp8+UkEbpnoRjDUZMwrYqi5Fu7Vx4WKkiRIP4b1FFFsFXMtW7B8g2oxQEnxYqAEaTATGaL9awDJp3HfEipBHkgA75WN0do5sYWZh3BgASpdmIHqPdijiWkco1Vz7rAcRpuofgndWu/847/yVR1s7wLRlyOTZLelmJsnKm515QmVkRbdMz8ek0waXjEjZcj3/yWwZ8QvSL53peNsy2ygmDsqFjkqpdYCPx63FoQcG2hkpJKsuWVv2iaGNTUOK5hjU1s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3FFaWRmdWZQNXVidVNHYkJlalVBdHlxRUFjMlFEb1E4RnNtSmN0VEpkcFFm?=
 =?utf-8?B?ZDBMSnhyeW15Mi91d0Y4cGhvZ1JSanlyR2lkMHZJTkV3WkJHOGlRa0FMMkZD?=
 =?utf-8?B?UGJQR3JnNDJyYVRZK2E0THViUlkyemFYSmlXS0JaNnRTWkNISEg0S3MxYTZD?=
 =?utf-8?B?QllvYzJyRnNSTG1PTzU3U0xMTDZXc0tORXNUazU5cnplTTIzbGQ4ZGtjaklj?=
 =?utf-8?B?VkYrbFNudkhzY0RoWG0xRHA2NnczM3RGT1RXV0hOR1JWazlYbm1CaWFsZEw4?=
 =?utf-8?B?aGt2T1JPdGJ5cityZUE0eFIyQ0crQnJkRE1rNXJsbnZVeVZHNnBuUzdTSm5u?=
 =?utf-8?B?SEk4bEY1SlJ1RUJNWThkVG1SanprZEtvTUZsejEwTjFYUHBWckZOR05uMFFr?=
 =?utf-8?B?SnRNTFNuWWJJbzlWUDZkTXZZYTkwWkhqVWJzbzA5L2JsTWcvR0dGd0tPZllB?=
 =?utf-8?B?c0tESTV2cVZBbUc4VnBzMW54VTZtTmZINmR4RXYvNGwrbDE4a0hRV0R4Nklx?=
 =?utf-8?B?d1h4Zzg1SnZmTTlUWUJ6cUlmMnE2bmRKbXJtWWV4aUlicHdLRjQrVmxJQ0V1?=
 =?utf-8?B?V1p4WTc0QlJlVkhKcmVuTEFtREtac3JRNTlNeHlpby8yNHIyMTNvc1dFaHBr?=
 =?utf-8?B?U3E2bi9DMXdRa1dvV2V5cHlvZ284SU9UeW15M3hrcHJ6ekF1OVFtR2dCMVM3?=
 =?utf-8?B?NGJLWlRkSW5vTU5aUHNZQWRIQkFJMmdtNlFKZHdMVk9HRitCdmJkZGxjMlZO?=
 =?utf-8?B?UE8vWkVoZjJVSWZJdEJGc04yb3QzSncxSUhZQVRHL2piTjJZNlpQbjcyeDdT?=
 =?utf-8?B?clF6NTBYTWV1K3BxdzZ6ZXd0SWFRZWpHNlJLN0NFSG1UR1ZEUjhVTVJjbGc2?=
 =?utf-8?B?OVF3TUhlM1Foa0JDTmNuQTdwQ1ZlWmVLeXhLbFh2WWlaRVc0UE5XYWZldUhR?=
 =?utf-8?B?d25QQ0t1bDlHZk9qK0FJZGRUbE8zTVkzVTI1bWJXRjVYZTA3amNac2s3WEE3?=
 =?utf-8?B?UnYrcWQycnZaTDJybUhxeTFsOG1iTnJyZHRSTXBmeHl2UG8yVzZHNHFhajV1?=
 =?utf-8?B?RXFUWG04dGxLWWkrUFJzNVorVy9mNVJsNnhvV1FhUjFSMkxTdjErRithRnBh?=
 =?utf-8?B?bTMvc3dLekhKMnppTnhWb3o1YUJMbFA0R1JtL09Za0tadEp3bWZJTXZ3eFJ4?=
 =?utf-8?B?OWFpUXI0ek91dnlTTGt0UEROeUxEKzdxanovV3djd1BiQ3c4amNad2p4c1RS?=
 =?utf-8?B?ZGZrWHVvRmVldW11R0pnTjZMQ0NwUDk2aUNsTVM0VHdXUEQ5UEhQcDJrNnBu?=
 =?utf-8?B?OEtxSjVPZE4yTm90cmMvclRRR0REQUdlUk5Cakx6UzNXa2w5a3JPMGNqRHcw?=
 =?utf-8?B?WUZhZm54T01mNVZzQXdiV3FYOElmQXM4RGQ3RXNodEZGdkRSZ2Z5NDhGaUw3?=
 =?utf-8?B?VGhya0JZMExwY3RtQmNtLzNtRlpyMHdMQzdlNENXTkVTYVIxZ1dxSUUrTEcv?=
 =?utf-8?B?OTVEbnR5WEg5NlA2NjJxQ053UXJBanJCSnhrcno0Y09sTUxRTTlvT2tMdFJG?=
 =?utf-8?B?clU0SzhjMXdhNS9GbzRoMGxXbFMzMFB4dDloWDlKcFlUMzQxNzVUU2JIZmRS?=
 =?utf-8?B?dkZBbW5RUmxHVVFacmpWbmxjeE9vMFBwOWVpL3ZDdy9pdFh4SUUxeFF3ZTBn?=
 =?utf-8?B?bkZLNDlmemJkVGNNWXdwZWY4ZGY5M1VpUUJTdkVkOGQ0VmtzL2c1Q0IzbSs0?=
 =?utf-8?B?YlNucXUvU2piN1VjYkQ5a0J5ZURrWXdYYkNtaTh4NXFhc3RhdTJEWnBEZXp2?=
 =?utf-8?B?WEFUL1R2UHhRNzJTdzVuT0l5Ui9QVnorRUZsYzg3VkxmaWFMaWxKcGIxZ2lS?=
 =?utf-8?B?aWx0QTJRZmVDYSt3RXdsYUVaV2kzSjFINFdWK1ZiVkdWQlZlc2loNEI3QU9X?=
 =?utf-8?B?cTVPV2RrWW5nZjRGRVZENFlPQ1l1WEpxakJHeU5SWlBKYlRmWkoyR2pHeTNC?=
 =?utf-8?B?NU1GMEN6a0RJaFp2NWd5RXlORWFKbktxV1htSm55b1p3UnVxMnMwN0xLeWZG?=
 =?utf-8?B?dmVWT2M0c2dObWdXemxFQ1pzaEY2NFU3dEZsaXdMK0FWVDNGZDgybVBKV1VL?=
 =?utf-8?Q?ZcPkrIoDUFaU1PB2S0Cs/SdDx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b14089-b69e-4b21-dfde-08dc579f8b2b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 07:43:12.8090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OH9q5S67B9/nYTIsKMlkXe9ASCbIqDrDxofwk/aSU6zMvECQS6zA8yRlB+5YJ0sYQpKanSZJYzKF6ZJdVErh/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5844



On 08/04/2024 5:54, Randy Dunlap wrote:
> Correct kernel-doc comments for struct iser_ctrl to prevent warnings:
> 
> iser.h:76: warning: Function parameter or struct member 'read_stag' not described in 'iser_ctrl'
> iser.h:76: warning: Excess struct member 'reaf_stag' description in 'iser_ctrl'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
> Cc: linux-rdma@vger.kernel.org
> Cc: target-devel@vger.kernel.org
> 
>   include/scsi/iser.h |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/include/scsi/iser.h b/include/scsi/iser.h
> --- a/include/scsi/iser.h
> +++ b/include/scsi/iser.h
> @@ -63,7 +63,7 @@ struct iser_cm_hdr {
>    * @rsvd:         reserved
>    * @write_stag:   write rkey
>    * @write_va:     write virtual address
> - * @reaf_stag:    read rkey
> + * @read_stag:    read rkey
>    * @read_va:      read virtual address
>    */
>   struct iser_ctrl {

Looks good,
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>

