Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC2E4E1C31
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Mar 2022 16:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245345AbiCTPNC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Mar 2022 11:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245340AbiCTPNB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Mar 2022 11:13:01 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7AE19B070
        for <linux-rdma@vger.kernel.org>; Sun, 20 Mar 2022 08:11:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnHZPUA3OKSR1jAxTCfOozQmzkfAFsJB5KiClLsYZ5hvqp7QwBr0tptC6wFtl5+JFSfRuDSohagMTv+EXhFhcckVx8WqSvdgg2qJ4/SLxDbSPa86+JQBje8IgPu/LLEschlBE4f2WoqBQtzeyYRXS6Y6MaNfYk/KpYaAit8lVX6X82BWeQda9x1iDcUmcibsYTSEeWRA9iPA1xeKbcn+Y2fWbMwGcXIk4ObUIuacrSNuDsjt6R3eL5SpnZ7ir12FSvvLVTjcN+mHG8BY7q4a0SvSlO239nctOy0taltmFyDyPR+E4WDA1kfZYsrw7ICgemRdII1wJRoZmTkM4McVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VijblXXuKMZ+iHxRe/NpFLJZYMrAdwLlvCSBkefnoM=;
 b=A1SI7ydh52LxYy9MhyUZG9UJSqxpysmRlxF746LD5adHtT2O/+rJtThLzH9EYrZ+EZ7GZJGj6SooNln7L8f2ztIBnhwslTAZGBtKiB1glJ22oASvPu29tNwcZdMtfOpMPhZpOpbLsap5xoqKGpdH2gTEZzw95YrUUH58md8eUFKExlmbjaGSDxfpNMiA2yMT+q9C3kHMi921X3PYfc+xhz197w9wCzD45/z7ES56ecmWXRsO1zIJJbW2nNKtr9mMeaCSvdXh5h+xcNUervkeqxMcbg39kEPA4wO7w4igRZ01mFTmyucq16eNyzHoBuayc7jhonLGgSt3/Gb27oAD/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VijblXXuKMZ+iHxRe/NpFLJZYMrAdwLlvCSBkefnoM=;
 b=WCSVwrBS9bfvUqou10HUNDT8G1OLakgv6iwAIzLrU25WqYyZ0UnXqMH4d7Zqgi2JXvSsf0FA/ScN3eDQwL2LH1deHX25hzvKj/D/gVocj5RAW4dCa4pwh02/8WLXEb2AyB1Sp8IX4LAnQyMY8mx0AqZqBIeUAozERfEZowYnStxkWGZVFrGHXP1b/Iq6A+kuhhrncv6oJvet74zCpYB4Cb2A2WPMKrEBvuS9hUT/RqJy3SvgNRvtVGQ/2gaKzxpdeg6W2UpfiwufibxNUcFCk14iuOvcdV+ivYEX2ns75gB0tOxyAvkZFOB2mqCNiSs8zAmWDzKuJXgPHdqwBqfJpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19; Sun, 20 Mar
 2022 15:11:37 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%7]) with mapi id 15.20.5081.018; Sun, 20 Mar 2022
 15:11:37 +0000
Message-ID: <d8283461-8759-39ac-6ef7-a6f5cc739634@nvidia.com>
Date:   Sun, 20 Mar 2022 17:11:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
Content-Language: en-US
To:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <2D31D2FB-BC4B-476A-9717-C02E84542DFA@oracle.com>
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
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <7e0abcac-791a-bd71-38c3-4a5490b7f209@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR04CA0114.eurprd04.prod.outlook.com
 (2603:10a6:20b:31e::29) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9310533-a84f-455d-a851-08da0a83ed86
X-MS-TrafficTypeDiagnostic: DM4PR12MB5294:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5294C086C1DD7D3418403619DE159@DM4PR12MB5294.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+0QSJo/ts263nOv6x1OvCWWNAKpYYDwW2fL/fZhFN/hZPlIPcPzDACI3GudASubhvJvZAr31VpfzmVTmwFjNGD8FSQqsHUHB84U8OQK5mrrkF3Nfb/uUJkHpUghGUBrIYrbWVKW3ROOf8/nX8DWVifrCvRqDde+6RVO2X/PH3KrO7Q+QmGDEcaTLyHnpffTdv4LEqERrE3Bkw36yisfPu6OGPaolj3cS2K0gSued0kOqn05txkkUPtvWCIPaUDHZ5EaHQjJ4H6hIvM951+k9Wa47xFYEL2H6ITjF8dYpjNsEMnzIxv4t+CMXqGQs6hOgOxeUqrnR0j3fPIar4h5fesMokKb3HOuyS7jz4C0TPTgq4hIjB0qCFCjXfci5HiakZ9fkrEwujnFAgAaK6pY9fEj6cJkCZH5DVdcxLl2CM+PwF/GyxPSLr5iNJP3PApI0mNTrGcViJhxKFYMvC84+mvPpbnaFkXSrF/NYM76IAOxF5CJH32UGwN/kkEwuBvt5JYOmmDuBqvOdlr+gL0E0PcixaClU1c0wDAeZiWaxZ4yAH0Bq4+X5fN3z7aWHu73E7A63vY2uDRTsDrseOq4Kk8iua33aB4kTCqytYT5/jHlGAdYVmknGk+D2MUV01EWxoHmypU7QNUejH8U5K7s6iJDz9pcWuYxNFZnZ53LjyiMya8IuvzPX3Sus5Qyk8V/QbakKxtSWg8o+otVTgIf+SP7zARrGNFmttpoKDJMdsb/KQV3NRSrD9lmus6Fzij4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(6506007)(53546011)(2906002)(6512007)(83380400001)(2616005)(186003)(26005)(66476007)(66946007)(8936002)(66556008)(508600001)(8676002)(31686004)(6486002)(36756003)(4326008)(86362001)(31696002)(6666004)(5660300002)(316002)(54906003)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUxKYVlWV1NXbnZRbDBBelNSdVBNZ25ubVZSUTRyNWtmQjZ3Z2VpcFViSC9T?=
 =?utf-8?B?OWZzckgyekxuQTFoTjFTUjRIbjhnS3JKempPVmlFZmExN0luVlRGUlg3bTJQ?=
 =?utf-8?B?dXI4bFREbUcyc092T1lHbnRBb3VHMkI0K29TdGZ0Wk1qaS95VDFNT2lsaVBL?=
 =?utf-8?B?QXpkbUM4dVgzam53amhFU0Job0cxcFhkQUhjaWw3QmVyV2hqR2Z5TE9CZDFE?=
 =?utf-8?B?eWtnTWlYOXNldUNkaW5uQ3NOWDRINkUrRDB4WjVickhGbGZWcXp2cTh3eUlG?=
 =?utf-8?B?TWowbitJTzBGeTJWNWlUd0F0T0xOT3kwcVZJTWhSUGdhQlphbHZyRGZSYk1X?=
 =?utf-8?B?bStqS1VSc2JaQ1pvNjNEbEJ4NTF0czJDRTRYUE0xbThxMDgxSFBNaXhKTCsv?=
 =?utf-8?B?VTB3NHZJeXFrRU4rY2M2OUlPbVZJVlY5Y3JrSzNKNFZ4SFJhYzdrMXNuejR2?=
 =?utf-8?B?aVZ6ZzJFajYzSEtGTG9FSVZDeGZ1QzArSUszZlBZWUduZmJaQTJ5NnU2MVVV?=
 =?utf-8?B?a1pPVHV1b3dXL05xU2w4SGR1aThDZ3psYldiSC9OSmQwb1YrMnVra0lqOFVh?=
 =?utf-8?B?anl2OFRzQ2VyQjN0NkV3Vk1HRVlBSHFKa0g4Ymk1dkMyK3QxVElXaGlDUk9i?=
 =?utf-8?B?dlZLbGt5OGxQQXpqdjVMQ1VZUGtMOWpzSlJkV0cyN3R4MTViZlYxNG9MbFRs?=
 =?utf-8?B?TG8ySENLOHpRQThaVzlUTUo3QU1KVUdWM2ZPejBHRFg4QWJzQmJiVTN1ZTk0?=
 =?utf-8?B?MlpHWFRZc1hKTTRFNUsvWlBHRWppL1JkaUliQ0NqTU5iTDBYdmwvK0lnSnZv?=
 =?utf-8?B?S2tLTW81eEJBdEJvYkNJaDhaMFByTW4rTkcxVHVrczBlYmM5OXZGUkJkVTRi?=
 =?utf-8?B?TjBiVXlmUEdSSk9PREE5cVU2S3hZUTNaZlpnTFJ4QS9Hc1VqQU9pd0lIeGFK?=
 =?utf-8?B?UGd1RFYwbGNUeUtaRnVBU0NqankwZXd0NGV1bzRTdkJKc2Nhck42emR1cm85?=
 =?utf-8?B?ejU5UnFoVkZsRHFpSGF5a0dwbGpMSnA4Nk5hUHlGZVNPaC9RbVFKNWxIUXZF?=
 =?utf-8?B?OWxjTlF1RHZ1YVZiYnFCZklJTkVZQmNOTzdsbDRsdUtHVi8zTEhoVVUxakNn?=
 =?utf-8?B?SkJvYmpsMUdacURwVWlub1BicWRxaGdHczNRTjR5UkhMemp1QVRrdHh4Vi9q?=
 =?utf-8?B?cGVoVlhBMG9RUm8yaWVpRW9Oc0lOUFMrU2MrMFE2QlIvZVk1eHViSWhJenNL?=
 =?utf-8?B?MW5NQXo0YWxZYTQzRW5iV0lNempUWmJBY3hnZGtxRVI1c3NGU3ZjQ3hMemY5?=
 =?utf-8?B?amZSWm1POXViU3FrdWVpeXdNZHdRWDM1YVZFTjdzem1IK1NNbElEM2swdUxY?=
 =?utf-8?B?YUV6SkVBdEk5YnMzTmZrOTd4TUF2YkEyUmNIam82QjFGanA3OXloTTVWWWZ1?=
 =?utf-8?B?TmdVOUZBcTdreC8wa2ZZK3VVWTgrZm5DbXp4UTlKMngyd1l0ZUdSemo1ai9U?=
 =?utf-8?B?dEY1UmZsU0RGRWZNaDJnSXpDcUpjaWh6N01SL1V5VnR5elVNR1E3dE1hZk96?=
 =?utf-8?B?cEs4bG0wTnFySTNsd1pUalJEeVlRQTd5MVRVMnZjaWUvLzBTSCtpQUhjQ1Jx?=
 =?utf-8?B?NVFZRFByY1JHWVlIRnk1ZW1PREpIays2d2pGZE9QVXI3QjBldlg3cGNmdG5V?=
 =?utf-8?B?TEpsOHhrKzZ2Ulhtb1JLSlE3akhjak1VYlVxYnFIbTc2RE9pVlpiMW8rdy82?=
 =?utf-8?B?c0p3dFUyTE9TQnRXVlBZY21HS3hVeGVVaCtwZytlekM0K2xtcllaVkpzVnVZ?=
 =?utf-8?B?RTlvaXc2WXV2c3FGYVZzZ250SmpTZi91a0NibVZuREI0d2xkeWtNMUxBRXRR?=
 =?utf-8?B?bGFwNHNUYWtJMUErQmI3aTZCbjlyS0luT1J5dzdEdEdEc2hBeFljdW9mZUor?=
 =?utf-8?B?TWtEc3pNLzRjMTNqNGRRdnpRRnM1NkRuVVVTeTlKWllxWHA3dXV3MkFWcS9x?=
 =?utf-8?B?a0hwekFqcE5BPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9310533-a84f-455d-a851-08da0a83ed86
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2022 15:11:37.1020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A45OVHPEey75agGv8EWl2P/3pgek/HBkgUK/ppjB1kQkXk+BW7coTd0DaeZYNY9v2VGE0kcXyiqPepo9+iwnkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5294
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 3/20/2022 3:03 PM, Sagi Grimberg wrote:
>
>>>> These are very long times for a non-debug kernel...
>>>> Max, do you see the root cause for this?
>>>>
>>>> Yi, does this happen with rxe/siw as well?
>>> Hi Sagi
>>>
>>> rxe/siw will take less than 1s
>>> with rdma_rxe
>>> # time nvme reset /dev/nvme0
>>> real 0m0.094s
>>> user 0m0.000s
>>> sys 0m0.006s
>>>
>>> with siw
>>> # time nvme reset /dev/nvme0
>>> real 0m0.097s
>>> user 0m0.000s
>>> sys 0m0.006s
>>>
>>> This is only reproducible with mlx IB card, as I mentioned before, the
>>> reset operation time changed from 3s to 12s after the below commit,
>>> could you check this commit?
>>>
>>> commit 5ec5d3bddc6b912b7de9e3eb6c1f2397faeca2bc
>>> Author: Max Gurtovoy <maxg@mellanox.com>
>>> Date:   Tue May 19 17:05:56 2020 +0300
>>>
>>>      nvme-rdma: add metadata/T10-PI support
>>>
>> I couldn't repro these long reset times.
>
> It appears to be when setting up a controller with lots of queues
> maybe?

I'm doing that.

>
>> Nevertheless, the above commit added T10-PI offloads.
>>
>> In this commit, for supported devices we create extra resources in HW 
>> (more memory keys per task).
>>
>> I suggested doing this configuration as part of the "nvme connect" 
>> command and save this resource allocation by default but during the 
>> review I was asked to make it the default behavior.
>
> Don't know if I gave you this feedback or not, but it probably didn't
> occur to the commenter that it will make the connection establishment
> take tens of seconds.

It was known that we create more resources than needed for 
"non-PI-desired" controllers.


>
>> Sagi/Christoph,
>>
>> WDYT ? should we reconsider the "nvme connect --with_metadata" option ?
>
> Maybe you can make these lazily allocated?

You mean something like:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fd4720d37cc0..367ba0bb62ab 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1620,10 +1620,19 @@ int nvme_getgeo(struct block_device *bdev, 
struct hd_geometry *geo)
  }

  #ifdef CONFIG_BLK_DEV_INTEGRITY
-static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type,
-                               u32 max_integrity_segments)
+static int nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns)
  {
         struct blk_integrity integrity = { };
+       u16 ms = ns->ms;
+       u8 pi_type = ns->pi_type;
+       u32 max_integrity_segments = ns->ctrl->max_integrity_segments;
+       int ret;
+
+       if (ns->ctrl->ops->init_integrity) {
+               ret = ns->ctrl->ops->init_integrity(ns->ctrl);
+               if (ret)
+                       return ret;
+       }

         switch (pi_type) {
         case NVME_NS_DPS_PI_TYPE3:
@@ -1644,11 +1653,13 @@ static void nvme_init_integrity(struct gendisk 
*disk, u16 ms, u8 pi_type,
         integrity.tuple_size = ms;
         blk_integrity_register(disk, &integrity);
         blk_queue_max_integrity_segments(disk->queue, 
max_integrity_segments);
+
+       return 0;
  }
  #else
-static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type,
-                               u32 max_integrity_segments)
+static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns)
  {
+       return 0;
  }
  #endif /* CONFIG_BLK_DEV_INTEGRITY */

@@ -1853,8 +1864,8 @@ static void nvme_update_disk_info(struct gendisk 
*disk,
         if (ns->ms) {
                 if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
                     (ns->features & NVME_NS_METADATA_SUPPORTED))
-                       nvme_init_integrity(disk, ns->ms, ns->pi_type,
- ns->ctrl->max_integrity_segments);
+                       if (nvme_init_integrity(disk, ns))
+                               capacity = 0;
                 else if (!nvme_ns_has_pi(ns))
                         capacity = 0;
         }
@@ -4395,7 +4406,7 @@ EXPORT_SYMBOL_GPL(nvme_stop_ctrl);


and create the resources for the first namespace we find as PI formatted ?


