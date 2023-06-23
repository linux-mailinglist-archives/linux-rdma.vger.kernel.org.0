Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F2973BE94
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jun 2023 20:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjFWSqV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jun 2023 14:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjFWSqU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Jun 2023 14:46:20 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18304186
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jun 2023 11:46:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVyYAuEdrJNXfnz2PBn3r+HBTGwy+JEj6zo0hTweR3QjbT48/SMdxEWT1wlCnQ6ZkGyoiO0be33dySXpy5saInpoRwW9SZxZ9icK7zJodTbjmyuJ6MmXDhiXGtuOKjYDIjnYcnLZ0EKtq68qR1NffcmPdTXZ8u5D6vz0fOhovh3YWVxTQk6R59mcTe7vUu+3C0nsU4mmKkE6ZyffInnaNXyjkBVHZJF0dIGZNURF43El0FrxkFXyP8dTpjRU+b/SqLko8UwBnvyH2oYOXBEjHjPG/EWp5wrsg60DXBK+wh8NAKWrPs8OLhoD5w07PBxeP/xrsHiBjMjeDNvCyGyWXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94iiARTrBZQKdmJvL7QW+/uek5zM6XIRmw0E7hWWo+8=;
 b=Yk92bIlMdKO+U10ZIDJ/1FDSSJoly5OQODE1SVWzhkg6VaQMIDA2irRe238kMFGJpB3Aw8fKUQLeMo0CS7eai6jommPWrEta1aiiguA2033ddCyT0Fwmqa2ax9k+JAxUGURK3a3K2txnylLLU9SMVWUPAH1UGJCKAZl659sjD7vb1SMtcXENsCBWwhiFbg0ULo5fYeDRJNDlL1Skc5yVPMiQj2xPz0sB2q713OCfDgB5tDBmXLMIP/kEodE7TJZKHtjJ2XLzwu77HmtImdqA9xsoG7h4+lKEyLdEmU4HIKSrAzzB2JWrizWaSvhc2PUPBvRJAlp3voRJTuA8Ks2nFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 SA0PR01MB6361.prod.exchangelabs.com (2603:10b6:806:e3::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Fri, 23 Jun 2023 18:46:15 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 18:46:15 +0000
Message-ID: <32cdb266-67b5-24db-68e2-137e2401ce6e@talpey.com>
Date:   Fri, 23 Jun 2023 14:46:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/4] RDMA/core: Set gid_attr.ndev for iWARP devices
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "BMT@zurich.ibm.com" <BMT@zurich.ibm.com>
References: <168675101993.2279.4985978457935843722.stgit@manet.1015granger.net>
 <168675124698.2279.15699248221119454150.stgit@manet.1015granger.net>
 <496bdd0c-a214-b9e8-86d8-2f5c5eea0db4@talpey.com>
 <EE9BB6BB-E5B7-4D49-92CF-D769E54A0C32@oracle.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <EE9BB6BB-E5B7-4D49-92CF-D769E54A0C32@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P193CA0059.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::36) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|SA0PR01MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: c6be15be-cc8a-4070-8607-08db741a1fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fK0hwarFR+PpXwoM+I7w1qSkUAYptyYsP5dGEmrCjUzJuXjMUDNr83IPOkv6tAP34UBLwq7C6uoDTgOZot0hrfjjEuIew6zcjb0xZtDQGwkOGFtSJ9LujV6OoVIqY0xjdg4A+lbKdvzM2mxfay91ru8ipZRinZAJbAeKkJhgaYemkmGuK/7ritznOlD5hFs+qlCCV1YKNRkZADthlMOCwhiQ4Whf2iRLEuvpUVleifXqfeH1NU36a8WlAyckTAspHpni3QU7cOMibjgGyPTid4yt3Oh7SMJKxZ/P6tbWyo3y1a4Omi+Fa0DwnirrK7DBAbRSMKDPE7RHK9MEUGwrliQ0ByI3lEh2He14PX2QREA4xr4+F4BYUPpkJ8pQWO/GCFppjUPyN7Ar2gfFt09Bj4fbhnwL7bMp8HSyvesFSze+skGEkBjbJ/fA8utxkF9EUz4mspvf0wKBf59ays1GeO/7uP1IuIJDBQEzenguPVk+8FhADaGTYqX5vfm6OqeoxzBPSHxliPHDzkwlW/ai67kVCMt6d/2moGxvw6tpIteGLDFbjKvJy/QQlu0qT4ZvBcxK5uruYgDsn49JVrgxRqpETufb+qTBvuoEuTbFPHfJnNlLG+d9paKEWmhP/k38Bk10+AwYzFosLRvOzkmt1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(346002)(39840400004)(136003)(451199021)(31686004)(6666004)(478600001)(54906003)(6486002)(2616005)(83380400001)(86362001)(31696002)(36756003)(66946007)(2906002)(6506007)(26005)(52116002)(6512007)(53546011)(38350700002)(186003)(41300700001)(316002)(66556008)(66476007)(8936002)(6916009)(38100700002)(8676002)(5660300002)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmpPMWF4ZjJxYjMzOElJRkROeHd3QUVIMFhjYWpENjlUWkpaRk5FV0ttZW5P?=
 =?utf-8?B?c01kMXo3WTVXU2hXRlhieGJ3RVhFTkEwbFU4ZndQTDNuSC9sZHhGR0FkM3B0?=
 =?utf-8?B?Tk82UUNJOWhKSUEwN2VSUy9ET1FVMVVmVHZiaUl6RklMdlNQRmdqbG84THYv?=
 =?utf-8?B?a245bFFyVG8zbHVFWTFZcUNXQ3VrYUFFUnN2V3pBNTJzVVhuR2dnMjZhNXNz?=
 =?utf-8?B?N05WOGQ1Rm1UYXF2TnpKTlNSV0doQnUvd0pjL2RlcDlZQmZSV0FQOFB5cHJo?=
 =?utf-8?B?VEZ5d3BOK2hab2RJTjNrTUNCYklOVjhGVlhHbjZFdnhpNTBENEtiT0FtQi9L?=
 =?utf-8?B?UEJvYXlnZkFCN0lvRm9NZDdkUkRxMXlnSzRXUjArei80aS8yRWJsQUw1UEJT?=
 =?utf-8?B?RnBsK2g0a1hCdnVWYUhWS213R3hQRFl1Ni81bnhFazBBQjhyd1IvYUU5cndu?=
 =?utf-8?B?dG5PSXRrdy9jS0xXSjFQVDdhNHN4bGRnRzlIQnY4dWhSc1hYUUwrZ2tETktn?=
 =?utf-8?B?Zy92MEVYQzlGUy9CbVA5Nk5IaHc0bE9zR3dMcmdUN0xkVkt2WWhTUHNWRnNM?=
 =?utf-8?B?V1d2clNBM3RaOTV4c0ZSK1NvS3QwSytMY2NHQlVITG1uWkJQZHgzMFhOZFhO?=
 =?utf-8?B?NUF6a0NwV1JQeU1ZU09nOUVMTEEwMFpKWW1RR05WWkRoQ1lLRkZ5dHg4TlFt?=
 =?utf-8?B?d1VRVytlOTh5WVpIUFJYTC96NFUrRDBObXVWL1BYeTlsM1RlU2NCNGVLYzZB?=
 =?utf-8?B?bThLL1VSR3UreEtiM1M3ZVpZdmRwV3Fhc0NxWk1UZG96RFQxclJSRytlSGd2?=
 =?utf-8?B?QTYxeDZlNTJNU0F1UnRGcDBTYjFLOWZpOURqSjRwenczajFLbmxkd0Vuc1Nt?=
 =?utf-8?B?akN2bGp6cGFnT2xxWlEvNVp3TzEvakNlUHcrTGhSNWwyZ2hnV0VOY1BnZHgy?=
 =?utf-8?B?S2UyQitIejA0Q1BtSkZIQ1pkbDZKUkpKSlFreXRvRUZRWUM0Y0FWbFBHalpu?=
 =?utf-8?B?K1ZaQzN4Yld5a3lhZ0MzVVFsWHNBbkJMZi9CcWo2QnVZMzVydFhZOUdsZTJj?=
 =?utf-8?B?a2pCMFNlZ2tlNzlmUGNLMS9sK2xBSjVNU1ZGbGtzSE1FT3VPSmhCODViNDVh?=
 =?utf-8?B?akpaMXF4UXV4SHV3a0pnSTJvd2JTcG5OcnBBVFZYakxpQlhSRWFRYXcvV3My?=
 =?utf-8?B?Z0ZzemhGTUs2YUUyVnk2aUZHR2c5ay95azBCMG5ZQW9HWjVwT2V6dm9tU25C?=
 =?utf-8?B?VEdNMzdWZnlzVUMrSTJUN0Rsd2tPeDJwWi9kdzdibXoweUpFQ2NUZFgrTFJk?=
 =?utf-8?B?aGcrcU5OVnhIVnU4ZFVmMzJaL3RiVDdLekdiMS9zWWJKdmtWZkdIQmNJbVF6?=
 =?utf-8?B?c0k5WDJtdk9SeWdsRDdQVmkxejQ0ZTNGR2UySFlBVTBCUCtBUFNCOEJFVTdQ?=
 =?utf-8?B?eUJDdXBNRVpSZDVOVG5mcEFrOWFyNFFoTDFJZ29DQXZ6SjBxclFEUld3d2F0?=
 =?utf-8?B?czNnTHY2RktwcTlNNTBRSDB2NkQrVGFSdGM5UGVHMTh2b1lsenNwSS9ncHBX?=
 =?utf-8?B?NUhTeWpGTnkwWGh3ODNXbEdpNTlRWktZdzdXVVRibmVtYlhibEw0dGtCZXJU?=
 =?utf-8?B?bVlUc1N5c0NCWmp0TTB1ald0MVpkSy9GVVRNQXNZeHVmdmZldDkxZkU4b3dV?=
 =?utf-8?B?dUY2RDA1YTFkbzd0aXArT0gwSWxVQ21CeXdHOXhFTzkrN1M4dkIzN1VDZ2pi?=
 =?utf-8?B?eFhoN2VHc1JZbU1GZTJBdmsxZTJ5T2lxTDZwMmMvQW1CcVIvUmxqN2Iyd08y?=
 =?utf-8?B?N3hRODVwdldkc2Flb0RTZU5uaHNNZUx3OEY0MVVnSU5VY2JJVU41RUdIS2Jo?=
 =?utf-8?B?bFY5NFpCNlVBTVVYeGpqWXdKL2JFb3F5SDczK2xaTlRHek9ZNGtPMndUbmpM?=
 =?utf-8?B?cmVHK3RSN3FLdi9kTWhwbkEwQlFuVkttM3lmZmhKTkRNeFBQeTlGa0dwVkhZ?=
 =?utf-8?B?anh1Ynp2aFVuakJ0Y1l1TzkwUDY2ZUY2S0NGRFRjYU0vaWtFZlRUYVdtbVlG?=
 =?utf-8?B?MlhvR05FeHN6WjVjcFZ1akZIVVpCNHhkM084MDgwSkU3QmF0a1VsK3dFc1hU?=
 =?utf-8?Q?XcPNGUyhh8dPouChUGZbEWJXq?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6be15be-cc8a-4070-8607-08db741a1fdc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 18:46:15.7810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: viaBtDtgs88BP4vkquvTM7XdAWYKIgt6QG/tGUwk1ATQ/cRvlZaO4XgiydOAMf7k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6361
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/23/2023 2:40 PM, Chuck Lever III wrote:
> 
> 
>> On Jun 23, 2023, at 2:37 PM, Tom Talpey <tom@talpey.com> wrote:
>>
>> On 6/14/2023 10:00 AM, Chuck Lever wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>> Have the iwarp side properly set the ndev in the device's sgid_attrs
>>> so that address resolution can treat it more like a RoCE device.
>>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>>   drivers/infiniband/core/cache.c |   12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
>>> index 2e91d8879326..717524fe8a39 100644
>>> --- a/drivers/infiniband/core/cache.c
>>> +++ b/drivers/infiniband/core/cache.c
>>> @@ -1439,6 +1439,7 @@ static int config_non_roce_gid_cache(struct ib_device *device,
>>>   {
>>>    struct ib_gid_attr gid_attr = {};
>>>    struct ib_gid_table *table;
>>> + struct net_device *ndev;
>>>    int ret = 0;
>>>    int i;
>>>   @@ -1457,10 +1458,21 @@ static int config_non_roce_gid_cache(struct ib_device *device,
>>>     i);
>>>    goto err;
>>>    }
>>> +
>>> + ndev = NULL;
>>> + if (rdma_protocol_iwarp(device, port)) {
>>> + ndev = ib_device_get_netdev(device, port);
>>> + if (!ndev)
>>> + continue;
>>> + RCU_INIT_POINTER(gid_attr.ndev, ndev);
>>> + }
>>> +
>>>    gid_attr.index = i;
>>>    tprops->subnet_prefix =
>>>    be64_to_cpu(gid_attr.gid.global.subnet_prefix);
>>>    add_modify_gid(table, &gid_attr);
>>> +
>>> + dev_put(ndev);
>>
>> I'm not sure about two things here...
>>
>> 1) is it correct to dev_put(ndev) when returning? It seems that this
>> may risk the device may vanish when it's still present in the cache.
>> Feel free to tell me I'm confused.
> 
> ib_device_get_netdev() increments the ndev's reference count
> before returning. dev_put() releases that reference.
> 
> 
>> 2) Assuming yes, shouldn't the dev_put(ndev) move to within the new
>> if(iwarp) block just above?
> 
> If the "if (iwarp)" block isn't taken, then ndev is NULL and that
> makes the dev_put() a no-op.

I still think it would be clearer and less side-effect sensitive to
put the call inside the if(iwarp) block.

Thanks for the dev_put clarification.

Reviewed-by: Tom Talpey <tom@talpey.com>

> 
> 
>> Tom.
>>
>>>    }
>>>   err:
>>>    mutex_unlock(&table->lock);
> 
> 
> --
> Chuck Lever
> 
> 
> 
