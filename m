Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E52A4E8675
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Mar 2022 09:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiC0HS1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Mar 2022 03:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiC0HS0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 27 Mar 2022 03:18:26 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F33CE7
        for <linux-rdma@vger.kernel.org>; Sun, 27 Mar 2022 00:16:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUB34/LFwd74NMiF2wF4LPHZ0cdTYQYVv5AD+sX6AobGPB/6iGIFomNnfOYk8JgtTtfZSbGN+F9E0r/Fb5QOSBC2xrve3m2ORnJQYsZhAXxKdaHc06UHgUI4KjoCcPE2aIoNF+wUl9LTk1OfQErvUk6LGV8By8EuBywd4DoUThaUc6K/kvEBmQVb6D4pCoN3DNewyf3tOSxZypFQJPKIrfX55rMF7DTHhArhAESQ8ormZZdyl91CHo8iY3KqQbhMMEucDeN89A3qJ2VbQfAOlpdW5MZO90ZAXfdyWrjVDuaVYgFMGRopfeW4wxTM8/aQKu9FZyA9d7HWQ0gs+7iw1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImvoMeLy+iFAsvVI9LtNFz6SGmNuYYg0P04KHW8xSRI=;
 b=A4rIQs2hiKNO58LCSq79RDKKs+enSmBDnG4i0xVyWMPTRpcOtyz1GjTUN+TvXzrjbqjvcz+Xxtec+cR6gQ7UEbUcf/flRfshrWznjSMxDFV2z2Ln83JIP4mKPZrXmy8xmu7HI+u+6pZt+drPkLi290oHE09fqrug0qgBqLaL6E5jqTmglHEGHXj5xzBJArVJRgmksN0IhqHlktSD/Kgi4VACSOvZbtgCCPSn5ryBbQVKK3yMmf/K+OU0UWsaqC59NO4NYRrBs/faeG0yOpFMyJ9KzQr4hDEer2Futx1sEqANl2Q4p/3RYzZBxaYyz1vaMBe0TinYCQSXeedoiaseuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImvoMeLy+iFAsvVI9LtNFz6SGmNuYYg0P04KHW8xSRI=;
 b=NR5EHcgfRVFdJztvUfIaFsiJfWF1JIF7sJ5F3yharZaRtjF3YktB07cZRG16k2P0a9IqAr/7U4zxvpykKKv3ymyxRNyBmVnidpmGXNudG8wR5YQaLCEoKuguXy20lcTymz+Ea34os4XbjD1nOWENhNE4aX5iN7VP46NpcEyDyUayuQ5LwxGrBUgVb91HyjUYJBTBPe7POXYmRK6J1e1H91vEMKPEoMsTVxNLQnVFEnL7TpowrcQw5IpXswW2r+Wp8N3XwSm3IHPA40Sa4bBfrL8VJ7uP0jr/mQkIs4hiJcw4DPLVJlXt880AILixylk3LexPmhGyNl3fkRi37UnLcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4227.namprd12.prod.outlook.com (2603:10b6:a03:206::21)
 by DM6PR12MB3322.namprd12.prod.outlook.com (2603:10b6:5:119::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Sun, 27 Mar
 2022 07:16:47 +0000
Received: from BY5PR12MB4227.namprd12.prod.outlook.com
 ([fe80::b1e5:ec1a:8859:e330]) by BY5PR12MB4227.namprd12.prod.outlook.com
 ([fe80::b1e5:ec1a:8859:e330%4]) with mapi id 15.20.5102.022; Sun, 27 Mar 2022
 07:16:46 +0000
Message-ID: <24582406-de0f-994b-f258-ca8e375adeb5@nvidia.com>
Date:   Sun, 27 Mar 2022 10:16:39 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] MAINTAINERS: Add Leon Romanovsky to RDMA maintainers
Content-Language: en-US
To:     Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
References: <0-v1-64175bea3d24+13436-leon_maint_jgg@nvidia.com>
 <YjzL1CthgBQaXfCb@unreal>
From:   Gal Pressman <gal@nvidia.com>
In-Reply-To: <YjzL1CthgBQaXfCb@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR1001CA0024.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:2::37) To BY5PR12MB4227.namprd12.prod.outlook.com
 (2603:10b6:a03:206::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4464b53-39e5-4163-8375-08da0fc1c082
X-MS-TrafficTypeDiagnostic: DM6PR12MB3322:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3322C0A384D5E2B0AD6B0266C21C9@DM6PR12MB3322.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2s+SUeRaaJNjjBt7FEwSyBpCEPffQidx2n5I4/vxyldswsZFpK038EbvWpqAn9bE1xD1UeD/MZcoMQ4KuFX1uWsRiOfz72vMrIPF6QTr8AQgOomfrz6pS01dtCn5LrtWmkrva63yu5MISQKFd4bI1fn8JZ2rfi4EKC8al4duPgip3vwinc/p90Xdn/yOr39oLXzrs+aWKgKbQlqtCYA/SVmE4IY8/HZxE3CmfkseZMPXQpSFADYZC02A76PNGyEEIAkbN+U0HeUCTs5lN0cxwTx86yRQzSOMusPCJol4d0HscBW00VUS5JbR3Gs+n1JBg3Is9nmcVgR457MvBe+RtE16HUS5y69VI9s7fPEojzyk/X2xXHuM4wScfcVI0OPhn8Pw/k+c8k19AuT3ainGYmPESWCN9bNqpK2ppYm77V0ZITPSsGwc874EUUhmZRg4FGvI4s5ZToZ0Jz+WJpJEVasUfKfpgkJxeoOlq8YjUmxHbipL6y2LHuhSlOAonW56ez70t0mottCc1AMaTuoOaRFGV7mXpJN1LtUIScGEDWLT83pLTDhUuAnyl8j/V0Z1if5iqzRy5nS0cABPI5PY+krLcdPgQS7eDZXbjO7To9EEmia6bAFDoGsmmZrq1FDs7/0Q4fN3FEmS0QOToJ2mQ3WeT0BD6aMcOaWDq050Nb+lD77fUqUKCgVC+b+nhvCcr3CRcOG0o1WY68JtFMM2gdGsPf2xroxea3pEgmP/C7s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4227.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66556008)(86362001)(66476007)(31696002)(5660300002)(36756003)(2906002)(83380400001)(508600001)(8676002)(4744005)(31686004)(8936002)(53546011)(110136005)(6506007)(4326008)(6666004)(2616005)(6636002)(38100700002)(6486002)(26005)(6512007)(186003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm5ZZ1lyeWI2UGJPalF6eC81SnFtMXpDSzRqNzVGZTEzNlJZSjF3ZmRYZnYv?=
 =?utf-8?B?OGcyRjI3SnBRRzErb1k3VzYxWEhDUlJ5UWVtRnliUEI1aTRSWHZQWFFicjAy?=
 =?utf-8?B?akcwSmg4SzNOa3JMSWh1MEtNTHJWdHpXV0dtd1Jkd0g2VXVSM1lkUjB5QUJx?=
 =?utf-8?B?ZVpsdVFvVGhFSnoybkxxU20zTHhzZTY2TEFMbFZvUU9ibEl2c3NhTVdUU1Bo?=
 =?utf-8?B?c3ZWcUlsOGdWdWgwUjVTOU5KNy9kcForaU9McndDaWh5dy9Tbm9IdkJERnVD?=
 =?utf-8?B?c1dvejNoZVZGRU00OHRLay9lbXFqRGFWdm1XT1RPbmc2Z3d2enlzaDVaNkhP?=
 =?utf-8?B?d081dHhCWGhRNUhtS2c5bUZTVTFna3V3ZERtMlh1cGVSdWtSc3haR0tGS1Fi?=
 =?utf-8?B?ZHNTRU82OTREb01OMWpNRUxOdjAwVlpQTUkyL3BvWlJnLzhiQ2xhdEEvbDFu?=
 =?utf-8?B?UFRIbXJtSnBxcU14RmRxMU1pWE9JT1NwSDJsZFUvNGpmdDZBL3dwUm9BOXpy?=
 =?utf-8?B?L3lBalNweVZqNjJ2RXh4TUFpSkE1S0NnSlRTRVEremc5cW9YUERvVmVUV25p?=
 =?utf-8?B?SUprK1BzU3VBREJmS1RIcDF5TDhnQWNjY0JqUHlmVThicXJUekdNVE5oaWJH?=
 =?utf-8?B?V0NjNFlNZ2dJdG9Wdk45bzlDVGcreTBEcEVBNVR1MFZVeG1DRE1wSXlxdXh4?=
 =?utf-8?B?bGF4cGhjSDNudzhaMDVOWmhLVWFpWGVhUW12VHIzdmxFNXVab2t4dUFJdWR2?=
 =?utf-8?B?U3p1VXFxZW92U05RWEVGU3BHRitrZlZrUk9seU01ak1BT1dDYXB0WWc5UHk4?=
 =?utf-8?B?dXNWY1daMzV1eklYRFRhT0JNdnR0d0d0bW5QNitSSGltVUxYa1l6aGFCVnpr?=
 =?utf-8?B?cU9LcHNoM3dWNGlFWUUwbGViWDlXMFUzcVkrWnF3dVRmbXdaTzFvRzArQVU2?=
 =?utf-8?B?dzRnQzJFcHJqNUJ5eHR3d0U4b3RVL2NMa2hZMVptOG5UVHlpSmtwam0vbjB3?=
 =?utf-8?B?cXdYMVhqS3pDNVk2NmR3Z1BNazkzWlJ4K0J6eU4rejh5cU1XNXMyZEtpZGJX?=
 =?utf-8?B?TlpRdjFSV0J4SGRlN2ZhRU5CNXBNczQvZGx4MFUvNkE0L3ZIR3JtZnlaQTEy?=
 =?utf-8?B?YlZiQi8yRHBvOWEwdDNFaWVKVW1xeC9KQzRzTW5pOU1DNHpLNVMxbFNnaHFx?=
 =?utf-8?B?L1NaemJlYTl5YjBNK3JmamE3MEpTYjlOeDVtSFR0Y1piMDh3eUFobWNHYkhn?=
 =?utf-8?B?RnZDQlphOUxJcmNKUm9aaE9HVUxqYm0zSUV4U3d3aHJieVI3TGVZUzcxRXFY?=
 =?utf-8?B?OVh2QWRqWVc1M3p4ZnB2K0JJSlZQanBraUNqdG1SZFBqNzBidkRncG9kbkM1?=
 =?utf-8?B?clgwQ1R0RVFDbU1VSStkOS9XdUZkYTZTQ2l2aGd4ckMwbXdUZU94VU80MGFY?=
 =?utf-8?B?UG85b1NRdDAxNGVGMEZvcEtwVWV6R0dzVWdBdlJSdmpIZDBpbGtrcmZtaWMw?=
 =?utf-8?B?Y2wyN2dwSUlBWU1uSXdBc2pTMEF2Y3BadXU5eWNvUTFGajI0VTd6ZWRNOW9r?=
 =?utf-8?B?UWxtWW9qcU56STVLa2luc3NLazNPU2hOMm5HcWsyVFJQZERvZFkxc20wNHFF?=
 =?utf-8?B?b0VacG5pdlUzSy9GekhpQm03aDgzdVVNZTIxRTlTTExEYUlWb2dmWjlEbW0y?=
 =?utf-8?B?SVJXSkNmTjlPaHVzMk9sK2tFa2RwdXhYcjJvdEcwNnFEOHl3b241Tjl6VE15?=
 =?utf-8?B?UmZvdEcxdVBDTGFWOVlmODBHbnhvU0w0QnVuWHNGc1hyWlJiV3lNRERiWHUr?=
 =?utf-8?B?eVpyQzRGRDRQdXpHTTVvVkpicWRrdDFVTjB1bG5sLzd4dFRpWi8yQ08yR1NJ?=
 =?utf-8?B?K3k4WFVrVUkwUU1JWU5YQ2lHd3YyM04rWVgzM1J3VjNHVTdzUDRpWFN5cmRw?=
 =?utf-8?B?K3Y4bi94V3ZoaXVmSXBSMWdRQUpITGo5SkFJSUthUnQyN0E5am5RclRyTXJH?=
 =?utf-8?B?Q2NWNTV6aWxxVnhyNGQ0eDZwcUxhN3RDa1BpRkZjZ3M4VHpFQUFua0RGbisx?=
 =?utf-8?B?TWorZFFiWmlUV3BPMTN3Vklkb204VFFmVFc0Tm11UU5oUDVUVWlIMHhLTmFr?=
 =?utf-8?B?TFllN0NlVUZNSUtUSFdNeXF0NGxFcG5MS0RrQjdyMVV6Uk1sQ1Nka1hKRmVl?=
 =?utf-8?B?a3M4MVlLSEl2VHRZSk1oTm41NEVocXVyajNxaDI1dWkwd3h0cGR6R2pma2R3?=
 =?utf-8?B?YkExTnM2UkRVc2N0Mkc2eVBFd1NsVFdVZEowV3F5T2gxS1llUUtoYTYyVUxo?=
 =?utf-8?B?NG9hUURGRVhkY0JrdjA2cGR6Tmg5eXlDV3dtMzA3UzRvMXVCcXVDZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4464b53-39e5-4163-8375-08da0fc1c082
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4227.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2022 07:16:46.3459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /61o44qWHNBerK3rA/oPlJA032+6kDftL/4tEIrZD63/+8OtrrQgWmNs0wujkPDo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3322
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 24/03/2022 21:51, Leon Romanovsky wrote:
> On Thu, Mar 24, 2022 at 02:53:19PM -0300, Jason Gunthorpe wrote:
>> Welcome Leon to the maintainer list so we continue to have two people on a
>> medium sized subsystem.
>>
>> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
> Thanks a lot.

Congrats Leon, good luck!
