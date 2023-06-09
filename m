Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62B872A4FB
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jun 2023 22:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjFIUt7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jun 2023 16:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbjFIUt5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Jun 2023 16:49:57 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D62E2D7C
        for <linux-rdma@vger.kernel.org>; Fri,  9 Jun 2023 13:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2iDxfSzf4K2pW+ZqmhN7oGBHd05ll3hvElMmeeUegp8VUGGKIWgR04xZhzVp3+zeFK/z/PLCdLXdaIuEJAY7Xz9kJ1vhdDcghM7Lo0kwH57gxH2l7Q9VMc0w2jiZCp5jgiejQeZ9xgvZU+liix5XV0wU0WBI7C92dCBktN8bXoTZwx/U2BVxwxDH1x3c7onm2azS/BI1FoeBPiuYxeVSTibByiV3yRFFsv93HEs681hv61yW2zv3DmvH5GqAfGx/hVc6Znyd3mHMtQzBGWr58zl/9G6YrRsyC4+R4ecmf9IaNpxj4vP52O1Z85LdnCXxdxWBsOBmYzi9gg8r+S4TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rIoJxrerU7jCmZzu5HhxCKtHFRn062UQl+vKfUkM8I=;
 b=TKSDp6e3guRxeFqW6VsWPlYFacR/gJgP4YWxMh1dmYutkc7nF+jcNPulhnxkWJarmGjETPvEAaNA68MvcBeRWTXqL+ViAPmNVocUs7BdBUGc2jjtzRw95RXkBN73DXvVNI5bCmbrLp6ZKMziXXrJnAlecNRHMi08OLRNxg/8wZ+0HB6HakZI5qO+oJClRVqUWKx+RKJ4zRkUx1nmzky5RgccnFzT0jzxFXzvF6zk0OJ9NEJAoIdAH3fD7xrPRPG/uJ0TFZvyi1CPASc3vv+YPa2qvA1lmt5wNbMPgcpwG9SOZrF5EaidcfBNirySnLoY5Y56ZxbwBp/+eXAhq58byg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 MW4PR01MB6243.prod.exchangelabs.com (2603:10b6:303:67::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Fri, 9 Jun 2023 20:49:51 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc%5]) with mapi id 15.20.6455.039; Fri, 9 Jun 2023
 20:49:50 +0000
Message-ID: <dd9f65ab-d54f-7830-8043-57ea66c76149@talpey.com>
Date:   Fri, 9 Jun 2023 16:49:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1] RDMA/core: Handle ARPHRD_NONE devices for iWARP
Content-Language: en-US
To:     Chuck Lever <cel@kernel.org>, jgg@nvidia.com, BMT@zurich.ibm.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org
References: <168616682205.2099.4473975057644323224.stgit@oracle-102.nfsv4bat.org>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <168616682205.2099.4473975057644323224.stgit@oracle-102.nfsv4bat.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:208:160::21) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|MW4PR01MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: df32bdd1-8935-4242-5993-08db692b11e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jawA01RDwsKtL3flTifhxPZE01UoclVytHkYzvNUAX+kl/Yow8i5XjdoGe75aJFKh5hBzFQ0jFdjXibiorfJ9e94IzV3LedEAEmSR/AY9Mjrc9O0WxRa17K6Ym8Hbah98UmSxB7o802iLvk1FiI2zMRd4yeNWv/3AHnar2ODX2p1zTGcuSWoHFEbLgLJH+G0AHvLHVOPanc8nNp0qtF645Z2UvKMtAHwF4Q7V3D4DJ2WnlMOZrKxrOJhNy+G8lva1dKcvDc+79jxSmkU4FVPybU4CG122DBX3gPD8Mk0mX3xENmY6cipddEpgI4eTG5JK9f3wLSifcPFdTHzHOHkITvD8qokfMXRKQWCYPG6ieMHHlSiHSX5SUBTcaBdausnftf7sU7euYRgXW/TCrRHGCVjQ52C0gskjHhJVb24vfSR2CAkkRwHjUPQAN4RPbbtGTN90e5v70kNQJn98UJwZAe/OYejQ2YYrFvvVnktDE7MX8red6IWyJRJ+aaWrd8HaAusm2o8j4FK+js8NmM7A8YSUOA6rqGdPnLa6FYH+Zd7396T+Y4SwdM+JKYzrlr6lBTdUoDca+jI8nBRDUb8zkiG1mfy7E6vaB9h26rz3ZkEibRsr/Jaqtm/U6KbqAbHLt9DrX60zmryvQNAXdGHpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39840400004)(366004)(396003)(136003)(451199021)(478600001)(5660300002)(8676002)(4326008)(66476007)(316002)(8936002)(38100700002)(66556008)(38350700002)(41300700001)(66946007)(2616005)(186003)(83380400001)(6486002)(52116002)(6506007)(6512007)(26005)(53546011)(31696002)(86362001)(31686004)(36756003)(2906002)(66899021)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVFaUi9nTGhSOFYxSUdBT1RlaVJNQ3gwdU45Rlg3TnM0QlBGamdKbDJVT0Nx?=
 =?utf-8?B?b2Z3c0tzWGNkSFc1TFIrNzNFdEZTQ0hGSDRRVTN6dzFXNmxDRFh3ak5LZENX?=
 =?utf-8?B?OU5OTC90SkFEQ3g1RjhFaitnZTEvTzhZRHBkbFhPQnRDT3Z2bUtNY1I5eFFY?=
 =?utf-8?B?enFtMFZDS0o1YTJFVmErOSt1Ukc3QTRLRjlsb3ZOTmN4aXI0Nkt1RDRHaDlu?=
 =?utf-8?B?bTBGcERXNFlJTUVsMDlYbElZUDZrZzNmU0pJVmZkbzFvazQzVVZpZFRWRUNS?=
 =?utf-8?B?SkpPUTY3am5LWHBMQzh0eGxDVXZBVHFpU3VQSWphRmJLS0hQczJFN2lVdHF4?=
 =?utf-8?B?Y3JkeXNBcTZSa0l2NDdDZTBlMGV5TVRoMXcrV0hkOXMvZ2lDVkppSWFOcWtL?=
 =?utf-8?B?ajQzTG8yYllrL3BwWm5yQkJ2RXlyUStYNmRPcjJBU0wyYVN2d1F5ekhMbzg5?=
 =?utf-8?B?VkdOZE90bkhpVHZ2dWIvNHdVQ0g1cDRWY0pOL01yWCtLRnBER3BCNXJSdnVS?=
 =?utf-8?B?T1lSM0FDWTFDQWpxRkZHSzBkSlVlcDZWSml3QmoyMC8xOVIyMmgvMURhTVli?=
 =?utf-8?B?Ty9jdjRYU2E1aytsQU04NHR0dW5VNS90M0M4YmVXYnFYenJOSW5CU1ExTE5G?=
 =?utf-8?B?a2t5WllmVENDZ1N6SU1UNitLZEdxdWpSM1BVbUUzOS9qZGh3alZLK28yODJz?=
 =?utf-8?B?RzRLMmdSVmQvQmhDNGdiRkZqZUd5WVdhaVpQNW9DQkZzQXRLRHVmZGlSM0NX?=
 =?utf-8?B?bG8yVTcySmowR1dqRnpzTHZXM3VLeFpPL0x3dVZQY2lhTDltKzkwQUhrOExw?=
 =?utf-8?B?aUpIUFhlNjA2RjBaRDBzRWhOdFkwWm1VVTJ5OC81RE5DK2FwZHljSmo3aS9t?=
 =?utf-8?B?dHU1RDRzdDI5ejhoMU41ZE8zUHFyTGdDVXBKZ28zaDVSOXNacEpLblFQTzlJ?=
 =?utf-8?B?TzEyYlB5cWpNODNoMzJTWFM1dmhyTmtKbXJEZThTR3V4d0RXRFNkei9lOXRJ?=
 =?utf-8?B?d3pUeFF0YzY2NWRueXliVzZGb2VteEhFcFVlb0Y4TWFlcmNMZW05K0tVVHVH?=
 =?utf-8?B?dmdBdVVFWTRDam5nWW14dUpLenRJWnV4YUhMKzQwUmVpMWczN2JsYWc3NWJx?=
 =?utf-8?B?VVp0elliZUJ0Q1ZTZjZmYnlRdDcvS2dWZzVTVVhZOTVmV3ZabWRzOGhEMmVD?=
 =?utf-8?B?MGNxc1ZaeTZJREdiNVlqaGhTZmpzQnFJZ2xGSHY2R0dLaktjUzBKYXFIT29E?=
 =?utf-8?B?Ulp6MWV6MzBLZXI1aUVWVHBYZTVVZHRGRzFjc09kcHM4K3FvcFBXMjlGOTNj?=
 =?utf-8?B?ekY3VndHM2l5YmdoVnNhUUo2eDlQN3NVYS9WMWtES01pZFgzS2pud2xzSWF5?=
 =?utf-8?B?S00vamlKZVkxZEZnTWdxQnFka3pEZTJwQVl2TncrQ0xadldXaXhEbjlMQ0hM?=
 =?utf-8?B?Q2pMOEp4TTZBYTBSVHQ5QU1Pa080akl4QW96TU1CeHY5NnUvcTNFdXhVYmhS?=
 =?utf-8?B?cll0enYxZlJiUlZaWnF1UHhwNlZjWS9vMm5TdmlmdEs1ZVlTV2hJTGVNdEla?=
 =?utf-8?B?V1duelU5Q2dMUWZLeFBZckhXdjAzMzRRdGVjVlNQN1FwMUNpVkVWNVVIRlQz?=
 =?utf-8?B?WEdTSFcvTUhicEFOVTdzdURoSkVjcHBlOTE5M2YyVzJ6bW5PSVlOcDBMSXY5?=
 =?utf-8?B?M1dBQXY4dGRYN1RNTWlyRy9HTTRYUGpnRWdFNUZJT3hsemV6b2NOOFNsMXRl?=
 =?utf-8?B?YjhFWHVlRWxBOEYyWS82NzBxSWlSRXFGUFNBZllZaWw4aC9FNTY4RHFxNExn?=
 =?utf-8?B?eDFpUnhtZE9TeC9Wd3pVY1N1OFcvbGpKazJ4UEZFeEVkMEhKbG9rbElTWUpC?=
 =?utf-8?B?WnVvTnJHemhQU094SndUWmdWNVk2YUhyY1A3S3pXL1ZsZVlxSDRuSTAwcmRR?=
 =?utf-8?B?UDN3THlkMVRTeEx2cE5reVJ1ZFBCMlZjOUs2emV2UHZNUkhNTTRPTE95eTc3?=
 =?utf-8?B?QllYUkJ3dGN1Sjl5M1VoMnZGZ2hrQjVZK2RCMFpDYW1FRFNuR2prbzB6ZElJ?=
 =?utf-8?B?UEhJNXpSWGhiU3hNMXB4Tm5aSzZKQjdMZnFGZVY1QlBRQmp5WGhCMC9QT21O?=
 =?utf-8?Q?4kDvBpt46MQ7yJtOniV3jnuLx?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df32bdd1-8935-4242-5993-08db692b11e1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 20:49:50.8751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JiRG9ULVe5lF6DmwX+DDUsJ9f5zlooNgi3VL2cwypFr2gHS8hrIX9zJAuI/LE5KT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6243
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/7/2023 3:43 PM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> We would like to enable the use of siw on top of a VPN that is
> constructed and managed via a tun device. That hasn't worked up
> until now because ARPHRD_NONE devices (such as tun devices) have
> no GID for the RDMA/core to look up.
> 
> But it turns out that the egress device has already been picked for
> us. addr_handler() just has to do the right thing with it.
> 
> Tested with siw and qedr, both initiator and target.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   drivers/infiniband/core/cma.c |    3 +++
>   1 file changed, 3 insertions(+)
> 
> This of course needs broader testing, but it seems to work, and it's
> a little nicer than "if (dev_type == ARPHRD_NONE)".
> 
> One thing I discovered is that the NFS/RDMA server implementation
> does not deal at all with more than one RDMA device on the system.
> I will address that with an ib_client; SunRPC patches forthcoming.
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 56e568fcd32b..c9a2bdb49e3c 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -694,6 +694,9 @@ cma_validate_port(struct ib_device *device, u32 port,
>   	if (!rdma_dev_access_netns(device, id_priv->id.route.addr.dev_addr.net))
>   		return ERR_PTR(-ENODEV);
>   
> +	if (rdma_protocol_iwarp(device, port))
> +		return rdma_get_gid_attr(device, port, 0);

This might work, but I'm skeptical of the conditional. There's nothing
special about iWARP that says a GID should come from the outgoing device
mac. And, other protocols without IB GID addressing won't benefit.

Wouldn't it be better to detect a missing GID, or infer the need from
some other transport attribute?

Tom.

> +
>   	if ((dev_type == ARPHRD_INFINIBAND) && !rdma_protocol_ib(device, port))
>   		return ERR_PTR(-ENODEV);
>   
> 
> 
> 
