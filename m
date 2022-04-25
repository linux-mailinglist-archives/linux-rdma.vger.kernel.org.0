Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4343550EC55
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Apr 2022 00:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiDYXBk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Apr 2022 19:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiDYXBj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Apr 2022 19:01:39 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2046.outbound.protection.outlook.com [40.107.102.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E883A5F5
        for <linux-rdma@vger.kernel.org>; Mon, 25 Apr 2022 15:58:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ER4D8xYsKbZBhE2OulOsYhPirUxc7TyzS11Xulvk6o9xjNLE95W4BDrRq7H/xTlIiJ0cxGj4Gucm8b9qmSD6pYZiHObY0oflHRbnvxtxLKNAg/3y0jMNHX0XjrB0LUlS9ejt4MyspvG+9VQ8A3ilGWLDU7WlAu2BV5xPY9BIi4PTUsw5aSB+1JUaJeOhwgPxJ5VxAmb87Oc+NCJIgpV2era6oe9QHYyM99b0higYSK8vuaTB1nzJ2JPXe9UN20sEzYim28Gn5YpyO9Nvg7QPb0bvFTe9FSgMZuTx8BGNPdcmJM0smloMP75m/s5IRtqHfbC+hy3xQ9SEpuHJWCdW3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55DYqk7nof9tBQ6+Qe0APMY6CDL/S+yazQp9UXShWNk=;
 b=LFI2mESn5q4Ap3Kz0rnYiabX1GI01Roa+WHXEkPIYRsrw2+YP+xEGOshvSE6DQnlU2/bhxDV1O/vm11lDf7LApB2GBYXD5mYQkihEeoXn+xWN+lRcYG8B3bhLM+gMVEcg84zucnNss/nRsKpak00wtRog2XQ2oHWiYe6WoMrbSONDKGLJRnYZL8D3ANM8faDwKQ6KE9Dczzq8jfW2If4YYpEj63OktaDQLJDAcTaZrK1fn6Pj7V2N65BprC6b818exqx4tzOBpQ/TtQxBAsTcepL9ul6V4KmzkFK5FZWejqSqbS7Zhcv6hggySGS8yqTS7fFqA12mGPo1xzdTWJPsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55DYqk7nof9tBQ6+Qe0APMY6CDL/S+yazQp9UXShWNk=;
 b=KU0UZTtw8HcLXvfwBrG4W1Smxm8vdxj2dZLJkQLDiwue23H84/9wN5qseTVDIVEtnTxLNun1T3vY7/fsFGbi6nxppuggro2ejIdfXIR4txQYzKSj+BusoDCZBXocfU2rZ0HLf7dGnsswayZKZXnIFfEcCb55R5QfLvTkFvTbgLQevPGO0qI+c+NBYRDK7sbSYrsHMBbfFSC9zFDEcfOBpwa51tuKXxbqohzuai3sZq62yKAlRJukio4LlDsm2aohYHqn82PtVmUVEU9ZYUfueFHMBL4BJC6NwtbHjRBNNQ5OtX3RNMIQZV+aAbMuG53WErn1iV32JHgkZAXSY4AKSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH0PR12MB5297.namprd12.prod.outlook.com (2603:10b6:610:d4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 22:58:32 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 22:58:32 +0000
Date:   Mon, 25 Apr 2022 19:58:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: bug report for rdma_rxe
Message-ID: <20220425225831.GG2125828@nvidia.com>
References: <5de7d1a9-a7ac-aea5-d11c-49423d3f0bf1@gmail.com>
 <98ad3df7-b934-ad2b-49c6-bb07a06a5c4f@linux.dev>
 <dfba7eb7-8467-59b5-2c2a-071ed1e4949f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dfba7eb7-8467-59b5-2c2a-071ed1e4949f@gmail.com>
X-ClientProxiedBy: BLAPR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:208:32e::15) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 977ea080-9d47-43f3-f9eb-08da270f1eee
X-MS-TrafficTypeDiagnostic: CH0PR12MB5297:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5297EFBC7A61FF865020C971C2F89@CH0PR12MB5297.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4JDd/GIu5ngPE1t+v4Cm6dDfhwfu6oyTR5A+vVFsP+DSLk0wBTtmJdWlvABsiRfbirGEn788tzgm/r62laPfNAFA14RSr3XoLRq7e5tZ7kmdVrl6dZS2g8sGXgVGLV2SYKMcQQAxoJHy9xXo5I+Ox48X49pJt6s8zOVQc3A4e1UwYggVBTXZ67AwCaLKW9ZCQXxC1xVwq8rTf/UqOZ5hOKL30MClrYVlM5IxzxVT0Bfa/Ao3bpOH4TifZ2NHo9v3p5vsKOEJxa9BfdftdYK184fcZXEYTnZuI5oR76rj8X/BT+mIpG9V/UGM806do3+JWZmrhSUsnM7f+TpGBK569FzkZCXFB5Hum/V2BHzlkHg3h5WSMKPs3wscVkPw+Sohz+1QAVkHwtjFKTV1+Se+mce16nnYXZrot3GsTDAYXcEaJ8YmPAN7oY+aM8xRIUmVo8tmnosODsitgXdc/O+bpenr4/MmMsOn4UWRLWPl84v4hj9F9kEpih4z6MSt/JXhjwsK/fbB1/HsfdhIU20tPw3c/l8MWoGj50eOmjXFdeoumpMXg3MHHRE8cjpnlPVSo28k2EEDeGKi8T+yhqnUwmNEwH4hDGWHgzt59yysW5MwPotPuApSNWqbWEWRZnUTu5X1lwisdSNsaLmFO+KEow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(36756003)(83380400001)(26005)(4326008)(5660300002)(54906003)(316002)(6916009)(38100700002)(186003)(66476007)(53546011)(8676002)(66946007)(6486002)(1076003)(2906002)(6506007)(508600001)(66556008)(8936002)(2616005)(33656002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTRZa3RnR01XS0NXeUo4eG5VR0M5c283RVlJRERIYnNPSHRSdUtvZjd2QmNo?=
 =?utf-8?B?cVgzcVYvWWpBU1ZaSEU2WmgwZEptaXRnYWR0WXlmUS9GNFNIdVJmOGlzcGFQ?=
 =?utf-8?B?eFB0VnVETElLY1FUbmE3SG83NmdKS29aVjIxZmNjVS9NbHF0Z2dMQ1pyb0p0?=
 =?utf-8?B?cnk4ZWdtNml5ZGJZME5nU0s3T0I5SFhQdnhiQXQ5U2VtZmVFQS9ELzU2UU1l?=
 =?utf-8?B?OUFnem9uV0kvRXdPcDF2RWQyU2hSdkNtQUtpMUhtZXRUenlaVWcxaWRtUGZn?=
 =?utf-8?B?VVBUdmxFaUowTU9OR1B4MnlIWmJLVk5Kc1NtSEhCd29JcmZXenRZT0xmNzhv?=
 =?utf-8?B?OUhSNkYrUEZpQklUM2EyS3VrWENhMzA5enJxMXREVFBiTUpsOWxtR1ZsVml3?=
 =?utf-8?B?djR6OFVSOXR5ZzZaNFFwaUZPc1dPenFmNDI1RFdrbDZBT1hicm5EOTRLS3N1?=
 =?utf-8?B?T0NVNnFiNkM4UmxQV2xpYVpVdFIrUDFrZ1hBU2FzQXEvMXBaTHdDdHB5dHIx?=
 =?utf-8?B?QzhKM0xwWGRCRm1ZbjJjZDZJZjRCL0U5VUNhRmtCQ09XRnptWVJKSUx1MnBF?=
 =?utf-8?B?ZDJSc3ZsWS8yaWlwaGY1T1hNek8zZ3gxQlRPendRWHNCMWxNU3M0T0Fwd2d0?=
 =?utf-8?B?eGZ0cTg4ckJXT1pTK05Ua0pyK2d2ZVZSL1dMZGdGWUVjcENVRFI3ZVVQbDc1?=
 =?utf-8?B?d1oxVmpuUWp2OWdVT2pkTVhueXBOK2Zwb09qRDZubHRkeCt1QTNSZlFhS3RC?=
 =?utf-8?B?eUpUUFNBaEhhWW5HZktxTkNWaS9mNDBLdHRjMkRzbDg4SUx5T3dCRkoxNldP?=
 =?utf-8?B?TUQxdXVJNjFUR1BDTXpmVC82d1MrSkZuVU8zVlpjbHNwK2FQeTVvY0FFdGdq?=
 =?utf-8?B?RTViVzBES0RoMG5MZWIzWDMwV3RRUHJUdFpzQUh3dVlhV3VkSDlHQmNSWU8w?=
 =?utf-8?B?dzhqd1U2eGEwT1BsTy9rbCttbDlDTGk3VVdkcWRUbVgxOHY0cm5lSUkyWnA3?=
 =?utf-8?B?TmN1Sk5Pb2FzZm9VT0ZTbDZwWkVDVE1iazV4S0dBQVZFTWRyclNaZEFuQ1I5?=
 =?utf-8?B?c0JsY2ZBcDErQWJhRHNKOFlpMFkzTHJvTUJTeWJBazkwYkczTHl6QWVqKzhh?=
 =?utf-8?B?K2lIVUtkbDdRNkRXcmtEeUlneFRFOVd4blZwSTJzeXV4TTJ2blYrMjhrSVh5?=
 =?utf-8?B?RWJRQXVmV3pnaC9TczNqOTI5SUJFK2hoY1d0bUpFWlFxaDFiK2tPZjh5T1R6?=
 =?utf-8?B?UUZRQ0ltOFVhUUNEQnB4aHVHaG56YUFpWHhKZ3BxdU4xVXZnN3ptZHFMelQ0?=
 =?utf-8?B?RnBlOEN3eXBpYk0reU41UmtBTUdzZFpmQkN5bTh0ME5za0FBek43blVrMElN?=
 =?utf-8?B?RDFUV1NnMUtSNHZFK0QxNnl5NXlkWVBVckVkWi9qSTlJMitvRUlKK3kyd0ZB?=
 =?utf-8?B?YVFqajFIMGQzRlZwYkQwYXVuektBTEtNT3QxWHAzeGFXenZHZUR6dGtKMWt3?=
 =?utf-8?B?T09BZnV3OU9RdDFWbmVUa3FzSnJ4OVNGcTkxbDVLRFpSWW1nY1ZpbXhGNlBG?=
 =?utf-8?B?cm81eXdtOUVlQWhyZFlMbVRiNzVzckhOeFNhaFBZdUM1dXZZeDBnaEQzb0tP?=
 =?utf-8?B?bFR2bkN0TkdiTkwxNktNNVlzTnZVUnEyeVhmM20xUmJ1eW5VcTBJWVV1TkVT?=
 =?utf-8?B?ekI4OXJqRUZGR1MyUVA1UDdLb2VYTlQ4Z1k1TGhmdTNYSHNzRzFpd1lFOTBy?=
 =?utf-8?B?cmlsTlBqMHlVZEJiOFd1ekNmaFBkZXlRbjJ2dUxhTktrL3h4VG5ISmZqUVZ2?=
 =?utf-8?B?V1llb21PeUFTWTFaa0swSUpFOGpNQVdZRngxU3VyQUdwTzVPcW9GYnJQcGU0?=
 =?utf-8?B?ZkRMTmlEdHBibDN4WW03KzV0c0ZJQUU2N0xQL05xeWJadUZxbjFxbTdOaEZ1?=
 =?utf-8?B?VlZPQ1BKSEIrRWNTY1ZKSEsxZXQvQW4wZWx1dCs4MUhSWHk4cDZxRkMrMG84?=
 =?utf-8?B?ZWdpUmZpZndBYWwzRytDY2IzZkNIUHY2QXZ4bUJHOTkvQytHWWFRT0hKMEFr?=
 =?utf-8?B?Mld4akVKRVlNdTcwZFRmRGlKS1JRT1dtdmM0RS9ZM214UWprN0loWFJNcmJO?=
 =?utf-8?B?U3M1Q0ordUcxZzhscU9FTEhsdURUMm8rdUJMRXRCemh6cDBVMTJoYVcxUUU3?=
 =?utf-8?B?NEovT1F1cXRjSGtrWmZIejZDenJ2MDEyVlcxU1MxY1hVZHFacldjQkdxOGhC?=
 =?utf-8?B?WkdwUm5uaGg1L0ZRM0RzUHRQSGNsaFNxNHhrS2J3cVVnQlFnNmlWRzJWVlFv?=
 =?utf-8?B?N3pkR0ZpWmpRck9PTjdTSVdlRTA1amtpOHFIZFFxWUNmT2kwR2NlUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977ea080-9d47-43f3-f9eb-08da270f1eee
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 22:58:32.4410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjFBsj2fdQM9ZzBpYEz2Jw3Z93QtpGy9g1/tSgZCID9gWK6DxsNT0wfLLcngiPY8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5297
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 25, 2022 at 11:58:55AM -0500, Bob Pearson wrote:
> On 4/24/22 19:04, Yanjun Zhu wrote:
> > 在 2022/4/23 5:04, Bob Pearson 写道:
> >> Local operations in the rdma_rxe driver are not obviously idempotent. But, the
> >> RC retry mechanism backs up the send queue to the point of the wqe that is
> >> currently being acknowledged and re-walks the sq. Each send or write operation is
> >> retried with the exception that the first one is truncated by the packets already
> >> having been acknowledged. Each read and atomic operation is resent except that
> >> read data already received in the first wqe is not requested. But all the
> >> local operations are replayed. The problem is local invalidate which is destructive.
> >> For example
> > 
> > Is there any example or just your analysis?
> 
> I have a colleague at HPE who is testing Lustre/o2iblnd/rxe. They are testing over a
> highly reliable network so do not expect to see dropped or out of order packets. But they
> see multiple timeout flows. When working on rping a week ago I also saw lots of timeouts
> and verified that the timeout code in rxe has the behavior that when a new RC operation is
> sent the retry timer is modified to go off at jiffies + qp->timeout_jiffies but only if
> there is not a currently pending timer. Once set it is never cleared so it will fire
> typically a few msec later initiating a retry flow. If IO operations are frequent then
> there will be a timeout every few msec (about 20 times a second for typical timeout values.)
> o2iblnd uses fast reg MRs to write data to the target system and then local invalidate
> operations to invalidate the MR and then increments the key portion of the rkey and resets
> the map and then does a reg mr operation. Retry flows cause the local invalidate and reg MR
> operations to be re-executed over and over again. A single retry can cause a half a dozen
> invalidate operations to be run with various rkeys and they mostly fail because they don't
> match the current MR. This results in Lustre crashing.
> 
> Currently I am actually happy that the unneeded retries are happening because it makes
> testing the retry code a lot easier. But eventually it would be good to clear or reset the timer
> after the operation is completed which would greatly reduce the number of retries. Also
> it will be important to figure out how the IBA intended for local invalidates and reg MRs to
> work. The way they are now they cannot be successfully retried. Also marking them as done
> and skipping them in the retry sequence does not work. (It breaks some of the blktests test
> cases.)

local operations on a QP are not supposed to need retry because they
are not supposed to go on the network, so backing up the sq past its
current position should not re-execute any local operations until the
sq passes its actual head.

Or, stated differently, you have a head/tail pointer for local work
and a head/tail pointer for network work and the two track
independently within the defined ordering constraints.

Jason
