Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187405A04E7
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Aug 2022 01:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiHXX7N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Aug 2022 19:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiHXX7M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Aug 2022 19:59:12 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6723B696F2
        for <linux-rdma@vger.kernel.org>; Wed, 24 Aug 2022 16:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwCBoCJoZ9dvLfvPBJgdezXxvHq8ul3vlL93WG4SKDIDJJ1ZP1HCtlCPzlgoLRQIRkSw7a7hc5ovi5SWp1LbpNhofgUO3pXLeOPSd54l6j0UragoCWJU0u8uHees2PPnw1G5ckdF5vTmWHiI9vQoUtqhoBO0ZkS7zKzf7UtlGMos7y0bX7UvxjmVjqRSq2iYIZ9LEM9ZhAN4U30TJ3AHrESM4kD7L92bMaxBOl/b9ulyuApGeF2beyvvMZSQvNfJjPGy+AgyTrl9ClNDlOs+s1NhUqDNpcLdjR2oIuhTV4QUn3Zb5rKjJYky948F/RpVuZFgMOA7b1jP4xcZ224Tdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmrPYYo8MGGlW8J6Q1+6aG0ZygCeNS6gVgtX9+XH8TI=;
 b=X4p7eHdPaL3p0FIISxtaVvCVMlN6gQgm0lQXKUIIxaxDWTaXVfdqyVL/md6pRQnpJ3BdAWzlKqceGkAuWs/WOFQtzEH3B8xgclOL6QHTmMkeWknKdRL6cqlGL9Sr11JYffRtkFtOAus7c0hxzLhGE6UYDHhvvXyQ5O/db9wt1Bg1Z6kTMoFsZk7/OWzBICJpBARyHFasQ17K8WDTf4drBnoccBPIFWuc1D4+yJkBdHv6rgzENmNnFldEDw+ULL8yPszTxRRNae0pFfzikmMqUfgTf78ldmUrWanFI5mkt1Z6s10Y+0ZYRzPv49kmK7OhPiocMTqXcqLSwhGyH1Uzdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmrPYYo8MGGlW8J6Q1+6aG0ZygCeNS6gVgtX9+XH8TI=;
 b=io+L2zKY6BvfEVDaeGkjZTW9OIaFhDRzVTMJjAKRxHcByqOQDlamPHStT/YiRfUp953nM9NzVg8BHlHdVPj4Mc8Q9P+CdJTtFpvWlbEo+wmXU2lcQNy0s1YALbHYfiAsd9MLb95hmijSv0+lOYIVzZ57DagBAAMP5c8Wt54D4oRrp9moZ5lqrJWhyTL8xCteSZuxzOnUt14+s74FwdzUbLyN7L3Y386cvX5nv4D+LTqt5eC1KPqhJfjYjaVwvWBhsmoj+H9dQK5uKFJB4mfcamb9DL7PJW+Lw1SRTKMa34cSgLtnx93ocLIEx3XTwfYA0uL4mQaIVcl0c2caZMaYHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CO6PR12MB5441.namprd12.prod.outlook.com (2603:10b6:303:13b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Wed, 24 Aug
 2022 23:59:10 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::8481:5712:c1a7:f84]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::8481:5712:c1a7:f84%7]) with mapi id 15.20.5546.024; Wed, 24 Aug 2022
 23:59:09 +0000
Message-ID: <8288a63a-d708-4e41-78fb-e3ed7d6fd9c2@nvidia.com>
Date:   Thu, 25 Aug 2022 02:59:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH RFC] IB/iser: add task reference counter for tx commands
Content-Language: en-US
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        linux-rdma@vger.kernel.org
Cc:     selvin.xavier@broadcom.com, andrew.gospodarek@broadcom.com,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20220824124236.812395-1-kashyap.desai@broadcom.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220824124236.812395-1-kashyap.desai@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0354.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::17) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63bc72e1-be5f-4400-176c-08da862ca2e9
X-MS-TrafficTypeDiagnostic: CO6PR12MB5441:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RvAt2OKNzGjzqqXffCtTSnFi7kIZZ8o0QTIlQRfGwQpQ+MeBV4B7eNY+jxhUWtTAmdHk1GbODIv5oaHOX46vuEswsEhwGTEvkZ+rtSXYmgAdZya77BDWv3wIKZK7INca5I7TyvCNciN5HKQ1R2bHgQQq1Jgp729H9MT7ZqliDnN3ayIDjuFOg0e4B/o9WsBz24q81zbAwVfGXTbmAzPndFV0xU35JlENf8LScjwBivNlXPE1rC24ok4Ayl3HqTmQ0QLzdOHhb5MySv4mBhNkWHwqWK5/2BLRVOLQFlEch+m0OeITp4vB2an4NESsQE/xD/AtIFIq9FDVollB0AoG7AcspX7F5zwKJvDUUFV0vAYuFp4708OuvXld5RPMc2ymz18uVOB0MWWU6sIVGK97+i3QCRvCF6/8mhODquOLh05A+GaAthQmlToIDSqoPt8UB/CS2M+mMiuk9jsGdJNsHMQXgzV4CgLZ2RyL6zgDt3W29+Sm4McIeqih4/7M/db5Ba62mUg4Mvz+RdRAH2rqBQFmpad8G2D1y3hPA6q+6+ueNuy02uWyRtmF1waYFWrze0rXTj2paXDVOu1CqfRyMUdooRyLwb0xjeH/F8T2Nxncl3NIAaYlh7L8yB+ZPXoXJEnlVXToUOk7Ni3g78A8Q5k5B52NEdAFQz5SniZ0sYU3sTOnvnOp6A2p+JPSjx0e9n9uhHTrnLrUyIe5evf30QR2mjq3NxVYDtlpREA2ncSHpvstH6Saocm5e4ZoOJ75D1wQ81vQ26VI4Lp5HR7Pcd7tfSw1MBUXLf/DP5sl9KMh+CSP6vic0/cWbwhlF0wSRFlhg91AV/dioh580kS0b0IL/qUu3Ijnqyon/fHufDYgi7K+wyyeHYPYD/LBR0Tf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(53546011)(6506007)(41300700001)(2906002)(6666004)(31686004)(86362001)(31696002)(478600001)(966005)(36756003)(316002)(6486002)(26005)(6512007)(54906003)(186003)(2616005)(38100700002)(8676002)(8936002)(5660300002)(66946007)(66556008)(4326008)(83380400001)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW9UZTVGd3VvUmJMdEJoYk1IZFF1NlUwMnUvVGhmSXpxWXQrcGtjb012Vy9F?=
 =?utf-8?B?bndieXBPWTZUcFZuMjFKQk10M0dEQlREc3J6emlnaHc3bmF0ZG5JOXhEaktT?=
 =?utf-8?B?dXB1RlROQVAreHNDZ3ZUS3FGVzZ3RmJacnZSUVRIWlpoRXBEQ3VHUzFqRDhX?=
 =?utf-8?B?aGtiQTdsamlYSkZ0djFvRy94ZlNvNW16ZGJESVYvUWdjY2R5LzBVWGFZbVJE?=
 =?utf-8?B?clU1QUJET05XTFY3YjFCVmVYa3doNjZQODBSaDg4OTFVUTM4WEl4V0JhQXo1?=
 =?utf-8?B?Q1h3ajVtM0NEZzVUanVXYWU3TUg5bDI0b3dOZGZhdE9vTHBJU2preHJ6emRa?=
 =?utf-8?B?ZlBNZGpIZENiMCtweFVudlQyd2d4eUtYYWxEMXJrS3lGWWtJQzc0VG4vblFQ?=
 =?utf-8?B?RkRHbGdLa29UTUE2NW8vNzRxYWdPTXlkTW5Qa3J4V29xREk2MnRMY2xxdThh?=
 =?utf-8?B?N0NTNGdMVm1yM3pJT3V0TzNheGkvcE1FK2lxSEdnaXB5bG1WN0kxdFNpMEQz?=
 =?utf-8?B?ZGVQM2J2endMZDZYSG1tN3hmQS9KRWtXTFZrZ0lreHJ3ZHFmcFNPTzBzUXMv?=
 =?utf-8?B?UWppUHlVQXZBZmZxbDRGUmFDaUpqeEdGVHVVbWhiZHYwdFJQT1Y3Ry9lMHht?=
 =?utf-8?B?NGVvSUtQdndQaGViMnRCbEwxV2RpSkwyOUNVemJIS0ZRb3BzV1VGa3FVTXky?=
 =?utf-8?B?RW9DRU9XRVczcjRxdUNrT2pWZHlqaXRCSFhJN1NwRWpyUmY4c3J2WkVVMGMw?=
 =?utf-8?B?N2U3cVYwM3BVTmVXQXZlRXJQS3BQS3RDQ09xZHVYc3VGRkVEYS81eXdUbW5I?=
 =?utf-8?B?aEdDMzVzUmxvYmF3NUZWTURYR2ErcnYwL050NHpESXlycTZKTkNLSlh3SGJo?=
 =?utf-8?B?TnpXUklGQndzRFB4bWVVdjFvSHYvcXgzZnZrTG5HSGh4MUJxQnJ2REdSSUJ3?=
 =?utf-8?B?RnJXNlZia1gyY3puWUxLTGRlV0ZnNUFVUlBORVZZSnhFWjJPdkdKdnMvbnpr?=
 =?utf-8?B?K1RDaHdnODhQS1VGVXFQS3dFMzdJcUt0ZlVCcElmSVptY2JZZU84WXRKUlpv?=
 =?utf-8?B?eHpzTnhTdHJXSEo3VjY1NkpoYnJzQVk2K2FIRkk0NHFlWnliRlFmSmt6T0VO?=
 =?utf-8?B?Y0xZcWp1WngxenQveFVJYzM1VzNmbzNFb2x0bVpCTDhYVHJWeG5LMS9UU0lZ?=
 =?utf-8?B?Ulo0c2hpR2JoaE5nbFRQOEdMYmxQTUxMSnlzdTVkTVQybllDR1pPa0lNVW5S?=
 =?utf-8?B?QS9EM2VTcXZMNk5sd1FGYVZ2RG9MRXRBZktDcVR5Vk00VGVuTXBXUFZ1WGtm?=
 =?utf-8?B?aTM1bzRJaUhNdFFiblp2YkMyaTRhQm5EKy9INTNUNHJzRkZKODVySU4wNThs?=
 =?utf-8?B?VFM4aUxENUZ6VnhGbGV1VVNLdmd4Q0U1L05PTGpGUUMwNzg4ejFiSWlBcUpC?=
 =?utf-8?B?aHRuekwyMWg2aWk2SVhwQkdNOXVmWVRhMDl2bk1nbUI3UkNOZ1pxL2FCbnRa?=
 =?utf-8?B?K09PcjdQTUJTTzRFK3lBejZSZ3M5bFdaWUhRZzNJQ1pOWkdTU2JqeVg4UDZS?=
 =?utf-8?B?ZExTRXdJVkQ0VTJzUWY1TW94aDNHakV1d3Q4ekExSkNhT3B6Q0NuNVZpYlhQ?=
 =?utf-8?B?M01KNGIzdmZUa0dEU3puWFlwaDNOWEV3Z3Rsc1A2V2cyQ1JVd0duMk8rRzU4?=
 =?utf-8?B?T0dyMGhjY0J4K0FHU0hURmhDQU1RZHZhalNMZ2xxMU03THZ2WGEyRk4wSzRJ?=
 =?utf-8?B?cWlEcUNaM3d5ZmRIN3pZYWFkNWk0ZlJsVnVvNVNLY3lFWE5PK2dXWGpZV3Jk?=
 =?utf-8?B?VGtSZFFqSUpkYXhoeG03ek1zU2tXM1RwUnlzUHp2MHBKOGR4UnRDaHkxM2hH?=
 =?utf-8?B?TTFMOTFYY1plMGhOVHQzS2o5ZmRLMW9IcW9EU2tIQm5Ea2xWUUVoS3djYWdO?=
 =?utf-8?B?LzVQUEtZVnlZVUNzVy90U05jSW4xOHdEbXpBQnYvOEMxTHlSSkhVcENFd1V2?=
 =?utf-8?B?azM1c3p4K3NCTnpCejhjZDFRYmJCdldzYWdQY01tMUxlbWtYakNielJyR2Yy?=
 =?utf-8?B?azUvSlp2TjRFTVcxYmw4a1B0TUVkWkloU2Z1b0xNeXBzRnh6ZW91c2lnSHRC?=
 =?utf-8?B?MmQ2S282eGYxWVdsTjd2SlJldzM5UlRzbU5PS0tkUCt1STczZFlDOHhiT3R5?=
 =?utf-8?B?Q0E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63bc72e1-be5f-4400-176c-08da862ca2e9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 23:59:09.8713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARDq20eSOibTXoHhn05vJ0LCCBq0b92U+l9DiExecxK1ChOEUflAsCZGhT/hlsd3I+23LYm9DtPkHANQIB46lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5441
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Kashyap Desai,

Unfortunately, there is a wider problem in iser that we do the local 
invalidation if any, after we complete the iscsi task.
So the right solution is to do the logic we have in NVMe/RDMA that 
checks if remote invalidation happened and if not, it does local 
invalidation.
And the task is released after getting the send_completion and 
local_invalidation/remote invalidation.

There is some infrastructure work needed to be done there.

Sagi,

Please remind me few things regarding the iSCSI bidir cmds.

In case of bidir IO cmd, if we need to use a reg_mr for it - I see a 
potential problem there.
Is this scenario possible ?

I'm asking because if it is possible, so what happens in remote 
invalidation ? what key is invalidated ? the read_key or the write_key ? 
in ib_isert there is a priority to the read_key (is it by the spec ?).
We don't consider this in the iser recv completion and the remote 
invalidation checker logic.
If it's not possible we should re-design few components in the code and 
fix the issue that we do local_invalidation of cmd N during the send of 
cmd N + 1.

Cheers,
-Max.

On 8/24/2022 3:42 PM, Kashyap Desai wrote:
> In [0], Max Gurtovoy already explained a future plan to add reference
> count.
>
> Below example has Initiator Task Tag = 0x1e. We are tracking the same ITT.
>
>          [177617.255969]  session508: iscsi_prep_scsi_cmd_pdu iscsi prep [write cid 0 sc 000000009d6ff976 cdb 0x2a itt 0x1e len 8192 cmdsn 90 win 64]
>          [177617.255982] iser: iscsi_iser_task_xmit: cmd [itt 1e total 8192 imm 8192 unsol_data 0
> (1) >>  [177617.255985] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x1e]
>          [177617.255992] iser: iser_reg_dma: Single DMA entry: lkey=0xffffffff, rkey=0x0, addr=0x9c5de000, length=0x2000
>          [177617.255995] iser: iser_prepare_write_cmd: Cmd itt:30, WRITE, adding imm.data sz: 8192
>          [177617.256002] iser: iser_send_command: from iser_send_command iser_task ffff9e39dad96898 tx_count 1
> (2) >>  [177617.256016] iser: iser_cmd_comp: from iser_cmd_comp iser_task ffff9e39dad96898 tx_count 0
> (3) >>  [177617.256045] iser: iser_task_rsp: op 0x21 itt 0x1e dlen 0
>          [177617.256049]  session508: __iscsi_complete_pdu [op 0x21 cid 0 itt 0x1e len 0]
>          [177617.256052]  session508: iscsi_scsi_cmd_rsp cmd rsp done [sc 000000009d6ff976 res 0 itt 0x1e]
>          [177617.256055]  session508: iscsi_complete_task complete task itt 0x1e state 3 sc 000000009d6ff976
> (4) >>  [177617.256057]  session508: iscsi_free_task freeing task itt 0x1e state 1 sc 000000009d6ff976
> (5) >>  [177617.256067] bnxt_en 0000:21:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x001e address=0x41137800 flags=0x0000]
>          [177617.256068] bnxt_en 0000:21:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x001e address=0xc1595098 flags=0x0000]
>
> (1) Is when iser stack has posted TX DESC type = ISCSI_TX_SCSI_COMMAND having two SGL.
>      sgl[0] is contain iscsi_header and sgl[1] is scsi data (of length 8K)
>      of scsi command cdb = WRITE_10
> (2) In a good case, TX completion is received,
>      but in some cases TX completion is not yet received to the iser stack.
> (3) Is when iser stack gets completion of RX DESC of ITT = 0x1e.
>      This is actual scsi completion of TX_DESC from target.
> (4) Is when the iser stack destroys all TX DESC resources associated with ITT = 0x1e.
> (5) Is when HCA is still accessing WQE entry of ITT = 0x1e (possible in retransmission path).
>      After (4), sgl[0] and sgl[1] dma addresses are unmapped and not allowed to be used by HCA.
>
> Get the iscsi_task reference count if TX DESC is successfully posted.
> Put the iscsi_task reference count once TX_DESC is completed.
> This method will make sure iscsi_free_task will be called only after TX
> and RX DESC received for the task->itt.
>   
> This patch depends upon [0] as it required signaled completion.
>
> [0] https://patchwork.kernel.org/project/linux-rdma/patch/20211215135721.3662-5-mgurtovoy@nvidia.com/
>
> Cc: "Jason Gunthorpe" <jgg@nvidia.com>
> Cc: "Max Gurtovoy" <mgurtovoy@nvidia.com>
> Cc: "Sagi Grimberg" <sagi@grimberg.me>
> Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> ---
>   drivers/infiniband/ulp/iser/iscsi_iser.c     | 5 ++++-
>   drivers/infiniband/ulp/iser/iser_initiator.c | 6 ++++++
>   2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
> index 620ae5b2d80d..f1704fef9dc8 100644
> --- a/drivers/infiniband/ulp/iser/iscsi_iser.c
> +++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
> @@ -339,9 +339,12 @@ static int iscsi_iser_task_xmit(struct iscsi_task *task)
>   
>   	/* Send the cmd PDU */
>   	if (!iser_task->command_sent) {
> +		iscsi_get_task(task);
>   		error = iser_send_command(conn, task);
> -		if (error)
> +		if (error) {
> +			iscsi_put_task(task);
>   			goto iscsi_iser_task_xmit_exit;
> +		}
>   		iser_task->command_sent = 1;
>   	}
>   
> diff --git a/drivers/infiniband/ulp/iser/iser_initiator.c b/drivers/infiniband/ulp/iser/iser_initiator.c
> index 7b83f48f60c5..1f0b1601b3b3 100644
> --- a/drivers/infiniband/ulp/iser/iser_initiator.c
> +++ b/drivers/infiniband/ulp/iser/iser_initiator.c
> @@ -669,6 +669,12 @@ void iser_task_rsp(struct ib_cq *cq, struct ib_wc *wc)
>   
>   void iser_cmd_comp(struct ib_cq *cq, struct ib_wc *wc)
>   {
> +	struct iser_tx_desc *desc = iser_tx(wc->wr_cqe);
> +	struct iscsi_task *task;
> +	task = (void *)desc - sizeof(struct iscsi_task);
> +
> +	iscsi_put_task(task);
> +
>   	if (unlikely(wc->status != IB_WC_SUCCESS))
>   		iser_err_comp(wc, "command");
>   }
