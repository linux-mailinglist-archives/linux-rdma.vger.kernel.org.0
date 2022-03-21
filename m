Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7054E2619
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Mar 2022 13:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347205AbiCUMN2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Mar 2022 08:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347202AbiCUMN2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Mar 2022 08:13:28 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2055.outbound.protection.outlook.com [40.107.95.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63EF1621A7
        for <linux-rdma@vger.kernel.org>; Mon, 21 Mar 2022 05:12:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiGrrNG0WvwMlckMN8iQviu2YgiHcTS1P+gPCa477KZZgr34ZT0nXfFXEM2ieuIDhkkiPG/9s2N6jr+eyROC9svEYWiNI6CpaY9i0RtctzpAb2fp3ti+U5iuU3MO5qEI7g2fcQoj7Te4UwHxqv6VEat40CS3Ir/OkAsSDQAn71HFVHn34eIrk5ebB6FMoQjNaV+Y5MPi9xK2Slb0Xy3XiMb4h70n8x6v9PClunPJWMhVDNm/LS8tOqfpWOEs4mikcRhbJYAa9T5mS7UUve2L3GMQPlAICYdgj8NuVrib8HiNubBws+d/5c3a2uylaZesEWAPIfqApPkXLAh3OaH3Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Og8l2xyIebiWTk+a5cXcjLWl3QtPyClZSaNzDyd4qdM=;
 b=lkrCBZ5M6A5guVEJ/qs1Q03rVcVwM+FGEaSovIZJNjrmPhmsg9aKMDpmnS7P+HPN/4S8qpzMX5eGERtfq+Ue/tk7gDkZlm9NvuzOh05G5dxMgpk0DRBwKcsE/JtKz708iqqNcDqtXVc/LQH1ru2/gQTuafAz561EOyKtt8MBQ51ef70TxuxnI09GsbLajmkCVC4PLmJJ5jOqQvL3FXaKibLZrJ9pgd9UTupPqDWtYMl/ocae2z8+dxnKBo6Twvc5fSE9YIWqeshKEtScW++9Wr5J1/IP5f1jWpPf+M2FFltBHrXjuAmALXchjyfxV9s5kjrs9SiVaSjgo8eJ0R+LlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Og8l2xyIebiWTk+a5cXcjLWl3QtPyClZSaNzDyd4qdM=;
 b=DpJ9y32ZMN/+syRVlZgsd0N/JYuPW3MogDLYFfoMspecRrO+a7l+WB+3ulItGU3/oGeju0V17TXz49XJIsqPbbwPBoXBP1GJOFvoAGPn/oT7y2ALlbLSXi4cJQgm2UPRECnObYC9etwld7+hwNSUV2SQ9uPJJnE6Q8sKAfLyJezCa4f0S09S2CXElOJP0LG1Gh8o/SC5vRBV2EQnLXcLnSQj4Q2zrQEtXd+rKQsM4MTv808xNEiy1u73H6NE+I62FytDYN2wp0wwWPmJLP0t9/kFmOWiFvPxAT5xEFRh0aMzOwqoTOK57QScw7QbrQ4MrsOUvQhy2ES3aV23l8uaLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MN2PR12MB3728.namprd12.prod.outlook.com (2603:10b6:208:167::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Mon, 21 Mar
 2022 12:12:00 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%7]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 12:12:00 +0000
Message-ID: <1f6f6e5f-950c-3272-bb55-2852c11af37d@nvidia.com>
Date:   Mon, 21 Mar 2022 14:11:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
Content-Language: en-US
To:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <CAHj4cs-yt1+Lufqgwira-YbB6PHtJ=2JA_Vora_CfarzSzoFrA@mail.gmail.com>
 <4BB6D957-6C18-4E58-A622-0880007ECD9F@oracle.com>
 <CAHj4cs_ta5WR7j0qvHyr1tSCR-U7=svY5j8Hctd7YUMNcGXsaA@mail.gmail.com>
 <a2fabeb3-5f19-11b6-8c00-a479e3759182@grimberg.me>
 <bdb675e4-1de8-400b-9d43-9f0c18147dc4@nvidia.com>
 <CAHj4cs_C=pCz41hg1AnQcEZPBRK78WTUq8HE3n_28t56iN1FuA@mail.gmail.com>
 <fe9842f1-e5c7-7569-426e-9029662bb4f3@nvidia.com>
 <CAHj4cs8fNmj2Mn7Srs547ji51x7mQ8ZWKzFOuJaENe=vKpBJ-A@mail.gmail.com>
 <6347079f-ec3b-c2e5-bb3b-43b539d6d3f1@nvidia.com>
 <CAHj4cs_ir917u7Up5PBfwWpZtnVLey69pXXNjFNAjbqQ5vwU0w@mail.gmail.com>
 <6d8f4525-f663-18cc-8644-bfddd7d86bd0@grimberg.me>
 <CAHj4cs_ff3TGnD2QJSzx3QJQKc1HkF=TJkh_MokqGK3n8NWyQQ@mail.gmail.com>
 <3d3f7b64-1c74-d41c-4c60-055e9fa79080@nvidia.com>
 <7e0abcac-791a-bd71-38c3-4a5490b7f209@grimberg.me>
 <d8283461-8759-39ac-6ef7-a6f5cc739634@nvidia.com>
 <94b12c63-7deb-5c62-2c0d-e339fd5e7823@grimberg.me>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <94b12c63-7deb-5c62-2c0d-e339fd5e7823@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR04CA0070.eurprd04.prod.outlook.com
 (2603:10a6:20b:313::15) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90c0cca3-5d32-4aa0-8976-08da0b340040
X-MS-TrafficTypeDiagnostic: MN2PR12MB3728:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB37282A7DCC8DD51339E75DC9DE169@MN2PR12MB3728.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nnX51u4bgbT9FT7MmKe4yV55V1rI8sEMcBY2g2m8wI3kiYukIBiG9l0d1D8AAni97AWEVlQswZ7yjmDlJ/shpXPqQz1cDjXD1lArVlFJ2A9eQXUg+Bq42sSsZp2hkKfjGPubnrQiUDULF5FzuvVy5xEdhj1EQCgV7b3CyYlWouA/ozFhEoroiJMAXF3yGbz0xTLAcg6TZoX+hEr0eVyD7YRqR7eZ3+YnwOYwJfESg+ajhkuQ6WQB6x5F1oVq/MtH044uXrFihV2LvzSWalrdM2b0O7/N0trFDiDz/RP9ELKWe/PNLHYfGO40kPGAgUQCurIU8QrDSB4wfJlogeo86AupjfXPJbfWnJYGi/iSAncWkpHCQQ4t+5CXlEJ0JrIqGexvFqe2u8m5ttxEAOITD4uCPvtWwuqytIHSNFn800JxRBJB0X8gvho6WpYkFRXnQdAWH/dW9vyenI9v/rIEDaRs2UojZP22MYeLt/Zph/E3LxsT9CHSlkUFAACxgiQ4XgekhUsYOOT5Hq0jkSCPWjvVd2JfTzWeNdxXyrozGFtXypnOcXtDjnM2u2uBsrKC84aQ7XhSTsoSlTMhyXSXGwwT9KEeD6jhXuHOzKQEp4U2dQ0gh3bb9lctR0FazzY0BrLyN0vVD+jIQnGQuMRDX2Oapd6xNkEu/3waPpNnAAyyeMP/agu7XVOX63gppTzMMjtWh4dSxoc5nKQgDm99OHImv4ZusR72YQ5te/Ij1bNXDxYdOqorkv2rlcanKoSc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(186003)(38100700002)(26005)(2906002)(8936002)(53546011)(2616005)(31686004)(5660300002)(110136005)(54906003)(316002)(66556008)(66476007)(8676002)(66946007)(4326008)(86362001)(83380400001)(6512007)(6506007)(31696002)(6486002)(6666004)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk5zMWhSczIyL01YOFlFTXlMc3ZncDA0VmRGc2ovV1lEaHkxS08xK2dHeFZ5?=
 =?utf-8?B?NXhnSkhJc3hjMVB0bXVkbU9JQTIrOEJYOXgzMmdPdEVuOEI0QmZ4WUdWUHdu?=
 =?utf-8?B?bFNvT1hCSEc0Y3YrSjAwZlpEeHArRXA0S2xVR2d1c2NmT1pvWkVmc2ZwNHdt?=
 =?utf-8?B?OW9KWDYrT0FaNlhoMWU3aVgvTUFOL3R2dm9ZOEtlMWs2Wlk3ZFh3aVpTSm5U?=
 =?utf-8?B?VDRranlERU5BRDlzSVVyRlJnRVpTaTV6NER1OGhqeTVaM0ROa3JYZVlVRDVz?=
 =?utf-8?B?Qm9iajNzV3dPVmJZdVFMQ0RVVHI2WE8ra0ZpZnBWWHZsNDRRN3ZqaHpNNUoy?=
 =?utf-8?B?NU1jWUluWUl3N2pkSXNvQ3ljandmWXV1aVZMM3RtbUFsUmpydVUrTXgxTXRH?=
 =?utf-8?B?MXdhQzIweXQvejlWT1BXUy9tVk5LU09kSElvNjYrT01KZ1RZSXRxNEZ0ZnlL?=
 =?utf-8?B?R28yUStvVjdUcm1yQnJYeDY2Mm4ySnNHS3phMVExUU02dWs3cStLUFdRZVlR?=
 =?utf-8?B?UTVzNVovdkdlcS96bGtIQXB6NGNYL3owUCtWUFo5YXorSXVIYW10TDdmbXFK?=
 =?utf-8?B?MmxHSnFrME9uVk1MS3BWdm9BWHhoQVU2b3JwRVNwcy80d2NVMUd1dTlCZnVQ?=
 =?utf-8?B?Tytjd1k0N1lnWTh0NkZYMm85YkUvUzh0SXgrVzY5OGNoZlZXdXVLUm1NczFQ?=
 =?utf-8?B?K2FwY2dwNUJoYUhVVWE3eVNzbVNaVzJGOGNVcFVncHZBOExIWlZBZExNZ20z?=
 =?utf-8?B?ME5sMSs2L1BabGlrZmZyY0VKOVN5ZHZ1UWpXNDArS3dKRjJ4NmFPZkxBMnZP?=
 =?utf-8?B?TmJsYnRZWkEvU25SWWZzbEk1V1U2TTQ3V3RqSGt2cFpzbDlVZVJaUTlReGhZ?=
 =?utf-8?B?YjI2aWFQQytBRVhwZnVFMmw2U3c3ZXBsWVN5aVF5K0U4TGVUV0ZzL2hLNTBS?=
 =?utf-8?B?cTJKYlpVNFpUL0VzTXNTZmFCRlA2Tm9LYjlScUFzUk12cXJYS2R4K3pDOXps?=
 =?utf-8?B?VmVLWW12cm5KQ0FRVWFYZHVyYi9EUlNldjdGZ2NBMWN4ekJFNUNPSFBMeURk?=
 =?utf-8?B?anp1QTRndDFFakl3Z0Yyb0phNVBRRFJDRHVoWGUySU5kT3lqZndxeVZFQmdr?=
 =?utf-8?B?Skg5V1NJcDk0MWZBajMyL3lYaEF4dnRUM0g5RG4zekh5OHBLSEFSQmNrZDR3?=
 =?utf-8?B?NHlGWHZnZmg2OU52ZWw3MkVXbklsb0FuaU1kdWpNd0d3ZldwVGNDUXlCdmEz?=
 =?utf-8?B?aE5rUkYvZWg0bHB6dVJIdi9JR1hIOS82WWIyUUIzSStmc1AxM3JkamVoSC9F?=
 =?utf-8?B?MWlKLytsdjhOakVkTFY1WmlOSHZQOFhvcVhGbkF1MlUyN1pxcWNuNE1IWml3?=
 =?utf-8?B?TC8rTnRSNHphR1lSdlFCck4xMWpDZDB6ZlkrRDJ1Uy9YaGNJS2dKTEJuTC82?=
 =?utf-8?B?TTAzZ2l0b2F0S2FhRlZsc0FEdmVrN2I0Rk5WT05TME5wdUN2eWJVaWJEeko3?=
 =?utf-8?B?NXA0NWhJNlRKeHhKdU85cmROM0dBbE9qQmRCdGE1RTR0aXB4MHdDdTVlNndU?=
 =?utf-8?B?NEVkd0REbG9yVk9kcHhwTEtiYUFOaGhTUnBtTXFPbHJBMkVjL0Z3TlNiUFY3?=
 =?utf-8?B?dncvWks2YWZaZmVKZ2VqRm9Hd29YYk1KREJuZElNTStZOGRRK2cwVE9uOTAr?=
 =?utf-8?B?S1MrN0lOQkVwQm12dmQ2a1pnZFRBL05oU2V0SXRoU1ZkWG1QVnFLZVpPUEJU?=
 =?utf-8?B?Zk5pSGdGM0dzNmpUaUY1cy9aSjVQeHQyUlc3Y1R0VzBtejVkQXUybm5qYkM1?=
 =?utf-8?B?QzV6UTJlWm1YUTl5TDZYaUVFK0tLQTlhVzVuY0RCUmIwWmNTYVNQeHhhSkNP?=
 =?utf-8?B?MFVqOURRQjd3d05EcjBkbHJURUxhWFpzdDZ1N3pSTVE0SUdCY1c1dXE3OHor?=
 =?utf-8?B?V29uTkIvWVA1T05wT01NTXVMdGJFQ0orMTBOM1Blb1Jmd2hXM3JncUNOTzYy?=
 =?utf-8?B?T1V0MEZMUGpBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c0cca3-5d32-4aa0-8976-08da0b340040
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 12:11:59.9761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRXhOW/bOkXDAqCHae04hquUf1FmTtNfrYFoKnx28o/dsh+di6+yIL6Sns/beeJnxF71yh6xs7wTmSBgCUr+Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3728
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 3/21/2022 11:28 AM, Sagi Grimberg wrote:
>
>>>> WDYT ? should we reconsider the "nvme connect --with_metadata" 
>>>> option ?
>>>
>>> Maybe you can make these lazily allocated?
>>
>> You mean something like:
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index fd4720d37cc0..367ba0bb62ab 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1620,10 +1620,19 @@ int nvme_getgeo(struct block_device *bdev, 
>> struct hd_geometry *geo)
>>   }
>>
>>   #ifdef CONFIG_BLK_DEV_INTEGRITY
>> -static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 
>> pi_type,
>> -                               u32 max_integrity_segments)
>> +static int nvme_init_integrity(struct gendisk *disk, struct nvme_ns 
>> *ns)
>>   {
>>          struct blk_integrity integrity = { };
>> +       u16 ms = ns->ms;
>> +       u8 pi_type = ns->pi_type;
>> +       u32 max_integrity_segments = ns->ctrl->max_integrity_segments;
>> +       int ret;
>> +
>> +       if (ns->ctrl->ops->init_integrity) {
>> +               ret = ns->ctrl->ops->init_integrity(ns->ctrl);
>> +               if (ret)
>> +                       return ret;
>> +       }
>>
>>          switch (pi_type) {
>>          case NVME_NS_DPS_PI_TYPE3:
>> @@ -1644,11 +1653,13 @@ static void nvme_init_integrity(struct 
>> gendisk *disk, u16 ms, u8 pi_type,
>>          integrity.tuple_size = ms;
>>          blk_integrity_register(disk, &integrity);
>>          blk_queue_max_integrity_segments(disk->queue, 
>> max_integrity_segments);
>> +
>> +       return 0;
>>   }
>>   #else
>> -static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 
>> pi_type,
>> -                               u32 max_integrity_segments)
>> +static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns 
>> *ns)
>>   {
>> +       return 0;
>>   }
>>   #endif /* CONFIG_BLK_DEV_INTEGRITY */
>>
>> @@ -1853,8 +1864,8 @@ static void nvme_update_disk_info(struct 
>> gendisk *disk,
>>          if (ns->ms) {
>>                  if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
>>                      (ns->features & NVME_NS_METADATA_SUPPORTED))
>> -                       nvme_init_integrity(disk, ns->ms, ns->pi_type,
>> - ns->ctrl->max_integrity_segments);
>> +                       if (nvme_init_integrity(disk, ns))
>> +                               capacity = 0;
>>                  else if (!nvme_ns_has_pi(ns))
>>                          capacity = 0;
>>          }
>> @@ -4395,7 +4406,7 @@ EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
>>
>>
>> and create the resources for the first namespace we find as PI 
>> formatted ?
>>
>>
>
> I was thinking more along the lines of allocating it as soon as an I/O
> comes with pi... Is there something internal to the driver that can
> be done in parallel to expedite the allocation of these extra resources?

Since when are we allocating things in the fast path ?

We allocate a pool of MRs per queue. Not MR per task.

Do you think it's better to allocate the whole pool in the first PI IO 
and pay the latency for this IO ?

-Max.


