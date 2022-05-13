Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42A7526290
	for <lists+linux-rdma@lfdr.de>; Fri, 13 May 2022 15:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358511AbiEMNE6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 May 2022 09:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240402AbiEMNE4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 May 2022 09:04:56 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7BB46644
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 06:04:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWR+qhta3g3dfb27+gP278K0F8uHPIxYH79fy1JInGbDL+4Mc+YT8UG6RZKYiib7gln2UA5YAsT3Wyh0SH9ogxoI8eJY7hrHdGaTPeNPCs21bluITFQtaC/n+APTecdWs39wlK6KN+N22+em1x6+BO9JudxwQC7tOVKdyZL+QFq3PBRpeaJmRCenN4rfMBm9/tjpyVeqttYzNwvqBkkFGMOb1nkaX64fSwPFQ+Bo7q4gicLVaw41Da94Neo8QxSBnwmxmsPrc2Hw7U7RR0xHJjfQWha3Yadu57SIelp4/5Jnm1xJuCJGrdBPDqzDqPb5muPXJ56uDsKN3IitmxstDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVNZZcHdsgvlIyHgbJVoS2HWaI4YiNjUvSFitoBA0Gw=;
 b=kbbWcZ7tjd9oXXPPYifWeGPkFor/k2CV4mHSML92elmEVVEwGFhSoz4LSykrmCkWI20lp3bAJ92+RWO4dQjgynnQds7xozMiPFhWenA/s9b1Y7ot7X6mR0wBatcRLwj6G5Ki+daNNBkuybqV/2uA2KrwMfQyocfFItL+BAXRBR5n7eT/My5FKp39QMBQuLteJqXBRhAjAuE9a0coZD8cZX/9DvXjEJA0h+1RW3pI2Rf5YYT3TwY/tXb4jlCt2eT404S15eARREuc4tjlw0fy+/Zf8pkJdiLNY7sSJ4CrcgK0wSQOcbyGgJ7v39UFksZEzG+l1Xw9l6yePBhWEnE35g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 BL0PR01MB5252.prod.exchangelabs.com (2603:10b6:208:7d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.22; Fri, 13 May 2022 13:04:51 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::d41:91cf:552e:b16b]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::d41:91cf:552e:b16b%7]) with mapi id 15.20.5227.023; Fri, 13 May 2022
 13:04:51 +0000
Message-ID: <ca817696-530e-f94f-dcfa-68f1980d31eb@talpey.com>
Date:   Fri, 13 May 2022 09:04:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH for-rc] RDMA/rxe: Fix rnr retry behavior
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220512194901.76696-1-rpearsonhpe@gmail.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <20220512194901.76696-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0189.namprd13.prod.outlook.com
 (2603:10b6:208:2be::14) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f3dcd55-f7d1-4b33-539b-08da34e12a4e
X-MS-TrafficTypeDiagnostic: BL0PR01MB5252:EE_
X-Microsoft-Antispam-PRVS: <BL0PR01MB52525D801EEB27BE9C662F67D6CA9@BL0PR01MB5252.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mvzgui0RbIx2NsVkstXPHHuvsfNNQzUSJk8qWOl69CbR3BlDSuv7bzkUEPQBd86qj69HZwNEM5X0iS7+a2UNL6JSEc8SXgw9EdLkh3ZN3MSu4eJk2XZN/TVYEA46WEYVy+miYajnkN1QnEnJDcjmxk7r3jtI882Gen1vnQmBMVMTqsIaVGdHye+chyfob2hjHrdtbYpXbXLR3Medn/kbb7GrsBvod/i6OQGjMOPAsC0uYZ6IUXLsBMAaiHdmW/YQBmfoKHF01HNMbXKDkQt18lQMhNjkxuxKc86ebds01ysspAzX7ZzQMzxm/y7vOLqIcI9li07AfsmiT15jZrygiYEfVILdoNsEyGMuc65vjuKFCy4H/OrnjDhfakSUPNS+8NKjD5ADQwCxbJRgQAcJUeha6hz+XcmPQikg40kAOn5OBJmrkwsV63/CDtUxtav5jkril7T6ezQqCvih2d4AxRab0u8Q9ADrmWyg2uFrreaKFHviE9TSIFhm0aukAcgb3pjLtu82tpIJSuIzfVhK0C9pah1rlEQYHEnIsjYsDeMIHfSjVTmB/i+o0G2NqOCV9eOhGNjI1iVQc5x2X30Uw9B/u/ngKdrbF0Fk6HImCXmkKnQ19CVlRE+pp6eHv089hN9QvZBD6UI1fqIDHxF1nB/8YX0Hxt4LBezUilstQ/FudDYkEpg30YmgLEsNOvlN1+uKmbbRVf2qIa0PWg/iSvOxVSDbC5SoR72Z5Ggv+h6Sxj2W780JMVI9KIJ3+MJ1XGKzT3FlzuTeDc2aNNw/ODV1XjUxK3YaKQj8tpnYkmQR4QLpjJcCWBgZthZ24Baq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(39830400003)(396003)(346002)(376002)(366004)(136003)(66556008)(66946007)(31686004)(186003)(66476007)(53546011)(8676002)(26005)(36756003)(31696002)(86362001)(966005)(8936002)(6486002)(508600001)(38350700002)(316002)(5660300002)(38100700002)(6506007)(45080400002)(52116002)(2906002)(2616005)(6512007)(6666004)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkFiU3JvTVJLc1JDMXF0WHcxcG5uL1MrMXpMbldBSlpBenV2NHhSRFQ3TnJp?=
 =?utf-8?B?cys3NGRpbDRJRE5oTytjdnN3TUVmWGhoTWoyc3A3VFJVSXB4NkNLN21JVVVn?=
 =?utf-8?B?eFFQRWxZKysrcmZ0YVNrVE9EamhQYzNaSVFnQUNNQlFYWU1FOEZPWWMvMUlF?=
 =?utf-8?B?bE9YVEIvN1dGd0w3d1RlMTV4ZHgrSXN3TXdMd2VTN1BhVDVSWWxtSmdZc1dk?=
 =?utf-8?B?Z01qWjZISWdTM1cwMFE5eWlicXZBMEUxY1BOOUFVU3p6cEZXSkhWYUdla2FP?=
 =?utf-8?B?dnoraDR0K1RyQS9xWEpPYWh2SFpMQlgwQU93NkNDNmpPZDZaSlc3cFVBRW50?=
 =?utf-8?B?YWhIcU0xSzZ6MElxamo0YlJSeUJFNzFJRnRWVkZLdWJjVnJERUFiMCtIZXlj?=
 =?utf-8?B?aWlBZks0YVpDdVJvT1lnQVFITjBSVHp0TDZ3OFF2dzdtRE5wLy9EVmNQa0pa?=
 =?utf-8?B?YXNNcmU5N0FnTUpKWlBaVm1MY3loS3g4VjlLQUVpekV5TVptdUprYStKSVdY?=
 =?utf-8?B?NURad3g3Q0JKVU5PMnZrY29mV2hyVTYvWkhacExVLzhTaTY2MnIvbWJSZFpG?=
 =?utf-8?B?OHVuVlgvTWpGZ056NDVBNUcyRGc2K2haWVpST3NBeElIWnZnZnVKNSsybFRu?=
 =?utf-8?B?TDU5U25uSkhBaWFiU0phdDRCTDZHM1J3TCtSeEpXUTB4TTVMaFo4VmVJTjhZ?=
 =?utf-8?B?T2xwcnJjVFE5clZuUnNxVjRtS1c5YTNaT1ZjM0Y4dHBxS2EzR1lleDNLeUFy?=
 =?utf-8?B?eTJwTkl5UkxBdXNkdUZmTkYyK3MxV3FabTFTRjB1TEVweTZCZkZhdHNReWt1?=
 =?utf-8?B?aDF5YXRSZEx1U0dZeVVZa3lnU01yYzF4KzBaVXYvdjdLalUrQUpZeDBCTlgz?=
 =?utf-8?B?R1dnTzYvMUJYUHg5QU9MT2ordndSSUhQMVhKamRXOGFWaU5QNkRXbFNSb1Ny?=
 =?utf-8?B?eFZCcGhadldkQXBTQ0IzSFIyWWRIL2tDakFYN3ZPZDZsVEVjNnphazk5VWlO?=
 =?utf-8?B?UTdSMzNTU2VPWktCTTNhYVkxL1RaNlhxbll5WU1qSGxySWt5VVZJcHBBYi9M?=
 =?utf-8?B?ckh3RzM3a0Q5dCtnV3EwMi8zYWFqd0VPV21oMnZsRGVSUDJtWGIwNDFBVXBv?=
 =?utf-8?B?L2VUbFEyODVqMUc2MU5SZmRoODJqQ0ZvaWpXS3BtaXBySWRHSFFlZXVwSTZk?=
 =?utf-8?B?aldIbm9laXNFSlAvak9veGRBS2tLMDZHdzNBdlFtaEFZWDBpSS9jMHB1djRo?=
 =?utf-8?B?Q0FwN3hLVG9DZG5xMjVXNzhmYk9LeVhkQjFWNVVIMlBHR1VoeTdIT3BNcm1l?=
 =?utf-8?B?WVoxQXROM2dnTThlOXcrd09DWE9uSkFwOEVKdFhrdDlFY0lHVGR3QXh3MWQ1?=
 =?utf-8?B?MldzemhQY09wVEZrZnlxTm9NditBNE15N3phM0FRZmNrdnBPbGV5Z0wyNUdP?=
 =?utf-8?B?bjZ5YU9Sa3ducGVBZnlycW5LdWtYNUdIdEhiVjNWR2UvU3JoNGZNY3pWZFEw?=
 =?utf-8?B?bnErL3dWU0FFRzcyUk91Wi9VTkRReGdINExkRm95YnRvMS9wMFBhbENGaUdU?=
 =?utf-8?B?MEJZNzNHWFFRcnA2QU1SQVp0YkpUdllFenAyRzM1ZjZadTZSUisyRWk1YkZD?=
 =?utf-8?B?b3lUVTVnbnVZVFpCWXFKUnhlRi9md05PMjIyS2ZKUjM5cHJxbnRYaWNIaVM1?=
 =?utf-8?B?RTBPQnZtNlJhL09BMjBSQ3YzZEQ2elVnWDd4K1hJUWZlcEhieG85bGNPdXIr?=
 =?utf-8?B?MnpUT215ZDdnT0p5NEdtTXR0NmV1WGJwZjczR0kycmJHY09ERitWV2xTdWlZ?=
 =?utf-8?B?alpiQU45ekFUa09mNTNFMm9Gci9SQkNySTVrSm1WRXRPc0tZYllPcFAvRE80?=
 =?utf-8?B?WEl3M0JBK2hFNlpKRVNua1lnTE5TUzI3cHZUbXZhaFlWQjhDSHNIYklwZUFJ?=
 =?utf-8?B?YmZHSFIrdXVrQzIva2RSc3VjdEMxV1Z5aW1heGNTTlNyT0EyK05hN0lnNGZs?=
 =?utf-8?B?dHV4UURYWFo0TFhMU0tEVzc3RGNTNVc5elRRWUtkTllyTUhqYWdFakRFMHBj?=
 =?utf-8?B?cDZhNVN4cmpVQVlJTG1mQlAxbGJpME8xOFRRMkZuaFY5eHpUeW5XWUE1aWps?=
 =?utf-8?B?OUUzMVBhb1lpTGJJNlpnc2FFeXAwUm9xK1BncTVaSlBCbTJQRjlvbXQzTUhr?=
 =?utf-8?B?ZVM0V3BaVHdMa0hUU3o3VzNWTXhHNTBNejM0d1E1Vm5YeHZOR2FseVQySFFB?=
 =?utf-8?B?R2R4bGZPd3pvMEM5ZkhLdWN0VVBLVlk2dkVkaTUxeXM5aHRPeHc3SHp1VnUw?=
 =?utf-8?Q?oxTkxQ7NMwkFwS9hqr?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3dcd55-f7d1-4b33-539b-08da34e12a4e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 13:04:51.0752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhV7nri4p+XjqXrcdYlLu3TpWhQnowlmEfxZtYeZFABxagWZh6pZwVERquG3OtZ7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB5252
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/12/2022 3:49 PM, Bob Pearson wrote:
> Currently the completer tasklet when it sets the retransmit timer or the
> nak timer sets the same flag (qp->req.need_retry) so that if either
> timer fires it will attempt to perform a retry flow on the send queue.
> This has the effect of responding to an RNR NAK at the first retransmit
> timer event which does not allow for the requested rnr timeout.
> 
> This patch adds a new flag (qp->req.need_rnr_timeout) which, if set,
> prevents a retry flow until the rnr nak timer fires.

The new name is a little confusing, nobody "needs" an RNR timeout. :)
But it seems really odd (and maybe fragile) to have two flags. To me,
setting need_retry to "-1", or anything but 0 or 1, would be better.
After all, if the RNR NAK timer goes off, the code will generally retry, 
right? So it seems more logical to merge these.

> This patch fixes rnr retry errors which can be observed by running the
> pyverbs test suite 50-100X. With this patch applied they do not occur.
> 
> Link: https://lore.kernel.org/linux-rdma/a8287823-1408-4273-bc22-99a0678db640@gmail.com/
> Fixes: 8700e3e7c485 ("Soft RoCE (RXE) - The software RoCE driver")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_comp.c  | 4 +---
>   drivers/infiniband/sw/rxe/rxe_qp.c    | 1 +
>   drivers/infiniband/sw/rxe/rxe_req.c   | 6 ++++--
>   drivers/infiniband/sw/rxe/rxe_verbs.h | 1 +
>   4 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
> index 138b3e7d3a5f..bc668cb211b1 100644
> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
> @@ -733,9 +733,7 @@ int rxe_completer(void *arg)
>   				if (qp->comp.rnr_retry != 7)
>   					qp->comp.rnr_retry--;
>   
> -				qp->req.need_retry = 1;
> -				pr_debug("qp#%d set rnr nak timer\n",
> -					 qp_num(qp));
> +				qp->req.need_rnr_timeout = 1;

Suggest req.need_rnr_retry = -1  (and keep the useful pr_debug!)

>   				mod_timer(&qp->rnr_nak_timer,
>   					  jiffies + rnrnak_jiffies(aeth_syn(pkt)
>   						& ~AETH_TYPE_MASK));
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index 62acf890af6c..1c962468714e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -513,6 +513,7 @@ static void rxe_qp_reset(struct rxe_qp *qp)
>   	atomic_set(&qp->ssn, 0);
>   	qp->req.opcode = -1;
>   	qp->req.need_retry = 0;
> +	qp->req.need_rnr_timeout = 0;
>   	qp->req.noack_pkts = 0;
>   	qp->resp.msn = 0;
>   	qp->resp.opcode = -1;
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index ae5fbc79dd5c..770ae4279f73 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -103,7 +103,8 @@ void rnr_nak_timer(struct timer_list *t)
>   {
>   	struct rxe_qp *qp = from_timer(qp, t, rnr_nak_timer);
>   
> -	pr_debug("qp#%d rnr nak timer fired\n", qp_num(qp));
> +	qp->req.need_retry = 1;
> +	qp->req.need_rnr_timeout = 0;

Simply setting need_retry = 1 would suffice, if suggestion accepted.

>   	rxe_run_task(&qp->req.task, 1);
>   }
>   
> @@ -624,10 +625,11 @@ int rxe_requester(void *arg)
>   		qp->req.need_rd_atomic = 0;
>   		qp->req.wait_psn = 0;
>   		qp->req.need_retry = 0;
> +		qp->req.need_rnr_timeout = 0;
>   		goto exit;
>   	}
>   
> -	if (unlikely(qp->req.need_retry)) {
> +	if (unlikely(qp->req.need_retry && !qp->req.need_rnr_timeout)) {

This would become (unlikely (qp->req.rnr_retry > 0)) ...

>   		req_retry(qp);
>   		qp->req.need_retry = 0;
>   	}
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index e7eff1ca75e9..ab3186478c3f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -123,6 +123,7 @@ struct rxe_req_info {
>   	int			need_rd_atomic;
>   	int			wait_psn;
>   	int			need_retry;
> +	int			need_rnr_timeout;

Drop

>   	int			noack_pkts;
>   	struct rxe_task		task;
>   };
> 
> base-commit: c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a


Tom.
