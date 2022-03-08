Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6D64D1521
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Mar 2022 11:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239485AbiCHKu0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Mar 2022 05:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345993AbiCHKuZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Mar 2022 05:50:25 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2052.outbound.protection.outlook.com [40.107.95.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191C043390
        for <linux-rdma@vger.kernel.org>; Tue,  8 Mar 2022 02:49:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHVrR0w4l+doKhvnHCmVNiM1ZhMC0hqJC1p7H6/L5W/WVIqymji6p/1f86DDjNdv8YPInX47SXaLFWEF+QsW3guN55J+Vx/YfAKOBGJYiwbQRbDmE3ryQ7xMSDWhP8avBG4umX1u5VTcgRHgfV8NyFf7JhRU3yer2dYHbjksw4wY3IfmLCExV5NXWiDcNAqfT2mo6TXR5KTKEU2ro7c/8v9niPBKYhygoxCDIFZgW6Z4qYEcCuDkC4n5p0Adu7zz2q03C8qSIvSRtf1SqvZPR7QxLDCVy9989AkBCEGyiC+sNkbCu1br+8nMOlS1M3e1l8H/OV4HrCu5cG4q+YWSEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6W3TZnLsRj5b9KIyJ2cbNY6pDPjd9krHgqPhT/98WI=;
 b=USrW2H7bTlnXDMfEeD1CeQrbeoMnXfZuM7wi9boBgsSFbPTfagqYmXBwZV5eZ18JP/v5CMrljp/EyFQvToW9WO9M8kWd+PuArYXqCwT0TtdZB6ncWdbtOMvVpuhEdwttKR3ALWPSjwwe0L8aLSPXvoHcdMrCloNU5HQEOMddZ1Y7pimfO5EsJZOkjbR6BSXaImqce1xjUMhV1mk1Gd1S5ggdYCN3zVzL4/87R1sc+8RstDdQ2j6AHSqpqxpsr9No667sGrsrVc26NcXHYc+GZ3USAyR3Ax/JvFWwe+3SURZINx533VigKpUtpJBwMdWJUWY62wV5gO36y9ZJ/4U7ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6W3TZnLsRj5b9KIyJ2cbNY6pDPjd9krHgqPhT/98WI=;
 b=EjQ83Fn2O3tXe/kqj6BeXk2jcq8IxUg8EoGZHN5ISDXqt8wveCXgRNFWkLlgJwiEc8YcFXJ/ZSrkk3DI4iXhkqEKjeVsT6Q5SRfLJW6v93j99KIwEC14OYv4jq2gGPLYUQGb0BwN2LAOQllZRJs8bwCIL926E+DrrItxLKNd4TjG/31wT0uG0L2lehXbGsBDgREgsyA9DUhNqSkixdiIYc6HvYcs7fHUe/NGW0y4zpD7l7fF/NlgKgr81pFqtUuqiGJ5Qkeu4nuRWt8PWdRLSecXgm4A6gpetYn4+vSn+v3a3tOIeIIBjSP/Ex7E+k+XW20u+nWtGgfNr1OTdDWmsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1366.namprd12.prod.outlook.com (2603:10b6:903:40::13)
 by MN2PR12MB3805.namprd12.prod.outlook.com (2603:10b6:208:15a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Tue, 8 Mar
 2022 10:49:27 +0000
Received: from CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::7044:8280:56e3:46da]) by CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::7044:8280:56e3:46da%4]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 10:49:26 +0000
Message-ID: <b612cd5a-b3ad-c8fb-cb01-32aeafbb9e7a@nvidia.com>
Date:   Tue, 8 Mar 2022 18:49:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [Question] Is address format "gid" supported by RDMACM with RoCE?
Content-Language: en-US
To:     Sylvain Didelot <didelot.sylvain@gmail.com>,
        linux-rdma@vger.kernel.org
References: <CAOrWFD8Kb3R0OZ8A04QF4fPdMM6Xa_-sze0tLHboAJnz3SLivw@mail.gmail.com>
From:   Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <CAOrWFD8Kb3R0OZ8A04QF4fPdMM6Xa_-sze0tLHboAJnz3SLivw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0161.apcprd06.prod.outlook.com
 (2603:1096:1:1e::15) To CY4PR12MB1366.namprd12.prod.outlook.com
 (2603:10b6:903:40::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2426d409-743a-41d1-518b-08da00f15061
X-MS-TrafficTypeDiagnostic: MN2PR12MB3805:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3805E696E6F0110287E2E262C7099@MN2PR12MB3805.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5nA2JNFpC3E23bj2mxppvKt7OLLzk0FKQVGNGNFHoNrSb+u+kxS6WzQzBCIJYFuTbatlVHPriUzAy6optcQzjY1uPWMxld6DEHBLIEAIYCT+/49NzxiFDaqcWOTgkEjE6vDM6HU0vckTAzqA9h6WO6JtYn5HUFdvHZlyWebYpMduHG32Qi3pkjjUpCmPaAth0dlqxFbV+VQ3rT+mfbkoF5rp9LdMm0rtdfoJB7lyL4r0pv7Mht2lVlNapPtos49apMoxdWEhW/W01T6AJpq/fWEfr/lE7bDVCXwX4pnRu5kbgf2y1nTxezf5kH8J3IvXXZwDKgn9M6YaM+0xJTJahMKe3+NtuoclSEqOSNi8Qs2VfkamWeeBvx+jrp1yl16M13t7c3qzfzHHUevtVK7xHSEvRCkPCIBEGSTcVJv6T1UHRC8vfiCdIFzKf0sKkbMihxfGDWWX7Onlif88W5DGgwFw0JYHha6hyamMycfLlk8/Y9Or2oRQoHP/SYQF7jE1RcwQrLrQZvBKZKGg2u96WTCJ7k3h0CF5plxJTf1Cd1jrYV/y3sL2ELQswuOYaGZGNjWU69AvRuHzD91Fyr42V1Jkvf8Z01oWWlWeZ/+th9jZksBFxAjjh5PTm96HCI88mn8Pw4m83KgcOwOaJELn2n+A9lDw3ts9ixOYLlJOF6nljCrNM7hNM/8tmcl9IlhwjN4gRhNwp6LKhNGR6uWqyhGm2my+kGrX3cIsl0E+6ew=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1366.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(8676002)(5660300002)(86362001)(66556008)(66946007)(66476007)(31696002)(8936002)(2906002)(508600001)(6486002)(316002)(31686004)(53546011)(6506007)(6512007)(6666004)(186003)(26005)(2616005)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEJKWlptNkdLM1hBYXdVTmtsRHpmdFpFRUhsUUZDY1VkWXJrRXhzNWVRQzdO?=
 =?utf-8?B?VWFGNXJVNCszU0JpOS9RZWJsMCtHYUYzeHhrTHF0U25xejE1WnQxcTZUREdt?=
 =?utf-8?B?MHVCZUlrVHRpMW1TaHpHUjRWVlJTaE9weVlmTVN2eWVhcWZpeTJHMDFsRTU3?=
 =?utf-8?B?SzZUOXRLQkFzNG80YVBhTFlNYWNveGZlNTFtYmY3aUdXK0puTm0vYjNnUWpR?=
 =?utf-8?B?Z2xDLy9Yc1lTMk1FYWNIK1BwUk8vekpUcU1FTUhhdGI3RHB1K2pwdUVMZ2Fk?=
 =?utf-8?B?TzNhRTNjemdRaERTQlVVdjhKTHZxcXo1MURBNHZkUmRmWXdSYTdvMVJBdlBS?=
 =?utf-8?B?MG4yL2NxaThkSkVwY1gxMGpsWmYwTGgySno4dHRlQWxVN2U0aUlDSmtUZjB1?=
 =?utf-8?B?MDJIanBuL3R1Nk9lQ0JIZXhiODFmbWNCRS9kcEpIYmdLMjU0RnNYNCsyK1dz?=
 =?utf-8?B?bkE4bElkQlI0MW4xQVN1ZDRIOHdPMHNDTjFicnpZeUxsY2h5R05vR00yV1p3?=
 =?utf-8?B?VmFvZ3lTM3R0Mmo1TlBWbGpkRU5EVDF1UWtFRG0wajNucjRRQ2swMmUwZG02?=
 =?utf-8?B?QzZQOGN2QllKN1hXb3VvTjIrbENBMVVBMHdOc2taRStzaUpDZE9QNWFSK2V5?=
 =?utf-8?B?TWltZnhhUG9JSkpSTURYYVdzMXV1VEFqaVBFc21jSytGNW90ZjloenJmN3Uz?=
 =?utf-8?B?RmthOTR1SG1ZVHlSR21PSDhZRDdBZGtXSDZvVzVvclREaDY0TmRzNTd0RE16?=
 =?utf-8?B?QXFyWnZFYnFTL2hVaUU0aFVtMGtMSldWQjNzZ3Bwd0xER1VOOUtrQ2tDSDlP?=
 =?utf-8?B?VWg4WHpXQ3llRGkzcGJYS3dZQUxWcUZzSnh2THJUa09DOEMxdW5IREJpUFJs?=
 =?utf-8?B?VGxNeFlpT0lpVEp2aFBRSnFDeEQwc2ZrMmJuUTJMTEtyM1BQU2FqaGVVVUxJ?=
 =?utf-8?B?aHBvbXlPblhVN244VU45cU5NMk1ERGJaeE44bkZzaXBoVDhhZmRsclIyOEZW?=
 =?utf-8?B?ZHVYTkdzRTNmckFHL3J0ckRxVWxTd3dPdE1wWEQ3bXQvSXJxek1jaEc5R1Rv?=
 =?utf-8?B?NTVudFNzeWZoNW9UUDlybCsxNEU3YlE4bEl1L2laa2tpcGxWaE1iVUtkQjZy?=
 =?utf-8?B?bDk2cnBuYkRrVDNEc3Rpci96MFY3WkZmUkhIVGd2cDdZYzFiR2ZuQ2RjTWJG?=
 =?utf-8?B?bi9reHA3QXIxTEVIY2hOTVpmQUpwWnBlLzRsUzdoQTYwTzhmQzBINFh3WHNN?=
 =?utf-8?B?ZHNZM2xSMVJhYXhkSnBTL0dVQlVHNDBEQjRxd0J6WE5IUWpPZHlsNy9BWjVy?=
 =?utf-8?B?cUQwTlZlaFlQcUozUHJZUlZsYzhiZnplV3V2VU9wRTE5a2xnV1dnVXdKaW9J?=
 =?utf-8?B?MTROdWwyb0ZDQmRrMTZLbWNxSlE1S2Q1LzdFZ3AxZDZuY01oN3hpYUdRN0hO?=
 =?utf-8?B?eFUvRGt6Y2hUVi8wME9ZditDNHJYZ296TjBqckltaWFUczFEazVtUmFUbXNw?=
 =?utf-8?B?RVBiVE44bkgyT2JEeDRrM09pcXVEcThQTmV5YllRblVURTFWUHNzbFhmb3BW?=
 =?utf-8?B?eXNMQXlhSzFDOTJwbW1MY2lsdnBLMmFSZ04vUm4xNTdsbENYSk9CV3lvdHRC?=
 =?utf-8?B?eC84bGxtVmFVaG5VYlo0aG1xWks1YkFrZU5Fc1hJMHhWR1RaSjJUWG9HVWw0?=
 =?utf-8?B?OXRFZS9Sb1RaTDg3VnlrUTN5ZzJCWDNrUnY2UnZDUWl6Sk1EcGcrVWpPQ2lo?=
 =?utf-8?B?MmMxa1VuV3hkQjg1SEFJaVgxZ2I1cnJnSEJFd2tYMklRS2Y2ZE91WFFqZ2Z5?=
 =?utf-8?B?dE1rdURJMmhtNFI2RCtZeVN6czh0TDRQRFZUcTQ0eUk0b2J2Sll5VUhwc0dm?=
 =?utf-8?B?WTlUcDNmdGVMQlhoMHdIeE5aRmRrQUYveGlyL04yYkIyRVp0aFhETGRVZkk5?=
 =?utf-8?B?NlRNQ3Y5OFhqSUdsYnBRS3AxdW8wVGp6WmhPdHhicE1VQjZiRlV5QmFYWktr?=
 =?utf-8?B?NXlHdWtaRmMvdG9jUEVIbGJxOHNEaXFTNHZvTEhsUmgydi9pekFRaFFZZVRm?=
 =?utf-8?B?VEt0cnd3SDNvRkdBMFV0YjhQVjZJdXZoSmVPdFJWWWxDMFB2alZHVFIvK1Rx?=
 =?utf-8?B?elZiVUtTZU5iVStKWm55VDV2NGozc2FKNm92N0twN0UrSFdiMWxUTmNYUU9s?=
 =?utf-8?Q?/EtlOA+fLB0qWvrzQPnv0P8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2426d409-743a-41d1-518b-08da00f15061
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1366.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 10:49:26.6550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7Eoh0DxXAP55RjpwQjCdwY8cMoQBfP4cOmyF1UoP8fqcEPShBV9qmy91cOgB9CWVFa8PZty5AyUzT5Wd/+Chw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3805
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/7/2022 9:57 PM, Sylvain Didelot wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi,
> 
> I have configured one of my Mellanox network adapters for RoCE:
> ---
> CA 'roceP1p1s0f1'
>      CA type: MT4123
>      Number of ports: 1
>      Firmware version: 20.32.1010
>      Hardware version: 0
>      Node GUID: 0xb8cef603002d1707
>      System image GUID: 0xb8cef603002d1706
>      Port 1:
>          State: Active
>          Physical state: LinkUp
>          Rate: 100
>          Base lid: 0
>          LMC: 0
>          SM lid: 0
>          Capability mask: 0x00010000
>          Port GUID: 0xbacef6fffe2d1707
>          Link layer: Ethernet
> ---
> 
> The Infiniband stack was installed from the official Ubuntu repository
> (20.04.4 LTS):
> ---
> $ apt search ibverbs
> Sorting... Done
> Full Text Search... Done
> ibverbs-providers/focal,now 28.0-1ubuntu1 arm64 [installed]
>    User space provider drivers for libibverbs
> 
> ibverbs-utils/focal,now 28.0-1ubuntu1 arm64 [installed]
>    Examples for the libibverbs library
> 
> libibverbs-dev/focal,now 28.0-1ubuntu1 arm64 [installed]
>    Development files for the libibverbs library
> 
> libibverbs1/focal,now 28.0-1ubuntu1 arm64 [installed]
>    Library for direct userspace use of RDMA (InfiniBand/iWARP)
> 
> librdmacm-dev/focal,now 28.0-1ubuntu1 arm64 [installed]
>    Development files for the librdmacm library
> 
> librdmacm1/focal,now 28.0-1ubuntu1 arm64 [installed]
>    Library for managing RDMA connections
> 
> rdmacm-utils/focal,now 28.0-1ubuntu1 arm64 [installed]
>    Examples for the librdmacm library
> ---
> 
> When I start the ucmatose server with the address format "gid", the
> tool fails binding with the error "No such device"
> 
> Here is an example of the output:
> ---
> $ cat /sys/class/infiniband/roceP1p1s0f1/ports/1/gids/0
> fe80:0000:0000:0000:bace:f6ff:fe2d:1707
> 
> $ ucmatose -b fe80:0000:0000:0000:bace:f6ff:fe2d:1707 -P ib -f gid
> cmatose: starting server
> cmatose: bind address failed: No such device
> test complete
> return status -1
> ---
> 
> Does rdmacm support connection establishment using GID with RoCE? Or
> Is it a known limitation for RoCE?
> FYI, the same experiment without RoCE (Link layer: Infiniband) works perfectly.
> 
> Thanks for your help and your feedback.
> 
> Sylvain Didelot

I think ucmatose doesn't support RoCE when using "-f gid", as in this 
case ai_family is set to AF_IB.
