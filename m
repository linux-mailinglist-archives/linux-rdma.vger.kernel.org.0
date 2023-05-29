Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D613714683
	for <lists+linux-rdma@lfdr.de>; Mon, 29 May 2023 10:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjE2IrU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 May 2023 04:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjE2IrS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 May 2023 04:47:18 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E0BC2
        for <linux-rdma@vger.kernel.org>; Mon, 29 May 2023 01:46:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWA8JpSlQ8/WXGdIFuHIWFhEaaXeYwcdBSCBIhMvbD5XcU2WeXFir1v5Uw/Yz2N/iqJTfR2ULayZa8lSceu0+30QI7ZjyfkX3j33k1icZqo9XPbXqAZvlBdB9E/WFf7pRaYnZE9LAV6slXYtJozpPi9vn0Vm1Uv1AVu0h5dVP84PcSz/fB9gdOKHit3UdHf6sEHi8LKmSVyF7eHr3TjJNT9tl4MoTJQvqa7z6LXiydy2xcZ/ZiCIUjOhm48T4Yynp2c25HKJwI/DwwdHQpvdDz4dSNl9icOA4JdOLqKj1vvkVwz4WcgOigz33u+ogvQAJ4wvRNpLu2npbVdFdEmeBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAHwnZlOk+4WiM7G0rkkn5MtTvdIEIukllXDJ3rbKZk=;
 b=SkcNh2BvaK9oUc8h4o4b3WGVt4ZIzcA2bLag4iZ2qQ9IALif6JIKoZ/5nmcvikbJCnkPSz6zP5EbypFyz5yMl4A7sZ2q2bFbFkDYX1MiPvqFj59CKWFqckBw1t6a5Vgc4gmkyaETpL8SgpuBwyq6mBElUS3HNleOGIkzbTyI1yXKkHauMfIgbt5pDkPnvs/lc0QUySp8YGaXKwR3+FrPnSYBKPvNlXPgVZ4+LLqXZTsEfZ5y0R7N6GtXKgQ8e3/RE+PQuOAKktCkJmFK+9y+q7g9TKdY+A1Uc8msdvjl1DxjGhIrAZryvFNfwOYPsZLxCkr07OPmwP+iVnaK2gin9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAHwnZlOk+4WiM7G0rkkn5MtTvdIEIukllXDJ3rbKZk=;
 b=M+ejOOno22y7f6Aq/Y71O9y8WOX8mYRPbHwhez3lClt45Gbk8gEcqEK+C0Y2HhdvqFHSpWofhMCFy87eXcmZLIfbHgH9din0TfSudSHKfns/lW21WzgZNzGzjNl/zUp7YctpaYRW0piC3RxAMJJH7zOTFog/35nUrG/Q6+x4JoXCOV2jx5ZhKq3dCZq/Sh+Yuo3DRXZdojhRAMudYwT9SYYNEiS1EpWp6UbRVfBCs2bklDqucOZZu4vyKb+mE1x5LHAj+Z9e3W8Wwze8ZwnF2ijM98tOp8YrzI9QJJVfAFAbBsUjo1TZGE2D5eZt2TVfIs1mKoZkKGxSFkfAfppGYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) by
 SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Mon, 29 May
 2023 08:46:49 +0000
Received: from DM4PR12MB6592.namprd12.prod.outlook.com
 ([fe80::4bbc:9ecb:57d4:1c3c]) by DM4PR12MB6592.namprd12.prod.outlook.com
 ([fe80::4bbc:9ecb:57d4:1c3c%4]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 08:46:49 +0000
Message-ID: <eec66b91-d3b9-47d3-32db-cc38d4aff527@nvidia.com>
Date:   Mon, 29 May 2023 11:46:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: problems with test_mr_rereg_pd
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>, ido Kalir <idok@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <12981460-88f4-017e-be8e-f19d1dee142f@gmail.com>
From:   Edward Srouji <edwards@nvidia.com>
In-Reply-To: <12981460-88f4-017e-be8e-f19d1dee142f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::16) To DM4PR12MB6592.namprd12.prod.outlook.com
 (2603:10b6:8:8a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6592:EE_|SA1PR12MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e137c8-a8f0-401f-542c-08db60213e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: be8hsIpV4cYYCqbGziLWe4ao+v8dRIkUwRt5oLu2zRfepb4D25066KX8Dg8yDjPpYs4e02Diruyrdbh3m8HibT3aY4y/HpoS3kLzTO90LCCGIRVUwxHFxXpkSNcVwGUOMozWB0/3GvOVwvmujQJNAgReO65vtGVwZd3YsOWcu+3ofSUQfJ16D0ofelbazpoAHiEmBS/nzZ0+d5XKThuKju5vteMBk0YWoP4twKUa2hYghigeH4ZMqmv4LWTVSL2A7Zmp7t/hcQlS9sxLIIN1sJGB3ZQj2GRnbHbGFzhswP27//1vtZae+SkT1u7ruap+kCUjTIrY1knGA4ncB3mnex5j2eKXQQDspavjwFMkamY+T7RfeMBcKHQJDERHvD4cVppUENROhdqM9F8TH0cIP6qghdo7S7JS5vt/hOTC2kpv7lfa+LrR8fyXN6byQSj6ALPxAFm1343V4hVaZCLZoKpPuROu7L8e3eOd2BISdGqIoZSKmBxjc4Pww4PolMzPQNYtB4KZIu35YZKp3o4tJZ1yz2aG9tgkX1a9vAOM05aiX+d9mRDtY6tn/rJPBUgquj7RbYLRp8CIkuhbax7uQqU8V9XTQMqc0t8EVpdI+1gs2NVK+o3vxqj3q2kR4O4YJC9KEhXaReHG7kQvq/sA2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6592.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199021)(66556008)(66476007)(66946007)(5660300002)(41300700001)(6486002)(31686004)(8676002)(8936002)(478600001)(7116003)(86362001)(26005)(6666004)(316002)(6512007)(110136005)(31696002)(6506007)(53546011)(186003)(2616005)(83380400001)(2906002)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHp4MVpOdVhKVDZlcmdCMzVBRXNVbTJrMTFJYU5zZUtuOHdZZlJxdXFaaHJz?=
 =?utf-8?B?bmRsa01USEY0dmYwMWJNZVlkTlRqcmN3bDhuakVDTGVPcTlnY1VkemNETkxB?=
 =?utf-8?B?TktnZEk3S25VVVVBaE5aTmVhUVhTRzJFM00vQ2sweFozenNINVQ3OGVDdlJ5?=
 =?utf-8?B?L0ZuVTI2Nk0wcTlJNCtBek5PN05FNWJTZ2tqd1FzUE43QUhNeE1WSFhqVnlv?=
 =?utf-8?B?djV5S3A5RE9Ock5zcjk3S3JJdUpyVk1VcmN5VTJwOEoyazdYRVdjLytTQjhT?=
 =?utf-8?B?ZE5RNnhGZUJIQ0U1aktDc3NDOUVBQjFGbnptSFlBNXk4NEliRzdqTFQ0WWpR?=
 =?utf-8?B?ZGlPbGJEcWtkamZaRnA0eDcza3Ewd3RVZllTWHQwcmJVSU5Hd29WOFUwakNC?=
 =?utf-8?B?RjVlMlZGVUYzWUZ1WE9KdzhKbVd6Y1Z2NVhkbWozcjRJQmdNaTduR1h0UHhZ?=
 =?utf-8?B?ZXFkQU9lVGhjSUlYb2ZNSWVpZUQrbFlobUtLcEM3VkltaEpRV001TGVEeGFC?=
 =?utf-8?B?bkt1N1Rvc21LK0cwU2dZQkMvS2E0T2pmK0hhdTFzYkJFYmdJS3llaHhKemNN?=
 =?utf-8?B?YmV3YnU0L01QWThNa0x2SERaZFBoMUwvSjYzQkcvL3JZL01helhjc2xCcXFQ?=
 =?utf-8?B?RnBoZFhhQk1Ic2VqNktlZ1Vmc1RFbnRuZzgwOGY5eEZUQUdSZTZnMit4K3dQ?=
 =?utf-8?B?VkVQbjgvTzQ4aTdPZjBUQXN6RUtucDJjbHBScHV3OHZBeWMvcDdUcHVxU0dp?=
 =?utf-8?B?SHlVZ0xoVmczZWpNTUVCYy8yNitBOUNxNEM1TjI5c25mM2drQVBwZkw1MmtB?=
 =?utf-8?B?bG53d3hNcEhIYkFnTUNqUjhQT3dkR2s1Z29VdS9UQitDaWpzVW5iRFNDOGdk?=
 =?utf-8?B?TExSYXNZdGNjcC92RS9WTURiczgzcThQMjVQNm84OTNYYXh5MTlpcVRsRkVV?=
 =?utf-8?B?eVJpQnJLR09KN2tySUUvc0lRMG9NT2xOUk5FdVNrQ1ViUXVYdGdkV000RDl6?=
 =?utf-8?B?dStHS3dBSDVESHh6UE45Mmp1SFpScjdQckQxa2xFZEtaNytuWi83UU92Y3dF?=
 =?utf-8?B?Y3dWdGR0c09IOXl3SURCWDRUS0dwc2E1dUJjZDRIL21Qa3NQb29pUmpuK3Er?=
 =?utf-8?B?UXhqbm9sbUpQRkRNUmpIUzlPY1FLcC9POUxOK3kvZmpIenlOZHVjM1pVV3BQ?=
 =?utf-8?B?QzdvSzUySS9IeGJ3cnpvb01uMGJ0dHYyUGdVQ1BUTm0yVUdaa3Q0WSt0NVZK?=
 =?utf-8?B?UWtRNjN0Q1pINGZtVklrMnlqT0JndkVMTW9iN2xZRCt2VFdMbmJ2UVRFMWpn?=
 =?utf-8?B?RHI0QzVMSzFEM0g0VHA4b1prc1ZVVThhcGNBWmY1TEFEVytKTCtySk9DTTNJ?=
 =?utf-8?B?cUxyNTE1R0JOa3dkdFkvL3JKZVo0aVZiZUJsTE5VYThRK1NMVVpWWHhMTlVz?=
 =?utf-8?B?WWlMSEVhYXdMd3o3anB0WktqOXVpei8rOXpCdGRUNjFIN01sUTgyOXJucWdH?=
 =?utf-8?B?V1FlcWRvS3IrUWJKak9mS2RZZ3Jzb3p3MkdRRW13RWFjWnR0cXEvcTltUGhs?=
 =?utf-8?B?OEFxb0VZTERoMUNDcEE5OHlyN09mNnBIZVZvdkZQWlZ2L0NPV0ViVFRLeThm?=
 =?utf-8?B?T3ZNZUN3NG1RU1NlK1F6SEp0aS9xVS8yWnJLWldzRHlXb3JOc0tSeEVYMlli?=
 =?utf-8?B?bnljdkZLaG9UaXU3YVFIZmVpYUNNdEZlMWNkTUpGcUxDUmhJNWNUWVhyQVQ3?=
 =?utf-8?B?ZkpvODYrR2RNT0ozZWQzdzlVaTQ3d05PRWVnSXo0MjBjUXRyR0x0TDdyUkdn?=
 =?utf-8?B?YXpDRnR1bkxHRXZ2QmhaWWtvaTQ0WjVDeW55RmN1WEtDRGNLRmg3ZkFyUFp2?=
 =?utf-8?B?WS9EYk5iVzNHbGhPVFdkOTh6Y3Joam1ZV25mTm85VlhjZWtBVkRvcWdMUTh0?=
 =?utf-8?B?RWc4M0hINHZQNnZjamVYMUR5S0xHUDYzMkxhTEtNcHAvNTVmMWM1aHRQV05Y?=
 =?utf-8?B?dGNqbWZ0bVhqN1dMRnF3MWtlQ3FQVkZjN3ZPeUtweEVVQnhDMXZBODI3SjE1?=
 =?utf-8?B?L1V2OXhKUHFBOHVpck5kYjMvVFhOM2QweUFQTXNWTVIvMHNSV3YvU2poNUhm?=
 =?utf-8?Q?kS4eZafj/3/AxzLMqt15VdWh7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e137c8-a8f0-401f-542c-08db60213e11
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6592.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 08:46:49.7428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0Ep+72VMnKwtQ7MsJGYEAUIZmbHK9Sdf/zKZe9lvSvEeka7LZSUe9af7idyE5yQslJ3K/BXiG65prO+oIgwWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6680
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/25/2023 1:22 AM, Bob Pearson wrote:
> External email: Use caution opening links or attachments
>
>
> Edward, Ido,
>
> The test_mr_rereg_pd pyverbs test is failing for the rxe driver.

Does rxe even support rereg? This is what I get:

$ python3 tests/run_tests.py -v -k rereg_pd --dev rxe0 --gid 1
test_mr_rereg_pd (tests.test_mr.MRTest)
Test that cover rereg MR's PD with this flow: ... skipped 'Rereg MR is 
not supported (Failed to rereg MR: IBV_REREG_MR_ERR_CMD. Errno: 95, 
Operation not supported)'

(Your below suggested solution should be done anyway)

> I have figured out that the problem is that the following sequence
>
>      def test_mr_rereg_pd(self):
>          """
>          Test that cover rereg MR's PD with this flow:
>          Use MR with QP that was created with the same PD. Then rereg the MR's PD
>          and use the MR with the same QP, expect the traffic to fail with "remote
>          operation error". Restate the QP from ERR state, rereg the MR back
>          to its previous PD and use it again with the QP, verify that it now
>          succeeds.
>          """
>          self.create_players(MRRes)
>          u.traffic(**self.traffic_args)
>          server_new_pd = PD(self.server.ctx)
>          self.server.rereg_mr(flags=e.IBV_REREG_MR_CHANGE_PD, pd=server_new_pd)
>          with self.assertRaisesRegex(PyverbsRDMAError, 'Remote operation error'):
>              u.traffic(**self.traffic_args)
>          self.restate_qps()
>          self.server.rereg_mr(flags=e.IBV_REREG_MR_CHANGE_PD, pd=self.server.pd)
>          u.traffic(**self.traffic_args)
>          # Rereg the MR again with the new PD to cover
>          # destroying a PD with a re-registered MR.
>          self.server.rereg_mr(flags=e.IBV_REREG_MR_CHANGE_PD, pd=server_new_pd)
>
> Schedules 10 iterations of a UD send to UD receive with an invalid mr pd which does not
> match the qp pd. So it fails with a remote operation error on the first request.
> The remaining 9 send and receive work requests are flushed to the caller with a
> FLUSH_ERROR but not cleared out of the completion queues.
>
> This is required by the IBA for Class A responder errors ("Remote operational error").
> In C9-220 it requires:
>
>        All other WQEs on both queues, and all WQEs subse-
>        quently posted to either Queue, are completed with
>        the “Completed - Flushed in Error” status
>
> The final phase of the test wants to verify that after putting the original pd
> back into the mr traffic works OK. But the remaining FLUSH errors in the completion
> queues cause the test to fail.
>
> To make this test work you would have to clean the completion queues as part of
> restate_qps but that is not done.
>
> Bob
